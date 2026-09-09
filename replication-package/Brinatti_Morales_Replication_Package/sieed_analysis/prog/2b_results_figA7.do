********************************************************************************
* 2b_results_figA7.do
*
* Purpose:
*   Produces Appendix Figure A7, which plots the median immigrant share of the
*   wage bill by establishment employment size bin, separately for the pre-
*   enlargement period (2003-2010) and the post-enlargement period (2015-2018).
*   The figure provides descriptive evidence that the 2011 opening of the
*   German labor market to EU New Member State nationals reduced the size
*   threshold above which establishments begin hiring immigrants, consistent
*   with a reduction in fixed hiring costs. See Appendix A.5 of the paper.
*
*   The 10 size bins (decile_wbill) mirror those used in the baseline Figure 1,
*   which plots the immigrant share by establishment size using the LIAB data.
*   The 200-repetition bootstrap is used to construct 95% confidence intervals
*   around the median immigrant shares, as in the paper's other descriptive
*   figures.
*
* Inputs:
*   ${data}/firm_level_sieed_A7.dta     - Firm-year panel from 1c
*   ${data}/local_labor_market.dta      - Kreis-to-local labor market crosswalk
*                                         from 1b (merged for ao_kreis)
*
* Outputs:
*   Regression results and bootstrap standard deviations printed to the log.
*   The median immigrant shares and their SDs by size bin are the inputs for
*   Figure A7 (two lines: 2003-2010 in red and 2015-2018 in blue).
********************************************************************************

clear
set seed 1234
set more off
set matsize 10000
set linesize 255

cap adopath++ ${prog}

capture log close
log using "${log}/2b_results_figA7.log", replace



*Data

use "${data}/firm_level_sieed_A7.dta", clear



* Merge in the local labor market crosswalk (used to verify geographic coverage;
* district identifiers are present from the BHP merge in 1c).
merge m:1 ao_kreis using "${data}/local_labor_market.dta" , generate(merge2)  
drop if merge2==2
drop merge2
keep if jahr>2002


rename local_labor local_labor11

* Construct industry x year and local labor market x year fixed effect groups
* (available for robustness; not used directly in the Figure A7 tabulations).
egen industry_time 		= group(w93_3_gen jahr)
egen local_labor_time 	= group(local_labor11 jahr)
egen industry_local_time=group(w93_3_gen ao_kreis jahr)


*-------------------------------------------------------------------------------
* Immigrant share measures
*   wimm_sh: wage-bill-based immigrant share (main outcome, used in Figure A7
*            and Figure 1 of the paper)
*   imm_sh:  employment-count-based immigrant share (available for robustness)
*-------------------------------------------------------------------------------

* immigrant shares

gen wimm_sh 		= wbill_imm/(wbill_tot)
gen imm_sh 		= emp_imm/(emp_tot)

*-------------------------------------------------------------------------------
* Size bins
*
* Establishments are assigned to one of 10 size bins based on their June 30
* employment count (emp_tot), using the same bin boundaries as Figure 1 of the
* paper (0-10, 11-20, 21-30, 31-50, 51-70, 71-100, 101-150, 151-200, 201-500,
* 500+). Because Figure A7 uses all years in the SIEED panel (not just 2010),
* emp_tot refers to employment in each respective year.
*-------------------------------------------------------------------------------

* Size bins 

gen size_bin=.
replace size_bin=1 if emp_tot<=10
replace size_bin=2 if emp_tot>=11 & emp_tot<=20
replace size_bin=3 if emp_tot>=21 & emp_tot<=30
replace size_bin=4 if emp_tot>=31 & emp_tot<=50
replace size_bin=5 if emp_tot>=51 & emp_tot<=70
replace size_bin=6 if emp_tot>=71 & emp_tot<=100
replace size_bin=7 if emp_tot>=101 & emp_tot<=150
replace size_bin=8 if emp_tot>=151 & emp_tot<=200
replace size_bin=9 if emp_tot>=201 & emp_tot<=500
replace size_bin=10 if emp_tot>=501 & emp_tot!=.

gen decile_wbill = size_bin




*-------------------------------------------------------------------------------
* Figure A7: Immigrant share for before and after the EU enlargement
*
* Point estimates: median immigrant wage-bill share within each size bin,
* computed separately for the pre-policy (2003-2010) and post-policy
* (2015-2018) periods. The 2011-2014 transition period is excluded to
* allow sufficient time for the policy effect to materialize.
* The table also reports the number of establishment-year observations in
* each bin, which is used to assess sample size.
*-------------------------------------------------------------------------------


* Figure A7: Immigrant share for before and after the EU enlargement


*2003-2010
table decile_wbill if jahr>2002 & jahr<2011 , stat(p50 wimm_sh) stat(count wimm_sh) 

*2015-2018
table decile_wbill if jahr>2014 & jahr<2019 , stat(p50 wimm_sh) stat(count wimm_sh)


