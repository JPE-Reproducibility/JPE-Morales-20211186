cap log close
log using "${log}/16_estimate_nu.log", replace

* Nu estimation: CV^2 of exponentiated wage residuals for Frechet calibration (Table C6)
* Agostina Brinatti & Nicolas Morales
* Source data: LIAB Longitudinal Model (version 1993-2014), IAB
*              IAB Establishment Panel (IABBP), waves 2004-2012

/*	This dofile constructs the firm-level dataset needed for the revenue
	regression sample (Part 1) and then computes the squared coefficient of
	variation of exponentiated native wage residuals under three fixed-effect. 
	
	To get the estimated values of nu, please run the matlab code estimate_nu_cont that can be found in the replication package. 
	This matlab file calls the function solve_nu also in the replication folder

****************************
* Table 1
* Table C6: Squared CV of exponentiated native wage residuals
****************************

* Variables: nwage_hat_nc / nwage_hat_c / nwage_hat_cov
*   (exponentiated residuals from log-wage regression of native workers
*   under three increasingly saturated fixed-effect specifications)
* Specification nc:  industry x year FEs only
* Specification c:   industry x year + district FEs + age + gender controls
* Specification cov: fully saturated (nationality x industry x age x gender
*                    x district x year FEs)
* Selection: Native workers (nation_single == 1), full-time (erwstat_gr == 1),
*   aged 25-65, in the revenue regression sample (sample_rev == 1)
* CV^2 = (sd / mean)^2 of the exponentiated residual for each specification
* Used to calibrate the Frechet labour supply parameter nu via equation (49):
*   CV^2 = Gamma(1 - 2/nu) / [Gamma(1 - 1/nu)]^2 - 1
* N (unweighted) reported via di after each specification.

	specifications (Part 2). The CV^2 values are used to calibrate the
	Frechet labour supply parameter nu via equation (49).

	Output in this dofile:
	  Table 1 - Table C6: CV^2 of exponentiated wage residuals by FE spec

	Saved intermediate dataset:
	  ${data}/data_sample_nu.dta — sample flag for the nu regression

	FDZ note: N (unweighted) is reported via di after each specification.
	  The CV^2 is computed as (sd/mean)^2 from the sum output.
*/

clear
set more off
set matsize 10000
set linesize 255
set seed 1234

cap adopath++ ${prog}

*FDZ: duplicate log removed — log opened at top of file
*capture log close
*log using "${log}/2j_estimate_nu_simplified.log", replace


*===============================================================================
* PART 1: BUILD FIRM-LEVEL DATASET TO DEFINE THE REVENUE-REGRESSION SAMPLE
*===============================================================================

use "${data}/dataset_individual_validation.dta", clear

keep if erwstat_gr == 1
rename tentgelt_orig tentgelt
gen german = (nation_single == 1)
gen l_wage  = log(tentgelt)

* Merge industry / location identifiers
merge m:1 betnr jahr using "${orig}/liab_lm_9314_v1_bhp_basis_v1.dta", ///
    keepusing(w93_3_gen az_ges ao_kreis grd_jahr lzt_jahr te_imp_mw)
drop if _merge != 3
drop _merge

* Reduced local labour markets
gen ao_kreis11 = ao_kreis
merge m:1 ao_kreis11 using "${data}/aokreis11.dta"
drop if _merge == 2
drop _merge
drop if ao_kreis11 == .

cap drop ao_bula
gen ao_bula = floor(ao_kreis / 1000)

*---------------------------------------
* Industry categories
*---------------------------------------
gen ind_2dig = floor(w93_3_gen / 10)

replace ind_2dig = 1  if ind_2dig >= 1  & ind_2dig <= 5
replace ind_2dig = 10 if ind_2dig >= 10 & ind_2dig <= 14
replace ind_2dig = 15 if ind_2dig >= 15 & ind_2dig <= 16
replace ind_2dig = 17 if ind_2dig >= 17 & ind_2dig <= 19
replace ind_2dig = 23 if ind_2dig >= 23 & ind_2dig <= 24
replace ind_2dig = 29 if ind_2dig >= 29 & ind_2dig <= 30
replace ind_2dig = 37 if ind_2dig >= 37 & ind_2dig <= 41
replace ind_2dig = 65 if ind_2dig >= 65 & ind_2dig <= 67

gen tradeable3 = ((w93_3_gen >= 154 & w93_3_gen <= 366) | ///
                  (w93_3_gen >= 721 & w93_3_gen <= 744) | ///
                  (w93_3_gen >= 501 & w93_3_gen <= 517))

