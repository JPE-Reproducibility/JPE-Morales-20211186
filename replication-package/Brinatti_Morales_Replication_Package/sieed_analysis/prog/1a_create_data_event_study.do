********************************************************************************
* 1a_create_data_event_study.do
*
* Purpose:
*   Takes the raw SIEED job-spell data and constructs the panel dataset used
*   in the EU enlargement event study. The final output is a firm-year panel
*   with employment and wage-bill counts broken out by worker origin group,
*   which is used to estimate equation (1) of the paper and produce:
*     - Figure 2:          Event study by firm size (large vs. small)
*     - Appendix Figure A8: Baseline event study (pooled firms)
*     - Appendix Table A3:  Alternative outcomes and size breakdowns
*     - Appendix Table A4:  Robustness to alternative samples
*     - Appendix Table A5:  Robustness to alternative fixed effects
*
* Inputs:
*   ${orig}/sieed_7518_v1.dta          - Raw SIEED job-spell file
*   ${orig}/SIEED_7518_v1_bhp_basis_v1.dta - BHP establishment characteristics
*                                         (industry, location, panel flag)
*
* Outputs:
*   ${data}/individual_level_sieed.dta - Individual-year panel with immigrant
*                                         status and demographics assigned
*   ${data}/firm_level_sieed.dta       - Firm-year panel ready for regressions
*
* Notes:
*   The event study compares NMS (New Member State) nationals -- the treated
*   group whose access to Germany was liberalized in 2011 -- against other
*   non-EU European nationals who faced unchanged restrictions throughout the
*   sample. See Section 3.3.2 and Appendix A.5 for details on the design.
********************************************************************************

set seed 1234

log using "${log}/1a_create_data_event_study.log", replace



****STEP 1 - create individual level data


*Open SIEED
use "${orig}/sieed_7518_v1.dta", clear


gen jahr=year(begepi)



*Important line! keep one spell per worker and remove duplicates
keep if begepi == begorig

drop if betnr==.n


*Keep spells that have June 30th of each year
* This is the standard IAB reference date that ensures a consistent annual
* snapshot comparable to the LIAB cross-sectional structure.

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


****Assign consistent immigration country****


*************Defining Immigrants**************

* Workers' citizenship in the social security records can change over time
* (e.g., naturalization). The block below assigns each worker a stable
* citizenship status by identifying their predominant foreign citizenship
* across all observed periods. See Appendix A.1 for the full discussion of
* this definition and its robustness.

*Find when workers join the labor market
bysort persnr: egen rank=rank(jahr), unique
gen new_entrant=(rank==1)


*Calculate tenure at firm

bysort persnr betnr: egen tenure=rank(jahr), unique


* Education is sometimes recorded inconsistently across years for the same
* worker. Assign the modal (most common) value to eliminate noise.
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
gen foreign_nation1=nation if nation!=.z
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


* Alternative (narrower) immigrant definition: workers who appear with foreign
* citizenship but entered the labor market very young are likely children of
* immigrants who grew up in Germany rather than migrants themselves.
* Robustness check discussed in Appendix A.1.
gen nation_single_alt=nation_single
gen immigrant_not_enter=(nation_single_alt!=1 & ((age_first<=19 & college==0) | (age_first<=25 & college==1)))
*Assumption: assign German nationality to those cases
replace nation_single_alt=0 if immigrant_not_enter==1


gen immigrant=(nation_single!=0)
gen native=(nation_single==0)

drop immigrant_not_enter

label val nation_single nation_en
label val nation_single_alt nation_en



keep if jahr>=1995


save "${data}/individual_level_sieed.dta", replace


****STEP 2 - create individual level data



use "${data}/individual_level_sieed.dta", clear



*Restrict sample

keep if jahr>=2002
* betnr_pan==1 restricts to the balanced SIEED establishment panel, which is
* required to track firms consistently over the pre- and post-2011 periods.
keep if betnr_pan==1

*Clean up variables and generate outcomes

drop nation
rename nation_single nation

* Assign each worker's citizenship to one of 17 grouped nationality categories
* matching the 10 regions used in the main LIAB analysis (see Appendix A.1).
* Groups 3 (EU 2004 NMS) and 6 (non-EU Europe) are the treated and control
* groups in the event study, respectively.
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
* Construct firm-level aggregates to be collapsed
*
* For each worker-year observation we generate indicators and wage-bill values
* that will be summed at the firm-year level. Variables are defined for:
*   - All employees (emp_tot, wbill_tot)
*   - Immigrants vs. natives (emp_imm, emp_nat, wbill_imm, wbill_nat)
*   - New hires (tenure==1) overall and by nationality group
*   - New labor market entrants (rank==1) for NMS and control groups
*   - Worker characteristics (college, gender, age) for new NMS/control hires,
*     used in the robustness check on migrant selection (Section 3.3.2)
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


* Average characteristics of new NMS and control-group hires at each firm-year.
* These are used in the robustness check verifying that post-2011 NMS migrants
* are not negatively selected relative to the pre-2011 cohort (Section 3.3.2).
gen charact_college_eu_2004=college if tenure==1 & nation_grouped==3
gen charact_college_europe_non_eu=college if tenure==1 & nation_grouped==6

gen charact_frau_eu_2004=frau if tenure==1 & nation_grouped==3
gen charact_frau_europe_non_eu=frau if tenure==1 & nation_grouped==6

gen charact_age_eu_2004=age if tenure==1 & nation_grouped==3
gen charact_age_europe_non_eu=age if tenure==1 & nation_grouped==6


* Year and treatment indicators used in the event study regression (equation 1).
* treat[x] equals 1 when the observation is from year x and the worker is
* from an NMS country (nation_grouped==3).
forval x=2002/2018 {
	
	gen year`x'=(jahr==`x')
	gen treat`x'=(jahr==`x')*(nation_grouped==3)
	
	
}

gen new_eu=(nation_grouped==3)
gen post=(jahr>=2011)
gen treat=new_eu*post



*Collapse at the firm - year level

collapse (sum) emp_* wbill_* (mean) charact_*, by(betnr jahr)


* Merge in BHP establishment characteristics (industry code, district of
* establishment location, panel membership flag). These are used to construct
* industry and local labor market fixed effects in the regressions.
merge m:1 betnr jahr using "${orig}/SIEED_7518_v1_bhp_basis_v1.dta"
drop if _m==2


save "${data}/firm_level_sieed.dta", replace




log close
