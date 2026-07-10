cap log close
log using "${log}/8_validation_regressions.log", replace

* Validation regressions: revenues and immigrant-to-native wage bill ratio
* Agostina Brinatti & Nicolas Morales
* Source data: LIAB Longitudinal Model (version 1993-2014), IAB

/*	This dofile estimates equation (20): the reduced-form regression of firm
	outcomes on the immigrant share of the local labour market, instrumented
	by a shift-share instrument (Card 2001; Ottaviano et al. 2018).

	y_jt = theta_1 Im_mt + theta_2 Im_mt x log(emp_j,2003) + controls + FE + u

	Output tables in this dofile:
	  Table 1  - Table C8:  OLS estimates (revenues and wage-bill ratio)
	  Table 2  - Table C9:  2SLS estimates (revenues and wage-bill ratio)
	  Table 3  - Table C10: First-stage regressions
	  Table 4  - Table C11: Pre-trend tests, lags 1-5
	  Table 5  - Table C12: Robustness to alternative FE specifications
	  Table 6  - Table C13 / Figure 3: Mean elasticity by size decile

	FDZ note: N (unweighted) reported via stats(N N_clust) in all estout calls.
	  For Table 6 (Figure 3), unweighted counts precede weighted means (§4.5).
*/


/*
Input datasets:
(ii)"${data}/establishment_full_dataset_reg_rep_oct24.dta": firm-year level with data that includes constructed variables needed for regression analysis

This dofile run the baseline regressions, the pre-trend analysis, and compute the elasticities of the main variables across the size distribution that will be used in the validation analysis

*/


clear

set more off
set matsize 10000
set linesize 255
set seed 1234

capture adopath++ ${prog}


use "${data}/establishment_level_regressions_liab.dta", clear

* Lag variables for pre-trend check 

tsset betnr jahr
foreach var in "logrevenues" "wb_mig_ger" {

	gen `var'L0 = `var'
	gen `var'L1 = L1.`var'
	gen `var'L2 = L2.`var'
	gen `var'L3 = L3.`var'
	gen `var'L4 = L4.`var'	
	gen `var'L5 = L5.`var'

}




merge 1:1 betnr jahr using "${data}/dataset_instrument_validation.dta" , keepusing(instrument3n_local)
drop _merge 

rename instrument3n_local instrument3n_new

* Variables in the regressions 

global regressors share_mig_local2_t interaction
global instruments instrument3n_new c.instrument3n_new#c.logemp_tot_firm03
global controls c.logemp_tot_firm03#c.jahr
global fixedeffects ind_med_time betnr i.local_labor11#c.jahr  c.cost_sales_03#i.jahr 
global clustering ind_2dig local_labor11 






*-------------------------------------------------------------------------------
* Main regressions and elasticities by firm size
*-------------------------------------------------------------------------------

* Sample

gen sample_rev=0
quietly ivreghdfe logrevenues ( $regressors = $instruments ) $controls if jahr>=2008 & jahr<=2011 & min_emp>=10 & count_missrev>=2 & turnover_type==1, cl($clustering) absorb($fixedeffects) 
replace sample_rev =1 if e(sample)==1
		
keep if sample_rev==1 


preserve
keep betnr jahr sample_rev
save "${data}/sample_validation.dta", replace
restore




* Sales, all firms 

quietly ivreghdfe logrevenues ( $regressors = $instruments ) $controls, cl($clustering) absorb($fixedeffects) 
eststo m1
local fstat_all=e(widstat)
gen   elast_lrev      	= (_b[share_mig_local2_t]*share_mig_local2_t + _b[interaction]*interaction) 

 
* Sales, T sector  

quietly ivreghdfe logrevenues ( $regressors = $instruments ) $controls if tradeable3==1, cl($clustering) absorb($fixedeffects) 
eststo m2
local fstat_T=e(widstat)
gen   elast_lrev_T 	= (_b[share_mig_local2_t]*share_mig_local2_t + _b[interaction]*interaction) if tradeable3==1


* Sales, NT sector 

quietly ivreghdfe logrevenues ( $regressors = $instruments ) $controls if tradeable3==0, cl($clustering) absorb($fixedeffects) 
eststo m3
local fstat_NT=e(widstat)
gen   elast_lrev_NT = (_b[share_mig_local2_t]*share_mig_local2_t + _b[interaction]*interaction) if tradeable3==0


