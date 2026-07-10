cap log close
log using "${log}/5_dataset_for_instrument_validation.log", replace

* Construct shift-share instrument for validation regressions
* Agostina Brinatti & Nicolas Morales
* Source data: LIAB Longitudinal Model (version 1993-2014), IAB

/*	This dofile constructs the shift-share instrument used in the
	validation regressions (equation 20). The instrument is a Card (2001)
	type shift-share: local labour market immigrant shares in 2003 (shares)
	interacted with national origin-group employment growth rates (shifts).

	The instrument is computed at the establishment level and saved for
	merging into the regression dataset in dofile 8.

	Input:
	  ${orig}/liab_lm_9314_v1_pers.dta        — LIAB individual spells
	  ${orig}/liab_lm_9314_v1_bhp_basis_v1.dta — LIAB establishment panel
	  ${data}/aokreis11.dta                    — from dofile 2

	Output:
	  ${data}/dataset_individual_validation.dta — individual-level, all years
	  ${data}/dataset_instrument_validation.dta — establishment-year instrument

	No output tables or figures are produced in this dofile.
*/

clear

set more off
set matsize 10000
set linesize 255
set seed 1234
capture adopath++ ${prog}


*Upload employer-employe linked dataset 

use "${orig}/liab_lm_9314_v1_pers.dta", clear


gen jahr=year(begepi)


cap label lang en

*keep one spell per worker and remove duplicates
keep if begepi == begorig

drop if betnr==.n


*Keep spells that have June 30th of each year

gen start_month=month(begorig)
gen end_month=month(endorig)

gen start_day=day(begorig)
gen end_day=day(endorig)

gen start_year=year(begorig)
gen end_year=year(endorig)

keep if (start_month<=6 & end_month>=6) & (start_day<=30 & end_day>=30)
keep if start_year==end_year


bysort persnr jahr: egen max_wage=max(tentgelt_orig)
keep if max_wage>=tentgelt_orig-0.001 & max_wage<=tentgelt_orig+0.001

duplicates drop persnr jahr, force


****Assign consistent immigration country****


*************Defining Immigrants**************

*Group citizenship variable
gen citizenship=1 if german==1
replace citizenship=2 if eu_orig1==1
replace citizenship=3 if eu_orig2==1
replace citizenship=4 if eu_2000==1
replace citizenship=5 if turkey==1
replace citizenship=6 if yugoslavia==1
replace citizenship=7 if europe_other==1
replace citizenship=8 if asia==1
replace citizenship=9 if africa_me==1
replace citizenship=10 if americas==1


*Find when workers join the labor market
bysort persnr: egen rank=rank(jahr), unique
gen new_entrant=(rank==1)


*Calculate tenure at firm

bysort persnr betnr: egen tenure=rank(jahr), unique


*Data on college noisy sometimes, we want to classify workers as college vs non college so we choose the most likely observation.
gen college=(ausbildung==11 | ausbildung==12)
replace college=. if ausbildung==.z
bysort persnr: egen college1=mode(college), maxmode

drop college
rename college1 college


gen age=jahr-gebjahr

drop german
gen german=(citizenship==1)



*How many periods does the worker show up as german
bysort persnr: egen avg_german=mean(german) if citizenship!=.z

*Find those that through time show up as both german and non-german
gen citizenship_change=(avg_german>0 & avg_german<1 & citizenship!=.z)

gen always_german=(avg_german==1)


*How many periods workers show up as immigrants
bysort persnr: egen imm_count1=sum(1-german) if citizenship!=.z

*Total periods
bysort persnr: egen total_count1=sum(1) if citizenship!=.z

*Impute imm_count1 for those observations where for some periods citizenship is missing
bysort persnr: egen imm_count=mean(imm_count1)

*Impute total_count1 for those observations where for some periods citizenship is missing
bysort persnr: egen total_count=mean(total_count1)

*Create nationality proxy. First with those that always show up as german.
gen nation_single=citizenship if always_german==1

*Identify main citizenship group for those that sometime show up as foreign.
gen foreign_nation1=citizenship if citizenship!=.z
bysort persnr: egen foreign_nation=mode(foreign_nation1), minmode

