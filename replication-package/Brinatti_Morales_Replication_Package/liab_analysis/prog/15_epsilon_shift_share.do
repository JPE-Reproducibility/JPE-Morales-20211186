cap log close
log using "${log}/15_epsilon_shift_share.log", replace

* Shift-share diagnostics: Rottemberg weights and instrument validity (Tables C2, C4)
* Agostina Brinatti & Nicolas Morales
* Source data: LIAB Longitudinal Model (version 1993-2014), IAB

/*	This dofile computes the Goldsmith-Pinkham et al. (2020) Rottemberg-weight
	shift-share diagnostics and tests the validity of the shift-share instrument
	by regressing initial country shares on firm characteristics.

	Output in this dofile:
	  Table 1 - Table C4 (instrument validity): R^2 of initial shares
	            regressed on firm characteristics (~0.001)
	  Table 2 - Table C2: Rottemberg-weight diagnostics by origin country

	FDZ note: The first preserve/restore block (Table 1) outputs estout with
	  stats(N r2). The Rottemberg table uses pwcorr and count to report
	  the number of groups and correlations. Cell counts >= 20 by construction
	  (9 origin groups x N firms in sample).
	
	  Note on commented-out regressions: the estout for sh2-sh10 above
	  the reshape produces per-country regressions not in the paper. It is
	  commented out and must not be run for submission.
*/


clear

set more off
set matsize 10000
set linesize 255
set seed 1234

cap adopath++ ${prog}


*-------------------------------------------------------------------------------
* Data required for Sorkin et al shares test - Rottemberg weights
*-------------------------------------------------------------------------------

*Dataset is at the origin-firm-year level

use "${data}/dataset_kappa_estimation.dta", clear

duplicates drop nation_single betnr jahr, force 

	
	drop if nation_single==1 /*natives*/
	
	rename nation_single nation
	
	rename sharew_03_of share

	gen shift = ( (nemp_ot)/(nemp_gt) ) * ( (nemp_g03)/(nemp_o03) ) 


*Reshape the dataset to be firm-year level 

keep shift share betnr jahr nation

drop if missing(nation) 

reshape wide shift share, i(betnr jahr) j(nation)


foreach x of numlist 2/10 {
	
replace share`x' = 0 if share`x' ==.

bysort jahr :  egen shift`x'_temp=mean(shift`x')

replace shift`x' = shift`x'_temp if shift`x' ==.

drop shift`x'_temp 
}


* Save 

tempfile temp
save `temp'




*-------------------------------------------------------------------------------
* Sample of epsilon regression
*-------------------------------------------------------------------------------

use "${data}/dataset_epsilon_estimation.dta", clear

*Keep firms in sample of epsilon estimation 

merge 1:1 betnr jahr using "${data}/sample_epsilon_estimation.dta" , keepusing(sample_epsilon)
drop _merge
  
  
*Bring the immigrant in terms of efficient units computed using the estimated kappa

merge 1:1 betnr jahr using "${data}/dataset_immigrant_effective_units.dta" , keepusing(emp_imm_eff)
drop _merge


* Outcome and regressor variables for the wage regressions 

gen l_emp_imm_eff_nat=log(emp_imm_eff/nemp_nat_ft)


* Baseline estimate:  

quietly ivreghdfe   l_wbill_imm_nat (l_emp_imm_eff_nat = iv_r_shift_sharew_o_f ) if sample_epsilon==1, absorb(betnr rt_fe kt_fe) cluster(ind_labormkt) 
local n_obs=e(N)

keep if e(sample)==1

keep l_wbill_imm_nat l_emp_imm_eff_nat  iv_r_shift_sharew_o_f  rt_fe kt_fe ind_labormkt betnr jahr exp_sh_03 trade_03 wb_sh_03 cost_sales_03 imm_sh_03 l_emp_tot_03 emp_sh_coll_03 premium_03 age_03


*Bring the data on country shares and shifts for the firms in the sample

merge 1:1 betnr jahr using `temp'
keep if _merge==3


*-------------------------------------------------------------------------------
* Correlation of shares with firm characteristics
*-------------------------------------------------------------------------------

preserve 

drop l_wbill_imm_nat l_emp_imm_eff_nat  iv_r_shift_sharew_o_f  rt_fe kt_fe ind_labormkt  
duplicates drop betnr , force 

* Table analogous to appendix table for each of the top 5 in terms of shares (not included in draft). 

foreach x of numlist 2/10 {
eststo sh`x': quietly reg share`x' exp_sh_03  wb_sh_03 cost_sales_03 l_emp_tot_03 emp_sh_coll_03 premium_03 age_03
}




eststo clear
  

reshape long share, i(betnr) j(country)
eststo shall: quietly reg share exp_sh_03  wb_sh_03 cost_sales_03 l_emp_tot_03 emp_sh_coll_03 premium_03 age_03

quietly reg share i.country
predict temp, residuals
eststo res_shall: reg temp exp_sh_03  wb_sh_03 cost_sales_03 l_emp_tot_03 emp_sh_coll_03 premium_03 age_03

****************************
* Table 1
* Table C4: Correlation between firm initial shares and characteristics
****************************

* Variables: Initial share of migrants 2003 (outcome), covariates: log employment, 
* The level of the observations is establishment - country of origin (9 regions)
* Sample is restricted to establishments with more than 10 employees that were hiring migrants by 2003.

estout res_shall, varlabels(_cons \_cons)  cells(b(star) se) starlevels( * 0.10 ** 0.05 *** 0.010) stats(N r2)
eststo clear

restore 


*-------------------------------------------------------------------------------
* Sorkin et al shares test - Rottemberg weights
*-------------------------------------------------------------------------------

bartik_weight, z(share*)    weightstub(shift*) x(l_emp_imm_eff_nat) y(l_wbill_imm_nat)  absorb(betnr) controls(rt_fe kt_fe)

mat beta = r(beta)
mat alpha = r(alpha)
mat gamma = r(gam)
mat pi = r(pi)
mat G = r(G)

clear
svmat beta
svmat alpha
svmat gamma
svmat pi
svmat G

gen country_id=_n



****************************
* Table 2
* Table C2: Shift-share diagnostics
****************************

*The Table and its associated statistics displayed below  are calculated using the bartik_weight command. It uses the underlying number of observations used in the first regression in this dofile and tests the different components of the instrument in the regression.
* Variables
* The level of the observations is establishment - year
* Sample is restricted to establishments with more than 10 employees that were hiring migrants by 2003.

dis "Number of observations comes from first regression of the dofile: `n_obs'"

tabstat beta1 alpha1 gamma1 pi1 G1, by(country_id) stat(mean) nototal

count 
count if alpha1>0

pwcorr alpha1 gamma1 beta1 pi1 G1, sig 

log close