* ---- Added for JPE reproducibility deposit: stash the point estimates above
* (median wimm_sh by decile_wbill, pre/post period) to a tempfile, since the
* `table` commands above only print them and do not save a dataset. Used by
* the Figure A7 plotting section added at the end of this do-file.
tempfile figA7_point
preserve
    gen wimm_sh_pre_pt  = wimm_sh if jahr>2002 & jahr<2011
    gen wimm_sh_post_pt = wimm_sh if jahr>2014 & jahr<2019
    collapse (median) wimm_sh_pre_pt wimm_sh_post_pt, by(decile_wbill)
    save `figA7_point'
restore


*-------------------------------------------------------------------------------
* Bootstrap standard errors for Figure A7
*
* 200 bootstrap repetitions with bsample (sampling with replacement at the
* establishment-year level). In each iteration we collapse to the median
* immigrant share by size bin x period, then append all iterations and compute
* the standard deviation across bootstrap samples -- this standard deviation
* is the bootstrap standard error reported in Figure A7.
*
* The two period-specific variables (wimm_sh_0211, wimm_sh_1419) are defined
* first so that a single bsample draw preserves both periods simultaneously,
* ensuring that the same set of establishments is used for both the pre- and
* post-period medians within each bootstrap iteration.
*-------------------------------------------------------------------------------

******Standard errors for figure A7********


gen wimm_sh_0211=wimm_sh if  jahr>2002 & jahr<2011
gen wimm_sh_1419=wimm_sh if  jahr>2014 & jahr<2019


keep decile_wbill wimm_sh_0211 wimm_sh_1419 


local ntot=200

forvalues x = 1/`ntot' {

preserve

display `x'
	
set seed `x'
	
bsample 	
	
collapse (median) wimm_sh_0211 wimm_sh_1419, by(decile_wbill) 

	
gen nsample=`x'
		
tempfile boot`x'
save `boot`x'', replace

		
restore

}

use `boot1', clear

forvalues y=2/`ntot'{

append using `boot`y''

}


*-------------------------------------------------------------------------------
* Bootstrap standard deviations (= standard errors for Figure A7)
*
* The standard deviation of the bootstrap medians across the 200 iterations,
* reported by size bin and period, is the standard error used to construct
* the 95% confidence intervals in Figure A7.
*-------------------------------------------------------------------------------

* Table A7 Standard errors

*2003-2010
table decile_wbill, stat(sd wimm_sh_0211) stat(n wimm_sh_0211)

*2015-2018
table decile_wbill, stat(sd wimm_sh_1419) stat(n wimm_sh_1419)


/*==============================================================================
  FIGURE (added for JPE reproducibility deposit — not part of the original
  submission). This section does not modify any of the analysis above; it only
  combines the point estimates (stashed above, right after the original
  point-estimate `table` calls) with the bootstrap SDs computed just above to
  plot Figure A7, since in the original submission this table was turned into
  a figure in Excel.

  NOTE ON EXACT APPEARANCE: the published Figure A7 was built by hand in Excel
  from the point estimates and standard errors printed by the `table` calls
  above (styling, colors, markers chosen by the authors). The Stata graph
  below plots the same underlying numbers but will not look pixel-identical
  to the paper's version (font, colors, marker style, axis formatting, etc.
  all differ) -- only the data displayed is the same.

  Output: sieed_analysis/output/figure_A7.jpg
==============================================================================*/

preserve
    collapse (sd) sd_pre = wimm_sh_0211 sd_post = wimm_sh_1419, by(decile_wbill)
    merge 1:1 decile_wbill using `figA7_point', nogenerate

    gen ci_lo_pre  = wimm_sh_pre_pt  - 1.96*sd_pre
    gen ci_hi_pre  = wimm_sh_pre_pt  + 1.96*sd_pre
    gen ci_lo_post = wimm_sh_post_pt - 1.96*sd_post
    gen ci_hi_post = wimm_sh_post_pt + 1.96*sd_post

    label define bin_lbl 1 "0-10" 2 "11-20" 3 "21-30" 4 "31-50" 5 "51-70" ///
        6 "71-100" 7 "101-150" 8 "151-200" 9 "201-500" 10 "+500"
    label values decile_wbill bin_lbl

    * Compute the y-axis range dynamically from the actual CI bounds (with a
    * 5% padding margin), rather than relying on Stata's default auto-range,
    * so that no point estimate or CI whisker is ever clipped at the plot edge.
    quietly summarize ci_lo_pre
    local ymin = r(min)
    quietly summarize ci_lo_post
    local ymin = min(`ymin', r(min))
    quietly summarize ci_hi_pre
    local ymax = r(max)
    quietly summarize ci_hi_post
    local ymax = max(`ymax', r(max))
    local ypad = 0.05*(`ymax' - `ymin')
    local ylo  = `ymin' - `ypad'
    local yhi  = `ymax' + `ypad'

    set scheme s1color
    global figout = subinstr("${prog}", "/prog", "/output", 1)
    cap mkdir "${figout}"

    twoway (rcap ci_lo_pre ci_hi_pre decile_wbill, lcolor(navy%40)) ///
           (rcap ci_lo_post ci_hi_post decile_wbill, lcolor(maroon%40)) ///
           (connected wimm_sh_pre_pt  decile_wbill, lcolor(navy)   mcolor(navy)   msymbol(O)) ///
           (connected wimm_sh_post_pt decile_wbill, lcolor(maroon) mcolor(maroon) msymbol(Dh)), ///
           xlabel(1/10, valuelabel angle(45) labsize(vsmall)) xscale(range(0.5 10.5)) ///
           xtitle("Establishment size bin (employment)", size(small)) ///
           yscale(range(`ylo' `yhi')) ///
           ytitle("Immigrant wage-bill share (median)", size(small)) ///
           legend(order(3 "2003-2010 (pre)" 4 "2015-2018 (post)") ///
                  cols(2) ring(1) position(6) region(lstyle(none)) size(small)) ///
           graphregion(color(white)) plotregion(color(white)) ysize(4.5) xsize(6.5) ///
           title("Figure A7: Immigrant share before/after EU enlargement", size(medium)) ///
           name(figA7, replace)
    graph export "${figout}/figure_A7.jpg", replace width(2000) height(1500)
restore


log close
