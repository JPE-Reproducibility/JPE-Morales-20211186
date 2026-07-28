cap log close
log using "${log}/19_moments_calculation.log", replace

* SMM calibration moments and demand elasticity sigma
* Agostina Brinatti & Nicolas Morales
* Source data: LIAB Longitudinal Model (version 1993-2014), IAB

/*	This dofile computes all empirical moments used for SMM calibration
	(Table 1 / Table C7) and the demand elasticity sigma used in Section 5.1.

	Output tables in this dofile:
	  Table 1  - Section 5.1: Demand elasticities sigma_d and sigma_x
	  Table 2  - Moment 1: Revenue variance conditional on immigrant share
	  Table 3  - Moments 2-3: Aggregate and average immigrant share
	  Table 4  - Moment 4: Variance of log immigrant-to-native wage bill ratio
	  Table 5  - Moment 5: Share of firms hiring immigrants
	  Table 6  - Moment 6: Share of firms exporting
	  Table 7  - Moment 7: Export-to-domestic revenue ratio
	  Table 8 - Moment 8: Immigrant share by wage-bill decile

	FDZ note: For each weighted statistic the immediately preceding output
	  is the unweighted equivalent so cell counts can be verified (§4.5).
	  Dummy variables (mig_D, trade) include both N and mean so both
	  categories can be verified to have >= 20 observations (§4.3).
*/


/*

input dataset:
(i) "establishment_level_liab".

This dofile creates compute moments to be used for calibration, including the elasticity of substitution across varieties.
It also computes the moments for the external validation.

*/


clear

set more off
set matsize 10000
set linesize 255
set seed 1234


capture adopath++ ${prog}


use "${data}/establishment_level_liab.dta", clear

keep if jahr>=2003 & jahr<=2011
label val w93_3_gen w93_3_gen_en



*Dependent variables

gen logrevenues=log(turnover)
gen logexprevenues=log(1+turnover*(exports_foreign/100))
replace logexprevenues=. if exports_foreign==.

gen logdomrevenues=log(1+turnover*(1-(exports_foreign/100)))
replace logdomrevenues=. if exports_foreign==.

gen trade=(exports_foreign>0)
replace trade=. if exports_foreign==.


*size is the variable for the interaction term

gen share_mig_firm2_t=(wbill_tot_tot-wbill_german_tot)/wbill_tot_tot

*Generating some new variables

gen mbill_tot_tot= turnover*(int_inputs/100)
gen markup1 = turnover/(wbill_tot_tot + mbill_tot_tot)
gen markdown1 = 1/markup1

*-------------------------------------------------------------------------------
* 	Estimation of sigma and sigma_x as done for the test of epsilon>sigma
*-------------------------------------------------------------------------------

preserve 

keep if emp_tot_tot>=10 

*Estimate sigma for all firms		

****************************
* Table 1
* Section 5.1: Demand elasticities sigma_d and sigma_x
****************************

* Variables: markup1 (= revenue / (wage bill + material costs));
*   markdown1 (= 1/markup1); exports_foreign (export share, 0-100)
* sigma_d = markup_d / (markup_d - 1) from NT average markup (eq. 17)
* sigma_x inferred from exporters' markdown gap in tradable sector
* Selection: establishments >= 10 employees; sigma_d from tradeable3=0;
*   sigma_x from tradeable3=1, exports_foreign > 0
* FDZ: unweighted stats shown first, then survey-weighted
*   estimates reported via sum after each block.

quietly reghdfe   markup1 [fw=weight_survey] , noabsorb /**/
		gen sigma    = _b[_cons]/(_b[_cons] - 1) /**/

*Estimate sigma	of non tradeable
quietly reghdfe  markup1 	[fw=weight_survey]	if  tradeable3==0  , noabsorb
		gen markup1_d =  _b[_cons] /**/
		gen sigma_d   = _b[_cons]/(_b[_cons] - 1) /**/
	
*Estimate the markdown of non-exporters	and exporters in the tradeable sector

