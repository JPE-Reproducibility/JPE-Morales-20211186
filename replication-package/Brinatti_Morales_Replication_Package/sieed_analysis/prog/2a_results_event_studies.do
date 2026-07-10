********************************************************************************
* 2a_results_event_studies.do
*
* Purpose:
*   Estimates the event study regression (equation 1 of the paper) that
*   identifies the causal effect of Germany's 2011 labor market opening to
*   EU New Member State (NMS) nationals. The identifying assumption is that,
*   absent the policy change, the hiring of NMS nationals would have followed
*   the same trend as hiring of non-EU European nationals (the control group).
*   The regression also recovers the differential response of small vs. large
*   establishments, which is the key evidence for fixed costs of hiring
*   immigrants. See Section 3.3.2 and Appendix A.5.
*
*   Specifically, this file produces:
*     - Figure 2:          Coefficients beta^L_tau and beta^SME_tau from
*                          equation (1): event-study paths for large and small
*                          establishments, estimated via lincom
*     - Appendix Figure A8: Baseline event study (pooled: beta_tau without
*                          size interaction)
*     - Appendix Table A3:  DiD estimates with alternative outcomes (new hires,
*                          new entrants, immigrant share) and finer size bins
*     - Appendix Table A4:  DiD estimates on alternative samples (full sample,
*                          non-hirers in 2005, firms >10 employees)
*     - Appendix Table A5:  DiD estimates with alternative fixed effect
*                          structures (column 1 baseline through column 4
*                          with origin-time FE)
*
*
* Inputs:
*   ${data}/firm_level_sieed.dta        - Firm-year panel from 1a
*   ${data}/local_labor_market.dta      - Kreis-to-local labor market crosswalk
*                                         from 1b
*
* Outputs:
*   Regression results printed to log file and displayed via esttab.
*   The lincom output for Figure 2 gives the point estimates and standard errors
*   for the small-firm coefficients (beta^SME_tau = theta_tau + beta^L_tau).
********************************************************************************

clear
set seed 1234

log using "${log}/2a_results_event_studies.log", replace


****************************Analysis on individual hiring countries****************


use "${data}/firm_level_sieed.dta", clear



****************************************

* Retain only the variables needed for the event study to keep the dataset
* manageable. The key outcome variables are employment counts of NMS nationals
* (emp_eu_2004) and control-group nationals (emp_europe_non_eu), normalized
* by firm total employment in 2010 in the regressions below.
keep emp_tot emp_imm emp_nat emp_eu_2004 emp_europe_non_eu wbill_tot wbill_imm wbill_nat betnr jahr w93_3_gen ao_kreis emp_new_hire_eu_2004 emp_new_hire_europe_non_eu emp_new_ent_eu_2004 emp_new_ent_europe_non_eu w93_3_gen ao_kreis charact_college_* charact_frau_* charact_age_*

tempfile firm_data
save `firm_data', replace


keep betnr jahr emp_eu_2004 emp_europe_non_eu emp_new_hire_eu_2004 emp_new_hire_europe_non_eu emp_new_ent_eu_2004 emp_new_ent_europe_non_eu charact_college_* charact_frau_* charact_age_*

* Reshape from wide (one row per firm-year) to long (one row per firm-year-
* origin group) so that treated (NMS, eu_2004) and control (non-EU Europe,
* europe_non_eu) observations are stacked. This structure is needed to absorb
* origin-group x firm fixed effects in equation (1).
reshape long emp_ emp_new_hire_ emp_new_ent_ charact_college_ charact_frau_ charact_age_, i(betnr jahr) j(treated) string


merge m:1 betnr jahr using `firm_data'


*Additional data cleaning and variable generation

* Construct two-digit industry codes from the three-digit WS93 classification.
* Adjacent three-digit codes are collapsed to a single two-digit group so that
* the industry fixed effects are not too granular for the sample size.
gen ind_2dig=floor(w93_3_gen/10)

replace ind_2dig=1 if ind_2dig>=1 & ind_2dig<=5
replace ind_2dig=10 if ind_2dig>=10 & ind_2dig<=14
replace ind_2dig=15 if ind_2dig>=15 & ind_2dig<=16
replace ind_2dig=17 if ind_2dig>=17 & ind_2dig<=19
replace ind_2dig=23 if ind_2dig>=23 & ind_2dig<=24
replace ind_2dig=29 if ind_2dig>=29 & ind_2dig<=30
replace ind_2dig=37 if ind_2dig>=37 & ind_2dig<=41
replace ind_2dig=65 if ind_2dig>=65 & ind_2dig<=67


