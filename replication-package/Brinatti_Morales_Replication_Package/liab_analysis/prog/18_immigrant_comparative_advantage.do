cap log close
log using "${log}/18_immigrant_comparative_advantage.log", replace

* Immigrant comparative advantage: occupational sorting and wage regressions
* Agostina Brinatti & Nicolas Morales
* Source data: LIAB Longitudinal Model (version 1993-2014), IAB

/*	This dofile documents immigrant specialisation in manual-intensive
	occupations and provides evidence of comparative advantage (Appendix A.6).

	Output tables in this dofile:
	  Table 1  - Table A6, Panel A: Relative occupational sorting by origin
	  Table 2  - Table A6, Panel B: Relative demographic characteristics
	  Table 3  - Table A7: Manual-to-language sorting and comparative advantage
	  Table 4  - Table A8 (part 1): Task intensity by time in Germany, nat. 1-5
	  Table 5  - Table A8 (part 2): Task intensity by time in Germany, nat. 6-10
	  Table 6  - Figure A9 underlying coefficients: sorting FE and wage beta

	FDZ note: N (unweighted) reported via di after each regression
	  (stats(N N_clust) in estout calls). Table 1 counts are reported
	  via list so the FDZ can verify all cells have >= 20 observations.

	nation_single codes:
	  1=Germany, 2=High-income EU, 3=EU middle-income, 4=New EU members,
	  5=Turkey, 6=Former Yugoslavia, 7=Europe non-EU,
	  8=Asia-Pacific, 9=Africa & Middle East, 10=Americas
*/

/*==============================================================================
  COMPARATIVE ADVANTAGE OF IMMIGRANTS
  Brinatti & Morales (2026) - "Firm Heterogeneity and the Impact of Immigration:
  Evidence from German Establishments"

  This do-file produces:
    - Table A6  : Relative occupational sorting and demographics by origin
                  (Panel A: tabulations
 Panel B: mean age, share female, share college)
    - Table A7  : Manual-to-language occupation sorting and comparative advantage
                  (Equations 22 and 23 in the paper)
    - Table A8  : Manual-to-language task intensity by time in Germany
                  (Equation 24 in the paper)
    - Table A9  : Occupational sorting vs. comparative advantage
                  (country FEs from eq. 22 vs. beta_o coefficients from eq. 23,
                   with 95% confidence intervals)
==============================================================================*/

clear
set more off
set matsize 10000
set linesize 255
set seed 1234

capture adopath++ ${prog}

*FDZ: duplicate log removed — log opened at top of file
*capture log close
*log using "${log}/4a_immigrant_comparative_advantage.log", replace

/*------------------------------------------------------------------------------
  1. LOAD AND PREPARE DATA
------------------------------------------------------------------------------*/

use "${data}/individual_level_liab.dta", clear
compress

* Restrict to working-age population and sample period (2003–2011)
drop if age > 65
drop if age < 19
keep if jahr >= 2003 & jahr <= 2011

* Drop unused variables
drop idnum begorig endorig begepi endepi quelle spell wo_bula west_wo ///
     occ tent_dup rank avg_german w93_3_gen

* Merge in manual/language task content by occupation (Peri & Sparber crosswalk)

merge m:1 beruf_gr using "${orig}/Onet_Peri_Sparber_beruf_gr.dta"
keep if _merge == 3
drop _merge

* Merge in Blossfeld broad occupation classification
merge m:1 beruf_gr using "${data}/crosswalk_beruf_gr_blossfeld.dta"
drop _merge

* Construct key variables
gen man_lang      = manual / language        // Ratio of manual to language task content
gen daily_wage_l  = log(daily_wage)          // Log daily wage
gen years_in_mkt  = age - age_first          // Years in German labor market

* Binary: 1 if worker has >= 10 years in the labor market (used in Table A8)
gen years_in_mkt_cat = (years_in_mkt >= 10)

