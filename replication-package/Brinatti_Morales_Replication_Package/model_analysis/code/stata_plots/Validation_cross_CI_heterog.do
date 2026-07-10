clear all
set more off
set matsize 5000
set scheme s1color

cd "${base}/output/intermediate/heterogeneous"

*-------------------------------------------------------------------------------
* Build panel: T and NT sectors x baseline (t=0) and CF equilibrium (t=1)
*-------------------------------------------------------------------------------
* Only the columns needed for Figure 3 are kept:
*   T  sheets (GER_0, GER):       A=psi, B=f, L=rev, S=I_Ld_alt
*   NT sheets (GER_nt_0, GER_nt): A=psi, B=f, J=rev, P=I_Ld_alt
*   I_Ld_alt = (wimm * I_alt) / (wd * Ld_alt) = relative immigrant-native wage bill

* T, baseline
import excel "Results_GER_Baseline.xlsx", sheet("GER_0") cellrange(A2:S1001) clear
keep A B L S
rename (A B L S) (psi f rev I_Ld_alt)
gen sector = 1
gen t      = 0
tempfile t1_0
save `t1_0'

* NT, baseline
import excel "Results_GER_Baseline.xlsx", sheet("GER_nt_0") cellrange(A2:P1001) clear
keep A B J P
rename (A B J P) (psi f rev I_Ld_alt)
gen sector = 0
gen t      = 0
tempfile t0_0
save `t0_0'

* T, CF equilibrium
import excel "Results_GER_Baseline.xlsx", sheet("GER") cellrange(A2:S1001) clear
keep A B L S
rename (A B L S) (psi f rev I_Ld_alt)
gen sector = 1
gen t      = 1
tempfile t1_1
save `t1_1'

* NT, CF equilibrium
import excel "Results_GER_Baseline.xlsx", sheet("GER_nt") cellrange(A2:P1001) clear
keep A B J P
rename (A B J P) (psi f rev I_Ld_alt)
gen sector = 0
gen t      = 1
append using `t1_1'
append using `t0_0'
append using `t1_0'

*-------------------------------------------------------------------------------
* Panel structure and size deciles (based on baseline revenue)
*-------------------------------------------------------------------------------
sort psi f
egen firm = group(psi f)
xtset firm t

xtile decile_rev = rev if t==0, nq(10)
by firm, sort: egen size_dec = max(decile_rev)

*-------------------------------------------------------------------------------
* Merge empirical data: mean revenue and immigrant-native ratio by decile-sector
*-------------------------------------------------------------------------------
preserve
import excel "${base}/data/inputs/Validation_data.xlsx", ///
    sheet("Sheet4") cellrange(A1:M21) firstrow clear
tempfile data_emp
save `data_emp'
restore

merge m:1 size_dec sector using `data_emp'
drop _merge
rename meansales rev_mean_dec_bse
rename meanratio ratio_mean_dec_bse

*-------------------------------------------------------------------------------
* Model elasticities
*-------------------------------------------------------------------------------
sort firm t
gen rev_hat     = D.rev/L.rev
gen imm_nat_hat = D.I_Ld_alt

gen rev_hat_trim_1     = rev_hat
gen imm_nat_hat_trim_1 = imm_nat_hat



foreach s in 0 1 {
    foreach var in rev_hat_trim_1 imm_nat_hat_trim_1 {
        sum `var' if sector==`s', d
        replace `var' = r(p99) if `var' > r(p99) & sector==`s' & t==1
        replace `var' = r(p1)  if `var' < r(p1)  & sector==`s' & t==1
    }
}

* Elasticity = (% change in outcome) / (immigration shock of 0.2)
gen elasticity_trim_1       = rev_hat_trim_1     / 0.2
gen elasticity_ratio_trim_1 = imm_nat_hat_trim_1 / 0.2

by size_dec sector, sort: egen elast_rev_t1 = mean(elasticity_trim_1)       if t==1
by size_dec sector, sort: egen elast_rat_t1 = mean(elasticity_ratio_trim_1) if t==1

*-------------------------------------------------------------------------------
* Figure 3: Immigration effects by Firm Size (Data vs. Model)
*-------------------------------------------------------------------------------

preserve

duplicates drop size_dec sector if t==1, force
keep if t==1

rename elast_rev_t1       model_rev
rename elast_rat_t1       model_rat
rename rev_mean_dec_bse   data_rev
rename ratio_mean_dec_bse data_rat

keep size_dec sector model_rev model_rat data_rev data_rat

* Step 1: subtract decile-1 reference value within each sector
foreach var in model_rev model_rat data_rev data_rat {
    bysort sector (size_dec): gen `var'_d = `var' - `var'[1]
}

