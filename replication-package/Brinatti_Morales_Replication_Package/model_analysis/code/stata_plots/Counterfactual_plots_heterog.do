
clear all
set more off
set matsize 5000
set scheme s1color

* global base is set by scripts/master.do;

*-------------------------------------------------------------------------------
* Building the dataset
* Only the heterogeneous-open (cf=1) baseline is needed for Figure 4.
* Each sheet of Results_GER_Baseline.xlsx is imported and stacked:
*   GER_0    : tradable     sector (sector=1), initial equilibrium (t=0)
*   GER_nt_0 : non-tradable  sector (sector=0), initial equilibrium (t=0)
*   GER      : tradable     sector (sector=1), counterfactual     (t=1)
*   GER_nt   : non-tradable  sector (sector=0), counterfactual     (t=1)
* Only the two variables used by Figure 4 (rev, Ld_alt) are renamed.
*-------------------------------------------------------------------------------	

import excel "${base}/output/intermediate/heterogeneous/Results_GER_Baseline.xlsx", sheet("GER_0") cellrange(A2:Q1001) clear
rename L rev
rename O Ld_alt
gen firm_n = _n
gen sector = 1
gen t      = 0
gen cf     = 1


preserve
clear
import excel "${base}/output/intermediate/heterogeneous/Results_GER_Baseline.xlsx", sheet("GER_nt_0") cellrange(A2:N1001) clear
rename J rev
rename L Ld_alt
gen firm_n = _n
gen sector = 0
gen t      = 0
gen cf     = 1
tempfile temp
save `temp'
restore
append using `temp' 


preserve
clear 
import excel "${base}/output/intermediate/heterogeneous/Results_GER_Baseline.xlsx", sheet("GER") cellrange(A2:Q1001) clear
rename L rev
rename O Ld_alt
gen firm_n = _n
gen sector = 1
gen t      = 1
gen cf     = 1
tempfile temp2
save `temp2'
restore
append using `temp2' 


preserve
clear
import excel "${base}/output/intermediate/heterogeneous/Results_GER_Baseline.xlsx", sheet("GER_nt") cellrange(A2:N1001) clear
rename J rev
rename L Ld_alt
gen firm_n = _n
gen sector = 0
gen t      = 1
gen cf     = 1
tempfile temp3
save `temp3'
restore
append using `temp3' 


* Firm identifier (firm_n x sector), used to assign each firm to a single
* revenue decile based on its t=0 value.

egen firm = group(firm_n sector)


*-------------------------------------------------------------------------------
* Figure 4 (Section 6.1): native reallocation across firms in heterogeneous
* open economy.
*-------------------------------------------------------------------------------	
local total_natives_DE = 35574.74425262905

* Pooled deciles by revenue at heterog-open baseline (cf=1, t=0)
xtile decile_rev = rev if cf==1 & t==0, nq(10)
by firm, sort: egen rev_decile = max(decile_rev)
drop decile_rev

* Sum natives by (cf, t, sector, rev_decile)
bysort cf t sector rev_decile: egen tot_nat_rev = sum(Ld_alt)
duplicates drop cf t sector rev_decile, force
keep cf t sector rev_decile tot_nat_rev

* Per-cell share of total natives within each (cf, t)
bysort cf t: egen tot_t = sum(tot_nat_rev)
gen share = tot_nat_rev / tot_t

* Reshape so each (cf, rev_decile, sector) row carries share at t=0 and t=1
keep cf t sector rev_decile share
reshape wide share, i(rev_decile sector cf) j(t)

gen change_thousands = (share1 - share0) * `total_natives_DE'

label define sectorlbl 0 "Non-tradable" 1 "Tradable", replace
label values sector sectorlbl

* Figure 4
* Built with twoway bar (instead of graph bar) so that a vertical separator
* between the two sectors can be drawn via xline(). Bar styling, color, and
* value labels match the original graph bar version.

* Bar x-position: non-tradable at 1..10, tradable at 12..21 (gap at x=11)
gen xpos = rev_decile if sector == 0
replace xpos = rev_decile + 11 if sector == 1

* Per-bar value labels (above positive bars, below negative bars)
gen vlabel = string(change_thousands, "%4.1f")
gen lab_y  = change_thousands + cond(change_thousands >= 0, 1.2, -1.2)

twoway ///
    (bar change_thousands xpos if cf==1, color("167 200 137") lcolor(black) lwidth(thin) barwidth(0.8)) ///
    (scatter lab_y xpos if cf==1, msymbol(none) mlabel(vlabel) mlabposition(0) mlabsize(vsmall) mlabcolor(black)), ///
    xline(11, lcolor(gs6) lpattern(dash) lwidth(medthin)) ///
    yline(0, lcolor(black) lwidth(thin)) ///
    ylabel(-40(10)30, labsize(small) angle(horizontal) nogrid) ///
    yscale(range(-46 32)) ///
    xlabel(1 "1" 2 "2" 3 "3" 4 "4" 5 "5" 6 "6" 7 "7" 8 "8" 9 "9" 10 "10" ///
           12 "1" 13 "2" 14 "3" 15 "4" 16 "5" 17 "6" 18 "7" 19 "8" 20 "9" 21 "10", ///
           labsize(small) noticks) ///
    xscale(range(0.3 21.7)) ///
    xtitle("") ///
    ytitle("Change between CF and baseline (thousands)", size(small)) ///
    text(-44 5.5 "Non-tradable", size(medium) color(black) placement(c)) ///
    text(-44 16.5 "Tradable", size(medium) color(black) placement(c)) ///
    b1title("Size deciles", size(small)) ///
    legend(off) ///
    graphregion(color(white)) plotregion(color(white)) ///
    ysize(5) xsize(8) ///
    name(F4, replace)
graph export "${base}/output/figures/figure_4.jpg", replace width(2400) height(1500)