/*==============================================================================
  TABLE A6 — Relative occupational sorting and demographics by origin
  Brinatti & Morales (2026)

  Replicates the exact layout of Table A6 in the paper:

  Panel A: Each cell = share of nationality group n in occupation occ /
           share of Germans in occupation occ.
           Rows = 12 Blossfeld occupations (occ_bl 1–12, excluding 0=missing).
           Columns = All immigrants, + 9 individual origin groups (nation_single 2–10).

  Panel B: Each cell = mean characteristic of nationality group n /
           mean characteristic of Germans.
           Rows = Share college, Share female, Age.
           Columns = same as Panel A.

  nation_single codes:
    1 = Germany
    2 = High-income Europe (France, UK, Netherlands, Belgium, Austria,
        Switzerland, Finland, Sweden)
    3 = EU middle-income (Italy, Spain, Greece, Portugal)
    4 = New EU member states (joined 2004)
    5 = Turkey
    6 = Former Yugoslavia (non-EU)
    7 = Europe non-EU (incl. Russia)
    8 = Asia-Pacific
    9 = Africa & Middle East
   10 = Americas

  occ_bl codes (Blossfeld classification):
    1  = Agriculture
    2  = Unskilled Manual
    3  = Skilled Manual
    4  = Technicians
    5  = Engineers
    6  = Unskilled Services
    7  = Skilled Services
    8  = Semi-Professions
    9  = Professions
   10  = Unskilled Commercial and Admin
   11  = Skilled Commercial and Admin
   12  = Managers
==============================================================================*/

/*------------------------------------------------------------------------------
  PANEL B SCALARS — compute BEFORE any preserve/restore so they survive
  We need German and all-immigrant means for age, female, college.
  Do this first on the full individual-level data.
------------------------------------------------------------------------------*/

* German baseline means
quietly sum age      if nation_single == 1
scalar ger_age     = r(mean)
quietly sum frau    if nation_single == 1
scalar ger_female  = r(mean)
quietly sum college1 if nation_single == 1
scalar ger_college = r(mean)

* All-immigrant means
quietly sum age      if nation_single != 1
scalar imm_age     = r(mean)
quietly sum frau    if nation_single != 1
scalar imm_female  = r(mean)
quietly sum college1 if nation_single != 1
scalar imm_college = r(mean)

* All-immigrant unweighted N (for Panel B)
quietly count if nation_single != 1
scalar imm_n = r(N)

/*------------------------------------------------------------------------------
  PANEL A: Relative occupational sorting
  Single preserve/restore — no nesting.
------------------------------------------------------------------------------*/

preserve

  drop if occ_bl == 0 | occ_bl == .

  * Shares within each nationality × occupation cell
  bysort nation_single occ_bl: gen n_nation_occ = _N
  bysort nation_single:        gen n_nation      = _N
  gen share_nation_occ = n_nation_occ / n_nation

  * Shares for the pooled all-immigrants group × occupation
  gen all_imm = (nation_single != 1)
  bysort all_imm occ_bl: gen n_imm_occ = _N
  bysort all_imm:        gen n_imm     = _N
  gen share_imm_occ = n_imm_occ / n_imm

  * German baseline share per occupation
  gen share_german_occ = .
  levelsof occ_bl, local(occs)
  quietly {
    foreach o of local occs {
      sum share_nation_occ if nation_single == 1 & occ_bl == `o'
      replace share_german_occ = r(mean) if occ_bl == `o'
    }
  }

  * Relative shares
  gen rel_share_nation = share_nation_occ / share_german_occ
  gen rel_share_imm    = share_imm_occ    / share_german_occ

  * Broadcast rel_share_imm from the all_imm==1 rows to every row of that occ_bl,
  * so we carry the all-immigrants column through without a nested preserve.
  bysort occ_bl: egen rel_all_imm = mean(cond(all_imm == 1, rel_share_imm, .))

  * FDZ: broadcast German counts (denominator baseline) to all rows so they
  * survive the drop of nation_single == 1 (Guidelines §4.5).
  bysort occ_bl: egen n_german_occ = total(n_nation_occ * (nation_single == 1))
  quietly sum n_nation if nation_single == 1
  gen n_german = r(mean)   // same for all rows; total German workers in sample

  * FDZ: broadcast all-immigrants counts to all rows
  bysort occ_bl: egen n_imm_occ_all = total(n_imm_occ * (all_imm == 1))
  quietly sum n_imm if all_imm == 1
  gen n_imm_all = r(mean)

  * One row per (nationality, occupation); drop Germans (baseline by construction)
  duplicates drop nation_single occ_bl, force
  drop if nation_single == 1

  * FDZ: keep numerator (n_nation_occ) and denominator (n_nation) so that
  * absolute counts for each share can be verified (Guidelines §4.5).
  * Also keep German baseline counts and all-immigrants counts.
  keep occ_bl nation_single rel_share_nation rel_all_imm ///
       n_nation_occ n_nation n_german_occ n_german n_imm_occ_all n_imm_all
	   
	   
	   
