## Potential Personal Identifiable Information (PII)

⚠️ We found the following instances of potentially personally identifying information. This may be completely legitimate but might be worth checking. *As a reminder, privacy legislation in many countries (e.g. GDPR in EU) prohibits the dissemination of personal identifiable information without prior (and documented) consent of individuals.* If indeed you want to publish such information with your replication package, you should probably have obtained IRB approval for this - please check!

**Summary:**

- Data files with PII indicators: 0
- Variables flagged in data: 0
- Code files with PII references: 85
- PII references in code: 1409

### Summary of Flagged Files

| File Type | File | Variables/References | PII Categories |
|-----------|------|----------------------|----------------|
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

*See [Appendix](report-pii-appendix.md) for detailed listing of all flagged instances.*
