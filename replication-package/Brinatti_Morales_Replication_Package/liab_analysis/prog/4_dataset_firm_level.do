cap log close
log using "${log}/4_dataset_firm_level.log", replace

* Construct establishment-level dataset
* Agostina Brinatti & Nicolas Morales
* Source data: LIAB Longitudinal Model (version 1993-2014), IAB
*              IAB Establishment Panel (IABBP), waves 2004-2012

/*	This dofile constructs the establishment-year analysis dataset.
	It does three things:
	  (i)  Uses the employer-employee data to construct wage bill and
	       employment measures at the establishment and market level
	  (ii) Merges establishment-level financial data from the IAB
	       Establishment Panel (IABBP) surveys 2004-2012
	  (iii) Cleans industry categories, constructs fixed-effect groups,
	        and deflates monetary variables to real 2010 euros

	Input:
	  ${data}/individual_level_liab.dta       — from dofile 1
	  ${data}/aokreis11.dta                   — from dofile 2
	  ${orig}/iabbp_YYYY.dta                  — IAB Establishment Panel waves 2004-2012
	  ${orig}/cpigermany.dta                  — CPI deflator

	Output:
	  ${data}/establishment_level_liab.dta    — establishment-year panel

	No output tables or figures are produced in this dofile.
*/


/*
Input datasets:
(i)  individual_level_rep_oct24: employer-employee level data, which already have the raw data on industry and labor market of the firm.

Output datasets:
(ii)"${data}/establishment_full_dataset_rep_oct24.dta": firm-year level with raw data (it does not create variable needed in regressions)

This file does three things:
(i) uses the employer-employee data to construct wagebill and employment measures at the market level
(ii) merges the employer-employee data with firm-level data on financials.
(iii) Clean up the industry categories and all fixed effects. We also add the definition of young, and experience category.
*/


clear

set more off
set matsize 10000
set linesize 255
set seed 1234


cap adopath++ ${prog}




use "${data}/individual_level_liab.dta", clear


*Create industry category

gen ind_2dig=floor(w93_3_gen/10)

replace ind_2dig=1 if ind_2dig>=1 & ind_2dig<=5
replace ind_2dig=10 if ind_2dig>=10 & ind_2dig<=14
replace ind_2dig=15 if ind_2dig>=15 & ind_2dig<=16
replace ind_2dig=17 if ind_2dig>=17 & ind_2dig<=19
replace ind_2dig=23 if ind_2dig>=23 & ind_2dig<=24
replace ind_2dig=29 if ind_2dig>=29 & ind_2dig<=30
replace ind_2dig=37 if ind_2dig>=37 & ind_2dig<=41
replace ind_2dig=65 if ind_2dig>=65 & ind_2dig<=67

gen ind2dig=ind_2dig /* because later calls may refer to this variable. Clean in the 2nd round*/
 
gen tradeable3=((w93_3_gen>=154 & w93_3_gen<=366) | (w93_3_gen>=721 & w93_3_gen<=744) | (w93_3_gen>=501 & w93_3_gen<=517))



* We have two 2 digit industries that are both T and NT. To be consistent with the model, we redifine the classification as follows:

egen ind_2dig_aux 	= group(ind_2dig tradeable3) 
drop ind_2dig 
rename ind_2dig_aux ind_2dig


*create reduced local labor markets
gen ao_kreis11=ao_kreis
merge m:1 ao_kreis11 using "${data}/aokreis11.dta"
drop if _m==2
drop _m

drop if ao_kreis11==.
drop if ind_2dig==.


*Fixed effects 

egen ind_labormkt 	= group(ind_2dig local_labor11)
egen rt_fe 		 	= group(local_labor11 jahr)
egen kt_fe 			= group(ind_2dig jahr)
egen ind_med_time 	= group(ind_2dig jahr)



drop kreis_tot_tot-year_americas_professional

