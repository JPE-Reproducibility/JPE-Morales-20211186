## Appendix: Detailed PII Detection Results

*Generated on 2026-07-28 21:59:57*

This appendix lists all detected instances of potential personally identifiable information (PII) in the project files. Each entry shows the matched PII terms and, for data files, sample values to help verify whether the flagged content is indeed sensitive.

### Full Summary Table

| File Type | File | Variables/References | PII Categories |
|-----------|------|----------------------|----------------|
| Data | `SIEED_7518_v1_bhp_basis_v1.dta` | 4 | lat, son |
| Data | `WIOT2012_October16_ROW.dta` | 1 | country |
| Data | `cpigermany.dta` | 1 | lat |
| Data | `iabbp_2004.dta` | 26 | son, url |
| Data | `iabbp_2005.dta` | 21 | son, lat |
| Data | `iabbp_2006.dta` | 21 | son, url |
| Data | `iabbp_2007.dta` | 19 | son, lat |
| Data | `iabbp_2008.dta` | 22 | son, lat |
| Data | `iabbp_2009.dta` | 20 | son, lat |
| Data | `iabbp_2010.dta` | 28 | son, url, lat |
| Data | `iabbp_2011.dta` | 26 | son, url, lat |
| Data | `iabbp_2012.dta` | 25 | son, lat |
| Data | `liab_lm_9314_v1_bhp_basis_v1.dta` | 3 | lat, son |
| Data | `liab_lm_9314_v1_pers.dta` | 4 | son, gender, school, lat |
| Data | `local labor markets.dta` | 13 | name, loc |
| Data | `oecd_weekly_hours_germany_2019_all_employees.csv` | 1 | sex |
| Data | `oecd_weekly_hours_germany_2019_full_time.csv` | 1 | sex |
| Data | `sieed_7518_v1.dta` | 1 | son |
| Data | `wdi_gdp_per_capita_ppp_2011.csv` | 3 | country, name |
| Data | `wdi_population_2011.csv` | 3 | country, name |
| Code | `10_epsilon_estimation.do` | 48 | city, lon, name, loc |
| Code | `11_epsilon_pre_trend_test.do` | 62 | lon, name, loc |
| Code | `12_epsilon_firm_characteristics.do` | 17 | lon, block, loc |
| Code | `13_estimate_epsilon_sigma.do` | 44 | lon, name, loc |
| Code | `14_epsilon_sigma_histogram.do` | 21 | lon, block, loc, lat |
| Code | `15_epsilon_shift_share.do` | 21 | lon, country, block, loc, lat, name |
| Code | `16_estimate_nu.do` | 21 | lon, district, gender, name, loc, location |
| Code | `17_empirical_facts.do` | 33 | lon, name, loc |
| Code | `18_immigrant_comparative_advantage.do` | 31 | lon, lat, loc, gender, country, name |
| Code | `19_moments_calculation.do` | 12 | city, lon, block, loc, lat |
| Code | `1_cleaning_data.do` | 10 | lon, lat, birth, country, social, district |
| Code | `1a_create_data_event_study.do` | 16 | loc, location, country, social, block, lat, name, lon, child, gender, district |
| Code | `1b_add_local_labor_market.do` | 418 | loc, district, city |
| Code | `1c_create_data_figA7.do` | 8 | lat, name, lon, district |
| Code | `2_local_labor_markets.do` | 7 | district, loc |
| Code | `2a_results_event_studies.do` | 41 | loc, lon, name, district, lat |
| Code | `2b_results_figA7.do` | 8 | loc, name, lat |
| Code | `2c_results_figA5.do` | 8 | name, lat |
| Code | `4_dataset_firm_level.do` | 31 | lon, lat, name, loc |
| Code | `5_dataset_for_instrument_validation.do` | 39 | lon, country, lat, name, loc |
| Code | `6_dataset_for_regressions_validation.do` | 11 | lon, loc, lat, location |
| Code | `7_dataset_for_epsilon_estimation.do` | 45 | lon, city, country, lat, name, loc |
| Code | `8_validation_regressions.do` | 53 | lon, loc, city, name, country |
| Code | `9_kappa_estimation.do` | 19 | city, lon, lat, loc |
| Code | `Calibration_Res.m` | 19 | lat, name |
| Code | `ComputeMoments.m` | 7 | lat |
| Code | `Counterfactual_heterogeneous_closed.m` | 1 | name |
| Code | `Counterfactual_heterogeneous_open.m` | 1 | name |
| Code | `Counterfactual_homogeneous_closed.m` | 1 | name |
| Code | `Counterfactual_homogeneous_open.m` | 1 | name |
| Code | `Counterfactual_plots_heterog.do` | 12 | name, loc, location |
| Code | `Counterfactual_plots_policies.do` | 71 | name, block, loc |
| Code | `Counterfactual_to_compare_policies.m` | 2 | name, lat |
| Code | `Export_latex_tables.m` | 44 | lat, name, city, son, loc, block |
| Code | `GE.m` | 7 | block, loc, lon |
| Code | `GE.m` | 6 | lon |
| Code | `GE.m` | 7 | block, loc, lon |
| Code | `Setup_PP.m` | 2 | lon |
| Code | `Setup_PP.m` | 2 | lon |
| Code | `Validation_cross_CI_heterog.do` | 30 | lat, name, city, loc |
| Code | `equilLoop.m` | 7 | lon |
| Code | `equilLoop.m` | 5 | lon |
| Code | `equilLoop.m` | 3 | lon |
| Code | `estimate_nu_cont.m` | 2 | gender |
| Code | `master.do` | 3 | lon, loc, location, son |
| Code | `master.do` | 19 | lon, loc, lat |
| Code | `master.do` | 4 | country, district, loc, lat |
| Code | `master.m` | 11 | name, lat, son |
| Code | `master_file.do` | 13 | loc, lon, lat, block |
| Code | `mig_costs_mapping.m` | 1 | lat |
| Code | `mig_costs_mapping.m` | 1 | lat |
| Code | `profitexpsd.m` | 4 | lon |
| Code | `profitexpsd.m` | 4 | lon |
| Code | `profitexpsd.m` | 4 | lon |
| Code | `profitnexpntsd.m` | 3 | lon |
| Code | `profitnexpntsd.m` | 3 | lon |
| Code | `profitnexpntsd.m` | 3 | lon |
| Code | `profitnexptsd.m` | 3 | lon |
| Code | `profitnexptsd.m` | 3 | lon |
| Code | `profitnexptsd.m` | 3 | lon |
| Code | `profits.m` | 2 | lon |
| Code | `profits.m` | 2 | lon |
| Code | `profits.m` | 2 | lon |
| Code | `revenues.m` | 5 | lon |
| Code | `revenues.m` | 5 | lon |
| Code | `revenues.m` | 5 | lon |
| Code | `sec61_aggregates.tex` | 1 | lat |
| Code | `sec61_dollar_gains.tex` | 1 | lat |
| Code | `sec63_decomposition.tex` | 1 | lat |
| Code | `sj_grstyle.do` | 1 | loc |
| Code | `table1.tex` | 2 | lat, city |
| Code | `table2.tex` | 1 | lat |
| Code | `tableC7.tex` | 2 | lat |
| Code | `tableD1.tex` | 2 | lat |
| Code | `tableD2.tex` | 1 | lat |
| Code | `tableD3.tex` | 1 | lat |
| Code | `tradable_consumption_share.do` | 8 | house, country, name, loc |
| Code | `utildent.m` | 3 | lon |
| Code | `utildent.m` | 4 | lon |
| Code | `utildent.m` | 4 | lon |
| Code | `utildet.m` | 4 | lon |
| Code | `utildet.m` | 4 | lon |
| Code | `utildet.m` | 4 | lon |
| Code | `write_GER_xlsx.m` | 4 | name |
| Code | `write_GER_xlsx_policy.m` | 4 | name |

### Data Files

**/replication-package/Brinatti_Morales_Replication_Package/calibration_external/data/WIOT2012_October16_ROW.dta**

- Variable: `Country`
  - Matched terms: country
  - Sample values: AUS, AUT, BEL

**/replication-package/Brinatti_Morales_Replication_Package/liab_analysis/orig/cpigermany.dta**

- Variable: `deflator`
  - Matched terms: lat
  - Sample values: 0.804084300994873, 0.8113210797309875, 0.8234909176826477

**/replication-package/Brinatti_Morales_Replication_Package/liab_analysis/orig/iabbp_2004.dta**

- Variable: `l01son03` (label: *anz. sonstige besch. 06/03*)
  - Matched terms: son
  - Sample values: 4.0, 0.0, 30.0
- Variable: `l01son04` (label: *anz. sonstige besch. 06/04*)
  - Matched terms: son
  - Sample values: 4.0, 0.0, 39.0
- Variable: `l05a` (label: *zu hoher personalbestand*)
  - Matched terms: son
  - Sample values: 0.0, 1.0, -9.0
- Variable: `l05b` (label: *hohe personalfluktuation*)
  - Matched terms: son
  - Sample values: 0.0, 1.0, -9.0
- Variable: `l05c` (label: *personalmangel*)
  - Matched terms: son
  - Sample values: 0.0, 1.0, -9.0
- Variable: `l05i` (label: *mutterschaft, erziehungsurlaub*)
  - Matched terms: url
  - Sample values: 0.0, 1.0, -9.0
- Variable: `l05o` (label: *andere personalprobleme*)
  - Matched terms: son
  - Sample values: 0.0, 1.0, -9.0
- Variable: `l05p` (label: *keine personalprobleme*)
  - Matched terms: son
  - Sample values: 1.0, 0.0, -9.0
- Variable: `l15c` (label: *investitionen in sonst. produkt.-anlagen*)
  - Matched terms: son
  - Sample values: 0.0, 1.0, -9.0
- Variable: `l24cd` (label: *sonstiges*)
  - Matched terms: son
  - Sample values: 0.0, 1.0
- Variable: `l25be` (label: *mangel an fachpersonal*)
  - Matched terms: son
  - Sample values: 0.0, 1.0, -9.0
- Variable: `l25bh` (label: *sonstiges*)
  - Matched terms: son
  - Sample values: 0.0, 1.0, -9.0
- Variable: `l26aj` (label: *sonstiges*)
  - Matched terms: son
  - Sample values: 0.0, 1.0, -9.0
- Variable: `l35a` (label: *anz. personen oberste fÃ¼hrungsebene*)
  - Matched terms: son
  - Sample values: 1.0, 4.0, 0.0
- Variable: `l36b` (label: *anz. personen zweite fÃ¼hrungsebene*)
  - Matched terms: son
  - Sample values: 6.0, 1.0, 7.0
- Variable: `l45b` (label: *stelle besetzt mit Ã¼ber 50-jÃ¤hriger person*)
  - Matched terms: son
  - Sample values: 2.0, 1.0
- Variable: `l48g` (label: *sonstiges*)
  - Matched terms: son
  - Sample values: 0.0, -9.0
- Variable: `l49` (label: *personalabgÃ¤nge im 1. hj.2004*)
  - Matched terms: son
  - Sample values: 1.0, 2.0, -9.0
- Variable: `l50j` (label: *anz. sonstige abgÃ¤nge*)
  - Matched terms: son
  - Sample values: 0.0, 1.0, 7.0
- Variable: `l63h` (label: *sonstige instrumente*)
  - Matched terms: son
  - Sample values: 0.0, 1.0, -9.0
- Variable: `l76af` (label: *sonstige grÃ¼nde*)
  - Matched terms: son
  - Sample values: 0.0, 1.0
- Variable: `l81d` (label: *sonstige grÃ¼nde*)
  - Matched terms: son
  - Sample values: 1.0, 0.0, -9.0
- Variable: `l84g` (label: *sonstige grÃ¼nde*)
  - Matched terms: son
  - Sample values: 0.0, 1.0, -9.0
- Variable: `l86b` (label: *angebote fÃ¼r personen in elternzeit*)
  - Matched terms: son
  - Sample values: 0.0, 1.0, -9.0
- Variable: `l87e` (label: *sonstiges*)
  - Matched terms: son
  - Sample values: 0.0, 1.0, -9.0
- Variable: `l88a` (label: *betriebsrat/personalrat*)
  - Matched terms: son
  - Sample values: 2.0, 1.0, -9.0

**/replication-package/Brinatti_Morales_Replication_Package/liab_analysis/orig/iabbp_2005.dta**

- Variable: `m01son04` (label: *anz. sonstige besch. 06/04*)
  - Matched terms: son
  - Sample values: 4.0, 0.0, 41.0
- Variable: `m01son05` (label: *anz. sonstige besch. 06/05*)
  - Matched terms: son
  - Sample values: 5.0, 0.0, 31.0
- Variable: `m06a` (label: *schriftl. plÃ¤ne fÃ¼r personalentw./weiterbildung*)
  - Matched terms: son
  - Sample values: -9.0, 1.0, 0.0
- Variable: `m06b` (label: *schriftl. plÃ¤ne fÃ¼r personalbedarf*)
  - Matched terms: son
  - Sample values: -9.0, 0.0, 1.0
- Variable: `m14a` (label: *mehr umsatz mit vorh. personal/anlagen mÃ¶gl.*)
  - Matched terms: son
  - Sample values: 1.0, 0.0, -9.0
- Variable: `m14b` (label: *zusÃ¤tzl. personal nÃ¶tig*)
  - Matched terms: son
  - Sample values: 0.0, 1.0, -9.0
- Variable: `m16ai` (label: *sonstige angebote*)
  - Matched terms: son
  - Sample values: 0.0, 1.0
- Variable: `m18c` (label: *investitionen in sonst. produkt.-anlagen*)
  - Matched terms: son
  - Sample values: 0.0, 1.0, -9.0
- Variable: `m22b` (label: *anteil sonstige eigenmittel an gesamtinvestitionen*)
  - Matched terms: son
  - Sample values: 0.0, -9.0, 90.0
- Variable: `m33af` (label: *sonstiges*)
  - Matched terms: son
  - Sample values: 0.0, -9.0, 1.0
- Variable: `m41af` (label: *sonstiges*)
  - Matched terms: son
  - Sample values: 0.0, -9.0, 1.0
- Variable: `m44af` (label: *sonstiges*)
  - Matched terms: son
  - Sample values: -9.0, 0.0, 1.0
- Variable: `m48` (label: *personalabgÃ¤nge im 1. hj.2005*)
  - Matched terms: son
  - Sample values: 2.0, 1.0, -9.0
- Variable: `m49j` (label: *anz. sonstige abgÃ¤nge*)
  - Matched terms: son
  - Sample values: 0.0, 1.0, 4.0
- Variable: `m51f` (label: *sonstiges*)
  - Matched terms: son
  - Sample values: 0.0, 1.0, -9.0
- Variable: `m57c` (label: *sonstiges (Ã–ffnungsklauseln)*)
  - Matched terms: son
  - Sample values: -9.0, 0.0, 1.0
- Variable: `m72j` (label: *sonstige lohnkostenzuschÃ¼sse*)
  - Matched terms: son
  - Sample values: 0.0, -9.0, 1.0
- Variable: `m78c` (label: *weiterbildung am arbeitsplatz*)
  - Matched terms: lat
  - Sample values: 1.0, 0.0
- Variable: `m78e` (label: *arbeitsplatzwechsel*)
  - Matched terms: lat
  - Sample values: 0.0, 1.0
- Variable: `m78h` (label: *sonstige weiterbildungsmaÃŸnahmen*)
  - Matched terms: son
  - Sample values: 1.0, 0.0
- Variable: `m85a` (label: *betriebsrat/personalrat*)
  - Matched terms: son
  - Sample values: 2.0, 1.0, -9.0

**/replication-package/Brinatti_Morales_Replication_Package/liab_analysis/orig/iabbp_2006.dta**

- Variable: `n01son05` (label: *anz. sonstige besch. 06/05*)
  - Matched terms: son
  - Sample values: 0.0, 1.0, 4.0
- Variable: `n01son06` (label: *anz. sonstige besch. 06/06*)
  - Matched terms: son
  - Sample values: 0.0, 9.0, 1.0
- Variable: `n05a` (label: *zu hoher personalstand*)
  - Matched terms: son
  - Sample values: 0.0, 1.0, -9.0
- Variable: `n05b` (label: *hohe personalfluktuation*)
  - Matched terms: son
  - Sample values: 0.0, -9.0, 1.0
- Variable: `n05c` (label: *personalmangel*)
  - Matched terms: son
  - Sample values: 0.0, 1.0, -9.0
- Variable: `n05h` (label: *mutterschaft/erziehungsurlaub*)
  - Matched terms: url
  - Sample values: 0.0, 1.0, -9.0
- Variable: `n05m` (label: *andere personalprobleme*)
  - Matched terms: son
  - Sample values: 0.0, -9.0, 1.0
- Variable: `n05n` (label: *keine personalprobleme*)
  - Matched terms: son
  - Sample values: 1.0, 0.0, -9.0
- Variable: `n14c` (label: *investitionen in sonst. produkt.anlagen*)
  - Matched terms: son
  - Sample values: 0.0, 1.0, -9.0
- Variable: `n29b` (label: *besond. ausstattung d. arbeitsplÃ¤tze*)
  - Matched terms: son
  - Sample values: 0.0, 1.0, -9.0
- Variable: `n36` (label: *personalabgÃ¤nge im 1. hj. 2006*)
  - Matched terms: son
  - Sample values: 2.0, 1.0, -9.0
- Variable: `n37j` (label: *anz. sonstige abgÃ¤nge*)
  - Matched terms: son
  - Sample values: 0.0, 1.0, 7.0
- Variable: `n46h` (label: *sonstige maÃŸnahmen zu arbeitszeiten*)
  - Matched terms: son
  - Sample values: 1.0, 2.0, -9.0
- Variable: `n47c` (label: *abstriche bei sonderzahlungen u.Ã¤.*)
  - Matched terms: son
  - Sample values: 1.0, 2.0, -9.0
- Variable: `n47h` (label: *sonstige maÃŸnahmen zur vergÃ¼tung*)
  - Matched terms: son
  - Sample values: 1.0, 2.0, -9.0
- Variable: `n50j` (label: *sonstige zusagen*)
  - Matched terms: son
  - Sample values: 1.0, 2.0, -9.0
- Variable: `n60e` (label: *sonstiges*)
  - Matched terms: son
  - Sample values: 0.0, 1.0, -9.0
- Variable: `n63c` (label: *stÃ¤ndige/regelmÃ¤ÃŸige sonntagsarbeit*)
  - Matched terms: son
  - Sample values: 2.0, 1.0, -9.0
- Variable: `n84a` (label: *betriebsrat/personalrat*)
  - Matched terms: son
  - Sample values: 2.0, -9.0, 1.0
- Variable: `n85` (label: *rolle betriebs-/personalrat bei betriebl. entscheidungen*)
  - Matched terms: son
  - Sample values: 2.0, 3.0, -9.0
- Variable: `n89g` (label: *sonstiger investitionsgrund*)
  - Matched terms: son
  - Sample values: 0.0, -9.0, 1.0

**/replication-package/Brinatti_Morales_Replication_Package/liab_analysis/orig/iabbp_2007.dta**

- Variable: `o01son06` (label: *anz. sonstige besch. 06/06*)
  - Matched terms: son
  - Sample values: 0.0, 1.0, 3.0
- Variable: `o01son07` (label: *anz. sonstige besch. 06/07*)
  - Matched terms: son
  - Sample values: 0.0, 1.0, 3.0
- Variable: `o07a` (label: *schriftl. plÃ¤ne fÃ¼r personalentw./weiterbildung*)
  - Matched terms: son
  - Sample values: 2.0, 1.0, -9.0
- Variable: `o07b` (label: *schriftl. plÃ¤ne fÃ¼r personalbedarf*)
  - Matched terms: son
  - Sample values: 2.0, 1.0, -9.0
- Variable: `o17c` (label: *investitionen in sonst. produkt.anlagen*)
  - Matched terms: son
  - Sample values: 0.0, 1.0, -9.0
- Variable: `o28be` (label: *mangel an fachpersonal*)
  - Matched terms: son
  - Sample values: 0.0, 1.0, -9.0
- Variable: `o28bh` (label: *sonstige*)
  - Matched terms: son
  - Sample values: 0.0, 1.0, -9.0
- Variable: `o29aj` (label: *sonstige*)
  - Matched terms: son
  - Sample values: 0.0, -9.0, 1.0
- Variable: `o49` (label: *personalabgÃ¤nge im 1. hj. 2007*)
  - Matched terms: son
  - Sample values: 2.0, 1.0, -9.0
- Variable: `o50j` (label: *anz. sonstige abgÃ¤nge*)
  - Matched terms: son
  - Sample values: 1.0, 0.0, 2.0
- Variable: `o57e` (label: *lÃ¤ngerfristige personalentwicklung (innerbetr. maÃŸnahmen)*)
  - Matched terms: son
  - Sample values: 2.0, 1.0, 3.0
- Variable: `o57h` (label: *sonstige maÃŸnahmen (innerbetr. maÃŸnahmen)*)
  - Matched terms: son
  - Sample values: 3.0, 1.0, -9.0
- Variable: `o58c` (label: *weiterbildung am arbeitsplatz*)
  - Matched terms: lat
  - Sample values: 1.0, 0.0, -9.0
- Variable: `o58e` (label: *arbeitsplatzwechsel*)
  - Matched terms: lat
  - Sample values: 0.0, 1.0, -9.0
- Variable: `o58h` (label: *sonstige weiterbildungsmaÃŸnahmen*)
  - Matched terms: son
  - Sample values: 0.0, 1.0, -9.0
- Variable: `o63ges` (label: *personen/teilnahmefÃ¤lle gesamt*)
  - Matched terms: son
  - Sample values: 1.0, 14.0, 5.0
- Variable: `o76h` (label: *sonstige programme*)
  - Matched terms: son
  - Sample values: 0.0, 1.0, -9.0
- Variable: `o84cc` (label: *sonstiges (nutzung von Ã–ffnungsklauseln)*)
  - Matched terms: son
  - Sample values: 0.0, 1.0
- Variable: `o86a` (label: *betriebsrat/personalrat*)
  - Matched terms: son
  - Sample values: 2.0, 1.0, -9.0

**/replication-package/Brinatti_Morales_Replication_Package/liab_analysis/orig/iabbp_2008.dta**

- Variable: `p01son07` (label: *anz. sonstige besch. 06/07*)
  - Matched terms: son
  - Sample values: 0.0, 1.0, 3.0
- Variable: `p01son08` (label: *anz. sonstige besch. 06/08*)
  - Matched terms: son
  - Sample values: 0.0, 1.0, 2.0
- Variable: `p05a` (label: *zu hoher personalstand*)
  - Matched terms: son
  - Sample values: 0.0, 1.0, -9.0
- Variable: `p05b` (label: *hohe personalfluktuation*)
  - Matched terms: son
  - Sample values: 0.0, 1.0, -9.0
- Variable: `p05d` (label: *personalmangel*)
  - Matched terms: son
  - Sample values: 0.0, 1.0, -9.0
- Variable: `p05j` (label: *andere personalprobleme*)
  - Matched terms: son
  - Sample values: 0.0, 1.0, -9.0
- Variable: `p05k` (label: *keine personalprobleme*)
  - Matched terms: son
  - Sample values: 0.0, 1.0, -9.0
- Variable: `p14a` (label: *mehr umsatz mit vorhand. personal/anlagen wÃ¤re mÃ¶glich gewesen*)
  - Matched terms: son
  - Sample values: 0.0, 1.0, -9.0
- Variable: `p14b` (label: *zusÃ¤tzliches personal wÃ¤re nÃ¶tig gewesen*)
  - Matched terms: son
  - Sample values: 1.0, 0.0, -9.0
- Variable: `p18c` (label: *investitionen in sonst. prod.anlagen*)
  - Matched terms: son
  - Sample values: 0.0, 1.0, -9.0
- Variable: `p21b` (label: *sonstige eigenmittel*)
  - Matched terms: son
  - Sample values: 0.0, 48.0, 8.0
- Variable: `p38b` (label: *besond. ausstattung der arbeitsplÃ¤tze*)
  - Matched terms: son
  - Sample values: 0.0, 1.0, -9.0
- Variable: `p43af` (label: *sonstige kompromisse*)
  - Matched terms: son
  - Sample values: 0.0, 1.0, -9.0
- Variable: `p53` (label: *personalabgÃ¤nge im 1. hj. 2008*)
  - Matched terms: son
  - Sample values: 2.0, 1.0, -9.0
- Variable: `p54j` (label: *anz. sonstige abgÃ¤nge*)
  - Matched terms: son
  - Sample values: 0.0, 5.0, 1.0
- Variable: `p75c` (label: *weiterbildung am arbeitsplatz*)
  - Matched terms: lat
  - Sample values: 1.0, 0.0, -9.0
- Variable: `p75e` (label: *arbeitsplatzwechsel*)
  - Matched terms: lat
  - Sample values: 0.0, 1.0, -9.0
- Variable: `p75h` (label: *sonstige weiterbildungsmaÃŸnahmen*)
  - Matched terms: son
  - Sample values: 0.0, 1.0, -9.0
- Variable: `p77ges` (label: *personen/teilnahmefÃ¤lle gesamt*)
  - Matched terms: son
  - Sample values: 2.0, 8.0, 29.0
- Variable: `p84e` (label: *langzeitkonten fÃ¼r sonstiges*)
  - Matched terms: son
  - Sample values: 0.0, -9.0, 1.0
- Variable: `p85c` (label: *stÃ¤ndige oder regelmÃ¤ÃŸige sonntagsarbeit*)
  - Matched terms: son
  - Sample values: 1.0, 2.0, -9.0
- Variable: `p86a` (label: *betriebsrat/personalrat*)
  - Matched terms: son
  - Sample values: 2.0, 1.0, -9.0

**/replication-package/Brinatti_Morales_Replication_Package/liab_analysis/orig/iabbp_2009.dta**

- Variable: `q01son08` (label: *Anz. sonstige Besch. 06/08*)
  - Matched terms: son
  - Sample values: 0.0, 1.0, 2.0
- Variable: `q01son09` (label: *Anz. sonstige Besch. 06/09*)
  - Matched terms: son
  - Sample values: 0.0, 2.0, 1.0
- Variable: `q11a` (label: *Mehr Umsatz mit vorhand. Personal/Anlagen wÃ¤re mÃ¶glich gewesen*)
  - Matched terms: son
  - Sample values: 0.0, 1.0, -9.0
- Variable: `q11b` (label: *ZusÃ¤tzliches Personal wÃ¤re nÃ¶tig gewesen*)
  - Matched terms: son
  - Sample values: 1.0, 0.0, -9.0
- Variable: `q16c` (label: *Investitionen in sonst. Prod.anlagen*)
  - Matched terms: son
  - Sample values: 1.0, 0.0, -9.0
