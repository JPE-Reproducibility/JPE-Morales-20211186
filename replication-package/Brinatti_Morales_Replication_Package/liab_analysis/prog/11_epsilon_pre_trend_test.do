cap log close
log using "${log}/11_epsilon_pre_trend_test.log", replace

* Epsilon pre-trend test: lagged outcome regressions (Table C3)
* Agostina Brinatti & Nicolas Morales
* Source data: LIAB Longitudinal Model (version 1993-2014), IAB

/*	This dofile tests whether the shift-share instrument predicts lagged
	outcomes (pre-trend check). An insignificant coefficient supports the
	identifying assumption that instrument variation is exogenous to
	pre-existing firm trends.

	Output in this dofile:
	  Tables 1-5 - Table C3: Pre-trend tests, lags h = 1,...,5

	Saved dataset:
	  ${data}/epsilon_pretrend_bootstrapsample.dta — 5,000 bootstrap draws

	FDZ note: N (unweighted) reported via stats(N N_clust) in estout.
	  The sum command at the end prints the 99% CI bounds for Table C3.
*/

/*

Input datasets:
(i)  data_imm_effective_snap_draft: effective units of labor using the estimated kappa
(ii) "${data}/individual_level_sieed_notw0.dta": firm-year level with the outcome variable, and the instrument

output dataset: 
(i) "${data}/bootstrapsample_pre_trend_snap_draft.dta"

*This dofile perform the pre-trend analysis, and bootstrap the standard errors of each regression

*/

clear

set more off
set matsize 10000
set linesize 255
set seed 1234

capture adopath++ ${prog}



use "${data}/dataset_epsilon_estimation.dta", clear


*Keep firms in sample of epsilon estimation 

merge 1:1 betnr jahr using "${data}/sample_epsilon_estimation.dta" , keepusing(sample_epsilon)
drop _merge


*Bring the immigrant in terms of efficient units computed using the estimated kappa

merge 1:1 betnr jahr using "${data}/dataset_immigrant_effective_units.dta" , keepusing(emp_imm_eff)
drop _merge

* Outcome and regressor variables for the wage regressions 

gen l_emp_imm_eff_nat = log(emp_imm_eff/nemp_nat_ft)

*Outcome variables for Pre trends 
tsset betnr jahr

gen l_wbill_imm_natL1 = L1.l_wbill_imm_nat
gen l_wbill_imm_natL2 = L2.l_wbill_imm_nat
gen l_wbill_imm_natL3 = L3.l_wbill_imm_nat
gen l_wbill_imm_natL4 = L4.l_wbill_imm_nat
gen l_wbill_imm_natL5 = L5.l_wbill_imm_nat

*-------------------------------------------------------------------------------
* Pre-trend test
*-------------------------------------------------------------------------------


****************************
* Table 1
* Table C3: Pre-trend tests — lags h = 0,...,5
****************************

* Variables: l_wbill_imm_nat (lag 0), l_wbill_imm_natL1-L5 (outcome
*   lagged 1-5 years); l_emp_imm_eff_nat (regressor, as in Table C1)
* Instrument: iv_r_shift_sharew_o_f (shift-share, same as Table C1)
* Selection: epsilon sample (sample_epsilon == 1)
* FE and SE: same as Table C1 (betnr, rt_fe, kt_fe; clustered at ind_labormkt)
* Table tests whether the instrument predicts outcomes prior to the sample
*   period. Insignificant coefficients at lags 1-5 support identifying assumption.
* N (unweighted) reported via stats(N N_clust) in estout.

ivreghdfe   l_wbill_imm_nat   ( l_emp_imm_eff_nat = iv_r_shift_sharew_o_f ) if sample_epsilon==1,  absorb(betnr rt_fe kt_fe) cluster(ind_labormkt)
estimates store IV_bsl_L0
ivreghdfe   l_wbill_imm_natL1 ( l_emp_imm_eff_nat = iv_r_shift_sharew_o_f ) if sample_epsilon==1,  absorb(betnr rt_fe kt_fe) cluster(ind_labormkt)
estimates store IV_bsl_L1
ivreghdfe   l_wbill_imm_natL2 ( l_emp_imm_eff_nat = iv_r_shift_sharew_o_f ) if sample_epsilon==1,  absorb(betnr rt_fe kt_fe) cluster(ind_labormkt)
estimates store IV_bsl_L2
ivreghdfe   l_wbill_imm_natL3 ( l_emp_imm_eff_nat = iv_r_shift_sharew_o_f ) if sample_epsilon==1,  absorb(betnr rt_fe kt_fe) cluster(ind_labormkt)
estimates store IV_bsl_L3
ivreghdfe   l_wbill_imm_natL4 ( l_emp_imm_eff_nat = iv_r_shift_sharew_o_f ) if sample_epsilon==1,  absorb(betnr rt_fe kt_fe) cluster(ind_labormkt)
estimates store IV_bsl_L4
ivreghdfe   l_wbill_imm_natL5 ( l_emp_imm_eff_nat = iv_r_shift_sharew_o_f ) if sample_epsilon==1,  absorb(betnr rt_fe kt_fe) cluster(ind_labormkt)
estimates store IV_bsl_L5

estout IV_bsl_L*, varlabels(_cons \_cons)  cells(b(star) se ) starlevels( * 0.10 ** 0.05 *** 0.010) stats(N N_clust)
eststo clear	


*-------------------------------------------------------------------------------
* Bootstrap  of 5000 repetitions for standard errors - supressing log to avoid excessive output
*-------------------------------------------------------------------------------

