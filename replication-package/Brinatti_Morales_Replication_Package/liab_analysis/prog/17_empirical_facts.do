cap log close
log using "${log}/17_empirical_facts.log", replace

* Empirical facts: immigrant share across the establishment size distribution
* Agostina Brinatti & Nicolas Morales
* Source data: LIAB Longitudinal Model (version 1993-2014), IAB

/*	This dofile produces the underlying series for Tables A1, A2 and for
	Figures 1, A1a-d, A2a-b, A3, A4a-b, A6a-b. All figures are reported as
	tables with point estimates (survey-weighted medians/means) and 95%
	bootstrap confidence intervals (200 repetitions). No graphs are produced.

	Output tables in this dofile:
	  Table 1  - Table A1: Descriptive statistics by sector and year
	  Table 2  - Table A2: Intensive vs. extensive margin
	  Table 3  - Figure 1: Median immigrant wage-bill share by size bin
	  Table 4  - Figure A1(a): Controlling for industry and geography
	  Table 5  - Figure A1(b): Tradable vs. non-tradable
	  Table 6  - Figure A1(c): Exporter vs. non-exporter
	  Table 7  - Figure A1(d): Exporter vs. non-exporter, residualised
	  Table 8  - Figure A2(a): College vs. non-college sub-groups
	  Table 9  - Figure A2(b): Single-establishment and German-owned firms
	  Table 10 - Figure A3: Share of establishments hiring immigrants
	  Table 11 - Figure A4(a): By tenure
	  Table 12 - Figure A4(b): By age
	  Table 13 - Figure A6(a): Number of origin regions by size bin
	  Table 14 - Figure A6(b): Number of origin regions by immigrant-share group

	FDZ note: unweighted counts (N) are reported immediately before each
	  weighted statistic throughout this dofile (Guidelines §4.5).
*/

/*==============================================================================
  EMPIRICAL FACTS — Tables version
  Brinatti & Morales (2026)

  Produces the underlying data tables for Figures 1, A1, A2, A3, A4, A6
  with point estimates and 95% bootstrap confidence intervals.
  No graphs are produced.
==============================================================================*/

clear
set more off
set matsize 10000
set linesize 255
set seed 1234

capture adopath++ ${prog}



/*------------------------------------------------------------------------------
  0. LOAD DATA AND CONSTRUCT VARIABLES
------------------------------------------------------------------------------*/

use "${data}/establishment_level_liab.dta", clear
label val w93_3_gen w93_3_gen_en

* Size bins
gen size_bin = .
replace size_bin = 1  if emp_tot_tot >=   1 & emp_tot_tot <=  10
replace size_bin = 2  if emp_tot_tot >=  11 & emp_tot_tot <=  20
replace size_bin = 3  if emp_tot_tot >=  21 & emp_tot_tot <=  30
replace size_bin = 4  if emp_tot_tot >=  31 & emp_tot_tot <=  50
replace size_bin = 5  if emp_tot_tot >=  51 & emp_tot_tot <=  70
replace size_bin = 6  if emp_tot_tot >=  71 & emp_tot_tot <= 100
replace size_bin = 7  if emp_tot_tot >= 101 & emp_tot_tot <= 150
replace size_bin = 8  if emp_tot_tot >= 151 & emp_tot_tot <= 200
replace size_bin = 9  if emp_tot_tot >= 201 & emp_tot_tot <= 500
replace size_bin = 10 if emp_tot_tot >= 501 & emp_tot_tot !=   .
gen decile_wbill = size_bin

* Derived employment stocks
gen emp_tot_old   = emp_tot_tot - emp_tot_young
gen emp_tot_ncoll = emp_tot_tot - emp_tot_college
rename emp_tot_experience10 emp_tot_exp10
gen emp_tot_nexp10 = emp_tot_tot - emp_tot_exp10