* Two 2-digit industries span both T and NT — collapse to consistent group
egen ind_2dig_aux = group(ind_2dig tradeable3)
drop ind_2dig
rename ind_2dig_aux ind_2dig

*---------------------------------------
* Fixed effects
*---------------------------------------
egen ind_labormkt = group(ind_2dig local_labor11)
egen ind_med_time = group(ind_2dig jahr)

*---------------------------------------
* Firm-level employment and wage bill by nativity (needed for regressors)
*---------------------------------------
bysort betnr jahr: egen nemp_ft     = sum(1)
bysort betnr jahr: egen nemp_nat_ft = sum((nation_single == 1) * 1)
bysort betnr jahr: egen nemp_imm_ft = sum((nation_single != 1) * 1)
bysort betnr jahr: egen wemp_nat_ft = sum((nation_single == 1) * tentgelt)
bysort betnr jahr: egen wemp_imm_ft = sum((nation_single != 1) * tentgelt)

*---------------------------------------
* Market-level share of immigrants (endogenous regressor)
*---------------------------------------
bysort local_labor11 jahr: egen wemp_rt     = sum(tentgelt)
bysort local_labor11 jahr: egen wemp_nat_rt = sum((nation_single == 1) * tentgelt)

gen share_mig_local2_t = (wemp_rt - wemp_nat_rt) / wemp_rt

*---------------------------------------
* Firm-level regressors
*---------------------------------------
gen emp_03_1 = log(nemp_ft) if jahr == 2003
bysort betnr: egen logemp_tot_firm03 = mean(emp_03_1)
drop emp_03_1

by betnr (jahr), sort: gen logemp_tot_totlag = log(nemp_ft[_n-1])

gen interaction = share_mig_local2_t * logemp_tot_totlag

*---------------------------------------
* Instrument: shift-share (market level, counts)
*---------------------------------------

* Initial shares in 2003 at the market level
bysort nation_single ind_labormkt jahr: egen nemp_orkt  = sum(1)
bysort ind_labormkt  jahr:              egen nemp_imm_rkt = sum((nation_single != 1) * 1)

gen share_03_1 = nemp_orkt / nemp_imm_rkt if jahr == 2003
bysort nation_single ind_labormkt: egen share_03_ork = mean(share_03_1)
replace share_03_ork = . if nation_single == 1

* Shifter components
bysort ao_bula jahr nation_single: egen nemp_ost = sum(1)
bysort ao_bula jahr:               egen nemp_gst = sum((nation_single == 1) * 1)
bysort jahr nation_single:         egen nemp_ot  = sum(1)
bysort jahr:                       egen nemp_gt  = sum((nation_single == 1) * 1)

* Aggregate shift-share to market level
gen shift_share_o = share_03_ork * (nemp_ot - nemp_ost) / (nemp_gt - nemp_gst)
replace shift_share_o = . if nation_single == 1

bysort nation_single jahr ind_labormkt: gen  n_ss  = _n
gen  t_ss = shift_share_o if n_ss == 1
bysort jahr ind_labormkt: egen iv_shift_share_o = total(t_ss)
replace iv_shift_share_o = 0 if iv_shift_share_o == .
drop t_ss n_ss

* Merge external instrument (dataset_instrument_validation)
* — done after collapse; kept for the ivreghdfe below

*---------------------------------------
* Keep LIAB sample and collapse to firm level
*---------------------------------------
keep if betr_st == 1 | betr_st == 2
keep if jahr >= 2003 & jahr <= 2011

* Workforce composition (needed for financials / controls)
gen young = (age <= 40)
bysort betnr jahr: egen tot_emp_coll  = sum(college)
bysort betnr jahr: egen tot_emp_ncoll = sum(1 - college)

gen l_emp_tot = log(nemp_ft)

duplicates drop betnr jahr, force

*---------------------------------------
* Firm-level financials from IAB establishment panel surveys
*---------------------------------------

gen turnover_type = .
gen turnover      = .
gen exports_foreign = .
gen int_inputs    = .
gen grosspay      = .
gen collective_agreement  = .
gen industry_agreement    = .
gen ownership_structure   = .
gen single_establishment  = .
gen parent_ownership      = .
gen foreign_parent        = .
gen relocated  = .
gen integrated = .
gen investment = .

