cap log close
log using "${log}/1_cleaning_data.log", replace

* Clean individual-level LIAB data
* Agostina Brinatti & Nicolas Morales
* Source data: LIAB Longitudinal Model (version 1993-2014), IAB

/*	This dofile constructs the individual-level LIAB dataset used throughout
	the analysis. The unit of observation is worker-establishment-year.

	It does the following:
	  (i)  Keeps one spell per worker and removes duplicates
	  (ii) Constructs a consistent immigrant indicator based on citizenship
	       history rather than point-in-time citizenship
	  (iii) Merges establishment identifiers and creates regional aggregates

	Input:
	  ${orig}/liab_lm_9314_v1_pers.dta    — LIAB individual spells
	  ${orig}/liab_lm_9314_v1_bhp_basis_v1.dta — LIAB establishment panel

	Output:
	  ${data}/individual_level_liab.dta   — worker-establishment-year panel

	No output tables or figures are produced in this dofile.
*/

clear

set more off
set matsize 10000
set linesize 255
set seed 1234


cap adopath++ ${prog}

clear


use "${orig}/liab_lm_9314_v1_pers.dta", clear
cap label lang en

*Important line! keep one spell per worker and remove duplicates
keep if begepi == begorig

drop if betnr==.n

gen jahr=year( begorig)


***********************Removing duplicate observations and calculating total income per worker-establishment


*Create occupation dummies
gen occ=beruf_gr

*Drop observations with wage equal to 0
drop if tentgelt_orig==0

*Keep only full time employment, part-time employment or trainees
keep if erwstat_gr==1 | erwstat_gr==2 | erwstat_gr==3


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



*Remove duplicated observations

*First keep highest daily wage (tentgelt_orig) across duplicated observations.
bysort persnr betnr begorig endorig: egen tent_dup=max(tentgelt_orig)
replace tentgelt_orig=tent_dup

replace tentgelt_gr=round(tentgelt_orig)

duplicates drop persnr betnr begorig endorig, force



*Number of days in establishment
gen work_days=endorig-begorig
bysort persnr betnr jahr: egen tot_days=sum(work_days)


*Some establishments report several entries for the same worker, ends up adding more than 365 work days for workers. We correct for that below.
gen share_in_estab=tot_days/360
replace share_in_estab=1 if share_in_estab>1




*Total earnings
gen earn1=work_days*tentgelt_orig

bysort persnr betnr jahr: egen tot_earn1=sum(earn1)

replace tot_earn1=tot_earn1*365/tot_days if tot_days>365

replace tot_days=365 if tot_days>=365

*Calculate adjusted daily wage
gen daily_wage=tot_earn/tot_days



*Leave one observation per establishment-individual-year

/* Sometimes individuals have multiple observations per establishment-year because they report different
occupation (occ), education (ausbildung), birthdate (gebjahr), citizenship or employment type (part-time, fulltime etc).

Below we keep the main observation for each of those variables before dropping the duplicates.
*/

bysort persnr betnr jahr: egen occ1=mode(occ), maxmode
replace occ=occ1

bysort persnr betnr jahr: egen bild1=mode(ausbildung), maxmode
replace ausbildung=bild1

bysort persnr betnr jahr: egen gebjahr1=mode(gebjahr), maxmode
replace gebjahr=gebjahr1

bysort persnr betnr jahr: egen nation_gr1=mode(citizenship), maxmode
replace citizenship=nation_gr1

bysort persnr betnr jahr: egen erwstat1=mode(erwstat_gr), minmode
replace erwstat_gr=erwstat1



drop nation_gr1 bild1 occ1 gebjahr1 work_days earn1 erwstat1

duplicates drop persnr betnr jahr, force



drop german eu_orig1 eu_orig2 eu_2000 turkey yugoslavia europe_other asia africa_me americas


gen german=(citizenship==1)



*************Defining Immigrants**************

/*
IMPORTANT: What is recorded in social security is citizenship, not country of birth. Also it is reported by the employer.
This generates some of the following:

Workers that grew up in Germany to foreign parents and who never change their citizenship show up as immigrants
Workers acquire citizenship and go from immigrant to german (selection into citizenship)
For some individuals, their reported citizenship depends on the employer (they go from german to some other citizenship when changing employers).

We want a consistent definition of immigrants that represents something closer to country of birth instead of citizenship. So in
the following lines we do some adjustments:
*/


*Find when workers join the labor market
bysort persnr: egen rank=rank(begorig), unique
gen new_entrant=(rank==1)

*Calculate tenure at firm

bysort persnr betnr: egen tenure=rank(jahr), unique


