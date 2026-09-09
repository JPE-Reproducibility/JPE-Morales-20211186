
/*This is the master dofile to replicate the empirical analsyis of the paper 
"Firm Heterogeneity and the Impact of Immigration: Evidence from German Establishments"
Agostina Brinatti and Nicolas Morales (2026)

Instructions

1) Change the "root" path below to wherever the replication folder is located
2) Install relevant software
3) Run LIAB master dofile
4) Run SIEED master dofile


*/

*****Part 1: Change directory**********

clear all
global root "/Users/mac/JPE-replications/JPE-Morales-20211186/replication-package/Brinatti_Morales_Replication_Package"
* Example (author's machine): global root "C:/Users/E1NXM04/Dropbox/Brinatti_Morales_Replication_Package"



******Part 2: Install stata programs needed***********

/*
ssc install ivreghdfe, replace
ssc install ivreg2, replace
ssc install ranktest, replace
ssc install reghdfe, replace
ssc install ftools, replace
ssc install require, replace
ssc install estout, replace
ssc install grstyle, replace
ssc install grc1leg2, replace

*/


/*Also make sure you bring in the adofiles for bartik_weight which can be found at https://github.com/paulgp/bartik-weight/tree/master/code (Not available via ssc install)*/



/*
*****Part 3: Analysis using LIAB******

	Programme order:
	  Data preparation (run in Internal Use Mode only):
	    1_cleaning_data.do
	    2_local_labor_markets.do
	    3_crosswalk_occupation_blossfeld.do
	    4_dataset_firm_level.do
	    5_dataset_for_instrument_validation.do
	    6_dataset_for_regressions_validation.do
	    7_dataset_for_epsilon_estimation.do

	  Analysis (submit in Presentation/Publication Mode):
	    8_validation_regressions.do       - Tables C8-C13 / Figure 3
	    9_kappa_estimation.do             - Kappa (Appendix C.1)
	    10_epsilon_estimation.do          - Table C1
	    11_epsilon_pre_trend_test.do      - Table C3
	    12_epsilon_firm_characteristics.do- Table C5
	    13_estimate_epsilon_sigma.do      - Section 5.1 point estimates
	    14_epsilon_sigma_histogram.do     - Section 5.3; Figure C1
	    15_epsilon_shift_share.do         - Tables C2, C4 (instrument validity)
	    16_estimate_nu.do                 - Table C6
	    17_empirical_facts.do             - Tables A1-A2; Figures 1, A1-A4, A6
	    18_immigrant_comparative_advantage.do - Tables A6-A8; Figure A9
	    19_moments_calculation.do         - Table 1 / Table C7; Section 5.1
		
*/	


*Set LIAB directories
global orig "${root}/liab_analysis/orig"
global data "${root}/liab_analysis/data"
global log  "${root}/liab_analysis/log"
global prog "${root}/liab_analysis/prog"	


*Run master dofile for LIAB analysis	
		
do "${prog}/master.do"

		
/*
*****Part 2: Analysis using SIEED******

Programme order:

Data preparation (run in Internal Use Mode only):

1a_create_data_event_study	  
1b_add_local_labor_market 
1c_create_data_figA7

Analysis (submit in Presentation/Publication Mode):

2a_results_event_studies 	- Figure 2, Appendix Figure A8, Appendix Tables A3, A4 and A5
2b_results_figA7 			- Appendix Figure A7
2c_results_figA5 			- Appendix Figure A5

		
*/	


*Set SIEED directories		
global orig "${root}/sieed_analysis/orig"
global data "${root}/sieed_analysis/data"
global log  "${root}/sieed_analysis/log"
global prog "${root}/sieed_analysis/prog"
		
		
*Run master dofile for SIEED analysis

do "${prog}/master.do"




*****Part 4: Calibrate the Cobb-Douglas tradable share******


global data "${root}/calibration_external/data"
global prog "${root}/calibration_external/prog"


do "${prog}/tradable_consumption_share.do"



*****Part 5: Analysis using the structural model (model_analysis)******

/*
Run order (see README Section 5.2):
  1. MATLAB: scripts/master.m  - calibration, counterfactuals, policies,
                                 and Export_latex_tables.m (Tables 1, 2, C7,
                                 D1-D3; Section 6.1/6.3 blocks)
  2. Stata:  scripts/master.do - plots (Figures 3, 4, D1, D2)

Note: MATLAB must be reachable from the shell. If "matlab" is not on PATH,
replace it with the full path, e.g.
  /Applications/MATLAB_R2023b.app/bin/matlab
*/

*Step 1 - MATLAB model master

shell matlab -batch "run('${root}/model_analysis/scripts/master.m')"

*Step 2 - Stata plotting master 

global base "${root}/model_analysis"

do "${root}/model_analysis/scripts/master.do"