*If you show up more than one period as a non-german citizen, impute that foreign citizenship
replace nation_single=foreign_nation if ((imm_count>1) | (imm_count==1 & total_count==1)) & imm_count!=.

*Count as German if you show up as a foreign citizenship just one period but work more than one period (might be data error)
replace nation_single=1 if imm_count==1 & total_count>1

*Some cases remaining where we just count them as german as long as they report german for at least one period.
replace nation_single=1 if nation_single==. & avg_german!=0

drop german-total_count foreign_nation1 foreign_nation


*Age at which you join the labor market
bysort persnr: egen year_first=min(jahr)
gen age_first=year_first-gebjahr


*More narrow definition: Remove those who seem to be immigrants but join the labor market too early (likely grew up in germany to foreign parents or studied in Germany)
gen nation_single_alt=nation_single
gen immigrant_not_enter=(nation_single_alt!=1 & ((age_first<=19 & college==0) | (age_first<=25 & college==1)))
*Assumption: assign German nationality to those cases
replace nation_single_alt=1 if immigrant_not_enter==1


drop immigrant_not_enter




*label drop nationality
label def nation_single 1 "German" 2 "EU Original 1" 3 "EU Original 1" 4 "EU 2000" 5 "Turkey" 6 "Yugoslavia" 7 "Europe non EU" 8 "Asia" 9 "Africa & ME" 10 "Americas"
label val nation_single nation_single




keep persnr jahr betnr nation_single nation_single_alt tentgelt_orig college tenure rank new_entrant age betr_st idnum erwstat_gr frau



save "${data}/dataset_individual_validation.dta", replace



keep if jahr>=2003 & jahr<=2011

keep if erwstat_gr==1
rename tentgelt_orig tentgelt

merge m:1 betnr jahr using "${orig}/liab_lm_9314_v1_bhp_basis_v1.dta", keepusing(w93_3_gen az_ges ao_kreis grd_jahr lzt_jahr te_imp_mw)
drop if _m!=3 
drop _m



*create reduced local labor markets
gen ao_kreis11=ao_kreis
merge m:1 ao_kreis11 using "${data}/aokreis11.dta"
drop if _m==2
drop _m

drop if ao_kreis11==.

*-------------------------------------------------------------------------------
* Construction of endogenous immigrant share and instrument
*-------------------------------------------------------------------------------

gen german=(nation_single==1)
gen eu_orig1=(nation_single==2)
gen eu_orig2=(nation_single==3)
gen eu_2000=(nation_single==4)
gen turkey=(nation_single==5)
gen yugoslavia=(nation_single==6)
gen europe_other=(nation_single==7)
gen asia=(nation_single==8)
gen africa_me=(nation_single==9)
gen americas=(nation_single==10)



gen tot=1
gen immigrant=(eu_orig1==1 | eu_orig2==1 | eu_2000==1 | turkey==1 | yugoslavia==1 | europe_other==1 | asia==1 | africa_me==1 | americas)