* Size bins for college / non-college sub-groups
foreach x in college ncoll {
    gen size_bin_`x' = .
    replace size_bin_`x' = 1  if emp_tot_`x' >=   1 & emp_tot_`x' <=  10
    replace size_bin_`x' = 2  if emp_tot_`x' >=  11 & emp_tot_`x' <=  20
    replace size_bin_`x' = 3  if emp_tot_`x' >=  21 & emp_tot_`x' <=  30
    replace size_bin_`x' = 4  if emp_tot_`x' >=  31 & emp_tot_`x' <=  40
    replace size_bin_`x' = 5  if emp_tot_`x' >=  41 & emp_tot_`x' <=  50
    replace size_bin_`x' = 6  if emp_tot_`x' >=  51 & emp_tot_`x' <= 70
    replace size_bin_`x' = 7  if emp_tot_`x' >= 71 & emp_tot_`x' <= 90
    replace size_bin_`x' = 8  if emp_tot_`x' >= 91 & emp_tot_`x' <= 110
    replace size_bin_`x' = 9  if emp_tot_`x' >= 111 & emp_tot_`x' <= 150
    replace size_bin_`x' = 10 if emp_tot_`x' >= 151 & emp_tot_`x' !=   .
}
gen decile_wbill_coll  = size_bin_college
gen decile_wbill_ncoll = size_bin_ncoll

* Immigrant share variables
gen mig_share       = 1 - wbill_german_tot / wbill_tot_tot
gen mig_share_coll  = 1 - wbill_german_college / wbill_tot_college
gen mig_share_ncoll = 1 - (wbill_german_tot - wbill_german_college) ///
                          / (wbill_tot_tot   - wbill_tot_college)

* Residualised immigrant share
egen industry_time    = group(w93_3_gen    jahr)
egen local_labor_time = group(local_labor11 jahr)
quietly reghdfe mig_share, absorb(industry_time local_labor_time) resid
predict mig_share_noindloc, r

* Sub-group immigrant shares
gen mig_share_t         = mig_share          if tradeable3 == 1
gen mig_share_nt        = mig_share          if tradeable3 == 0
gen mig_share_exp       = mig_share          if exports_foreign > 0 & exports_foreign != .
gen mig_share_nexp      = mig_share          if exports_foreign == 0
gen mig_share_exp_nind  = mig_share_noindloc if exports_foreign > 0 & exports_foreign != .
gen mig_share_nexp_nind = mig_share_noindloc if exports_foreign == 0
gen mig_share_sing      = mig_share          if single_establishment == 1
gen mig_share_nfor      = mig_share          if foreign_parent == 0
gen mig_share_el10      = (wbill_tot_experience10 - wbill_german_experience10) ///
                           / wbill_tot_experience10
gen mig_share_ep10      = ((wbill_tot_tot - wbill_tot_experience10) ///
                           - (wbill_german_tot - wbill_german_experience10)) ///
                           / (wbill_tot_tot - wbill_tot_experience10)
gen mig_share_young     = 1 - wbill_german_young / wbill_tot_young
gen mig_share_old       = 1 - (wbill_german_tot - wbill_german_young) ///
                              / (wbill_tot_tot   - wbill_tot_young)

* Extensive margin
gen hire_immigrant = (mig_share > 0)

* Number of origin countries
gen number_of_countries = (wbill_eu_orig1_tot    > 0) + (wbill_eu_orig2_tot    > 0) ///
                        + (wbill_eu_2000_tot      > 0) + (wbill_turkey_tot      > 0) ///
                        + (wbill_yugoslavia_tot   > 0) + (wbill_europe_other_tot> 0) ///
                        + (wbill_asia_tot         > 0) + (wbill_africa_me_tot   > 0) ///
                        + (wbill_americas_tot     > 0)

* Immigrant share groups for A6b
gen mig_share_group = .
forvalues g = 1/20 {
    local lo = (`g' - 1) / 100
    local hi = `g'       / 100
    replace mig_share_group = `g' if mig_share >= `lo' & mig_share < `hi'
}

* Number of immigrants (Table A2)
gen number_of_imm = emp_eu_orig1_tot  + emp_eu_orig2_tot  + emp_eu_2000_tot  ///
                  + emp_turkey_tot    + emp_yugoslavia_tot + emp_europe_other_tot ///
                  + emp_asia_tot      + emp_africa_me_tot  + emp_americas_tot


/*------------------------------------------------------------------------------
  TABLE A1: Descriptive Statistics
------------------------------------------------------------------------------*/

****************************
* Table 1
* Table A1: Descriptive statistics by sector and year
****************************

* Columns: Tradable 2003, Tradable 2011, Non-Tradable 2003, Non-Tradable 2011
* Rows:
*   Panel 1 — N establishments (unweighted), mean employment, mean college employment
*   Panel 2 — Share of employment by origin region (Germany, Europe High-Income,
*     EU Middle Income, EU joined 2004, Europe other, Turkey, Former Yugoslavia,
*     Asia-Pacific, Africa and Middle East, Americas)
* Selection: establishments >= 10 employees; years 2003 and 2011 only
* FDZ: row 1 (N establishments) is unweighted count; all other rows are
*   survey-weighted means (§4.5). Unweighted N per cell shown first.

* --- Panel 1: establishment counts and mean employment ---

* N establishments (unweighted) — reported directly, no weights
di ""
di "======================================================================"
di "TABLE A1 — Panel 1: N, Mean Employment, Mean College Employment"
di "  Selection: emp_tot_tot >= 10, years 2003 and 2011"
di "======================================================================"

* Unweighted counts (the N establishments row in the paper)
tabstat emp_tot_tot if emp_tot_tot >= 10 & (jahr == 2003 | jahr == 2011), ///
    by(tradeable3) stat(count) nototal

* Unweighted counts by sector x year (for FDZ cell-level verification)
table jahr tradeable3 if emp_tot_tot >= 10 & (jahr == 2003 | jahr == 2011)

* Survey-weighted mean employment and mean college employment by sector x year
bysort tradeable3 jahr: sum emp_tot_tot emp_tot_college ///
    [fw=weight_survey] if emp_tot_tot >= 10 & (jahr == 2003 | jahr == 2011)

* --- Panel 2: employment shares by origin region ---

* Aggregate share = sum of origin-group employment across all firms in the cell
*   divided by sum of total employment in that cell (sector x year).
* Computed from survey-weighted sums: share_X = (Σ weight*emp_X) / (Σ weight*emp_tot).

di ""
di "======================================================================"
di "TABLE A1 — Panel 2: Share of employment by origin region"
di "  Aggregate shares: survey-weighted sum(emp_X) / sum(emp_tot)"
di "  Selection: emp_tot_tot >= 10, years 2003 and 2011"
di "======================================================================"

* Unweighted N per cell first (FDZ §4.5)
tabstat emp_tot_tot if emp_tot_tot >= 10 & (jahr == 2003), ///
    by(tradeable3) stat(count) nototal
tabstat emp_tot_tot if emp_tot_tot >= 10 & (jahr == 2011), ///
    by(tradeable3) stat(count) nototal

* Survey-weighted employment sums by origin region, sector and year.
* The aggregate share for each origin is sum(emp_X [fw]) / sum(emp_tot [fw])
* within each tradeable3 x jahr cell — read directly from the sum output.
*The number of establishments used for each table below is the number of establishments reported above, for a given sector - year pair.



preserve
    keep if emp_tot_tot >= 10 & (jahr == 2003 | jahr == 2011)
    collapse (sum) emp_german_tot emp_eu_orig1_tot emp_eu_orig2_tot      ///
                   emp_eu_2000_tot emp_europe_other_tot emp_turkey_tot   ///
                   emp_yugoslavia_tot emp_asia_tot emp_africa_me_tot     ///
                   emp_americas_tot emp_tot_tot                          ///
             [fw=weight_survey], by(tradeable3 jahr)

    * Compute aggregate shares within each cell
    foreach origin in german eu_orig1 eu_orig2 eu_2000 europe_other     ///
                      turkey yugoslavia asia africa_me americas {
        gen share_`origin' = emp_`origin'_tot / emp_tot_tot
    }

    * FDZ: display numerator and denominator (emp_X_tot and emp_tot_tot)
    * for each cell before showing aggregate shares (Guidelines §4.5).
    format emp_* %12.0f
    tabdisp tradeable3 jahr, c(emp_tot_tot)           concise
    foreach origin in german eu_orig1 eu_orig2 eu_2000 europe_other ///
                      turkey yugoslavia asia africa_me americas {
        tabdisp tradeable3 jahr, c(emp_`origin'_tot)  concise
    }

    format share_* %8.4f
    tabdisp tradeable3 jahr, c(share_german)        concise
    tabdisp tradeable3 jahr, c(share_eu_orig1)      concise
    tabdisp tradeable3 jahr, c(share_eu_orig2)      concise
    tabdisp tradeable3 jahr, c(share_eu_2000)       concise
    tabdisp tradeable3 jahr, c(share_europe_other)  concise
    tabdisp tradeable3 jahr, c(share_turkey)        concise
    tabdisp tradeable3 jahr, c(share_yugoslavia)    concise
    tabdisp tradeable3 jahr, c(share_asia)          concise
    tabdisp tradeable3 jahr, c(share_africa_me)     concise
    tabdisp tradeable3 jahr, c(share_americas)      concise
restore


/*------------------------------------------------------------------------------
  TABLE A2: Immigrant share — Intensive vs. Extensive Margin
------------------------------------------------------------------------------*/


****************************
* Table 2
* Table A2: Intensive vs. extensive margin of immigrant hiring
****************************

* Variables: mig_share (dep var: immigrant wage-bill share);
*   number_of_countries (count of origin regions with positive wage bill, 0-9);
*   number_of_imm (total immigrant headcount)
* Selection: establishments >= 10 employees, 2003-2011;
*   FE: industry x year (industry_time), LLM x year (local_labor_time);
*   SE clustered at betnr
* Col 1: number_of_countries only; Col 2: adds number_of_imm
* N (unweighted) reported via di after each regression.

reghdfe mig_share number_of_countries if emp_tot_tot >= 10, ///
    absorb(industry_time local_labor_time) cluster(betnr)
reghdfe mig_share number_of_countries number_of_imm if emp_tot_tot >= 10, ///
    absorb(industry_time local_labor_time) cluster(betnr)


/*------------------------------------------------------------------------------
  STEP 1: POINT ESTIMATES FROM ORIGINAL DATA
------------------------------------------------------------------------------*/

preserve
    collapse (median) mig_share         mig_share_noindloc                   ///
                      mig_share_t       mig_share_nt                         ///
                      mig_share_exp     mig_share_nexp                       ///
                      mig_share_exp_nind mig_share_nexp_nind                 ///
                      mig_share_sing    mig_share_nfor                       ///
                      mig_share_young   mig_share_old                        ///
                      mig_share_el10    mig_share_ep10                       ///
             (mean)   hire_immigrant    number_of_countries                  ///
             [fw=weight_survey], by(decile_wbill)
    save "${data}/medians_main.dta", replace
restore

* Unweighted N per bin for each series (collapse count on the series variable;
* missing = out of subsample, so count gives the correct unweighted N).
* FDZ: also count non-missing observations of the numerator and denominator
* of each share separately, so FDZ can verify both sides (Guidelines §4.5).
* mig_share        = 1 - wbill_german_tot   / wbill_tot_tot
* mig_share_young  = 1 - wbill_german_young / wbill_tot_young
* mig_share_old    = 1 - (wbill_german_tot-wbill_german_young)
*                        / (wbill_tot_tot-wbill_tot_young)
* mig_share_el10   = 1 - wbill_german_experience10 / wbill_tot_experience10
* mig_share_ep10   = 1 - (wbill_german_tot-wbill_german_experience10)
*                        / (wbill_tot_tot-wbill_tot_experience10)
preserve
    * Construct denominator variables for old/ep10 (not directly in data)
    gen wbill_tot_old  = wbill_tot_tot - wbill_tot_young
    gen wbill_ger_old  = wbill_german_tot - wbill_german_young
    gen wbill_tot_ep10 = wbill_tot_tot - wbill_tot_experience10
    gen wbill_ger_ep10 = wbill_german_tot - wbill_german_experience10

    *keep if emp_tot_tot >= 10
    collapse (count) N_main        = mig_share           N_noindloc   = mig_share_noindloc ///
                     N_t           = mig_share_t          N_nt         = mig_share_nt       ///
                     N_exp         = mig_share_exp        N_nexp       = mig_share_nexp     ///
                     N_exp_nind    = mig_share_exp_nind   N_nexp_nind  = mig_share_nexp_nind ///
                     N_sing        = mig_share_sing       N_nfor       = mig_share_nfor     ///
                     N_young       = mig_share_young      N_old        = mig_share_old      ///
                     N_el10        = mig_share_el10       N_ep10       = mig_share_ep10     ///
                     N_hire        = hire_immigrant       N_ncountries = number_of_countries /// *numerator obs counts (non-missing immigrant wbill variable)
                     Nnum_main     = wbill_german_tot         Nden_main    = wbill_tot_tot          ///
                     Nnum_young    = wbill_german_young       Nden_young   = wbill_tot_young        ///
                     Nnum_old      = wbill_ger_old            Nden_old     = wbill_tot_old          ///
                     Nnum_el10     = wbill_german_experience10 Nden_el10   = wbill_tot_experience10 ///
                     Nnum_ep10     = wbill_ger_ep10           Nden_ep10    = wbill_tot_ep10         ///
             , by(decile_wbill)
    save "${data}/N_per_bin_main.dta", replace
restore

* FDZ: Obs counts of numerator/denominator for subsample shares (t/nt, exp/nexp,
* sing/nfor). Each share restricts to a subsample; we count non-missing obs of
* the native wbill (numerator proxy) and total wbill (denominator proxy) within
* each subsample, by size bin.
preserve
    * Restrict variables to the relevant subsample so count gives subsample N
    gen wbill_ger_t    = wbill_german_tot if tradeable3 == 1
    gen wbill_tot_t    = wbill_tot_tot    if tradeable3 == 1
    gen wbill_ger_nt   = wbill_german_tot if tradeable3 == 0
    gen wbill_tot_nt   = wbill_tot_tot    if tradeable3 == 0
    gen wbill_ger_exp  = wbill_german_tot if exports_foreign > 0 & exports_foreign != .
    gen wbill_tot_exp  = wbill_tot_tot    if exports_foreign > 0 & exports_foreign != .
    gen wbill_ger_nexp = wbill_german_tot if exports_foreign == 0
    gen wbill_tot_nexp = wbill_tot_tot    if exports_foreign == 0
    gen wbill_ger_sing = wbill_german_tot if single_establishment == 1
    gen wbill_tot_sing = wbill_tot_tot    if single_establishment == 1
    gen wbill_ger_nfor = wbill_german_tot if foreign_parent == 0
    gen wbill_tot_nfor = wbill_tot_tot    if foreign_parent == 0
    collapse (count) Nnum_t    = wbill_ger_t    Nden_t    = wbill_tot_t    ///
                     Nnum_nt   = wbill_ger_nt   Nden_nt   = wbill_tot_nt   ///
                     Nnum_exp  = wbill_ger_exp  Nden_exp  = wbill_tot_exp  ///
                     Nnum_nexp = wbill_ger_nexp Nden_nexp = wbill_tot_nexp ///
                     Nnum_sing = wbill_ger_sing Nden_sing = wbill_tot_sing ///
                     Nnum_nfor = wbill_ger_nfor Nden_nfor = wbill_tot_nfor ///
             , by(decile_wbill)
    merge 1:1 decile_wbill using "${data}/N_per_bin_main.dta", nogenerate
    save "${data}/N_per_bin_main.dta", replace
restore

preserve
    collapse (median) mig_share_coll [fw=weight_survey], by(decile_wbill_coll)
    save "${data}/medians_coll.dta", replace
restore

preserve
    * mig_share_coll = 1 - wbill_german_college / wbill_tot_college
    * Count non-missing obs of numerator (wbill_german_college) and
    * denominator (wbill_tot_college) separately (Guidelines §4.5).
    *keep if emp_tot_tot >= 10
    collapse (count) N_coll     = mig_share_coll ///
                     Nnum_coll  = wbill_german_college ///
                     Nden_coll  = wbill_tot_college ///
             , by(decile_wbill_coll)
    rename decile_wbill_coll decile_wbill
    save "${data}/N_per_bin_coll.dta", replace
restore

preserve
    collapse (median) mig_share_ncoll [fw=weight_survey], by(decile_wbill_ncoll)
    save "${data}/medians_ncoll.dta", replace
restore

preserve
    * mig_share_ncoll = 1 - (wbill_german_tot - wbill_german_college)
    *                       / (wbill_tot_tot   - wbill_tot_college)
    * Denominator = wbill_tot_tot - wbill_tot_college; construct it so count
    * reflects non-missing obs on both sides (Guidelines §4.5).
    gen wbill_ger_ncoll = wbill_german_tot - wbill_german_college
    gen wbill_tot_ncoll = wbill_tot_tot    - wbill_tot_college
    *keep if emp_tot_tot >= 10
    collapse (count) N_ncoll      = mig_share_ncoll ///
                     Nnum_ncoll   = wbill_ger_ncoll ///
                     Nden_ncoll   = wbill_tot_ncoll ///
             , by(decile_wbill_ncoll)
    rename decile_wbill_ncoll decile_wbill
    save "${data}/N_per_bin_ncoll.dta", replace
restore

preserve
    collapse (median) med_countries  = number_of_countries ///
             (mean)   mean_countries = number_of_countries ///
             (count)  N_a6b          = number_of_countries ///
             [fw=weight_survey] if emp_tot_tot >= 10, by(mig_share_group)
    save "${data}/medians_a6b.dta", replace
restore

keep decile_wbill decile_wbill_coll decile_wbill_ncoll                       ///
     tradeable3 weight_survey emp_tot_tot mig_share_group                    ///
     mig_share         mig_share_noindloc                                    ///
     mig_share_t       mig_share_nt                                          ///
     mig_share_exp     mig_share_nexp                                        ///
     mig_share_exp_nind mig_share_nexp_nind                                  ///
     mig_share_sing    mig_share_nfor                                        ///
     mig_share_young   mig_share_old                                         ///
     mig_share_el10    mig_share_ep10                                        ///
     mig_share_coll    mig_share_ncoll                                       ///
     hire_immigrant    number_of_countries                                   ///
     exports_foreign   single_establishment foreign_parent

save "${data}/descriptives_orig.dta", replace


/*------------------------------------------------------------------------------
  STEP 2: BOOTSTRAP — main grouping, 200 reps
------------------------------------------------------------------------------*/
*supressing log to avoid excessive output

log off

local ntot = 200

forvalues x = 1/`ntot' {
    preserve
    display `x'
    set seed `x'
    bsample
    collapse (median) mig_share         mig_share_noindloc                   ///
                      mig_share_t       mig_share_nt                         ///
                      mig_share_exp     mig_share_nexp                       ///
                      mig_share_exp_nind mig_share_nexp_nind                 ///
                      mig_share_sing    mig_share_nfor                       ///
                      mig_share_young   mig_share_old                        ///
                      mig_share_el10    mig_share_ep10                       ///
             (mean)   hire_immigrant    number_of_countries                  ///
             [fw=weight_survey], by(decile_wbill)
    gen nsample = `x'
    tempfile boot`x'
    save `boot`x'', replace
    restore
}

use `boot1', clear
forvalues y = 2/`ntot' {
    append using `boot`y''
}