quietly reghdfe  markdown1 [fw=weight_survey] if  (exports_foreign==0 | missing(exports_foreign)) &  tradeable3==1 , noabsorb
	gen markdown1_d =  _b[_cons]

quietly reghdfe  markdown1 [fw=weight_survey] if (exports_foreign>0 & exports_foreign!=.) &  tradeable3==1 , noabsorb
	gen markdown1_e =  _b[_cons]
	

*Estimate the average export share in the tredeable sector for exporters

quietly reghdfe exports_foreign [fw=weight_survey] if (exports_foreign>0 & exports_foreign!=.) & tradeable3==1  , noabsorb /**/
 	gen export_share =  _b[_cons]/100	
	
		
*Estimate the markdown in RoW 

	gen markdown1_x =  ( markdown1_e - (1-export_share) * markdown1_d ) / export_share
	
*Estimate sigma_x and average sigma
	
	gen sigma_x = 1/(1-markdown1_x)
	gen sigma_avg = (1-export_share) * sigma_d + export_share * sigma_x
	

	
	
*Displaying sigma_x (RoW), sigma (domestic)
sum sigma_x sigma 


*Displaying overall markup, non-tradable markup, export share 

****************************
* Table 1 (supplement)
* Section 5.1: sigma components printed for reference
****************************

* Variables: markup1 (revenue / factor costs), markdown1_d (NT non-exporter
*   markdown), export_share (exporter share in tradable sector), sigma_avg (average sigma in tradable sector)
* Selection: epsilon sample; survey-weighted means
* These support the sigma_d and sigma_x calculations in Table 1 above.

sum markup1  markdown1_d export_share  sigma_avg

restore 


gen share_mig_ratio = (1-share_mig_firm2_t)/share_mig_firm2_t
gen mig_D = (share_mig_firm2_t>0)
gen l_share_mig_firm2_t = log(share_mig_firm2_t)



********************************************************************************
* Empirical moments for SMM
********************************************************************************


*1) Revenue variability tradeable and non-tradeable sector

quietly reg logrevenues l_share_mig_firm2_t trade i.jahr i.local_labor11#c.jahr if tradeable3==1 & emp_tot_tot>=10
predict resid_T,r

quietly reg logrevenues l_share_mig_firm2_t  trade i.jahr i.local_labor11#c.jahr if tradeable3==0 & emp_tot_tot>=10
predict resid_NT,r


****************************
* Table 2
* Table C7 Moment 1: Revenue variance conditional on immigrant share
****************************

* Variables: resid_T / resid_NT (residuals from OLS of logrevenues on
*   l_share_mig_firm2_t, trade, year FE, local-labor-market x year FE)
* Selection: tradable (tradeable3=1) and non-tradable (tradeable3=0)
*   establishments >= 10 employees
* Moment identifies revenue dispersion sigma_eps in each sector.
* FDZ: unweighted sum shown first; survey-weighted follows.

sum resid_T if emp_tot_tot>=10 & tradeable3==1
sum resid_T [fw=weight_survey] if emp_tot_tot>=10 & tradeable3==1


sum resid_NT if emp_tot_tot>=10 & tradeable3==0
sum resid_NT [fw=weight_survey] if emp_tot_tot>=10 & tradeable3==0



*2) Aggregate immigrant share tradeable and non tradeable
*3) Average immigrant share tradeable and non-tradeable
gen dom_share=wbill_german_tot/wbill_tot_tot



****************************
* Table 3
* Table C7 Moments 2-3: Aggregate and average immigrant share
****************************

* Variables: wbill_german_tot (native wage bill), wbill_tot_tot (total wage bill)
* Moment 2 — Aggregate immigrant share: sum all immigrant and total wage bills
*   across firms within each sector, then compute 1 - (sum_native / sum_total).
*   This is the sector-level aggregate share, not an average of firm-level shares.
*   Identifies beta_k (distributional share parameter).
* Moment 3 — Average (within-establishment) immigrant share: mean of dom_share
*   across establishments. Identifies average firm-level immigrant intensity.
* Selection: establishments >= 10 employees; by sector (tradeable3)
* FDZ: unweighted shown first (N verifiable); survey-weighted follows.