- Variable: `q19cb` (label: *Sonstiges*)
  - Matched terms: son
  - Sample values: 0.0, 1.0
- Variable: `q20be` (label: *Sonstige Kreditkonditionen wurden verschÃ¤rft*)
  - Matched terms: son
  - Sample values: 1.0, 0.0
- Variable: `q26be` (label: *Mangel an Fachpersonal*)
  - Matched terms: son
  - Sample values: 0.0, 1.0
- Variable: `q26bh` (label: *Sonstige*)
  - Matched terms: son
  - Sample values: 0.0, 1.0
- Variable: `q32af` (label: *Geringfg. Besch.: Sonstiges*)
  - Matched terms: son
  - Sample values: 0.0, 1.0, -9.0
- Variable: `q36ag` (label: *Befr. Besch.: Sonstiges*)
  - Matched terms: son
  - Sample values: 0.0, 1.0, -9.0
- Variable: `q64` (label: *PersonalabgÃ¤nge im 1. Hj. 2009*)
  - Matched terms: son
  - Sample values: 1.0, 2.0, -9.0
- Variable: `q65j` (label: *Anz. sonstige AbgÃ¤nge*)
  - Matched terms: son
  - Sample values: 0.0, 1.0, -9.0
- Variable: `q67j` (label: *Sonstige Unterst. der betr. Ausbildung*)
  - Matched terms: son
  - Sample values: 0.0, 1.0, -9.0
- Variable: `q67l` (label: *Sonstige Programme*)
  - Matched terms: son
  - Sample values: 0.0, 1.0, -9.0
- Variable: `q71bc` (label: *Weiterbildung am Arbeitsplatz*)
  - Matched terms: lat
  - Sample values: 1.0, 0.0, -9.0
- Variable: `q71be` (label: *Arbeitsplatzwechsel*)
  - Matched terms: lat
  - Sample values: 0.0, 1.0, -9.0
- Variable: `q71bh` (label: *Sonstige WeiterbildungsmaÃŸnahmen*)
  - Matched terms: son
  - Sample values: 0.0, 1.0, -9.0
- Variable: `q73ges` (label: *Personen/TeilnahmefÃ¤lle gesamt*)
  - Matched terms: son
  - Sample values: 11.0, 30.0, 17.0
- Variable: `q84a` (label: *Betriebsrat/Personalrat*)
  - Matched terms: son
  - Sample values: 2.0, 1.0, -9.0

**/replication-package/Brinatti_Morales_Replication_Package/liab_analysis/orig/iabbp_2010.dta**

- Variable: `r01son09` (label: *anz. sonstige besch. 06/09*)
  - Matched terms: son
  - Sample values: 0.0, 2.0, 1.0
- Variable: `r01son10` (label: *anz. sonstige besch. 06/10*)
  - Matched terms: son
  - Sample values: 0.0, 3.0, 1.0
- Variable: `r07ab` (label: *angeordnete inanspruchnahme von urlaub*)
  - Matched terms: url
  - Sample values: 2.0, 1.0, -9.0
- Variable: `r07aj` (label: *zurÃ¼ckstellen geplanter personalaufstockungen*)
  - Matched terms: son
  - Sample values: 2.0, -9.0, 1.0
- Variable: `r07al` (label: *sonstiges*)
  - Matched terms: son
  - Sample values: 2.0, 1.0, -9.0
- Variable: `r08a` (label: *zu hoher personalstand*)
  - Matched terms: son
  - Sample values: 0.0, -9.0, 1.0
- Variable: `r08b` (label: *hohe personalfluktuation*)
  - Matched terms: son
  - Sample values: 0.0, -9.0, 1.0
- Variable: `r08d` (label: *personalmangel*)
  - Matched terms: son
  - Sample values: 1.0, 0.0, -9.0
- Variable: `r08j` (label: *andere personalprobleme*)
  - Matched terms: son
  - Sample values: 0.0, 1.0, -9.0
- Variable: `r08k` (label: *keine personalprobleme*)
  - Matched terms: son
  - Sample values: 0.0, -9.0, 1.0
- Variable: `r14a` (label: *mehr umsatz mit vorhand. personal/anlagen wÃ¤re mÃ¶glich gewesen*)
  - Matched terms: son
  - Sample values: 0.0, 1.0, -9.0
- Variable: `r14b` (label: *zusÃ¤tzliches personal wÃ¤re nÃ¶tig gewesen*)
  - Matched terms: son
  - Sample values: 1.0, 0.0, -9.0
- Variable: `r19c` (label: *investitionen in sonst. prod.anlagen*)
  - Matched terms: son
  - Sample values: 1.0, 0.0, -9.0
- Variable: `r23be` (label: *sonstige kreditkonditionen wurden verschÃ¤rft*)
  - Matched terms: son
  - Sample values: 1.0, 0.0
- Variable: `r29aj` (label: *sonstige*)
  - Matched terms: son
  - Sample values: -9.0, 0.0, 1.0
- Variable: `r46` (label: *personalabgÃ¤nge im 1. hj. 2010*)
  - Matched terms: son
  - Sample values: 1.0, 2.0, -9.0
- Variable: `r47j` (label: *anz. sonstige abgÃ¤nge*)
  - Matched terms: son
  - Sample values: 1.0, 0.0, 4.0
- Variable: `r49ae` (label: *vermeidung von kosten/aufwand bzgl. personal-akquise u. trennung*)
  - Matched terms: son
  - Sample values: 0.0, 1.0, -9.0
- Variable: `r49ag` (label: *sonstige*)
  - Matched terms: son
  - Sample values: 0.0, 1.0, -9.0
- Variable: `r56c` (label: *weiterbildung am arbeitsplatz*)
  - Matched terms: lat
  - Sample values: 0.0, 1.0
- Variable: `r56e` (label: *arbeitsplatzwechsel*)
  - Matched terms: lat
  - Sample values: 0.0, 1.0
- Variable: `r56h` (label: *sonstige weiterbildungsmaÃŸnahmen*)
  - Matched terms: son
  - Sample values: 0.0, 1.0
- Variable: `r58ges` (label: *personen/teilnahmefÃ¤lle gesamt*)
  - Matched terms: son
  - Sample values: 21.0, 16.0, 2.0
- Variable: `r58ges_f` (label: *personen/teilnahmefÃ¤lle (frauen)*)
  - Matched terms: son
  - Sample values: 19.0, 7.0, 0.0
- Variable: `r65e` (label: *sonstiges*)
  - Matched terms: son
  - Sample values: 0.0, 1.0, -9.0
- Variable: `r75e` (label: *langzeitkonten fÃ¼r sonstiges*)
  - Matched terms: son
  - Sample values: 0.0, 1.0, -9.0
- Variable: `r76c` (label: *stÃ¤ndige oder regelmÃ¤ÃŸige sonntagsarbeit*)
  - Matched terms: son
  - Sample values: 2.0, 1.0, -9.0
- Variable: `r79a` (label: *betriebsrat/personalrat*)
  - Matched terms: son
  - Sample values: 2.0, 1.0, -9.0

**/replication-package/Brinatti_Morales_Replication_Package/liab_analysis/orig/iabbp_2011.dta**

- Variable: `s01son10` (label: *anz. sonstige besch. 06/10*)
  - Matched terms: son
  - Sample values: 0.0, 2.0, 1.0
- Variable: `s01son11` (label: *anz. sonstige besch. 06/11*)
  - Matched terms: son
  - Sample values: 0.0, 3.0, 1.0
- Variable: `s06a` (label: *schriftl. plÃ¤ne fÃ¼r personalentw./weiterbildung*)
  - Matched terms: son
  - Sample values: 1.0, 2.0, -9.0
- Variable: `s06b` (label: *schriftl. plÃ¤ne fÃ¼r personalbedarf*)
  - Matched terms: son
  - Sample values: 1.0, 2.0, -9.0
- Variable: `s12a` (label: *mehr umsatz mit vorhand. personal/anlagen wÃ¤re mÃ¶glich gewesen*)
  - Matched terms: son
  - Sample values: 0.0, 1.0, -9.0
- Variable: `s12b` (label: *zusÃ¤tzliches personal wÃ¤re nÃ¶tig gewesen*)
  - Matched terms: son
  - Sample values: 1.0, 0.0, -9.0
- Variable: `s16c` (label: *investitionen in sonst. prod.anlagen*)
  - Matched terms: son
  - Sample values: 0.0, 1.0, -9.0
- Variable: `s24be` (label: *mangel an fachpersonal*)
  - Matched terms: son
  - Sample values: 0.0, 1.0
- Variable: `s24bh` (label: *sonstige*)
  - Matched terms: son
  - Sample values: 0.0, 1.0
- Variable: `s32b` (label: *besond. ausstattung der arbeitsplÃ¤tze*)
  - Matched terms: son
  - Sample values: 0.0, 1.0, -9.0
- Variable: `s37c` (label: *lÃ¤ngerfrist. spez. personalentw. v. mitarbeitern*)
  - Matched terms: son
  - Sample values: 2.0, 1.0, 3.0
- Variable: `s37m` (label: *sonstige strategien*)
  - Matched terms: son
  - Sample values: 3.0, 2.0, 1.0
- Variable: `s49` (label: *personalabgÃ¤nge im 1. hj. 2011*)
  - Matched terms: son
  - Sample values: 2.0, 1.0
- Variable: `s50j` (label: *anz. sonstige abgÃ¤nge*)
  - Matched terms: son
  - Sample values: 0.0, 1.0, -9.0
- Variable: `s55ad` (label: *kÃ¼rz./wegfall v. sonderzahl., urlaubsg. od. sonst. zahl.*)
  - Matched terms: son, url
  - Sample values: 2.0, 1.0, -9.0
- Variable: `s55ae` (label: *sonstiges*)
  - Matched terms: son
  - Sample values: 2.0, 3.0, -9.0
- Variable: `s55bd` (label: *kÃ¼rzg/wegfall v. sonderzahl., urlaubsg. od. sonst. zahl. (nutzung)*)
  - Matched terms: son, url
  - Sample values: 2.0, 1.0, -9.0
- Variable: `s55be` (label: *sonstiges (nutzung)*)
  - Matched terms: son
  - Sample values: 1.0
- Variable: `s55etxt` (label: *sonstige Ã–ffnungsklausel*)
  - Matched terms: son
  - Sample values: 
- Variable: `s57b` (label: *orientierung hinsichtl. dauer jahresurlaub*)
  - Matched terms: url
  - Sample values: 0.0, 1.0, -9.0
- Variable: `s57d` (label: *orientierung hinsichtl. sonst. regelungen*)
  - Matched terms: son
  - Sample values: 0.0, -9.0, 1.0
- Variable: `s71c` (label: *weiterbildung am arbeitsplatz*)
  - Matched terms: lat
  - Sample values: 0.0, 1.0
- Variable: `s71e` (label: *arbeitsplatzwechsel*)
  - Matched terms: lat
  - Sample values: 0.0, 1.0
- Variable: `s71h` (label: *sonstige weiterbildungsmaÃŸnahmen*)
  - Matched terms: son
  - Sample values: 1.0, 0.0
- Variable: `s73ges` (label: *anz. personen/teilnahmefÃ¤lle gesamt 1. hj. 2011*)
  - Matched terms: son
  - Sample values: 22.0, 7.0, 4.0
- Variable: `s77a` (label: *betriebsrat/personalrat vorhanden*)
  - Matched terms: son
  - Sample values: 2.0, 1.0, -9.0

**/replication-package/Brinatti_Morales_Replication_Package/liab_analysis/orig/iabbp_2012.dta**

- Variable: `t01son11` (label: *Anz. sonstige Besch. 06/11*)
  - Matched terms: son
  - Sample values: 0.0, 1.0, 2.0
- Variable: `t01son12` (label: *Anz. sonstige Besch. 06/12*)
  - Matched terms: son
  - Sample values: 0.0, 1.0, 2.0
- Variable: `t05a` (label: *Zu hoher Personalstand*)
  - Matched terms: son
  - Sample values: 0.0, 1.0, -9.0
- Variable: `t05b` (label: *Hohe Personalfluktuation*)
  - Matched terms: son
  - Sample values: 0.0, 1.0, -9.0
- Variable: `t05d` (label: *Personalmangel*)
  - Matched terms: son
  - Sample values: 0.0, 1.0, -9.0
- Variable: `t05j` (label: *Andere Personalprobleme*)
  - Matched terms: son
  - Sample values: 0.0, 1.0, -9.0
- Variable: `t05k` (label: *Keine Personalprobleme*)
  - Matched terms: son
  - Sample values: 1.0, 0.0, -9.0
- Variable: `t12a` (label: *Mehr Umsatz mit vorhand. Personal/Anlagen wÃ¤re mÃ¶glich gewesen*)
  - Matched terms: son
  - Sample values: 0.0, 1.0, -9.0
- Variable: `t12b` (label: *ZusÃ¤tzliches Personal wÃ¤re nÃ¶tig gewesen*)
  - Matched terms: son
  - Sample values: 1.0, 0.0, -9.0
- Variable: `t18ak` (label: *Sonstige GÃ¼ter o. DL fÃ¼r den Umweltschutz*)
  - Matched terms: son
  - Sample values: 0.0, 1.0, -9.0
- Variable: `t28aj` (label: *Sonstige organisatorische Ã„nderungen*)
  - Matched terms: son
  - Sample values: 0.0, -9.0, 1.0
- Variable: `t29b` (label: *Mitarbeiterbefr. zu Gesundheitsschutz am Arbeitsplatz*)
  - Matched terms: lat
  - Sample values: 1.0, 2.0, -9.0
- Variable: `t32cb` (label: *Anz. befrist. Mitarbeiter aus sonst. sachl. Grund*)
  - Matched terms: son
  - Sample values: 1.0, 2.0, 0.0
- Variable: `t46` (label: *PersonalabgÃ¤nge im 1. Hj. 2012*)
  - Matched terms: son
  - Sample values: 2.0, 1.0
- Variable: `t47j` (label: *Anz. sonstige AbgÃ¤nge*)
  - Matched terms: son
  - Sample values: 0.0, -9.0, 2.0
- Variable: `t57ae` (label: *Langzeitkonten fÃ¼r Sonstiges*)
  - Matched terms: son
  - Sample values: 0.0, 1.0, -9.0
- Variable: `t58c` (label: *StÃ¤ndige oder regelmÃ¤ÃŸige Sonntagsarbeit*)
  - Matched terms: son
  - Sample values: -9.0, 2.0, 1.0
- Variable: `t59a` (label: *Personen mit Vorgesetztenfunktion auf 1. Ebene*)
  - Matched terms: son
  - Sample values: 1.0, 2.0, 4.0
- Variable: `t60b` (label: *Personen mit Vorgesetztenfunktion auf 2. Ebene*)
  - Matched terms: son
  - Sample values: 2.0, 3.0, 1.0
- Variable: `t63c` (label: *Weiterbildung am Arbeitsplatz*)
  - Matched terms: lat
  - Sample values: 1.0, 0.0
- Variable: `t63e` (label: *Arbeitsplatzwechsel*)
  - Matched terms: lat
  - Sample values: 0.0, 1.0
- Variable: `t63h` (label: *Sonstige WeiterbildungsmaÃŸnahmen*)
  - Matched terms: son
  - Sample values: 0.0, 1.0
- Variable: `t74a` (label: *Betriebsrat/Personalrat vorhanden*)
  - Matched terms: son
  - Sample values: 2.0, 1.0, -9.0
- Variable: `t74b` (label: *GrÃ¼ndungsjahr Betriebsrat/Personalrat*)
  - Matched terms: son
  - Sample values: -9.0, 9999.0, 1992.0
- Variable: `t93c` (label: *Sonstige GrÃ¼nde gegen Internetbefr.*)
  - Matched terms: son
  - Sample values: 0.0, 1.0, -9.0

**/replication-package/Brinatti_Morales_Replication_Package/liab_analysis/orig/liab_lm_9314_v1_bhp_basis_v1.dta**

- Variable: `az_vz` (label: *Anzahl Vollzeit (Normalbeschaeftigte + sonstige)*)
  - Matched terms: son
  - Sample values: 9.0, 12.0, 35.0
- Variable: `w73_3_gen` (label: *w73_3 vervollstaendigt durch Extrapolation/Imputation*)
  - Matched terms: lat
  - Sample values: 920.0, 740.0, 670.0
- Variable: `w93_3_gen` (label: *w93_3 vervollstaendigt durch Extrapolation/Imputation*)
  - Matched terms: lat
  - Sample values: 551.0, 913.0, 853.0

**/replication-package/Brinatti_Morales_Replication_Package/liab_analysis/orig/liab_lm_9314_v1_pers.dta**

- Variable: `frau` (label: *Gender*)
  - Matched terms: gender
  - Sample values: 1.0, 0.0
- Variable: `grund_orig` (label: *Reason of cancellation/notification/termination*)
  - Matched terms: lat, son
  - Sample values: 30.0, 50.0, 33.0
- Variable: `schule` (label: *School leaving qualification*)
  - Matched terms: school
  - Sample values: 8.0, 5.0, 4.0
- Variable: `spell` (label: *counter per person*)
  - Matched terms: son
  - Sample values: 4.0, 5.0, 6.0

**/replication-package/Brinatti_Morales_Replication_Package/liab_analysis/orig/local labor markets.dta**

- Variable: `ao_kreis11_name` (label: *ao_kreis11_name*)
  - Matched terms: name
  - Sample values: Flensburg, Kiel, Lübeck
- Variable: `ao_kreis_name` (label: *ao_kreis_name*)
  - Matched terms: name
  - Sample values: Flensburg, Stadt, Kiel, Landeshauptstadt, Lübeck, Hansestadt
- Variable: `local_labor` (label: *local_labor*)
  - Matched terms: loc
  - Sample values: 1.001e6, 1.002e6, 1.003e6
- Variable: `local_labor11` (label: *local_labor11*)
  - Matched terms: loc
  - Sample values: 1.001e6, 1.002e6, 1.003e6
- Variable: `local_labor11_name` (label: *local_labor11_name*)
  - Matched terms: loc, name
  - Sample values: Flensburg, Kiel, Lübeck
- Variable: `local_labor2` (label: *local_labor2*)
  - Matched terms: loc
  - Sample values: 1.002e6, 2.0e6, 1.003e6
- Variable: `local_labor2_name` (label: *local_labor2_name*)
  - Matched terms: loc, name
  - Sample values: Kiel, Hamburg, Lübeck
- Variable: `local_labor2_share` (label: *local_labor2_share*)
  - Matched terms: loc
  - Sample values: 3.732674, 5.420504, 12.983599
- Variable: `local_labor_name` (label: *local_labor_name*)
  - Matched terms: loc, name
  - Sample values: Flensburg, Kiel, Lübeck
- Variable: `local_labor_share` (label: *local_labor_share*)
  - Matched terms: loc
  - Sample values: 90.297478, 88.279137, 79.831963
- Variable: `region11_name` (label: *region11_name*)
  - Matched terms: name
  - Sample values: Hamburg, Braunschweig/Wolfsburg, Göttingen
- Variable: `region2_name` (label: *region2_name*)
  - Matched terms: name
  - Sample values: Frankfurt a.M., Düsseldorf-Ruhr, München
- Variable: `region_name` (label: *region_name*)
  - Matched terms: name
  - Sample values: Hamburg, Braunschweig/Wolfsburg, Göttingen

**/replication-package/Brinatti_Morales_Replication_Package/model_analysis/data/raw/oecd_weekly_hours_germany_2019_all_employees.csv**

- Variable: `SEX`
  - Matched terms: sex
  - Sample values: _T

**/replication-package/Brinatti_Morales_Replication_Package/model_analysis/data/raw/oecd_weekly_hours_germany_2019_full_time.csv**

- Variable: `SEX`
  - Matched terms: sex
  - Sample values: _T

**/replication-package/Brinatti_Morales_Replication_Package/model_analysis/data/raw/wdi_gdp_per_capita_ppp_2011.csv**

- Variable: `country_iso3`
  - Matched terms: country
  - Sample values: ABW, AFE, AFG
- Variable: `country_name`
  - Matched terms: country, name
  - Sample values: Aruba, Africa Eastern and Southern, Afghanistan
- Variable: `indicator_name`
  - Matched terms: name
  - Sample values: GDP per capita, PPP (current international $)

**/replication-package/Brinatti_Morales_Replication_Package/model_analysis/data/raw/wdi_population_2011.csv**

- Variable: `country_iso3`
  - Matched terms: country
  - Sample values: ABW, AFE, AFG
- Variable: `country_name`
  - Matched terms: country, name
  - Sample values: Aruba, Africa Eastern and Southern, Afghanistan
- Variable: `indicator_name`
  - Matched terms: name
  - Sample values: Population, total

**/replication-package/Brinatti_Morales_Replication_Package/sieed_analysis/orig/SIEED_7518_v1_bhp_basis_v1.dta**

- Variable: `az_vz` (label: *Anzahl Vollzeit (Normalbeschaeftigte + sonstige)*)
  - Matched terms: son
  - Sample values: 11.0, 10.0, 2.0
- Variable: `w08_3_gen` (label: *w08_3 vervollstaendigt durch Extrapolation/Imputation*)
  - Matched terms: lat
  - Sample values: 432.0, 881.0, 477.0
- Variable: `w73_3_gen` (label: *w73_3 vervollstaendigt durch Extrapolation/Imputation*)
  - Matched terms: lat
  - Sample values: 625.0, 670.0, 780.0
- Variable: `w93_3_gen` (label: *w93_3 vervollstaendigt durch Extrapolation/Imputation*)
  - Matched terms: lat
  - Sample values: 930.0, 205.0, 747.0

**/replication-package/Brinatti_Morales_Replication_Package/sieed_analysis/orig/sieed_7518_v1.dta**

- Variable: `persnr` (label: *Systemfreie Personennummer*)
  - Matched terms: son
  - Sample values: 2.785384e6, 2.785395e6, 2.785397e6

### Code Files

**/replication-package/Brinatti_Morales_Replication_Package/calibration_external/prog/tradable_consumption_share.do**

- Line 4: house
  ```
  Computes the share of German household final consumption expenditure
  ```
- Line 19: country
  ```
  keep if Country == "DEU"
  ```
- Line 21: house
  ```
  * Keep household final consumption column and identifiers
  ```
- Line 24: name
  ```
  * Rename for clarity
  ```
- Line 25: name
  ```
  rename vDEU57 hh_cons
  ```
- Line 40: loc
  ```
  local total = r(sum)
  ```
- Line 43: loc
  ```
  local tradeable = r(mean)   // only one row, so mean == value
  ```
- Line 49: house
  ```
  di "Share of tradeable household consumption"
  ```

**/replication-package/Brinatti_Morales_Replication_Package/liab_analysis/prog/10_epsilon_estimation.do**

- Line 4: city, lon
  ```
  * Epsilon estimation: within-firm elasticity of substitution (OLS and 2SLS)
  ```
- Line 6: lon
  ```
  * Source data: LIAB Longitudinal Model (version 1993-2014), IAB
  ```
- Line 8: city, lon
  ```
  /*	This dofile estimates epsilon, the within-firm elasticity of substitution
  ```
- Line 13: lon
  ```
  epsilon = 1 / (1 - beta_hat)
  ```
- Line 20: lon
  ```
  ${data}/epsilon_baseline_bootstrapsample.dta — 5,000 bootstrap dra
  ```
- Line 33: lon
  ```
  *This dofile estimates epsilon
  ```
- Line 47: lon
  ```
  use "${data}/dataset_epsilon_estimation.dta", clear
  ```
- Line 49: lon
  ```
  *Keep firms in sample of epsilon estimation
  ```
- Line 73: lon
  ```
  * Table C1: OLS and 2SLS estimates of epsilon
  ```
- Line 81: lon
  ```
  * Selection: epsilon sample (sample_epsilon == 1); 2008-2011,
  ```
- Line 85: lon
  ```
  * beta = (epsilon-1)/epsilon; implied epsilon reported via nlcom.
  ```
- Line 89: lon
  ```
  *Table C1: Estimates for epsilon
  ```
- Line 91: lon
  ```
  eststo OLS_bsl:     reghdfe   l_wbill_imm_nat l_emp_imm_eff_nat  if sample_epsilon==1, absorb(betnr 
  ```
- Line 94: lon
  ```
  ivreghdfe   l_wbill_imm_nat (l_emp_imm_eff_nat = iv_r_shift_sharew_o_f ) if sample_epsilon==1, absor
  ```
- Line 111: lon
  ```
  keep if  sample_epsilon==1
  ```
- Line 113: name
  ```
  rename betnr betnr2
  ```
- Line 117: loc
  ```
  local ntot=5000
  ```
- Line 134: lon
  ```
  qui reghdfe   l_wbill_imm_nat l_emp_imm_eff_nat  if sample_epsilon==1, absorb(betnr rt_fe kt_fe) clu
  ```
- Line 135: lon
  ```
  gen epsilon_ols = _b[l_emp_imm_eff_nat]
  ```
- Line 136: lon
  ```
  gen epsilon_1_ols   = 1 / (1-_b[l_emp_imm_eff_nat])
  ```
- Line 138: lon
  ```
  qui ivreghdfe   l_wbill_imm_nat (l_emp_imm_eff_nat = iv_r_shift_sharew_o_f ) if sample_epsilon==1, a
  ```
- Line 139: lon
  ```
  gen epsilon_2sls = _b[l_emp_imm_eff_nat]
  ```
- Line 140: lon
  ```
  gen epsilon_2_2sls   = 1 / (1-_b[l_emp_imm_eff_nat])
  ```
- Line 145: lon
  ```
  keep epsilon* nsample
  ```
- Line 172: lon
  ```
  _pctile epsilon_ols , nq(1000)
  ```
- Line 173: lon
  ```
  gen epsilon_ols_25 = r(r25)
  ```
- Line 174: lon
  ```
  _pctile epsilon_ols , nq(1000)
  ```
- Line 175: lon
  ```
  gen epsilon_ols_975 = r(r975)
  ```
- Line 178: lon
  ```
  _pctile epsilon_2sls , nq(1000)
  ```
- Line 179: lon
  ```
  gen epsilon_2sls_25 = r(r25)
  ```
- Line 180: lon
  ```
  _pctile epsilon_2sls , nq(1000)
  ```
- Line 181: lon
  ```
  gen epsilon_2sls_975 = r(r975)
  ```
- Line 185: lon
  ```
  *95% CI for epsilon
  ```
- Line 187: lon
  ```
  _pctile epsilon_1_ols , nq(1000)
  ```
- Line 188: lon
  ```
  gen epsilon_1_ols_25 = r(r25)
  ```
- Line 189: lon
  ```
  _pctile epsilon_1_ols , nq(1000)
  ```