*Data on college noisy sometimes, we want to classify workers as college vs non college so we choose the most likely observation.
gen college=(ausbildung==11 | ausbildung==12)
replace college=. if ausbildung==.z
bysort persnr: egen college1=mode(college), maxmode


gen age=jahr-gebjahr



*How many periods does the worker show up as german
bysort persnr: egen avg_german=mean(german) if citizenship!=.

*Find those that through time show up as both german and non-german
gen citizenship_change=(avg_german>0 & avg_german<1 & citizenship!=.)

gen always_german=(avg_german==1)


*How many periods workers show up as immigrants
bysort persnr: egen imm_count1=sum(1-german) if citizenship!=.

*Total periods
bysort persnr: egen total_count1=sum(1) if citizenship!=.

*Impute imm_count1 for those observations where for some periods citizenship is missing
bysort persnr: egen imm_count=mean(imm_count1)

*Impute total_count1 for those observations where for some periods citizenship is missing
bysort persnr: egen total_count=mean(total_count1)

*Create nationality proxy. First with those that always show up as german.
gen nation_single=citizenship if always_german==1

*Identify main citizenship group for those that sometime show up as foreign.
gen foreign_nation1=citizenship if citizenship!=1
bysort persnr: egen foreign_nation=mode(foreign_nation1), minmode

*If you show up more than one period as a non-german citizen, impute that foreign citizenship
replace nation_single=foreign_nation if ((imm_count>1) | (imm_count==1 & total_count==1)) & imm_count!=.

*Count as German if you show up as a foreign citizenship just one period but work more than one period (might be data error)
replace nation_single=1 if imm_count==1 & total_count>1

*Some cases remaining where we just count them as german as long as they report german for at least one period.
replace nation_single=1 if nation_single==. & avg_german!=0


*Age at which you join the labor market
bysort persnr: egen year_first=min(jahr)
gen age_first=year_first-gebjahr


*More narrow definition: Remove those who seem to be immigrants but join the labor market too early (likely grew up in germany to foreign parents or studied in Germany)
gen nation_single_alt=nation_single
gen immigrant_not_enter=(nation_single_alt!=1 & ((age_first<=19 & college1==0) | (age_first<=25 & college1==1)))
*Assumption: assign no nationality to those cases
replace nation_single_alt=. if immigrant_not_enter==1




*Create establishment level aggregates - with full establishment employment

drop german

*Create dummies by nationality - using broad definition (not dropping those who enter young). Results robust to using the narrow definition.
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




*label drop nationality
label def nation_single 1 "German" 2 "EU Original 1" 3 "EU Original 1" 4 "EU 2000" 5 "Turkey" 6 "Yugoslavia" 7 "Europe non EU" 8 "Asia" 9 "Africa & ME" 10 "Americas"
label val nation_single nation_single

label val occ beruf_gr_en



***********************Collapse variables at the establishment level

*Merge number of employees (az_ges), 3-digit industry (w93_3_gen), district (ao_kreis), grd_jahr (first year in data), lzt_jahr (last year in data), te_imp_mw (median wage in establishment)
merge m:1 betnr jahr using "${orig}/liab_lm_9314_v1_bhp_basis_v1.dta", keepusing(w93_3_gen az_ges ao_kreis grd_jahr lzt_jahr te_imp_mw)
drop if _m!=3
drop _m

label val w93_3_gen w93_3_gen_en

bysort persnr jahr: egen max_income=max(tot_earn1)
gen main_obs=(tot_earn1==max_income)



*generate blossfeld occupation groups

gen manual=((occ>=1 & occ<=54) | (occ>=56 & occ<=58))
gen service=((occ>=72 & occ<=79) | (occ>=55 & occ<=56) | (occ>=80 & occ<=86) | (occ>=90 & occ<=98) | (occ>=114 & occ<=120))
gen professional=((occ>=59 & occ<=71) | (occ>=99 & occ<=113) | (occ>=87 & occ<=89))

gen occ_broad=1 if manual==1
replace occ_broad=2 if service==1
replace occ_broad=3 if professional==1

gen tot=1

drop if ao_kreis==.


*First, calculate aggregates at the regional level by nationality and occupation group.
*The aggregation is using wage bill, not worker counts. (Wage bill says something about the skills - effective units of each worker).

foreach x of varlist tot german eu_orig1 eu_orig2 eu_2000 turkey yugoslavia europe_other asia africa_me americas {

foreach y of varlist tot manual service professional college {



bysort jahr ao_kreis: egen kreis_`x'_`y'=sum(tot_earn1*`x'*`y')
bysort jahr: egen year_`x'_`y'=sum(tot_earn1*`x'*`y')


}
}


*****Save disaggregated data

save "${data}/individual_level_liab.dta", replace


log close
