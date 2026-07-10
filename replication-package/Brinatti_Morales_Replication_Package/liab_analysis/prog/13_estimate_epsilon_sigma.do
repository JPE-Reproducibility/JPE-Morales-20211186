cap log close
log using "${log}/13_estimate_epsilon_sigma.log", replace

* Epsilon vs. sigma: bootstrap distribution and p-value (Section 5.3)
* Agostina Brinatti & Nicolas Morales
* Source data: LIAB Longitudinal Model (version 1993-2014), IAB

/*	This dofile computes the joint bootstrap distribution of epsilon and
	sigma and tests H0: epsilon < sigma (Section 5.3 of the paper).
	sigma_d is inferred from average markups of non-tradable firms (eq. 17).
	sigma_x is inferred from exporters' markdowns in the tradable sector.

	Output in this dofile:
	  Table 1 - Section 5.3: Point estimates of epsilon, sigma_d, sigma_x,
	            sigma_avg and their components (printed via sum before bootstrap)

	Saved dataset:
	  ${data}/epsilon_sigma_bootstrapsample.dta — 5,000 bootstrap draws
	  (used in dofile 15 for Figure C1 and the p-value cited in text)

	FDZ note: The sum command before the bootstrap loop prints the point
	  estimates for Table 1. The bootstrap loop itself produces no output;
	  all CIs and p-values are computed in dofile 15.
*/


/*

Input datasets:
(i)  data_imm_effective_snap_draft: effective units of labor using the estimated kappa
(ii) "${data}/individual_level_sieed_notw0.dta": firm-year level with the outcome variable, and the instrument

Output dataset:
(i) "${data}/bootstrapsample.dta" 

*This dofile perform the statistical test of wether epsilon> sigma, and bootstrap the standard errors

*/

clear

set more off
set matsize 10000
set linesize 255
set seed 1234

capture adopath++ ${prog}




use "${data}/dataset_epsilon_estimation.dta", clear

*Bring the immigrant in terms of efficient units computed using the estimated kappa

merge 1:1 betnr jahr using "${data}/dataset_immigrant_effective_units.dta" , keepusing(emp_imm_eff)
drop _merge

gen l_emp_imm_eff_nat=log(emp_imm_eff/nemp_nat_ft)


*Bring data of total wage bill from the dataset used to compute the markup

preserve 

drop tentgelt wemp_ft

merge 1:m betnr jahr using "${data}/establishment_level_liab.dta", keepusing( wbill_tot_tot ) 

gen mbill_tot_tot= turnover*(int_inputs/100)
gen markup1 = turnover/(wbill_tot_tot + mbill_tot_tot)

keep betnr jahr markup1 mbill_tot_tot wbill_tot_tot

duplicates drop 

tempfile temp
save `temp'
restore 

	merge m:1 betnr jahr using `temp'
	drop _merge 

	
gen markdown1 = 1/markup1

rename nemp_ft emp_tot_tot


*Bring the id for the firms in the LIAB sample of our paper 

merge 1:1 betnr jahr using "${data}/sample_epsilon_estimation.dta" 
drop _merge



*-------------------------------------------------------
* Distribution of epsilon, sigma and the difference 
*-------------------------------------------------------

keep if  sample_epsilon==1 

rename betnr betnr2

tsset  betnr2 jahr

local ntot=5000


*Estimate of epsilon /*0.*/
qui ivreghdfe l_wbill_imm_nat ( l_emp_imm_eff_nat = iv_r_shift_sharew_o_f)   if sample_epsilon==1, absorb(betnr rt_fe kt_fe) cluster(ind_labormkt) 
		gen epsilon    =  1/(1-_b[l_emp_imm_eff_nat])


*Estimate sigma for all firms		
qui ivreghdfe   markup1 if sample_epsilon==1  /**/
		gen sigma    = _b[_cons]/(_b[_cons] - 1) /**/

*Estimate sigma	of non tradeable
qui ivreghdfe  markup1 		if sample_epsilon==1 & tradeable3==0
		gen markup1_d =  _b[_cons] /**/
		gen sigma_d   = _b[_cons]/(_b[_cons] - 1) /**/
	
*Estimate the markdown of non-exporters	and exporters in the tradeable sector

qui ivreghdfe  markdown1 if sample_epsilon==1 & (exports_foreign==0 | missing(exports_foreign)) &  tradeable3==1
	gen markdown1_d =  _b[_cons]

qui ivreghdfe  markdown1 if sample_epsilon==1 & (exports_foreign>0 & exports_foreign!=.) &  tradeable3==1
	gen markdown1_e =  _b[_cons]
	

	*Estimate the average export share in the tredeable sector for exporters

qui ivreghdfe exports_foreign if sample_epsilon==1 & (exports_foreign>0 & exports_foreign!=.) & tradeable3==1 /**/
 	gen export_share =  _b[_cons]/100	
	
		