* 2012 survey → 2011 data
quietly merge m:1 idnum using "${orig}/iabbp_2012.dta", keepusing(t80 t79b t48 t49 t52 t21 t11 t09a t09b t09c t08 t07 t02a t02b t02c t02d t03)
drop if _merge == 2
replace turnover_type   = t07   if jahr == 2011
replace turnover        = t08   if jahr == 2011
replace grosspay        = t52   if jahr == 2011
replace exports_foreign = t09c  if t09c != -9 & jahr == 2011
replace int_inputs      = t11   if t11  != -9 & jahr == 2011
replace investment      = t21   if t21  != -9 & jahr == 2011
replace investment      = 0     if t21  == .  & jahr == 2011 & _merge == 3
replace collective_agreement = t48  if t48 != -9 & jahr == 2011
replace ownership_structure  = t80  if t80 != -9 & jahr == 2011
replace single_establishment = 1    if t80 == 1  & jahr == 2011
replace single_establishment = 0    if t80 != 1  & t80 != -9 & _merge == 3 & jahr == 2011
drop t80 t79b t48 t49 t52 t21 t11 t09a t09b t09c t08 t07 t02a t02b t02c t02d t03 _merge

* 2011 survey → 2010 data
quietly merge m:1 idnum using "${orig}/iabbp_2011.dta", keepusing(s80b s84 s53 s52 s17 s11 s09c s08 s07 s58)
drop if _merge == 2
replace turnover_type   = s07  if jahr == 2010
replace turnover        = s08  if jahr == 2010
replace grosspay        = s58  if jahr == 2010
replace exports_foreign = s09c if s09c != -9 & jahr == 2010
replace int_inputs      = s11  if s11  != -9 & jahr == 2010
replace investment      = s17  if s17  != -9 & jahr == 2010
replace investment      = 0    if s17  == .  & jahr == 2010 & _merge == 3
replace collective_agreement = s52  if s52  != -9 & jahr == 2010
replace ownership_structure  = s84  if s84  != -9 & jahr == 2010
replace single_establishment = 1    if s84  == 1  & jahr == 2010
replace single_establishment = 0    if s84  != 1  & s84 != -9 & _merge == 3 & jahr == 2010
drop s80b s84 s53 s52 s17 s11 s09c s08 s07 s58 _merge

* 2010 survey → 2009 data
quietly merge m:1 idnum using "${orig}/iabbp_2010.dta", keepusing(r87 r83 r51 r50 r20 r13 r11c r09 r10 r54)
drop if _merge == 2
replace turnover_type   = r09  if jahr == 2009
replace turnover        = r10  if jahr == 2009
replace grosspay        = r54  if jahr == 2009
replace exports_foreign = r11c if r11c != -9 & jahr == 2009
replace int_inputs      = r13  if r13  != -9 & jahr == 2009
replace investment      = r20  if r20  != -9 & jahr == 2009
replace investment      = 0    if r20  == .  & jahr == 2009 & _merge == 3
replace collective_agreement = r50  if r50  != -9 & jahr == 2009
replace ownership_structure  = r83  if r83  != -9 & jahr == 2009
replace single_establishment = 1    if r83  == 1  & jahr == 2009
replace single_establishment = 0    if r83  != 1  & r83 != -9 & _merge == 3 & jahr == 2009
drop r87 r83 r51 r50 r20 r13 r11c r09 r10 r54 _merge

* 2009 survey → 2008 data
quietly merge m:1 idnum using "${orig}/iabbp_2009.dta", keepusing(q06 q07 q43 q03 q08c q10 q17 q39 q40 q88 q91)
drop if _merge == 2
replace turnover_type   = q06  if jahr == 2008
replace turnover        = q07  if jahr == 2008
replace grosspay        = q43  if jahr == 2008
replace exports_foreign = q08c if q08c != -9 & jahr == 2008
replace int_inputs      = q10  if q10  != -9 & jahr == 2008
replace investment      = q17  if q17  != -9 & jahr == 2008
replace investment      = 0    if q17  == .  & jahr == 2008 & _merge == 3
replace collective_agreement = q39  if q39  != -9 & jahr == 2008
replace ownership_structure  = q88  if q88  != -9 & jahr == 2008
replace single_establishment = 1    if q88  == 1  & jahr == 2008
replace single_establishment = 0    if q88  != 1  & q88 != -9 & _merge == 3 & jahr == 2008
drop q06 q07 q43 q03 q08c q10 q17 q39 q40 q88 q91 _merge