log on 

collapse (sd) sd_mig_share         = mig_share                               ///
              sd_noindloc          = mig_share_noindloc                      ///
              sd_t                 = mig_share_t                             ///
              sd_nt                = mig_share_nt                            ///
              sd_exp               = mig_share_exp                           ///
              sd_nexp              = mig_share_nexp                          ///
              sd_exp_nind          = mig_share_exp_nind                      ///
              sd_nexp_nind         = mig_share_nexp_nind                     ///
              sd_sing              = mig_share_sing                          ///
              sd_nfor              = mig_share_nfor                          ///
              sd_young             = mig_share_young                         ///
              sd_old               = mig_share_old                           ///
              sd_el10              = mig_share_el10                          ///
              sd_ep10              = mig_share_ep10                          ///
              sd_hire              = hire_immigrant                           ///
              sd_ncountries        = number_of_countries                     ///
         , by(decile_wbill)

save "${data}/boot_sd_main.dta", replace


/*------------------------------------------------------------------------------
  STEP 3: BOOTSTRAP — college grouping
------------------------------------------------------------------------------*/
*supressing log to avoid excessive output



use "${data}/descriptives_orig.dta", clear

log off 

forvalues x = 1/`ntot' {
    preserve
    set seed `x'
    bsample
    collapse (median) mig_share_coll [fw=weight_survey], by(decile_wbill_coll)
    gen nsample = `x'
    tempfile bootc`x'
    save `bootc`x'', replace
    restore
}

