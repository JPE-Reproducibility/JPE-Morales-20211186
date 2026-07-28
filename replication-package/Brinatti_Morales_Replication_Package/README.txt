================================================================================
README — Replication Package
Data and Code for: "Firm Heterogeneity and the Impact of Immigration: Evidence from German Establishments"
Agostina Brinatti, University of Chicago 
Nicolas Morales, Federal Reserve Bank of Richmond
July, 2026


Journal of Political Economy
================================================================================

This README documents the replication package. It follows the AEA Data and Code
Availability Standard. It explains (1) what each folder contains, (2) where the
data come from and which parts can be shared, (3) the software and packages
required, (4) how to run the code, and (5) which program produces each table and
figure in the paper.

--------------------------------------------------------------------------------
0. PACKAGE CONTENTS AT A GLANCE
--------------------------------------------------------------------------------

The package has four top-level folders:

  calibration_external/   A standalone Stata do-file that compute external
                          calibration moment for the Cobb Douglas share of consumption from public data (World Bank, WIOD).
                          

  liab_analysis/          Stata pipeline (1 master.do + 19 do-files) plus two
                          MATLAB files. Builds the firm- and worker-level samples
                          from the LIAB / IAB Establishment Panel administrative
                          data and produces the empirical tables and figure inputs.
			  

  model_analysis/         MATLAB structural model (calibration,
                          counterfactuals, policy experiments) plus Stata plotting.
                          Run master.m (MATLAB) then master.do (Stata).

  sieed_analysis/         Stata pipeline (1 master.do + 6 do-files). Builds the
                          SIEED sample for the EU-enlargement event study and
                          produces the associated figures and tables.
                          

All of the analysis can be fully run by running 
the master_file.do, which can be found in the main directory "PATH/Brinatti_Morales_Replication_Package/master_file.do"

--------------------------------------------------------------------------------
1. OVERVIEW OF THE PAPER
--------------------------------------------------------------------------------

The paper studies how immigration affects firms differently along the firm-size
distribution, combining (i) reduced-form evidence from German administrative
matched employer-employee data, (ii) estimates of key elasticities (the within-
firm immigrant-native substitution elasticity epsilon, the across-origin
elasticity kappa, demand elasticities sigma, and the labor-supply parameter nu),
and (iii) a quantitative heterogeneous-firm trade-and-migration model used for
calibration, counterfactuals, and policy experiments.

The empirical work is split by data source:
  - liab_analysis  uses the LIAB Longitudinal Model and the IAB Establishment
                   Panel (cross-sectional / panel firm and worker analysis).
  - sieed_analysis uses the SIEED sample (event-study around the 2011 EU
                   enlargement / free-movement reform).
The structural model and all of its outputs live in model_analysis. External
public calibration moments are computed in calibration_external.

--------------------------------------------------------------------------------
2. DATA AVAILABILITY, PROVENANCE AND STATEMENT ABOUT RIGHTS
--------------------------------------------------------------------------------

2.1 CONFIDENTIAL GERMAN ADMINISTRATIVE DATA (cannot be redistributed)

The core analysis uses confidential micro data from the Research Data Centre (FDZ)
of the German Federal Employment Agency at the Institute for Employment Research
(IAB):

  - LIAB Longitudinal Model 1993-2014 (LIAB LM 9314):
        liab_lm_9314_v1_pers.dta            (worker-level job histories)
        liab_lm_9314_v1_bhp_basis_v1.dta    (establishment-level basis file)
        Data citation: Section 8.1.
  - IAB Establishment Panel (IABBP), survey waves used 2004-2012:
        iabbp_<year>.dta
        Data citation: Section 8.1.
  - SIEED 7518 (Sample of Integrated Employer-Employee Data):
        SIEED_7518_v1.dta                   (worker-level spells)
        SIEED_7518_v1_bhp_basis_v1.dta      (establishment-level basis file)
        Data citation: Section 8.1.