* Moment 2: Aggregate immigrant share by sector (sum wage bills, then divide)
* Unweighted totals (N verifiable)
tabstat wbill_german_tot wbill_tot_tot if emp_tot_tot>=10, by(tradeable3) stat(sum count) nototal
* Survey-weighted totals
*FDZ: bysort + sum [fw=] gives weighted sums for aggregate share calculation
bysort tradeable3: sum wbill_german_tot wbill_tot_tot [fw=weight_survey] if emp_tot_tot>=10

* Moment 3: Average (within-establishment) immigrant share by sector
* Unweighted
tabstat dom_share if emp_tot_tot>=10, by(tradeable3) stat(mean count) nototal
* Survey-weighted
bysort tradeable3: sum dom_share [fw=weight_survey] if emp_tot_tot>=10


*4) Variance of immigrant shares

gen log_share_dom = log(dom_share)
gen log_transformation=log((1-dom_share)/dom_share)

****************************
* Table 4
* Table C7 Moment 4: Variance of log immigrant-to-native wage bill ratio
****************************

* Variables: log_transformation (= log((1-dom_share)/dom_share),
*   i.e. log of immigrant-to-native wage bill ratio)
* Selection: establishments >= 10 employees; by sector (tradeable3)
* Moment identifies the dispersion of firm-level immigrant intensity.
* FDZ: unweighted sum shown first (N verifiable); survey-weighted follows.

sum  log_transformation if tradeable3==1 & emp_tot_tot>=10
sum  log_transformation [fw=weight_survey] if tradeable3==1 & emp_tot_tot>=10

sum  log_transformation if tradeable3==0 & emp_tot_tot>=10
sum  log_transformation [fw=weight_survey] if tradeable3==0 & emp_tot_tot>=10



****************************
* Table 5
* Table C7 Moment 5: Share of firms hiring immigrants
****************************

* Variables: mig_D (= 1 if share_mig_firm2_t > 0, i.e. firm has any immigrant
*   wage bill); both N and mean reported so each category can be verified
*   to have >= 20 observations (§4.3).
* Selection: establishments >= 10 employees; by sector (tradeable3)
* Moment identifies fixed cost of hiring immigrants f_m.
* FDZ: unweighted sum shown first (N verifiable); survey-weighted follows.

sum mig_D if tradeable3==1 & emp_tot_tot>=10
sum mig_D [fw=weight_survey] if tradeable3==1 & emp_tot_tot>=10

sum mig_D if tradeable3==0 & emp_tot_tot>=10
sum mig_D [fw=weight_survey] if tradeable3==0 & emp_tot_tot>=10

****************************
* Table 6
* Table C7 Moment 6: Share of firms exporting
****************************

* Variables: trade (= 1 if exports_foreign > 0; missing if exports_foreign
*   missing); both N and mean reported so each category can be verified
*   to have >= 20 observations (§4.3).
* Selection: tradable establishments (tradeable3=1) >= 10 employees
* Moment identifies fixed export cost f_x.
* FDZ: unweighted sum shown first (N verifiable); survey-weighted follows.

sum trade if tradeable3==1 & emp_tot_tot>=10
sum trade [fw=weight_survey] if tradeable3==1 & emp_tot_tot>=10


*7) Export to domestic revenues moments
gen export_to_dom_rev=(exports_foreign/100)/(1-(exports_foreign/100))

gen export_rev=(exports_foreign/100)*turnover
gen domestic_rev=(1-(exports_foreign/100))*turnover

****************************
* Table 7
* Table C7 Moment 7: Export-to-domestic revenue ratio (tradable exporters)
****************************

* Variables: export_rev (= exports_foreign/100 * turnover),
*   domestic_rev (= (1 - exports_foreign/100) * turnover)
* Selection: tradable exporters (tradeable3=1, exports_foreign > 0),
*   establishments >= 10 employees
* Moment identifies iceberg trade cost tau.
* FDZ: unweighted table shown first; survey-weighted follows.