foreach x in tot immigrant german eu_orig1 eu_orig2 eu_2000 turkey yugoslavia europe_other asia africa_me americas {
	
	foreach y of varlist tot {
	
bysort jahr local_labor11: egen loclabor_`x'_`y'=sum(tentgelt*`x'*`y')
bysort jahr local_labor11: egen nloclabor_`x'_`y'=sum(1*`x'*`y')


bysort jahr: egen year_`x'_`y'=sum(tentgelt*`x'*`y')
bysort jahr: egen nyear_`x'_`y'=sum(1*`x'*`y')


}
}


*Instrument3: local labor market level

gen share_mig1_local2=(loclabor_eu_orig1_tot)/(loclabor_tot_tot) if jahr==2003
bysort local_labor11: egen share_mig1_local203=mean(share_mig1_local2)

gen share_mig2_local2=(loclabor_eu_orig2_tot)/(loclabor_tot_tot) if jahr==2003
bysort local_labor11: egen share_mig2_local203=mean(share_mig2_local2)

gen share_mig3_local2=(loclabor_eu_2000_tot)/(loclabor_tot_tot) if jahr==2003
bysort local_labor11: egen share_mig3_local203=mean(share_mig3_local2)

gen share_mig4_local2=(loclabor_turkey_tot)/(loclabor_tot_tot) if jahr==2003
bysort local_labor11: egen share_mig4_local203=mean(share_mig4_local2)

gen share_mig5_local2=(loclabor_yugoslavia_tot)/(loclabor_tot_tot) if jahr==2003
bysort local_labor11: egen share_mig5_local203=mean(share_mig5_local2)

gen share_mig6_local2=(loclabor_europe_other_tot)/(loclabor_tot_tot) if jahr==2003
bysort local_labor11: egen share_mig6_local203=mean(share_mig6_local2)

gen share_mig7_local2=(loclabor_asia_tot)/(loclabor_tot_tot) if jahr==2003
bysort local_labor11: egen share_mig7_local203=mean(share_mig7_local2)

gen share_mig8_local2=(loclabor_africa_me_tot)/(loclabor_tot_tot) if jahr==2003
bysort local_labor11: egen share_mig8_local203=mean(share_mig8_local2)

gen share_mig9_local2=(loclabor_americas_tot)/(loclabor_tot_tot) if jahr==2003
bysort local_labor11: egen share_mig9_local203=mean(share_mig9_local2)


foreach x of varlist year_tot_tot year_eu_orig1_tot year_eu_orig2_tot year_eu_2000_tot year_turkey_tot year_yugoslavia_tot year_europe_other_tot year_asia_tot year_africa_me_tot year_americas_tot {
	generate `x'_aux = `x' if jahr==2003
	egen `x'03 = max(`x'_aux)
	drop `x'_aux
}

gen instrument3_local=(share_mig1_local203*year_eu_orig1_tot/year_eu_orig1_tot03 +  ///
share_mig2_local203*year_eu_orig2_tot/year_eu_orig2_tot03         + share_mig3_local203*year_eu_2000_tot/year_eu_2000_tot03 + ///
share_mig4_local203*year_turkey_tot/year_turkey_tot03             + share_mig5_local203*year_yugoslavia_tot/year_yugoslavia_tot03 + ///
share_mig6_local203*year_europe_other_tot/year_europe_other_tot03 + share_mig7_local203*year_asia_tot/year_asia_tot03 + ///
share_mig8_local203*year_africa_me_tot/year_africa_me_tot03       + share_mig9_local203*year_americas_tot/year_americas_tot03)*year_tot_tot03/year_tot_tot


foreach x of varlist nyear_tot_tot nyear_eu_orig1_tot nyear_eu_orig2_tot nyear_eu_2000_tot nyear_turkey_tot nyear_yugoslavia_tot nyear_europe_other_tot nyear_asia_tot nyear_africa_me_tot nyear_americas_tot {
	generate `x'_aux = `x' if jahr==2003
	egen `x'03 = max(`x'_aux)
	drop `x'_aux
}

gen instrument3n_local=(share_mig1_local203*nyear_eu_orig1_tot/nyear_eu_orig1_tot03 +  ///
share_mig2_local203*nyear_eu_orig2_tot/nyear_eu_orig2_tot03         + share_mig3_local203*nyear_eu_2000_tot/nyear_eu_2000_tot03 + ///
share_mig4_local203*nyear_turkey_tot/nyear_turkey_tot03             + share_mig5_local203*nyear_yugoslavia_tot/nyear_yugoslavia_tot03 + ///
share_mig6_local203*nyear_europe_other_tot/nyear_europe_other_tot03 + share_mig7_local203*nyear_asia_tot/nyear_asia_tot03 + ///
share_mig8_local203*nyear_africa_me_tot/nyear_africa_me_tot03       + share_mig9_local203*nyear_americas_tot/nyear_americas_tot03)*nyear_tot_tot03/nyear_tot_tot

*Save 

	keep if betr_st==1 | betr_st==2
	keep if jahr>=2003 & jahr<=2011

	duplicates drop betnr jahr, force


	keep betnr jahr instrument3n_local

	save "${data}/dataset_instrument_validation.dta", replace


log close 