* 2008 survey → 2007 data
quietly merge m:1 idnum using "${orig}/iabbp_2008.dta", keepusing(p09 p10 p63 p03 p11c p13 p19 p59 p60 p91 p94)
drop if _merge == 2
replace turnover_type   = p09  if jahr == 2007
replace turnover        = p10  if jahr == 2007
replace grosspay        = p63  if jahr == 2007
replace exports_foreign = p11c if p11c != -9 & jahr == 2007
replace int_inputs      = p13  if p13  != -9 & jahr == 2007
replace investment      = p19  if p19  != -9 & jahr == 2007
replace investment      = 0    if p19  == .  & jahr == 2007 & _merge == 3
replace collective_agreement = p59  if p59  != -9 & jahr == 2007
replace ownership_structure  = p91  if p91  != -9 & jahr == 2007
replace single_establishment = 1    if p91  == 1  & jahr == 2007
replace single_establishment = 0    if p91  != 1  & p91 != -9 & _merge == 3 & jahr == 2007
drop p09 p10 p63 p03 p11c p13 p19 p59 p60 p91 p94 _merge

* 2007 survey → 2006 data
quietly merge m:1 idnum using "${orig}/iabbp_2007.dta", keepusing(o08 o09 o85 o04 o10c o12 o18 o81 o82 o90 o92)
drop if _merge == 2
replace turnover_type   = o08  if jahr == 2006
replace turnover        = o09  if jahr == 2006
replace grosspay        = o85  if jahr == 2006
replace exports_foreign = o10c if o10c != -9 & jahr == 2006
replace int_inputs      = o12  if o12  != -9 & jahr == 2006
replace investment      = o18  if o18  != -9 & jahr == 2006
replace investment      = 0    if o18  == .  & jahr == 2006 & _merge == 3
replace collective_agreement = o81  if o81  != -9 & jahr == 2006
replace ownership_structure  = o90  if o90  != -9 & jahr == 2006
replace single_establishment = 1    if o90  == 1  & jahr == 2006
replace single_establishment = 0    if o90  != 1  & o90 != -9 & _merge == 3 & jahr == 2006
drop o08 o09 o85 o04 o10c o12 o18 o81 o82 o90 o92 _merge

* 2006 survey → 2005 data
quietly merge m:1 idnum using "${orig}/iabbp_2006.dta", keepusing(n07 n08 n83 n03 n09c n10 n15 n79 n80 n86 n92)
drop if _merge == 2
replace turnover_type   = n07  if jahr == 2005
replace turnover        = n08  if jahr == 2005
replace grosspay        = n83  if jahr == 2005
replace exports_foreign = n09c if n09c != -9 & jahr == 2005
replace int_inputs      = n10  if n10  != -9 & jahr == 2005
replace investment      = n15  if n15  != -9 & jahr == 2005
replace investment      = 0    if n15  == .  & jahr == 2005 & _merge == 3
replace collective_agreement = n79  if n79  != -9 & jahr == 2005
replace ownership_structure  = n86  if n86  != -9 & jahr == 2005
replace single_establishment = 1    if n86  == 1  & jahr == 2005
replace single_establishment = 0    if n86  != 1  & n86 != -9 & _merge == 3 & jahr == 2005
drop n07 n08 n83 n03 n09c n10 n15 n79 n80 n86 n92 _merge

* 2005 survey → 2004 data
quietly merge m:1 idnum using "${orig}/iabbp_2005.dta", keepusing(m02aa m02ab m02ac m03 m12c m13 m19 m52 m53 m91 m88 m07 m08 m59)
drop if _merge == 2
replace turnover_type   = m07  if jahr == 2004
replace turnover        = m08  if jahr == 2004
replace grosspay        = m59  if jahr == 2004
replace exports_foreign = m12c if m12c != -9 & jahr == 2004
replace int_inputs      = m13  if m13  != -9 & jahr == 2004
replace investment      = m19  if m19  != -9 & jahr == 2004
replace investment      = 0    if m19  == .  & jahr == 2004 & _merge == 3
replace collective_agreement = m52  if m52  != -9 & jahr == 2004
replace ownership_structure  = m88  if m88  != -9 & jahr == 2004
replace single_establishment = 1    if m88  == 1  & jahr == 2004
replace single_establishment = 0    if m88  != 1  & m88 != -9 & _merge == 3 & jahr == 2004
drop m02aa m02ab m02ac m03 m12c m13 m19 m52 m53 m91 m88 m07 m08 m59 _merge

* 2004 survey → 2003 data
quietly merge m:1 idnum using "${orig}/iabbp_2004.dta", keepusing(l08 l09 l68 l03 l13c l14 l16 l91 l89 l64 l65)
drop if _merge == 2
replace turnover_type   = l08  if jahr == 2003
replace turnover        = l09  if jahr == 2003
replace grosspay        = l68  if jahr == 2003
replace exports_foreign = l13c if l13c != -9 & jahr == 2003
replace int_inputs      = l14  if l14  != -9 & jahr == 2003
replace investment      = l16  if l16  != -9 & jahr == 2003
replace investment      = 0    if l16  == .  & jahr == 2003 & _merge == 3
replace collective_agreement = l64  if l64  != -9 & jahr == 2003
replace ownership_structure  = l89  if l89  != -9 & jahr == 2003
replace single_establishment = 1    if l89  == 1  & jahr == 2003
replace single_establishment = 0    if l89  != 1  & l89 != -9 & _merge == 3 & jahr == 2003
drop l08 l09 l68 l03 l13c l14 l16 l91 l89 l64 l65 _merge

