
clear
clear all
set more off
set matsize 5000
set scheme s1color

* Use ${base} set in scripts/master.do.

cd "${base}/output/intermediate/policies"

*-------------------------------------------------------------------------------
* Figures D1 / D2. The figures use:
*   psi    (firm productivity)
*   sdom   (domestic share of input bill; sfor = 1 - sdom)
*   Ld_alt (native employment, effective units)
*   I_alt  (immigrant employment, effective units)
*
* cf mapping:
*   0 = baseline (basef pre-shock sheet)
*   2 = top10        (Policy 2)
*   4 = basef        (Policy 1)
*   5 = bottom_onlyt (Policy 3)
*   6 = top_onlyt    (Policy 4)
*   7 = nobasef      (Figure D2 only)
*-------------------------------------------------------------------------------

tempfile cf0_t cf0_nt cf2_t cf2_nt cf4_t cf4_nt cf5_t cf5_nt cf6_t cf6_nt cf7_t cf7_nt

* cf=0 T  (baseline)
import excel "Validation_GER_output_subsidy_notax_basef.xlsx", sheet("GER_0") cellrange(A2:Q1001) clear
rename A psi
rename E sdom
rename O Ld_alt
rename P I_alt
keep psi sdom Ld_alt I_alt
gen sector = 1
gen cf     = 0
save `cf0_t'

* cf=0 NT (baseline)
import excel "Validation_GER_output_subsidy_notax_basef.xlsx", sheet("GER_nt_0") cellrange(A2:N1001) clear
rename A psi
rename D sdom
rename L Ld_alt
rename M I_alt
keep psi sdom Ld_alt I_alt
gen sector = 0
gen cf     = 0
save `cf0_nt'

* cf=2 T  (Policy 2 -- top10)
import excel "Validation_GER_output_subsidy_notax_top10.xlsx", sheet("GER") cellrange(A2:Q1001) clear
rename A psi
rename E sdom
rename O Ld_alt
rename P I_alt
keep psi sdom Ld_alt I_alt
gen sector = 1
gen cf     = 2
save `cf2_t'

* cf=2 NT
import excel "Validation_GER_output_subsidy_notax_top10.xlsx", sheet("GER_nt") cellrange(A2:N1001) clear
rename A psi
rename D sdom
rename L Ld_alt
rename M I_alt
keep psi sdom Ld_alt I_alt
gen sector = 0
gen cf     = 2
save `cf2_nt'

* cf=4 T  (Policy 1 -- basef post-shock)
import excel "Validation_GER_output_subsidy_notax_basef.xlsx", sheet("GER") cellrange(A2:Q1001) clear
rename A psi
rename E sdom
rename O Ld_alt
rename P I_alt
keep psi sdom Ld_alt I_alt
gen sector = 1
gen cf     = 4
save `cf4_t'

* cf=4 NT
import excel "Validation_GER_output_subsidy_notax_basef.xlsx", sheet("GER_nt") cellrange(A2:N1001) clear
rename A psi
rename D sdom
rename L Ld_alt
rename M I_alt
keep psi sdom Ld_alt I_alt
gen sector = 0
gen cf     = 4
save `cf4_nt'

* cf=5 T  (Policy 3 -- bottom_onlyt)
import excel "Validation_GER_output_subsidy_notax_bottom_onlyt.xlsx", sheet("GER") cellrange(A2:Q1001) clear
rename A psi
rename E sdom
rename O Ld_alt
rename P I_alt
keep psi sdom Ld_alt I_alt
gen sector = 1
gen cf     = 5
save `cf5_t'

* cf=5 NT
import excel "Validation_GER_output_subsidy_notax_bottom_onlyt.xlsx", sheet("GER_nt") cellrange(A2:N1001) clear
rename A psi
rename D sdom
rename L Ld_alt
rename M I_alt
keep psi sdom Ld_alt I_alt
gen sector = 0
gen cf     = 5
save `cf5_nt'

* cf=6 T  (Policy 4 -- top_onlyt)
import excel "Validation_GER_output_subsidy_notax_top_onlyt.xlsx", sheet("GER") cellrange(A2:Q1001) clear
rename A psi
rename E sdom
rename O Ld_alt
rename P I_alt
keep psi sdom Ld_alt I_alt
gen sector = 1
gen cf     = 6
save `cf6_t'

* cf=6 NT
import excel "Validation_GER_output_subsidy_notax_top_onlyt.xlsx", sheet("GER_nt") cellrange(A2:N1001) clear
rename A psi
rename D sdom
rename L Ld_alt
rename M I_alt
keep psi sdom Ld_alt I_alt
gen sector = 0
gen cf     = 6
save `cf6_nt'