drop if nation_single==.
	   
  reshape wide rel_share_nation n_nation_occ n_nation, i(occ_bl) j(nation_single)

  * Occupation labels
  label define occ_lbl                  ///
    1  "Agriculture"                    ///
    2  "Unskilled Manual"               ///
    3  "Skilled Manual"                 ///
    4  "Technicians"                    ///
    5  "Engineers"                      ///
    6  "Unskilled Services"             ///
    7  "Skilled Services"               ///
    8  "Semi-Professions"               ///
    9  "Professions"                    ///
    10 "Unskilled Commercial & Admin"   ///
    11 "Skilled Commercial & Admin"     ///
    12 "Managers"
  label values occ_bl occ_lbl

  foreach v of varlist rel_all_imm rel_share_nation* {
    replace `v' = round(`v', 0.01)
  }

  sort occ_bl


****************************
* Table 1
* Table A6, Panel A: Relative occupational sorting by origin group
****************************

* Variables: rel_share_nation2-10 (share of origin group in occupation /
*   share of Germans in same occupation); rel_all_imm (pooled immigrants);
*   N_workers_occ2-10 (unweighted worker count per nationality x occupation cell);
*   occ_bl (Blossfeld occupation category, 12 groups)
* Selection: Working-age (19-65), 2003-2011
* Ratios > 1 indicate over-representation relative to Germans.
* All cells must have >= 20 observations; N_workers_occ columns verify this.

  di  " Yugosl(6) | EurNonEU(7) | Asia(8) | Africa(9) | Americas(10)"
  di ""

  * FDZ: German baseline counts (n_german_occ = workers per occupation;
  * n_german = total German workers; both are denominators in the norming step).
  di "--- German baseline and all-immigrants counts by occupation ---"
  tabdisp occ_bl, c(n_german_occ) concise
  * n_german and n_imm_all are scalar (same across all occ_bl rows)
  di "n_german (total German workers in sample):  " n_german[1]
  di "n_imm_all (total all-immigrant workers):    " n_imm_all[1]

  di "--- All-immigrants workers per occupation (numerator of rel_all_imm) ---"
  tabdisp occ_bl, c(n_imm_occ_all) concise

  * FDZ: Denominator — total workers per nationality group (n_nation).
  * n_nation is constant within nationality (total workers of that group),
  * used as the denominator of share_nation_occ before norming by Germans.
  di "--- Denominator: total workers per nationality group (n_nation) ---"
  forvalues n = 2/10 {
      di "  nation_single = " `n' ":  n_nation = " n_nation`n'[1]
  }

  * FDZ: Numerator — workers per nationality x occupation cell (n_nation_occ).
  di "--- Numerator: workers per nationality x occupation cell (n_nation_occ) ---"
  forvalues n = 2/10 {
      tabdisp occ_bl, c(n_nation_occ`n') concise
  }

  * Relative shares (n_nation_occ/n_nation, normed to German baseline)
  di "--- Relative occupational shares (rel_share_nation = share_n / share_german) ---"
  tabdisp occ_bl, c(rel_all_imm) concise
  forvalues n = 2/10 {
      tabdisp occ_bl, c(rel_share_nation`n') concise
  }

restore

/*------------------------------------------------------------------------------
  PANEL B: Relative demographic characteristics
  Single preserve/restore — scalars from above are still in memory.
------------------------------------------------------------------------------*/

preserve

  collapse (mean) age frau college1 (count) N_workers = age, by(nation_single)

  * FDZ: compute raw counts — numerators of share_female and share_college
  gen N_female  = round(frau     * N_workers)   // workers who are female
  gen N_college = round(college1 * N_workers)   // workers who are college-educated

  gen rel_age     = round(age      / ger_age,     0.01)
  gen rel_female  = round(frau     / ger_female,  0.01)
  gen rel_college = round(college1 / ger_college, 0.01)

  * FDZ: store German baseline counts before dropping (denominators for all relative chars)
  quietly sum N_workers if nation_single == 1
  scalar ger_n        = r(mean)
  quietly sum N_female if nation_single == 1
  scalar ger_n_female  = r(mean)
  quietly sum N_college if nation_single == 1
  scalar ger_n_college = r(mean)

  * Drop Germans — they are the baseline (all ratios = 1.00 by construction)
  drop if nation_single == 1

  * All-immigrants relative values (from scalars computed before preserve)
  scalar rel_imm_age     = round(imm_age     / ger_age,     0.01)
  scalar rel_imm_female  = round(imm_female  / ger_female,  0.01)
  scalar rel_imm_college = round(imm_college / ger_college, 0.01)

  * Sort so rows 1–9 correspond to nation_single 2–10
  sort nation_single


****************************
* Table 2
* Table A6, Panel B: Relative demographic characteristics by origin group
****************************

* Variables: rel_age (mean age / mean German age), rel_female
*   (female share / German female share), rel_college (college share /
*   German college share); N_workers (unweighted worker count per origin group)
* nation_single: 1=Germany (omitted), 2=High-income EU, 3=EU middle-income,
*   4=New EU members, 5=Turkey, 6=Former Yugoslavia, 7=Europe non-EU,
*   8=Asia-Pacific, 9=Africa & Middle East, 10=Americas
* Selection: Working-age (19-65), 2003-2011


  di _col(1)  "Share college" ///
     _col(15) %5.2f scalar(rel_imm_college) ///
     _col(21) %5.2f rel_college[1] ///
     _col(27) %5.2f rel_college[2] ///
     _col(33) %5.2f rel_college[3] ///
     _col(39) %5.2f rel_college[4] ///
     _col(46) %5.2f rel_college[5] ///
     _col(53) %5.2f rel_college[6] ///
     _col(61) %5.2f rel_college[7] ///
     _col(67) %5.2f rel_college[8] ///
     _col(73) %5.2f rel_college[9]

  di _col(1)  "Share female" ///
     _col(15) %5.2f scalar(rel_imm_female) ///
     _col(21) %5.2f rel_female[1] ///
     _col(27) %5.2f rel_female[2] ///
     _col(33) %5.2f rel_female[3] ///
     _col(39) %5.2f rel_female[4] ///
     _col(46) %5.2f rel_female[5] ///
     _col(53) %5.2f rel_female[6] ///
     _col(61) %5.2f rel_female[7] ///
     _col(67) %5.2f rel_female[8] ///
     _col(73) %5.2f rel_female[9]

  di _col(1)  "Age" ///
     _col(15) %5.2f scalar(rel_imm_age) ///
     _col(21) %5.2f rel_age[1] ///
     _col(27) %5.2f rel_age[2] ///
     _col(33) %5.2f rel_age[3] ///
     _col(39) %5.2f rel_age[4] ///
     _col(46) %5.2f rel_age[5] ///
     _col(53) %5.2f rel_age[6] ///
     _col(61) %5.2f rel_age[7] ///
     _col(67) %5.2f rel_age[8] ///
     _col(73) %5.2f rel_age[9]

  * FDZ: German baseline raw counts (denominator for all relative characteristics)
  di "German baseline counts (nation_single = 1):"
  di _col(1)  "N workers (Germany)"  _col(15) %9.0f scalar(ger_n)
  di _col(1)  "N female  (Germany)"  _col(15) %9.0f scalar(ger_n_female)
  di _col(1)  "N college (Germany)"  _col(15) %9.0f scalar(ger_n_college)
  di ""

  * FDZ: immigrant group raw counts (numerator/denominator of each relative share)
  di "Immigrant group counts (N_workers = denominator; N_female/N_college = numerators):"
  di _col(1)  "N female" ///
     _col(15) %9.0f scalar(imm_n) * scalar(imm_female) ///
     _col(21) %9.0f N_female[1] _col(27) %9.0f N_female[2] ///
     _col(33) %9.0f N_female[3] _col(39) %9.0f N_female[4] ///
     _col(46) %9.0f N_female[5] _col(53) %9.0f N_female[6] ///
     _col(61) %9.0f N_female[7] _col(67) %9.0f N_female[8] ///
     _col(73) %9.0f N_female[9]

  di _col(1)  "N college" ///
     _col(15) %9.0f scalar(imm_n) * scalar(imm_college) ///
     _col(21) %9.0f N_college[1] _col(27) %9.0f N_college[2] ///
     _col(33) %9.0f N_college[3] _col(39) %9.0f N_college[4] ///
     _col(46) %9.0f N_college[5] _col(53) %9.0f N_college[6] ///
     _col(61) %9.0f N_college[7] _col(67) %9.0f N_college[8] ///
     _col(73) %9.0f N_college[9]
  di ""

  di _col(1)  "N workers" ///
     _col(15) %9.0f scalar(imm_n) ///
     _col(21) %9.0f N_workers[1] ///
     _col(27) %9.0f N_workers[2] ///
     _col(33) %9.0f N_workers[3] ///
     _col(39) %9.0f N_workers[4] ///
     _col(46) %9.0f N_workers[5] ///
     _col(53) %9.0f N_workers[6] ///
     _col(61) %9.0f N_workers[7] ///
     _col(67) %9.0f N_workers[8] ///
     _col(73) %9.0f N_workers[9]

  di "======================================================================"
  di "nation_single: 2=High-income EU, 3=Mid-income EU, 4=New EU,"
  di "               5=Turkey, 6=Former Yugoslavia, 7=Europe non-EU,"
  di "               8=Asia-Pacific, 9=Africa & Middle East, 10=Americas"

restore

/*------------------------------------------------------------------------------
  3. TABLE A7 — Manual-to-language occupation sorting and comparative advantage
                Columns 1–3: Equation (22) — sorting regressions
                Columns 4–5: Equation (23) — wage-differential regressions
------------------------------------------------------------------------------*/

* ---- Columns 1–2: Baseline sorting regressions (Equation 22) ----------------
* Dependent variable: manual/language task ratio of worker's occupation
* FE: establishment × year (compares workers within the same workplace)
* Col 1: immigrant dummy only

****************************
* Table 3
* Table A7: Occupational sorting and comparative advantage (equations 22-23)
****************************

* Variables: man_lang (manual/language task ratio of worker's occupation,
*   Peri & Sparber 2009); daily_wage_l (log daily wage)
* Cols 1-3 (eq. 22 — sorting): dep var = man_lang;
*   regressors: immigrant dummy / nationality dummies, optional demographics
* Cols 4-5 (eq. 23 — comparative advantage): dep var = daily_wage_l;
*   regressors: nationality x man_lang interaction
* FE: establishment x year (i.betnr#i.jahr) in all columns
* SE clustered at nationality group (nation_single, 10 groups)
* Selection: Working-age (19-65), 2003-2011
* N (unweighted) reported via di after each regression.

eststo man_lang_ger: ///
    quietly reghdfe man_lang ib1.german, ///
    absorb(i.betnr#i.jahr) cluster(nation_single)

* Col 2: nationality dummies (disaggregated by origin group)
* Country FEs from this regression are plotted on the x-axis of Figure A9
eststo man_lang_cty: ///
    quietly reghdfe man_lang i.nation_single, ///
    absorb(i.betnr#i.jahr) cluster(nation_single)

* ---- Column 3: Sorting controlling for worker demographics ------------------
* Controls: age, gender (frau), college education
eststo man_lang_dem_cty: ///
    quietly reghdfe man_lang age frau college1 i.nation_single, ///
    absorb(i.betnr#i.jahr) cluster(nation_single)

* ---- Columns 4–5: Comparative advantage — wage regressions (Equation 23) ---
* Dependent variable: log daily wage
* Key regressors: nationality × manual/language interaction (beta_o in the paper)
* A positive beta_o means the group earns a premium in manual-intensive occupations
* The beta_o coefficients are plotted on the y-axis of Figure A9

* Col 4: immigrant dummy interacted with man_lang (pooled)
eststo wage_ger: ///
    quietly reghdfe daily_wage_l ib1.german#c.man_lang man_lang ib1.german ///
    if daily_wage_l > 0, ///
    absorb(i.betnr#i.jahr) cluster(nation_single)

* Col 5: nationality dummies interacted with man_lang (disaggregated)
eststo wage_cty: ///
    quietly reghdfe daily_wage_l i.nation_single#c.man_lang man_lang i.nation_single ///
    if daily_wage_l > 0, ///
    absorb(i.betnr#i.jahr) cluster(nation_single)

* ---- Print Table A7 ----------------------------------------------------------
* Columns 1–2 (sorting), Column 3 (sorting with demographics) and 4–5 (comparative advantage)
esttab man_lang_ger man_lang_cty man_lang_dem_cty wage_ger wage_cty, ///
    se stats(N N_clust r2, fmt(%9.0g %9.0g %9.2f)) ///
    title("Table A7: Sorting and comparative advantage")

/*------------------------------------------------------------------------------
  4. TABLE A8 — Manual-to-language task intensity by time in Germany
                Equation (24): run separately for each nationality group
                Coefficient of interest: 1(years_in_mkt >= 10)
                nation_single values: 1=Germany, 2=High-income EU, 3=Mid-income EU,
                4=New EU members, 5=Turkey, 6=Former Yugoslavia,
                7=Europe non-EU, 8=Asia-Pacific, 9=Africa & Middle East, 10=Americas
------------------------------------------------------------------------------*/


****************************
* Tables 4-5
* Table A8: Task intensity by time in Germany (equation 24)
****************************

* Variables: man_lang (manual/language task ratio); years_in_mkt_cat
*   (=1 if >= 10 years in German labour market); age
* FE: establishment x year, gender x year, college x year
* SE clustered at worker level (persnr)
* Selection: Working-age (19-65), 2003-2011; one regression per nationality
* Coefficient of interest: 1(years_in_mkt >= 10) — tests skill upgrading
* N (unweighted) reported via di after each regression.
* Table 4 = nationalities 1-5; Table 5 = nationalities 6-10.

forvalues n = 1/10 {
    eststo man_lang`n': ///
        quietly reghdfe man_lang i.years_in_mkt_cat age if nation_single == `n', ///
        absorb(i.betnr#i.jahr i.frau#i.jahr i.college1#i.jahr) cluster(persnr)
}

* Print Table A8
esttab man_lang1 man_lang2 man_lang3 man_lang4 man_lang5, ///
    se stats(N N_clust r2, fmt(%9.0g %9.0g %9.2f)) ///
    title("Table A8 (part 1): Task intensity by time in Germany — nationalities 1–5")

esttab man_lang6 man_lang7 man_lang8 man_lang9 man_lang10, ///
    se stats(N N_clust r2, fmt(%9.0g %9.0g %9.2f)) ///
    title("Table A8 (part 2): Task intensity by time in Germany — nationalities 6–10")

/*------------------------------------------------------------------------------
  5. FIGURE A9 — Occupational sorting vs. comparative advantage
                 X-axis: country FEs from man_lang_cty  (Equation 22, col 2)
                 Y-axis: beta_o coefficients from wage_cty (Equation 23, col 5)
                 One dot per origin-country group (nations 2–10, i.e. non-Germans)
                 The positive slope shows that groups specialising in manual-
                 intensive tasks also earn a wage premium in those tasks.
------------------------------------------------------------------------------*/

* Extract country FEs from the sorting regression (Equation 22)
preserve
    reghdfe man_lang i.nation_single, ///
        absorb(i.betnr#i.jahr) cluster(nation_single)
    * Store nation FE coefficients
    matrix sorting_fe = r(table)
    * (In practice these are the i.nation_single coefficients from man_lang_cty above)
restore

/*------------------------------------------------------------------------------
  1. Extract sorting FEs from equation (22): man_lang_cty
     Parameters of interest: 2.nation_single ... 10.nation_single
------------------------------------------------------------------------------*/

estimates restore man_lang_cty

matrix b_sort = e(b)
matrix V_sort = e(V)

* nation_single runs 2–10; Germans (1) are the omitted base (ib1.nation_single)
* In the coefficient vector the names are "2.nation_single" ... "10.nation_single"

tempfile sorting
quietly {
    clear
    set obs 9
    gen nation_single = _n + 1          // 2, 3, ..., 10
    gen sorting_fe = .
    gen sorting_se = .

    forvalues n = 2/10 {
        local i = `n' - 1               // row index in our dataset
        local coln "`n'.nation_single"
        replace sorting_fe = b_sort[1, colnumb(b_sort, "`coln'")] if nation_single == `n'
        replace sorting_se = sqrt(V_sort[colnumb(b_sort, "`coln'"), ///
                                         colnumb(b_sort, "`coln'")]) if nation_single == `n'
    }

    gen sorting_lo = sorting_fe - 1.96 * sorting_se
    gen sorting_hi = sorting_fe + 1.96 * sorting_se
    save `sorting'
}

/*------------------------------------------------------------------------------
  2. Extract wage betas from equation (23): wage_cty
     Parameters of interest: 2.nation_single#c.man_lang ... 10.nation_single#c.man_lang
------------------------------------------------------------------------------*/

estimates restore wage_cty

matrix b_wage = e(b)
matrix V_wage = e(V)

tempfile wagebeta
quietly {
    clear
    set obs 9
    gen nation_single = _n + 1
    gen wage_beta = .
    gen wage_se   = .

    forvalues n = 2/10 {
        local coln "`n'.nation_single#c.man_lang"
        replace wage_beta = b_wage[1, colnumb(b_wage, "`coln'")] if nation_single == `n'
        replace wage_se   = sqrt(V_wage[colnumb(b_wage, "`coln'"), ///
                                        colnumb(b_wage, "`coln'")]) if nation_single == `n'
    }

    gen wage_lo = wage_beta - 1.96 * wage_se
    gen wage_hi = wage_beta + 1.96 * wage_se
    save `wagebeta'
}

/*------------------------------------------------------------------------------
  3. Merge and label
------------------------------------------------------------------------------*/

use `sorting', clear
merge 1:1 nation_single using `wagebeta', nogenerate

label define nat_lbl          ///
    2  "High-income EU"        ///
    3  "EU middle-income"      ///
    4  "New EU members"        ///
    5  "Turkey"                ///
    6  "Former Yugoslavia"     ///
    7  "Europe non-EU"         ///
    8  "Asia-Pacific"          ///
    9  "Africa & Middle East"  ///
    10 "Americas"
label values nation_single nat_lbl

/*------------------------------------------------------------------------------
  4. Table: sorting FE and wage beta side by side
------------------------------------------------------------------------------*/

format sorting_fe sorting_lo sorting_hi wage_beta wage_lo wage_hi %6.3f


****************************
* Table 6
* Figure A9: Sorting FE vs. wage beta by origin group
****************************

* Variables: sorting_fe (nationality FE from equation 22: relative
*   manual/language ratio within establishment-year, relative to Germans);
*   wage_beta (beta_o from equation 23: wage premium in manual-intensive
*   occupations relative to Germans); sorting_lo/hi and wage_lo/hi
*   (95% CIs computed as estimate +/- 1.96*SE)
* Selection: 9 non-German origin groups (nation_single 2-10)
* A positive correlation between sorting_fe and wage_beta is consistent
*   with comparative advantage in manual tasks.
* SE from nationality-clustered regressions (10 clusters — interpret with care).

list nation_single sorting_fe sorting_lo sorting_hi ///
                   wage_beta  wage_lo    wage_hi,    ///
     noobs sep(0) abbrev(20) subvarname divider

di ""
di "Notes: 95% CIs computed as estimate +/- 1.96*SE."
di "       Omitted group = Germans (nation_single = 1)."


/*==============================================================================
  FIGURE (added for JPE reproducibility deposit — not part of the original
  submission). This section does not modify any of the analysis above; it only
  plots the Figure A9 dataset already built and listed above, since Figure A9
  in the original submission was turned into a figure in Excel from this
  underlying table.

  NOTE ON EXACT APPEARANCE: the published Figure A9 was built by hand in
  Excel from this table (styling, colors, markers chosen by the authors).
  The Stata graph below plots the same underlying numbers but will not look
  pixel-identical to the paper's version (font, colors, marker style, axis
  formatting, etc. all differ) -- only the data displayed is the same.

  Output: liab_analysis/output/figure_A9.jpg
==============================================================================*/

set scheme s1color
global figout = subinstr("${prog}", "/prog", "/output", 1)
cap mkdir "${figout}"

twoway (scatter wage_beta sorting_fe, mcolor(navy) msymbol(O)), ///
       xline(0, lpattern(dot) lcolor(gs8)) yline(0, lpattern(dot) lcolor(gs8)) ///
       xtitle("Sorting FE (manual/language ratio, relative to Germans)", size(small)) ///
       ytitle("Wage beta (manual-task wage premium, relative to Germans)", size(small)) ///
       legend(off) graphregion(color(white)) plotregion(color(white)) ///
       ysize(4.5) xsize(6.5) ylabel(, format(%5.2f)) ///
       title("Figure A9: Occupational sorting vs. comparative advantage", size(medium)) ///
       name(figA9, replace)
graph export "${figout}/figure_A9.jpg", replace width(2000) height(1500)


log close

