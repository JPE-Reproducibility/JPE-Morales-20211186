cap log close
log using "${log}/12_epsilon_firm_characteristics.log", replace

* Epsilon robustness: controlling for firm characteristics x year (Table C5)
* Agostina Brinatti & Nicolas Morales
* Source data: LIAB Longitudinal Model (version 1993-2014), IAB

/*	This dofile tests the robustness of the epsilon estimate to controlling
	for initial firm characteristics interacted with year dummies (Table C5).

	Output in this dofile:
	  Table 1 - Table C5: Robustness of epsilon to firm characteristics

	FDZ note: N (unweighted) reported via stats(N N_clust) in estout.
	  The commented-out block above the active regressions is an earlier
	  specification with continuous trends; it is kept for reference but
	  not used in the paper. Only the active estout block is for submission.
*/

/*

Description here

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
* Table C5: Robustness of epsilon — firm characteristics x year
****************************

* Variables: l_wbill_imm_nat (dep var); l_emp_imm_eff_nat (regressor);
*   instrument: iv_r_shift_sharew_o_f
* Additional FE per column: baseline / exp_sh_03 / l_emp_tot_03 /
*   emp_sh_coll_03 / premium_03 (each interacted with year dummies)
* Selection: epsilon sample (sample_epsilon==1)
* Implied epsilon reported via nlcom for each column.
* N (unweighted) reported via stats(N N_clust) in estout.

****Table C5: Robustness of epsilon when controlling for covariates

ivreghdfe   l_wbill_imm_nat (l_emp_imm_eff_nat = iv_r_shift_sharew_o_f ) if sample_epsilon==1,  absorb(betnr rt_fe kt_fe) cluster(ind_labormkt) 
estimates store IV_bsl
nlcom (r21: 1 / (1-_b[l_emp_imm_eff_nat]) ), post 

ivreghdfe   l_wbill_imm_nat (l_emp_imm_eff_nat = iv_r_shift_sharew_o_f )  if sample_epsilon==1,  absorb(betnr rt_fe kt_fe c.exp_sh_03#i.jahr) cluster(ind_labormkt) 
estimates store exp_sh_03
nlcom (r21: 1 / (1-_b[l_emp_imm_eff_nat]) ), post 

ivreghdfe   l_wbill_imm_nat (l_emp_imm_eff_nat = iv_r_shift_sharew_o_f )  if sample_epsilon==1,  absorb(betnr rt_fe kt_fe c.l_emp_tot_03#i.jahr) cluster(ind_labormkt) 
estimates store l_emp_tot_03
nlcom (r21: 1 / (1-_b[l_emp_imm_eff_nat]) ), post 

ivreghdfe   l_wbill_imm_nat (l_emp_imm_eff_nat = iv_r_shift_sharew_o_f ) if sample_epsilon==1,  absorb(betnr rt_fe kt_fe c.emp_sh_coll_03#i.jahr ) cluster(ind_labormkt) 
estimates store emp_sh_coll_03
nlcom (r21: 1 / (1-_b[l_emp_imm_eff_nat]) ), post 

ivreghdfe   l_wbill_imm_nat (l_emp_imm_eff_nat = iv_r_shift_sharew_o_f )  if sample_epsilon==1,  absorb(betnr rt_fe kt_fe c.premium_03#i.jahr) cluster(ind_labormkt) 
estimates store premium_03
nlcom (r21: 1 / (1-_b[l_emp_imm_eff_nat]) ), post 

estout IV_bsl exp_sh_03 l_emp_tot_03 emp_sh_coll_03 premium_03, varlabels(_cons \_cons)  cells(b(star) se ) starlevels( * 0.10 ** 0.05 *** 0.010) stats(N N_clust)
eststo clear
 
log close