use `bootc1', clear
forvalues y = 2/`ntot' {
    append using `bootc`y''
}

log on 

collapse (sd) sd_coll = mig_share_coll, by(decile_wbill_coll)
rename decile_wbill_coll decile_wbill
save "${data}/boot_sd_coll.dta", replace


/*------------------------------------------------------------------------------
  STEP 4: BOOTSTRAP — non-college grouping
------------------------------------------------------------------------------*/

use "${data}/descriptives_orig.dta", clear

*supressing log to avoid excessive output

log off 

forvalues x = 1/`ntot' {
    preserve
    set seed `x'
    bsample
    collapse (median) mig_share_ncoll [fw=weight_survey], by(decile_wbill_ncoll)
    gen nsample = `x'
    tempfile bootn`x'
    save `bootn`x'', replace
    restore
}

use `bootn1', clear
forvalues y = 2/`ntot' {
    append using `bootn`y''
}

log on 

collapse (sd) sd_ncoll = mig_share_ncoll, by(decile_wbill_ncoll)
rename decile_wbill_ncoll decile_wbill
save "${data}/boot_sd_ncoll.dta", replace


/*------------------------------------------------------------------------------
  STEP 5: MERGE POINT ESTIMATES AND SDs
 BUILD CI VARIABLES
------------------------------------------------------------------------------*/