These data are confidential and are accessible only on site / via remote
execution through the FDZ. They CANNOT be included in this package. Access can be
requested from the FDZ (https://fdz.iab.de). The analysis was carried out under
an FDZ project agreement. Project numbers are fdz1328 (LIAB) and fdz2224 (SIEED).
Full data citations for all three FDZ products are given in Section 8.1 below.


Instructions for access can be found in the following website: https://fdz.iab.de/en/data-access/on-site-use/

While these might change over time, as of May 2026 the process is the following:

1) Complete the request form and send them via email to the FDZ (iab.fdz@iab.de). The request form includes your research project description and the datasets you intend to gain access to.
2) The FDZ reviews your application and if successful, sends a contract to be signed with the researcher's institution.
3) Once the contract is signed by both parties then data access is allowed.

As of May 2026 there is no monetary cost associated with accessing the data but this should be confirmed with the FDZ.
The FDZ allows researchers to run code through a virtual tool called Josua. A majority of this project was done via this virtual mode. Onsite access is possible in certain locations including certain places outside of the EU area (https://fdz.iab.de/en/appointment-locations-and-fdz-online-calendar/) and access options can be discussed before signing the contract.



The empirical folders liab_analysis and sieed_analysis follow the same structure as the one required by the FDZ. 
A researcher should be able to directly run the codes provided through the remote online tool or via on-site access at a restricted data enclave.

IMPORTANT — TEST DATA ONLY. The .dta files shipped in the orig/ folders of
liab_analysis and sieed_analysis are FDZ-provided TEST (dummy) data, included
solely so that the code can be executed and inspected end to end. They do NOT
reproduce the numbers in the paper. Reproducing the published estimates requires
running the code on the genuine confidential data inside the FDZ environment.

A full variable-by-variable codebook for every .dta file in these two orig/
folders is provided in README_Appendix_Codebooks.txt (same directory as this
README).

2.2 ADDITIONAL INPUT FILES SHIPPED WITH THE PACKAGE

  liab_analysis/orig/
        cpigermany.dta                    German CPI deflator (to real 2010 EUR)
                                          Data citation: Section 8.2.
        local labor markets.dta           Kreis (district) -> local labor market
                                          concordance (Kropp & Schwengler 2011)
                                          Data citation: Section 8.3.
        Onet_Peri_Sparber_beruf_gr.dta    Task content of occupations (used in the
                                          comparative-advantage analysis)
                                          Data citation: Section 8.3.

					  This dataset has occupational task-content
					  measures—following Peri and Sparber(2009, AEJ: Applied)
					  —for German occupational categories (beruf_gr).
					  It starts from O*NET task scores defined at the
				 	  U.S. occ1990 level and maps them onto the German
					  classification. The dataset with the task-content
					  measures can be downloaded from https://www.aeaweb.org/articles?id=10.1257/app.1.3.135
					  and found in the folder \Extraction\TempONetVals.dta


  model_analysis/data/inputs/
        Validation_data.xlsx              Aggregated empirical moments computed
                                          from the IAB micro data inside the FDZ
                                          (already de-confidentialized aggregates;
                                          the model reads these aggregates, not the
                                          micro data). This is an internal derived
                                          product, not a separate external dataset;
                                          it is covered by the LIAB/IABBP/SIEED
                                          citations in Section 8.1.

2.3 PUBLIC EXTERNAL DATA (free, redistributable; included for convenience)

  World Bank, World Development Indicators (WDI) data.worldbank.org:
        SL.GDP.PCAP.EM.KD  GDP per person employed (constant 2017 PPP $)
        SP.POP.1564.TO     Population ages 15-64
        (also NY.GDP.PCAP.PP.CD and SP.POP.TOTL for the 2011 vintage)
        Documented in model_analysis/data/raw/.
        Download instructions are in the headers of the do-files in
        calibration_external/prog/.
        Data citation: Section 8.2.

  World Input-Output Database (WIOD), 2012 release:
        WIOT2012_October16_ROW.dta
        Used to compute the tradeable consumption share.
        Data citation: Section 8.2.

  OECD (wages, hours, GDP, dependent employees, Germany 2019):
        Five CSVs archived in model_analysis/data/raw/. These document the
        hardcoded constants used to convert model welfare percentages into the
        dollar-amount gains reported in Section 6.1. See
        model_analysis/data/raw/README.md for exact dataset ids and the derivation
        of each constant. NOTE: the package hardcodes current-vintage OECD values;
        the published paper text used the 2020-vintage OECD release.
        Data citation: Section 8.2.


Destatis:https://www-genesis.destatis.de/datenbank/online/statistic/61111/table/61111-0001
CPI series for Germany. The original series we used was discontinued but updated series is available from 1991 onwards (only 2003 – 2011 is needed for our purposes)
Data citation: Section 8.2.


2.4 STATEMENT ABOUT RIGHTS

We certify that the author(s) of the manuscript have legitimate access to and permission to use the data used in this manuscript. Access to the restricted FDZ data was granted through a formal application process with the data providers and disclosure of results followed their confidentiality process. Every number reported in the paper went through the appropriate disclosure process.


2.5 PRESERVATION OF RESTRICTED-ACCESS DATA AND SUPPORT FOR REPLICATION CHECKS

Preservation of the restricted-access data:
The confidential micro data used in this paper (LIAB LM 9314, IAB
Establishment Panel waves 2004-2012, and SIEED 7518; see Section 2.1) are
held, versioned, and preserved by the Research Data Centre (FDZ) of the
German Federal Employment Agency at the Institute for Employment Research
(IAB), https://fdz.iab.de. The FDZ retains its standardized data products
independently of individual research projects, and its policy is to make
previous versions of its datasets available on request for replication
studies even after they have been superseded by newer versions
(https://fdz.iab.de/en/our-data-products/archived-data/). In addition,
under the IAB's policy on data access for replication purposes, data
access for replication is available for ten years starting from the date
of the respective publication
(https://iab.de/en/facts-and-figures-2/data-access-for-replication-purposes/).


Affirmation of support for replication checks:
In accordance with the JPE Data and Code Availability Policy, the authors
commit to preserving the code and all materials that they are permitted to
retain for a period of no less than five years following the publication of
the paper. The authors affirm that they will provide reasonable assistance
to requests for clarification and replication, including guidance on
applying for FDZ data access (Section 2.1), answering questions about the
code, and supporting replication checks carried out within the FDZ
environment. Contact: Agostina Brinatti (agostina.brinatti@chicagobooth.edu)
and Nicolas Morales (Nicolas.Morales@rich.frb.org).


--------------------------------------------------------------------------------
3. SOFTWARE AND PACKAGE REQUIREMENTS
--------------------------------------------------------------------------------

3.1 STATA
  - Stata 16 or later. (liab_analysis/prog/master.do declares `version 16`.)
  - User-written packages (install once from SSC):

        ssc install reghdfe        // high-dimensional fixed-effects regression
        ssc install ivreghdfe      // IV/2SLS version of reghdfe
        ssc install ftools         // dependency of reghdfe/ivreghdfe
        ssc install require        // package/version dependency checker  
        ssc install estout         // eststo / esttab / estout table export
        ssc install grstyle        // graph styling (model_analysis plots only)
        ssc install grc1leg2       // graph styling (model_analysis plots only)


    ivreghdfe additionally relies on ivreg2 and ranktest; if `ssc install
    ivreghdfe` does not pull them in, install them as well:
        ssc install ivreg2
        ssc install ranktest

    The do-files in calibration_external/ use base Stata only (import Excel,
    merge, collapse) and require none of the above.


Also, make sure to add the ado files bartik_weight.ado, btsls.ado, and ch_weak.ado, which are not available via ssc install.
The codes can be downloaded directly at https://github.com/paulgp/bartik-weight/tree/master/code


3.2 MATLAB
  - MATLAB (R2019b or later recommended) with the Optimization Toolbox.
    The model solution and calibration use fsolve and fminsearch; the
    nu-estimation helper files in liab_analysis/prog use fsolve and gamma().
  - No additional MATLAB toolboxes are required.

3.3 RUN TIME AND REPRODUCIBILITY
  - Run time is data-dependent. The empirical part of the model takes close to 5 hours to run on the full data.
    On the genuine FDZ data, the bootstrap-based
    do-files (5,000 firm-clustered draws) and the model calibration (SMM via
    fminsearch) are the slow steps.
  - Seeds are set (set seed 1234 in Stata; explicit bootstrap seeds were used).
  - With the shipped TEST data the code runs to completion but outputs WILL NOT
    match the paper.


3.4 MEMORY AND STORAGE REQUIREMENTS

  Restricted-data Stata analysis (liab_analysis, sieed_analysis):
  All computations on the confidential data are carried out on the
  servers of the FDZ. Replicators therefore do not need to provision
  memory or storage for this part of the analysis.

  MATLAB model (model_analysis) and MATLAB helper files:
  The structural model is small and runs on any standard computer capable
  of running MATLAB itself. A machine meeting
  MathWorks' standard recommendation of 8 GB of RAM is more than
  sufficient. Model_analysis requires under 15 MB in total. 

--------------------------------------------------------------------------------
4. FOLDER-BY-FOLDER DESCRIPTION
--------------------------------------------------------------------------------

================================================================================
4.1 calibration_external/
================================================================================
Purpose: compute one external calibration moment from public data. The code is run from master_file.do.

  prog/
        tradable_consumption_share.do  Reads WIOT2012 and computes the share of German
                                    household final consumption originating from
                                    tradeable sectors. Result ~ 0.68. (Timmer et al 2015)

  data/
    WIOT2012_October16_ROW.dta      WIOD 2012 world input-output table

Outputs: scalars displayed in the Stata results window (no files written). These
moments feed the model calibration in model_analysis.

================================================================================
4.2 liab_analysis/
================================================================================
Structure: data/ (empty), log/ (empty), orig/ (raw/test data — see Section 2),
prog/ (programs).

prog/ contains one master and 19 numbered do-files and 2 matlab files. Run prog/master.do after
setting the four path globals (see Section 5). Do-files 1-7 build intermediate
datasets and produce no publication output; do-files 8-19 produce all tables and
figure inputs. The header of master.do also lists this mapping.

IMPORTANT: although do-files 1-7 produce no publication output of their own,
several analysis do-files in 8-19 read intermediate files that 1-7 construct
(e.g. 18_immigrant_comparative_advantage.do reads crosswalk_beruf_gr_blossfeld.dta,
which is written by 3_crosswalk_occupation_blossfeld.do). Do-files 8-19 should
therefore never be run in isolation without first having run 1-7 (or the full
prog/master.do, which always runs 1-7 before 8-19 and handles this correctly).

  Data construction (no output):
    1_cleaning_data.do                       Worker-level LIAB sample; immigrant
                                             indicator from citizenship history.
    2_local_labor_markets.do                 Kreis -> local labor market concordance.
    3_crosswalk_occupation_blossfeld.do      Occupation -> Blossfeld 12-group crosswalk.
    4_dataset_firm_level.do                  Establishment-year analysis dataset;
                                             merges IABBP, deflates to real 2010 EUR.
    5_dataset_for_instrument_validation.do   Card (2001) shift-share instrument.
    6_dataset_for_regressions_validation.do  Regression-ready establishment dataset.
    7_dataset_for_epsilon_estimation.do      Firm-/origin-firm-year samples for
                                             epsilon and kappa.

  Analysis (output):
    8_validation_regressions.do          Tables C8-C13; Figure 3 (elasticity by
                                         size decile).
    9_kappa_estimation.do                Kappa (Appendix C.1).
    10_epsilon_estimation.do             Table C1 (OLS and 2SLS; bootstrap CIs).
    11_epsilon_pre_trend_test.do         Table C3 (pre-trend test).
    12_epsilon_firm_characteristics.do   Table C5 (robustness to firm controls).
    13_estimate_epsilon_sigma.do         Section 5.1 point estimates; joint
                                         epsilon-sigma bootstrap.
    14_epsilon_sigma_histogram.do        Section 5.3; Figure C1.
    15_epsilon_shift_share.do            Tables C2, C4 (instrument diagnostics).
    16_estimate_nu.do                    Table C6 (CV^2 of native wage residuals).
    17_empirical_facts.do                Tables A1-A2; underlying data for Figures
                                         1, A1-A4, A6.
    18_immigrant_comparative_advantage.do Tables A6-A8; Figure A9.
    19_moments_calculation.do            Table 1 / Table C7; demand elasticities
                                         sigma (Section 5.1).

  MATLAB helpers (nu):
    solve_kappa.m            Solves beta = Gamma(1-2/x)/Gamma(1-1/x)^2 - 1 for the
                             Frechet labor-supply parameter (input from Table C6).
    estimate_nu_2j_cont.m    Calls solve_kappa for the three FE specifications in
                             Table C6 to back out nu.

Due to the way output is released according to the FDZ guidelines, the Figures and Tables of the paper are disclosed via tables that we later convert into Figures using predominantly Excel. As such, the Figures are not directly produced using the code but the underlying data to construct them is.

================================================================================
4.3 model_analysis/  (SELF-CONTAINED — see its own README files)
================================================================================
This folder is self-contained and carries its own documentation:
    model_analysis/data/README.md
    model_analysis/data/raw/README.md   (exact OECD/WDI ids and constant derivations)

Layout:
    code/model/        MATLAB model code: heterogeneous-firm model, homogeneous
                       comparison model, policy experiments, equilibrium equations,
                       calibration (SMM), and Export_latex_tables.m (LaTeX tables).
    code/stata_plots/  Stata do-files that combine model output with data to draw
                       the figures (uses grstyle / sj_grstyle.do).
    data/inputs/       Aggregated IAB moments (Validation_data.xlsx).
    data/raw/          Archived OECD and World Bank source files (documentation).
    output/            tables/ (.tex), figures/ (.jpg), intermediate/ (MATLAB->Stata
                       bridge .mat/.xlsx files).
    scripts/master.m   MATLAB orchestration (run FIRST).
    scripts/master.do  Stata orchestration (run SECOND).

Run order: in MATLAB, run scripts/master.m (heterogeneous model -> homogeneous
model -> five policy counterfactuals -> Export_latex_tables.m). Then, in Stata,
set the `base` global at the top of scripts/master.do to the absolute path of
model_analysis and run it.

Outputs:
    LaTeX tables (output/tables/): Table 1, Table 2, Table C7, Tables D1-D3, plus
        the Section 6.1 aggregate / dollar-gains blocks and the Section 6.3
        decomposition. (Produced by Export_latex_tables.m.)
    Figures (output/figures/): Figure 3 (data vs. model elasticities by size
        decile, Sec 5.5), Figure 4 (native reallocation across firms, Sec 6.1),
        Figure D1 and Figure D2 (alternative policies, Appendix D.2-D.3).

================================================================================
4.4 sieed_analysis/
================================================================================
Structure mirrors liab_analysis: data/ (empty), log/ (empty), orig/ (raw/test
data: SIEED_7518_v1.dta and SIEED_7518_v1_bhp_basis_v1.dta), prog/ (programs).

prog/ contains one master and six do-files. Run prog/master.do after setting the
four path globals (Section 5). Files 1a-1c build datasets; 2a-2c produce output.

  Data construction (no output):
    1a_create_data_event_study.do   Worker- and firm-level SIEED panel for the
                                     event study.
    1b_add_local_labor_market.do     Kreis -> local labor market mapping.
    1c_create_data_figA7.do          Firm-level dataset for Figure A7.

  Analysis (output):
    2a_results_event_studies.do      Figure 2 (event study by firm size); Figure A8
                                     (baseline event study); Tables A3-A5
                                     (alternative outcomes / sample / FE robustness).
    2b_results_figA7.do              Figure A7 (immigrant wage share by size decile,
                                     pre/post enlargement; 200 bootstrap reps).
    2c_results_figA5.do              Figure A5 (hiring dynamics after a firm first
                                     hires immigrants).

Due to the way output is released according to the FDZ guidelines, the Figures and Tables of the paper are disclosed via tables that we later convert into Figures using predominantly Excel. As such, the Figures are not directly produced using the code but the underlying data to construct them is.

--------------------------------------------------------------------------------
5. INSTRUCTIONS TO REPLICATORS
--------------------------------------------------------------------------------

Prerequisite: install the Stata packages in Section 3.1 and have MATLAB with the
Optimization Toolbox available.

5.1 EMPIRICAL FOLDERS (liab_analysis, sieed_analysis)
The master file master_file.do, found in the main directory runs the analysis of liab and sieed. You will need to set the "root" path where the replication folder is located:


Each folder follows the same structure as the one required by the FDZ as follows:

        global orig "<...>/<folder>/orig"     // raw / test input data
        global data "<...>/<folder>/data"     // intermediate datasets (writable)
        global log  "<...>/<folder>/log"      // log files (writable)
        global prog "<...>/<folder>/prog"     // this folder of programs


Within each prog folder, there is a master.do file that runs the data-construction step first, then the analysis step. (When
working inside the FDZ in publication/presentation mode, the data-construction
block may be run separately from the analysis block.)

5.2 MODEL FOLDER (model_analysis)
        1. In MATLAB: run model_analysis/scripts/master.m
        2. In Stata:  set `global base` at the top of
                      model_analysis/scripts/master.do to the absolute path of
                      model_analysis, then run that file.

5.3 EXTERNAL CALIBRATION (calibration_external)
Run any of the three do-files in calibration_external/prog/ individually; each
reads its inputs from calibration_external/data/ and displays a scalar result.

--------------------------------------------------------------------------------
6. MAPPING OF EXHIBITS TO PROGRAMS
--------------------------------------------------------------------------------

The "CONFIDENTIAL DATA?" column indicates whether reproducing the exhibit
requires access to the confidential FDZ micro data described in Section 2.1.
Exhibits marked "Yes" are constructed from the LIAB, IAB Establishment Panel,
and/or SIEED confidential data and cannot be reproduced using only the test
data and public inputs shipped in this package; genuine FDZ access (Section
2.1) is required. Exhibits marked "No" rely only on public data (Section 2.3)
and the structural model, and can be reproduced in full from the materials
shipped here.

EXHIBIT                                      FOLDER                PROGRAM                                       CONFIDENTIAL DATA?
-------                                      ------                -------                                       ------------------
Table 1 (data side)                                     liab_analysis         19_moments_calculation.do                     Yes
Table 1 (model side) / Table 2               model_analysis        code/model/Export_latex_tables.m              No
Table A1, A2                                 liab_analysis         17_empirical_facts.do                         Yes
Tables A3-A5                                 sieed_analysis        2a_results_event_studies.do                   Yes
Tables A6-A8                                 liab_analysis         18_immigrant_comparative_advantage.do         Yes
Table C1                                     liab_analysis         10_epsilon_estimation.do                      Yes
Tables C2, C4                                liab_analysis         15_epsilon_shift_share.do                     Yes
Table C3                                     liab_analysis         11_epsilon_pre_trend_test.do                  Yes
Table C5                                     liab_analysis         12_epsilon_firm_characteristics.do            Yes
Table C6                                     liab_analysis         16_estimate_nu.do (+ MATLAB nu files)         Yes
Table C7                                     liab_analysis /       19_moments_calculation.do /                   Yes
                                             model_analysis        Export_latex_tables.m
Tables C8-C13                                liab_analysis         8_validation_regressions.do                   Yes
Tables D1-D3                                 model_analysis        code/model/Export_latex_tables.m              No
Kappa (Appendix C.1)                         liab_analysis         9_kappa_estimation.do                         Yes

Figure 1                                     liab_analysis         17_empirical_facts.do                         Yes
Figure 2                                     sieed_analysis        2a_results_event_studies.do                   Yes
Figure 3                                     liab_analysis /       8_validation_regressions.do /                 Yes
                                             model_analysis        master.do (Validation_cross_CI_heterog.do)
Figure 4                                     model_analysis        master.do (Counterfactual_plots_heterog.do)   No
Figure A1-A4, A6                             liab_analysis         17_empirical_facts.do                         Yes
Figure A5                                    sieed_analysis        2c_results_figA5.do                           Yes
Figure A7                                    sieed_analysis        2b_results_figA7.do                           Yes
Figure A8                                    sieed_analysis        2a_results_event_studies.do                   Yes
Figure A9                                    liab_analysis         18_immigrant_comparative_advantage.do         Yes
Figure C1                                    liab_analysis         14_epsilon_sigma_histogram.do                 Yes
Figure D1, D2                                model_analysis        master.do (Counterfactual_plots_policies.do)  No

Calibration moment GDP_RoW_Ger (~0.32)       calibration_external  gdp_per_worker_*.do                           No
Calibration moment tradeable share (~0.68)   calibration_external  tradeable_consumption_share.do                No

Note: in the empirical folders, several exhibits that appear as figures in the
paper are produced as the underlying numerical tables (point estimates and
bootstrap confidence intervals), in line with FDZ output-disclosure rules.

--------------------------------------------------------------------------------
7. NOTES
--------------------------------------------------------------------------------
  - The data/ and log/ folders of liab_analysis and sieed_analysis are shipped
    empty; they are populated when the code runs.
  - The shipped orig/ administrative data are FDZ TEST data only and do not
    reproduce the paper's numbers (Section 2.1).
  - A variable-by-variable codebook for every raw/test .dta file shipped in
    liab_analysis/orig/ and sieed_analysis/orig/ (variable names, storage
    types, labels, and coded categories) is provided as a separate appendix:
    README_Appendix_Codebooks.txt, in this same directory.

--------------------------------------------------------------------------------
8. DATA CITATIONS
--------------------------------------------------------------------------------

As required by the JPE Data and Code Availability Policy, this section gives a
full citation for every dataset used in the replication package: confidential
FDZ micro data (8.1), public secondary data (8.2), and data derived from
published academic work that is shipped with the package but has no
independent public data DOI (8.3). Each entry also states which file(s) in
the package it covers. See Section 2 for provenance/access details and
Section 9 (References) for the corresponding in-text article references.

8.1 Confidential FDZ data
    (Research Data Centre (FDZ) of the German Federal Employment Agency at
    the Institute for Employment Research (IAB), https://fdz.iab.de; accessed
    under project agreements fdz1328 [LIAB/IABBP] and fdz2224 [SIEED] --
    see Section 2.1)

  Covers: liab_lm_9314_v1_pers.dta, liab_lm_9314_v1_bhp_basis_v1.dta

    Heining, Jörg; Klosterhuber, Wolfram; Lehnert, Patrick; Seth, Stefan
    (2016). "Linked Employer-Employee Data from the IAB: LIAB Longitudinal
    Model 1993-2014 (LIAB LM 9314)." FDZ-Datenreport 10/2016 (en). Institut
    für Arbeitsmarkt- und Berufsforschung (IAB), Nuremberg.
    Data access: Research Data Centre (FDZ) of the German Federal Employment
    Agency (BA) at IAB, project fdz1328.

  Covers: iabbp_2004.dta ... iabbp_2012.dta

    Institut für Arbeitsmarkt- und Berufsforschung (IAB) / Forschungsdaten-
    zentrum (FDZ) der Bundesagentur für Arbeit (BA). IAB Establishment Panel
    (IAB-BP), waves 2004-2012.
    IAB-Betriebspanel (IAB-BP), Version 9314     
Data access: Research Data Centre (FDZ) of the German Federal Employment
    Agency (BA) at IAB, project fdz1328.

  Covers: SIEED_7518_v1.dta, SIEED_7518_v1_bhp_basis_v1.dta

    Berge, Philipp vom; Schmidtlein, Lisa; Seth, Stefan; Graf, Tobias;
    Grießemer, Stephan; Kaimer, Steffen; Köhler, Markus; Lehnert, Claudia;
    Oertel, Martina; Seysen, Christian (2020). "The Sample of Integrated
    Employer-Employee Data (SIEED): SIEED 7518, Version 1." Institut für
    Arbeitsmarkt- und Berufsforschung (IAB), Nuremberg.
    DOI: 10.5164/IAB.SIEED7518.de.en.v1
    Data access: Research Data Centre (FDZ) of the German Federal Employment
    Agency (BA) at IAB, project fdz2224.

Covers: \model_analysis\data\inputs\Validation_data.xlsx

This data is directly created using the LIAB datasets in this section but constructed and disclosed from the confidential data instead of the test data. The file is constructed exporting the numbers disclosed for Table C13 - data citation just includes the LIAB datasets above.


8.2 Public secondary data

  Covers: cpigermany.dta

    Statistisches Bundesamt (Destatis). Verbraucherpreisindizes für
    Deutschland [Consumer Price Indices for Germany]. GENESIS-Online
    database, table 61111-0001.
    https://www-genesis.destatis.de/datenbank/online/statistic/61111/table/61111-0001
    (accessed May 2026). Note: the original CPI table used to
    build this series was discontinued by Destatis; table 61111-0001 is the
    current successor series (available from 1991 onward; only 2003-2011 is
    used here).

  Covers: World Bank WDI series used in calibration_external/ and
          model_analysis/

    World Bank. World Development Indicators. Washington, DC: World Bank
    Group. https://data.worldbank.org (May 2026).
    Series used: SL.GDP.PCAP.EM.KD (GDP per person employed, constant 2017
    PPP $); SP.POP.1564.TO (population ages 15-64, total); NY.GDP.PCAP.PP.CD
    (GDP per capita, PPP, current international $, 2011 vintage); SP.POP.TOTL
    (population, total, 2011 vintage).

  Covers: WIOT2012_October16_ROW.dta

    Timmer, Marcel P.; Dietzenbacher, Erik; Los, Bart; Stehrer, Robert;
    de Vries, Gaaitzen J. (2015). "An Illustrated User Guide to the World
    Input-Output Database: The Case of Global Automotive Production." Review
    of International Economics 23(3): 575-605.
    Data: World Input-Output Database (WIOD), 2012 Release,
    https://www.rug.nl/ggdc/valuechain/wiod/wiod-2013-release (per WIOD's own
    citation policy, this article is the designated data citation for the
    2012 release).

  Covers: five OECD CSVs in model_analysis/data/raw/ (Section 6.1
          dollar-gains conversion)

    OECD. Germany, 2019: Average Annual Wages [dataset
    OECD.ELS.SAE,DSD_EARNINGS@AV_AN_WAGE,1.0]; Average Usual Weekly Hours
    Worked [OECD.ELS.SAE,DSD_HW@DF_AVG_USL_WK_WKD,1.0]; National Accounts --
    GDP [OECD.SDD.NAD,DSD_NAMAIN10@DF_TABLE1_EXPENDITURE,2.0]; National
    Accounts -- Employment [OECD.SDD.NAD,DSD_NAMAIN10@DF_TABLE3_EMPDC,2.0].
    OECD Data Explorer / OECD.Stat, https://stats.oecd.org (accessed
    May 2026). Note: the published paper text used the
    2020-vintage OECD release; the package hardcodes current-vintage values
    (Section 2.3).

8.3 Data derived from published academic work
    (shipped with the package; see Section 2.2. No independent public data
    DOI exists for these -- the underlying article is the data citation.)

  Covers: local labor markets.dta

    Kropp, Per; Schwengler, Barbara (2011). "Delineation of Functional Labour
    Market Regions: A Methodological Approach." Raumforschung und
    Raumordnung 69(1): 45-62.
    Concordance data provided directly to the authors by the IAB; not
    separately published or versioned.

  Covers: Onet_Peri_Sparber_beruf_gr.dta

    Peri, Giovanni; Sparber, Chad (2009). "Task Specialization, Immigration,
    and Wages." American Economic Journal: Applied Economics 1(3): 135-169.
    Underlying data: American Economic Association data archive,
    https://www.aeaweb.org/articles?id=10.1257/app.1.3.135, file
    Extraction/TempONetVals.dta.

--------------------------------------------------------------------------------
9. REFERENCES
--------------------------------------------------------------------------------

Kropp, P. and B. Schwengler 2011. Delineation of Functional Labour Market Regions: a Methodological Approach. Raumforschung und Raumordnung 69 (1), 45-62.
Peri, G., and C. Sparber. 2009. "Task Specialization, Immigration, and Wages." American Economic Journal: Applied Economics 1 (3): 135–69.
Timmer, M. P., E. Dietzenbacher, B. Los, R. Stehrer, and G. J. de Vries (2015). An illustrated user guide to the world input–output database: the case of global automotive production. Review of International Economics 23, 575–605

================================================================================
End of README.
================================================================================
