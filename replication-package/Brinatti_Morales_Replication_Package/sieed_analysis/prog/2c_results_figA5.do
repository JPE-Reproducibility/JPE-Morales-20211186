********************************************************************************
* 2c_results_figA5.do
*
* Purpose:
*   Produces Appendix Figure A5, which documents the lumpiness of immigrant
*   hiring at the extensive margin. The figure plots the median and mean number
*   of immigrant new hires (panel a) and the immigrant share among new hires
*   (panel b) as a function of the number of periods elapsed since a firm first
*   began hiring immigrants.
*
*   The key pattern in the figure is a spike in immigrant hiring in period 0
*   (the first period a firm hires), followed by a decline toward a lower
*   steady-state level in subsequent periods. This lumpiness is inconsistent
*   with a frictionless model, where firms could gradually increase immigrant
*   hiring over time. It instead supports the presence of a fixed cost of
*   starting to hire immigrants, consistent with the modeling assumption in
*   Section 4 of the paper. See Appendix A.4 for the empirical discussion.
*
* Sample:
*   Restricted to establishments that (i) begin hiring immigrants at some
*   point during 2003-2010, (ii) had zero immigrant employment in the period
*   immediately before their first immigrant hire, and (iii) hire at least
*   5 immigrants in total over the 2003-2010 period (sample_hire5==1).
*   The 5-immigrant threshold ensures that the hiring dynamics are not
*   driven by firms that hire a single immigrant and never repeat.
*
* Inputs:
*   ${data}/firm_level_sieed.dta  - Firm-year panel from 1a (restricted to
*                                   2003-2010 in this file)
*
* Outputs:
*   Summary statistics (median, mean, SD, count) printed to log file.
*   These are the data underlying Appendix Figure A5.
********************************************************************************

clear
set seed 1234
set more off
set matsize 10000
set linesize 255

cap adopath++ ${prog}

capture log close
log using "${log}/2c_results_figA5.log", replace



use "${data}/firm_level_sieed.dta", clear

* Restrict to 2003-2010 to focus on the pre-enlargement period, consistent
* with Figure A5 in the paper (which uses the SIEED over this window).
keep if jahr<2011 
keep if jahr>2002

* Recycling the code 

* Rename key variables to shorter names for convenience.
rename emp_tot nemp_ft
rename emp_imm nemp_imm_ft
rename emp_new_hire_imm nhir_imm_ft 
rename emp_new_hire_nat	nhir_nat_ft
rename wbill_new_hire_imm whir_imm_ft 
rename wbill_new_hire_nat whir_nat_ft

*-------------------------------------------------------------------------------
* Identify the first period in which each establishment hires immigrants
*
* event_year: the first calendar year in which the firm had positive new
*             immigrant hires AND zero immigrant employment in the previous
*             period (i.e., a genuine first hire, not a re-hire after an
*             established immigrant workforce).
* dist_event_year: periods elapsed since event_year (0 = first hire period,
*                  1 = one period later, etc.)
*-------------------------------------------------------------------------------

* Compute the event variable and the years since and to event

by betnr (jahr), sort: gen nemp_imm_ftlag  = nemp_imm_ft[_n-1]

gen event_year_aux = jahr if nhir_imm_ft > 0 & nemp_imm_ftlag == 0

bysort betnr: egen event_year = min(event_year_aux)
gen dist_event_year = jahr - event_year 
tab dist_event_year
drop event_year_aux

gen event=0 
replace event=1 if dist_event_year==0

bysort betnr: egen event_ever = max(event)

* We keep the periods after the firm hired immigrants 

keep if dist_event_year==0| dist_event_year>0

*Generate immigrant shares in terms of hiring

	gen nhir_imm_nat 		= nhir_imm_ft/nhir_nat_ft
	gen nhir_imm_sh 		= nhir_imm_ft/(nhir_imm_ft + nhir_nat_ft)
	
*-------------------------------------------------------------------------------
* Sample selection
*
* Three restrictions to obtain a clean sample of genuine first-time hirers:
*   1. Drop firms that already had immigrants at the start of the period
*      (Dnemp_imm_f1==1 means the firm had immigrants in the very first
*      period it appears in the data, so it is not a new hirer).
*   2. Drop firms that never hire an immigrant during 2003-2010 (event_ever==0).
*   3. Drop firms with fewer than 5 total immigrant new hires across all
*      periods (sample_hire5==0), to ensure the hiring dynamics are meaningful.
*   4. Drop observations where nhir_imm_sh is missing (new hires of all types
*      are zero in that period).
*-------------------------------------------------------------------------------

*Sample selection

	* Drop those that were hiring immigrants in the first period 
	
	bysort betnr jahr: gen 	nemp_imm_f1_aux = 0 if  _n == 1
	replace nemp_imm_f1_aux = 1 if (nemp_imm_ft > 0 & _n == 1)
	
	bysort betnr: egen Dnemp_imm_f1=mean(nemp_imm_f1_aux)
	drop if Dnemp_imm_f1==1
	drop nemp_imm_f1_aux
	
	*Drop those who will never hire an immigrant in the period 
	
	drop if event_ever==0


	*Sample with that hire at least 5 or 10 immigrants in the period (2002-2018)

	bysort betnr: egen nhir_imm_f=sum(nhir_imm_ft) 
	
	gen sample_hire10 = (nhir_imm_f>9)
	gen sample_hire5  = (nhir_imm_f>4)	
	

	*Drop the observations that did not where hiring imm + natives = 0

	drop if missing(nhir_imm_sh)

	*Only then we define the panel sample 
	
	foreach x in "1" "2" "3" "4" {
		gen eventF`x' = (dist_event_year==`x')
	}
	gen eventF5 = (dist_event_year>4)

	
replace dist_event_year = 5 if dist_event_year > 4
 

 *-------------------------------------------------------------------------------
 * Figure A5: Hiring dynamics after starting to hire immigrants
 *
 * For each value of dist_event_year (0 through 5+), compute:
 *   - Median and mean number of immigrant new hires (nhir_imm_ft): panel (a)
 *   - Median and mean immigrant share among new hires (nhir_imm_sh): panel (b)
 * restricted to firms that hired at least 5 immigrants in total (sample_hire5).
 * Standard deviations and observation counts are also reported.
 *-------------------------------------------------------------------------------

 *-------------------------------------------------------------------------------
 * Baseline
 *-------------------------------------------------------------------------------

 *Figure A5: Hiring dynamics after starting to hire immigrants
 
 
*(a) Number of immigrant new hires
 table dist_event_year if sample_hire5==1, stat(p50 nhir_imm_ft) stat(mean nhir_imm_ft) stat(sd nhir_imm_ft) stat(count nhir_imm_ft)

*(b) Immigrant share among new hires
table dist_event_year if sample_hire5==1, stat(p50 nhir_imm_sh) stat(mean nhir_imm_sh) stat(sd nhir_imm_sh) stat(count nhir_imm_sh)



log close