* ---- Main dataset ----------------------------------------------------------
use "${data}/medians_main.dta", clear
merge 1:1 decile_wbill using "${data}/boot_sd_main.dta", nogenerate
merge 1:1 decile_wbill using "${data}/N_per_bin_main.dta", nogenerate

gen ci_lo_mig_share     = mig_share           - 1.96 * sd_mig_share
gen ci_hi_mig_share     = mig_share           + 1.96 * sd_mig_share
gen ci_lo_noindloc      = mig_share_noindloc  - 1.96 * sd_noindloc
gen ci_hi_noindloc      = mig_share_noindloc  + 1.96 * sd_noindloc
gen ci_lo_t             = mig_share_t         - 1.96 * sd_t
gen ci_hi_t             = mig_share_t         + 1.96 * sd_t
gen ci_lo_nt            = mig_share_nt        - 1.96 * sd_nt
gen ci_hi_nt            = mig_share_nt        + 1.96 * sd_nt
gen ci_lo_exp           = mig_share_exp       - 1.96 * sd_exp
gen ci_hi_exp           = mig_share_exp       + 1.96 * sd_exp
gen ci_lo_nexp          = mig_share_nexp      - 1.96 * sd_nexp
gen ci_hi_nexp          = mig_share_nexp      + 1.96 * sd_nexp
gen ci_lo_exp_nind      = mig_share_exp_nind  - 1.96 * sd_exp_nind
gen ci_hi_exp_nind      = mig_share_exp_nind  + 1.96 * sd_exp_nind
gen ci_lo_nexp_nind     = mig_share_nexp_nind - 1.96 * sd_nexp_nind
gen ci_hi_nexp_nind     = mig_share_nexp_nind + 1.96 * sd_nexp_nind
gen ci_lo_sing          = mig_share_sing      - 1.96 * sd_sing
gen ci_hi_sing          = mig_share_sing      + 1.96 * sd_sing
gen ci_lo_nfor          = mig_share_nfor      - 1.96 * sd_nfor
gen ci_hi_nfor          = mig_share_nfor      + 1.96 * sd_nfor
gen ci_lo_hire          = hire_immigrant      - 1.96 * sd_hire
gen ci_hi_hire          = hire_immigrant      + 1.96 * sd_hire
gen ci_lo_el10          = mig_share_el10      - 1.96 * sd_el10
gen ci_hi_el10          = mig_share_el10      + 1.96 * sd_el10
gen ci_lo_ep10          = mig_share_ep10      - 1.96 * sd_ep10
gen ci_hi_ep10          = mig_share_ep10      + 1.96 * sd_ep10
gen ci_lo_young         = mig_share_young     - 1.96 * sd_young
gen ci_hi_young         = mig_share_young     + 1.96 * sd_young
gen ci_lo_old           = mig_share_old       - 1.96 * sd_old
gen ci_hi_old           = mig_share_old       + 1.96 * sd_old
gen ci_lo_ncountries    = number_of_countries - 1.96 * sd_ncountries
gen ci_hi_ncountries    = number_of_countries + 1.96 * sd_ncountries