- Line 190: lon
  ```
  gen epsilon_1_ols_975 = r(r975)
  ```
- Line 193: lon
  ```
  _pctile epsilon_2_2sls , nq(1000)
  ```
- Line 194: lon
  ```
  gen epsilon_2_2sls_25 = r(r25)
  ```
- Line 195: lon
  ```
  _pctile epsilon_2_2sls , nq(1000)
  ```
- Line 196: lon
  ```
  gen epsilon_2_2sls_975 = r(r975)
  ```
- Line 204: lon
  ```
  * Table C1: 99% bootstrap CIs for epsilon — OLS and 2S
  ```
- Line 207: lon
  ```
  * Variables: epsilon_ols_25 / epsilon_ols_975 (2.5 and 97.5 pctile of
  ```
- Line 208: lon
  ```
  *   OLS epsilon distribution across 5,000 bootstrap draws);
  ```
- Line 209: lon
  ```
  *   epsilon_2sls_25 / epsilon_2sls_975 (same for 2SLS)
  ```
- Line 212: lon
  ```
  *sum epsilon_ols_25 epsilon_ols_975 epsilon_2sls_25 epsilon_2sls_975
  ```
- Line 213: lon
  ```
  tabstat epsilon_ols_25 epsilon_ols_975 epsilon_2sls_25 epsilon_2sls_975 epsilon_1_ols_25 epsilon_1_o
  ```
- Line 219: lon
  ```
  save "${data}/epsilon_baseline_bootstrapsample.dta",replace
  ```

**/replication-package/Brinatti_Morales_Replication_Package/liab_analysis/prog/11_epsilon_pre_trend_test.do**

- Line 4: lon
  ```
  * Epsilon pre-trend test: lagged outcome regressions (Table C3)
  ```
- Line 6: lon
  ```
  * Source data: LIAB Longitudinal Model (version 1993-2014), IAB
  ```
- Line 17: lon
  ```
  ${data}/epsilon_pretrend_bootstrapsample.dta — 5,000 bootstrap dra
  ```
- Line 47: lon
  ```
  use "${data}/dataset_epsilon_estimation.dta", clear
  ```
- Line 50: lon
  ```
  *Keep firms in sample of epsilon estimation
  ```
- Line 87: lon
  ```
  * Selection: epsilon sample (sample_epsilon == 1)
  ```
- Line 93: lon
  ```
  ivreghdfe   l_wbill_imm_nat   ( l_emp_imm_eff_nat = iv_r_shift_sharew_o_f ) if sample_epsilon==1,  a
  ```
- Line 95: lon
  ```
  ivreghdfe   l_wbill_imm_natL1 ( l_emp_imm_eff_nat = iv_r_shift_sharew_o_f ) if sample_epsilon==1,  a
  ```
- Line 97: lon
  ```
  ivreghdfe   l_wbill_imm_natL2 ( l_emp_imm_eff_nat = iv_r_shift_sharew_o_f ) if sample_epsilon==1,  a
  ```
- Line 99: lon
  ```
  ivreghdfe   l_wbill_imm_natL3 ( l_emp_imm_eff_nat = iv_r_shift_sharew_o_f ) if sample_epsilon==1,  a
  ```
- Line 101: lon
  ```
  ivreghdfe   l_wbill_imm_natL4 ( l_emp_imm_eff_nat = iv_r_shift_sharew_o_f ) if sample_epsilon==1,  a
  ```
- Line 103: lon
  ```
  ivreghdfe   l_wbill_imm_natL5 ( l_emp_imm_eff_nat = iv_r_shift_sharew_o_f ) if sample_epsilon==1,  a
  ```
- Line 116: lon
  ```
  keep if  sample_epsilon==1
  ```
- Line 118: name
  ```
  rename betnr betnr2
  ```
- Line 122: loc
  ```
  local ntot=5000
  ```
- Line 137: loc
  ```
  local skip 0
  ```
- Line 139: lon
  ```
  cap qui ivreghdfe   l_wbill_imm_natL1 ( l_emp_imm_eff_nat = iv_r_shift_sharew_o_f ) if sample_epsilo
  ```
- Line 141: loc
  ```
  local skip 1
  ```
- Line 144: lon
  ```
  gen epsilon_RF1 = _b[l_emp_imm_eff_nat]
  ```
- Line 145: lon
  ```
  gen epsilon_1   = 1 / (1-_b[l_emp_imm_eff_nat])
  ```
- Line 148: lon
  ```
  cap qui ivreghdfe   l_wbill_imm_natL2 ( l_emp_imm_eff_nat = iv_r_shift_sharew_o_f ) if sample_epsilo
  ```
- Line 150: loc
  ```
  local skip 1
  ```
- Line 153: lon
  ```
  gen epsilon_RF2 = _b[l_emp_imm_eff_nat]
  ```
- Line 154: lon
  ```
  gen epsilon_2   = 1 / (1-_b[l_emp_imm_eff_nat])
  ```
- Line 157: lon
  ```
  cap qui ivreghdfe   l_wbill_imm_natL3 ( l_emp_imm_eff_nat = iv_r_shift_sharew_o_f ) if sample_epsilo
  ```
- Line 159: loc
  ```
  local skip 1
  ```
- Line 162: lon
  ```
  gen epsilon_RF3 = _b[l_emp_imm_eff_nat]
  ```
- Line 163: lon
  ```
  gen epsilon_3   = 1 / (1-_b[l_emp_imm_eff_nat])
  ```
- Line 166: lon
  ```
  cap qui ivreghdfe   l_wbill_imm_natL4 ( l_emp_imm_eff_nat = iv_r_shift_sharew_o_f ) if sample_epsilo
  ```
- Line 168: loc
  ```
  local skip 1
  ```
- Line 171: lon
  ```
  gen epsilon_RF4 = _b[l_emp_imm_eff_nat]
  ```
- Line 172: lon
  ```
  gen epsilon_4   = 1 / (1-_b[l_emp_imm_eff_nat])
  ```
- Line 175: lon
  ```
  cap qui ivreghdfe   l_wbill_imm_natL5 ( l_emp_imm_eff_nat = iv_r_shift_sharew_o_f ) if sample_epsilo
  ```
- Line 177: loc
  ```
  local skip 1
  ```
- Line 180: lon
  ```
  gen epsilon_RF5 = _b[l_emp_imm_eff_nat]
  ```
- Line 181: lon
  ```
  gen epsilon_5   = 1 / (1-_b[l_emp_imm_eff_nat])
  ```
- Line 187: lon
  ```
  keep epsilon* nsample
  ```
- Line 200: loc
  ```
  local first_saved 1
  ```
- Line 206: loc
  ```
  local first_saved 0
  ```
- Line 218: lon
  ```
  _pctile epsilon_RF1 , nq(1000)
  ```
- Line 219: lon
  ```
  gen epsilon_RF1_25 = r(r25)
  ```
- Line 220: lon
  ```
  _pctile epsilon_RF1 , nq(1000)
  ```
- Line 221: lon
  ```
  gen epsilon_RF1_975 = r(r975)
  ```
- Line 224: lon
  ```
  _pctile epsilon_RF2 , nq(1000)
  ```
- Line 225: lon
  ```
  gen epsilon_RF2_25 = r(r25)
  ```
- Line 226: lon
  ```
  _pctile epsilon_RF2 , nq(1000)
  ```
- Line 227: lon
  ```
  gen epsilon_RF2_975 = r(r975)
  ```
- Line 229: lon
  ```
  _pctile epsilon_RF3 , nq(1000)
  ```
- Line 230: lon
  ```
  gen epsilon_RF3_25 = r(r25)
  ```
- Line 231: lon
  ```
  _pctile epsilon_RF3 , nq(1000)
  ```
- Line 232: lon
  ```
  gen epsilon_RF3_975 = r(r975)
  ```
- Line 234: lon
  ```
  _pctile epsilon_RF4 , nq(1000)
  ```
- Line 235: lon
  ```
  gen epsilon_RF4_25 = r(r25)
  ```
- Line 236: lon
  ```
  _pctile epsilon_RF4 , nq(1000)
  ```
- Line 237: lon
  ```
  gen epsilon_RF4_975 = r(r975)
  ```
- Line 240: lon
  ```
  _pctile epsilon_RF5 , nq(1000)
  ```
- Line 241: lon
  ```
  gen epsilon_RF5_25 = r(r25)
  ```
- Line 242: lon
  ```
  _pctile epsilon_RF5 , nq(1000)
  ```
- Line 243: lon
  ```
  gen epsilon_RF5_975 = r(r975)
  ```
- Line 253: lon
  ```
  * Variables: epsilon_RF1_25 / epsilon_RF1_975 through epsilon_RF5_25 / epsilon_RF5_975
  ```
- Line 259: lon
  ```
  tabstat epsilon_RF1_25 epsilon_RF1_975 epsilon_RF2_25 epsilon_RF2_975 epsilon_RF3_25 epsilon_RF3_975
  ```
- Line 266: lon
  ```
  save "${data}/epsilon_pretrend_bootstrapsample.dta",replace
  ```

**/replication-package/Brinatti_Morales_Replication_Package/liab_analysis/prog/12_epsilon_firm_characteristics.do**

- Line 4: lon
  ```
  * Epsilon robustness: controlling for firm characteristics x year (Table C5)
  ```
- Line 6: lon
  ```
  * Source data: LIAB Longitudinal Model (version 1993-2014), IAB
  ```
- Line 8: lon
  ```
  /*	This dofile tests the robustness of the epsilon estimate to controlling
  ```
- Line 12: lon
  ```
  Table 1 - Table C5: Robustness of epsilon to firm characteristics
  ```
- Line 15: block, loc
  ```
  The commented-out block above the active regressions is an earlier
  ```
- Line 17: block, loc
  ```
  not used in the paper. Only the active estout block is for submission.
  ```
- Line 37: lon
  ```
  use "${data}/dataset_epsilon_estimation.dta", clear
  ```
- Line 39: lon
  ```
  *Keep firms in sample of epsilon estimation
  ```
- Line 63: lon
  ```
  * Table C5: Robustness of epsilon — firm characteristics x ye
  ```
- Line 70: lon
  ```
  * Selection: epsilon sample (sample_epsilon==1)
  ```
- Line 71: lon
  ```
  * Implied epsilon reported via nlcom for each column.
  ```
- Line 74: lon
  ```
  ****Table C5: Robustness of epsilon when controlling for covariates
  ```
- Line 76: lon
  ```
  ivreghdfe   l_wbill_imm_nat (l_emp_imm_eff_nat = iv_r_shift_sharew_o_f ) if sample_epsilon==1,  abso
  ```
- Line 80: lon
  ```
  ivreghdfe   l_wbill_imm_nat (l_emp_imm_eff_nat = iv_r_shift_sharew_o_f )  if sample_epsilon==1,  abs
  ```
- Line 84: lon
  ```
  ivreghdfe   l_wbill_imm_nat (l_emp_imm_eff_nat = iv_r_shift_sharew_o_f )  if sample_epsilon==1,  abs
  ```
- Line 88: lon
  ```
  ivreghdfe   l_wbill_imm_nat (l_emp_imm_eff_nat = iv_r_shift_sharew_o_f ) if sample_epsilon==1,  abso
  ```
- Line 92: lon
  ```
  ivreghdfe   l_wbill_imm_nat (l_emp_imm_eff_nat = iv_r_shift_sharew_o_f )  if sample_epsilon==1,  abs
  ```

**/replication-package/Brinatti_Morales_Replication_Package/liab_analysis/prog/13_estimate_epsilon_sigma.do**

- Line 4: lon
  ```
  * Epsilon vs. sigma: bootstrap distribution and p-value (Section 5.3)
  ```
- Line 6: lon
  ```
  * Source data: LIAB Longitudinal Model (version 1993-2014), IAB
  ```
- Line 8: lon
  ```
  /*	This dofile computes the joint bootstrap distribution of epsilon and
  ```
- Line 9: lon
  ```
  sigma and tests H0: epsilon < sigma (Section 5.3 of the paper).
  ```
- Line 14: lon
  ```
  Table 1 - Section 5.3: Point estimates of epsilon, sigma_d, sigma_x,
  ```
- Line 18: lon
  ```
  ${data}/epsilon_sigma_bootstrapsample.dta — 5,000 bootstrap dra
  ```
- Line 36: lon
  ```
  *This dofile perform the statistical test of wether epsilon> sigma, and bootstrap the standard error
  ```
- Line 52: lon
  ```
  use "${data}/dataset_epsilon_estimation.dta", clear
  ```
- Line 87: name
  ```
  rename nemp_ft emp_tot_tot
  ```
- Line 98: lon
  ```
  * Distribution of epsilon, sigma and the difference
  ```
- Line 101: lon
  ```
  keep if  sample_epsilon==1
  ```
- Line 103: name
  ```
  rename betnr betnr2
  ```
- Line 107: loc
  ```
  local ntot=5000
  ```
- Line 110: lon
  ```
  *Estimate of epsilon /*0.*/
  ```
- Line 111: lon
  ```
  qui ivreghdfe l_wbill_imm_nat ( l_emp_imm_eff_nat = iv_r_shift_sharew_o_f)   if sample_epsilon==1, a
  ```
- Line 112: lon
  ```
  gen epsilon    =  1/(1-_b[l_emp_imm_eff_nat])
  ```
- Line 116: lon
  ```
  qui ivreghdfe   markup1 if sample_epsilon==1  /**/
  ```
- Line 120: lon
  ```
  qui ivreghdfe  markup1 		if sample_epsilon==1 & tradeable3==0
  ```
- Line 126: lon
  ```
  qui ivreghdfe  markdown1 if sample_epsilon==1 & (exports_foreign==0 | missing(exports_foreign)) &  t
  ```
- Line 129: lon
  ```
  qui ivreghdfe  markdown1 if sample_epsilon==1 & (exports_foreign>0 & exports_foreign!=.) &  tradeabl
  ```
- Line 135: lon
  ```
  qui ivreghdfe exports_foreign if sample_epsilon==1 & (exports_foreign>0 & exports_foreign!=.) & trad
  ```
- Line 152: lon
  ```
  * Section 5.1: Point estimates of epsilon, sigma components
  ```
- Line 155: lon
  ```
  * Variables: epsilon (2SLS), sigma (all firms), markup1_d (NT markup),
  ```
- Line 159: lon
  ```
  * Selection: epsilon sample (sample_epsilon==1); survey-weighted means
  ```
- Line 164: lon
  ```
  sum  epsilon sigma markup1_d sigma_d markdown1_d markdown1_e export_share markdown1_x sigma_x sigma_
  ```
- Line 165: lon
  ```
  drop epsilon sigma markup1_d sigma_d markdown1_d markdown1_e export_share markdown1_x sigma_x sigma_
  ```
- Line 169: lon
  ```
  * Distribution of epsilon, sigma and the difference
  ```
- Line 188: lon
  ```
  qui ivreghdfe   l_wbill_imm_nat  l_emp_imm_eff_nat  if sample_epsilon==1, absorb(betnr rt_fe kt_fe)
  ```
- Line 189: lon
  ```
  gen epsilon_RF_OLS = _b[l_emp_imm_eff_nat]
  ```
- Line 190: lon
  ```
  gen epsilon_OLS    = 1/(1-_b[l_emp_imm_eff_nat])
  ```
- Line 193: lon
  ```
  * Estimate of epsilon
  ```
- Line 195: lon
  ```
  qui ivreghdfe   l_wbill_imm_nat ( l_emp_imm_eff_nat = iv_r_shift_sharew_o_f) if sample_epsilon==1, a
  ```
- Line 196: lon
  ```
  gen epsilon_RF = _b[l_emp_imm_eff_nat]
  ```
- Line 197: lon
  ```
  gen epsilon    = 1/(1-_b[l_emp_imm_eff_nat])
  ```
- Line 202: lon
  ```
  qui ivreghdfe   markup1 if sample_epsilon==1
  ```
- Line 207: lon
  ```
  qui ivreghdfe  markup1 if sample_epsilon==1 & tradeable3==0
  ```
- Line 213: lon
  ```
  qui ivreghdfe  markdown1 if sample_epsilon==1 & (exports_foreign==0 | missing(exports_foreign)) &  t
  ```
- Line 216: lon
  ```
  qui ivreghdfe  markdown1 if sample_epsilon==1 & (exports_foreign>0 & exports_foreign!=.) &  tradeabl
  ```
- Line 222: lon
  ```
  qui ivreghdfe exports_foreign	if sample_epsilon==1 & (exports_foreign>0 & exports_foreign!=.) & trad
  ```
- Line 238: lon
  ```
  gen diff 	= epsilon - sigma
  ```
- Line 239: lon
  ```
  gen diff_d 	= epsilon - sigma_d
  ```
- Line 240: lon
  ```
  gen diff_avg= epsilon - sigma_avg
  ```
- Line 244: lon
  ```
  keep epsilon epsilon_RF sigma sigma_d sigma_x sigma_avg diff* nsample diff diff_d diff_avg epsilon_R
  ```
- Line 265: lon
  ```
  save "${data}/epsilon_sigma_bootstrapsample.dta",replace
  ```

**/replication-package/Brinatti_Morales_Replication_Package/liab_analysis/prog/14_epsilon_sigma_histogram.do**

- Line 4: lon
  ```
  * Epsilon-sigma histogram and p-values cited in Section 5.3
  ```
- Line 6: lon
  ```
  * Source data: LIAB Longitudinal Model (version 1993-2014), IAB
  ```
- Line 8: lon
  ```
  /*	This dofile produces confidence intervals, the p-value for H0: epsilon < sigma,
  ```
- Line 12: lon
  ```
  Table 1  - Table C1 (supplement): 95% and 99% CIs for epsilon
  ```
- Line 13: lon
  ```
  Table 2  - Section 5.3: p-value for H0: epsilon < sigma
  ```
- Line 14: lon
  ```
  Graph 1  - Figure C1: Distribution of epsilon - sigma (trimmed)
  ```
- Line 22: block, loc
  ```
  Note on commented-out code: The block inside /* */ below the active
  ```
- Line 46: lon
  ```
  use "${data}/epsilon_sigma_bootstrapsample.dta",clear
  ```
- Line 56: lon
  ```
  * Section 5.3: p-value for H0: epsilon < sigma
  ```
- Line 59: lon
  ```
  * Variables: epsilon (2SLS implied epsilon per bootstrap draw),
  ```
- Line 63: lon
  ```
  * p-value = fraction of draws where epsilon < sigma
  ```
- Line 70: lon
  ```
  count if epsilon>sigma /**/
  ```
- Line 71: lon
  ```
  count if epsilon>sigma_d /**/
  ```
- Line 72: lon
  ```
  count if epsilon>sigma_avg  /**/
  ```
- Line 92: lon
  ```
  * Figure C1: Distribution of (epsilon - sigma), trimmed
  ```
- Line 95: lon
  ```
  * Variables: diff_trim_0_975 (= epsilon - sigma; negative values replaced
  ```
- Line 101: lon
  ```
  *** Figure C1: Distribution of epsilon - sigma
  ```
- Line 108: lon
  ```
  graph export "${log}/14_epsilon_sigma_histogram_01_hist.png", replace
  ```
- Line 111: lat, lon
  ```
  * The histogram is computed by running 5000 bootstrap simulations (in dofile 13_estimate_epsilon_sig
  ```
- Line 112: lat
  ```
  * The relevant count is not the 5000 nor how many observations are in each bar, but the underlying o
  ```
- Line 116: lat
  ```
  di "Figure C1 — observations used in each of the 5000 bootstrap simulation
  ```

**/replication-package/Brinatti_Morales_Replication_Package/liab_analysis/prog/15_epsilon_shift_share.do**

- Line 6: lon
  ```
  * Source data: LIAB Longitudinal Model (version 1993-2014), IAB
  ```
- Line 10: country
  ```
  by regressing initial country shares on firm characteristics.
  ```
- Line 15: country
  ```
  Table 2 - Table C2: Rottemberg-weight diagnostics by origin country
  ```
- Line 17: block, loc
  ```
  FDZ note: The first preserve/restore block (Table 1) outputs estout with
  ```
- Line 19: lat
  ```
  the number of groups and correlations. Cell counts >= 20 by construction
  ```
- Line 23: country
  ```
  the reshape produces per-country regressions not in the paper. It is
  ```
- Line 51: name
  ```
  rename nation_single nation
  ```
- Line 53: name
  ```
  rename sharew_03_of share
  ```
- Line 88: lon
  ```
  * Sample of epsilon regression
  ```
- Line 91: lon
  ```
  use "${data}/dataset_epsilon_estimation.dta", clear
  ```
- Line 93: lon
  ```
  *Keep firms in sample of epsilon estimation
  ```
- Line 112: lon
  ```
  quietly ivreghdfe   l_wbill_imm_nat (l_emp_imm_eff_nat = iv_r_shift_sharew_o_f ) if sample_epsilon==
  ```
- Line 113: loc
  ```
  local n_obs=e(N)
  ```
- Line 120: country
  ```
  *Bring the data on country shares and shifts for the firms in the sample
  ```
- Line 127: lat
  ```
  * Correlation of shares with firm characteristics
  ```
- Line 147: country, lon
  ```
  reshape long share, i(betnr) j(country)
  ```
- Line 150: country
  ```
  quietly reg share i.country
  ```
- Line 156: lat
  ```
  * Table C4: Correlation between firm initial shares and characteristics
  ```
- Line 160: country
  ```
  * The level of the observations is establishment - country of origin (9 regions)
  ```
- Line 188: country
  ```
  gen country_id=_n
  ```
- Line 204: country
  ```
  tabstat beta1 alpha1 gamma1 pi1 G1, by(country_id) stat(mean) nototal
  ```

**/replication-package/Brinatti_Morales_Replication_Package/liab_analysis/prog/16_estimate_nu.do**

- Line 6: lon
  ```
  * Source data: LIAB Longitudinal Model (version 1993-2014), IAB
  ```
- Line 25: district, gender
  ```
  * Specification c:   industry x year + district FEs + age + gender controls
  ```
- Line 26: gender
  ```
  * Specification cov: fully saturated (nationality x industry x age x gender
  ```
- Line 27: district
  ```
  *                    x district x year FEs)
  ```
- Line 68: name
  ```
  rename tentgelt_orig tentgelt
  ```
- Line 72: loc, location
  ```
  * Merge industry / location identifiers
  ```
- Line 78: loc
  ```
  * Reduced local labour markets
  ```
- Line 109: name
  ```
  rename ind_2dig_aux ind_2dig
  ```
- Line 114: loc
  ```
  egen ind_labormkt = group(ind_2dig local_labor11)
  ```
- Line 129: loc
  ```
  bysort local_labor11 jahr: egen wemp_rt     = sum(tentgelt)
  ```
- Line 130: loc
  ```
  bysort local_labor11 jahr: egen wemp_nat_rt = sum((nation_single == 1) * tentgelt)
  ```
- Line 132: loc
  ```
  gen share_mig_local2_t = (wemp_rt - wemp_nat_rt) / wemp_rt
  ```
- Line 143: loc
  ```
  gen interaction = share_mig_local2_t * logemp_tot_totlag
  ```
- Line 206: loc
  ```
  gen relocated  = .
  ```
- Line 375: name
  ```
  rename count_missrev2 count_missrev
  ```
- Line 381: loc
  ```
  keepusing(instrument3n_local)
  ```
- Line 384: loc
  ```
  drop if missing(tradeable3) | missing(ind_2dig) | missing(local_labor11)
  ```
- Line 393: loc
  ```
  (share_mig_local2_t interaction = instrument3n_local c.instrument3n_local#c.logemp_tot_firm03) ///
  ```
- Line 396: loc
  ```
  cl(betnr) absorb(ind_med_time betnr i.local_labor11#c.jahr)
  ```
- Line 419: loc, location
  ```
  * Industry / location identifiers
  ```
- Line 453: loc
  ```
  local coeff = (r(sd))^2 / (r(mean))^2
  ```

**/replication-package/Brinatti_Morales_Replication_Package/liab_analysis/prog/17_empirical_facts.do**

- Line 6: lon
  ```
  * Source data: LIAB Longitudinal Model (version 1993-2014), IAB
  ```
- Line 76: name
  ```
  rename emp_tot_experience10 emp_tot_exp10
  ```
- Line 104: loc
  ```
  egen local_labor_time = group(local_labor11 jahr)
  ```
- Line 105: loc
  ```
  quietly reghdfe mig_share, absorb(industry_time local_labor_time) resid
  ```
- Line 106: loc
  ```
  predict mig_share_noindloc, r
  ```
- Line 113: loc
  ```
  gen mig_share_exp_nind  = mig_share_noindloc if exports_foreign > 0 & exports_foreign != .
  ```
- Line 114: loc
  ```
  gen mig_share_nexp_nind = mig_share_noindloc if exports_foreign == 0
  ```
- Line 139: loc
  ```
  local lo = (`g' - 1) / 100
  ```
- Line 140: loc
  ```
  local hi = `g'       / 100
  ```
- Line 266: loc
  ```
  *   FE: industry x year (industry_time), LLM x year (local_labor_time);
  ```
- Line 272: loc
  ```
  absorb(industry_time local_labor_time) cluster(betnr)
  ```
- Line 274: loc
  ```
  absorb(industry_time local_labor_time) cluster(betnr)
  ```
- Line 282: loc
  ```
  collapse (median) mig_share         mig_share_noindloc                   ///
  ```
- Line 313: loc
  ```
  collapse (count) N_main        = mig_share           N_noindloc   = mig_share_noindloc ///
  ```
- Line 373: name
  ```
  rename decile_wbill_coll decile_wbill
  ```
- Line 394: name
  ```
  rename decile_wbill_ncoll decile_wbill
  ```
- Line 408: loc
  ```
  mig_share         mig_share_noindloc                                    ///
  ```
- Line 429: loc
  ```
  local ntot = 200
  ```
- Line 436: loc
  ```
  collapse (median) mig_share         mig_share_noindloc                   ///
  ```
- Line 459: loc
  ```
  sd_noindloc          = mig_share_noindloc                      ///
  ```
- Line 509: name
  ```
  rename decile_wbill_coll decile_wbill
  ```
- Line 542: name
  ```
  rename decile_wbill_ncoll decile_wbill
  ```
- Line 558: loc
  ```
  gen ci_lo_noindloc      = mig_share_noindloc  - 1.96 * sd_noindloc
  ```
- Line 559: loc
  ```
  gen ci_hi_noindloc      = mig_share_noindloc  + 1.96 * sd_noindloc
  ```
- Line 600: name
  ```
  rename decile_wbill_coll decile_wbill
  ```
- Line 611: name
  ```
  rename decile_wbill_ncoll decile_wbill
  ```
