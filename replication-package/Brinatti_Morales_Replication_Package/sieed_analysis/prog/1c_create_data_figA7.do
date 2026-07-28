********************************************************************************
* 1c_create_data_figA7.do
*
* Purpose:
*   Constructs the firm-year dataset used to produce Appendix Figure A7, which
*   plots the median immigrant share of the wage bill by establishment size bin
*   for the pre-enlargement period (2003-2010) and the post-enlargement period
*   (2015-2018). The figure provides descriptive evidence that the 2011 EU
*   enlargement reduced the fixed costs of hiring NMS immigrants, leading to a
*   convergence in immigrant intensity between small and large establishments.
*   See Appendix A.5 of the paper for discussion.
*
*
* Inputs:
*   ${orig}/sieed_7518_v1.dta             - Raw SIEED job-spell file
*   ${orig}/SIEED_7518_v1_bhp_basis_v1.dta - BHP establishment characteristics
*
* Outputs:
*   ${data}/firm_level_sieed_A7.dta - Firm-year panel (2003-2018) with
*                                     employment and wage-bill totals by
*                                     immigrant origin group, used in 2b_results_figA7.do
********************************************************************************


set seed 1234

log using "${log}/1c_create_data_figA7.log", replace


*Open SIEED
use "${orig}/sieed_7518_v1.dta", clear


gen jahr=year(begepi)




*Important line! keep one spell per worker and remove duplicates
keep if begepi == begorig

drop if betnr==.n


*Keep spells that have June 30th of each year
* Selects the annual June 30 cross-section, consistent with the standard IAB
* reference date used throughout the paper.

gen start_month=month(begorig)
gen end_month=month(endorig)

gen start_day=day(begorig)
gen end_day=day(endorig)

gen start_year=year(begorig)
gen end_year=year(endorig)

keep if (start_month<=6 & end_month>=6) & (start_day<=30 & end_day>=30)
keep if start_year==end_year


* When a worker holds multiple jobs on June 30, keep only the highest-paying
* spell to obtain one observation per worker-year.
bysort persnr jahr: egen max_wage=max(tentgelt)
keep if max_wage>=tentgelt-0.001 & max_wage<=tentgelt+0.001

duplicates drop persnr jahr, force

drop max_wage start_month end_month start_day end_day start_year end_year begorig endorig begepi endepi ausbildung schule beruf stib gleitz leih befrist grund alo_dau nation_gr spell



*************Defining Immigrants**************

* Identical immigrant assignment logic to 1a_create_data_event_study.do.
* See Appendix A.1 for the definition and robustness discussion.

*Find when workers join the labor market
bysort persnr: egen rank=rank(jahr), unique
gen new_entrant=(rank==1)


*Calculate tenure at firm

bysort persnr betnr: egen tenure=rank(jahr), unique


* Use the modal education value across all observed periods for each worker
* to reduce measurement error in the college indicator.
gen college=(ausbildung_imp==5 | ausbildung_imp==6)
replace college=. if ausbildung_imp==.z
bysort persnr: egen college1=mode(college), maxmode

drop college
rename college1 college


gen age=jahr-gebjahr


gen german=(nation==0)

*How many periods does the worker show up as german
bysort persnr: egen avg_german=mean(german) if nation!=.z

*Find those that through time show up as both german and non-german
gen citizenship_change=(avg_german>0 & avg_german<1 & nation!=.z)

gen always_german=(avg_german==1)


*How many periods workers show up as immigrants
bysort persnr: egen imm_count1=sum(1-german) if nation!=.z

*Total periods
bysort persnr: egen total_count1=sum(1) if nation!=.z

*Impute imm_count1 for those observations where for some periods citizenship is missing
bysort persnr: egen imm_count=mean(imm_count1)

*Impute total_count1 for those observations where for some periods citizenship is missing
bysort persnr: egen total_count=mean(total_count1)

*Create nationality proxy. First with those that always show up as german.
gen nation_single=nation if always_german==1