* Label the size bin variable for display
label define bin_lbl 1 "0-10" 2 "11-20" 3 "21-30" 4 "31-50" 5 "51-70"    ///
    6 "71-100" 7 "101-150" 8 "151-200" 9 "201-500" 10 "+500"
label values decile_wbill bin_lbl

format mig_share* ci_lo* ci_hi* hire_immigrant number_of_countries %6.4f

save "${data}/plot_data_main.dta", replace

* ---- College ---------------------------------------------------------------
use "${data}/medians_coll.dta", clear
rename decile_wbill_coll decile_wbill
merge 1:1 decile_wbill using "${data}/boot_sd_coll.dta", nogenerate
merge 1:1 decile_wbill using "${data}/N_per_bin_coll.dta", nogenerate
gen ci_lo_coll = mig_share_coll - 1.96 * sd_coll
gen ci_hi_coll = mig_share_coll + 1.96 * sd_coll
label values decile_wbill bin_lbl
format mig_share_coll ci_lo_coll ci_hi_coll %6.4f
save "${data}/plot_data_coll.dta", replace

* ---- Non-college -----------------------------------------------------------
use "${data}/medians_ncoll.dta", clear
rename decile_wbill_ncoll decile_wbill
merge 1:1 decile_wbill using "${data}/boot_sd_ncoll.dta", nogenerate
merge 1:1 decile_wbill using "${data}/N_per_bin_ncoll.dta", nogenerate
gen ci_lo_ncoll = mig_share_ncoll - 1.96 * sd_ncoll
gen ci_hi_ncoll = mig_share_ncoll + 1.96 * sd_ncoll
label values decile_wbill bin_lbl
format mig_share_ncoll ci_lo_ncoll ci_hi_ncoll %6.4f
save "${data}/plot_data_ncoll.dta", replace


/*==============================================================================
  TABLES — point estimates and 95% CIs by size bin
  Each table corresponds to the underlying data for one figure.
==============================================================================*/

use "${data}/plot_data_main.dta", clear

* --------------------------------------------------------------------------
di ""
di "======================================================================"

****************************
* Table 3
* Figure 1: Median immigrant share by establishment size bin
****************************

* Variables: mig_share (immigrant wage-bill share, 0-1),
*   ci_lo_mig_share / ci_hi_mig_share (95% bootstrap CI bounds),
*   N_main (unweighted establishment count per size bin),
*   decile_wbill (employment size bin, 10 categories)
* Selection: All sectors, 2003-2011, establishments >= 10 employees;
*   survey-weighted median per bin; 200 bootstrap repetitions

* FDZ: obs count of numerator (wbill_german_tot) and denominator (wbill_tot_tot) per bin
tabdisp decile_wbill, c(Nnum_main Nden_main) concise
tabdisp decile_wbill, c(N_main) concise
tabdisp decile_wbill, c(mig_share ci_lo_mig_share ci_hi_mig_share) concise

* --------------------------------------------------------------------------
di ""
di "======================================================================"