* Tradable sector indicator: manufacturing (WS93 154-366), professional services
* (721-744), and wholesale trade (501-517), consistent with the paper's
* tradable/non-tradable classification described in Section 2.
gen tradeable3=((w93_3_gen>=154 & w93_3_gen<=366) | (w93_3_gen>=721 & w93_3_gen<=744) | (w93_3_gen>=501 & w93_3_gen<=517))


* Some three-digit WS93 codes span both the tradable and non-tradable
* classification. Creating an interaction group ensures establishments in those
* codes are assigned consistently with their actual tradability status.

* We have two 2 digit industries that are both T and NT. To be consistent with the model, we redifine the classification as follows:

egen ind_2dig_aux 	= group(ind_2dig tradeable3) 
drop ind_2dig 
rename ind_2dig_aux ind_2dig



* Merge the local labor market crosswalk (created in 1b) to construct
* local labor market x year fixed effects (local_labor_time).
merge m:1 ao_kreis using "${data}/local_labor_market.dta" , generate(merge2)  
drop if merge2==2
drop merge2


rename local_labor local_labor11

* Construct all fixed-effect group identifiers used in the regressions.
* firm_origin  = origin-group x establishment FE (absorbs FE_o,j in eq. 1)
* firm_time    = establishment x year FE (absorbs FE_j,t in eq. 1)
* origin_time  = origin-group x year FE (used in robustness, Table A5 col. 4)
* district_time = district x year FE (additional geography control)
* clusters_g   = establishment cluster identifier for standard error clustering
egen industry_time 		= group(ind_2dig jahr)
egen local_labor_time 	= group(local_labor11 jahr)
egen industry_local_time=group(ind_2dig ao_kreis jahr)
egen district_time 		= group(ao_kreis jahr)
egen clusters_g 		= group(betnr) 



* Employment in 2010 (base year) used to normalize the outcome variable
* (employment_relative = emp_ / emp_tot_2010) as in equation (1).
gen emp_firm_2010_1=emp_tot if jahr==2010
bysort betnr: egen emp_tot_2010=mean(emp_firm_2010_1)

gen emp_firm_2006_1=emp_tot if jahr==2006
bysort betnr: egen emp_tot_2006=mean(emp_firm_2006_1)


* Outcome variables:
*   employment_relative     : NMS (or control) employment / base-year total emp
*   employment_int          : indicator = 1 if firm hires from origin group
*   lemployment             : log of (1 + employment count)
*   imm_share               : origin-group employment / total immigrant employment
*   *_new / *_ent variants  : same outcomes for new hires and labor market entrants
gen employment_relative=emp_/emp_tot_2010
gen employment_int=(emp_>0)
gen lemployment=log(1+emp_)
gen imm_share=emp_/emp_imm


gen employment_relative_new=emp_new_hire_/emp_tot_2010
gen employment_relative_new06=emp_new_hire_/emp_tot_2006

gen employment_int_new=(emp_new_hire_>0)
gen lemployment_new=log(1+emp_new_hire_)


gen employment_relative_ent=emp_new_ent_/emp_tot_2010
gen employment_relative_ent06=emp_new_ent_/emp_tot_2006

gen employment_int_ent=(emp_new_ent_>0)
gen lemployment_ent=log(1+emp_new_ent_)



* Treatment indicator: eu_2004==1 for NMS nationals (the treated group);
* eu_2004==0 for non-EU European nationals (the control group).
gen eu_2004=(treated=="eu_2004")

egen firm_origin=group(betnr eu_2004)
egen firm_time=group(betnr jahr)
egen origin_time=group(eu_2004 jahr)


* hire_2006 flags establishments that had any NMS or control-group employment
* in 2005 (the year before the SIEED panel begins). The baseline sample is
* restricted to hire_2006==0 to focus on the extensive margin response,
* i.e., establishments that had not yet established a hiring channel for either
* group before the policy change.
gen hire_2006_1=(emp_>0 & emp_!=. & jahr==2005)
bysort betnr: egen hire_2006=max(hire_2006_1)


gen hire_in_period=(emp_>0 & emp_!=.)
bysort betnr jahr: egen max_hire_in_period=max(hire_in_period)



gen post_period=(jahr>=2011 & jahr<=2018)


* Four establishment size groups based on 2010 employment, used to estimate
* the heterogeneous response by firm size (Figure 2 and Table A3):
*   bsize_1: fewer than 30 employees (smallest)
*   bsize_2: 30-99 employees
*   bsize_3: 100-199 employees
*   bsize_4: 200+ employees (large; the omitted group in the main specification)
* In the main specification, SME is defined as bsize_1 + bsize_2 + bsize_3
* (fewer than 200 employees), consistent with the paper's SME definition.
gen bsize_bin_2010=.
replace bsize_bin_2010=1 if emp_tot_2010<30
replace bsize_bin_2010=2 if emp_tot_2010>=30 & emp_tot_2010<100
replace bsize_bin_2010=3 if emp_tot_2010>=100 & emp_tot_2010<200
replace bsize_bin_2010=4 if emp_tot_2010>=201 & emp_tot_2010!=.