* Ratio, all 
 
quietly ivreghdfe wb_mig_ger  ( $regressors = $instruments ) $controls, cl($clustering) absorb($fixedeffects)
eststo m4
gen   elast_ratio = (_b[share_mig_local2_t]*share_mig_local2_t + _b[interaction]*interaction) if tradeable3==0

 
* Ratio, T
quietly ivreghdfe wb_mig_ger ( $regressors = $instruments ) $controls if tradeable3==1, cl($clustering) absorb($fixedeffects) 
eststo m5
gen   elast_ratio_T 	= (_b[share_mig_local2_t]*share_mig_local2_t + _b[interaction]*interaction) if tradeable3==1

* Ratio, NT 

quietly ivreghdfe wb_mig_ger ( $regressors = $instruments ) $controls if tradeable3==0, cl($clustering) absorb($fixedeffects)  
eststo m6
gen   elast_ratio_NT = (_b[share_mig_local2_t]*share_mig_local2_t + _b[interaction]*interaction) if tradeable3==0









* Sales, all firms
quietly reghdfe logrevenues $regressors $controls, cl($clustering) absorb($fixedeffects)
eststo y1

* Sales, T sector
quietly reghdfe logrevenues $regressors $controls if tradeable3==1, cl($clustering) absorb($fixedeffects)
eststo y2

* Sales, NT sector
quietly reghdfe logrevenues $regressors $controls if tradeable3==0, cl($clustering) absorb($fixedeffects)
eststo y3

* Ratio, all
quietly reghdfe wb_mig_ger $regressors $controls, cl($clustering) absorb($fixedeffects)
eststo y4

* Ratio, T
quietly reghdfe wb_mig_ger $regressors $controls if tradeable3==1, cl($clustering) absorb($fixedeffects)
eststo y5

* Ratio, NT
quietly reghdfe wb_mig_ger $regressors $controls if tradeable3==0, cl($clustering) absorb($fixedeffects)
eststo y6


****************************
* Table 1
* Table C8: OLS estimates — revenues and wage-bill ratio
****************************

* Variables: logrevenues (log annual revenues), wb_mig_ger (log immigrant-to-native
*   wage bill ratio); share_mig_local2_t (LLM immigrant share of wage bill),
*   interaction (share_mig_local2_t x log emp 2003)
* Selection: 2008-2011, establishments >= 10 employees, >= 2 non-missing revenue
*   observations, turnover_type = 1; FE: ind_med_time, betnr, LLM linear trend,
*   cost_sales_03 trend; SE clustered at (ind_2dig, local_labor11)
* Outcome: logrevenues (cols 1-3) and wb_mig_ger (cols 4-6)
* Sectors: All / Tradable (tradeable3=1) / Non-tradable (tradeable3=0)
* N (unweighted) reported via stats(N N_clust) in estout.

esttab y*, se nocons unstack star(* 0.10 ** 0.05  *** 0.01)  mtitles("All,sales" "T,sales" "NT,sales" "All,ratio" "T,ratio" "NT,ratio") keep(share_mig_local2_t interaction)




****************************
* Table 2

****************************
* Table 2
* Table C9: 2SLS estimates — revenues and wage-bill ratio
****************************

* Variables: as Table C8 above
* Instrument: instrument3n_new (shift-share instrument: 2003 LLM origin-country
*   shares x national employment growth rates) and its interaction with log emp 2003
* Table shows causal effects of local immigrant inflows on firm outcomes.
*   theta_1: average effect; theta_2: heterogeneity by initial firm size.
* KP F-statistics reported via di after estout.
* N (unweighted) reported via stats(N N_clust) in estout.

* Table C9: 2SLS estimates — revenues and wage-bill ratio
****************************

* Variables: as Table C8 above
* Instrument: instrument3n_new (shift-share, national growth x 2003 LLM shares),
*   and its interaction with log emp 2003
* Kleibergen-Paap F-statistics reported below the estout.
* N (unweighted) reported via stats(N N_clust) in estout.

*Table C9: Effects of immigration for firms of different sizes: 2SLS estimates

