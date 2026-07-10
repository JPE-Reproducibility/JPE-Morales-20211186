cap log close
log using "${log}/9_kappa_estimation.log", replace

* Kappa estimation: elasticity of substitution across immigrant origin countries
* Agostina Brinatti & Nicolas Morales
* Source data: LIAB Longitudinal Model (version 1993-2014), IAB

/*	This dofile estimates kappa (equation 47, Appendix C.1) and constructs
	the CES composite of immigrant effective labour units used in the epsilon
	regressions (dofiles 10-13).

	Regression (equation 47):
	  log(WageBill_ojt) = beta log(Emp_ojt) + FE_okt + FE_jt + FE_oj + u
	  kappa = 1 / (1 - beta_hat)

	Output in this dofile:
	  Table 1 - Kappa estimate cited in Appendix C.1

	Saved intermediate datasets:
	  ${data}/sample_epsilon_estimation.dta         — sample flag for epsilon
	  ${data}/dataset_immigrant_effective_units.dta — CES composite

	FDZ note: N (unweighted) reported via di after each regression.
*/


/*

Input datasets:
(i) "${data}/dataset_epsilon_estimation.dta": firm-year level used to select the sample following the same criteria than validation regressions
(ii) "${data}/dataset_kappa_estimation.dta": wage and employment data by firm-origin-year used to estimate kappa

Output datasets:
(i) "${data}/dataset_immigrant_effective_units.dta":
(ii) "${data}/sample_epsilon_estimation.dta": the sample of firms that has the same restrictions as in for validation excercises and makes it to the epsilon regression

*This do file estimates kappa and compute the efficient units of immigrant share that will be later used to estimate epsilon 

*/


clear

set more off
set matsize 10000
set linesize 255
set seed 1234

capture adopath++ ${prog}



*-------------------------------------------------------------------------------
* Keep the sample that will be used in the upper nest estimation 
*-------------------------------------------------------------------------------

preserve 

*Firm-level dataset 

use "${data}/dataset_epsilon_estimation.dta", clear

* Restrict the sample in the same way as we do for the validation regressions

keep if jahr>=2008 & jahr<=2011 & min_emp>=10 & count_missrev>=2 & turnover_type==1
gen sample_rev=1

* Keep one observation per firm-year 

duplicates drop betnr jahr, force

* Run the regression to generate the sample that will be included in the

ivreghdfe  l_emp_imm_nat  (l_wbill_imm_nat = iv_r_shift_sharew_o_f )   if sample_rev==1, absorb(betnr rt_fe kt_fe)

gen sample_epsilon=e(sample)

keep sample_epsilon betnr jahr

save "${data}/sample_epsilon_estimation.dta", replace

restore

*-------------------------------------------------------------------------------
* Estimate Kappa
*-------------------------------------------------------------------------------

use "${data}/dataset_kappa_estimation.dta", clear

preserve 

*Drop natives
drop if nation_single==1


*Keep firms in sample of epsilon estimation 

merge m:1 betnr jahr using "${data}/sample_epsilon_estimation.dta" 
drop _merge

keep if sample_epsilon ==1  


*nation_single-betnr-jahr-level data
duplicates drop nation_single betnr jahr w93_3_gen, force 
duplicates drop nation_single betnr jahr, force /*verify no new drop*/

*Fixed effects 
egen id_f_o		= group(betnr nation_single)
egen id_f_t		= group(betnr jahr)
egen id_o_2k_t	= group(nation_single ind_2dig jahr)


****************************
* Table 1
* Kappa estimate — Appendix C.1
****************************

* Variables: l_wemp (log wage bill of origin group o at establishment j in year t),
*   l_emp (log employment of same group); kappa = 1/(1 - beta_hat)
* Selection: Immigrant workers only (nation_single != 1); establishments in the
*   epsilon sample (2008-2011, >= 10 employees, revenue available,
*   sample_epsilon == 1); one observation per origin x establishment x year
* FE: origin x 2-digit-industry x year (id_o_2k_t), establishment x year (id_f_t),
*   origin x establishment (id_f_o); SE clustered at id_f_o
* Table reports beta and implied kappa via nlcom.
* N (unweighted) reported via di after regression.

*Estimation of kappa 

gen l_emp  = log(nemp_oft)
gen l_wemp = log(wemp_oft)

ivreghdfe l_wemp l_emp if sample_epsilon==1, absorb(i.id_o_2k_t   i.id_f_t i.id_f_o) cluster( id_f_o  )
nlcom (r21: 1 / (1-_b[l_emp]) ), post 

quietly ivreghdfe l_wemp l_emp if sample_epsilon==1, absorb(i.id_o_2k_t   i.id_f_t i.id_f_o) cluster( id_f_o  )
local kappa_hat = 1/(1 - _b[l_emp] )

restore 



*-------------------------------------------------------------------------------
* Create immigrant labor bundle
*-------------------------------------------------------------------------------

preserve 

drop if nation_single==1

egen okt_fe=group(nation_single ind_2dig jahr)
egen ft_fe=group(betnr jahr) 

bysort nation_single betnr jahr: egen avg_wage_ojt=mean(tentgelt)
bysort nation_single betnr jahr: egen emp_ojt=sum(1)

duplicates drop betnr nation_single  jahr, force

gen lavg_wage=log(avg_wage_ojt)
gen lcount_workers_num=log(emp_ojt)


local kappa_est=`kappa_hat'

gen dep_variable=lavg_wage-((-1)/`kappa_est')*lcount_workers_num

quietly reghdfe dep_variable if jahr>=2003 & jahr<=2011, absorb(est_okt_fe=okt_fe ft_fe)

bysort nation_single jahr ind_2dig: egen est_okt_fe_1=mean(est_okt_fe)
replace est_okt_fe=est_okt_fe_1 if est_okt_fe_1!=. & est_okt_fe==.
replace est_okt_fe=0 if est_okt_fe==.
gen est_fe_transform=exp(est_okt_fe)

gen count_work_temp=emp_ojt^((`kappa_est'-1)/`kappa_est')
replace count_work_temp=0 if nation_single==1 

bysort betnr jahr: egen imm_effective1=sum(count_work_temp*est_fe_transform)
gen imm_effective = imm_effective1^(`kappa_est'/(`kappa_est'-1))

drop dep_variable est_fe_transform est_okt_fe* count_work_temp imm_effective1

	keep betnr jahr imm_effective
	collapse (mean) imm_effective  , by(betnr jahr) 
	
	tempfile temp
	save `temp'
restore 

	merge m:1 betnr jahr using `temp'
	drop _merge 

	gen emp_imm_eff = imm_effective

* Save 

keep betnr jahr	emp_imm_eff
duplicates drop 

save "${data}/dataset_immigrant_effective_units.dta", replace