****************************
* Table 4
* Figure A1(a): Controlling for industry and geography
****************************

* Variables: mig_share (raw median), mig_share_noindloc (residualised
*   on 3-digit industry x year and LLM x year FEs),
*   ci_lo_noindloc / ci_hi_noindloc (95% bootstrap CI bounds),
*   N_main / N_noindloc (unweighted N per bin for each series),
*   decile_wbill (size bin)
* Selection: All sectors, 2003-2011, establishments >= 10 employees

* FDZ: obs count of numerator (wbill_german_tot) and denominator (wbill_tot_tot)
* mig_share_noindloc is a residual of mig_share; same underlying variables
tabdisp decile_wbill, c(Nnum_main Nden_main) concise
tabdisp decile_wbill, c(N_main N_noindloc) concise
tabdisp decile_wbill, c(mig_share mig_share_noindloc ci_lo_noindloc ci_hi_noindloc) concise

* --------------------------------------------------------------------------
di ""
di "======================================================================"

****************************
* Table 5
* Figure A1(b): Tradable vs. non-tradable sectors
****************************

* Variables: mig_share_t (immigrant share, tradable sector),
*   mig_share_nt (non-tradable sector); ci_lo/hi for each;
*   N_t / N_nt (unweighted N per bin for each sector),
*   decile_wbill (size bin)
* Selection: 2003-2011, establishments >= 10 employees; by sector

* FDZ: obs count of numerator/denominator for tradable and non-tradable subsamples
tabdisp decile_wbill, c(Nnum_t Nden_t) concise
tabdisp decile_wbill, c(Nnum_nt Nden_nt) concise
tabdisp decile_wbill, c(N_t N_nt) concise
tabdisp decile_wbill, c(mig_share_t ci_lo_t ci_hi_t) concise
tabdisp decile_wbill, c(mig_share_nt ci_lo_nt ci_hi_nt) concise

* --------------------------------------------------------------------------
di ""
di "======================================================================"

****************************
* Table 6
* Figure A1(c): Exporter vs. non-exporter
****************************

* Variables: mig_share_exp (immigrant share, exports_foreign > 0),
*   mig_share_nexp (exports_foreign == 0); ci_lo/hi for each;
*   N_exp / N_nexp (unweighted N per bin for each group),
*   decile_wbill (size bin)
* Selection: 2003-2011, establishments >= 10 employees

* FDZ: obs count of numerator/denominator for exporter and non-exporter subsamples
tabdisp decile_wbill, c(Nnum_exp Nden_exp) concise
tabdisp decile_wbill, c(Nnum_nexp Nden_nexp) concise
tabdisp decile_wbill, c(N_exp N_nexp) concise
tabdisp decile_wbill, c(mig_share_exp ci_lo_exp ci_hi_exp) concise
tabdisp decile_wbill, c(mig_share_nexp ci_lo_nexp ci_hi_nexp) concise

* --------------------------------------------------------------------------
di ""
di "======================================================================"

****************************
* Table 7
* Figure A1(d): Exporter vs. non-exporter, residualised
****************************

* Variables: mig_share_exp_nind / mig_share_nexp_nind (immigrant share
*   residualised on industry x year and LLM x year FEs, by exporter status);
*   ci_lo/hi for each; N_exp_nind / N_nexp_nind (unweighted N per bin),
*   decile_wbill (size bin)
* Selection: 2003-2011, establishments >= 10 employees

* FDZ: residualised shares use same subsample as exp/nexp; same obs counts apply
tabdisp decile_wbill, c(Nnum_exp Nden_exp) concise
tabdisp decile_wbill, c(Nnum_nexp Nden_nexp) concise
tabdisp decile_wbill, c(N_exp_nind N_nexp_nind) concise
tabdisp decile_wbill, c(mig_share_exp_nind ci_lo_exp_nind ci_hi_exp_nind) concise
tabdisp decile_wbill, c(mig_share_nexp_nind ci_lo_nexp_nind ci_hi_nexp_nind) concise

* --------------------------------------------------------------------------
di ""
di "======================================================================"

****************************
* Table 9
* Figure A2(b): Single-establishment and German-owned firms
****************************

* Variables: mig_share (baseline), mig_share_sing (single_establishment == 1),
*   mig_share_nfor (foreign_parent == 0); ci_lo/hi for each;
*   N_main / N_sing / N_nfor (unweighted N per bin for each series),
*   decile_wbill (size bin)
* Selection: 2003-2011, establishments >= 10 employees

* FDZ: obs count of numerator/denominator for each subsample
tabdisp decile_wbill, c(Nnum_main Nden_main) concise
tabdisp decile_wbill, c(Nnum_sing Nden_sing) concise
tabdisp decile_wbill, c(Nnum_nfor Nden_nfor) concise
tabdisp decile_wbill, c(N_main N_sing N_nfor) concise
tabdisp decile_wbill, c(mig_share ci_lo_mig_share ci_hi_mig_share) concise
tabdisp decile_wbill, c(mig_share_sing ci_lo_sing ci_hi_sing) concise
tabdisp decile_wbill, c(mig_share_nfor ci_lo_nfor ci_hi_nfor) concise

* --------------------------------------------------------------------------
di ""
di "======================================================================"

****************************
* Table 10
* Figure A3: Extensive margin of hiring
****************************