*Identify main citizenship group for those that sometime show up as foreign.
gen foreign_nation1=nation if nation!=.z & nation!=0
bysort persnr: egen foreign_nation=mode(foreign_nation1), minmode

*If you show up more than one period as a non-german citizen, impute that foreign citizenship
replace nation_single=foreign_nation if ((imm_count>1) | (imm_count==1 & total_count==1)) & imm_count!=.

*Count as German if you show up as a foreign citizenship just one period but work more than one period (might be data error)
replace nation_single=0 if imm_count==1 & total_count>1

*Some cases remaining where we just count them as german as long as they report german for at least one period.
replace nation_single=0 if nation_single==. & avg_german!=0

drop german-total_count foreign_nation1 foreign_nation


*Age at which you join the labor market
bysort persnr: egen year_first=min(jahr)
gen age_first=year_first-gebjahr


* Alternative narrow immigrant definition (robustness; not used for Fig A7).
gen nation_single_alt=nation_single
gen immigrant_not_enter=(nation_single_alt!=1 & ((age_first<=19 & college==0) | (age_first<=25 & college==1)))
*Assumption: assign German nationality to those cases
replace nation_single_alt=0 if immigrant_not_enter==1


gen immigrant=(nation_single!=0)
gen native=(nation_single==0)

drop immigrant_not_enter

label val nation_single nation_en
label val nation_single_alt nation_en


* Note: unlike 1a, this file does NOT restrict to betnr_pan==1. Figure A7
* uses the full SIEED establishment universe to provide a broader cross-sectional
* picture of the size-immigrant share relationship before and after 2011.
keep if jahr>=2002
keep if betnr_pan==1



drop nation
rename nation_single nation

* Nationality groupings are identical to those in 1a_create_data_event_study.do.
* Group 3 (EU 2004 NMS) is the treated group in the enlargement experiment;
* Group 6 (non-EU Europe) is the control group.
gen nation_grouped=0 if nation==0
replace nation_grouped=1 if nation==124 | nation==126 | nation==128 | nation==129 | nation==143 | nation==148 | nation==151 | nation==157 | nation==168 /*EU-Rich*/
replace nation_grouped=2 if nation==134 | nation==135 | nation==137 | nation==153 | nation==161 /*EU-Medium Income: Greece, Ireland, Portugal, Spain, Italy */
replace nation_grouped=3 if nation==127 | nation==131 | nation==139 | nation==142 | nation==152 | nation==155 | nation==164 | nation==165 /* EU-2004 */
replace nation_grouped=4 if nation==125 | nation==154 /* Bulgaria - Romania */
replace nation_grouped=5 if nation==130 /* Croatia */
replace nation_grouped=6 if nation==121 | nation==122 | nation==132 | nation==133 | nation==136 | nation==138 | nation==140 | (nation>=144 & nation<=147) | nation==149 | nation==150 | nation==158 | nation==159 | nation==162 | nation==166 | nation==169 | nation==170 | nation==123 | nation==141 | nation==156 | nation==167 | nation==181 | nation==195 /* Europe non EU */
replace nation_grouped=7 if nation==163 /* Turkey */
replace nation_grouped=8 if nation==160 /* Russia */
replace nation_grouped=9 if nation==434 | nation==442 | nation==465 | nation==467 | nation==479 |  nation==412 |  nation==411 /* Asia */
replace nation_grouped=10 if (nation>=431 & nation<=432) | (nation>=436 & nation<=437) | (nation>=457 & nation<=462) | nation==476 | nation==482 | nation==474 /* Southeast-Central Asia */
replace nation_grouped=11 if nation>=221 & nation<=299  /* Africa */
replace nation_grouped=12 if (nation>=421 & nation<=430) | (nation>=438 & nation<=441) | (nation>=444 & nation<=456) | (nation>=469 & nation<=472) | nation==477 /* Middle East */
replace nation_grouped=13 if nation==475 /* Syria */
replace nation_grouped=14 if (nation>=320 & nation<=347) | (nation>=349 & nation<=367)  | (nation>=369 & nation<=371) | nation==399 /* Latin America */
replace nation_grouped=15 if nation==348 | nation==368 /* North America */
replace nation_grouped=16 if nation>=523 & nation<=599 /* Oceania */
replace nation_grouped=17 if nation==499 | nation==996 | nation==997 | nation==998 | nation==495 | nation==395 | nation==495 | nation==399 /* Other */