- Line 658: loc
  ```
  * Variables: mig_share (raw median), mig_share_noindloc (residualised
  ```
- Line 660: loc
  ```
  *   ci_lo_noindloc / ci_hi_noindloc (95% bootstrap CI bounds),
  ```
- Line 661: loc
  ```
  *   N_main / N_noindloc (unweighted N per bin for each series),
  ```
- Line 666: loc
  ```
  * mig_share_noindloc is a residual of mig_share; same underlying variables
  ```
- Line 668: loc
  ```
  tabdisp decile_wbill, c(N_main N_noindloc) concise
  ```
- Line 669: loc
  ```
  tabdisp decile_wbill, c(mig_share mig_share_noindloc ci_lo_noindloc ci_hi_noindloc) concise
  ```
- Line 775: lon
  ```
  * NOTE: hire_immigrant is a dummy variable. N_hire is reported alongside
  ```

**/replication-package/Brinatti_Morales_Replication_Package/liab_analysis/prog/18_immigrant_comparative_advantage.do**

- Line 6: lon
  ```
  * Source data: LIAB Longitudinal Model (version 1993-2014), IAB
  ```
- Line 12: lat
  ```
  Table 1  - Table A6, Panel A: Relative occupational sorting by origin
  ```
- Line 13: lat
  ```
  Table 2  - Table A6, Panel B: Relative demographic characteristics
  ```
- Line 35: lat
  ```
  - Table A6  : Relative occupational sorting and demographics by origin
  ```
- Line 36: lat
  ```
  (Panel A: tabulations
  ```
- Line 66: lat
  ```
  * Restrict to working-age population and sample period (2003–201
  ```
- Line 94: lat
  ```
  TABLE A6 — Relative occupational sorting and demographics by orig
  ```
- Line 164: lat
  ```
  PANEL A: Relative occupational sorting
  ```
- Line 185: loc
  ```
  levelsof occ_bl, local(occs)
  ```
- Line 187: loc
  ```
  foreach o of local occs {
  ```
- Line 193: lat
  ```
  * Relative shares
  ```
- Line 253: lat
  ```
  * Table A6, Panel A: Relative occupational sorting by origin group
  ```
- Line 261: lat
  ```
  * Ratios > 1 indicate over-representation relative to Germans.
  ```
- Line 292: lat
  ```
  * Relative shares (n_nation_occ/n_nation, normed to German baseline)
  ```
- Line 293: lat
  ```
  di "--- Relative occupational shares (rel_share_nation = share_n / share_german) ---"
  ```
- Line 302: lat
  ```
  PANEL B: Relative demographic characteristics
  ```
- Line 318: lat
  ```
  * FDZ: store German baseline counts before dropping (denominators for all relative chars)
  ```
- Line 340: lat
  ```
  * Table A6, Panel B: Relative demographic characteristics by origin group
  ```
- Line 388: lat
  ```
  * FDZ: German baseline raw counts (denominator for all relative characteristics)
  ```
- Line 395: lat
  ```
  * FDZ: immigrant group raw counts (numerator/denominator of each relative share)
  ```
- Line 471: gender
  ```
  * Controls: age, gender (frau), college education
  ```
- Line 517: gender
  ```
  * FE: establishment x year, gender x year, college x year
  ```
- Line 543: country
  ```
  One dot per origin-country group (nations 2–10, i.e. non-German
  ```
- Line 568: name
  ```
  * In the coefficient vector the names are "2.nation_single" ... "10.nation_single"
  ```