gen bsize_1=(bsize_bin_2010==1)
gen bsize_2=(bsize_bin_2010==2)
gen bsize_3=(bsize_bin_2010==3)
gen bsize_4=(bsize_bin_2010==4)

gen post_treat=post_period*eu_2004

gen post_1=post_period*bsize_1
gen post_2=post_period*bsize_2
gen post_3=post_period*bsize_3
gen post_4=post_period*bsize_4

gen post_treat_1=post_period*bsize_1*eu_2004
gen post_treat_2=post_period*bsize_2*eu_2004
gen post_treat_3=post_period*bsize_3*eu_2004
gen post_treat_4=post_period*bsize_4*eu_2004

gen treated_size=eu_2004*bsize_4


* Year x treatment interactions for the event study specification.
* treat_[x]    : NMS indicator interacted with year x (gives beta^L_tau when
*                bsize_4==1 is the reference group, i.e., large firms)
* treat_b4_[x] : additional interaction with large-firm indicator (bsize_4)
*                gives the extra effect for large firms, so that lincom
*                treat_[x]+treat_b4_[x] recovers beta^SME_tau for small firms.
forval x=2006/2018 {
	
	
	gen treat_`x'=eu_2004*(jahr==`x')
	gen treat_b4_`x'=eu_2004*(jahr==`x')*bsize_4
	
	
}


*-------------------------------------------------------------------------------
* Appendix Figure A8: Baseline event study (pooled firms)
*
* Estimates beta_tau from equation (1) without firm size interactions, pooling
* all firm sizes. Confirms that NMS hiring increased significantly only after
* 2011 and that pre-trends are flat. Output is stored in eststo y2 and
* printed via esttab.
*-------------------------------------------------------------------------------

*Figure A8 - baseline event study

quietly reghdfe employment_relative treat_2006 treat_2007 treat_2008 treat_2009 treat_2011 treat_2012 treat_2013 treat_2014 treat_2015 treat_2016 treat_2017 treat_2018 if jahr>=2006 & emp_tot_2010!=. & hire_2006==0, absorb(firm_origin firm_time) cluster(betnr)
eststo y2

esttab y2, se nocons unstack star(* 0.10 ** 0.05  *** 0.01)
cap drop _est*


  
*-------------------------------------------------------------------------------
* Figure 2: Event study with size breakdown
*
* Adds triple interactions (treat_b4_[x]) to recover both the large-firm
* path (beta^L_tau) and, via lincom, the small-firm path (beta^SME_tau).
* The lincom loop prints the point estimate and standard error of
* beta^SME_tau = beta^L_tau + theta_tau for each post-treatment year.
*-------------------------------------------------------------------------------

*Figure 2: Event study with breakdown by size


quietly reghdfe employment_relative treat_2006 treat_2007 treat_2008 treat_2009 treat_2011 treat_2012 treat_2013 treat_2014 treat_2015 treat_2016 treat_2017 treat_2018 treat_b4_2006 treat_b4_2007 treat_b4_2008 treat_b4_2009 treat_b4_2011 treat_b4_2012 treat_b4_2013 treat_b4_2014 treat_b4_2015 treat_b4_2016 treat_b4_2017 treat_b4_2018 if jahr>=2006 & emp_tot_2010!=. & hire_2006==0, absorb(firm_origin firm_time) cluster(betnr)
eststo y4


esttab y4, se nocons unstack star(* 0.10 ** 0.05  *** 0.01)
cap drop _est*



*Calculate standard error of coefficients for Figure 2
* Re-run the same regression (not quietly) to recover e(N) and then use
* lincom to construct beta^SME_tau and its standard error for each year.
* The printed output gives the data points and confidence intervals plotted
* in Figure 2 for small establishments.

quietly reghdfe employment_relative treat_2006 treat_2007 treat_2008 treat_2009 treat_2011 treat_2012 treat_2013 treat_2014 treat_2015 treat_2016 treat_2017 treat_2018 treat_b4_2006 treat_b4_2007 treat_b4_2008 treat_b4_2009 treat_b4_2011 treat_b4_2012 treat_b4_2013 treat_b4_2014 treat_b4_2015 treat_b4_2016 treat_b4_2017 treat_b4_2018 if jahr>=2006 & emp_tot_2010!=. & hire_2006==0, absorb(firm_origin firm_time) cluster(betnr)

local nobs=e(N)