sum export_rev domestic_rev export_to_dom_rev if emp_tot_tot>=10 & tradeable3==1 & (exports_foreign>0 & exports_foreign!=.)
sum export_rev domestic_rev export_to_dom_rev [fw=weight_survey] if emp_tot_tot>=10 & tradeable3==1 & (exports_foreign>0 & exports_foreign!=.)






*10) Mean sd percentile 90 - Mean sd percentile 50, T and NT
xtile decile_wbill=wbill_tot_tot if emp_tot_tot>=10, nq(10)
xtile decile_emp=emp_tot_tot if emp_tot_tot>=10, nq(10)
xtile decile_rev=turnover if emp_tot_tot>=10, nq(10)

xtile decile_wbill_weight=wbill_tot_tot if emp_tot_tot>=10 [fw=weight_survey], nq(10)
xtile decile_emp_weight=emp_tot_tot if emp_tot_tot>=10 [fw=weight_survey], nq(10)
xtile decile_rev_weight=turnover if emp_tot_tot>=10 [fw=weight_survey], nq(10)

xtile full_dec_wbill=wbill_tot_tot, nq(10)
xtile full_dec_emp=emp_tot_tot, nq(10)
xtile full_dec_rev=turnover, nq(10)

xtile full_dec_wbill_weight=wbill_tot_tot [fw=weight_survey], nq(10)
xtile full_dec_emp_weight=emp_tot_tot [fw=weight_survey], nq(10)
xtile full_dec_rev_weight=turnover [fw=weight_survey], nq(10)


*Create deciles separately by sector

xtile decile_wbill_T=wbill_tot_tot if tradeable3==1 & emp_tot_tot>=10, nq(10)
xtile decile_wbill_NT=wbill_tot_tot if tradeable3==0 & emp_tot_tot>=10, nq(10)




gen mig_share=1-dom_share

****************************
* Table 8
* Moment 8: Immigrant share by wage-bill decile
****************************

* Variables: mig_share (= 1 - dom_share = immigrant wage-bill share),
*   decile_wbill (unweighted decile of wbill_tot_tot among emp>=10 firms),
*   decile_wbill_T / decile_wbill_NT (sector-specific deciles)
* Selection: establishments >= 10 employees; full sample then by sector
* Validates that model replicates the positive gradient of immigrant share
*   across the firm wage-bill distribution (Figure C7).
* FDZ: unweighted tabstat shown first (N in stat(count) verifiable);
*   survey-weighted bysort sum follows.

*FDZ: table...stat() replaced for Stata 16 compatibility

* mig_share = (wbill_tot_tot - wbill_german_tot) / wbill_tot_tot
* FDZ: display unweighted numerator and denominator sums per decile before
* the weighted mean share, so absolute counts are verifiable (Guidelines §4.5).

* --- Tradable sector ---
* Unweighted N and absolute wage-bill sums (numerator + denominator of mig_share)
gen wbill_imm_tot = wbill_tot_tot - wbill_german_tot

tabstat wbill_imm_tot wbill_tot_tot if emp_tot_tot>=10 & tradeable3==1, ///
    by(decile_wbill) stat(sum n) nototal
* Unweighted mean share (N verifiable via count above)
tabstat mig_share if emp_tot_tot>=10 & tradeable3==1, by(decile_wbill) stat(mean count) nototal
* Survey-weighted mean share
tabstat mig_share [fw=weight_survey] if emp_tot_tot>=10 & tradeable3==1, by(decile_wbill) stat(mean) nototal

* --- Non-tradable sector ---
tabstat wbill_imm_tot wbill_tot_tot if emp_tot_tot>=10 & tradeable3==0, ///
    by(decile_wbill) stat(sum n) nototal
tabstat mig_share if emp_tot_tot>=10 & tradeable3==0, by(decile_wbill) stat(mean count) nototal
tabstat mig_share [fw=weight_survey] if emp_tot_tot>=10 & tradeable3==0, by(decile_wbill) stat(mean) nototal





log close
