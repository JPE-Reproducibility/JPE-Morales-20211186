********************************************************************************
* Replication Package for:
* "Firm Heterogeneity and the Impact of Immigration:
*  Evidence from German Establishments"
* Agostina Brinatti and Nicolas Morales
* Journal of Political Economy
*
* SIEED Analysis Master File
*
* This master do-file runs all programs that use the Sample of Integrated
* Employer-Employee Data (SIEED). The SIEED is used (rather than the LIAB)
* for the EU enlargement analysis because it covers post-2011 years and
* contains workers' country of citizenship at the individual level.
* See Section 3.3.2 and Appendix A.5 of the paper for details.
*
* Outputs produced by this master file:
*   - Figure 2:       Event study evidence of fixed costs (large vs. small firms)
*   - Appendix Figure A5:  Hiring dynamics after first immigrant hire
*   - Appendix Figure A7:  Immigrant share before and after the EU enlargement
*   - Appendix Figure A8:  Baseline event study (pooled firms)
*   - Appendix Table A3:   Alternative outcomes and size breakdowns
*   - Appendix Table A4:   Robustness to alternative samples
*   - Appendix Table A5:   Robustness to alternative fixed effects
*
* REQUIRED GLOBAL MACROS (set before running this file):
*   ${prog}  - path to the directory containing all do-files
*   ${orig}  - path to the raw SIEED data files
*   ${data}  - path for intermediate datasets created by this code
*   ${log}   - path for log files
*
* Data source:
*   SIEED (Sample of Integrated Employer-Employee Data), version 7518 v1.
*   Accessed via the IAB Research Data Centre (FDZ).
********************************************************************************

clear all
set more off
set linesize 255
set matsize 5000


cap adopath++ ${prog}

capture log close


*-------------------------------------------------------------------------------
* STEP 1: Build analysis datasets from raw SIEED data
*-------------------------------------------------------------------------------

* 1a: Construct individual- and firm-level panel from raw job-spell data.
*     Defines immigrants, assigns consistent citizenship, and collapses to
*     firm-year level. Used for the event study (Figure 2, Figure A8, Tables A3-A5).
do "${prog}/1a_create_data_event_study.do"

* 1b: Map German administrative districts (Kreise) to functional local labor
*     market areas following Kropp and Schwengler (2011). Used as a geographic
*     fixed effect in the event study regressions.
do "${prog}/1b_add_local_labor_market.do"

* 1c: Construct a separate firm-year panel for Figure A7, which plots the
*     immigrant share by establishment size before and after the 2011
*     EU enlargement.
do "${prog}/1c_create_data_figA7.do"


*-------------------------------------------------------------------------------
* STEP 2: Produce results
*-------------------------------------------------------------------------------

* 2a: Event study regressions for Figure 2, Appendix Figure A8, and
*     Appendix Tables A3-A5. Estimates the differential hiring response of
*     NMS nationals relative to other European non-EU nationals by firm size,
*     exploiting the 2011 opening of the German labor market to EU New Member
*     State (NMS) citizens.
do "${prog}/2a_results_event_studies.do"

* 2b: Produces Appendix Figure A7 (immigrant share by size bin, pre- vs.
*     post-2011) with 200-repetition bootstrap standard errors.
do "${prog}/2b_results_figA7.do"

* 2c: Produces Appendix Figure A5 (lumpiness of immigrant hiring at the
*     extensive margin). Tracks new immigrant hires and immigrant share among
*     new hires in the periods following a firm's first immigrant hire.
do "${prog}/2c_results_figA5.do"