foreach x in 2006 2007 2008 2009 2011 2012 2013 2014 2015 2016 2017 2018 {
	
	dis "Number of observations used in calculation below: `nobs'" 
	lincom _b[treat_`x']+_b[treat_b4_`x']

}




*-------------------------------------------------------------------------------
* Appendix Tables A3-A5: Robustness checks on the DiD estimates
*
* All three tables use a collapsed DiD specification (post_treat and
* interactions with size bins) rather than the full event-study path, for
* conciseness. The outcome, sample, and fixed effects vary across tables.
*-------------------------------------------------------------------------------

*****Appendix Tables*****

*-------------------------------------------------------------------------------
* Table A3: Alternative outcomes and size breakdowns
*
* Panel 1 (relative to the largest group, bsize_4):
*   Uses post_treat and its interaction with bsize_4 (post_treat_4), so the
*   coefficient on post_treat gives the average DiD for SMEs (<200 employees)
*   and post_treat_4 gives the differential effect for large firms.
*
* Panel 2 (relative to the bottom three groups):
*   Uses post_treat and interactions with bsize_1, bsize_2, bsize_3, so the
*   baseline effect is for large firms (bsize_4) and interactions recover
*   the differential response of each SME size category.
*
* Outcomes: total employment, new hires, new labor market entrants, immigrant
* share -- corresponding to columns 1-4 of Table A3.
*-------------------------------------------------------------------------------

*Table A3: Alternative outcomes and size breakdowns

local i=1

foreach outcome in employment_relative employment_relative_new employment_relative_ent  imm_share {
	
quietly reghdfe `outcome' post_treat  post_4 post_treat_4 if jahr>=2006 & emp_tot_2010!=. & hire_2006==0, absorb(firm_origin firm_time) cluster(betnr)
eststo m`i'

local i=`i'+1	
	
}

esttab m1 m2 m3 m4, se nocons unstack star(* 0.10 ** 0.05  *** 0.01)
cap drop _est*




local i=1

foreach outcome in employment_relative employment_relative_new employment_relative_ent  imm_share {
	
quietly reghdfe `outcome' post_treat post_1 post_2 post_3 post_treat_1 post_treat_2 post_treat_3 if jahr>=2006 & emp_tot_2010!=. & hire_2006==0, absorb(firm_origin firm_time) cluster(betnr)
eststo m`i'

local i=`i'+1	
	
}

esttab m1 m2 m3 m4, se nocons unstack star(* 0.10 ** 0.05  *** 0.01)
cap drop _est*




*-------------------------------------------------------------------------------
* Table A4: Robustness to alternative samples
*
* Varies the sample restriction:
*   Column 1: Full sample (all firms regardless of base-year hiring)
*   Column 2: Baseline -- non-hirers of NMS/control group in 2005
*   Column 3: Firms with 10+ employees in 2010
*   Column 4: Intersection of columns 2 and 3
*-------------------------------------------------------------------------------

*Table A4: Robustness to alternative samples

local i=1

foreach rest in "" "& hire_2006==0" "& emp_tot_2010>=10" "& emp_tot_2010>=10 & hire_2006==0" {
	
quietly reghdfe employment_relative post_treat  post_4 post_treat_4 if jahr>=2006 & emp_tot_2010!=. `rest', absorb(firm_origin firm_time) cluster(betnr)
eststo m`i'

local i=`i'+1	
	
}


esttab m1 m2 m3 m4, se nocons unstack star(* 0.10 ** 0.05  *** 0.01)
cap drop _est*




*-------------------------------------------------------------------------------
* Table A5: Robustness to alternative fixed effects
*
* Varies the fixed effect structure while holding the sample fixed (baseline):
*   Column 1: firm_origin + firm_time (baseline, equation 1)
*   Column 2: firm_origin + industry_time + local_labor_time
*             (replaces establishment x year FE with separate industry-year
*              and local labor market-year FE)
*   Column 3: firm_origin + year (minimal time FE)
*   Column 4: firm_origin + firm_time + origin_time
*             (adds origin-group x year FE to absorb aggregate trends in
*              immigration from each group; Table A5 column 4)
*-------------------------------------------------------------------------------

*Table A5: Robustness to alternative fixed effects

local i=1

foreach fixed in "firm_origin firm_time"  "firm_origin industry_time local_labor_time" "firm_origin jahr" "firm_origin firm_time origin_time" {
	
quietly reghdfe employment_relative post_treat  post_4 post_treat_4 if jahr>=2006 & emp_tot_2010!=. & hire_2006==0, absorb(`fixed') cluster(betnr)
eststo m`i'

local i=`i'+1	
	
}


esttab m1 m2 m3 m4, se nocons unstack star(* 0.10 ** 0.05  *** 0.01)
cap drop _est*




log close