foreach x of varlist tot german eu_orig1 eu_orig2 eu_2000 turkey yugoslavia europe_other asia africa_me americas {

foreach y of varlist tot {

bysort jahr ao_kreis: egen kreis_`x'_`y'=sum(tot_earn1*`x'*`y')
bysort jahr local_labor11: egen loclabor_`x'_`y'=sum(tot_earn1*`x'*`y')
bysort jahr: egen year_`x'_`y'=sum(tot_earn1*`x'*`y')

bysort jahr ao_kreis: egen nkreis_`x'_`y'=sum(main_obs*`x'*`y')
bysort jahr local_labor11: egen nloclabor_`x'_`y'=sum(main_obs*`x'*`y')
bysort jahr: egen nyear_`x'_`y'=sum(main_obs*`x'*`y')


}
}



bysort persnr betnr: egen tenure_alt=rank(jahr), unique


keep if betr_st==1 | betr_st==2
keep if jahr>=2003 & jahr<=2011


gen young=(age<=40)  
gen tenure5=(tenure_alt<=5)  
gen experience10=(rank<=10)  


*Collapse data

foreach x of varlist tot german eu_orig1 eu_orig2 eu_2000 turkey yugoslavia europe_other asia africa_me americas {


foreach y of varlist tot college young tenure5 experience10 {	


bysort betnr jahr: egen emp_`x'_`y'=sum(share_in_estab*`x'*`y')
bysort betnr jahr: egen wbill_`x'_`y'=sum(tot_earn1*`x'*`y')

}
}



duplicates drop betnr jahr, force





************************Bring in variables needed from survey


*Merging Financials from Interview data

gen turnover_type=.
gen turnover=.
gen grosspay=.

gen relocated=.


gen integrated=.
gen exports_west_germany=.
gen exports_east_germany=.
gen exports_foreign=.
gen int_inputs=.


gen investment=.

gen collective_agreement=.
gen industry_agreement=.

gen ownership_structure=.
gen single_establishment=.

gen parent_ownership=.
gen foreign_parent=.


*2012 survey - match to 2011 data

quietly merge m:1 idnum using "${orig}/iabbp_2012.dta", keepusing(t80 t79b t48 t49 t52 t21 t11 t09a t09b t09c t08 t07 t02a t02b t02c t02d t03)
drop if _m==2

replace turnover_type=t07 if jahr==2011
replace turnover=t08 if jahr==2011
replace grosspay=t52 if jahr==2011

replace relocated=1 if (t02a==1 | t02b==1 | t02c==1) & jahr==2011
replace relocated=0 if (t02d==1) & jahr==2011

replace integrated=1 if t03==1 & jahr==2011
replace integrated=0 if t03==2 & jahr==2011


replace exports_west_germany=t09a if t09a!=-9 & jahr==2011
replace exports_east_germany=t09b if t09b!=-9 & jahr==2011
replace exports_foreign=t09c if t09c!=-9 & jahr==2011

replace int_inputs=t11 if t11!=-9 & jahr==2011

replace investment=t21 if t21!=-9 & jahr==2011
replace investment=0 if t21==. & jahr==2011 & _m==3

replace collective_agreement=t48 if t48!=-9 & jahr==2011
replace industry_agreement=t49 if t49!=-9 & jahr==2011

replace ownership_structure=t80 if t80!=-9 & jahr==2011
replace single_establishment=1 if t80==1 & jahr==2011
replace single_establishment=0 if t80!=1 & t80!=-9 & _m==3 & jahr==2011

replace parent_ownership=t79b if t79b!=-9 & jahr==2011
replace foreign_parent=1 if t79b==3 & jahr==2011
replace foreign_parent=0 if t79b!=3 &  t79b!=-9 & jahr==2011 & _m==3


drop t80 t79b t48 t49 t52 t21 t11 t09a t09b t09c t08 t07 t02a t02b t02c t02d t03
drop _m






*2011 survey - match to 2010 data
quietly merge m:1 idnum using "${orig}/iabbp_2011.dta", keepusing(s80b s84 s53 s52 s17 s11 s09c s09b s09a s03 s02d s02a s02b s02c s58 s08 s07)
drop if _m==2

replace turnover_type=s07 if jahr==2010
replace turnover=s08 if jahr==2010
replace grosspay=s58 if jahr==2010

replace relocated=1 if (s02a==1 | s02b==1 | s02c==1) & jahr==2010
replace relocated=0 if (s02d==1) & jahr==2010

replace integrated=1 if s03==1 & jahr==2010
replace integrated=0 if s03==2 & jahr==2010


replace exports_west_germany=s09a if s09a!=-9 & jahr==2010
replace exports_east_germany=s09b if s09b!=-9 & jahr==2010
replace exports_foreign=s09c if s09c!=-9 & jahr==2010

replace int_inputs=s11 if s11!=-9 & jahr==2010

replace investment=s17 if s17!=-9 & jahr==2010
replace investment=0 if s17==. & jahr==2010 & _m==3

replace collective_agreement=s52 if s52!=-9 & jahr==2010
replace industry_agreement=s53 if s53!=-9 & jahr==2010

replace ownership_structure=s84 if s84!=-9 & jahr==2010
replace single_establishment=1 if s84==1 & jahr==2010
replace single_establishment=0 if s84!=1 & s84!=-9 & _m==3 & jahr==2010

replace parent_ownership=s80b if s80b!=-9 & jahr==2010
replace foreign_parent=1 if s80b==3 & jahr==2010
replace foreign_parent=0 if s80b!=3 &  s80b!=-9 & jahr==2010 & _m==3


drop s80b s84 s53 s52 s17 s11 s09c s09b s09a s03 s02d s02a s02b s02c s58 s08 s07
drop _m






*2010 survey - match to 2009 data
quietly merge m:1 idnum using "${orig}/iabbp_2010.dta", keepusing(r87 r83 r51 r50 r20 r13 r11c r11b r11a r03 r09 r10 r54 r02a r02b r02c r02d r02e r02f)
drop if _m==2

replace turnover_type=r09 if jahr==2009
replace turnover=r10 if jahr==2009
replace grosspay=r54 if jahr==2009

replace relocated=1 if (r02a==1 | r02b==1 | r02c==1 | r02d==1 | r02e==1) & jahr==2009
replace relocated=0 if (r02f==1) & jahr==2009

replace integrated=1 if r03==1 & jahr==2009
replace integrated=0 if r03==2 & jahr==2009


replace exports_west_germany=r11a if r11a!=-9 & jahr==2009
replace exports_east_germany=r11b if r11b!=-9 & jahr==2009
replace exports_foreign=r11c if r11c!=-9 & jahr==2009

replace int_inputs=r13 if r13!=-9 & jahr==2009

replace investment=r20 if r20!=-9 & jahr==2009
replace investment=0 if r20==. & jahr==2009 & _m==3

replace collective_agreement=r50 if r50!=-9 & jahr==2009
replace industry_agreement=r51 if r51!=-9 & jahr==2009

replace ownership_structure=r83 if r83!=-9 & jahr==2009
replace single_establishment=1 if r83==1 & jahr==2009
replace single_establishment=0 if r83!=1 & r83!=-9 & _m==3 & jahr==2009

replace parent_ownership=r87 if r87!=-9 & jahr==2009
replace foreign_parent=1 if r87==3 & jahr==2009
replace foreign_parent=0 if r87!=3 &  r87!=-9 & jahr==2009 & _m==3


drop r87 r83 r51 r50 r20 r13 r11c r11b r11a r03 r09 r10 r54 r02a r02b r02c r02d r02e r02f
drop _m






*2009 survey - match to 2008 data
quietly merge m:1 idnum using "${orig}/iabbp_2009.dta", keepusing(q06 q07 q43 q02a q02b q02c q02d q03 q08a q08b q08c q10 q17 q39 q40 q88 q91)
drop if _m==2

replace turnover_type=q06 if jahr==2008
replace turnover=q07 if jahr==2008
replace grosspay=q43 if jahr==2008

replace relocated=1 if (q02a==1 | q02b==1 | q02c==1) & jahr==2008
replace relocated=0 if (q02a==0 & q02b==0 & q02c==0) & jahr==2008

replace integrated=1 if q03==1 & jahr==2008
replace integrated=0 if q03==2 & jahr==2008


replace exports_west_germany=q08a if q08a!=-9 & jahr==2008
replace exports_east_germany=q08b if q08b!=-9 & jahr==2008
replace exports_foreign=q08c if q08c!=-9 & jahr==2008

replace int_inputs=q10 if q10!=-9 & jahr==2008

replace investment=q17 if q17!=-9 & jahr==2008
replace investment=0 if q17==. & jahr==2008 & _m==3

replace collective_agreement=q39 if q39!=-9 & jahr==2008
replace industry_agreement=q40 if q40!=-9 & jahr==2008

replace ownership_structure=q88 if q88!=-9 & jahr==2008
replace single_establishment=1 if q88==1 & jahr==2008
replace single_establishment=0 if q88!=1 & q88!=-9 & _m==3 & jahr==2008

replace parent_ownership=q91 if q91!=-9 & jahr==2008
replace foreign_parent=1 if q91==3 & jahr==2008
replace foreign_parent=0 if q91!=3 &  q91!=-9 & jahr==2008 & _m==3


drop q06 q07 q43 q02a q02b q02c q02d q03 q08a q08b q08c q10 q17 q39 q40 q88 q91
drop _m

*2008 survey - match to 2007 data
quietly merge m:1 idnum using "${orig}/iabbp_2008.dta", keepusing(p09 p10 p63 p02a p02b p02c p03 p11a p11b p11c p13 p19 p59 p60 p91 p94)
drop if _m==2

replace turnover_type=p09 if jahr==2007
replace turnover=p10 if jahr==2007
replace grosspay=p63 if jahr==2007


replace relocated=1 if (p02a==1 | p02b==1 | p02c==1) & jahr==2007
replace relocated=0 if (p02a==0 & p02b==0 & p02c==0) & jahr==2007

replace integrated=1 if p03==1 & jahr==2007
replace integrated=0 if p03==2 & jahr==2007


replace exports_west_germany=p11a if p11a!=-9 & jahr==2007
replace exports_east_germany=p11b if p11b!=-9 & jahr==2007
replace exports_foreign=p11c if p11c!=-9 & jahr==2007

replace int_inputs=p13 if p13!=-9 & jahr==2007

replace investment=p19 if p19!=-9 & jahr==2007
replace investment=0 if p19==. & jahr==2007 & _m==3

replace collective_agreement=p59 if p59!=-9 & jahr==2007
replace industry_agreement=p60 if p60!=-9 & jahr==2007

replace ownership_structure=p91 if p91!=-9 & jahr==2007
replace single_establishment=1 if p91==1 & jahr==2007
replace single_establishment=0 if p91!=1 & jahr==2007 & p91!=-9 & _m==3

replace parent_ownership=p94 if p94!=-9 & jahr==2007
replace foreign_parent=1 if p94==3 & jahr==2007
replace foreign_parent=0 if p94!=3 & jahr==2007 & p94!=-9 & _m==3


drop p09 p10 p63 p02a p02b p02c p03 p11a p11b p11c p13 p19 p59 p60 p91 p94
drop _m

*2007 survey - match to 2006 data
quietly merge m:1 idnum using "${orig}/iabbp_2007.dta", keepusing(o08 o09 o85 o02a o02b o02c o02d o02e o04 o10a o10b o10c o10d o10e o12 o18 o81 o82 o90 o92)
drop if _m==2

replace turnover_type=o08 if jahr==2006
replace turnover=o09 if jahr==2006
replace grosspay=o85 if jahr==2006

replace relocated=1 if (o02a==1 | o02b==1 | o02c==1 | o02d==1 | o02e==1) & jahr==2006
replace relocated=0 if (o02a==0 & o02b==0 & o02c==0 & o02d==0 & o02e==0) & jahr==2006

replace integrated=1 if o04==1 & jahr==2006
replace integrated=0 if o04==2 & jahr==2006


replace exports_west_germany=o10a if o10a!=-9 & jahr==2006
replace exports_east_germany=o10b if o10b!=-9 & jahr==2006
replace exports_foreign=o10c+o10d+o10e if o10c!=-9 & o10d!=-9 & o10e!=-9 & jahr==2006

replace int_inputs=o12 if o12!=-9 & jahr==2006

replace investment=o18 if o18!=-9 & jahr==2006
replace investment=0 if o18==. & jahr==2006 & _m==3

replace collective_agreement=o81 if o81!=-9 & jahr==2006
replace industry_agreement=o82 if o82!=-9 & jahr==2006

replace ownership_structure=o90 if o90!=-9 & jahr==2006
replace single_establishment=1 if o90==1 & jahr==2006
replace single_establishment=0 if o90!=1 & jahr==2006 & o90!=-9 & _m==3

replace parent_ownership=o92 if o92!=-9 & jahr==2006
replace foreign_parent=1 if o92==3 & jahr==2006
replace foreign_parent=0 if o92!=3 & jahr==2006 & o92!=-9 & _m==3

drop o08 o09 o85 o02a o02b o02c o02d o02e o04 o10a o10b o10c o10d o10e o12 o18 o81 o82 o90 o92
drop _m

*2006 survey - match to 2005 data
quietly merge m:1 idnum using "${orig}/iabbp_2006.dta", keepusing(n07 n08 n83 n02aa n02ab n02ac n03 n09a n09b n09c n09d n09e n10 n15 n79 n80 n86 n92)
drop if _m==2

replace turnover_type=n07 if jahr==2005
replace turnover=n08 if jahr==2005
replace grosspay=n83 if jahr==2005

replace relocated=1 if (n02aa==1 | n02ab==1 | n02ac==1) & jahr==2005
replace relocated=0 if (n02aa==0 & n02ab==0 & n02ac==0) & jahr==2005

replace integrated=1 if n03==1 & jahr==2005
replace integrated=0 if n03==2 & jahr==2005


replace exports_west_germany=n09a if n09a!=-9 & jahr==2005
replace exports_east_germany=n09b if n09b!=-9 & jahr==2005
replace exports_foreign=n09c+n09d+n09e if n09c!=-9 & n09d!=-9 & n09e!=-9 & jahr==2005

replace int_inputs=n10 if n10!=-9 & jahr==2005

replace investment=n15 if n15!=-9 & jahr==2005
replace investment=0 if n15==. & jahr==2005 & _m==3

replace collective_agreement=n79 if n79!=-9 & jahr==2005
replace industry_agreement=n80 if n80!=-9 & jahr==2005

replace ownership_structure=n86 if n86!=-9 & jahr==2005
replace single_establishment=1 if n86==1 & jahr==2005
replace single_establishment=0 if n86!=1 & jahr==2005 & n86!=-9 & _m==3

replace parent_ownership=n92 if n92!=-9 & jahr==2005
replace foreign_parent=1 if n92==3 & jahr==2005
replace foreign_parent=0 if n92!=3 & jahr==2005 & n92!=-9 & _m==3


drop n07 n08 n83 n02aa n02ab n02ac n03 n09a n09b n09c n09d n09e n10 n15 n79 n80 n86 n92
drop _m




*2005 survey - match to 2004 data
quietly merge m:1 idnum using "${orig}/iabbp_2005.dta", keepusing(m02aa m02ab m02ac m03 m12a m12b m12c m12d m12e m13 m19 m52 m53 m91 m88 m07 m08 m59)
drop if _m==2

replace turnover_type=m07 if jahr==2004
replace turnover=m08 if jahr==2004
replace grosspay=m59 if jahr==2004

replace relocated=1 if (m02aa==1 | m02ab==1 | m02ac==1) & jahr==2004
replace relocated=0 if (m02aa==0 & m02ab==0 & m02ac==0) & jahr==2004

replace integrated=1 if m03==1 & jahr==2004
replace integrated=0 if m03==2 & jahr==2004


replace exports_west_germany=m12a if m12a!=-9 & jahr==2004
replace exports_east_germany=m12b if m12b!=-9 & jahr==2004
replace exports_foreign=m12c+m12d+m12e if m12c!=-9 & m12d!=-9 & m12e!=-9 & jahr==2004

replace int_inputs=m13 if m13!=-9 & jahr==2004

replace investment=m19 if m19!=-9 & jahr==2004
replace investment=0 if m19==. & jahr==2004 & _m==3

replace collective_agreement=m52 if m52!=-9 & jahr==2004
replace industry_agreement=m53 if m53!=-9 & jahr==2004

replace ownership_structure=m88 if m88!=-9 & jahr==2004
replace single_establishment=1 if m88==1 & jahr==2004
replace single_establishment=0 if m88!=1 & jahr==2004 & m88!=-9 & _m==3

replace parent_ownership=m91 if m91!=-9 & jahr==2004
replace foreign_parent=1 if m91==3 & jahr==2004
replace foreign_parent=0 if m91!=3 & jahr==2004 & m91!=-9 & _m==3

drop m07 m08 m59 m02aa m02ab m02ac m03 m12a m12b m12c m12d m12e m13 m19 m52 m53 m91 m88
drop _m



*2004 survey - match to 2003 data
quietly merge m:1 idnum using "${orig}/iabbp_2004.dta", keepusing(l08 l09 l68 l02a l02b l02c l03 l13a l13b l13c l13d l13e l14 l16 l91 l89 l64 l65)
drop if _m==2

replace turnover_type=l08 if jahr==2003
replace turnover=l09 if jahr==2003
replace grosspay=l68 if jahr==2003


replace relocated=1 if (l02a==1 | l02b==1 | l02c==1) & jahr==2003
replace relocated=0 if (l02a==0 & l02b==0 & l02c==0) & jahr==2003

replace integrated=1 if l03==1 & jahr==2003
replace integrated=0 if l03==2 & jahr==2003


replace exports_west_germany=l13a if l13a!=-9 & jahr==2003
replace exports_east_germany=l13b if l13b!=-9 & jahr==2003
replace exports_foreign=l13c+l13d+l13e if l13c!=-9 & l13d!=-9 & l13e!=-9 & jahr==2003

replace int_inputs=l14 if l14!=-9 & jahr==2003

replace investment=l16 if l16!=-9 & jahr==2003
replace investment=0 if l16==. & jahr==2003 & _m==3

replace collective_agreement=l64 if l64!=-9 & jahr==2003
replace industry_agreement=l65 if l65!=-9 & jahr==2003

replace ownership_structure=l89 if l89!=-9 & jahr==2003
replace single_establishment=1 if l89==1 & jahr==2003
replace single_establishment=0 if l89!=1 & jahr==2003 & l89!=-9 & _m==3

replace parent_ownership=l91 if l91!=-9 & jahr==2003
replace foreign_parent=1 if l91==3 & jahr==2003
replace foreign_parent=0 if l91!=3 & jahr==2003 & _m==3 & l91!=-9

drop l08 l09 l68 l02a l02b l02c l03 l13a l13b l13c l13d l13e l14 l16 l91 l89 l64 l65
drop _m



******************************************************************************************

replace turnover=. if turnover==-9 | turnover==-8
replace grosspay=. if grosspay==-9 | grosspay==-8

*turnover_type==-9 | turnover_type>1 |
drop begorig endorig begepi endepi quelle spell frau gebjahr ausbildung schule tentgelt_gr teilzeit gleitz wo_bula mon_erw mon_bet mon_job mon_lst erwstat_gr grund_gr grund_orig west_wo tentgelt_orig beruf_gr occ citizenship tent_dup tot_days share_in_estab tot_earn1 daily_wage rank new_entrant college college1 age avg_german citizenship_change always_german imm_count1 total_count1 imm_count total_count nation_single foreign_nation1 foreign_nation year_first age_first nation_single_alt immigrant_not_enter german eu_orig1 eu_orig2 eu_2000 turkey yugoslavia europe_other asia africa_me americas max_income main_obs manual service professional occ_broad tot


* Add the weights  

label val w93_3_gen w93_3_gen_en


gen weight_survey=.


foreach x of numlist 2004 2005 2006 2007 2008 2009 2010 2011 2012 {

quietly merge m:1 idnum using "${orig}/iabbp_`x'.dta", keepusing(hr`x'q)
drop if _m==2

replace weight_survey=hr`x'q if jahr==`x'-1

drop _m hr`x'q

}

replace weight_survey=round(weight_survey)


gen missing_turnover=(turnover==.)
gen missing_weight=(weight_survey==.)


* Deflate wagebill - turnover 

merge m:1 jahr using "${orig}/cpigermany.dta"
drop if _m==2
drop _m rate yrly

foreach x of varlist wbill_tot_tot wbill_german_tot wbill_eu_orig1_tot wbill_eu_orig2_tot wbill_eu_2000_tot wbill_turkey_tot wbill_yugoslavia_tot wbill_europe_other_tot wbill_asia_tot wbill_africa_me_tot wbill_americas_tot turnover grosspay investment wbill_tot_college wbill_german_college wbill_tot_young wbill_german_young  wbill_tot_tenure5 wbill_german_tenure5 wbill_tot_experience10 wbill_german_experience10 {
replace `x'=`x'*deflator
}


save "${data}/establishment_level_liab.dta", replace