*Estimate the markdown in RoW 

	gen markdown1_x =  ( markdown1_e - (1-export_share) * markdown1_d ) / export_share

	
*Estimate sigma_x and average sigma
	
	gen sigma_x = 1/(1-markdown1_x)
	gen sigma_avg = (1-export_share) * sigma_d + export_share * sigma_x
	
	
****************************
* Table 1
* Section 5.1: Point estimates of epsilon, sigma components
****************************

* Variables: epsilon (2SLS), sigma (all firms), markup1_d (NT markup),
*   sigma_d (NT sigma), markdown1_d (non-exporters T), markdown1_e
*   (exporters T), export_share, markdown1_x (RoW markdown),
*   sigma_x (RoW sigma), sigma_avg (weighted average)
* Selection: epsilon sample (sample_epsilon==1); survey-weighted means
* Table provides the point estimates used in Section 5.1 and as
*   inputs for the bootstrap in this dofile and dofile 15.
* N (unweighted) for each sub-sample: see count commands above.

sum  epsilon sigma markup1_d sigma_d markdown1_d markdown1_e export_share markdown1_x sigma_x sigma_avg
drop epsilon sigma markup1_d sigma_d markdown1_d markdown1_e export_share markdown1_x sigma_x sigma_avg


*-------------------------------------------------------
* Distribution of epsilon, sigma and the difference 
*Bootstrap of 5000 repetitions for standard errors - supressing log to avoid excessive output
*-------------------------------------------------------

log off

forvalues x = 1/`ntot' { 

preserve

	display `x'
	
	set seed `x'
	
	bsample, cl(betnr2) idcl(betnr) 
	

		* OLS estimate
		
		qui ivreghdfe   l_wbill_imm_nat  l_emp_imm_eff_nat  if sample_epsilon==1, absorb(betnr rt_fe kt_fe) 
		gen epsilon_RF_OLS = _b[l_emp_imm_eff_nat]
		gen epsilon_OLS    = 1/(1-_b[l_emp_imm_eff_nat])	
		

		* Estimate of epsilon
		
		qui ivreghdfe   l_wbill_imm_nat ( l_emp_imm_eff_nat = iv_r_shift_sharew_o_f) if sample_epsilon==1, absorb(betnr rt_fe kt_fe) 
		gen epsilon_RF = _b[l_emp_imm_eff_nat]
		gen epsilon    = 1/(1-_b[l_emp_imm_eff_nat])
		gen count_2sls=e(N)
				
		* Estimate of sigma for all

		qui ivreghdfe   markup1 if sample_epsilon==1 
				gen sigma    = _b[_cons]/(_b[_cons] - 1)
	

		*Estimate sigma	for non tradeable 
		qui ivreghdfe  markup1 if sample_epsilon==1 & tradeable3==0
				gen markup1_d =  _b[_cons] /**/
				gen sigma_d   = _b[_cons]/(_b[_cons] - 1) /**/
		
		*Estimate the markdown of non-exporters	and exporters in the tredeable

		qui ivreghdfe  markdown1 if sample_epsilon==1 & (exports_foreign==0 | missing(exports_foreign)) &  tradeable3==1
			gen markdown1_d =  _b[_cons]

		qui ivreghdfe  markdown1 if sample_epsilon==1 & (exports_foreign>0 & exports_foreign!=.) &  tradeable3==1
			gen markdown1_e =  _b[_cons]
			
				
		*Estimate the average export share for exporters in the tradeable

		qui ivreghdfe exports_foreign	if sample_epsilon==1 & (exports_foreign>0 & exports_foreign!=.) & tradeable3==1 /**/
			gen export_share =  _b[_cons]/100		
	
			
		*Estimate the markdown in RoW 

			gen markdown1_x =  ( markdown1_e - (1-export_share) * markdown1_d ) / export_share

		*Estimate sigma_x and average sigma

			gen sigma_x = 1/(1-markdown1_x)
			gen sigma_avg = (1-export_share) * sigma_d + export_share * sigma_x	
	

		* Compute the different		
		
		gen diff 	= epsilon - sigma
		gen diff_d 	= epsilon - sigma_d
		gen diff_avg= epsilon - sigma_avg 
		
		gen nsample =`x'
		
		keep epsilon epsilon_RF sigma sigma_d sigma_x sigma_avg diff* nsample diff diff_d diff_avg epsilon_RF_OLS epsilon_OLS count_2sls
		keep if _n==1
		
		
		save "${data}/coeff`x'", replace
		
restore

}


use "${data}/coeff1.dta", clear

forvalues y=2/`ntot'{

append using "${data}/coeff`y'"

}

log on

save "${data}/epsilon_sigma_bootstrapsample.dta",replace


* Clean 

forvalues y=1/`ntot'{

erase "${data}/coeff`y'.dta"

}



log close
