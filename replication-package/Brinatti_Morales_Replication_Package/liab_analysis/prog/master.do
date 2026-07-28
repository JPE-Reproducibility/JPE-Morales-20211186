cap log close
log using "${log}/master.log", replace

* Master file — Brinatti & Morales (2026)
* Agostina Brinatti & Nicolas Morales
* Source data: LIAB Longitudinal Model (version 1993-2014), IAB
*              IAB Establishment Panel (IABBP), waves 2004-2012

/*	This master file runs all programmes in sequence.
	Data preparation programmes (1-7) produce no publication output.
	Analysis programmes (8-19) produce all tables and Figure C1.

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

version 16
set linesize 120
set more off
set seed 1234

* -----------------------------------------------------------------------
* Data preparation — comment out before submitting for Presentation/Publication
* -----------------------------------------------------------------------

do "${prog}/1_cleaning_data.do"
do "${prog}/2_local_labor_markets.do"
do "${prog}/3_crosswalk_occupation_blossfeld.do"
do "${prog}/4_dataset_firm_level.do"
do "${prog}/5_dataset_for_instrument_validation.do"
do "${prog}/6_dataset_for_regressions_validation.do"
do "${prog}/7_dataset_for_epsilon_estimation.do"

* -----------------------------------------------------------------------
* Analysis — these produce all submission outputs
* -----------------------------------------------------------------------

*Tables C8-C13 / Figure 3
do "${prog}/8_validation_regressions.do"

*Kappa estimate (Appendix C.1)
do "${prog}/9_kappa_estimation.do"

*Table C1
do "${prog}/10_epsilon_estimation.do"

*Table C3
do "${prog}/11_epsilon_pre_trend_test.do"

*Table C5
do "${prog}/12_epsilon_firm_characteristics.do"

*Section 5.1 point estimates
do "${prog}/13_estimate_epsilon_sigma.do"

*Section 5.3; Figure C1
do "${prog}/14_epsilon_sigma_histogram.do"

*Tables C2, C4 (instrument validity)
do "${prog}/15_epsilon_shift_share.do"

*Run this dofile in conjunction with the matlab code to obtain all of the numbers in Table C6
do "${prog}/16_estimate_nu.do"
shell matlab -batch "run('${prog}/estimate_nu_cont.m')"

*Tables A1-A2; Figures 1, A1-A4, A6
do "${prog}/17_empirical_facts.do"

*Tables A6-A8; Figure A9
do "${prog}/18_immigrant_comparative_advantage.do"

*Table 1 / Table C7; Section 5.1
do "${prog}/19_moments_calculation.do"

cap log close