replace turnover = . if turnover == -9 | turnover == -8
replace grosspay = . if grosspay == -9 | grosspay == -8

* Survey weights
gen weight_survey = .
foreach x of numlist 2004 2005 2006 2007 2008 2009 2010 2011 2012 {
    quietly merge m:1 idnum using "${orig}/iabbp_`x'.dta", keepusing(hr`x'q)
    drop if _merge == 2
    replace weight_survey = hr`x'q if jahr == `x' - 1
    drop _merge hr`x'q
}
replace weight_survey = round(weight_survey)

*---------------------------------------
* Revenue and sample-selection variables
*---------------------------------------
gen logrevenues   = log(turnover)
gen count_missrev = .
bysort betnr: replace count_missrev = sum(turnover != .)   // approx; use count() if preferred
bysort betnr: egen count_missrev2   = count(turnover)
drop count_missrev
rename count_missrev2 count_missrev

bysort betnr: egen min_emp = min(az_ges)

* External instrument
merge 1:1 betnr jahr using "${data}/dataset_instrument_validation.dta", ///
    keepusing(instrument3n_local)
drop _merge

drop if missing(tradeable3) | missing(ind_2dig) | missing(local_labor11)
drop if nemp_nat_ft == 0 | wemp_nat_ft == 0

*---------------------------------------
* Revenue regression to define sample
*---------------------------------------
gen sample_rev = 0

ivreghdfe logrevenues ///
    (share_mig_local2_t interaction = instrument3n_local c.instrument3n_local#c.logemp_tot_firm03) ///
    logemp_tot_totlag ///
    if jahr >= 2008 & jahr <= 2011 & min_emp >= 10 & count_missrev >= 2 & turnover_type == 1, ///
    cl(betnr) absorb(ind_med_time betnr i.local_labor11#c.jahr)

replace sample_rev = 1 if e(sample) == 1

keep betnr jahr sample_rev
save "${data}/data_sample_may192026.dta", replace


*===============================================================================
* PART 2: ESTIMATE NU — SQUARED CV OF EXPONENTIATED WAGE RESIDUALS (TABLE C6)
*===============================================================================

use "${data}/dataset_individual_validation.dta", clear

merge m:1 betnr jahr using "${data}/data_sample_may192026.dta"
drop _merge

keep if sample_rev == 1
keep if erwstat_gr  == 1
keep if age >= 25 & age <= 65

gen log_wage = log(tentgelt_orig)

* Industry / location identifiers
merge m:1 betnr jahr using "${orig}/liab_lm_9314_v1_bhp_basis_v1.dta", ///
    keepusing(w93_3_gen ao_kreis)
drop if _merge != 3
drop _merge

* Fixed-effect groups for the three regressions
egen nat_d_ind_d     = group(nation_single w93_3_gen jahr)
egen nat_d_ind_d_cov = group(nation_single w93_3_gen age frau ao_kreis jahr)

*---------------------------------------
* Three wage residual regressions (natives only)
*---------------------------------------
reghdfe log_wage if nation_single == 1, absorb(nat_d_ind_d) resid
predict nwage_resid_d_nc, r

reghdfe log_wage age frau if nation_single == 1, absorb(nat_d_ind_d ao_kreis) resid
predict nwage_resid_d_c, r

reghdfe log_wage if nation_single == 1, absorb(nat_d_ind_d_cov) resid
predict nwage_resid_d_c_cov, r

gen nwage_hat_d_nc    = exp(nwage_resid_d_nc)
gen nwage_hat_d_c     = exp(nwage_resid_d_c)
gen nwage_hat_d_c_cov = exp(nwage_resid_d_c_cov)

*---------------------------------------
* Squared coefficient of variation (Table C6)
* — fed into Matlab code estimate_nu_2j_cont
*Number of observations for numbers below come from the three regressions above
*Variables log daily wage
*---------------------------------------
foreach x in nwage_hat_d_nc nwage_hat_d_c nwage_hat_d_c_cov {
    quietly sum `x'
    local coeff = (r(sd))^2 / (r(mean))^2
    dis "`x':  CV² = " `coeff'
}

*Copy disclosed coefficients by hand in Matlab code estimate_nu_cont.m


log close