* cf=7 T  (Figure D2 -- nobasef)
import excel "Validation_GER_output_subsidy_notax_nobasef.xlsx", sheet("GER") cellrange(A2:Q1001) clear
rename A psi
rename E sdom
rename O Ld_alt
rename P I_alt
keep psi sdom Ld_alt I_alt
gen sector = 1
gen cf     = 7
save `cf7_t'

* cf=7 NT
import excel "Validation_GER_output_subsidy_notax_nobasef.xlsx", sheet("GER_nt") cellrange(A2:N1001) clear
rename A psi
rename D sdom
rename L Ld_alt
rename M I_alt
keep psi sdom Ld_alt I_alt
gen sector = 0
gen cf     = 7
save `cf7_nt'

* Stack all 12 blocks
use `cf0_t', clear
append using `cf0_nt'
append using `cf2_t'
append using `cf2_nt'
append using `cf4_t'
append using `cf4_nt'
append using `cf5_t'
append using `cf5_nt'
append using `cf6_t'
append using `cf6_nt'
append using `cf7_t'
append using `cf7_nt'

*-------------------------------------------------------------------------------
* Build the cell-level quantities in Figures D1 and D2 plot
*-------------------------------------------------------------------------------

* Firm IDs so the cf=0 productivity decile can be propagated to all rows
sort psi
egen firm = group(psi)
sort firm cf

* Immigrant share of the wage bill
gen sfor = 1 - sdom

* Productivity deciles -- pooled across NT and T, defined on the cf=0 sample.
* Matches the policy design (cuts at the pooled-median psi in master.m).
xtile decile_psi = psi if cf==0, nq(10)
by firm, sort: egen size_dec = max(decile_psi)

* Median immigrant share by (decile x sector x cf) -- right-axis line series
by size_dec sector cf, sort: egen sfor_med_size_sector = median(sfor)

* Native- and immigrant-employment totals per (decile x sector x cf)
bysort size_dec cf sector: egen tot_natives_size_sector = sum(Ld_alt)
bysort size_dec cf sector: egen tot_imm_size_sector     = sum(I_alt)

* Baseline (cf==0) totals broadcast to all cf cells in the same (decile, sector)
gen natives_baseline = tot_natives_size_sector if cf==0
gen imm_baseline     = tot_imm_size_sector     if cf==0
bysort sector size_dec: egen natives_baseline_agg = mean(natives_baseline)
bysort sector size_dec: egen imm_baseline_agg     = mean(imm_baseline)

* Change vs. baseline (model effective-labor units)
gen diff_level_cf_baseline     = tot_natives_size_sector - natives_baseline_agg
gen diff_level_cf_baseline_imm = tot_imm_size_sector     - imm_baseline_agg

*-------------------------------------------------------------------------------
* Figure D1 (Appendix D.2) and Figure D2 (Appendix D.3)
*-------------------------------------------------------------------------------

preserve

* Scale model effective-unit changes to thousands of workers
local scale = 35574.74425262905 / 1000
gen chg_nat_th = diff_level_cf_baseline     * `scale'
gen chg_imm_th = diff_level_cf_baseline_imm * `scale'

* One row per (size_dec, sector, cf); values are constant within each cell
collapse (firstnm) chg_nat_th chg_imm_th sfor_med_size_sector, ///
    by(size_dec sector cf)

* Express the median immigrant share on the right Y-axis as a percent
replace sfor_med_size_sector = sfor_med_size_sector * 100

* x positions
gen xpos     = size_dec + (sector==1)*11
gen xpos_nat = xpos - 0.22
gen xpos_imm = xpos + 0.22

