## Code Quality

### Stata

[CRITICAL] Hardcoded absolute path detected — the package will not run on another machine. (master_file.do, line 20)
  → global root "C:/Users/E1NXM04/Dropbox/Brinatti_Morales_Replication_Package"

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (10_epsilon_estimation.do, line 111)
  → keep if  sample_epsilon==1

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (10_epsilon_estimation.do, line 146)
  → keep if _n==1

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (11_epsilon_pre_trend_test.do, line 116)
  → keep if  sample_epsilon==1

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (11_epsilon_pre_trend_test.do, line 188)
  → keep if _n==1

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (13_estimate_epsilon_sigma.do, line 245)
  → keep if _n==1

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (15_epsilon_shift_share.do, line 49)
  → drop if nation_single==1 /*natives*/

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (15_epsilon_shift_share.do, line 62)
  → drop if missing(nation)

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (15_epsilon_shift_share.do, line 115)
  → keep if e(sample)==1

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (15_epsilon_shift_share.do, line 123)
  → keep if _merge==3

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (16_estimate_nu.do, line 67)
  → keep if erwstat_gr == 1

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (16_estimate_nu.do, line 75)
  → drop if _merge != 3

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (16_estimate_nu.do, line 81)
  → drop if _merge == 2

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (16_estimate_nu.do, line 83)
  → drop if ao_kreis11 == .

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (16_estimate_nu.do, line 361)
  → drop if _merge == 2

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (16_estimate_nu.do, line 384)
  → drop if missing(tradeable3) | missing(ind_2dig) | missing(local_labor11)

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (16_estimate_nu.do, line 385)
  → drop if nemp_nat_ft == 0 | wemp_nat_ft == 0

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (16_estimate_nu.do, line 413)
  → keep if sample_rev == 1

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (16_estimate_nu.do, line 414)
  → keep if erwstat_gr  == 1

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (16_estimate_nu.do, line 415)
  → keep if age >= 25 & age <= 65

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (16_estimate_nu.do, line 422)
  → drop if _merge != 3

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (17_empirical_facts.do, line 216)
  → keep if emp_tot_tot >= 10 & (jahr == 2003 | jahr == 2011)

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (17_empirical_facts.do, line 893)
  → drop if mig_share_group == .

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (18_immigrant_comparative_advantage.do, line 69)
  → keep if jahr >= 2003 & jahr <= 2011

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (18_immigrant_comparative_advantage.do, line 78)
  → keep if _merge == 3

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (18_immigrant_comparative_advantage.do, line 170)
  → drop if occ_bl == 0 | occ_bl == .

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (18_immigrant_comparative_advantage.do, line 224)
  → drop if nation_single==.

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (19_moments_calculation.do, line 52)
  → keep if jahr>=2003 & jahr<=2011

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (19_moments_calculation.do, line 86)
  → keep if emp_tot_tot>=10

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (1_cleaning_data.do, line 46)
  → drop if betnr==.n

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (1_cleaning_data.do, line 293)
  → drop if ao_kreis==.

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (2_local_labor_markets.do, line 37)
  → keep if ao_kreis11!=.

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (4_dataset_firm_level.do, line 90)
  → drop if _m==2

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (4_dataset_firm_level.do, line 93)
  → drop if ao_kreis11==.

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (4_dataset_firm_level.do, line 94)
  → drop if ind_2dig==.

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (4_dataset_firm_level.do, line 129)
  → keep if betr_st==1 | betr_st==2

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (4_dataset_firm_level.do, line 130)
  → keep if jahr>=2003 & jahr<=2011

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (4_dataset_firm_level.do, line 194)
  → drop if _m==2

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (4_dataset_firm_level.do, line 584)
  → drop if _m==2

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (4_dataset_firm_level.do, line 602)
  → drop if _m==2

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (5_dataset_for_instrument_validation.do, line 50)
  → drop if betnr==.n

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (5_dataset_for_instrument_validation.do, line 64)
  → keep if (start_month<=6 & end_month>=6) & (start_day<=30 & end_day>=30)

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (5_dataset_for_instrument_validation.do, line 65)
  → keep if start_year==end_year

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (5_dataset_for_instrument_validation.do, line 69)
  → keep if max_wage>=tentgelt_orig-0.001 & max_wage<=tentgelt_orig+0.001

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (5_dataset_for_instrument_validation.do, line 190)
  → keep if jahr>=2003 & jahr<=2011

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (5_dataset_for_instrument_validation.do, line 192)
  → keep if erwstat_gr==1

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (5_dataset_for_instrument_validation.do, line 196)
  → drop if _m!=3

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (5_dataset_for_instrument_validation.do, line 204)
  → drop if _m==2

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (5_dataset_for_instrument_validation.do, line 207)
  → drop if ao_kreis11==.

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (5_dataset_for_instrument_validation.do, line 303)
  → keep if jahr>=2003 & jahr<=2011

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (6_dataset_for_regressions_validation.do, line 48)
  → keep if jahr>=2003 & jahr<=2011

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (6_dataset_for_regressions_validation.do, line 53)
  → drop if _m==2

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (6_dataset_for_regressions_validation.do, line 147)
  → drop if wb_ger>r(p99)

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (6_dataset_for_regressions_validation.do, line 174)
  → drop if z_logrevenues>4   & z_logrevenues~=.

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (6_dataset_for_regressions_validation.do, line 175)
  → drop if z_logrevenues<-4  & z_logrevenues~=.

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (6_dataset_for_regressions_validation.do, line 180)
  → drop if z_logemp_tot_tot>4   & z_logemp_tot_tot~=.

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (6_dataset_for_regressions_validation.do, line 181)
  → drop if z_logemp_tot_tot<-4  & z_logemp_tot_tot~=.

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (7_dataset_for_epsilon_estimation.do, line 44)
  → drop if betnr==.n

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (7_dataset_for_epsilon_estimation.do, line 62)
  → keep if (start_month<=6 & end_month>=6) & (start_day<=30 & end_day>=30)

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (7_dataset_for_epsilon_estimation.do, line 63)
  → keep if start_year==end_year

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (7_dataset_for_epsilon_estimation.do, line 67)
  → keep if max_wage>=tentgelt_orig-0.001 & max_wage<=tentgelt_orig+0.001

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (7_dataset_for_epsilon_estimation.do, line 197)
  → keep if erwstat_gr==1

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (7_dataset_for_epsilon_estimation.do, line 206)
  → drop if _m!=3

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (7_dataset_for_epsilon_estimation.do, line 213)
  → drop if _m==2

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (7_dataset_for_epsilon_estimation.do, line 216)
  → drop if ao_kreis11==.

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (7_dataset_for_epsilon_estimation.do, line 500)
  → keep if jahr>=2003 & jahr<=2011

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (7_dataset_for_epsilon_estimation.do, line 564)
  → drop if _m==2

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (7_dataset_for_epsilon_estimation.do, line 948)
  → drop if _m==2

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (7_dataset_for_epsilon_estimation.do, line 1021)
  → drop if nemp_nat_ft==0 | wemp_nat_ft==0

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (8_validation_regressions.do, line 93)
  → keep if sample_rev==1

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (9_kappa_estimation.do, line 101)
  → keep if sample_epsilon ==1

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (9_kappa_estimation.do, line 150)
  → drop if nation_single==1

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (Validation_cross_CI_heterog.do, line 112)
  → keep if t==1

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (1a_create_data_event_study.do, line 52)
  → drop if betnr==.n

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (1a_create_data_event_study.do, line 68)
  → keep if (start_month<=6 & end_month>=6) & (start_day<=30 & end_day>=30)

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (1a_create_data_event_study.do, line 69)
  → keep if start_year==end_year

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (1a_create_data_event_study.do, line 183)
  → keep if jahr>=1995

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (1c_create_data_figA7.do, line 42)
  → drop if betnr==.n

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (1c_create_data_figA7.do, line 58)
  → keep if (start_month<=6 & end_month>=6) & (start_day<=30 & end_day>=30)

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (1c_create_data_figA7.do, line 59)
  → keep if start_year==end_year

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (2b_results_figA7.do, line 54)
  → keep if jahr>2002

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (2c_results_figA5.do, line 124)
  → drop if Dnemp_imm_f1==1