esttab m*, se nocons unstack star(* 0.10 ** 0.05  *** 0.01)  mtitles("All,sales" "T,sales" "NT,sales" "All,ratio" "T,ratio" "NT,ratio") keep(share_mig_local2_t interaction)
dis "lag: `lag'    " 
dis "Fstat 1st stage all, betnr: `fstat_all'"
dis "Fstat 1st stage T, betnr: `fstat_T'"
dis "Fstat 1st stage NT, betnr: `fstat_NT'"
eststo clear



* Elasticity of sales and ratio for all firms, T sector and NT sector 
	
xtile decile_emp 	= logemp_tot_firm03, nq(10)
xtile decile_emp_T 	= logemp_tot_firm03 if tradeable3==1, nq(10)
xtile decile_emp_NT = logemp_tot_firm03 if tradeable3==0, nq(10)	














 *All firms
quietly reghdfe share_mig_local2_t  $instruments $controls, cl($clustering) absorb($fixedeffects) 
eststo f1 
quietly reghdfe share_mig_local2_t $instruments $controls if tradeable3==1, cl($clustering) absorb($fixedeffects) 
eststo f3
quietly reghdfe share_mig_local2_t $instruments $controls if tradeable3==0, cl($clustering) absorb($fixedeffects) 
eststo f5

quietly reghdfe interaction  $instruments $controls, cl($clustering) absorb($fixedeffects) 
eststo f2
quietly reghdfe interaction $instruments $controls if tradeable3==1, cl($clustering) absorb($fixedeffects) 
eststo f4
quietly reghdfe interaction $instruments $controls if tradeable3==0, cl($clustering) absorb($fixedeffects) 
eststo f6

****************************
* Table 3
* Table C10: First-stage regressions
****************************

* Variables: share_mig_local2_t and interaction (endogenous regressors);
*   instrument3n_new and interaction (instruments)
* Selection: same sample as Table C9
* N (unweighted) reported via stats(N N_clust) in estout.

*Table C10: Effects of immigration for firms of different sizes: First stage regressions
esttab f1 f2 f3 f4 f5 f6, se nocons unstack star(* 0.10 ** 0.05  *** 0.01)  mtitles("All,base" "All,interaction" "T,base" "T,interaction" "NT,base" "NT,interaction")





*-------------------------------------------------------------------------------
* Pre-trend analysis
*-------------------------------------------------------------------------------


foreach lag in "1" "2" "3" "4" "5" {
							
cap drop _est*

quietly ivreghdfe logrevenuesL`lag' ( $regressors = $instruments ) $controls, cl($clustering) absorb($fixedeffects) 
eststo m1
local fstat_all=e(widstat)

quietly ivreghdfe wb_mig_gerL`lag'  ( $regressors = $instruments ) $controls, cl($clustering) absorb($fixedeffects)
eststo m4




****************************
* Table 4
* Table C11: Pre-trend tests (lags 1-5)
****************************

* Variables: logrevenueLh and wb_mig_gerLh (outcomes lagged h=1..5 years)
* Instrument: same shift-share as Table C9
* Selection: same sample as Table C9
* Table tests whether instrument predicts outcomes h years prior to 2008.
* N (unweighted) reported via stats(N N_clust) in estout.
*Fstats for each of the regressions displayed below each table, N obs same as the columns in same order
*Table C11: Pre-trends tests

esttab m*, se nocons unstack star(* 0.10 ** 0.05  *** 0.01)  mtitles("All,sales" "All,ratio") keep(share_mig_local2_t interaction)
dis "lag: `lag'    " 
dis "Fstat 1st stage all, betnr: `fstat_all'"

eststo clear

}


*Revenues