* ---- Figure D1: 4-panel combine over Policies 1-4 ----
* Per-panel y-axis ranges match the Excel draft of Figure D1 in the paper
* so that the median-share lines are placed consistently across panels
* (in particular, panel (a)'s right axis must extend below zero).
local panels D1_p1 D1_p2 D1_p3 D1_p4
local cfvals 4 2 5 6
local titles `" "(a) Policy 1" "(b) Policy 2" "(c) Policy 3" "(d) Policy 4" "'

local ylab1_1 "-400(200)1000"
local ylab1_2 "-400(200)1400"
local ylab1_3 "-80(20)60"
local ylab1_4 "-500(500)4000"

local ylab2_1 "-12(5)28"
local ylab2_2 "-3(2)9"
local ylab2_3 "-15(5)10"
local ylab2_4 "-1(1)9"

* Excel-like colors: light green (matches Figure 4) and light Office blue
local col_nat "167 200 137"
local col_imm "91 155 213"

forvalues i = 1/4 {
    local cfval  : word `i' of `cfvals'
    local pname  : word `i' of `panels'
    local ptitle : word `i' of `titles'
    local yl1    "`ylab1_`i''"
    local yl2    "`ylab2_`i''"

    twoway ///
        (bar chg_nat_th xpos_nat if cf==`cfval', ///
             barw(0.42) color("`col_nat'") lwidth(none)) ///
        (bar chg_imm_th xpos_imm if cf==`cfval', ///
             barw(0.42) color("`col_imm'") lwidth(none)) ///
        (connected sfor_med_size_sector xpos if cf==`cfval' & sector==0, ///
             yaxis(2) lpattern(shortdash) lcolor(black) ///
             mcolor(black) msymbol(none) lwidth(thin)) ///
        (connected sfor_med_size_sector xpos if cf==`cfval' & sector==1, ///
             yaxis(2) lpattern(dash_dot) lcolor(black) ///
             mcolor(black) msymbol(none) lwidth(thin)), ///
        xlabel(1 "1" 2 "2" 3 "3" 4 "4" 5 "5" 6 "6" 7 "7" 8 "8" 9 "9" 10 "10" ///
               12 "1" 13 "2" 14 "3" 15 "4" 16 "5" 17 "6" 18 "7" 19 "8" 20 "9" 21 "10", ///
               labsize(vsmall)) ///
        xtitle("Productivity deciles" ///
               "Non-tradable                                      Tradable", ///
               size(small)) ///
        ytitle("Change vs. baseline (thousands)", size(vsmall)) ///
        ytitle("Immigrant share of wage bill (%)", axis(2) size(vsmall)) ///
        ylabel(`yl1', axis(1) labsize(vsmall) angle(0) format(%9.0fc)) ///
        ylabel(`yl2', axis(2) labsize(vsmall) angle(0) format(%4.0f)) ///
        legend(order(1 "Natives" 2 "Immigrants" ///
                     3 "Median share NT" 4 "Median share T") ///
               rows(1) size(vsmall) region(lcolor(white))) ///
        title(`ptitle', size(small)) ///
        graphregion(color(white)) plotregion(color(white)) ///
        name(`pname', replace)
}

* Combine the four panels with a single shared legend
grc1leg2 D1_p1 D1_p2 D1_p3 D1_p4, ///
    cols(2) iscale(0.7) ///
    legendfrom(D1_p1) ///
    graphregion(color(white))
graph export "${base}/output/figures/figure_D1.jpg", replace width(2800)


* ---- Figure D2: single panel, cf=7 (nobasef) ----
* Same styling as Figure D1: matched left/right y-axis ranges to the Excel
* draft of D2 (both -30 to 40), Excel-like green/blue colors (reused from
* the D1 block above), single-row legend, no title, abbreviated left ytitle.
twoway ///
    (bar chg_nat_th xpos_nat if cf==7, ///
         barw(0.42) color("`col_nat'") lwidth(none)) ///
    (bar chg_imm_th xpos_imm if cf==7, ///
         barw(0.42) color("`col_imm'") lwidth(none)) ///
    (connected sfor_med_size_sector xpos if cf==7 & sector==0, ///
         yaxis(2) lpattern(shortdash) lcolor(black) ///
         mcolor(black) msymbol(none) lwidth(thin)) ///
    (connected sfor_med_size_sector xpos if cf==7 & sector==1, ///
         yaxis(2) lpattern(dash_dot) lcolor(black) ///
         mcolor(black) msymbol(none) lwidth(thin)), ///
    xlabel(1 "1" 2 "2" 3 "3" 4 "4" 5 "5" 6 "6" 7 "7" 8 "8" 9 "9" 10 "10" ///
           12 "1" 13 "2" 14 "3" 15 "4" 16 "5" 17 "6" 18 "7" 19 "8" 20 "9" 21 "10", ///
           labsize(small)) ///
    xtitle("Productivity deciles" ///
           "Non-tradable                                      Tradable") ///
    ytitle("Change vs. baseline (thousands)", size(vsmall)) ///
    ytitle("Immigrant share of wage bill (%)", axis(2) size(vsmall)) ///
    ylabel(-30(10)40, axis(1) angle(0)) ///
    ylabel(-30(10)40, axis(2) angle(0) format(%4.0f)) ///
    legend(order(1 "Natives" 2 "Immigrants" ///
                 3 "Median share NT" 4 "Median share T") ///
           rows(1) size(vsmall) region(lcolor(white))) ///
    graphregion(color(white)) plotregion(color(white)) ///
    name(D2, replace) xsize(8) ysize(5)
graph export "${base}/output/figures/figure_D2.jpg", replace width(1800)

restore
