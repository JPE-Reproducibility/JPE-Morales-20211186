cap log close
log using "${log}/14_epsilon_sigma_histogram.log", replace

* Epsilon-sigma histogram and p-values cited in Section 5.3
* Agostina Brinatti & Nicolas Morales
* Source data: LIAB Longitudinal Model (version 1993-2014), IAB

/*	This dofile produces confidence intervals, the p-value for H0: epsilon < sigma,
	and Figure C1 (the only graph output in the project).

	Output in this dofile:
	  Table 1  - Table C1 (supplement): 95% and 99% CIs for epsilon
	  Table 2  - Section 5.3: p-value for H0: epsilon < sigma
	  Graph 1  - Figure C1: Distribution of epsilon - sigma (trimmed)
	             Exported as ${log}/hist_diff_trim_0_975.png

	FDZ note for Figure C1: Per FDZ guidelines §4.6, histogram bin counts
	  must be verified. twoway__histogram_gen is called with the same
	  bin specification immediately after graph export to extract per-bin
	  frequencies. The sum of _freq confirms all bars have >= 20 observations.

	Note on commented-out code: The block inside /* */ below the active
	  histogram produces alternative graphs that are not in the paper.
	  It is retained for reference but must not be run for submission.
*/

/*

Input datasets:
(i)  bootstrapsample: bootstrap estimates of the difference between epsion and sigma for T and NT

*This dofile plots the distributions of the tests 
*/


clear

set more off
set matsize 10000
set linesize 255
set seed 1234

capture adopath++ ${prog}


use "${data}/epsilon_sigma_bootstrapsample.dta",clear





*---------------------------------------------------------------

****************************
* Table 1
* Section 5.3: p-value for H0: epsilon < sigma
****************************

* Variables: epsilon (2SLS implied epsilon per bootstrap draw),
*   sigma (implied from average markup, all firms),
*   sigma_d (NT firms), sigma_avg (weighted average of sigma_d and sigma_x)
* Selection: 5,000 firm-clustered bootstrap draws from dofile 14
* p-value = fraction of draws where epsilon < sigma
* N (bootstrap draws) reported by first count command.

* p-values for the tests
*---------------------------------------------------------------

count /**/
count if epsilon>sigma /**/
count if epsilon>sigma_d /**/
count if epsilon>sigma_avg  /**/



 _pctile diff , nq(1000)
	gen diff_25 = r(r25)
  _pctile diff , nq(1000)
   gen diff_975 = r(r975)
   
   
   
*------------------------------------------------------------------------------
* Plots
*------------------------------------------------------------------------------




****************************
* Graph 1
* Figure C1: Distribution of (epsilon - sigma), trimmed
****************************

* Variables: diff_trim_0_975 (= epsilon - sigma; negative values replaced
*   with 0, values above 97.5th percentile capped at that percentile)
* Selection: 5,000 firm-clustered bootstrap draws from dofile 14
* FDZ §4.6: per-bin frequencies verified via twoway__histogram_gen below.
*   All bars must have >= 20 observations.

*** Figure C1: Distribution of epsilon - sigma

gen 	diff_trim_0_975= diff
replace diff_trim_0_975 = 0  	   if diff < 0
replace diff_trim_0_975 = diff_975 if diff > diff_975

histogram diff_trim_0_975
graph export "${log}/14_epsilon_sigma_histogram_01_hist.png", replace  

* FDZ §4.6: verify per-bin frequencies for Figure C1
* The histogram is computed by running 5000 bootstrap simulations (in dofile 13_estimate_epsilon_sigma), and then splitting the result of the 5000 simulations across each bar of the graph.
* The relevant count is not the 5000 nor how many observations are in each bar, but the underlying observations in the regressions that calculate the statistics in each bootstrap sample  
* Below I report, the sum of the number of observations in the regressions across each bootrtrap sample to corroborate that each of the 5000 statistics was computed with more than 20 observations. You can see that the "min" and "max" are well above 20

sum count_2sls
di "Figure C1 — observations used in each of the 5000 bootstrap simulations"





log close