- Line 579: loc
  ```
  local i = `n' - 1               // row index in our dataset
  ```
- Line 580: loc
  ```
  local coln "`n'.nation_single"
  ```
- Line 610: loc
  ```
  local coln "`n'.nation_single#c.man_lang"
  ```
- Line 653: lat
  ```
  *   manual/language ratio within establishment-year, relative to Germans);
  ```
- Line 655: lat
  ```
  *   occupations relative to Germans); sorting_lo/hi and wage_lo/hi
  ```
- Line 658: lat
  ```
  * A positive correlation between sorting_fe and wage_beta is consistent
  ```
- Line 664: name
  ```
  noobs sep(0) abbrev(20) subvarname divider
  ```

**/replication-package/Brinatti_Morales_Replication_Package/liab_analysis/prog/19_moments_calculation.do**

- Line 4: city
  ```
  * SMM calibration moments and demand elasticity sigma
  ```
- Line 6: lon
  ```
  * Source data: LIAB Longitudinal Model (version 1993-2014), IAB
  ```
- Line 9: city
  ```
  (Table 1 / Table C7) and the demand elasticity sigma used in Section 5.1.
  ```
- Line 33: city
  ```
  This dofile creates compute moments to be used for calibration, including the elasticity of substitu
  ```
- Line 81: lon
  ```
  * 	Estimation of sigma and sigma_x as done for the test of epsilon>sigma
  ```
- Line 102: block, loc
  ```
  *   estimates reported via sum after each block.
  ```
- Line 152: lon
  ```
  * Selection: epsilon sample; survey-weighted means
  ```
- Line 153: lat
  ```
  * These support the sigma_d and sigma_x calculations in Table 1 above.
  ```
- Line 173: loc
  ```
  quietly reg logrevenues l_share_mig_firm2_t trade i.jahr i.local_labor11#c.jahr if tradeable3==1 & e
  ```
- Line 176: loc
  ```
  quietly reg logrevenues l_share_mig_firm2_t  trade i.jahr i.local_labor11#c.jahr if tradeable3==0 & 
  ```
- Line 186: loc
  ```
  *   l_share_mig_firm2_t, trade, year FE, local-labor-market x year FE)
  ```
- Line 226: lat
  ```
  *FDZ: bysort + sum [fw=] gives weighted sums for aggregate share calculation
  ```

**/replication-package/Brinatti_Morales_Replication_Package/liab_analysis/prog/1_cleaning_data.do**

- Line 6: lon
  ```
  * Source data: LIAB Longitudinal Model (version 1993-2014), IAB
  ```
- Line 51: lat
  ```
  ***********************Removing duplicate observations and calculating total income per worker-estab
  ```
- Line 111: lat
  ```
  *Calculate adjusted daily wage
  ```
- Line 119: birth
  ```
  occupation (occ), education (ausbildung), birthdate (gebjahr), citizenship or employment type (part-
  ```
- Line 157: birth, country, social
  ```
  IMPORTANT: What is recorded in social security is citizenship, not country of birth. Also it is repo
  ```
- Line 164: birth, country
  ```
  We want a consistent definition of immigrants that represents something closer to country of birth i
  ```
- Line 173: lat
  ```
  *Calculate tenure at firm
  ```
- Line 222: lon
  ```
  *Some cases remaining where we just count them as german as long as they report german for at least 
  ```
- Line 269: district
  ```
  *Merge number of employees (az_ges), 3-digit industry (w93_3_gen), district (ao_kreis), grd_jahr (fi
  ```
- Line 296: lat
  ```
  *First, calculate aggregates at the regional level by nationality and occupation group.
  ```

**/replication-package/Brinatti_Morales_Replication_Package/liab_analysis/prog/2_local_labor_markets.do**

- Line 4: district, loc
  ```
  * Crosswalk between district (Kreis) and local labour market
  ```
- Line 6: loc
  ```
  * Source data: Local labour market concordance, IAB (Kropp & Schwengler 2011)
  ```
- Line 8: district
  ```
  /*	This dofile prepares the crosswalk between Kreis (district) codes and
  ```
- Line 9: loc
  ```
  functional local labour market regions (Kropp & Schwengler 2011).
  ```
- Line 17: loc
  ```
  ${orig}/local labor markets.dta   — raw concordance fi
  ```
- Line 33: loc
  ```
  use "${orig}/local labor markets.dta", clear
  ```
- Line 35: loc
  ```
  keep ao_kreis11 local_labor11
  ```

**/replication-package/Brinatti_Morales_Replication_Package/liab_analysis/prog/4_dataset_firm_level.do**

- Line 6: lon
  ```
  * Source data: LIAB Longitudinal Model (version 1993-2014), IAB
  ```
- Line 16: lat
  ```
  and deflates monetary variables to real 2010 euros
  ```
- Line 22: lat
  ```
  ${orig}/cpigermany.dta                  — CPI deflat
  ```
- Line 74: lat
  ```
  gen ind2dig=ind_2dig /* because later calls may refer to this variable. Clean in the 2nd round*/
  ```
- Line 84: name
  ```
  rename ind_2dig_aux ind_2dig
  ```
- Line 87: loc
  ```
  *create reduced local labor markets
  ```
- Line 99: loc
  ```
  egen ind_labormkt 	= group(ind_2dig local_labor11)
  ```
- Line 100: loc
  ```
  egen rt_fe 		 	= group(local_labor11 jahr)
  ```
- Line 113: loc
  ```
  bysort jahr local_labor11: egen loclabor_`x'_`y'=sum(tot_earn1*`x'*`y')
  ```
- Line 117: loc
  ```
  bysort jahr local_labor11: egen nloclabor_`x'_`y'=sum(main_obs*`x'*`y')
  ```
- Line 169: loc
  ```
  gen relocated=.
  ```
- Line 200: loc
  ```
  replace relocated=1 if (t02a==1 | t02b==1 | t02c==1) & jahr==2011
  ```
- Line 201: loc
  ```
  replace relocated=0 if (t02d==1) & jahr==2011
  ```
- Line 244: loc
  ```
  replace relocated=1 if (s02a==1 | s02b==1 | s02c==1) & jahr==2010
  ```
- Line 245: loc
  ```
  replace relocated=0 if (s02d==1) & jahr==2010
  ```
- Line 288: loc
  ```
  replace relocated=1 if (r02a==1 | r02b==1 | r02c==1 | r02d==1 | r02e==1) & jahr==2009
  ```
- Line 289: loc
  ```
  replace relocated=0 if (r02f==1) & jahr==2009
  ```
- Line 332: loc
  ```
  replace relocated=1 if (q02a==1 | q02b==1 | q02c==1) & jahr==2008
  ```
- Line 333: loc
  ```
  replace relocated=0 if (q02a==0 & q02b==0 & q02c==0) & jahr==2008
  ```
- Line 372: loc
  ```
  replace relocated=1 if (p02a==1 | p02b==1 | p02c==1) & jahr==2007
  ```
- Line 373: loc
  ```
  replace relocated=0 if (p02a==0 & p02b==0 & p02c==0) & jahr==2007
  ```
- Line 411: loc
  ```
  replace relocated=1 if (o02a==1 | o02b==1 | o02c==1 | o02d==1 | o02e==1) & jahr==2006
  ```
- Line 412: loc
  ```
  replace relocated=0 if (o02a==0 & o02b==0 & o02c==0 & o02d==0 & o02e==0) & jahr==2006
  ```
- Line 449: loc
  ```
  replace relocated=1 if (n02aa==1 | n02ab==1 | n02ac==1) & jahr==2005
  ```
- Line 450: loc
  ```
  replace relocated=0 if (n02aa==0 & n02ab==0 & n02ac==0) & jahr==2005
  ```
- Line 491: loc
  ```
  replace relocated=1 if (m02aa==1 | m02ab==1 | m02ac==1) & jahr==2004
  ```
- Line 492: loc
  ```
  replace relocated=0 if (m02aa==0 & m02ab==0 & m02ac==0) & jahr==2004
  ```
- Line 532: loc
  ```
  replace relocated=1 if (l02a==1 | l02b==1 | l02c==1) & jahr==2003
  ```
- Line 533: loc
  ```
  replace relocated=0 if (l02a==0 & l02b==0 & l02c==0) & jahr==2003
  ```
- Line 599: lat
  ```
  * Deflate wagebill - turnover
  ```
- Line 606: lat
  ```
  replace `x'=`x'*deflator
  ```

**/replication-package/Brinatti_Morales_Replication_Package/liab_analysis/prog/5_dataset_for_instrument_validation.do**

- Line 6: lon
  ```
  * Source data: LIAB Longitudinal Model (version 1993-2014), IAB
  ```
- Line 74: country
  ```
  ****Assign consistent immigration country****
  ```
- Line 97: lat
  ```
  *Calculate tenure at firm
  ```
- Line 108: name
  ```
  rename college1 college
  ```
- Line 152: lon
  ```
  *Some cases remaining where we just count them as german as long as they report german for at least 
  ```
- Line 193: name
  ```
  rename tentgelt_orig tentgelt
  ```
- Line 201: loc
  ```
  *create reduced local labor markets
  ```
- Line 233: loc
  ```
  bysort jahr local_labor11: egen loclabor_`x'_`y'=sum(tentgelt*`x'*`y')
  ```
- Line 234: loc
  ```
  bysort jahr local_labor11: egen nloclabor_`x'_`y'=sum(1*`x'*`y')
  ```
- Line 245: loc
  ```
  *Instrument3: local labor market level
  ```
- Line 247: loc
  ```
  gen share_mig1_local2=(loclabor_eu_orig1_tot)/(loclabor_tot_tot) if jahr==2003
  ```
- Line 248: loc
  ```
  bysort local_labor11: egen share_mig1_local203=mean(share_mig1_local2)
  ```
- Line 250: loc
  ```
  gen share_mig2_local2=(loclabor_eu_orig2_tot)/(loclabor_tot_tot) if jahr==2003
  ```
- Line 251: loc
  ```
  bysort local_labor11: egen share_mig2_local203=mean(share_mig2_local2)
  ```
- Line 253: loc
  ```
  gen share_mig3_local2=(loclabor_eu_2000_tot)/(loclabor_tot_tot) if jahr==2003
  ```
- Line 254: loc
  ```
  bysort local_labor11: egen share_mig3_local203=mean(share_mig3_local2)
  ```
- Line 256: loc
  ```
  gen share_mig4_local2=(loclabor_turkey_tot)/(loclabor_tot_tot) if jahr==2003
  ```
- Line 257: loc
  ```
  bysort local_labor11: egen share_mig4_local203=mean(share_mig4_local2)
  ```
- Line 259: loc
  ```
  gen share_mig5_local2=(loclabor_yugoslavia_tot)/(loclabor_tot_tot) if jahr==2003
  ```
- Line 260: loc
  ```
  bysort local_labor11: egen share_mig5_local203=mean(share_mig5_local2)
  ```
- Line 262: loc
  ```
  gen share_mig6_local2=(loclabor_europe_other_tot)/(loclabor_tot_tot) if jahr==2003
  ```
- Line 263: loc
  ```
  bysort local_labor11: egen share_mig6_local203=mean(share_mig6_local2)
  ```
- Line 265: loc
  ```
  gen share_mig7_local2=(loclabor_asia_tot)/(loclabor_tot_tot) if jahr==2003
  ```
- Line 266: loc
  ```
  bysort local_labor11: egen share_mig7_local203=mean(share_mig7_local2)
  ```
- Line 268: loc
  ```
  gen share_mig8_local2=(loclabor_africa_me_tot)/(loclabor_tot_tot) if jahr==2003
  ```
- Line 269: loc
  ```
  bysort local_labor11: egen share_mig8_local203=mean(share_mig8_local2)
  ```
- Line 271: loc
  ```
  gen share_mig9_local2=(loclabor_americas_tot)/(loclabor_tot_tot) if jahr==2003
  ```
- Line 272: loc
  ```
  bysort local_labor11: egen share_mig9_local203=mean(share_mig9_local2)
  ```
- Line 281: loc
  ```
  gen instrument3_local=(share_mig1_local203*year_eu_orig1_tot/year_eu_orig1_tot03 +  ///
  ```
- Line 282: loc
  ```
  share_mig2_local203*year_eu_orig2_tot/year_eu_orig2_tot03         + share_mig3_local203*year_eu_2000
  ```
- Line 283: loc
  ```
  share_mig4_local203*year_turkey_tot/year_turkey_tot03             + share_mig5_local203*year_yugosla
  ```
- Line 284: loc
  ```
  share_mig6_local203*year_europe_other_tot/year_europe_other_tot03 + share_mig7_local203*year_asia_to
  ```
- Line 285: loc
  ```
  share_mig8_local203*year_africa_me_tot/year_africa_me_tot03       + share_mig9_local203*year_america
  ```
- Line 294: loc
  ```
  gen instrument3n_local=(share_mig1_local203*nyear_eu_orig1_tot/nyear_eu_orig1_tot03 +  ///
  ```
- Line 295: loc
  ```
  share_mig2_local203*nyear_eu_orig2_tot/nyear_eu_orig2_tot03         + share_mig3_local203*nyear_eu_2
  ```
- Line 296: loc
  ```
  share_mig4_local203*nyear_turkey_tot/nyear_turkey_tot03             + share_mig5_local203*nyear_yugo
  ```
- Line 297: loc
  ```
  share_mig6_local203*nyear_europe_other_tot/nyear_europe_other_tot03 + share_mig7_local203*nyear_asia
  ```
- Line 298: loc
  ```
  share_mig8_local203*nyear_africa_me_tot/nyear_africa_me_tot03       + share_mig9_local203*nyear_amer
  ```
- Line 308: loc
  ```
  keep betnr jahr instrument3n_local
  ```

**/replication-package/Brinatti_Morales_Replication_Package/liab_analysis/prog/6_dataset_for_regressions_validation.do**

- Line 6: lon
  ```
  * Source data: LIAB Longitudinal Model (version 1993-2014), IAB
  ```
- Line 11: loc
  ```
  - Immigrant share of local labour market wage bill (endogenous regressor)
  ```
- Line 17: lat
  ```
  ${orig}/cpigermany.dta                  — CPI deflat
  ```
- Line 56: lat
  ```
  ***Deflate wagebill - turnover
  ```
- Line 59: lat
  ```
  replace `x'=`x'*deflator
  ```
- Line 64: loc
  ```
  foreach x of varlist kreis_tot_tot loclabor_tot_tot year_tot_tot kreis_german_tot loclabor_german_to
  ```
- Line 65: lat
  ```
  replace `x'=`x'*deflator
  ```
- Line 101: loc
  ```
  gen share_mig_local2_t =(loclabor_tot_tot-loclabor_german_tot)/loclabor_tot_tot
  ```
- Line 116: loc
  ```
  gen interaction   = share_mig_local2_t*logemp_tot_firm03
  ```
- Line 141: loc, location
  ```
  *Generating new variables to analyse reallocation
  ```
- Line 144: lon
  ```
  clonevar wb_ger     =  wbill_german_tot
  ```

**/replication-package/Brinatti_Morales_Replication_Package/liab_analysis/prog/7_dataset_for_epsilon_estimation.do**

- Line 4: lon
  ```
  * Construct individual-level dataset for epsilon and kappa estimation
  ```
- Line 6: lon
  ```
  * Source data: LIAB Longitudinal Model (version 1993-2014), IAB
  ```
- Line 9: city
  ```
  kappa (elasticity of substitution across origin countries, dofile 9)
  ```
- Line 10: city, lon
  ```
  and epsilon (within-firm elasticity between immigrants and natives, dofile 10).
  ```
- Line 23: lon
  ```
  ${data}/dataset_epsilon_estimation.dta   — firm-year pan
  ```
- Line 72: country
  ```
  ****Assign consistent immigration country****
  ```
- Line 97: lat
  ```
  *Calculate tenure at firm
  ```
- Line 108: name
  ```
  rename college1 college
  ```
- Line 152: lon
  ```
  *Some cases remaining where we just count them as german as long as they report german for at least 
  ```
- Line 180: lat
  ```
  ***Create auxiliary variables needed later
  ```
- Line 193: lon
  ```
  save "${data}/individual_level_epsilon_liab.dta", replace
  ```
- Line 198: name
  ```
  rename tentgelt_orig tentgelt
  ```
- Line 210: loc
  ```
  *create reduced local labor markets
  ```
- Line 243: name
  ```
  rename ind_2dig_aux ind_2dig
  ```
- Line 248: loc
  ```
  egen ind_labormkt 	= group(ind_2dig local_labor11)
  ```
- Line 249: loc
  ```
  egen rt_fe 		 	= group(local_labor11 jahr)
  ```
- Line 336: country
  ```
  *Total workers in the country
  ```
- Line 343: loc
  ```
  bysort 				 local_labor11 jahr: egen wemp_rt=sum(tentgelt)
  ```
- Line 347: loc
  ```
  bysort nation_single local_labor11 jahr: egen wemp_ort=sum(tentgelt)
  ```
- Line 477: loc
  ```
  bysort local_labor11 jahr: egen nemp_nat_rt=sum((nation_single==1)*1)
  ```
- Line 478: loc
  ```
  bysort local_labor11 jahr: egen wemp_nat_rt=sum((nation_single==1)*tentgelt)
  ```
- Line 479: loc
  ```
  bysort local_labor11 jahr: egen nemp_rt=sum(1)
  ```
- Line 482: loc
  ```
  gen share_mig_local2_t = share_emp_imm_rt
  ```
- Line 539: loc
  ```
  gen relocated=.
  ```
- Line 570: loc
  ```
  replace relocated=1 if (t02a==1 | t02b==1 | t02c==1) & jahr==2011
  ```
- Line 571: loc
  ```
  replace relocated=0 if (t02d==1) & jahr==2011
  ```
- Line 614: loc
  ```
  replace relocated=1 if (s02a==1 | s02b==1 | s02c==1) & jahr==2010
  ```
- Line 615: loc
  ```
  replace relocated=0 if (s02d==1) & jahr==2010
  ```
- Line 658: loc
  ```
  replace relocated=1 if (r02a==1 | r02b==1 | r02c==1 | r02d==1 | r02e==1) & jahr==2009
  ```
- Line 659: loc
  ```
  replace relocated=0 if (r02f==1) & jahr==2009
  ```
- Line 702: loc
  ```
  replace relocated=1 if (q02a==1 | q02b==1 | q02c==1) & jahr==2008
  ```
- Line 703: loc
  ```
  replace relocated=0 if (q02a==0 & q02b==0 & q02c==0) & jahr==2008
  ```
- Line 742: loc
  ```
  replace relocated=1 if (p02a==1 | p02b==1 | p02c==1) & jahr==2007
  ```
- Line 743: loc
  ```
  replace relocated=0 if (p02a==0 & p02b==0 & p02c==0) & jahr==2007
  ```
- Line 781: loc
  ```
  replace relocated=1 if (o02a==1 | o02b==1 | o02c==1 | o02d==1 | o02e==1) & jahr==2006
  ```
- Line 782: loc
  ```
  replace relocated=0 if (o02a==0 & o02b==0 & o02c==0 & o02d==0 & o02e==0) & jahr==2006
  ```
- Line 819: loc
  ```
  replace relocated=1 if (n02aa==1 | n02ab==1 | n02ac==1) & jahr==2005
  ```
- Line 820: loc
  ```
  replace relocated=0 if (n02aa==0 & n02ab==0 & n02ac==0) & jahr==2005
  ```
- Line 861: loc
  ```
  replace relocated=1 if (m02aa==1 | m02ab==1 | m02ac==1) & jahr==2004
  ```
- Line 862: loc
  ```
  replace relocated=0 if (m02aa==0 & m02ab==0 & m02ac==0) & jahr==2004
  ```
- Line 902: loc
  ```
  replace relocated=1 if (l02a==1 | l02b==1 | l02c==1) & jahr==2003
  ```
- Line 903: loc
  ```
  replace relocated=0 if (l02a==0 & l02b==0 & l02c==0) & jahr==2003
  ```
- Line 1020: loc
  ```
  drop if missing(tradeable3) | missing(ind_2dig) | missing(local_labor11)
  ```
- Line 1022: lon
  ```
  clonevar wb_ger     =  wemp_nat_ft
  ```
- Line 1026: lon
  ```
  save "${data}/dataset_epsilon_estimation.dta", replace
  ```

**/replication-package/Brinatti_Morales_Replication_Package/liab_analysis/prog/8_validation_regressions.do**

- Line 6: lon
  ```
  * Source data: LIAB Longitudinal Model (version 1993-2014), IAB
  ```
- Line 9: loc
  ```
  outcomes on the immigrant share of the local labour market, instrumented
  ```
- Line 20: city
  ```
  Table 6  - Table C13 / Figure 3: Mean elasticity by size decile
  ```
- Line 68: loc, name
  ```
  rename instrument3n_local instrument3n_new
  ```
- Line 72: loc
  ```
  global regressors share_mig_local2_t interaction
  ```
- Line 75: loc
  ```
  global fixedeffects ind_med_time betnr i.local_labor11#c.jahr  c.cost_sales_03#i.jahr
  ```
- Line 76: loc
  ```
  global clustering ind_2dig local_labor11
  ```
- Line 108: loc
  ```
  local fstat_all=e(widstat)
  ```
- Line 109: loc
  ```
  gen   elast_lrev      	= (_b[share_mig_local2_t]*share_mig_local2_t + _b[interaction]*interaction)
  ```
- Line 116: loc
  ```
  local fstat_T=e(widstat)
  ```
- Line 117: loc
  ```
  gen   elast_lrev_T 	= (_b[share_mig_local2_t]*share_mig_local2_t + _b[interaction]*interaction) if t
  ```
- Line 124: loc
  ```
  local fstat_NT=e(widstat)
  ```
- Line 125: loc
  ```
  gen   elast_lrev_NT = (_b[share_mig_local2_t]*share_mig_local2_t + _b[interaction]*interaction) if t
  ```
- Line 132: loc
  ```
  gen   elast_ratio = (_b[share_mig_local2_t]*share_mig_local2_t + _b[interaction]*interaction) if tra
  ```
- Line 138: loc
  ```
  gen   elast_ratio_T 	= (_b[share_mig_local2_t]*share_mig_local2_t + _b[interaction]*interaction) if 
  ```
- Line 144: loc
  ```
  gen   elast_ratio_NT = (_b[share_mig_local2_t]*share_mig_local2_t + _b[interaction]*interaction) if 
  ```
- Line 185: loc
  ```
  *   wage bill ratio); share_mig_local2_t (LLM immigrant share of wage bill),
  ```
- Line 186: loc
  ```
  *   interaction (share_mig_local2_t x log emp 2003)
  ```
- Line 189: loc
  ```
  *   cost_sales_03 trend; SE clustered at (ind_2dig, local_labor11)
  ```
- Line 194: loc
  ```
  esttab y*, se nocons unstack star(* 0.10 ** 0.05  *** 0.01)  mtitles("All,sales" "T,sales" "NT,sales
  ```
- Line 208: country
  ```
  * Instrument: instrument3n_new (shift-share instrument: 2003 LLM origin-country
  ```
- Line 210: loc
  ```
  * Table shows causal effects of local immigrant inflows on firm outcomes.
  ```
- Line 226: loc
  ```
  esttab m*, se nocons unstack star(* 0.10 ** 0.05  *** 0.01)  mtitles("All,sales" "T,sales" "NT,sales
  ```
- Line 235: city
  ```
  * Elasticity of sales and ratio for all firms, T sector and NT sector
  ```
- Line 255: loc
  ```
  quietly reghdfe share_mig_local2_t  $instruments $controls, cl($clustering) absorb($fixedeffects)
  ```
- Line 257: loc
  ```
  quietly reghdfe share_mig_local2_t $instruments $controls if tradeable3==1, cl($clustering) absorb($
  ```
- Line 259: loc
  ```
  quietly reghdfe share_mig_local2_t $instruments $controls if tradeable3==0, cl($clustering) absorb($
  ```
- Line 274: loc
  ```
  * Variables: share_mig_local2_t and interaction (endogenous regressors);
  ```
- Line 297: loc
  ```
  local fstat_all=e(widstat)
  ```
- Line 318: loc
  ```
  esttab m*, se nocons unstack star(* 0.10 ** 0.05  *** 0.01)  mtitles("All,sales" "All,ratio") keep(s
  ```
- Line 331: loc
  ```
  local fstat_1=e(widstat)
  ```
- Line 334: loc
  ```
  local fstat_2=e(widstat)
  ```
- Line 335: loc
  ```
  quietly ivreghdfe logrevenues ( $regressors = $instruments ) $controls, cl($clustering) absorb(ind_m
  ```
- Line 337: loc
  ```
  local fstat_3=e(widstat)
  ```
- Line 338: loc
  ```
  quietly ivreghdfe logrevenues ( $regressors = $instruments ) $controls, cl($clustering) absorb(i.loc
  ```
- Line 340: loc
  ```
  local fstat_4=e(widstat)
  ```
- Line 343: loc
  ```
  local fstat_5=e(widstat)
  ```
- Line 344: loc
  ```
  quietly ivreghdfe logrevenues ( $regressors = $instruments ) $controls, cl($clustering) absorb(ind_m
  ```
- Line 346: loc
  ```
  local fstat_6=e(widstat)
  ```
- Line 354: loc
  ```
  local fstat_7=e(widstat)
  ```
- Line 357: loc
  ```
  local fstat_8=e(widstat)
  ```
- Line 358: loc
  ```
  quietly ivreghdfe wb_mig_ger ( $regressors = $instruments ) $controls, cl($clustering) absorb(ind_me
  ```
- Line 360: loc
  ```
  local fstat_9=e(widstat)
  ```
- Line 361: loc
  ```
  quietly ivreghdfe wb_mig_ger ( $regressors = $instruments ) $controls, cl($clustering) absorb(i.loca
  ```
- Line 363: loc
  ```
  local fstat_10=e(widstat)
  ```
- Line 366: loc
  ```
  local fstat_11=e(widstat)
  ```
- Line 367: loc
  ```
  quietly ivreghdfe wb_mig_ger ( $regressors = $instruments ) $controls, cl($clustering) absorb(ind_me
  ```
- Line 369: loc
  ```
  local fstat_12=e(widstat)
  ```
- Line 385: loc
  ```
  esttab z*, se nocons unstack star(* 0.10 ** 0.05  *** 0.01)  mtitles("Baseline" "No emp control" "No
  ```
- Line 394: loc
  ```
  esttab w*, se nocons unstack star(* 0.10 ** 0.05  *** 0.01)  mtitles("Baseline" "No emp control" "No
  ```
- Line 406: city
  ```
  * Table C13 / Figure 3: Mean firm-level elasticity by size decile
  ```
- Line 409: city
  ```
  * Variables: elast_lrev / elast_lrev_T / elast_lrev_NT (fitted revenue elasticity
  ```
- Line 411: city
  ```
  *   (fitted wage-bill ratio elasticity); decile_emp / decile_emp_T / decile_emp_NT
  ```

**/replication-package/Brinatti_Morales_Replication_Package/liab_analysis/prog/9_kappa_estimation.do**

- Line 4: city
  ```
  * Kappa estimation: elasticity of substitution across immigrant origin countries
  ```
- Line 6: lon
  ```
  * Source data: LIAB Longitudinal Model (version 1993-2014), IAB
  ```
- Line 9: lon
  ```
  the CES composite of immigrant effective labour units used in the epsilon
  ```
- Line 20: lon
  ```
  ${data}/sample_epsilon_estimation.dta         — sample flag for epsil
  ```
- Line 30: lon
  ```
  (i) "${data}/dataset_epsilon_estimation.dta": firm-year level used to select the sample following th
  ```
- Line 35: lon
  ```
  (ii) "${data}/sample_epsilon_estimation.dta": the sample of firms that has the same restrictions as 
  ```
- Line 37: lat, lon
  ```
  *This do file estimates kappa and compute the efficient units of immigrant share that will be later 
  ```
- Line 61: lon
  ```
  use "${data}/dataset_epsilon_estimation.dta", clear
  ```
- Line 76: lon
  ```
  gen sample_epsilon=e(sample)
  ```
- Line 78: lon
  ```
  keep sample_epsilon betnr jahr
  ```
- Line 80: lon
  ```
  save "${data}/sample_epsilon_estimation.dta", replace
  ```
- Line 96: lon
  ```
  *Keep firms in sample of epsilon estimation
  ```
- Line 101: lon
  ```
  keep if sample_epsilon ==1
  ```
- Line 122: lon
  ```
  *   epsilon sample (2008-2011, >= 10 employees, revenue available,
  ```
- Line 123: lon
  ```
  *   sample_epsilon == 1); one observation per origin x establishment x year
  ```
- Line 134: lon
  ```
  ivreghdfe l_wemp l_emp if sample_epsilon==1, absorb(i.id_o_2k_t   i.id_f_t i.id_f_o) cluster( id_f_o
  ```
- Line 137: lon
  ```
  quietly ivreghdfe l_wemp l_emp if sample_epsilon==1, absorb(i.id_o_2k_t   i.id_f_t i.id_f_o) cluster
  ```
- Line 138: loc
  ```
  local kappa_hat = 1/(1 - _b[l_emp] )
  ```
- Line 164: loc
  ```
  local kappa_est=`kappa_hat'
  ```

**/replication-package/Brinatti_Morales_Replication_Package/liab_analysis/prog/estimate_nu_cont.m**

- Line 9: gender
  ```
  %Controls for detailed occ detailed sector and year, and also age gender and
  ```
- Line 15: gender
  ```
  %Controls for detailed occ detailed sector, year, and also age gender and
  ```

**/replication-package/Brinatti_Morales_Replication_Package/liab_analysis/prog/master.do**

- Line 6: lon
  ```
  * Source data: LIAB Longitudinal Model (version 1993-2014), IAB
  ```
- Line 16: loc
  ```
  2_local_labor_markets.do
  ```
- Line 21: lon
  ```
  7_dataset_for_epsilon_estimation.do
  ```
- Line 26: lon
  ```
  10_epsilon_estimation.do          - Table C1
  ```
- Line 27: lon
  ```
  11_epsilon_pre_trend_test.do      - Table C3
  ```
- Line 28: lon
  ```
  12_epsilon_firm_characteristics.do- Table C5
  ```
- Line 29: lon
  ```
  13_estimate_epsilon_sigma.do      - Section 5.1 point estimates
  ```
- Line 30: lon
  ```
  14_epsilon_sigma_histogram.do     - Section 5.3; Figure C1
  ```
- Line 31: lon
  ```
  15_epsilon_shift_share.do         - Tables C2, C4 (instrument validity)
  ```
- Line 35: lat
  ```
  19_moments_calculation.do         - Table 1 / Table C7; Section 5.1
  ```
- Line 48: loc
  ```
  do "${prog}/2_local_labor_markets.do"
  ```
- Line 53: lon
  ```
  do "${prog}/7_dataset_for_epsilon_estimation.do"
  ```
- Line 66: lon
  ```
  do "${prog}/10_epsilon_estimation.do"
  ```
- Line 69: lon
  ```
  do "${prog}/11_epsilon_pre_trend_test.do"
  ```
- Line 72: lon
  ```
  do "${prog}/12_epsilon_firm_characteristics.do"
  ```
- Line 75: lon
  ```
  do "${prog}/13_estimate_epsilon_sigma.do"
  ```
- Line 78: lon
  ```
  do "${prog}/14_epsilon_sigma_histogram.do"
  ```
- Line 81: lon
  ```
  do "${prog}/15_epsilon_shift_share.do"
  ```
- Line 94: lat
  ```
  do "${prog}/19_moments_calculation.do"
  ```

**/replication-package/Brinatti_Morales_Replication_Package/master_file.do**

- Line 8: loc
  ```
  1) Change the "root" path below to wherever the replication folder is located
  ```
- Line 50: loc
  ```
  2_local_labor_markets.do
  ```
- Line 55: lon
  ```
  7_dataset_for_epsilon_estimation.do
  ```
- Line 60: lon
  ```
  10_epsilon_estimation.do          - Table C1
  ```
- Line 61: lon
  ```
  11_epsilon_pre_trend_test.do      - Table C3
  ```
- Line 62: lon
  ```
  12_epsilon_firm_characteristics.do- Table C5
  ```
- Line 63: lon
  ```
  13_estimate_epsilon_sigma.do      - Section 5.1 point estimates
  ```
- Line 64: lon
  ```
  14_epsilon_sigma_histogram.do     - Section 5.3; Figure C1
  ```
- Line 65: lon
  ```
  15_epsilon_shift_share.do         - Tables C2, C4 (instrument validity)
  ```
- Line 69: lat
  ```
  19_moments_calculation.do         - Table 1 / Table C7; Section 5.1
  ```
- Line 94: loc
  ```
  1b_add_local_labor_market
  ```
- Line 137: lat
  ```
  and Export_latex_tables.m (Tables 1, 2, C7,
  ```
- Line 138: block, loc
  ```
  D1-D3; Section 6.1/6.3 blocks)
  ```

**/replication-package/Brinatti_Morales_Replication_Package/model_analysis/code/model/Export_latex_tables.m**

- Line 1: lat
  ```
  % Export_latex_tables.m
  ```
- Line 28: name
  ```
  this_file = mfilename('fullpath');
  ```
- Line 40: name
  ```
  % Helper: load a Tab xlsx with row names
  ```
- Line 42: name
  ```
  load_agg = @(f) readtable(f, 'ReadRowNames', true);
  ```
- Line 64: name
  ```
  % Helper: extract Change column (col 1 in the 3-column Tab) by row name
  ```
- Line 66: name
  ```
  ch = @(T, name) T{name, 1};
  ```
- Line 70: name
  ```
  cf_eq   = @(T, name) T{name, 2};
  ```
- Line 71: name
  ```
  init_eq = @(T, name) T{name, 3};
  ```
- Line 88: lat
  ```
  fprintf(fid, '%% Auto-generated by Export_latex_tables.m\n');
  ```
- Line 99: city
  ```
  fprintf(fid, 'Covariance of $\\psi$ and $f_j$, T & $\\sigma_{\\psi,f,T}$    & %.2f   & Elasticity $s
  ```
- Line 120: lat
  ```
  fprintf(fid, '%% Auto-generated by Export_latex_tables.m\n');
  ```
- Line 142: lat
  ```
  fprintf(fid, '%% Auto-generated by Export_latex_tables.m\n');
  ```
- Line 176: lat
  ```
  %  "current 2019" coincide (the deflator at the base year is 1).
  ```
- Line 179: son
  ```
  %  to a per-worker concept (each LIAB worker is one person, not one FTE), so
  ```
- Line 218: son
  ```
  LF_TOTAL          = LF_TOTAL_THOUSAND * 1e3;           % persons
  ```
- Line 219: son
  ```
  NATIVE_LF         = LF_TOTAL * (1 - immigrant_share);  % persons
  ```
- Line 229: lat
  ```
  fprintf(fid, '%% Auto-generated by Export_latex_tables.m\n');
  ```
- Line 254: lat
  ```
  fprintf(fid, '%% Auto-generated by Export_latex_tables.m\n');
  ```
- Line 268: lat
  ```
  %  Table C.7 — Simulated vs data moments (Appendix 
  ```
- Line 272: lat
  ```
  fprintf(fid, '%% Auto-generated by Export_latex_tables.m\n');
  ```
- Line 275: lat
  ```
  fprintf(fid, 'Moment description & Simulated & Data & Moment description & Simulated & Data \\\\\n')
  ```
- Line 277: lat
  ```
  fprintf(fid, 'Aggregate $s_T$                                      & %.2f  & %.2f  & $E(1-s_{j,p90})
  ```
- Line 283: lat
  ```
  fprintf(fid, '$E(1-s_{j,p90})-E(1-s_{j,p50})$, T                   & %.3f & %.3f & $E(s_j)$         
  ```
- Line 294: lat
  ```
  fprintf(fid, '%% Auto-generated by Export_latex_tables.m\n');
  ```
- Line 306: lat
  ```
  fprintf(fid, '\\multicolumn{5}{l}{\\textbf{Wages (relative to numeraire)}} \\\\\n');
  ```
- Line 319: lat
  ```
  fprintf(fid, '%% Auto-generated by Export_latex_tables.m\n');
  ```
- Line 352: lat
  ```
  fprintf(fid, '%% Auto-generated by Export_latex_tables.m\n');
  ```
- Line 375: lat
  ```
  fprintf('\nAll LaTeX tables written to %s\n', tables_out);
  ```
- Line 379: loc
  ```
  % Local function: build_h_open_from_mat
  ```
- Line 382: name
  ```
  % row names match the labels this script uses via ch(h_open, name).
  ```
- Line 474: name
  ```
  % --- Bundle as a 1-column table indexed by the row names this script reads ---
  ```
- Line 475: name
  ```
  names = { ...
  ```
- Line 489: name
  ```
  T = table(vals, 'VariableNames', {'Change'}, 'RowNames', names);
  ```
- Line 493: loc
  ```
  % Local function: build_h_closed_from_mat
  ```
- Line 526: name
  ```
  T = table(100*earn_p_ch, 'VariableNames', {'Change'}, 'RowNames', {'earn_p'});
  ```
- Line 530: loc
  ```
  % Local function: build_m_open_from_mat
  ```
- Line 543: loc
  ```
  % Local function: build_m_closed_from_mat
  ```
- Line 582: name
  ```
  T = table(100*earn_p_ch, 'VariableNames', {'Change'}, 'RowNames', {'earn_p'});
  ```
- Line 586: loc
  ```
  % Local function: build_p_from_mat
  ```
- Line 636: name
  ```
  names = {'earn_p'; 'w_T_p'; 'w_NT_p'; 'w_imm_T_p'; 'w_imm_NT_p'; ...
  ```
- Line 654: name
  ```
  'VariableNames', {'Change','CFequil','Initialequil'}, ...
  ```
- Line 655: name
  ```
  'RowNames', names);
  ```
- Line 659: loc
  ```
  % Local function: snapshot_calibration
  ```
- Line 687: block, loc
  ```
  % InputVec layout must match the "Read the input vectors" block in
  ```

**/replication-package/Brinatti_Morales_Replication_Package/model_analysis/code/model/heterogeneous/Counterfactual_heterogeneous_closed.m**

- Line 72: name
  ```
  save(fullfile(fileparts(mfilename('fullpath')), 'Results_counterfactuals', ...
  ```

**/replication-package/Brinatti_Morales_Replication_Package/model_analysis/code/model/heterogeneous/Counterfactual_heterogeneous_open.m**

- Line 65: name
  ```
  save(fullfile(fileparts(mfilename('fullpath')), 'Results_counterfactuals', ...
  ```

**/replication-package/Brinatti_Morales_Replication_Package/model_analysis/code/model/heterogeneous/Equations_equilibrium/GE.m**

- Line 8: block, loc
  ```
  %   only on aggregate prices, expenditures, and the wage block; they
  ```
- Line 32: lon
  ```
  epsilon     = PP.epsilon;
  ```
- Line 38: lon
  ```
  D_t     = Pd^(sigma-1)*   Yd_t* (sigmat)*( (beta^(epsilon/(1-epsilon))*wd)^(1-sigma) );
  ```
- Line 40: lon
  ```
  D_nt    = Pd_nt^(sigma-1)*Yd_nt*(sigmat)*( (beta_nt^(epsilon/(1-epsilon))*wd_nt)^(1-sigma) );
  ```
- Line 42: lon
  ```
  Dexp    = Px^(sigmax-1)*   Yx*   (sigmaxt)*( (beta^(epsilon/(1-epsilon))*wd)^(1-sigmax) );
  ```
- Line 44: lon
  ```
  F_t      = wd*xbar*( ((beta^epsilon*wd^(1-epsilon))/((1-beta)^epsilon*wimm^(1-epsilon)))^(1/(iota*(e
  ```
- Line 46: lon
  ```
  F_nt     = wd_nt*xbar*( ((beta_nt^epsilon*wd_nt^(1-epsilon))/((1-beta_nt)^epsilon*wimm_nt^(1-epsilon
  ```

**/replication-package/Brinatti_Morales_Replication_Package/model_analysis/code/model/heterogeneous/Equations_equilibrium/equilLoop.m**

- Line 29: lon
  ```
  epsilon     = PP.epsilon;
  ```
- Line 347: lon
  ```
  fe_j        = f_j    * (F_t /wd)    .* (((1-sdom)   ./sdom)   .^(1/(iota*(epsilon-1))));
  ```
- Line 348: lon
  ```
  fe_j_nt     = f_j_nt * (F_nt/wd_nt) .* (((1-sdom_nt)./sdom_nt).^(1/(iota*(epsilon-1))));
  ```

**/replication-package/Brinatti_Morales_Replication_Package/model_analysis/code/model/heterogeneous/Equations_equilibrium/profitexpsd.m**

- Line 24: lon
  ```
  epsilon     = PP.epsilon;
  ```
- Line 38: lon
  ```
  iot = 1/(iota*(epsilon-1));
  ```
- Line 40: lon
  ```
  profsd_exp  = psi_g.^(sigma-1) *((D_t )/sigma) * ((1-sigma)/(epsilon-1)) .* ( sd.^((1-sigma)/(epsilo
  ```
- Line 41: lon
  ```
  + psi_g.^(sigmax-1)*((Dexp)/sigmax)* (1+taugx)^(1-sigmax) * ((1-sigmax)/(epsilon-1)) .* ( sd.^((1-si
  ```

**/replication-package/Brinatti_Morales_Replication_Package/model_analysis/code/model/heterogeneous/Equations_equilibrium/profitnexpntsd.m**

- Line 23: lon
  ```
  epsilon     = PP.epsilon;
  ```
- Line 34: lon
  ```
  iot = 1/(iota*(epsilon-1));
  ```
- Line 36: lon
  ```
  profsd_nexp = psi_g_nt.^(sigma-1) * D_nt * (1/sigma) * ((1-sigma)/(epsilon-1)) .* ( sd.^((1-sigma)/(
  ```

**/replication-package/Brinatti_Morales_Replication_Package/model_analysis/code/model/heterogeneous/Equations_equilibrium/profitnexptsd.m**

- Line 23: lon
  ```
  epsilon     = PP.epsilon;
  ```
- Line 35: lon
  ```
  iot = 1/(iota*(epsilon-1));
  ```
- Line 37: lon
  ```
  profsd_nexp = psi_g.^(sigma-1) * D_t * (1/sigma) * ((1-sigma)/(epsilon-1)) .* ( sd.^((1-sigma)/(epsi
  ```

**/replication-package/Brinatti_Morales_Replication_Package/model_analysis/code/model/heterogeneous/Equations_equilibrium/profits.m**

- Line 25: lon
  ```
  epsilon     = PP.epsilon;
  ```
- Line 41: lon
  ```
  iot = 1/(iota*(epsilon-1));
  ```

**/replication-package/Brinatti_Morales_Replication_Package/model_analysis/code/model/heterogeneous/Equations_equilibrium/revenues.m**

- Line 9: lon
  ```
  %   component alone.
  ```
- Line 27: lon
  ```
  epsilon     = PP.epsilon;
  ```
- Line 39: lon
  ```
  rev_nexp_nt = psi_g_nt.^(sigma-1) * D_nt      .* ( sd.^((1-sigma)/(epsilon-1)  ) ) ;
  ```
- Line 40: lon
  ```
  rev_nexp_t  = psi_g.^(sigma-1)    * D_t       .* ( sd.^((1-sigma)/(epsilon-1)  ) ) ;
  ```
- Line 41: lon
  ```
  rev_exp_only    = psi_g.^(sigmax-1)    * Dexp    .* ((1+taugx)).^(1-sigmax)  .*( sd.^((1-sigmax)/(ep
  ```

**/replication-package/Brinatti_Morales_Replication_Package/model_analysis/code/model/heterogeneous/Equations_equilibrium/utildent.m**

- Line 12: lon
  ```
  %     PP     - parameter struct (uses beta_nt, epsilon).
  ```
- Line 20: lon
  ```
  epsilon = PP.epsilon;
  ```
- Line 24: lon
  ```
  epsilon_aux = 1/(epsilon-1);
  ```
- Line 26: lon
  ```
  u_tilde = (beta_nt^(epsilon/(1-epsilon))*wd_nt).*sd.^epsilon_aux ;
  ```

**/replication-package/Brinatti_Morales_Replication_Package/model_analysis/code/model/heterogeneous/Equations_equilibrium/utildet.m**

- Line 12: lon
  ```
  %     PP - parameter struct (uses beta, epsilon).
  ```
- Line 21: lon
  ```
  epsilon = PP.epsilon;
  ```
- Line 23: lon
  ```
  epsilon_aux = 1/(epsilon-1);
  ```
- Line 27: lon
  ```
  u_tilde = (beta^(epsilon/(1-epsilon))*wd).*sd.^epsilon_aux ;
  ```

**/replication-package/Brinatti_Morales_Replication_Package/model_analysis/code/model/heterogeneous/Other_functions/Calibration_Res.m**

- Line 7: lat
  ```
  %   non-negative and that Walras' law holds, computes the simulated moments
  ```
- Line 23: lat
  ```
  %     ExitFlag     - 1 success, 2 boundary violation, 3 fsolve failure,
  ```
- Line 109: lat
  ```
  %% 4. Simulated moments and SMM objective
  ```
- Line 113: lat
  ```
  % Pack the 14 simulated moments that target Table C.7.
  ```
- Line 120: lat
  ```
  'moment_correlation', Mom.moment_correlation, ...
  ```
- Line 121: lat
  ```
  'moment_correlation_nt', Mom.moment_correlation_nt, ...
  ```
- Line 130: lat
  ```
  Mom_Data_draft  = struct('std_l_rev_cond', 1.38, 'sagg', 0.912, 'std_l_sd_ratio', 1.39, 'moment_corr
  ```
- Line 133: lat
  ```
  'moment_correlation_nt', 0.0084, 'mean_Dimm_nt', 0.61);
  ```
- Line 139: lat
  ```
  Mom_Data_draft.moment_correlation       - Mom_Model.moment_correlation , ...
  ```
- Line 147: lat
  ```
  Mom_Data_draft.moment_correlation_nt    - Mom_Model.moment_correlation_nt , ...
  ```
- Line 155: lat
  ```
  MomWeight       =   struct('std_l_rev_cond', 1, 'sagg', 1, 'std_l_sd_ratio', 1, 'moment_correlation'
  ```
- Line 158: lat
  ```
  'moment_correlation_nt', 1, 'mean_Dimm_nt', 1, 'mean_sd', 1);
  ```
- Line 165: lat
  ```
  weight_mat(4,4)     = MomWeight.moment_correlation*(1/Mom_Data_draft.moment_correlation^2)*40000;
  ```
- Line 173: lat
  ```
  weight_mat(12,12)   = MomWeight.moment_correlation_nt*(1/Mom_Data_draft.moment_correlation_nt^2)*400
  ```
- Line 191: lat
  ```
  Mom_List    = {'std_l_rev_cond', 'sagg', 'std_l_sd_ratio', 'moment_correlation', 'GDP_RoW_Ger', ...
  ```
- Line 193: lat
  ```
  'std_l_rev_nt_cond', 'sagg_nt', 'std_l_sd_ratio_nt', 'moment_correlation_nt', 'mean_Dimm_nt'};
  ```
- Line 198: lat
  ```
  Mom_Data_draft.moment_correlation        , Mom_Model.moment_correlation,    PP.cov_psif     ; ...
  ```
- Line 207: lat
  ```
  Mom_Data_draft.moment_correlation_nt     , Mom_Model.moment_correlation_nt, PP.cov_psif_nt  ; ...
  ```
- Line 210: name
  ```
  MomTab      = array2table(Mom_values, 'VariableNames', {'Data', 'Model', 'Parameters'}, 'RowNames', 
  ```

**/replication-package/Brinatti_Morales_Replication_Package/model_analysis/code/model/heterogeneous/Other_functions/ComputeMoments.m**

- Line 2: lat
  ```
  % ComputeMoments  Compute the 14 simulated moments at a given equilibrium.
  ```
- Line 63: lat
  ```
  %% 5. GDP per capita: RoW relative to Germany
  ```
- Line 86: lat
  ```
  %     across T and NT (moment_correlation, moment_correlation_nt)
  ```
- Line 104: lat
  ```
  moment_correlation = median_p90_T - median_p50_T;
  ```
- Line 112: lat
  ```
  moment_correlation_nt = median_p90_NT - median_p50_NT;
  ```
- Line 123: lat
  ```
  'moment_correlation',     moment_correlation, ...
  ```
- Line 124: lat
  ```
  'moment_correlation_nt',  moment_correlation_nt, ...
  ```

**/replication-package/Brinatti_Morales_Replication_Package/model_analysis/code/model/heterogeneous/Other_functions/Setup_PP.m**

- Line 19: lon
  ```
  epsilon         = 7.9;
  ```
- Line 69: lon
  ```
  PP              =   struct('epsilon', epsilon, 'iota', iota, 'sigma', sigma, 'sigmax', sigmax, ...
  ```

**/replication-package/Brinatti_Morales_Replication_Package/model_analysis/code/model/heterogeneous/Other_functions/mig_costs_mapping.m**

- Line 9: lat
  ```
  %   and `change_nt` (NT) relative to the baseline equilibrium.
  ```

**/replication-package/Brinatti_Morales_Replication_Package/model_analysis/code/model/heterogeneous/write_GER_xlsx.m**

- Line 18: name
  ```
  writetable(array2table(W.GER_0,    'VariableNames', GER_list),    xlsx_path, 'Sheet', 'GER_0',    'W
  ```
- Line 19: name
  ```
  writetable(array2table(W.GER_nt_0, 'VariableNames', GER_nt_list), xlsx_path, 'Sheet', 'GER_nt_0', 'W
  ```
- Line 20: name
  ```
  writetable(array2table(W.GER,      'VariableNames', GER_list),    xlsx_path, 'Sheet', 'GER',      'W
  ```
- Line 21: name
  ```
  writetable(array2table(W.GER_nt,   'VariableNames', GER_nt_list), xlsx_path, 'Sheet', 'GER_nt',   'W
  ```

**/replication-package/Brinatti_Morales_Replication_Package/model_analysis/code/model/homogeneous/Counterfactual_homogeneous_closed.m**

- Line 60: name
  ```
  save(fullfile(fileparts(mfilename('fullpath')), 'Results_counterfactuals', ...
  ```

**/replication-package/Brinatti_Morales_Replication_Package/model_analysis/code/model/homogeneous/Counterfactual_homogeneous_open.m**

- Line 52: name
  ```
  save(fullfile(fileparts(mfilename('fullpath')), 'Results_counterfactuals', ...
  ```

**/replication-package/Brinatti_Morales_Replication_Package/model_analysis/code/model/homogeneous/Equations_equilibrium/GE.m**

- Line 31: lon
  ```
  epsilon     = PP.epsilon;
  ```
- Line 37: lon
  ```
  D_t     = Pd^(sigma-1)*   Yd_t* (sigmat)*( (beta^(epsilon/(1-epsilon))*wd)^(1-sigma) );
  ```
- Line 39: lon
  ```
  D_nt    = Pd_nt^(sigma-1)*Yd_nt*(sigmat)*( (beta_nt^(epsilon/(1-epsilon))*wd_nt)^(1-sigma) );
  ```
- Line 41: lon
  ```
  Dexp    = Px^(sigmax-1)*   Yx*   (sigmaxt)*( (beta^(epsilon/(1-epsilon))*wd)^(1-sigmax) );
  ```
- Line 43: lon
  ```
  F_t      = wd*xbar*( ((beta^epsilon*wd^(1-epsilon))/((1-beta)^epsilon*wimm^(1-epsilon)))^(1/(iota*(e
  ```
- Line 45: lon
  ```
  F_nt     = wd_nt*xbar*( ((beta_nt^epsilon*wd_nt^(1-epsilon))/((1-beta_nt)^epsilon*wimm_nt^(1-epsilon
  ```

**/replication-package/Brinatti_Morales_Replication_Package/model_analysis/code/model/homogeneous/Equations_equilibrium/equilLoop.m**

- Line 34: lon
  ```
  epsilon     = PP.epsilon;
  ```
- Line 122: lon
  ```
  num_nt                    =             (beta_nt^ epsilon)*(wd_nt  ^(1-epsilon));
  ```
- Line 123: lon
  ```
  den_nt                    = num_nt + ((1-beta_nt)^epsilon)*(wimm_nt^(1-epsilon)) ;
  ```
- Line 132: lon
  ```
  num_t                  =             (beta^ epsilon)*(wd ^(1-epsilon));
  ```
- Line 133: lon
  ```
  den_t                  = num_t + ((1-beta)^epsilon)*(wimm^(1-epsilon)) ;
  ```
- Line 212: lon
  ```
  fe_j        = f_j    * (F_t /wd)    .* (((1-sdom)   ./sdom)   .^(1/(iota*(epsilon-1))));
  ```
- Line 213: lon
  ```
  fe_j_nt     = f_j_nt * (F_nt/wd_nt) .* (((1-sdom_nt)./sdom_nt).^(1/(iota*(epsilon-1))));
  ```

**/replication-package/Brinatti_Morales_Replication_Package/model_analysis/code/model/homogeneous/Equations_equilibrium/profitexpsd.m**

- Line 22: lon
  ```
  epsilon     = PP.epsilon;
  ```
- Line 35: lon
  ```
  iot = 1/(iota*(epsilon-1));
  ```
- Line 37: lon
  ```
  profsd_exp  = psi_g.^(sigma-1) *((D_t )/sigma) * ((1-sigma)/(epsilon-1)) .* ( sd.^((1-sigma)/(epsilo
  ```
- Line 38: lon
  ```
  + psi_g.^(sigmax-1) *((Dexp)/sigmax) * (1+taugx)^(1-sigmax) * ((1-sigmax)/(epsilon-1)) .* ( sd.^((1-
  ```

**/replication-package/Brinatti_Morales_Replication_Package/model_analysis/code/model/homogeneous/Equations_equilibrium/profitnexpntsd.m**

- Line 21: lon
  ```
  epsilon     = PP.epsilon;
  ```
- Line 32: lon
  ```
  iot = 1/(iota*(epsilon-1));
  ```
- Line 34: lon
  ```
  profsd_nexp = psi_g_nt.^(sigma-1) * D_nt * (1/sigma) * ((1-sigma)/(epsilon-1)) .* ( sd.^((1-sigma)/(
  ```

**/replication-package/Brinatti_Morales_Replication_Package/model_analysis/code/model/homogeneous/Equations_equilibrium/profitnexptsd.m**

- Line 21: lon
  ```
  epsilon     = PP.epsilon;
  ```
- Line 33: lon
  ```
  iot = 1/(iota*(epsilon-1));
  ```
- Line 35: lon
  ```
  profsd_nexp = psi_g.^(sigma-1) * D_t * (1/sigma) * ((1-sigma)/(epsilon-1)) .* ( sd.^((1-sigma)/(epsi
  ```

**/replication-package/Brinatti_Morales_Replication_Package/model_analysis/code/model/homogeneous/Equations_equilibrium/profits.m**

- Line 25: lon
  ```
  epsilon     = PP.epsilon;
  ```
- Line 41: lon
  ```
  iot = 1/(iota*(epsilon-1));
  ```

**/replication-package/Brinatti_Morales_Replication_Package/model_analysis/code/model/homogeneous/Equations_equilibrium/revenues.m**

- Line 8: lon
  ```
  %   exports) for an exporter in T, and the export component alone.
  ```
- Line 26: lon
  ```
  epsilon     = PP.epsilon;
  ```
- Line 37: lon
  ```
  rev_nexp_nt = psi_g_nt.^(sigma-1) * D_nt      .* ( sd.^((1-sigma)/(epsilon-1)  ) ) ;
  ```
- Line 38: lon
  ```
  rev_nexp_t  = psi_g.^(sigma-1)    * D_t       .* ( sd.^((1-sigma)/(epsilon-1)  ) ) ;
  ```
- Line 39: lon
  ```
  rev_exp_only    = psi_g.^(sigmax-1)    * Dexp    .* ((1+taugx)).^(1-sigmax)  .*( sd.^((1-sigmax)/(ep
  ```

**/replication-package/Brinatti_Morales_Replication_Package/model_analysis/code/model/homogeneous/Equations_equilibrium/utildent.m**

- Line 11: lon
  ```
  %     PP     - parameter struct (uses beta_nt, epsilon).
  ```
- Line 20: lon
  ```
  epsilon     = PP.epsilon;
  ```
- Line 24: lon
  ```
  epsilon_aux = 1/(epsilon-1);
  ```
- Line 26: lon
  ```
  u_tilde     = (beta_nt^(epsilon/(1-epsilon))*wd_nt).*sd.^epsilon_aux ;
  ```

**/replication-package/Brinatti_Morales_Replication_Package/model_analysis/code/model/homogeneous/Equations_equilibrium/utildet.m**

- Line 12: lon
  ```
  %     PP - parameter struct (uses beta, epsilon).
  ```
- Line 21: lon
  ```
  epsilon = PP.epsilon;
  ```
- Line 23: lon
  ```
  epsilon_aux = 1/(epsilon-1);
  ```
- Line 27: lon
  ```
  u_tilde = (beta^(epsilon/(1-epsilon))*wd).*sd.^epsilon_aux ;
  ```

**/replication-package/Brinatti_Morales_Replication_Package/model_analysis/code/model/homogeneous/Other_functions/Setup_PP.m**

- Line 19: lon
  ```
  epsilon         = 7.9;
  ```
- Line 69: lon
  ```
  PP              =   struct('epsilon', epsilon, 'iota', iota, 'sigma', sigma, 'sigmax', sigmax, ...
  ```

**/replication-package/Brinatti_Morales_Replication_Package/model_analysis/code/model/homogeneous/Other_functions/mig_costs_mapping.m**

- Line 9: lat
  ```
  %   and `change_nt` (NT) relative to the baseline equilibrium.
  ```

**/replication-package/Brinatti_Morales_Replication_Package/model_analysis/code/model/policies/Counterfactual_to_compare_policies.m**

- Line 7: name
  ```
  this_dir            = fileparts(mfilename('fullpath'));
  ```
- Line 99: lat
  ```
  % Re-pack SS as a flat struct (drops fields equilLoop does not use)
  ```

**/replication-package/Brinatti_Morales_Replication_Package/model_analysis/code/model/policies/Equations_equilibrium/GE.m**

- Line 8: block, loc
  ```
  %   only on aggregate prices, expenditures, and the wage block; they
  ```
- Line 32: lon
  ```
  epsilon     = PP.epsilon;
  ```
- Line 38: lon
  ```
  D_t     = Pd^(sigma-1)*   Yd_t* (sigmat)*( (beta^(epsilon/(1-epsilon))*wd)^(1-sigma) );
  ```
- Line 40: lon
  ```
  D_nt    = Pd_nt^(sigma-1)*Yd_nt*(sigmat)*( (beta_nt^(epsilon/(1-epsilon))*wd_nt)^(1-sigma) );
  ```
- Line 42: lon
  ```
  Dexp    = Px^(sigmax-1)*   Yx*   (sigmaxt)*( (beta^(epsilon/(1-epsilon))*wd)^(1-sigmax) );
  ```
- Line 44: lon
  ```
  F_t      = wd*xbar*( ((beta^epsilon*wd^(1-epsilon))/((1-beta)^epsilon*wimm^(1-epsilon)))^(1/(iota*(e
  ```
- Line 46: lon
  ```
  F_nt     = wd_nt*xbar*( ((beta_nt^epsilon*wd_nt^(1-epsilon))/((1-beta_nt)^epsilon*wimm_nt^(1-epsilon
  ```

**/replication-package/Brinatti_Morales_Replication_Package/model_analysis/code/model/policies/Equations_equilibrium/equilLoop.m**

- Line 28: lon
  ```
  epsilon     = PP.epsilon;
  ```
- Line 357: lon
  ```
  fe_j        = f_j    * (F_t /wd)    .* (((1-sdom)   ./sdom)   .^(1/(iota*(epsilon-1))));
  ```
- Line 358: lon
  ```
  fe_j_nt     = f_j_nt * (F_nt/wd_nt) .* (((1-sdom_nt)./sdom_nt).^(1/(iota*(epsilon-1))));
  ```
- Line 457: lon
  ```
  subsidy_fixed = wd   *sum( (f_j_orig    - f_j   ) * (F_t /wd)    .* (((1-sdom)   ./sdom)   .^(1/(iot
  ```
- Line 458: lon
  ```
  + wd_nt*sum( (f_j_nt_orig - f_j_nt) * (F_nt/wd_nt) .* (((1-sdom_nt)./sdom_nt).^(1/(iota*(epsilon-1))
  ```

**/replication-package/Brinatti_Morales_Replication_Package/model_analysis/code/model/policies/Equations_equilibrium/profitexpsd.m**

- Line 19: lon
  ```
  epsilon     = PP.epsilon;
  ```
- Line 33: lon
  ```
  iot = 1/(iota*(epsilon-1));
  ```
- Line 35: lon
  ```
  profsd_exp  = psi_g.^(sigma-1) *((D_t )/sigma) * ((1-sigma)/(epsilon-1)) .* ( sd.^((1-sigma)/(epsilo
  ```
- Line 36: lon
  ```
  + psi_g.^(sigmax-1)*((Dexp)/sigmax)* (1+taugx)^(1-sigmax) * ((1-sigmax)/(epsilon-1)) .* ( sd.^((1-si
  ```

**/replication-package/Brinatti_Morales_Replication_Package/model_analysis/code/model/policies/Equations_equilibrium/profitnexpntsd.m**

- Line 17: lon
  ```
  epsilon     = PP.epsilon;
  ```
- Line 28: lon
  ```
  iot = 1/(iota*(epsilon-1));
  ```
- Line 30: lon
  ```
  profsd_nexp = psi_g_nt.^(sigma-1) * D_nt * (1/sigma) * ((1-sigma)/(epsilon-1)) .* ( sd.^((1-sigma)/(
  ```

**/replication-package/Brinatti_Morales_Replication_Package/model_analysis/code/model/policies/Equations_equilibrium/profitnexptsd.m**

- Line 19: lon
  ```
  epsilon     = PP.epsilon;
  ```
- Line 30: lon
  ```
  iot = 1/(iota*(epsilon-1));
  ```
- Line 32: lon
  ```
  profsd_nexp = psi_g.^(sigma-1) * D_t * (1/sigma) * ((1-sigma)/(epsilon-1)) .* ( sd.^((1-sigma)/(epsi
  ```

**/replication-package/Brinatti_Morales_Replication_Package/model_analysis/code/model/policies/Equations_equilibrium/profits.m**

- Line 25: lon
  ```
  epsilon     = PP.epsilon;
  ```
- Line 41: lon
  ```
  iot = 1/(iota*(epsilon-1));
  ```

**/replication-package/Brinatti_Morales_Replication_Package/model_analysis/code/model/policies/Equations_equilibrium/revenues.m**

- Line 8: lon
  ```
  %   component alone.
  ```
- Line 26: lon
  ```
  epsilon     = PP.epsilon;
  ```
- Line 38: lon
  ```
  rev_nexp_nt = psi_g_nt.^(sigma-1) * D_nt      .* ( sd.^((1-sigma)/(epsilon-1)  ) ) ;
  ```
- Line 39: lon
  ```
  rev_nexp_t  = psi_g.^(sigma-1)    * D_t       .* ( sd.^((1-sigma)/(epsilon-1)  ) ) ;
  ```
- Line 40: lon
  ```
  rev_exp_only    = psi_g.^(sigmax-1)    * Dexp    .* ((1+taugx)).^(1-sigmax)  .*( sd.^((1-sigmax)/(ep
  ```

**/replication-package/Brinatti_Morales_Replication_Package/model_analysis/code/model/policies/Equations_equilibrium/utildent.m**

- Line 20: lon
  ```
  epsilon = PP.epsilon;
  ```
- Line 24: lon
  ```
  epsilon_aux = 1/(epsilon-1);
  ```
- Line 26: lon
  ```
  u_tilde = (beta_nt^(epsilon/(1-epsilon))*wd_nt).*sd.^epsilon_aux ;
  ```

**/replication-package/Brinatti_Morales_Replication_Package/model_analysis/code/model/policies/Equations_equilibrium/utildet.m**

- Line 12: lon
  ```
  %     PP - parameter struct (uses beta, epsilon).
  ```
- Line 21: lon
  ```
  epsilon = PP.epsilon;
  ```
- Line 23: lon
  ```
  epsilon_aux = 1/(epsilon-1);
  ```
- Line 27: lon
  ```
  u_tilde = (beta^(epsilon/(1-epsilon))*wd).*sd.^epsilon_aux ;
  ```

**/replication-package/Brinatti_Morales_Replication_Package/model_analysis/code/model/policies/write_GER_xlsx_policy.m**

- Line 25: name
  ```
  writetable(array2table(W.GER_0,    'VariableNames', GER_list),    xlsx_path, 'Sheet', 'GER_0',    'W
  ```
- Line 26: name
  ```
  writetable(array2table(W.GER_nt_0, 'VariableNames', GER_nt_list), xlsx_path, 'Sheet', 'GER_nt_0', 'W
  ```
- Line 27: name
  ```
  writetable(array2table(W.GER,      'VariableNames', GER_list),    xlsx_path, 'Sheet', 'GER',      'W
  ```
- Line 28: name
  ```
  writetable(array2table(W.GER_nt,   'VariableNames', GER_nt_list), xlsx_path, 'Sheet', 'GER_nt',   'W
  ```

**/replication-package/Brinatti_Morales_Replication_Package/model_analysis/code/stata_plots/Counterfactual_plots_heterog.do**

- Line 17: name
  ```
  * Only the two variables used by Figure 4 (rev, Ld_alt) are renamed.
  ```
- Line 21: name
  ```
  rename L rev
  ```
- Line 22: name
  ```
  rename O Ld_alt
  ```
- Line 32: name
  ```
  rename J rev
  ```
- Line 33: name
  ```
  rename L Ld_alt
  ```
- Line 47: name
  ```
  rename L rev
  ```
- Line 48: name
  ```
  rename O Ld_alt
  ```
- Line 62: name
  ```
  rename J rev
  ```
- Line 63: name
  ```
  rename L Ld_alt
  ```
- Line 81: loc, location
  ```
  * Figure 4 (Section 6.1): native reallocation across firms in heterogeneous
  ```
- Line 84: loc
  ```
  local total_natives_DE = 35574.74425262905
  ```
- Line 141: name
  ```
  name(F4, replace)
  ```

**/replication-package/Brinatti_Morales_Replication_Package/model_analysis/code/stata_plots/Counterfactual_plots_policies.do**

- Line 32: name
  ```
  rename A psi
  ```
- Line 33: name
  ```
  rename E sdom
  ```
- Line 34: name
  ```
  rename O Ld_alt
  ```
- Line 35: name
  ```
  rename P I_alt
  ```
- Line 43: name
  ```
  rename A psi
  ```
- Line 44: name
  ```
  rename D sdom
  ```
- Line 45: name
  ```
  rename L Ld_alt
  ```
- Line 46: name
  ```
  rename M I_alt
  ```
- Line 54: name
  ```
  rename A psi
  ```
- Line 55: name
  ```
  rename E sdom
  ```
- Line 56: name
  ```
  rename O Ld_alt
  ```
- Line 57: name
  ```
  rename P I_alt
  ```
- Line 65: name
  ```
  rename A psi
  ```
- Line 66: name
  ```
  rename D sdom
  ```
- Line 67: name
  ```
  rename L Ld_alt
  ```
- Line 68: name
  ```
  rename M I_alt
  ```
- Line 76: name
  ```
  rename A psi
  ```
- Line 77: name
  ```
  rename E sdom
  ```
- Line 78: name
  ```
  rename O Ld_alt
  ```
- Line 79: name
  ```
  rename P I_alt
  ```
- Line 87: name
  ```
  rename A psi
  ```
- Line 88: name
  ```
  rename D sdom
  ```
- Line 89: name
  ```
  rename L Ld_alt
  ```
- Line 90: name
  ```
  rename M I_alt
  ```
- Line 98: name
  ```
  rename A psi
  ```
- Line 99: name
  ```
  rename E sdom
  ```
- Line 100: name
  ```
  rename O Ld_alt
  ```
- Line 101: name
  ```
  rename P I_alt
  ```
- Line 109: name
  ```
  rename A psi
  ```
- Line 110: name
  ```
  rename D sdom
  ```
- Line 111: name
  ```
  rename L Ld_alt
  ```
- Line 112: name
  ```
  rename M I_alt
  ```
- Line 120: name
  ```
  rename A psi
  ```
- Line 121: name
  ```
  rename E sdom
  ```
- Line 122: name
  ```
  rename O Ld_alt
  ```
- Line 123: name
  ```
  rename P I_alt
  ```
- Line 131: name
  ```
  rename A psi
  ```
- Line 132: name
  ```
  rename D sdom
  ```
- Line 133: name
  ```
  rename L Ld_alt
  ```
- Line 134: name
  ```
  rename M I_alt
  ```
- Line 142: name
  ```
  rename A psi
  ```
- Line 143: name
  ```
  rename E sdom
  ```
- Line 144: name
  ```
  rename O Ld_alt
  ```
- Line 145: name
  ```
  rename P I_alt
  ```
- Line 153: name
  ```
  rename A psi
  ```
- Line 154: name
  ```
  rename D sdom
  ```
- Line 155: name
  ```
  rename L Ld_alt
  ```
- Line 156: name
  ```
  rename M I_alt
  ```
- Line 162: block, loc
  ```
  * Stack all 12 blocks
  ```
- Line 217: loc
  ```
  local scale = 35574.74425262905 / 1000
  ```
- Line 237: loc
  ```
  local panels D1_p1 D1_p2 D1_p3 D1_p4
  ```
- Line 238: loc
  ```
  local cfvals 4 2 5 6
  ```
- Line 239: loc
  ```
  local titles `" "(a) Policy 1" "(b) Policy 2" "(c) Policy 3" "(d) Policy 4" "'
  ```
- Line 241: loc
  ```
  local ylab1_1 "-400(200)1000"
  ```
- Line 242: loc
  ```
  local ylab1_2 "-400(200)1400"
  ```
- Line 243: loc
  ```
  local ylab1_3 "-80(20)60"
  ```
- Line 244: loc
  ```
  local ylab1_4 "-500(500)4000"
  ```
- Line 246: loc
  ```
  local ylab2_1 "-12(5)28"
  ```
- Line 247: loc
  ```
  local ylab2_2 "-3(2)9"
  ```
- Line 248: loc
  ```
  local ylab2_3 "-15(5)10"
  ```
- Line 249: loc
  ```
  local ylab2_4 "-1(1)9"
  ```
- Line 252: loc
  ```
  local col_nat "167 200 137"
  ```
- Line 253: loc
  ```
  local col_imm "91 155 213"
  ```
- Line 256: loc
  ```
  local cfval  : word `i' of `cfvals'
  ```
- Line 257: loc, name
  ```
  local pname  : word `i' of `panels'
  ```
- Line 258: loc
  ```
  local ptitle : word `i' of `titles'
  ```
- Line 259: loc
  ```
  local yl1    "`ylab1_`i''"
  ```
- Line 260: loc
  ```
  local yl2    "`ylab2_`i''"
  ```
- Line 288: name
  ```
  name(`pname', replace)
  ```
- Line 302: block, loc
  ```
  * the D1 block above), single-row legend, no title, abbreviated left ytitle.
  ```
- Line 327: name
  ```
  name(D2, replace) xsize(8) ysize(5)
  ```

**/replication-package/Brinatti_Morales_Replication_Package/model_analysis/code/stata_plots/Validation_cross_CI_heterog.do**

- Line 14: lat
  ```
  *   I_Ld_alt = (wimm * I_alt) / (wd * Ld_alt) = relative immigrant-native wage bill
  ```
- Line 19: name
  ```
  rename (A B L S) (psi f rev I_Ld_alt)
  ```
- Line 28: name
  ```
  rename (A B J P) (psi f rev I_Ld_alt)
  ```
- Line 37: name
  ```
  rename (A B L S) (psi f rev I_Ld_alt)
  ```
- Line 46: name
  ```
  rename (A B J P) (psi f rev I_Ld_alt)
  ```
- Line 75: name
  ```
  rename meansales rev_mean_dec_bse
  ```
- Line 76: name
  ```
  rename meanratio ratio_mean_dec_bse
  ```
- Line 98: city
  ```
  * Elasticity = (% change in outcome) / (immigration shock of 0.2)
  ```
- Line 99: city
  ```
  gen elasticity_trim_1       = rev_hat_trim_1     / 0.2
  ```
- Line 100: city
  ```
  gen elasticity_ratio_trim_1 = imm_nat_hat_trim_1 / 0.2
  ```
- Line 102: city
  ```
  by size_dec sector, sort: egen elast_rev_t1 = mean(elasticity_trim_1)       if t==1
  ```
- Line 103: city
  ```
  by size_dec sector, sort: egen elast_rat_t1 = mean(elasticity_ratio_trim_1) if t==1
  ```
- Line 114: name
  ```
  rename elast_rev_t1       model_rev
  ```
- Line 115: name
  ```
  rename elast_rat_t1       model_rat
  ```
- Line 116: name
  ```
  rename rev_mean_dec_bse   data_rev
  ```
- Line 117: name
  ```
  rename ratio_mean_dec_bse data_rat
  ```
- Line 141: loc
  ```
  local xax    xlabel(1(1)10, labsize(small)) xtitle("Size decile (1 smallest - 10 largest)", size(sma
  ```
- Line 142: loc
  ```
  local style  graphregion(color(white)) plotregion(color(white)) ysize(5) xsize(6.5)
  ```
- Line 143: loc
  ```
  local legopt  legend(order(1 "Model" 2 "Data") cols(1) ring(0) position(11) ///
  ```
- Line 147: loc
  ```
  local legopt_d legend(order(1 "Model" 2 "Data") cols(1) ring(0) position(7) ///
  ```
- Line 150: loc
  ```
  local ylab_a `"0 "0" 0.5 "0.5" 1 "1" 1.5 "1.5" 2 "2" 2.5 "2.5" 3 "3" 3.5 "3.5""'
  ```
- Line 151: loc
  ```
  local ylab_b `"-0.05 "-0.05" -0.03 "-0.03" -0.01 "-0.01" 0.01 "0.01" 0.03 "0.03" 0.05 "0.05""'
  ```
- Line 152: loc
  ```
  local ylab_c `"0 "0" 0.05 "0.05" 0.1 "0.1" 0.15 "0.15" 0.2 "0.2" 0.25 "0.25" 0.3 "0.3" 0.35 "0.35" 0
  ```
- Line 153: loc
  ```
  local ylab_d `"-0.25 "-0.25" -0.2 "-0.2" -0.15 "-0.15" -0.1 "-0.1" -0.05 "-0.05" 0 "0""'
  ```
- Line 157: city
  ```
  , ytitle("Revenue elasticity", size(small)) `xax' ylabel(`ylab_a', labsize(small) angle(horizontal))
  ```
- Line 158: name
  ```
  title("(a) Revenues - Tradable sector", size(small)) `legopt' `style' name(g1, replace)
  ```
- Line 162: city
  ```
  , ytitle("Revenue elasticity", size(small)) `xax' ylabel(`ylab_b', labsize(small) angle(horizontal))
  ```
- Line 163: name
  ```
  title("(b) Revenues - Non-Tradable sector", size(small)) `legopt' `style' name(g2, replace)
  ```
- Line 168: lat, name
  ```
  title("(c) Relative Wage Bill - Tradable sector", size(small)) `legopt' `style' name(g3, replace)
  ```
- Line 173: lat, name
  ```
  title("(d) Relative Wage Bill - Non-Tradable sector", size(small)) `legopt_d' `style' name(g4, repla
  ```

**/replication-package/Brinatti_Morales_Replication_Package/model_analysis/code/stata_plots/sj_grstyle.do**

- Line 24: loc
  ```
  grstyle clockdir legend_position 4
  ```

**/replication-package/Brinatti_Morales_Replication_Package/model_analysis/output/tables/sec61_aggregates.tex**

- Line 1: lat
  ```
  % Auto-generated by Export_latex_tables.m
  ```

**/replication-package/Brinatti_Morales_Replication_Package/model_analysis/output/tables/sec61_dollar_gains.tex**

- Line 1: lat
  ```
  % Auto-generated by Export_latex_tables.m
  ```

**/replication-package/Brinatti_Morales_Replication_Package/model_analysis/output/tables/sec63_decomposition.tex**

- Line 1: lat
  ```
  % Auto-generated by Export_latex_tables.m
  ```

**/replication-package/Brinatti_Morales_Replication_Package/model_analysis/output/tables/table1.tex**

- Line 1: lat
  ```
  % Auto-generated by Export_latex_tables.m
  ```
- Line 12: city
  ```
  Covariance of $\psi$ and $f_j$, T & $\sigma_{\psi,f,T}$    & -54.03   & Elasticity $s_j$ to $n$     
  ```

**/replication-package/Brinatti_Morales_Replication_Package/model_analysis/output/tables/table2.tex**

- Line 1: lat
  ```
  % Auto-generated by Export_latex_tables.m
  ```

**/replication-package/Brinatti_Morales_Replication_Package/model_analysis/output/tables/tableC7.tex**

- Line 1: lat
  ```
  % Auto-generated by Export_latex_tables.m
  ```
- Line 4: lat
  ```
  Moment description & Simulated & Data & Moment description & Simulated & Data \\
  ```

**/replication-package/Brinatti_Morales_Replication_Package/model_analysis/output/tables/tableD1.tex**

- Line 1: lat
  ```
  % Auto-generated by Export_latex_tables.m
  ```
- Line 13: lat
  ```
  \multicolumn{5}{l}{\textbf{Wages (relative to numeraire)}} \\
  ```

**/replication-package/Brinatti_Morales_Replication_Package/model_analysis/output/tables/tableD2.tex**

- Line 1: lat
  ```
  % Auto-generated by Export_latex_tables.m
  ```

**/replication-package/Brinatti_Morales_Replication_Package/model_analysis/output/tables/tableD3.tex**

- Line 1: lat
  ```
  % Auto-generated by Export_latex_tables.m
  ```

**/replication-package/Brinatti_Morales_Replication_Package/model_analysis/scripts/master.do**

- Line 14: lon
  ```
  * is called. To run this file standalone, uncomment and set the line below:
  ```
- Line 31: loc, location
  ```
  * Figure 4: native reallocation across firms (Section 6.1)
  ```
- Line 32: son
  ```
  * Also produces Table 2 numerical comparisons
  ```

**/replication-package/Brinatti_Morales_Replication_Package/model_analysis/scripts/master.m**

- Line 15: name
  ```
  this_file = mfilename('fullpath');
  ```
- Line 33: lat
  ```
  run_isolated('Counterfactual_heterogeneous_open.m');
  ```
- Line 38: lat
  ```
  run_isolated('Counterfactual_heterogeneous_closed.m');
  ```
- Line 48: son
  ```
  %  HOMOGENEOUS MODEL (Section 6.2, 6.3 comparison)
  ```
- Line 57: lat
  ```
  run_isolated('Counterfactual_homogeneous_open.m');
  ```
- Line 60: lat
  ```
  run_isolated('Counterfactual_homogeneous_closed.m');
  ```
- Line 88: lat
  ```
  %  EXPORT LaTeX TABLES
  ```
- Line 91: lat
  ```
  fprintf('\nExporting LaTeX tables (table2, tableD1, tableD2, tableD3, sec61_aggregates, sec61_dollar
  ```
- Line 93: lat
  ```
  run_isolated('Export_latex_tables.m');
  ```
- Line 100: name
  ```
  run(script_name);
  ```
- Line 104: name
  ```
  run(script_name);
  ```

**/replication-package/Brinatti_Morales_Replication_Package/sieed_analysis/prog/1a_create_data_event_study.do**

- Line 18: loc, location
  ```
  *                                         (industry, location, panel flag)
  ```
- Line 82: country
  ```
  ****Assign consistent immigration country****
  ```
- Line 87: social
  ```
  * Workers' citizenship in the social security records can change over time
  ```
- Line 88: block, loc
  ```
  * (e.g., naturalization). The block below assigns each worker a stable
  ```
- Line 98: lat
  ```
  *Calculate tenure at firm
  ```
- Line 110: name
  ```
  rename college1 college
  ```
- Line 152: lon
  ```
  *Some cases remaining where we just count them as german as long as they report german for at least 
  ```
- Line 164: child
  ```
  * citizenship but entered the labor market very young are likely children of
  ```
- Line 207: name
  ```
  rename nation_single nation
  ```
- Line 227: lat
  ```
  replace nation_grouped=14 if (nation>=320 & nation<=347) | (nation>=349 & nation<=367)  | (nation>=3
  ```
- Line 235: lat
  ```
  label define nation_grouped 0 "0 Germany" 1 "1 EU High Income" 2 "2 EU Middle Income" 3 "3 EU 2004" 
  ```
- Line 250: gender
  ```
  *   - Worker characteristics (college, gender, age) for new NMS/control hires,
  ```
- Line 305: lat
  ```
  * are not negatively selected relative to the pre-2011 cohort (Section 3.3.2).
  ```
- Line 338: district
  ```
  * Merge in BHP establishment characteristics (industry code, district of
  ```
- Line 339: loc, location
  ```
  * establishment location, panel membership flag). These are used to construct
  ```
- Line 340: loc
  ```
  * industry and local labor market fixed effects in the regressions.
  ```

**/replication-package/Brinatti_Morales_Replication_Package/sieed_analysis/prog/1b_add_local_labor_market.do**

- Line 2: loc
  ```
  * 1b_add_local_labor_market.do
  ```
- Line 5: district
  ```
  *   Maps German administrative districts (Kreise, identified by the variable
  ```
- Line 6: loc
  ```
  *   ao_kreis) to functional local labor market areas following the commuting-
  ```
- Line 9: loc
  ```
  *   local labor market fixed effects can be included in the event study
  ```
- Line 13: loc
  ```
  *   local labor market whose identifier (local_labor) corresponds to its
  ```
- Line 15: district
  ```
  *   identifier encodes the core district of the labor market area.
  ```
- Line 47: district
  ```
  * Merge in the BHP establishment file to obtain the district identifier
  ```
- Line 58: loc
  ```
  gen local_labor=.
  ```
- Line 62: loc
  ```
  * Kreis-to-local-labor-market mapping
  ```
- Line 64: loc
  ```
  * Each replace statement assigns the Kreis (ao_kreis) to its parent local
  ```
- Line 65: loc
  ```
  * labor market area (local_labor) following Kropp and Schwengler (2011).
  ```
- Line 66: city, district, loc
  ```
  * The local_labor identifier is the Kreis code of the anchor city or district
  ```
- Line 69: loc
  ```
  * unassigned (local_labor==.).
  ```
- Line 72: loc
  ```
  replace local_labor=1001000 if ao_kreis==1001
  ```
- Line 73: loc
  ```
  replace local_labor=1002000 if ao_kreis==1002
  ```
- Line 74: loc
  ```
  replace local_labor=1003000 if ao_kreis==1003
  ```
- Line 75: loc
  ```
  replace local_labor=1002000 if ao_kreis==1004
  ```
- Line 76: loc
  ```
  replace local_labor=2000000 if ao_kreis==1051
  ```
- Line 77: loc
  ```
  replace local_labor=2000000 if ao_kreis==1053
  ```
- Line 78: loc
  ```
  replace local_labor=1001000 if ao_kreis==1054
  ```
- Line 79: loc
  ```
  replace local_labor=1003000 if ao_kreis==1055
  ```
- Line 80: loc
  ```
  replace local_labor=2000000 if ao_kreis==1056
  ```
- Line 81: loc
  ```
  replace local_labor=1002000 if ao_kreis==1057
  ```
- Line 82: loc
  ```
  replace local_labor=1002000 if ao_kreis==1058
  ```
- Line 83: loc
  ```
  replace local_labor=1001000 if ao_kreis==1059
  ```
- Line 84: loc
  ```
  replace local_labor=2000000 if ao_kreis==1060
  ```
- Line 85: loc
  ```
  replace local_labor=2000000 if ao_kreis==1061
  ```
- Line 86: loc
  ```
  replace local_labor=2000000 if ao_kreis==1062
  ```
- Line 87: loc
  ```
  replace local_labor=2000000 if ao_kreis==2000
  ```
- Line 88: loc
  ```
  replace local_labor=3101000 if ao_kreis==3101
  ```
- Line 89: loc
  ```
  replace local_labor=3101000 if ao_kreis==3102
  ```
- Line 90: loc
  ```
  replace local_labor=3103000 if ao_kreis==3103
  ```
- Line 91: loc
  ```
  replace local_labor=3103000 if ao_kreis==3151
  ```
- Line 92: loc
  ```
  replace local_labor=3152012 if ao_kreis==3152
  ```
- Line 93: loc
  ```
  replace local_labor=3101000 if ao_kreis==3153
  ```
- Line 94: loc
  ```
  replace local_labor=3103000 if ao_kreis==3154
  ```
- Line 95: loc
  ```
  replace local_labor=3152012 if ao_kreis==3155
  ```
- Line 96: loc
  ```
  replace local_labor=3152012 if ao_kreis==3156
  ```
- Line 97: loc
  ```
  replace local_labor=3101000 if ao_kreis==3157
  ```
- Line 98: loc
  ```
  replace local_labor=3101000 if ao_kreis==3158
  ```
- Line 99: loc
  ```
  replace local_labor=3241001 if ao_kreis==3241
  ```
- Line 100: loc
  ```
  replace local_labor=4011000 if ao_kreis==3251
  ```
- Line 101: loc
  ```
  replace local_labor=3241001 if ao_kreis==3252
  ```
- Line 102: loc
  ```
  replace local_labor=3254021 if ao_kreis==3254
  ```
- Line 103: loc
  ```
  replace local_labor=5774032 if ao_kreis==3255
  ```
- Line 104: loc
  ```
  replace local_labor=3241001 if ao_kreis==3256
  ```
- Line 105: loc
  ```
  replace local_labor=3241001 if ao_kreis==3257
  ```
- Line 106: loc
  ```
  replace local_labor=3241001 if ao_kreis==3351
  ```
- Line 107: loc
  ```
  replace local_labor=4012000 if ao_kreis==3352
  ```
- Line 108: loc
  ```
  replace local_labor=2000000 if ao_kreis==3353
  ```
- Line 109: loc
  ```
  replace local_labor=2000000 if ao_kreis==3354
  ```
- Line 110: loc
  ```
  replace local_labor=2000000 if ao_kreis==3355
  ```
- Line 111: loc
  ```
  replace local_labor=4011000 if ao_kreis==3356
  ```
- Line 112: loc
  ```
  replace local_labor=4011000 if ao_kreis==3357
  ```
- Line 113: loc
  ```
  replace local_labor=3241001 if ao_kreis==3358
  ```
- Line 114: loc
  ```
  replace local_labor=2000000 if ao_kreis==3359
  ```
- Line 115: loc
  ```
  replace local_labor=2000000 if ao_kreis==3360
  ```
- Line 116: loc
  ```
  replace local_labor=4011000 if ao_kreis==3361
  ```
- Line 117: loc
  ```
  replace local_labor=4011000 if ao_kreis==3401
  ```
- Line 118: loc
  ```
  replace local_labor=3402000 if ao_kreis==3402
  ```
- Line 119: loc
  ```
  replace local_labor=3403000 if ao_kreis==3403
  ```
- Line 120: loc
  ```
  replace local_labor=3404000 if ao_kreis==3404
  ```
- Line 121: loc
  ```
  replace local_labor=3403000 if ao_kreis==3405
  ```
- Line 122: loc
  ```
  replace local_labor=3403000 if ao_kreis==3451
  ```
- Line 123: loc
  ```
  replace local_labor=3402000 if ao_kreis==3452
  ```
- Line 124: loc
  ```
  replace local_labor=3403000 if ao_kreis==3453
  ```
- Line 125: loc
  ```
  replace local_labor=3454041 if ao_kreis==3454
  ```
- Line 126: loc
  ```
  replace local_labor=3403000 if ao_kreis==3455
  ```
- Line 127: loc
  ```
  replace local_labor=5515000 if ao_kreis==3456
  ```
- Line 128: loc
  ```
  replace local_labor=3402000 if ao_kreis==3457
  ```
- Line 129: loc
  ```
  replace local_labor=4011000 if ao_kreis==3458
  ```
- Line 130: loc
  ```
  replace local_labor=3404000 if ao_kreis==3459
  ```
- Line 131: loc
  ```
  replace local_labor=3460006 if ao_kreis==3460
  ```
- Line 132: loc
  ```
  replace local_labor=3403000 if ao_kreis==3461
  ```
- Line 133: loc
  ```
  replace local_labor=3402000 if ao_kreis==3462
  ```
- Line 134: loc
  ```
  replace local_labor=4011000 if ao_kreis==4011
  ```
- Line 135: loc
  ```
  replace local_labor=4012000 if ao_kreis==4012
  ```
- Line 136: loc
  ```
  replace local_labor=5111000 if ao_kreis==5111
  ```
- Line 137: loc
  ```
  replace local_labor=5113000 if ao_kreis==5112
  ```
- Line 138: loc
  ```
  replace local_labor=5113000 if ao_kreis==5113
  ```
- Line 139: loc
  ```
  replace local_labor=5111000 if ao_kreis==5114
  ```
- Line 140: loc
  ```
  replace local_labor=5116000 if ao_kreis==5116
  ```
- Line 141: loc
  ```
  replace local_labor=5113000 if ao_kreis==5117
  ```
- Line 142: loc
  ```
  replace local_labor=5113000 if ao_kreis==5119
  ```
- Line 143: loc
  ```
  replace local_labor=5111000 if ao_kreis==5120
  ```
- Line 144: loc
  ```
  replace local_labor=5111000 if ao_kreis==5122
  ```
- Line 145: loc
  ```
  replace local_labor=5111000 if ao_kreis==5124
  ```
- Line 146: loc
  ```
  replace local_labor=5154036 if ao_kreis==5154
  ```
- Line 147: loc
  ```
  replace local_labor=5111000 if ao_kreis==5158
  ```
- Line 148: loc
  ```
  replace local_labor=5111000 if ao_kreis==5162
  ```
- Line 149: loc
  ```
  replace local_labor=5111000 if ao_kreis==5166
  ```
- Line 150: loc
  ```
  replace local_labor=5113000 if ao_kreis==5170
  ```
- Line 151: loc
  ```
  replace local_labor=5315000 if ao_kreis==5314
  ```
- Line 152: loc
  ```
  replace local_labor=5315000 if ao_kreis==5315
  ```
- Line 153: loc
  ```
  replace local_labor=5315000 if ao_kreis==5316
  ```
- Line 154: loc
  ```
  replace local_labor=5334002 if ao_kreis==5334
  ```
- Line 155: loc
  ```
  replace local_labor=5358008 if ao_kreis==5358
  ```
- Line 156: loc
  ```
  replace local_labor=5315000 if ao_kreis==5362
  ```
- Line 157: loc
  ```
  replace local_labor=5315000 if ao_kreis==5366
  ```
- Line 158: loc
  ```
  replace local_labor=5116000 if ao_kreis==5370
  ```
- Line 159: loc
  ```
  replace local_labor=5374012 if ao_kreis==5374
  ```
- Line 160: loc
  ```
  replace local_labor=5315000 if ao_kreis==5378
  ```
- Line 161: loc
  ```
  replace local_labor=5315000 if ao_kreis==5382
  ```
- Line 162: loc
  ```
  replace local_labor=5113000 if ao_kreis==5512
  ```
- Line 163: loc
  ```
  replace local_labor=5113000 if ao_kreis==5513
  ```
- Line 164: loc
  ```
  replace local_labor=5515000 if ao_kreis==5515
  ```
- Line 165: loc
  ```
  replace local_labor=5554020 if ao_kreis==5554
  ```
- Line 166: loc
  ```
  replace local_labor=5515000 if ao_kreis==5558
  ```
- Line 167: loc
  ```
  replace local_labor=5113000 if ao_kreis==5562
  ```
- Line 168: loc
  ```
  replace local_labor=5515000 if ao_kreis==5566
  ```
- Line 169: loc
  ```
  replace local_labor=5515000 if ao_kreis==5570
  ```
- Line 170: loc
  ```
  replace local_labor=5711000 if ao_kreis==5711
  ```
- Line 171: loc
  ```
  replace local_labor=5711000 if ao_kreis==5754
  ```
- Line 172: loc
  ```
  replace local_labor=5758004 if ao_kreis==5758
  ```
- Line 173: loc
  ```
  replace local_labor=5774032 if ao_kreis==5762
  ```
- Line 174: loc
  ```
  replace local_labor=5766020 if ao_kreis==5766
  ```
- Line 175: loc
  ```
  replace local_labor=5770024 if ao_kreis==5770
  ```
- Line 176: loc
  ```
  replace local_labor=5774032 if ao_kreis==5774
  ```
- Line 177: loc
  ```
  replace local_labor=5113000 if ao_kreis==5911
  ```
- Line 178: loc
  ```
  replace local_labor=5113000 if ao_kreis==5913
  ```
- Line 179: loc
  ```
  replace local_labor=5113000 if ao_kreis==5914
  ```
- Line 180: loc
  ```
  replace local_labor=5113000 if ao_kreis==5915
  ```
- Line 181: loc
  ```
  replace local_labor=5113000 if ao_kreis==5916
  ```
- Line 182: loc
  ```
  replace local_labor=5113000 if ao_kreis==5954
  ```
- Line 183: loc
  ```
  replace local_labor=5958004 if ao_kreis==5958
  ```
- Line 184: loc
  ```
  replace local_labor=5962032 if ao_kreis==5962
  ```
- Line 185: loc
  ```
  replace local_labor=5970040 if ao_kreis==5966
  ```
- Line 186: loc
  ```
  replace local_labor=5970040 if ao_kreis==5970
  ```
- Line 187: loc
  ```
  replace local_labor=5958004 if ao_kreis==5974
  ```
- Line 188: loc
  ```
  replace local_labor=5113000 if ao_kreis==5978
  ```
- Line 189: loc
  ```
  replace local_labor=6411000 if ao_kreis==6411
  ```
- Line 190: loc
  ```
  replace local_labor=6412000 if ao_kreis==6412
  ```
- Line 191: loc
  ```
  replace local_labor=6412000 if ao_kreis==6413
  ```
- Line 192: loc
  ```
  replace local_labor=6414000 if ao_kreis==6414
  ```
- Line 193: loc
  ```
  replace local_labor=8222000 if ao_kreis==6431
  ```
- Line 194: loc
  ```
  replace local_labor=6411000 if ao_kreis==6432
  ```
- Line 195: loc
  ```
  replace local_labor=6412000 if ao_kreis==6433
  ```
- Line 196: loc
  ```
  replace local_labor=6412000 if ao_kreis==6434
  ```
- Line 197: loc
  ```
  replace local_labor=6412000 if ao_kreis==6435
  ```
- Line 198: loc
  ```
  replace local_labor=6412000 if ao_kreis==6436
  ```
- Line 199: loc
  ```
  replace local_labor=6411000 if ao_kreis==6437
  ```
- Line 200: loc
  ```
  replace local_labor=6412000 if ao_kreis==6438
  ```
- Line 201: loc
  ```
  replace local_labor=6414000 if ao_kreis==6439
  ```
- Line 202: loc
  ```
  replace local_labor=6412000 if ao_kreis==6440
  ```
- Line 203: loc
  ```
  replace local_labor=6531005 if ao_kreis==6531
  ```
- Line 204: loc
  ```
  replace local_labor=6531005 if ao_kreis==6532
  ```
- Line 205: loc
  ```
  replace local_labor=6412000 if ao_kreis==6533
  ```
- Line 206: loc
  ```
  replace local_labor=6534014 if ao_kreis==6534
  ```
- Line 207: loc
  ```
  replace local_labor=6412000 if ao_kreis==6535
  ```
- Line 208: loc
  ```
  replace local_labor=6611000 if ao_kreis==6611
  ```
- Line 209: loc
  ```
  replace local_labor=6631009 if ao_kreis==6631
  ```
- Line 210: loc
  ```
  replace local_labor=6611000 if ao_kreis==6632
  ```
- Line 211: loc
  ```
  replace local_labor=6611000 if ao_kreis==6633
  ```
- Line 212: loc
  ```
  replace local_labor=6611000 if ao_kreis==6634
  ```
- Line 213: loc
  ```
  replace local_labor=6611000 if ao_kreis==6635
  ```
- Line 214: loc
  ```
  replace local_labor=6611000 if ao_kreis==6636
  ```
- Line 215: loc
  ```
  replace local_labor=7111000 if ao_kreis==7111
  ```
- Line 216: loc
  ```
  replace local_labor=5315000 if ao_kreis==7131
  ```
- Line 217: loc
  ```
  replace local_labor=5970040 if ao_kreis==7132
  ```
- Line 218: loc
  ```
  replace local_labor=6414000 if ao_kreis==7133
  ```
- Line 219: loc
  ```
  replace local_labor=6414000 if ao_kreis==7134
  ```
- Line 220: loc
  ```
  replace local_labor=7111000 if ao_kreis==7135
  ```
- Line 221: loc
  ```
  replace local_labor=7111000 if ao_kreis==7137
  ```
- Line 222: loc
  ```
  replace local_labor=7111000 if ao_kreis==7138
  ```
- Line 223: loc
  ```
  replace local_labor=7111000 if ao_kreis==7140
  ```
- Line 224: loc
  ```
  replace local_labor=6412000 if ao_kreis==7141
  ```
- Line 225: loc
  ```
  replace local_labor=7111000 if ao_kreis==7143
  ```
- Line 226: loc
  ```
  replace local_labor=7211000 if ao_kreis==7211
  ```
- Line 227: loc
  ```
  replace local_labor=7211000 if ao_kreis==7231
  ```
- Line 228: loc
  ```
  replace local_labor=7211000 if ao_kreis==7232
  ```
- Line 229: loc
  ```
  replace local_labor=7211000 if ao_kreis==7233
  ```
- Line 230: loc
  ```
  replace local_labor=7211000 if ao_kreis==7235
  ```
- Line 231: loc
  ```
  replace local_labor=8222000 if ao_kreis==7311
  ```
- Line 232: loc
  ```
  replace local_labor=7312000 if ao_kreis==7312
  ```
- Line 233: loc
  ```
  replace local_labor=7316000 if ao_kreis==7313
  ```
- Line 234: loc
  ```
  replace local_labor=8222000 if ao_kreis==7314
  ```
- Line 235: loc
  ```
  replace local_labor=6414000 if ao_kreis==7315
  ```
- Line 236: loc
  ```
  replace local_labor=7316000 if ao_kreis==7316
  ```
- Line 237: loc
  ```
  replace local_labor=10045114 if ao_kreis==7317
  ```
- Line 238: loc
  ```
  replace local_labor=8222000 if ao_kreis==7318
  ```
- Line 239: loc
  ```
  replace local_labor=8222000 if ao_kreis==7319
  ```
- Line 240: loc
  ```
  replace local_labor=10045114 if ao_kreis==7320
  ```
- Line 241: loc
  ```
  replace local_labor=6414000 if ao_kreis==7331
  ```
- Line 242: loc
  ```
  replace local_labor=8222000 if ao_kreis==7332
  ```
- Line 243: loc
  ```
  replace local_labor=8222000 if ao_kreis==7333
  ```
- Line 244: loc
  ```
  replace local_labor=7316000 if ao_kreis==7334
  ```
- Line 245: loc
  ```
  replace local_labor=7312000 if ao_kreis==7335
  ```
- Line 246: loc
  ```
  replace local_labor=7312000 if ao_kreis==7336
  ```
- Line 247: loc
  ```
  replace local_labor=7316000 if ao_kreis==7337
  ```
- Line 248: loc
  ```
  replace local_labor=8222000 if ao_kreis==7338
  ```
- Line 249: loc
  ```
  replace local_labor=6414000 if ao_kreis==7339
  ```
- Line 250: loc
  ```
  replace local_labor=10045114 if ao_kreis==7340
  ```
- Line 251: loc
  ```
  replace local_labor=8111000 if ao_kreis==8111
  ```
- Line 252: loc
  ```
  replace local_labor=8111000 if ao_kreis==8115
  ```
- Line 253: loc
  ```
  replace local_labor=8111000 if ao_kreis==8116
  ```
- Line 254: loc
  ```
  replace local_labor=8117026 if ao_kreis==8117
  ```
- Line 255: loc
  ```
  replace local_labor=8111000 if ao_kreis==8118
  ```
- Line 256: loc
  ```
  replace local_labor=8111000 if ao_kreis==8119
  ```
- Line 257: loc
  ```
  replace local_labor=8121000 if ao_kreis==8121
  ```
- Line 258: loc
  ```
  replace local_labor=8121000 if ao_kreis==8125
  ```
- Line 259: loc
  ```
  replace local_labor=8121000 if ao_kreis==8126
  ```
- Line 260: loc
  ```
  replace local_labor=8127076 if ao_kreis==8127
  ```
- Line 261: loc
  ```
  replace local_labor=8127076 if ao_kreis==8128
  ```
- Line 262: loc
  ```
  replace local_labor=8136088 if ao_kreis==8135
  ```
- Line 263: loc
  ```
  replace local_labor=8136088 if ao_kreis==8136
  ```
- Line 264: loc
  ```
  replace local_labor=8212000 if ao_kreis==8211
  ```
- Line 265: loc
  ```
  replace local_labor=8212000 if ao_kreis==8212
  ```
- Line 266: loc
  ```
  replace local_labor=8212000 if ao_kreis==8215
  ```
- Line 267: loc
  ```
  replace local_labor=8212000 if ao_kreis==8216
  ```
- Line 268: loc
  ```
  replace local_labor=8222000 if ao_kreis==8221
  ```
- Line 269: loc
  ```
  replace local_labor=8222000 if ao_kreis==8222
  ```
- Line 270: loc
  ```
  replace local_labor=8121000 if ao_kreis==8225
  ```
- Line 271: loc
  ```
  replace local_labor=8222000 if ao_kreis==8226
  ```
- Line 272: loc
  ```
  replace local_labor=8231000 if ao_kreis==8231
  ```
- Line 273: loc
  ```
  replace local_labor=8111000 if ao_kreis==8235
  ```
- Line 274: loc
  ```
  replace local_labor=8231000 if ao_kreis==8236
  ```
- Line 275: loc
  ```
  replace local_labor=8111000 if ao_kreis==8237
  ```
- Line 276: loc
  ```
  replace local_labor=8311000 if ao_kreis==8311
  ```
- Line 277: loc
  ```
  replace local_labor=8311000 if ao_kreis==8315
  ```
- Line 278: loc
  ```
  replace local_labor=8311000 if ao_kreis==8316
  ```
- Line 279: loc
  ```
  replace local_labor=8317096 if ao_kreis==8317
  ```
- Line 280: loc
  ```
  replace local_labor=8326074 if ao_kreis==8325
  ```
- Line 281: loc
  ```
  replace local_labor=8326074 if ao_kreis==8326
  ```
- Line 282: loc
  ```
  replace local_labor=8326074 if ao_kreis==8327
  ```
- Line 283: loc
  ```
  replace local_labor=8335075 if ao_kreis==8335
  ```
- Line 284: loc
  ```
  replace local_labor=8336050 if ao_kreis==8336
  ```
- Line 285: loc
  ```
  replace local_labor=8336050 if ao_kreis==8337
  ```
- Line 286: loc
  ```
  replace local_labor=8415061 if ao_kreis==8415
  ```
- Line 287: loc
  ```
  replace local_labor=8111000 if ao_kreis==8416
  ```
- Line 288: loc
  ```
  replace local_labor=8417079 if ao_kreis==8417
  ```
- Line 289: loc
  ```
  replace local_labor=8421000 if ao_kreis==8421
  ```
- Line 290: loc
  ```
  replace local_labor=8421000 if ao_kreis==8425
  ```
- Line 291: loc
  ```
  replace local_labor=8421000 if ao_kreis==8426
  ```
- Line 292: loc
  ```
  replace local_labor=8435016 if ao_kreis==8435
  ```
- Line 293: loc
  ```
  replace local_labor=8436064 if ao_kreis==8436
  ```
- Line 294: loc
  ```
  replace local_labor=8421000 if ao_kreis==8437
  ```
- Line 295: loc
  ```
  replace local_labor=9161000 if ao_kreis==9161
  ```
- Line 296: loc
  ```
  replace local_labor=9162000 if ao_kreis==9162
  ```
- Line 297: loc
  ```
  replace local_labor=9162000 if ao_kreis==9163
  ```
- Line 298: loc
  ```
  replace local_labor=9171112 if ao_kreis==9171
  ```
- Line 299: loc
  ```
  replace local_labor=9189155 if ao_kreis==9172
  ```
- Line 300: loc
  ```
  replace local_labor=9162000 if ao_kreis==9173
  ```
- Line 301: loc
  ```
  replace local_labor=9162000 if ao_kreis==9174
  ```
- Line 302: loc
  ```
  replace local_labor=9162000 if ao_kreis==9175
  ```
- Line 303: loc
  ```
  replace local_labor=9161000 if ao_kreis==9176
  ```
- Line 304: loc
  ```
  replace local_labor=9162000 if ao_kreis==9177
  ```
- Line 305: loc
  ```
  replace local_labor=9162000 if ao_kreis==9178
  ```
- Line 306: loc
  ```
  replace local_labor=9162000 if ao_kreis==9179
  ```
- Line 307: loc
  ```
  replace local_labor=9162000 if ao_kreis==9180
  ```
- Line 308: loc
  ```
  replace local_labor=9162000 if ao_kreis==9181
  ```
- Line 309: loc
  ```
  replace local_labor=9162000 if ao_kreis==9182
  ```
- Line 310: loc
  ```
  replace local_labor=9162000 if ao_kreis==9183
  ```
- Line 311: loc
  ```
  replace local_labor=9162000 if ao_kreis==9184
  ```
- Line 312: loc
  ```
  replace local_labor=9161000 if ao_kreis==9185
  ```
- Line 313: loc
  ```
  replace local_labor=9161000 if ao_kreis==9186
  ```
- Line 314: loc
  ```
  replace local_labor=9162000 if ao_kreis==9187
  ```
- Line 315: loc
  ```
  replace local_labor=9162000 if ao_kreis==9188
  ```
- Line 316: loc
  ```
  replace local_labor=9189155 if ao_kreis==9189
  ```
- Line 317: loc
  ```
  replace local_labor=9162000 if ao_kreis==9190
  ```
- Line 318: loc
  ```
  replace local_labor=9261000 if ao_kreis==9261
  ```
- Line 319: loc
  ```
  replace local_labor=9262000 if ao_kreis==9262
  ```
- Line 320: loc
  ```
  replace local_labor=9362000 if ao_kreis==9263
  ```
- Line 321: loc
  ```
  replace local_labor=9271119 if ao_kreis==9271
  ```
- Line 322: loc
  ```
  replace local_labor=9262000 if ao_kreis==9272
  ```
- Line 323: loc
  ```
  replace local_labor=9161000 if ao_kreis==9273
  ```
- Line 324: loc
  ```
  replace local_labor=9261000 if ao_kreis==9274
  ```
- Line 325: loc
  ```
  replace local_labor=9262000 if ao_kreis==9275
  ```
- Line 326: loc
  ```
  replace local_labor=9271119 if ao_kreis==9276
  ```
- Line 327: loc
  ```
  replace local_labor=9171112 if ao_kreis==9277
  ```
- Line 328: loc
  ```
  replace local_labor=9362000 if ao_kreis==9278
  ```
- Line 329: loc
  ```
  replace local_labor=9261000 if ao_kreis==9279
  ```
- Line 330: loc
  ```
  replace local_labor=9564000 if ao_kreis==9361
  ```
- Line 331: loc
  ```
  replace local_labor=9362000 if ao_kreis==9362
  ```
- Line 332: loc
  ```
  replace local_labor=9363000 if ao_kreis==9363
  ```
- Line 333: loc
  ```
  replace local_labor=9564000 if ao_kreis==9371
  ```
- Line 334: loc
  ```
  replace local_labor=9362000 if ao_kreis==9372
  ```
- Line 335: loc
  ```
  replace local_labor=9564000 if ao_kreis==9373
  ```
- Line 336: loc
  ```
  replace local_labor=9363000 if ao_kreis==9374
  ```
- Line 337: loc
  ```
  replace local_labor=9362000 if ao_kreis==9375
  ```
- Line 338: loc
  ```
  replace local_labor=9362000 if ao_kreis==9376
  ```
- Line 339: loc
  ```
  replace local_labor=9479136 if ao_kreis==9377
  ```
- Line 340: loc
  ```
  replace local_labor=9461000 if ao_kreis==9461
  ```
- Line 341: loc
  ```
  replace local_labor=9462000 if ao_kreis==9462
  ```
- Line 342: loc
  ```
  replace local_labor=9463000 if ao_kreis==9463
  ```
- Line 343: loc
  ```
  replace local_labor=9464000 if ao_kreis==9464
  ```
- Line 344: loc
  ```
  replace local_labor=9461000 if ao_kreis==9471
  ```
- Line 345: loc
  ```
  replace local_labor=9462000 if ao_kreis==9472
  ```
- Line 346: loc
  ```
  replace local_labor=9463000 if ao_kreis==9473
  ```
- Line 347: loc
  ```
  replace local_labor=9564000 if ao_kreis==9474
  ```
- Line 348: loc
  ```
  replace local_labor=9464000 if ao_kreis==9475
  ```
- Line 349: loc
  ```
  replace local_labor=9463000 if ao_kreis==9476
  ```
- Line 350: loc
  ```
  replace local_labor=9462000 if ao_kreis==9477
  ```
- Line 351: loc
  ```
  replace local_labor=9463000 if ao_kreis==9478
  ```
- Line 352: loc
  ```
  replace local_labor=9479136 if ao_kreis==9479
  ```
- Line 353: loc
  ```
  replace local_labor=9564000 if ao_kreis==9561
  ```
- Line 354: loc
  ```
  replace local_labor=9564000 if ao_kreis==9562
  ```
- Line 355: loc
  ```
  replace local_labor=9564000 if ao_kreis==9563
  ```
- Line 356: loc
  ```
  replace local_labor=9564000 if ao_kreis==9564
  ```
- Line 357: loc
  ```
  replace local_labor=9564000 if ao_kreis==9565
  ```
- Line 358: loc
  ```
  replace local_labor=9564000 if ao_kreis==9571
  ```
- Line 359: loc
  ```
  replace local_labor=9564000 if ao_kreis==9572
  ```
- Line 360: loc
  ```
  replace local_labor=9564000 if ao_kreis==9573
  ```
- Line 361: loc
  ```
  replace local_labor=9564000 if ao_kreis==9574
  ```
- Line 362: loc
  ```
  replace local_labor=9564000 if ao_kreis==9575
  ```
- Line 363: loc
  ```
  replace local_labor=9564000 if ao_kreis==9576
  ```
- Line 364: loc
  ```
  replace local_labor=9564000 if ao_kreis==9577
  ```
- Line 365: loc
  ```
  replace local_labor=9661000 if ao_kreis==9661
  ```
- Line 366: loc
  ```
  replace local_labor=9662000 if ao_kreis==9662
  ```
- Line 367: loc
  ```
  replace local_labor=9663000 if ao_kreis==9663
  ```
- Line 368: loc
  ```
  replace local_labor=9661000 if ao_kreis==9671
  ```
- Line 369: loc
  ```
  replace local_labor=9662000 if ao_kreis==9672
  ```
- Line 370: loc
  ```
  replace local_labor=9662000 if ao_kreis==9673
  ```
- Line 371: loc
  ```
  replace local_labor=9662000 if ao_kreis==9674
  ```
- Line 372: loc
  ```
  replace local_labor=9663000 if ao_kreis==9675
  ```
- Line 373: loc
  ```
  replace local_labor=9661000 if ao_kreis==9676
  ```
- Line 374: loc
  ```
  replace local_labor=9663000 if ao_kreis==9677
  ```
- Line 375: loc
  ```
  replace local_labor=9662000 if ao_kreis==9678
  ```
- Line 376: loc
  ```
  replace local_labor=9663000 if ao_kreis==9679
  ```
- Line 377: loc
  ```
  replace local_labor=9761000 if ao_kreis==9761
  ```
- Line 378: loc
  ```
  replace local_labor=9162000 if ao_kreis==9762
  ```
- Line 379: loc
  ```
  replace local_labor=9763000 if ao_kreis==9763
  ```
- Line 380: loc
  ```
  replace local_labor=9764000 if ao_kreis==9764
  ```
- Line 381: loc
  ```
  replace local_labor=9761000 if ao_kreis==9771
  ```
- Line 382: loc
  ```
  replace local_labor=9761000 if ao_kreis==9772
  ```
- Line 383: loc
  ```
  replace local_labor=9761000 if ao_kreis==9773
  ```
- Line 384: loc
  ```
  replace local_labor=9761000 if ao_kreis==9774
  ```
- Line 385: loc
  ```
  replace local_labor=8421000 if ao_kreis==9775
  ```
- Line 386: loc
  ```
  replace local_labor=8436064 if ao_kreis==9776
  ```
- Line 387: loc
  ```
  replace local_labor=9162000 if ao_kreis==9777
  ```
- Line 388: loc
  ```
  replace local_labor=9764000 if ao_kreis==9778
  ```
- Line 389: loc
  ```
  replace local_labor=9761000 if ao_kreis==9779
  ```
- Line 390: loc
  ```
  replace local_labor=9763000 if ao_kreis==9780
  ```
- Line 391: loc
  ```
  replace local_labor=10041100 if ao_kreis==10041
  ```
- Line 392: loc
  ```
  replace local_labor=10041100 if ao_kreis==10042
  ```
- Line 393: loc
  ```
  replace local_labor=10041100 if ao_kreis==10043
  ```
- Line 394: loc
  ```
  replace local_labor=10041100 if ao_kreis==10044
  ```
- Line 395: loc
  ```
  replace local_labor=10045114 if ao_kreis==10045
  ```
- Line 396: loc
  ```
  replace local_labor=10041100 if ao_kreis==10046
  ```
- Line 397: loc
  ```
  replace local_labor=11000000 if ao_kreis==11000
  ```
- Line 398: loc
  ```
  replace local_labor=11000000 if ao_kreis==12051
  ```
- Line 399: loc
  ```
  replace local_labor=12052000 if ao_kreis==12052
  ```
- Line 400: loc
  ```
  replace local_labor=11000000 if ao_kreis==12053
  ```
- Line 401: loc
  ```
  replace local_labor=11000000 if ao_kreis==12054
  ```
- Line 402: loc
  ```
  replace local_labor=11000000 if ao_kreis==12060
  ```
- Line 403: loc
  ```
  replace local_labor=11000000 if ao_kreis==12061
  ```
- Line 404: loc
  ```
  replace local_labor=12052000 if ao_kreis==12062
  ```
- Line 405: loc
  ```
  replace local_labor=11000000 if ao_kreis==12063
  ```
- Line 406: loc
  ```
  replace local_labor=11000000 if ao_kreis==12064
  ```
- Line 407: loc
  ```
  replace local_labor=11000000 if ao_kreis==12065
  ```
- Line 408: loc
  ```
  replace local_labor=12052000 if ao_kreis==12066
  ```
- Line 409: loc
  ```
  replace local_labor=11000000 if ao_kreis==12067
  ```
- Line 410: loc
  ```
  replace local_labor=11000000 if ao_kreis==12068
  ```
- Line 411: loc
  ```
  replace local_labor=11000000 if ao_kreis==12069
  ```
- Line 412: loc
  ```
  replace local_labor=11000000 if ao_kreis==12070
  ```
- Line 413: loc
  ```
  replace local_labor=12052000 if ao_kreis==12071
  ```
- Line 414: loc
  ```
  replace local_labor=11000000 if ao_kreis==12072
  ```
- Line 415: loc
  ```
  replace local_labor=11000000 if ao_kreis==12073
  ```
- Line 416: loc
  ```
  replace local_labor=13003000 if ao_kreis==13003
  ```
- Line 417: loc
  ```
  replace local_labor=13004000 if ao_kreis==13004
  ```
- Line 418: loc
  ```
  replace local_labor=13071107 if ao_kreis==13071
  ```
- Line 419: loc
  ```
  replace local_labor=13003000 if ao_kreis==13072
  ```
- Line 420: loc
  ```
  replace local_labor=13075039 if ao_kreis==13073
  ```
- Line 421: loc
  ```
  replace local_labor=13004000 if ao_kreis==13074
  ```
- Line 422: loc
  ```
  replace local_labor=13075039 if ao_kreis==13075
  ```
- Line 423: loc
  ```
  replace local_labor=13004000 if ao_kreis==13076
  ```
- Line 424: loc
  ```
  replace local_labor=14511000 if ao_kreis==14511
  ```
- Line 425: loc
  ```
  replace local_labor=14511000 if ao_kreis==14521
  ```
- Line 426: loc
  ```
  replace local_labor=14511000 if ao_kreis==14522
  ```
- Line 427: loc
  ```
  replace local_labor=14523320 if ao_kreis==14523
  ```
- Line 428: loc
  ```
  replace local_labor=14524330 if ao_kreis==14524
  ```
- Line 429: loc
  ```
  replace local_labor=14612000 if ao_kreis==14612
  ```
- Line 430: loc
  ```
  replace local_labor=14612000 if ao_kreis==14625
  ```
- Line 431: loc
  ```
  replace local_labor=14612000 if ao_kreis==14626
  ```
- Line 432: loc
  ```
  replace local_labor=14612000 if ao_kreis==14627
  ```
- Line 433: loc
  ```
  replace local_labor=14612000 if ao_kreis==14628
  ```
- Line 434: loc
  ```
  replace local_labor=14713000 if ao_kreis==14713
  ```
- Line 435: loc
  ```
  replace local_labor=14713000 if ao_kreis==14729
  ```
- Line 436: loc
  ```
  replace local_labor=14713000 if ao_kreis==14730
  ```
- Line 437: loc
  ```
  replace local_labor=15001000 if ao_kreis==15001
  ```
- Line 438: loc
  ```
  replace local_labor=15002000 if ao_kreis==15002
  ```
- Line 439: loc
  ```
  replace local_labor=15003000 if ao_kreis==15003
  ```
- Line 440: loc
  ```
  replace local_labor=15003000 if ao_kreis==15081
  ```
- Line 441: loc
  ```
  replace local_labor=15001000 if ao_kreis==15082
  ```
- Line 442: loc
  ```
  replace local_labor=15003000 if ao_kreis==15083
  ```
- Line 443: loc
  ```
  replace local_labor=15002000 if ao_kreis==15084
  ```
- Line 444: loc
  ```
  replace local_labor=15085370 if ao_kreis==15085
  ```
- Line 445: loc
  ```
  replace local_labor=15003000 if ao_kreis==15086
  ```
- Line 446: loc
  ```
  replace local_labor=15002000 if ao_kreis==15087
  ```
- Line 447: loc
  ```
  replace local_labor=15002000 if ao_kreis==15088
  ```
- Line 448: loc
  ```
  replace local_labor=15003000 if ao_kreis==15089
  ```
- Line 449: loc
  ```
  replace local_labor=15003000 if ao_kreis==15090
  ```
- Line 450: loc
  ```
  replace local_labor=15001000 if ao_kreis==15091
  ```
- Line 451: loc
  ```
  replace local_labor=16051000 if ao_kreis==16051
  ```
- Line 452: loc
  ```
  replace local_labor=16052000 if ao_kreis==16052
  ```
- Line 453: loc
  ```
  replace local_labor=16053000 if ao_kreis==16053
  ```
- Line 454: loc
  ```
  replace local_labor=16054000 if ao_kreis==16054
  ```
- Line 455: loc
  ```
  replace local_labor=16051000 if ao_kreis==16055
  ```
- Line 456: loc
  ```
  replace local_labor=16051000 if ao_kreis==16056
  ```
- Line 457: loc
  ```
  replace local_labor=3152012 if ao_kreis==16061
  ```
- Line 458: loc
  ```
  replace local_labor=3152012 if ao_kreis==16062
  ```
- Line 459: loc
  ```
  replace local_labor=16051000 if ao_kreis==16063
  ```
- Line 460: loc
  ```
  replace local_labor=16051000 if ao_kreis==16064
  ```
- Line 461: loc
  ```
  replace local_labor=16051000 if ao_kreis==16065
  ```
- Line 462: loc
  ```
  replace local_labor=16054000 if ao_kreis==16066
  ```
- Line 463: loc
  ```
  replace local_labor=16051000 if ao_kreis==16067
  ```
- Line 464: loc
  ```
  replace local_labor=16051000 if ao_kreis==16068
  ```
- Line 465: loc
  ```
  replace local_labor=16054000 if ao_kreis==16069
  ```
- Line 466: loc
  ```
  replace local_labor=16051000 if ao_kreis==16070
  ```
- Line 467: loc
  ```
  replace local_labor=16051000 if ao_kreis==16071
  ```
- Line 468: loc
  ```
  replace local_labor=9463000 if ao_kreis==16072
  ```
- Line 469: loc
  ```
  replace local_labor=16051000 if ao_kreis==16073
  ```
- Line 470: loc
  ```
  replace local_labor=16053000 if ao_kreis==16074
  ```
- Line 471: loc
  ```
  replace local_labor=16051000 if ao_kreis==16075
  ```
- Line 472: loc
  ```
  replace local_labor=16052000 if ao_kreis==16076
  ```
- Line 473: loc
  ```
  replace local_labor=14713000 if ao_kreis==16077
  ```
- Line 475: loc
  ```
  * Verify that every Kreis in the SIEED sample has been assigned to a local
  ```
- Line 477: loc
  ```
  sum if local_labor==.
  ```
- Line 480: loc
  ```
  save "${data}/local_labor_market.dta", replace
  ```

**/replication-package/Brinatti_Morales_Replication_Package/sieed_analysis/prog/1c_create_data_figA7.do**

- Line 83: lat
  ```
  *Calculate tenure at firm
  ```
- Line 95: name
  ```
  rename college1 college
  ```
- Line 137: lon
  ```
  *Some cases remaining where we just count them as german as long as they report german for at least 
  ```
- Line 166: lat
  ```
  * picture of the size-immigrant share relationship before and after 2011.
  ```
- Line 173: name
  ```
  rename nation_single nation
  ```
- Line 192: lat
  ```
  replace nation_grouped=14 if (nation>=320 & nation<=347) | (nation>=349 & nation<=367)  | (nation>=3
  ```
- Line 200: lat
  ```
  label define nation_grouped 0 "0 Germany" 1 "1 EU High Income" 2 "2 EU Middle Income" 3 "3 EU 2004" 
  ```
- Line 268: district
  ```
  * and district identifier (ao_kreis), used to define the size bins in Figure A7.
  ```

**/replication-package/Brinatti_Morales_Replication_Package/sieed_analysis/prog/2a_results_event_studies.do**

- Line 31: loc
  ```
  *   ${data}/local_labor_market.dta      - Kreis-to-local labor market crosswalk
  ```
- Line 71: lon
  ```
  reshape long emp_ emp_new_hire_ emp_new_ent_ charact_college_ charact_frau_ charact_age_, i(betnr ja
  ```
- Line 108: name
  ```
  rename ind_2dig_aux ind_2dig
  ```
- Line 112: loc
  ```
  * Merge the local labor market crosswalk (created in 1b) to construct
  ```
- Line 113: loc
  ```
  * local labor market x year fixed effects (local_labor_time).
  ```
- Line 119: loc, name
  ```
  rename local_labor local_labor11
  ```
- Line 125: district
  ```
  * district_time = district x year FE (additional geography control)
  ```
- Line 128: loc
  ```
  egen local_labor_time 	= group(local_labor11 jahr)
  ```
- Line 129: loc
  ```
  egen industry_local_time=group(ind_2dig ao_kreis jahr)
  ```
- Line 130: district
  ```
  egen district_time 		= group(ao_kreis jahr)
  ```
- Line 136: lat
  ```
  * (employment_relative = emp_ / emp_tot_2010) as in equation (1).
  ```
- Line 145: lat
  ```
  *   employment_relative     : NMS (or control) employment / base-year total emp
  ```
- Line 150: lat
  ```
  gen employment_relative=emp_/emp_tot_2010
  ```
- Line 156: lat
  ```
  gen employment_relative_new=emp_new_hire_/emp_tot_2010
  ```
- Line 157: lat
  ```
  gen employment_relative_new06=emp_new_hire_/emp_tot_2006
  ```
- Line 163: lat
  ```
  gen employment_relative_ent=emp_new_ent_/emp_tot_2010
  ```
- Line 164: lat
  ```
  gen employment_relative_ent06=emp_new_ent_/emp_tot_2006
  ```
- Line 253: lat
  ```
  * 2011 and that pre-trends are flat. Output is stored in eststo y2 and
  ```
- Line 259: lat
  ```
  quietly reghdfe employment_relative treat_2006 treat_2007 treat_2008 treat_2009 treat_2011 treat_201
  ```
- Line 279: lat
  ```
  quietly reghdfe employment_relative treat_2006 treat_2007 treat_2008 treat_2009 treat_2011 treat_201
  ```
- Line 288: lat
  ```
  *Calculate standard error of coefficients for Figure 2
  ```
- Line 294: lat
  ```
  quietly reghdfe employment_relative treat_2006 treat_2007 treat_2008 treat_2009 treat_2011 treat_201
  ```
- Line 296: loc
  ```
  local nobs=e(N)
  ```
- Line 300: lat
  ```
  dis "Number of observations used in calculation below: `nobs'"
  ```
- Line 321: lat
  ```
  * Panel 1 (relative to the largest group, bsize_4):
  ```
- Line 326: lat
  ```
  * Panel 2 (relative to the bottom three groups):
  ```
- Line 337: loc
  ```
  local i=1
  ```
- Line 339: lat
  ```
  foreach outcome in employment_relative employment_relative_new employment_relative_ent  imm_share {
  ```
- Line 344: loc
  ```
  local i=`i'+1
  ```
- Line 354: loc
  ```
  local i=1
  ```
- Line 356: lat
  ```
  foreach outcome in employment_relative employment_relative_new employment_relative_ent  imm_share {
  ```
- Line 361: loc
  ```
  local i=`i'+1
  ```
- Line 383: loc
  ```
  local i=1
  ```
- Line 387: lat
  ```
  quietly reghdfe employment_relative post_treat  post_4 post_treat_4 if jahr>=2006 & emp_tot_2010!=. 
  ```
- Line 390: loc
  ```
  local i=`i'+1
  ```
- Line 406: loc
  ```
  *   Column 2: firm_origin + industry_time + local_labor_time
  ```
- Line 408: loc
  ```
  *              and local labor market-year FE)
  ```
- Line 417: loc
  ```
  local i=1
  ```
- Line 419: loc
  ```
  foreach fixed in "firm_origin firm_time"  "firm_origin industry_time local_labor_time" "firm_origin 
  ```
- Line 421: lat
  ```
  quietly reghdfe employment_relative post_treat  post_4 post_treat_4 if jahr>=2006 & emp_tot_2010!=. 
  ```
- Line 424: loc
  ```
  local i=`i'+1
  ```

**/replication-package/Brinatti_Morales_Replication_Package/sieed_analysis/prog/2b_results_figA7.do**

- Line 21: loc
  ```
  *   ${data}/local_labor_market.dta      - Kreis-to-local labor market crosswalk
  ```
- Line 49: loc
  ```
  * Merge in the local labor market crosswalk (used to verify geographic coverage;
  ```
- Line 57: loc, name
  ```
  rename local_labor local_labor11
  ```
- Line 59: loc
  ```
  * Construct industry x year and local labor market x year fixed effect groups
  ```
- Line 60: lat
  ```
  * (available for robustness; not used directly in the Figure A7 tabulations).
  ```
- Line 62: loc
  ```
  egen local_labor_time 	= group(local_labor11 jahr)
  ```
- Line 63: loc
  ```
  egen industry_local_time=group(w93_3_gen ao_kreis jahr)
  ```
- Line 155: loc
  ```
  local ntot=200
  ```

**/replication-package/Brinatti_Morales_Replication_Package/sieed_analysis/prog/2c_results_figA5.do**

- Line 58: name
  ```
  * Rename key variables to shorter names for convenience.
  ```
- Line 59: name
  ```
  rename emp_tot nemp_ft
  ```
- Line 60: name
  ```
  rename emp_imm nemp_imm_ft
  ```
- Line 61: name
  ```
  rename emp_new_hire_imm nhir_imm_ft
  ```
- Line 62: name
  ```
  rename emp_new_hire_nat	nhir_nat_ft
  ```
- Line 63: name
  ```
  rename wbill_new_hire_imm whir_imm_ft
  ```
- Line 64: name
  ```
  rename wbill_new_hire_nat whir_nat_ft
  ```
- Line 74: lat
  ```
  *                  1 = one period later, etc.)
  ```

**/replication-package/Brinatti_Morales_Replication_Package/sieed_analysis/prog/master.do**

- Line 13: country
  ```
  * contains workers' country of citizenship at the individual level.
  ```
- Line 56: district, loc
  ```
  * 1b: Map German administrative districts (Kreise) to functional local labor
  ```
- Line 59: loc
  ```
  do "${prog}/1b_add_local_labor_market.do"
  ```
- Line 73: lat
  ```
  *     NMS nationals relative to other European non-EU nationals by firm size,
  ```