* Variables: hire_immigrant (=1 if mig_share > 0, i.e. establishment
*   hires at least one immigrant); ci_lo_hire / ci_hi_hire;
*   N_hire (unweighted N per bin), decile_wbill (size bin)
* Selection: 2003-2011, establishments >= 10 employees;
*   survey-weighted mean per bin
* NOTE: hire_immigrant is a dummy variable. N_hire is reported alongside
*   the mean so FDZ can verify both categories (0/1) have >= 20 obs.

tabdisp decile_wbill, c(N_hire) concise
tabdisp decile_wbill, c(hire_immigrant ci_lo_hire ci_hi_hire) concise

* --------------------------------------------------------------------------
di ""
di "======================================================================"

****************************
* Table 11
* Figure A4(a): By tenure — more vs. less than 10 years experience
****************************

* Variables: mig_share_ep10 (immigrant share, workers with > 10 years
*   experience in the labour market), mig_share_el10 (<= 10 years);
*   ci_lo/hi for each; N_ep10 / N_el10 (unweighted N per bin),
*   decile_wbill (size bin)
* Selection: 2003-2011, establishments >= 10 employees

di "  ep10 = more than 10 years experience;  el10 = less than 10 years"
di "======================================================================"
* FDZ: obs count of numerator/denominator for each tenure subgroup
tabdisp decile_wbill, c(Nnum_ep10 Nden_ep10) concise
tabdisp decile_wbill, c(Nnum_el10 Nden_el10) concise
tabdisp decile_wbill, c(N_ep10 N_el10) concise
tabdisp decile_wbill, c(mig_share_ep10 ci_lo_ep10 ci_hi_ep10) concise
tabdisp decile_wbill, c(mig_share_el10 ci_lo_el10 ci_hi_el10) concise

* --------------------------------------------------------------------------
di ""
di "======================================================================"

****************************
* Table 12
* Figure A4(b): By age — young (< 40) vs. old (>= 40)
****************************

* Variables: mig_share_young (immigrant share, workers aged < 40),
*   mig_share_old (aged >= 40); ci_lo/hi for each;
*   N_young / N_old (unweighted N per bin), decile_wbill (size bin)
* Selection: 2003-2011, establishments >= 10 employees

* FDZ: obs count of numerator/denominator for each age subgroup
tabdisp decile_wbill, c(Nnum_young Nden_young) concise
tabdisp decile_wbill, c(Nnum_old Nden_old) concise
tabdisp decile_wbill, c(N_young N_old) concise
tabdisp decile_wbill, c(mig_share_young ci_lo_young ci_hi_young) concise
tabdisp decile_wbill, c(mig_share_old ci_lo_old ci_hi_old) concise

* --------------------------------------------------------------------------
di ""
di "======================================================================"

****************************
* Table 13
* Figure A6(a): Number of origin regions sourced from, by size bin
****************************

* Variables: number_of_countries (count of origin regions with positive
*   immigrant wage bill, 0-9); ci_lo_ncountries / ci_hi_ncountries;
*   N_ncountries (unweighted N per bin), decile_wbill (size bin)
* Selection: 2003-2011, establishments >= 10 employees;
*   survey-weighted mean per bin

tabdisp decile_wbill, c(N_ncountries) concise
tabdisp decile_wbill, c(number_of_countries ci_lo_ncountries ci_hi_ncountries) concise


* --------------------------------------------------------------------------
di ""
di "======================================================================"
di "FIGURE A2(a): College vs. non-college"
di "======================================================================"

****************************
* Table 8
* Figure A2(a): College vs. non-college sub-groups
****************************

* Variables: mig_share_coll (immigrant share of college wage bill),
*   mig_share_ncoll (non-college wage bill); ci_lo/hi for each;
*   N_coll / N_ncoll (unweighted N per bin for each sub-group),
*   decile_wbill (size bins defined separately per sub-group)
* Selection: 2003-2011, establishments >= 10 employees

use "${data}/plot_data_coll.dta", clear
merge 1:1 decile_wbill using "${data}/plot_data_ncoll.dta", nogenerate

* FDZ: obs count of numerator/denominator for college and non-college subgroups
tabdisp decile_wbill, c(Nnum_coll Nden_coll) concise
tabdisp decile_wbill, c(Nnum_ncoll Nden_ncoll) concise
tabdisp decile_wbill, c(N_coll N_ncoll) concise
tabdisp decile_wbill, c(mig_share_coll ci_lo_coll ci_hi_coll) concise
tabdisp decile_wbill, c(mig_share_ncoll ci_lo_ncoll ci_hi_ncoll) concise


* --------------------------------------------------------------------------
di ""
di "======================================================================"
di "FIGURE A6(b): Number of regions sourced, by immigrant share group"
di "  (1% bins no bootstrap — point estimates only)"
di "======================================================================"

****************************
* Table 14
* Figure A6(b): Number of origin regions by immigrant-share group
****************************

* Variables: med_countries / mean_countries (median and mean of
*   number_of_countries per 1%-wide immigrant-share bin);
*   mig_share_pct (midpoint of bin in %); N_a6b (unweighted count per bin)
* Selection: 2003-2011, establishments >= 10 employees;
*   1%-wide bins covering immigrant shares 0-20% (20 bins)
* No bootstrap CIs — point estimates only.

use "${data}/medians_a6b.dta", clear
drop if mig_share_group == .
gen mig_share_pct = (mig_share_group - 0.5)   // midpoint in percent
format med_countries mean_countries %6.3f
tabdisp mig_share_pct, c(N_a6b) concise
tabdisp mig_share_pct, c(med_countries mean_countries) concise


log close