replace nation_grouped=17 if nation_grouped==.


label define nation_grouped 0 "0 Germany" 1 "1 EU High Income" 2 "2 EU Middle Income" 3 "3 EU 2004" 4 "4 EU 2007"  5 "5 Croatia" 6 "6 Europe non EU" 7 "7 Turkey" 8 "8 Russia" 9 "9 Northeast Asia" 10 "10 Southeast-Central Asia" 11 "11 Africa" 12 "12 Middle East" 13 "13 Syria" 14 "14 Latin America" 15 "15 North America" 16 "16 Oceania" 17 "17 Other"
label val nation_grouped nation_grouped



*-------------------------------------------------------------------------------
* Construct firm-level aggregates
*
* For each worker-year observation generate employment and wage-bill indicators
* that will be summed at the firm-year level. Variables cover total employment,
* immigrant vs. native employment, new hires (tenure==1), and breakdowns by
* the four nationality groups used in the event study (EU-Rich, EU-Medium,
* EU-2004 NMS, non-EU Europe).
*-------------------------------------------------------------------------------

*Things to compute at the firm level:



gen emp_tot=1
gen emp_imm=(nation_single!=0)
gen emp_nat=(nation_single==0)

gen emp_new_hire=(tenure==1)
gen emp_new_hire_imm=(tenure==1 & nation_single!=0)
gen emp_new_hire_nat=(tenure==1 & nation_single==0)

gen emp_new_hire_eu_rich=(tenure==1 & nation_grouped==1)
gen emp_new_hire_eu_med=(tenure==1 & nation_grouped==2)
gen emp_new_hire_eu_2004=(tenure==1 & nation_grouped==3)
gen emp_new_hire_europe_non_eu=(tenure==1 & nation_grouped==6)


gen emp_new_ent_eu_2004=(rank==1 & nation_grouped==3)
gen emp_new_ent_europe_non_eu=(rank==1 & nation_grouped==6)


gen emp_eu_rich=(nation_grouped==1)
gen emp_eu_med=(nation_grouped==2)
gen emp_eu_2004=(nation_grouped==3)
gen emp_europe_non_eu=(nation_grouped==6)


gen wbill_tot=tentgelt
gen wbill_imm=tentgelt*(nation_single!=0)
gen wbill_nat=tentgelt*(nation_single==0)


gen wbill_new_hire=(tentgelt*(tenure==1))
gen wbill_new_hire_imm=tentgelt*(tenure==1 & nation_single!=0)
gen wbill_new_hire_nat=tentgelt*(tenure==1 & nation_single==0)

gen wbill_new_hire_eu_rich=tentgelt*(tenure==1 & nation_grouped==1)
gen wbill_new_hire_eu_med=tentgelt*(tenure==1 & nation_grouped==2)
gen wbill_new_hire_eu_2004=tentgelt*(tenure==1 & nation_grouped==3)
gen wbill_new_hire_europe_non_eu=tentgelt*(tenure==1 & nation_grouped==6)

gen wbill_eu_rich=tentgelt*(nation_grouped==1)
gen wbill_eu_med=tentgelt*(nation_grouped==2)
gen wbill_eu_2004=tentgelt*(nation_grouped==3)
gen wbill_europe_non_eu=tentgelt*(nation_grouped==6)


* Collapse to firm-year level, summing all employment and wage-bill variables.
collapse (sum) emp_* wbill_*, by(betnr jahr)


* Merge in BHP establishment characteristics to obtain industry code (w93_3_gen)
* and district identifier (ao_kreis), used to define the size bins in Figure A7.
merge m:1 betnr jahr using "${orig}/SIEED_7518_v1_bhp_basis_v1.dta"
drop if _m==2


save "${data}/firm_level_sieed_A7.dta", replace


log close
