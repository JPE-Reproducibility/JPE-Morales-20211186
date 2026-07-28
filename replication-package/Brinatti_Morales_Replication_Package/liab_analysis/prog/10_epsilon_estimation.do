cap log close
log using "${log}/10_epsilon_estimation.log", replace

* Epsilon estimation: within-firm elasticity of substitution (OLS and 2SLS)
* Agostina Brinatti & Nicolas Morales
* Source data: LIAB Longitudinal Model (version 1993-2014), IAB

/*	This dofile estimates epsilon, the within-firm elasticity of substitution
	between immigrant and native workers (Table C1, Appendix C.2).

	Regression:
	  log(WageBill_imm/WageBill_nat)_jt = beta log(ImmEff/NatEmp)_jt + FE + u
	  epsilon = 1 / (1 - beta_hat)

	Output in this dofile:
	  Table 1 - Table C1: OLS and 2SLS point estimates
	  (99% bootstrap CIs computed and printed below the main table)

	Saved dataset:
	  ${data}/epsilon_baseline_bootstrapsample.dta — 5,000 bootstrap draws

	FDZ note: N (unweighted) reported via stats(N N_clust) in estout.
	  The bootstrap uses 5,000 firm-clustered draws. The sum command at the
	  end of the bootstrap section prints the 99% CI bounds (Table C1 supplement).
*/

/*

Input datasets:
(i)  data_imm_effective_snap_draft: effective units of labor using the estimated kappa
(ii) "${data}/individual_level_sieed_notw0.dta": firm-year level with the outcome variable, and the instrument

*This dofile estimates epsilon

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

gen l_emp_imm_eff_nat=log(emp_imm_eff/nemp_nat_ft)

		
*-------------------------------------------------------------------------------
* Baseline estimate:  
*-------------------------------------------------------------------------------


****************************
* Table 1
* Table C1: OLS and 2SLS estimates of epsilon
****************************

* Variables: l_wbill_imm_nat (log immigrant-to-native wage bill ratio),
*   l_emp_imm_eff_nat (log immigrant CES composite / native employment,
*   constructed using kappa from dofile 9)
* Instrument: iv_r_shift_sharew_o_f (shift-share; weighted by 2003 origin
*   shares and national employment growth rates)
* Selection: epsilon sample (sample_epsilon == 1); 2008-2011,
*   establishments >= 10 employees, revenue available
* FE: establishment (betnr), origin-group x year (rt_fe),
*   industry x year (kt_fe); SE clustered at ind_labormkt
* beta = (epsilon-1)/epsilon; implied epsilon reported via nlcom.
* N (unweighted) reported via stats(N N_clust) in estout.
* 95% bootstrap CIs (5,000 firm-clustered draws) reported below.

*Table C1: Estimates for epsilon

eststo OLS_bsl:     reghdfe   l_wbill_imm_nat l_emp_imm_eff_nat  if sample_epsilon==1, absorb(betnr rt_fe kt_fe) cluster(ind_labormkt)
nlcom (r21: 1 / (1-_b[l_emp_imm_eff_nat]) ), post 

ivreghdfe   l_wbill_imm_nat (l_emp_imm_eff_nat = iv_r_shift_sharew_o_f ) if sample_epsilon==1, absorb(betnr rt_fe kt_fe) cluster(ind_labormkt) 
estimates store IV_bsl

nlcom (r21: 1 / (1-_b[l_emp_imm_eff_nat]) ), post 

estout OLS_bsl IV_bsl, varlabels(_cons \_cons)  cells(b(star) se p) starlevels( * 0.10 ** 0.05 *** 0.010) stats(N N_clust)
eststo clear





*-------------------------------------------------------------------------------
* Bootstrap of 5000 repetitions for standard errors - supressing log to avoid excessive output
*-------------------------------------------------------------------------------


keep if  sample_epsilon==1 

rename betnr betnr2

tsset  betnr2 jahr

local ntot=5000


log off 

*Estimate 

forvalues x = 1/`ntot' { 

	preserve

	display `x'
	
	set seed `x'
	
	bsample, cl(betnr2) idcl(betnr) 

qui reghdfe   l_wbill_imm_nat l_emp_imm_eff_nat  if sample_epsilon==1, absorb(betnr rt_fe kt_fe) cluster(ind_labormkt)
gen epsilon_ols = _b[l_emp_imm_eff_nat]
gen epsilon_1_ols   = 1 / (1-_b[l_emp_imm_eff_nat])

qui ivreghdfe   l_wbill_imm_nat (l_emp_imm_eff_nat = iv_r_shift_sharew_o_f ) if sample_epsilon==1, absorb(betnr rt_fe kt_fe) cluster(ind_labormkt)
gen epsilon_2sls = _b[l_emp_imm_eff_nat]
gen epsilon_2_2sls   = 1 / (1-_b[l_emp_imm_eff_nat])


		gen nsample =`x'
		
		keep epsilon* nsample
		keep if _n==1
		
		
	save "${data}/coeff`x'", replace
		
restore

}	


*Generate the dataset 

use "${data}/coeff1.dta", clear

forvalues y=2/`ntot'{

append using "${data}/coeff`y'"

}


log on
 

 *95% CI for reduced form coefficient 
 
 _pctile epsilon_ols , nq(1000)
 gen epsilon_ols_25 = r(r25)
  _pctile epsilon_ols , nq(1000)
 gen epsilon_ols_975 = r(r975)
  
  
 _pctile epsilon_2sls , nq(1000)
 gen epsilon_2sls_25 = r(r25)
  _pctile epsilon_2sls , nq(1000)
 gen epsilon_2sls_975 = r(r975)
 
 
 
  *95% CI for epsilon 
 
 _pctile epsilon_1_ols , nq(1000)
 gen epsilon_1_ols_25 = r(r25)
  _pctile epsilon_1_ols , nq(1000)
 gen epsilon_1_ols_975 = r(r975)
  
  
 _pctile epsilon_2_2sls , nq(1000)
 gen epsilon_2_2sls_25 = r(r25)
  _pctile epsilon_2_2sls , nq(1000)
 gen epsilon_2_2sls_975 = r(r975)
  

 * Print results 
 

****************************
* Table 1 (supplement)
* Table C1: 99% bootstrap CIs for epsilon — OLS and 2SLS
****************************

* Variables: epsilon_ols_25 / epsilon_ols_975 (2.5 and 97.5 pctile of
*   OLS epsilon distribution across 5,000 bootstrap draws);
*   epsilon_2sls_25 / epsilon_2sls_975 (same for 2SLS)
* N (bootstrap draws): 5,000 firm-clustered resamples

  *sum epsilon_ols_25 epsilon_ols_975 epsilon_2sls_25 epsilon_2sls_975
  tabstat epsilon_ols_25 epsilon_ols_975 epsilon_2sls_25 epsilon_2sls_975 epsilon_1_ols_25 epsilon_1_ols_975 epsilon_2_2sls_25 epsilon_2_2sls_975, c(stat) s(mean n)



 * Save 

save "${data}/epsilon_baseline_bootstrapsample.dta",replace


* Clean 

forvalues y=1/`ntot'{

erase "${data}/coeff`y'.dta"

}







log close