quietly ivreghdfe logrevenues ( $regressors = $instruments ) $controls, cl($clustering) absorb($fixedeffects) 
eststo z1
local fstat_1=e(widstat)
quietly ivreghdfe logrevenues ( $regressors = $instruments ) , cl($clustering) absorb($fixedeffects) 
eststo z2
local fstat_2=e(widstat)
quietly ivreghdfe logrevenues ( $regressors = $instruments ) $controls, cl($clustering) absorb(ind_med_time betnr i.local_labor11#c.jahr) 
eststo z3
local fstat_3=e(widstat)
quietly ivreghdfe logrevenues ( $regressors = $instruments ) $controls, cl($clustering) absorb(i.local_labor11#c.jahr betnr c.cost_sales_03#i.jahr) 
eststo z4
local fstat_4=e(widstat)
quietly ivreghdfe logrevenues ( $regressors = $instruments ) $controls, cl($clustering) absorb(ind_med_time betnr c.cost_sales_03#i.jahr) 
eststo z5
local fstat_5=e(widstat)
quietly ivreghdfe logrevenues ( $regressors = $instruments ) $controls, cl($clustering) absorb(ind_med_time betnr i.local_labor11#i.jahr c.cost_sales_03#i.jahr) 
eststo z6
local fstat_6=e(widstat)


*Ratio of Immigrant to Native Wage Bill


quietly ivreghdfe wb_mig_ger ( $regressors = $instruments ) $controls, cl($clustering) absorb($fixedeffects) 
eststo w1
local fstat_7=e(widstat)
quietly ivreghdfe wb_mig_ger ( $regressors = $instruments ) , cl($clustering) absorb($fixedeffects) 
eststo w2
local fstat_8=e(widstat)
quietly ivreghdfe wb_mig_ger ( $regressors = $instruments ) $controls, cl($clustering) absorb(ind_med_time betnr i.local_labor11#c.jahr) 
eststo w3
local fstat_9=e(widstat)
quietly ivreghdfe wb_mig_ger ( $regressors = $instruments ) $controls, cl($clustering) absorb(i.local_labor11#c.jahr betnr c.cost_sales_03#i.jahr) 
eststo w4
local fstat_10=e(widstat)
quietly ivreghdfe wb_mig_ger ( $regressors = $instruments ) $controls, cl($clustering) absorb(ind_med_time betnr c.cost_sales_03#i.jahr) 
eststo w5
local fstat_11=e(widstat)
quietly ivreghdfe wb_mig_ger ( $regressors = $instruments ) $controls, cl($clustering) absorb(ind_med_time betnr i.local_labor11#i.jahr c.cost_sales_03#i.jahr) 
eststo w6
local fstat_12=e(widstat)


****************************
* Table 5
* Table C12: Robustness — alternative FE specifications
****************************

* Variables: as Table C9; FE variant per column:
*   Col 1: Baseline; Col 2: drop cost control; Col 3: drop ind-year FE;
*   Col 4: drop LLM linear trend; Col 5: replace linear with LLM-year FE
* N (unweighted) reported via stats(N N_clust) in estout.
*Fstats for each of the regressions displayed below each table, N obs same as the columns in same order

*Table C12: Robustness exercises for main specification

esttab z*, se nocons unstack star(* 0.10 ** 0.05  *** 0.01)  mtitles("Baseline" "No emp control" "No cost control" "No ind-year FE" "No local trend" "local labor - year FE") keep(share_mig_local2_t interaction)

forval x=1/6 {
	
	dis "Fstat 1st stage all, betnr: `fstat_`x'''"
	
}


esttab w*, se nocons unstack star(* 0.10 ** 0.05  *** 0.01)  mtitles("Baseline" "No emp control" "No cost control" "No ind-year FE" "No local trend" "local labor - year FE") keep(share_mig_local2_t interaction)

forval x=7/12 {
	
	dis "Fstat 1st stage all, betnr: `fstat_`x'''"
	
}



****************************
* Table 6
* Table C13 / Figure 3: Mean firm-level elasticity by size decile
****************************

* Variables: elast_lrev / elast_lrev_T / elast_lrev_NT (fitted revenue elasticity
*   from 2SLS, evaluated firm-by-firm); elast_ratio / elast_ratio_T / elast_ratio_NT
*   (fitted wage-bill ratio elasticity); decile_emp / decile_emp_T / decile_emp_NT
*   (decile of log employment in 2003, defined pooled and by sector)
* Selection: same sample as Table C9, split by tradeable3
* Table provides the empirical counterpart to Figure 3 in the paper.
* FDZ: unweighted counts per decile shown first (via stat(n ...)), then p50 and mean.


tabstat elast_lrev_T if tradeable3==1, by(decile_emp) stat(count mean) nototal
tabstat elast_lrev_NT if tradeable3==0, by(decile_emp) stat(count mean) nototal

tabstat elast_ratio_T if  tradeable3==1, by(decile_emp) stat(count mean) nototal
tabstat elast_ratio_NT if tradeable3==0, by(decile_emp) stat(count mean) nototal




log close 

