cap log close
log using "${log}/2_local_labor_markets.log", replace

* Crosswalk between district (Kreis) and local labour market
* Agostina Brinatti & Nicolas Morales
* Source data: Local labour market concordance, IAB (Kropp & Schwengler 2011)

/*	This dofile prepares the crosswalk between Kreis (district) codes and
	functional local labour market regions (Kropp & Schwengler 2011).
	The raw dataset was provided directly by Barbara Schwengler at the IAB.

	Reference: Kropp, P. and B. Schwengler (2011). Delineation of Functional
	Labour Market Regions: a Methodological Approach. Raumforschung und
	Raumordnung 69 (1), 45-62.

	Input:
	  ${orig}/local labor markets.dta   — raw concordance file

	Output:
	  ${data}/aokreis11.dta             — Kreis-to-LLM crosswalk

	No output tables or figures are produced in this dofile.
*/

clear

set more off
set matsize 10000
set linesize 255
set seed 1234


use "${orig}/local labor markets.dta", clear

keep ao_kreis11 local_labor11

keep if ao_kreis11!=.

duplicates drop ao_kreis11, force

save "${data}/aokreis11.dta", replace

log close
