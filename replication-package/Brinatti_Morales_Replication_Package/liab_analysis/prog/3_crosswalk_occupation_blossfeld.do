cap log close
log using "${log}/3_crosswalk_occupation_blossfeld.log", replace

* Crosswalk between occupation codes (beruf_gr) and Blossfeld categories
* Agostina Brinatti & Nicolas Morales
* Source data: Created manually following Blossfeld (1985); guided by
*              "04_occ_blossfeld" from Gangl et al. (2020),
*              https://labourmarketresearch.springeropen.com/articles/10.1186/s12651-020-00275-9

/*	This dofile creates a concordance between the LIAB occupation codes
	(beruf_gr, 120 categories) and the 12 Blossfeld broad occupation groups
	used in Table A6 and Figure A9.

	Input:  None (dataset constructed from scratch)

	Output:
	  ${data}/crosswalk_beruf_gr_blossfeld.dta — beruf_gr to occ_bl crosswalk

	No output tables or figures are produced in this dofile.
*/

clear

set more off
set matsize 10000
set linesize 255
set seed 1234

capture adopath++ ${prog}

 set obs 120
 gen beruf_gr	=_n
 gen occ_bl 	= 0

********************************************************************************
* Blossfeld occupation as close as possible to the one based on the narrow definition
********************************************************************************
* comment:

replace occ_bl=1 if beruf_gr==1
replace occ_bl=1 if beruf_gr==2
replace occ_bl=2 if beruf_gr==3
replace occ_bl=2 if beruf_gr==4
replace occ_bl=2 if beruf_gr==5
replace occ_bl=3 if beruf_gr==6
replace occ_bl=2 if beruf_gr==7
replace occ_bl=2 if beruf_gr==8
replace occ_bl=3 if beruf_gr==9
replace occ_bl=3 if beruf_gr==10
replace occ_bl=2 if beruf_gr==11
replace occ_bl=2 if beruf_gr==12
replace occ_bl=2 if beruf_gr==13
replace occ_bl=2 if beruf_gr==14
replace occ_bl=2 if beruf_gr==15
replace occ_bl=2 if beruf_gr==16
replace occ_bl=2 if beruf_gr==17
replace occ_bl=2 if beruf_gr==18
replace occ_bl=2 if beruf_gr==19
replace occ_bl=3 if beruf_gr==20
replace occ_bl=3 if beruf_gr==21
replace occ_bl=3 if beruf_gr==22
replace occ_bl=3 if beruf_gr==23
replace occ_bl=3 if beruf_gr==24
replace occ_bl=3 if beruf_gr==25
replace occ_bl=3 if beruf_gr==26
replace occ_bl=3 if beruf_gr==27
replace occ_bl=3 if beruf_gr==28
replace occ_bl=4 if beruf_gr==29
replace occ_bl=3 if beruf_gr==30
replace occ_bl=3 if beruf_gr==31
replace occ_bl=3 if beruf_gr==32
replace occ_bl=2 if beruf_gr==33
replace occ_bl=2 if beruf_gr==34
replace occ_bl=2 if beruf_gr==35
replace occ_bl=2 if beruf_gr==36
replace occ_bl=2 if beruf_gr==37
replace occ_bl=3 if beruf_gr==38
replace occ_bl=2 if beruf_gr==39
replace occ_bl=2 if beruf_gr==40
replace occ_bl=2 if beruf_gr==41
replace occ_bl=3 if beruf_gr==42
replace occ_bl=2 if beruf_gr==43
replace occ_bl=2 if beruf_gr==44
replace occ_bl=2 if beruf_gr==45
replace occ_bl=2 if beruf_gr==46
replace occ_bl=2 if beruf_gr==47
replace occ_bl=3 if beruf_gr==48
replace occ_bl=3 if beruf_gr==49
replace occ_bl=3 if beruf_gr==50
replace occ_bl=3 if beruf_gr==51
replace occ_bl=3 if beruf_gr==52
replace occ_bl=2 if beruf_gr==53
replace occ_bl=2 if beruf_gr==54
replace occ_bl=2 if beruf_gr==55
replace occ_bl=2 if beruf_gr==56
replace occ_bl=2 if beruf_gr==57
replace occ_bl=2 if beruf_gr==58
replace occ_bl=5 if beruf_gr==59
replace occ_bl=5 if beruf_gr==60
replace occ_bl=5 if beruf_gr==61
replace occ_bl=5 if beruf_gr==62
replace occ_bl=5 if beruf_gr==63
replace occ_bl=4 if beruf_gr==64
replace occ_bl=4 if beruf_gr==65
replace occ_bl=4 if beruf_gr==66
replace occ_bl=4 if beruf_gr==67
replace occ_bl=4 if beruf_gr==68
replace occ_bl=4 if beruf_gr==69
replace occ_bl=4 if beruf_gr==70
replace occ_bl=4 if beruf_gr==71
replace occ_bl=11 if beruf_gr==72
replace occ_bl=10 if beruf_gr==73
replace occ_bl=11 if beruf_gr==74
replace occ_bl=10 if beruf_gr==75
replace occ_bl=11 if beruf_gr==76
replace occ_bl=11 if beruf_gr==77
replace occ_bl=11 if beruf_gr==78
replace occ_bl=7 if beruf_gr==79
replace occ_bl=6 if beruf_gr==80
replace occ_bl=6 if beruf_gr==81
replace occ_bl=6 if beruf_gr==82
replace occ_bl=10 if beruf_gr==83
replace occ_bl=6 if beruf_gr==84
replace occ_bl=6 if beruf_gr==85
replace occ_bl=6 if beruf_gr==86
replace occ_bl=12 if beruf_gr==87
replace occ_bl=12 if beruf_gr==88
replace occ_bl=12 if beruf_gr==89
replace occ_bl=11 if beruf_gr==90
replace occ_bl=10 if beruf_gr==91
replace occ_bl=11 if beruf_gr==92
replace occ_bl=11 if beruf_gr==93
replace occ_bl=10 if beruf_gr==94
replace occ_bl=10 if beruf_gr==95
replace occ_bl=6 if beruf_gr==96
replace occ_bl=6 if beruf_gr==97
replace occ_bl=7 if beruf_gr==98
replace occ_bl=8 if beruf_gr==99
replace occ_bl=7 if beruf_gr==100
replace occ_bl=7 if beruf_gr==101
replace occ_bl=9 if beruf_gr==102
replace occ_bl=7 if beruf_gr==103
replace occ_bl=8 if beruf_gr==104
replace occ_bl=7 if beruf_gr==105
replace occ_bl=7 if beruf_gr==106
replace occ_bl=7 if beruf_gr==107
replace occ_bl=8 if beruf_gr==108
replace occ_bl=8 if beruf_gr==109
replace occ_bl=8 if beruf_gr==110
replace occ_bl=9 if beruf_gr==111
replace occ_bl=8 if beruf_gr==112
replace occ_bl=9 if beruf_gr==113
replace occ_bl=7 if beruf_gr==114
replace occ_bl=6 if beruf_gr==115
replace occ_bl=6 if beruf_gr==116
replace occ_bl=7 if beruf_gr==117
replace occ_bl=6 if beruf_gr==118
replace occ_bl=6 if beruf_gr==119
replace occ_bl=6 if beruf_gr==120


* Labels
label define lblBlo  1 "AGR" ///
					 2 "EMB" ///
					 3 "QMB" ///
					 4 "TEC" ///
					 5 "ING" ///
					 6 "EDI" ///
					 7 "QDI" ///
					 8 "SEMI" ///
					 9 "PROF" ///
					10 "EVB" ///
					11 "QVB" ///
					12 "MAN" ///
					 0 "NO"

label values occ_bl lblBlo
label variable occ_bl "Blossfeld occupations"

* Save dataset

save "${data}/crosswalk_beruf_gr_blossfeld.dta" , replace

log close