log off

keep if  sample_epsilon==1 

rename betnr betnr2

tsset  betnr2 jahr

local ntot=5000

*Estimate 

forvalues x = 1/`ntot' { 

	preserve

	display `x'
	
	set seed `x'
	
	bsample, cl(betnr2) idcl(betnr) 

	* Wrap each regression; skip draw if instrument is degenerate
	local skip 0

	cap qui ivreghdfe   l_wbill_imm_natL1 ( l_emp_imm_eff_nat = iv_r_shift_sharew_o_f ) if sample_epsilon==1,  absorb(betnr rt_fe kt_fe)
	if _rc != 0 {
		local skip 1
	}
	else {
		gen epsilon_RF1 = _b[l_emp_imm_eff_nat]
		gen epsilon_1   = 1 / (1-_b[l_emp_imm_eff_nat])
	}

	cap qui ivreghdfe   l_wbill_imm_natL2 ( l_emp_imm_eff_nat = iv_r_shift_sharew_o_f ) if sample_epsilon==1,  absorb(betnr rt_fe kt_fe)
	if _rc != 0 {
		local skip 1
	}
	else {
		gen epsilon_RF2 = _b[l_emp_imm_eff_nat]
		gen epsilon_2   = 1 / (1-_b[l_emp_imm_eff_nat])
	}

	cap qui ivreghdfe   l_wbill_imm_natL3 ( l_emp_imm_eff_nat = iv_r_shift_sharew_o_f ) if sample_epsilon==1,  absorb(betnr rt_fe kt_fe)
	if _rc != 0 {
		local skip 1
	}
	else {
		gen epsilon_RF3 = _b[l_emp_imm_eff_nat]
		gen epsilon_3   = 1 / (1-_b[l_emp_imm_eff_nat])
	}

	cap qui ivreghdfe   l_wbill_imm_natL4 ( l_emp_imm_eff_nat = iv_r_shift_sharew_o_f ) if sample_epsilon==1,  absorb(betnr rt_fe kt_fe)
	if _rc != 0 {
		local skip 1
	}
	else {
		gen epsilon_RF4 = _b[l_emp_imm_eff_nat]
		gen epsilon_4   = 1 / (1-_b[l_emp_imm_eff_nat])
	}

	cap qui ivreghdfe   l_wbill_imm_natL5 ( l_emp_imm_eff_nat = iv_r_shift_sharew_o_f ) if sample_epsilon==1,  absorb(betnr rt_fe kt_fe)
	if _rc != 0 {
		local skip 1
	}
	else {
		gen epsilon_RF5 = _b[l_emp_imm_eff_nat]
		gen epsilon_5   = 1 / (1-_b[l_emp_imm_eff_nat])
	}

	* Only save iterations where all regressions succeeded
	if `skip' == 0 {
		gen nsample =`x'
		keep epsilon* nsample
		keep if _n==1
		save "${data}/coeff`x'", replace
	}
		
restore

}	


*Generate the dataset 

* Append only the draws that were successfully saved
local first_saved 1
forvalues y=1/`ntot'{
	cap confirm file "${data}/coeff`y'.dta"
	if _rc == 0 {
		if `first_saved' == 1 {
			use "${data}/coeff`y'.dta", clear
			local first_saved 0
		}
		else {
			append using "${data}/coeff`y'"
		}
	}
}
 
log on

 *95% CI for reduced form coefficient 
 
 _pctile epsilon_RF1 , nq(1000)
 gen epsilon_RF1_25 = r(r25)
  _pctile epsilon_RF1 , nq(1000)
 gen epsilon_RF1_975 = r(r975)
  
  
 _pctile epsilon_RF2 , nq(1000)
 gen epsilon_RF2_25 = r(r25)
  _pctile epsilon_RF2 , nq(1000)
 gen epsilon_RF2_975 = r(r975)
  
   _pctile epsilon_RF3 , nq(1000)
 gen epsilon_RF3_25 = r(r25)
  _pctile epsilon_RF3 , nq(1000)
 gen epsilon_RF3_975 = r(r975)
  
   _pctile epsilon_RF4 , nq(1000)
 gen epsilon_RF4_25 = r(r25)
  _pctile epsilon_RF4 , nq(1000)
 gen epsilon_RF4_975 = r(r975)
  

 _pctile epsilon_RF5 , nq(1000)
 gen epsilon_RF5_25 = r(r25)
  _pctile epsilon_RF5 , nq(1000)
 gen epsilon_RF5_975 = r(r975)

 * Print results 
 

****************************
* Table 1 (supplement)
* Table C3: 99% bootstrap CIs for pre-trend coefficients
****************************

* Variables: epsilon_RF1_25 / epsilon_RF1_975 through epsilon_RF5_25 / epsilon_RF5_975
*   (2.5st and 97.5th percentiles of the lag-1 through lag-5 coefficient distribution
*   across 5,000 firm-clustered bootstrap draws)
* N (bootstrap draws): 5,000

 
  tabstat epsilon_RF1_25 epsilon_RF1_975 epsilon_RF2_25 epsilon_RF2_975 epsilon_RF3_25 epsilon_RF3_975 epsilon_RF4_25 epsilon_RF4_975 epsilon_RF5_25 epsilon_RF5_975, c(stat) s(mean n)




 * Save 

save "${data}/epsilon_pretrend_bootstrapsample.dta",replace


* Clean 

forvalues y=1/`ntot'{
	cap erase "${data}/coeff`y'.dta"
}

  
log close 

 