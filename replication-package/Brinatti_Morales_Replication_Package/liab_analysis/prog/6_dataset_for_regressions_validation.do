cap log close
log using "${log}/6_dataset_for_regressions_validation.log", replace

* Construct regression-ready establishment dataset for validation analysis
* Agostina Brinatti & Nicolas Morales
* Source data: LIAB Longitudinal Model (version 1993-2014), IAB

/*	This dofile takes the establishment-level dataset from dofile 4 and
	constructs the variables needed for the validation regressions (equation 20):
	  - Log revenues and log immigrant-to-native wage bill ratio (outcomes)
	  - Immigrant share of local labour market wage bill (endogenous regressor)
	  - Interaction with log initial employment (size heterogeneity regressor)
	  - Drops extreme outliers (> 4 SDs) in log revenues and log employment

	Input:
	  ${data}/establishment_level_liab.dta    — from dofile 4
	  ${orig}/cpigermany.dta                  — CPI deflator

	Output:
	  ${data}/establishment_level_regressions_liab.dta — regression dataset

	No output tables or figures are produced in this dofile.
*/


/*
Input datasets:
(i)  establishment_full_dataset_rep_oct24: employer-level data with mainly raw data on employment, wage bill, and financials.

Output datasets:
(ii)"${data}/establishment_full_dataset_reg_rep_oct24.dta": firm-year level with data that includes constructed variables needed for regression analysis

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


merge m:1 jahr using "${orig}/cpigermany.dta"
drop if _m==2
drop _m rate yrly

***Deflate wagebill - turnover

foreach x of varlist wbill_tot_tot wbill_german_tot wbill_eu_orig1_tot wbill_eu_orig2_tot wbill_eu_2000_tot wbill_turkey_tot wbill_yugoslavia_tot wbill_europe_other_tot wbill_asia_tot wbill_africa_me_tot wbill_americas_tot turnover grosspay investment  {
replace `x'=`x'*deflator
}



foreach x of varlist kreis_tot_tot loclabor_tot_tot year_tot_tot kreis_german_tot loclabor_german_tot year_german_tot kreis_eu_orig1_tot loclabor_eu_orig1_tot year_eu_orig1_tot kreis_eu_orig2_tot loclabor_eu_orig2_tot year_eu_orig2_tot kreis_eu_2000_tot loclabor_eu_2000_tot year_eu_2000_tot kreis_turkey_tot loclabor_turkey_tot year_turkey_tot kreis_yugoslavia_tot loclabor_yugoslavia_tot year_yugoslavia_tot kreis_europe_other_tot loclabor_europe_other_tot year_europe_other_tot kreis_asia_tot loclabor_asia_tot year_asia_tot kreis_africa_me_tot loclabor_africa_me_tot year_africa_me_tot kreis_americas_tot loclabor_americas_tot year_americas_tot {
replace `x'=`x'*deflator
}


**************************Constructing variables****************


*Dependent variables

gen 	logrevenues 	= log(turnover)
gen 	logexprevenues 	= log(1+turnover*(exports_foreign/100))
replace logexprevenues 	=. if exports_foreign==.

gen 	logdomrevenues=log(1+turnover*(1-(exports_foreign/100)))
replace logdomrevenues=. if exports_foreign==.

gen trade=(exports_foreign>0)
replace trade=. if exports_foreign==.


bysort betnr: egen count_obs=count(jahr)
bysort betnr: egen count_missrev=count(turnover)
bysort betnr: egen min_emp=min(az_ges)


*Explanatory variables - log share of wagebill spent on immigrants

gen sharedomestic=wbill_german_tot/(wbill_german_tot+wbill_eu_orig1_tot+wbill_eu_orig2_tot+wbill_eu_2000_tot+wbill_turkey_tot+wbill_yugoslavia_tot+wbill_europe_other_tot+wbill_asia_tot+wbill_africa_me_tot+wbill_americas_tot)
gen lsharedomestic=log(sharedomestic)

gen shareforeign=1-sharedomestic
gen lshareforeign=log(shareforeign)

gen shareforeign_emp=1-emp_german_tot/(emp_german_tot+emp_eu_orig1_tot+emp_eu_orig2_tot+emp_eu_2000_tot+emp_turkey_tot+emp_yugoslavia_tot+emp_europe_other_tot+emp_asia_tot+emp_africa_me_tot+emp_americas_tot)


gen share_mig_local2_t =(loclabor_tot_tot-loclabor_german_tot)/loclabor_tot_tot


*size is the variable for the interaction term

gen    size_firm=emp_tot_tot if jahr==2003
bysort betnr: egen emp_tot_firm03=mean(size_firm)
drop size_firm
gen logemp_tot_firm03 = log(emp_tot_firm03)



 gen logemp_tot_tot = log(emp_tot_tot)


gen interaction   = share_mig_local2_t*logemp_tot_firm03


*Generating some variables

gen 	logexprevenues2 	= log(turnover*(exports_foreign/100))
replace logexprevenues2		=. if exports_foreign==.

gen 	logdomrevenues2 	= log(turnover*(1-(exports_foreign/100)))
replace logdomrevenues2 	= . if exports_foreign==.
gen 	logexpdomrevenues2 	= logexprevenues2-logdomrevenues2

gen logrevenues_employment = logrevenues - logemp_tot_tot


gen grosspay12 			= grosspay*12
gen profit 			  	= turnover*(1-int_inputs/100) - grosspay12
gen logprofit 		  	= log(profit)
gen profit2 		  	= turnover*(1-int_inputs/100) - wbill_tot_tot
gen logprofit2 		  	= log(profit2)
gen loggrosspay 	  	= log(grosspay12)
gen logwbill_tot_tot  	= log(wbill_tot_tot)
gen logexpdomrevenues 	= logexprevenues-logdomrevenues


*Generating new variables to analyse reallocation

drop if emp_german_tot==0 | wbill_german_tot==0
clonevar wb_ger     =  wbill_german_tot

sum wb_ger ,d
drop if wb_ger>r(p99)

	*Firm level immigrant intensity 


gen wb_mig     = (wbill_eu_orig1_tot+wbill_eu_orig2_tot+wbill_eu_2000_tot+wbill_turkey_tot+wbill_yugoslavia_tot+wbill_europe_other_tot+wbill_asia_tot+wbill_africa_me_tot+wbill_americas_tot)
gen wb_mig_ger = wb_mig/wb_ger


* New control 

gen cost 			= (int_inputs*turnover/100) + wbill_tot_tot
gen cost_sales 		= cost/turnover

foreach x in "cost_sales" {
	gen auxx=`x' if jahr==2003
	bysort betnr: egen `x'_03=mean(auxx)
	drop auxx
}



*Drop extreme observations (if more or less than 4 standard deviations)

egen m_logrevenues = mean(logrevenues)
egen s_logrevenues = sd(logrevenues)
gen  z_logrevenues = (logrevenues - m_logrevenues)/s_logrevenues
drop if z_logrevenues>4   & z_logrevenues~=.
drop if z_logrevenues<-4  & z_logrevenues~=.

egen m_logemp_tot_tot = mean(logemp_tot_tot)
egen s_logemp_tot_tot = sd(logemp_tot_tot)
gen  z_logemp_tot_tot = (logemp_tot_tot - m_logemp_tot_tot)/s_logemp_tot_tot
drop if z_logemp_tot_tot>4   & z_logemp_tot_tot~=.
drop if z_logemp_tot_tot<-4  & z_logemp_tot_tot~=.


* Save data

save "${data}/establishment_level_regressions_liab.dta", replace


log close