* Step 2: rescale model so its average |diff| matches data's average |diff|
foreach v in rev rat {
    bysort sector: egen avg_d_`v' = mean(abs(data_`v'_d))
    bysort sector: egen avg_m_`v' = mean(abs(model_`v'_d))
    gen model_`v'_p = model_`v'_d * avg_d_`v' / avg_m_`v'
}

sort sector size_dec

* 4-panel paper figure (Figure 3) - styling matched to the Excel draft:
*   - legend inside each subplot at upper-left, vertical, no surrounding box
*   - subplot titles + axis text in small fonts
*   - per-panel y-axis ticks given as explicit value-label pairs so the
*     decimal formatting matches the draft exactly (e.g. "0.5" not "0.50",
*     but "0.05" not "0.1" where small steps require two decimals)
local xax    xlabel(1(1)10, labsize(small)) xtitle("Size decile (1 smallest - 10 largest)", size(small))
local style  graphregion(color(white)) plotregion(color(white)) ysize(5) xsize(6.5)
local legopt  legend(order(1 "Model" 2 "Data") cols(1) ring(0) position(11) ///
                     region(lstyle(none)) size(small) bmargin(zero))
* Panel (d) places the legend at lower-left so it doesn't overlap the
* downward-trending series.
local legopt_d legend(order(1 "Model" 2 "Data") cols(1) ring(0) position(7) ///
                      region(lstyle(none)) size(small) bmargin(zero))

local ylab_a `"0 "0" 0.5 "0.5" 1 "1" 1.5 "1.5" 2 "2" 2.5 "2.5" 3 "3" 3.5 "3.5""'
local ylab_b `"-0.05 "-0.05" -0.03 "-0.03" -0.01 "-0.01" 0.01 "0.01" 0.03 "0.03" 0.05 "0.05""'
local ylab_c `"0 "0" 0.05 "0.05" 0.1 "0.1" 0.15 "0.15" 0.2 "0.2" 0.25 "0.25" 0.3 "0.3" 0.35 "0.35" 0.4 "0.4" 0.45 "0.45" 0.5 "0.5""'
local ylab_d `"-0.25 "-0.25" -0.2 "-0.2" -0.15 "-0.15" -0.1 "-0.1" -0.05 "-0.05" 0 "0""'

twoway (connected model_rev_p size_dec if sector==1, lcolor(navy) mcolor(navy) msymbol(O)) ///
       (connected data_rev_d  size_dec if sector==1, lcolor(red)  mcolor(red)  msymbol(O) lpattern(dash)) ///
       , ytitle("Revenue elasticity", size(small)) `xax' ylabel(`ylab_a', labsize(small) angle(horizontal)) ///
         title("(a) Revenues - Tradable sector", size(small)) `legopt' `style' name(g1, replace)

twoway (connected model_rev_p size_dec if sector==0, lcolor(navy) mcolor(navy) msymbol(O)) ///
       (connected data_rev_d  size_dec if sector==0, lcolor(red)  mcolor(red)  msymbol(O) lpattern(dash)) ///
       , ytitle("Revenue elasticity", size(small)) `xax' ylabel(`ylab_b', labsize(small) angle(horizontal)) ///
         title("(b) Revenues - Non-Tradable sector", size(small)) `legopt' `style' name(g2, replace)

twoway (connected model_rat_p size_dec if sector==1, lcolor(navy) mcolor(navy) msymbol(O)) ///
       (connected data_rat_d  size_dec if sector==1, lcolor(red)  mcolor(red)  msymbol(O) lpattern(dash)) ///
       , ytitle("Change in imm to native ratio", size(small)) `xax' ylabel(`ylab_c', labsize(small) angle(horizontal)) ///
         title("(c) Relative Wage Bill - Tradable sector", size(small)) `legopt' `style' name(g3, replace)

twoway (connected model_rat_p size_dec if sector==0, lcolor(navy) mcolor(navy) msymbol(O)) ///
       (connected data_rat_d  size_dec if sector==0, lcolor(red)  mcolor(red)  msymbol(O) lpattern(dash)) ///
       , ytitle("Change in imm to native ratio", size(small)) `xax' ylabel(`ylab_d', labsize(small) angle(horizontal)) ///
         title("(d) Relative Wage Bill - Non-Tradable sector", size(small)) `legopt_d' `style' name(g4, replace)

graph combine g1 g2 g3 g4, cols(2) ///
    graphregion(color(white)) ysize(10) xsize(13) iscale(*0.9)
graph export "${base}/output/figures/figure_3.jpg", replace width(2800) height(2100)

restore

