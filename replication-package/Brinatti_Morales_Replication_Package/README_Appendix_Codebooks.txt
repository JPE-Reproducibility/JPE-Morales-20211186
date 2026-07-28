================================================================================
APPENDIX A — DATA CODEBOOKS FOR RAW/TEST INPUT FILES
"Firm Heterogeneity and the Impact of Immigration: Evidence from German
Establishments" -- Agostina Brinatti and Nicolas Morales
================================================================================

This appendix documents, variable by variable, the .dta files shipped in
  liab_analysis/orig/
  sieed_analysis/orig/
(see README.txt Section 2 for provenance and access). As stated there, the
LIAB, IABBP and SIEED files in these folders are FDZ-provided TEST (dummy)
data included only so the code can be run end to end; they do not reproduce
the confidential data used for the paper's results.

All variable and value labels below are given in English. Where the .dta file
itself stores an English label (LIAB LM worker file; and, via Stata's
`label language en`, the SIEED establishment basis file), that stored label is
reproduced directly. Where the shipped file carries only German-language
labels (SIEED worker file, LIAB LM establishment basis file, IAB Establishment
Panel waves), the English text below is taken from FDZ's own official
English-language documentation for the same (or, for LIAB LM basis and IABBP,
a closely corresponding) dataset version, published at fdz.iab.de -- not an
ad hoc translation. Sources by dataset are noted at each section below. For
each dataset the entries below give:
  - the Stata variable name
  - the Stata storage/display format (e.g. %10.0f numeric, %tdD_m_CY date,
    %20s string)
  - the variable label
  - for labeled (categorical) variables: the value-label set. Sets of up to
    30 categories are listed in full; larger sets (occupation codes KldB,
    industry codes WZ, regional codes Kreis/Arbeitsagentur, nationality
    codes, etc.) report only the category count and a few example codes --
    these follow standard external German/EU classifications documented by
    Destatis / the Federal Employment Agency (BA) / FDZ.

--------------------------------------------------------------------------------
A.0 INDEX
--------------------------------------------------------------------------------
  A. sieed_analysis/orig/
     A.1  sieed_7518_v1.dta                    (worker-level spells)
     A.2  SIEED_7518_v1_bhp_basis_v1.dta        (establishment basis file)
  B. liab_analysis/orig/
     B.1  liab_lm_9314_v1_pers.dta              (worker-level job histories)
     B.2  liab_lm_9314_v1_bhp_basis_v1.dta      (establishment basis file)
     B.3  iabbp_2004.dta ... iabbp_2012.dta     (IAB Establishment Panel waves)
     B.4  cpigermany.dta                        (German CPI deflator)
     B.5  local labor markets.dta               (Kreis -> local labor market)
     B.6  Onet_Peri_Sparber_beruf_gr.dta        (O*NET task content by occupation)

================================================================================
A. SIEED_ANALYSIS/ORIG
================================================================================

--------------------------------------------------------------------------------
A.1 sieed_7518_v1.dta
--------------------------------------------------------------------------------
  Observations: 1,150,384    Variables: 33    Unit of observation: worker-spell (SIEED 7518)

  Note: English labels: the shipped .dta stores German labels only. Text below is
  from FDZ's official English documentation for this exact dataset version
  (Labels_SIEED_7518_v1_en.log, in the "Frequencies and labels" package for
  FDZ-Datenreport 14/2020, fdz.iab.de), matched variable-for-variable and
  code-for-code against the shipped file.

  persnr             %10.0f     Individual ID
  betnr              %12.0f     Establishment ID
  betnr_pan          %22.0g     panel establishment identifier
        [2 categories] 0=no panel establishment; 1=panel establishment;
  spell              %8.0f      Observation counter per person
  begorig            %tdD_m_CY  Original start date
  endorig            %tdD_m_CY  Original end date
  begepi             %tdD_m_CY  Episode start date
  endepi             %tdD_m_CY  Episode end date
  frau               %11.0f     Gender
        [2 categories] 0=Male; 1=Female;
  gebjahr            %12.0g     Year of birth
  gebmon             %16.0f     Month of birth
        [12 categories] 1=January; 2=February; 3=March; 4=April; 5=May; 6=June; 7=July; 8=August; 9=September;
          10=October; 11=November; 12=December;
  nation             %32.0f     Nationality
        [225-category external classification] e.g. 0=Germany; 121=Albania; 122=Bosnia and Herzegovina ...
  nation_gr          %54.0f     Nationality, grouped
        [48-category external classification] e.g. 10=Germany; 11=Turkey; 12=Italy ...
  ausbildung         %48.0f     Vocational training
        [4 categories] 1=Without vocational training;
          2=In-company voc. training/traineeship/External (on-school) voc. training;
          11=University of applied sciences without further specifications;
          12=University without further specifications;
  ausbildung_imp     %74.0f     Vocational training (imputed)
        [6 categories] 1=Secondary / intermediate school leaving certificate without completed vocational training;
          2=Secondary / intermediate school leaving certificate with completed vocational training;
          3=Upper secondary school leaving certificate (general or subject-specific) without completed vocational training;
          4=Upper secondary school leaving certificate (general or subject-specific) with completed vocational training;
          5=Completion of a university of applied sciences; 6=College / university degree;
  schule             %84.0f     School leaving qualification
        [6 categories] 1=No school leaving certificate;
          4=lower secondary school certificate/ grade school certificate;
          5=Grade-/lower school certificate, intermediate school or equivalent qualification;
          6=Intermediate school leaving certificate;
          8=Completion of education at a specialised upper secondary school/completion of higher education at a specialised college or upper secondary school leaving certificate, A-level equivalent, qualification for university; 13 years of schooling;
          9=Upper secondary school leaving certificate, A-level equivalent, qualification for university; 13 years of schooling;
  tentgelt           %12.0g     Daily wage/daily benefit
  beruf              %76.0f     Occupation - current/most recent (KldB 1988)
        [342-category external classification] e.g. 11=Farmers; 12=Winegrowers; 21=Animal breeders ...
  beruf2010_3        %101.0f    Occupational group - current/most recent (KldB 2010), 3-digit
        [144-category external classification] e.g. 11=Commissioned officers; 12=Senior non-commissioned officers and higher; 13=Junior non-commissioned officers ...
  beruf2010_4        %134.0f    Occupational sub-group - current/most recent (KldB 2010), 4-digit
        [700-category external classification] e.g. 110=Commissioned officers; 120=Senior non-commissioned officers and higher; 130=Junior non-commissioned officers ...
  niveau             %34.0f     Level of requirement - current/most recent job (KldB 2010)
        [4 categories] 1=Unskilled/semiskilled task; 2=Skilled task; 3=Complex task; 4=Highly complex task;
  teilzeit           %24.0f     Part-time
        [2 categories] 0=Full-time; 1=Part-time;
  stib               %36.0f     Occupational status and working hours
        [8 categories] 0=In vocational training; 1=Unskilled workers; 2=Skilled workers;
          3=Master craftsmen, foremen (blue-collar or white-collar);
          4=Employees (excl. employed master craftsmen); 7=Home workers, Freelance home workers;
          8=Part-time up to half of full-time; 9=Part-time more than half of full-time;
  erwstat            %70.0f     Employment status
        [24 categories] 101=Employees liable to social security without special characteristics;
          102=Trainees without special characteristics; 103=Employees in partial retirement;
          104=Freelance home workers; 105=Interns; 106=Student trainees; 109=Marginal part-time workers;
          112=Family-member workers in agriculture; 118=Unsteady workers;
          119=Retired persons exempt from social security payments;
          120=Retired persons with compulsory social security payments;
          121=Trainees (below marginal part-time income threshold);
          122=Trainees (external (on-school) voc. training);
          123=Voluntary social or ecological year or in federal volunteer service; 124=Home workers;
          140=Sailors; 141=Trainees in maritime shipping; 143=Maritime pilots;
          149=Retired persons exempt from social security payments (mar. shipping);
          201=Employees (household cheque);
          203=Artists and publicists with compulsory social security payments; 205=Unsteady workers;
          209=Marginal part-time workers (household cheque); 599=Others in labour force;
  gleitz             %24.0f     Transition zone
        [3 categories] 0=No transition zone; 1=Transition zone; 2=Mixed case;
  leih               %28.0f     Temporary agency work
        [2 categories] 0=No temporary agency work; 1=Temporary agency work;
  befrist            %24.0f     Fixed-term contract
        [2 categories] 0=permanent contract; 1=fixed-term contract;
  grund              %62.0f     Reason of cancellation/notification/termination
        [21 categories] 30=Deregistration due to end of employment;
          31=Deregistration due to change of health insurance company;
          32=Deregistration due to change of contribution group; 33=Deregistration for other reasons;
          34=Deregistration due to interruption of employment for more than one month;
          35=Deregistration due to interruption of employment for more than one month because of industrial conflict/dispute;
          36=Deregistration due to change of payroll accounting system / currency changeover;
          40=Simultaneous registration and deregistration due to end of employment;
          49=Deregistration due to death; 50=Annual notification;
          51=Employment interruption notification due to entitlement to other compensation;
          52=Employment interruption notification due to parental leave;
          53=Employment interruption notification due to statutory official duties;
          54=Notification of a lump sum payment;
          55=Notification of credit not used as agreed (process upset);
          56=Notification of the difference in amount in the case of earnings-replacement benefits during partial retirement;
          57=Special notification according to § 194 SGB VI;
          59=Renumeration notification for casual employees;
          70=Annual notification for employees released from work;
          71=Notification because of insolvency/ exemption;
          72=Notification at the legal end of employment;
  alo_dau            %9.0g      Duration of unemployment
  wo_kreis           %38.0f     Place of residence - district (Kreis)
        [415-category external classification] e.g. 0=Other foreign countries; 124=Belgium; 126=Denmark ...
  wo_bula            %25.0f     Place of residence - federal state (Bundesland)
        [16 categories] 1=Schleswig-Holstein; 2=Hamburg; 3=Lower Saxony; 4=Bremen; 5=North Rhine-Westphalia; 6=Hesse;
          7=Rhineland-Palatinate; 8=Baden-Wuerttemberg; 9=Bavaria; 10=Saarland; 11=Berlin;
          12=Brandenburg; 13=Mecklenburg-Western Pomerania; 14=Saxony; 15=Saxony-Anhalt; 16=Thuringia;
  wo_aa              %39.0f     Place of residence - employment agency (Arbeitsagentur)
        [157-category external classification] e.g. 30=Greifswald; 31=Neubrandenburg; 32=Rostock ...
  wo_rd              %29.0f     Place of residence - regional directorate (Regionaldirektion)
        [11 categories] 101=North; 102=Berlin-Brandenburg; 103=Saxony-Anhalt/Thuringia; 104=Saxony;
          105=Lower Saxony-Bremen; 106=North Rhine-Westphalia; 107=Hesse (incl. ZAV);
          108=Rhineland-Palatinate-Saarland; 109=Baden-Wuerttemberg; 110=Bavaria; 111=Foreign places;

--------------------------------------------------------------------------------
A.2 SIEED_7518_v1_bhp_basis_v1.dta
--------------------------------------------------------------------------------
  Observations: 197,898    Variables: 25    Unit of observation: establishment-year

  Note: English labels: extracted directly from the shipped .dta via Stata's
  `label language en` (this file stores German, English, and "default"
  label sets; English was already present, not sourced externally).

  betnr              %12.0f     Establishment ID
        [1 categories] z=no entry;
  jahr               %8.0g      Year
  w73_3              %47.0f     classification of economic activities 73
        [304-category external classification] e.g. 0=Growing of crops, farming of animals; 1=Industrial farming; 10=Horticulture ...
  w93_5              %48.0f     classification of economic activities 93, sub-classes
        [1066-category external classification] e.g. 1111=Growing of cereals; 1112=Growing of other crops n.e.c.; 1121=Growing of vegetables, seasoning herbs and mushrooms ...
  w93_3              %35.0f     classification of economic activities 93, groups
        [226-category external classification] e.g. 11=Growing of crops; market gardening; horticulture; 12=Farming of animals; 13=Growing of crops combined with farming of animals (mixed farming) ...
  w03_5              %213.0f    classification of economic activities 03, sub-classes
        [1045-category external classification] e.g. 1111=Growing of cereals; 1112=Growing of other crops n.e.c.; 1121=Growing of vegetables, seasoning herbs and mushrooms ...
  w03_3              %98.0f     classification of economic activities 03, groups
        [226-category external classification] e.g. 11=Growing of crops; market gardening; horticulture; 12=Farming of animals; 13=Growing of crops combined with farming of animals (mixed farming) ...
  w08_5              %213.0f    classification of economic activities 08, sub-classes
        [843-category external classification] e.g. 1110=Growing of cereals (except rice), leguminous crops and oil seeds; 1120=Growing of rice; 1131=Growing of vegetables and melons ...
  w08_3              %162.0f    classification of economic activities 08, groups
        [276-category external classification] e.g. 11=Growing of non-perennial crops; 12=Growing of perennial crops; 13=Plant propagation ...
  w73_3_gen          %47.0f     w73_3 completed by extrapolation/imputation
        [304-category external classification] e.g. 0=Growing of crops, farming of animals; 1=Industrial farming; 10=Horticulture ...
  group_w73_3        %27.0g     Type of imputation w73_3
        [4 categories] 0=Original value; 1=Remains missing; 2=Extrapolated; 3=Imp. using w93_5;
  w93_3_gen          %35.0f     w93_3 completed by extrapolation/imputation
        [226-category external classification] e.g. 11=Growing of crops; market gardening; horticulture; 12=Farming of animals; 13=Growing of crops combined with farming of animals (mixed farming) ...
  group_w93_3        %30.0g     Type of imputation w93_3
        [5 categories] 0=Original value; 1=Remains missing; 2=Extrapolated; 3=Imp. using w03_5;
          4=2nd Imp. using w73_3;
  w08_3_gen          %162.0f    w08_3 completed by extrapolation/imputation
        [276-category external classification] e.g. 11=Growing of non-perennial crops; 12=Growing of perennial crops; 13=Plant propagation ...
  group_w08_3        %27.0g     Type of imputation w08_3
        [4 categories] 0=Original value; 1=Remains missing; 2=Extrapolated; 3=Imputed;
  grd_jahr           %8.0g      year of first appearance
  grd_dat            %tdD_m_Y   first appearance
  lzt_jahr           %8.0g      year of last appearance
  lzt_dat            %tdD_m_Y   last appearance
  az_ges             %15.0g     no. employees
        [1 categories] z=no entry;
  az_vz              %15.0g     no. full-time (regular workers + others)
        [1 categories] z=no entry;
  az_gf              %15.0g     no. marginal part-time workers
        [1 categories] z=no entry;
  te_imp_mw          %15.0g     mean imp. wage all full-time employees
        [1 categories] z=no entry;
  ao_kreis           %38.0f     Place of work - district (Kreis)
        [571-category external classification] e.g. 0=Other foreign countries; 121=Albania; 122=Bosnia and Herzegovina ...
  ao_bula            %26.0f     Place of work - federal state (Bundesland)
        [19 categories] 0=Foreign places; 1=Schleswig-Holstein; 2=Hamburg; 3=Lower Saxony; 4=Bremen;
          5=North Rhine-Westphalia; 6=Hesse; 7=Rhineland-Palatinate; 8=Baden-Wuerttemberg; 9=Bavaria;
          10=Saarland; 11=Berlin; 12=Brandenburg; 13=Mecklenburg-Western Pomerania; 14=Saxony;
          15=Saxony-Anhalt; 16=Thuringia; n=n/a; z=no entry;

================================================================================
B. LIAB_ANALYSIS/ORIG
================================================================================

--------------------------------------------------------------------------------
B.1 liab_lm_9314_v1_pers.dta
--------------------------------------------------------------------------------
  Observations: 3,385,862    Variables: 41    Unit of observation: worker-spell (LIAB LM 9314)

  Note: English labels: the shipped .dta's only label language ("default") is
  already English -- reproduced directly, no external source needed.

  persnr             %12.0g     Individual ID
  betnr              %15.0f     Establishment ID
  idnum              %15.0f     Establishment-ID acc. to Survey
  begorig            %tdD_m_CY  Original start date
  endorig            %tdD_m_CY  Original end date
  begepi             %tdD_m_CY  Episode start date
  endepi             %tdD_m_CY  Episode end date
  quelle             %40.0f     Source of spell
        [6 categories] 1=1  BeH Employee History; 2=2  LEH Benefit Recipient History; 7=7  ASU Jobseeker History;
          16=16  LHG Unemployment Benefit II Recipient History;
          18=18  XASU Job-Search History drawn from XSozial-BA-SGB II;
          32=32  MTH Participants-in-Measures History Files;
  spell              %4.0f      counter per person
  betr_st            %101.0g    Status of establishment number
        [4 categories] 
          1=1  Employment in estab. of Estab. Panel with interview in same year, estab. selected for LIAB model;
          2=2  Employment in estab. of Estab. Panel without interview in same year, estab. selected for LIAB model;
          3=3  Employment in estab. of Estab. Panel, estab. not selected for LIAB model;
          4=4  Employment in estab. not of Estab. Panel;
  frau               %15.0f     Gender
        [2 categories] 0=0  Male; 1=1  Female;
  gebjahr            %9.0g      
   
  ausbildung         %49.0f     Vocational training
        [4 categories] 1=1  Without vocational training;
          2=2  In-company voc. training/traineeship/External (on-school) voc. training;
          11=11  University of applied sciences without further specifications;
          12=12  University without further specifications;
  schule             %85.0f     School leaving qualification
        [7 categories] 1=1  No school leaving certificate;
          4=4  lower secondary school certificate/ grade school certificate;
          5=5  Grade-/lower school certificate, intermediate school or equivalent qualification;
          6=6  Intermediate school leaving certificate;
          7=7  Completion of education at a specialised upper secondary school/completion of higher education at a specialised college;
          8=8  Completion of education at a specialised upper secondary school/completion of higher education at a specialised college or upper secondary school leaving certificate, A-level equivalent, qualification for university; 13 years of schooling;
          9=9  Upper secondary school leaving certificate, A-level equivalent, qualification for university; 13 years of schooling;
  tentgelt_orig      %15.1f     Daily wage/daily benefit
  beruf_gr           %77.0f     Occupation - current/most recent (KldB 1988)
        [343-category external classification] e.g. 11=11  Farmers; 12=12  Winegrowers; 21=21  Animal breeders ...
  teilzeit           %24.0f     Part-time
        [2 categories] 0=0  Full-time; 1=1  Part-time;
  erwstat            %125.0f    Employment status
        [29 categories] 1=1  ALG Unemployment benefit; 2=2  ALHI Unemployment assistance;
          3=3  UHG Maintenance allowance;
          5=5  PFL Contributions to long-term care insurance of privately insured persons;
          101=101  Employees liable to social security without special characteristics;
          102=102  Trainees; 103=103  Employees in partial retirement; 104=104  Freelance home workers;
          105=105  Interns; 106=106  Student trainees; 109=109  Marginal part-time workers;
          112=112  Family-member workers in agriculture; 118=118  Casual workers;
          119=119  Retired persons exempt from social security payments;
          120=120  Persons with assumed employment;
          121=121  Trainees (below marginal part-time income threshold);
          122=122  Trainees (external (on-school) voc. training);
          123=123  Persons in a voluntary social or ecological year or in federal volunteer service;
          124=124  Home workers; 140=140  Seamen; 141=141  Trainees in seafaring;
          142=142  Seamen in partial retirement; 143=143  Maritime pilots;
          149=149  Recipients of full pensions exempt from social security payments employed in seafaring;
          201=201  Employees registered within household cheque procedure;
          203=203  Artists and publicists liable to social security; 205=205  Casual workers;
          209=209  Marginal part-time workers registered within household cheque procedure;
          599=599  Other workers;
  gleitz             %69.0f     Transition zone
        [3 categories] 0=0  No transition zone;
          1=1  Remun. always within transition zone (between 400,01€ and 800,00€);
          2=2  Remun. both within and outside transition zone;
  grund_orig         %63.0f     Reason of cancellation/notification/termination
        [85-category external classification] e.g. 30=30  Deregistration due to end of employment; 31=31  Deregistration due to change of health insurance company; 32=32  Deregistration due to change of contribution group ...
  wo_bula            %26.0f     Place of residence: federal state (Bundesland)
        [16 categories] 1=1  Schleswig-Holstein; 2=2  Hamburg; 3=3  Lower Saxony; 4=4  Bremen;
          5=5  North Rhine-Westphalia; 6=6  Hesse; 7=7  Rhineland-Palatinate; 8=8  Baden-Wuerttemberg;
          9=9  Bavaria; 10=10  Saarland; 11=11  Berlin; 12=12  Brandenburg;
          13=13  Mecklenburg-Western Pomerania; 14=14  Saxony; 15=15  Saxony-Anhalt; 16=16  Thuringia;
  mon_erw            %15.0f     Number of days in employment
  mon_bet            %15.0f     Number of days in establishment
  mon_job            %15.0f     Number of days in job
  mon_lst            %15.0f     Number of days of benefit receipt
  tentgelt_gr        %9.0g      
  erwstat_gr         %37.0g     
        [4 categories] 1=1 Employees liable to social security; 2=2 Trainees; 3=3 Marginal part-time workers;
          4=4 Other;
  grund_gr           %9.0g      
  west_wo            %9.0g 

  Nationality indicators (1=citizenship from that country group): 
     
  german             %9.0g      
  eu_orig1           %9.0g      
  eu_orig2           %9.0g      
  eu_2000            %9.0g      
  turkey             %9.0g      
  yugoslavia         %9.0g      
  europe_other       %9.0g      
  asia               %9.0g      
  africa_me          %9.0g      
  americas           %9.0g      

--------------------------------------------------------------------------------
B.2 liab_lm_9314_v1_bhp_basis_v1.dta
--------------------------------------------------------------------------------
  Observations: 141,076    Variables: 23    Unit of observation: establishment-year

  Note: English labels: the shipped .dta stores German labels only. Text below is
  from FDZ's official English documentation for LIAB LM 7521 (a later LIAB
  Longitudinal Model vintage sharing the identical WZ73/93/03/08 and Kreis
  classification variables; Labels_LIAB_LM_7521_v1_btr_basis_en.log, FDZ-
  Datenreport 04/2024, fdz.iab.de), matched code-for-code; 2 rare WZ93-5 codes
  absent from that reference (95300, 95400) were translated directly from the
  shipped file's own German text.

  betnr              %10.0g     Establishment ID
  jahr               %10.0g     Year
  w73_3              %10.0g     Classification of economic activities 73
        [302-category external classification] e.g. 0=Growing of crops, farming of animals; 1=Industrial farming; 10=Horticulture ...
  w73_3_gen          %10.0g     w73_3 completed by extrapolation/imputation
        [302-category external classification] e.g. 0=Growing of crops, farming of animals; 1=Industrial farming; 10=Horticulture ...
  group_w73_3        %10.0g     Type of imputation w73_3
        [4 categories] 0=Original value; 1=Remains missing; 2=Extrapolated; 3=Imp. using w93_5;
  w93_3              %10.0g     Classification of economic activities 93, groups
        [224-category external classification] e.g. 11=Growing of crops; market gardening; horticulture; 12=Farming of animals; 13=Growing of crops combined with farming of animals (mixed farming) ...
  w93_5              %10.0g     Classification of economic activities 93, sub-classes
        [1064-category external classification] e.g. 1111=Growing of cereals; 1112=Growing of other crops n.e.c.; 1121=Growing of vegetables, seasoning herbs and mushrooms ...
  w93_3_gen          %10.0g     w93_3 completed by extrapolation/imputation
        [224-category external classification] e.g. 11=Growing of crops; market gardening; horticulture; 12=Farming of animals; 13=Growing of crops combined with farming of animals (mixed farming) ...
  group_w93_3        %10.0g     Type of imputation w93_3
        [5 categories] 0=Original value; 1=Remains missing; 2=Extrapolated; 3=Imp. using w03_5;
          4=2nd Imp. using w73_3;
  w03_3              %10.0g     Classification of economic activities 03, groups
        [224-category external classification] e.g. 11=Growing of crops; market gardening; horticulture; 12=Farming of animals; 13=Growing of crops combined with farming of animals (mixed farming) ...
  w03_5              %10.0g     Classification of economic activities 03, sub-classes
        [1043-category external classification] e.g. 1111=Growing of cereals; 1112=Growing of other crops n.e.c.; 1121=Growing of vegetables, seasoning herbs and mushrooms ...
  w08_3              %10.0g     Classification of economic activities 08, groups
        [274-category external classification] e.g. 11=Growing of non-perennial crops; 12=Growing of perennial crops; 13=Plant propagation ...
  w08_5              %10.0g     Classification of economic activities 08, sub-classes
        [841-category external classification] e.g. 1110=Growing of cereals (except rice), leguminous crops and oil seeds; 1120=Growing of rice; 1131=Growing of vegetables and melons ...
  grd_dat            %td        Date of first appearance
  grd_jahr           %10.0g     Year of first appearance
  lzt_dat            %td        Date of last appearance
  lzt_jahr           %10.0g     Year of last appearance
  az_ges             %10.0g     No. employees total
  az_vz              %10.0g     No. full-time (regular workers + others)
  az_gf              %10.0g     No. marginal part-time workers
  te_imp_mw          %10.0g     Mean imp. wage all full-time employees
  ao_kreis           %10.0g     Place of work - district (Kreis)
        [456-category external classification] e.g. 0=Other foreign countries; 121=Albania; 122=Bosnia and Herzegovina ...
  ao_bula            %10.0g     Place of work - federal state (Bundesland)
        [17 categories] 0=Foreign places; 1=Schleswig-Holstein; 2=Hamburg; 3=Lower Saxony; 4=Bremen;
          5=North Rhine-Westphalia; 6=Hesse; 7=Rhineland-Palatinate; 8=Baden-Wuerttemberg; 9=Bavaria;
          10=Saarland; 11=Berlin; 12=Brandenburg; 13=Mecklenburg-Western Pomerania; 14=Saxony;
          15=Saxony-Anhalt; 16=Thuringia;

--------------------------------------------------------------------------------
B.3 iabbp_2004.dta ... iabbp_2012.dta  (IAB Establishment Panel, survey waves 2004-2012)
--------------------------------------------------------------------------------
  Unit of observation: establishment (idnum), one cross-section per wave/year.

  Each raw wave file ships the FULL IAB Establishment Panel questionnaire for that
  year (see counts below): several hundred survey variables, most wave-specific
  (the IAB Establishment Panel relabels almost every question each year with a new
  wave-letter variable-name prefix, e.g. l* in 2004, m* in 2005, ... t* in 2012).
  liab_analysis/prog/4_dataset_firm_level.do (and 7_dataset_for_epsilon_estimation.do,
  16_estimate_nu.do) merge only a small subset of these variables, by establishment
  identifier idnum, into the analysis panel via Stata's merge ... keepusing(...). The
  full raw questionnaire is NOT reproduced here (a full codebook would run to several
  thousand lines across the nine waves); it is documented by the FDZ IABBP
  questionnaire/codebook releases (https://fdz.iab.de). Variable and value labels
  below are the official English versions from FDZ's IAB Establishment Panel
  documentation (Variablenliste_1993_2022_en.xlsx and Fallzahlen_*_en.txt, both
  fdz.iab.de/en/betriebsdaten/), since our raw wave files themselves only ship
  German-language labels (label language en is not available on these test files).
  Below: raw file size per wave, then the codebook entries for only the variables
  actually used by the code.

  Wave     Raw obs.   Raw vars   Weight var. used
  2004       12,050        327   hr2004q (cross-sectional extrapolation weight)
  2005       12,237        336   hr2005q (cross-sectional extrapolation weight)
  2006       12,007        340   hr2006q (cross-sectional extrapolation weight)
  2007       11,491        322   hr2007q (cross-sectional extrapolation weight)
  2008       11,568        320   hr2008q (cross-sectional extrapolation weight)
  2009       11,889        346   hr2009q (cross-sectional extrapolation weight)
  2010       12,381        333   hr2010q (cross-sectional extrapolation weight)
  2011       12,354        329   hr2011q (cross-sectional extrapolation weight)
  2012       13,001        336   hr2012q (cross-sectional extrapolation weight)

  --- iabbp_2004.dta: variables merged into the analysis panel ---
  idnum              %10.0g     Identification number
  l08                %10.0g     Type of business volume
        [5 categories] -9=item non response; 1=volume (without tax); 2=total; 3=total premiums paid; 4=budget;
  l09                %10.0g     Business volume (DM/Euro)/(Panel: EUR)
        [1 categories] -9=item non response;
  l68                %10.0g     Gross-wage/total-salary (DM/EUR)/(Panel: EUR)
        [1 categories] -9=item non response;
  l02a               %10.0g     Parts of establishment closed down
        [3 categories] -9=item non response; 0=not marked; 1=yes;
  l02b               %10.0g     Parts of establishment sourced out (nationally)
        [3 categories] -9=item non response; 0=not marked; 1=yes;
  l02c               %10.0g     Parts of establishment spun off (nationally)
        [3 categories] -9=item non response; 0=not marked; 1=yes;
  l03                %10.0g     Establishments incorporated
        [3 categories] -9=item non response; 1=yes; 2=no;
  l13a               %10.0g     Prop. total sales Western Germany (in %)
        [1 categories] -9=item non response;
  l13b               %10.0g     Prop. total sales Eastern Germany (in %)
        [1 categories] -9=item non response;
  l13c               %10.0g     Prop. sales in EMU excl. Ger., prev. year (in %)
        [1 categories] -9=item non response;
  l13d               %10.0g     Prop. sales in EU-accession count., prev. year (in %)
        [1 categories] -9=item non response;
  l13e               %10.0g     Prop. total sales other abroad, prev. year (in %)
        [1 categories] -9=item non response;
  l14                %10.0g     Prop intermed. consump. of turnover, prev. year (in %)
        [1 categories] -9=item non response;
  l16                %10.0g     Sum of all invest., prev. year (DM/EUR)/(Panel: EUR)
        [1 categories] -9=item non response;
  l91                %10.0g     Majority/sole ownership
        [7 categories] -9=item non response; 1=western germany; 2=eastern germany; 3=foreign; 4=public;
          5=no principal shareholder; 6=don't know;
  l89                %10.0g     State of establishment/office
        [5 categories] -9=item non response; 1=independent company; 2=Head Office; 3=place of business;
          4=middle-level authority;
  l64                %10.0g     Applicability of sectoral collective agreement
        [4 categories] -9=item non response; 1=industry-wide wage agreement; 2=company agreement; 3=none;
  l65                %10.0g     Orientation towards sectoral collective agreement
        [3 categories] -9=item non response; 1=yes; 2=no;
  hr2004q            %10.0g     Cross-section weighting factor

  --- iabbp_2005.dta: variables merged into the analysis panel ---
  idnum              %10.0g     Identification number
  m02aa              %10.0g     Parts of establishment closed down
        [3 categories] -9=item non response; 0=not marked; 1=yes;
  m02ab              %10.0g     Parts of establishment sourced out (nationally)
        [3 categories] -9=item non response; 0=not marked; 1=yes;
  m02ac              %10.0g     Parts of establishment spun off (nationally)
        [3 categories] -9=item non response; 0=not marked; 1=yes;
  m03                %10.0g     Establishments incorporated
        [3 categories] -9=item non response; 1=yes; 2=no;
  m12a               %10.0g     Prop. total sales Western Germany (in %)
        [1 categories] -9=item non response;
  m12b               %10.0g     Prop. total sales Eastern Germany (in %)
        [1 categories] -9=item non response;
  m12c               %10.0g     Prop. sales in EMU excl. Ger., prev. year (in %)
        [1 categories] -9=item non response;
  m12d               %10.0g     Prop. sales in EU-accession count., prev. year (in %)
        [1 categories] -9=item non response;
  m12e               %10.0g     Prop. total sales other abroad, prev. year (in %)
        [1 categories] -9=item non response;
  m13                %10.0g     Prop intermed. consump. of turnover, prev. year (in %)
        [1 categories] -9=item non response;
  m19                %10.0g     Sum of all invest., prev. year (DM/EUR)/(Panel: EUR)
        [1 categories] -9=item non response;
  m52                %10.0g     Applicability of sectoral collective agreement
        [4 categories] -9=item non response; 1=industry-wide wage agreement; 2=company agreement; 3=none;
  m53                %10.0g     Orientation towards sectoral collective agreement
        [3 categories] -9=item non response; 1=yes; 2=no;
  m91                %10.0g     Majority/sole ownership
        [7 categories] -9=item non response; 1=western germany; 2=eastern germany; 3=foreign; 4=public;
          5=no principal shareholder; 6=don't know;
  m88                %10.0g     State of establishment/office
        [5 categories] -9=item non response; 1=independent company; 2=Head Office; 3=place of business;
          4=middle-level authority;
  m07                %10.0g     Type of business volume
        [5 categories] -9=item non response; 1=volume (without tax); 2=total; 3=total premiums paid; 4=budget;
  m08                %10.0g     Business volume (DM/Euro)/(Panel: EUR)
        [1 categories] -9=item non response;
  m59                %10.0g     Gross-wage/total-salary (DM/EUR)/(Panel: EUR)
        [1 categories] -9=item non response;
  hr2005q            %10.0g     Cross-section weighting factor

  --- iabbp_2006.dta: variables merged into the analysis panel ---
  idnum              %10.0g     Identification number
  n07                %10.0g     Type of business volume
        [5 categories] -9=item non response; 1=volume (without tax); 2=total; 3=total premium paid; 4=budget;
  n08                %10.0g     Business volume (DM/Euro)/(Panel: EUR)
        [1 categories] -9=item non response;
  n83                %10.0g     Gross-wage/total-salary (DM/EUR)/(Panel: EUR)
        [1 categories] -9=item non response;
  n02aa              %10.0g     Parts of establishment closed down
        [3 categories] -9=item non response; 0=not marked; 1=yes;
  n02ab              %10.0g     Parts of establishment sourced out (nationally)
        [3 categories] -9=item non response; 0=not marked; 1=yes;
  n02ac              %10.0g     Parts of establishment spun off (nationally)
        [3 categories] -9=item non response; 0=not marked; 1=yes;
  n03                %10.0g     Establishments incorporated
        [3 categories] -9=item non response; 1=yes; 2=no;
  n09a               %10.0g     Prop. total sales Western Germany (in %)
        [1 categories] -9=item non response;
  n09b               %10.0g     Prop. total sales Eastern Germany (in %)
        [1 categories] -9=item non response;
  n09c               %10.0g     Prop. sales in EMU excl. Ger., prev. year (in %)
        [1 categories] -9=item non response;
  n09d               %10.0g     Prop. sales in EU-accession count., prev. year (in %)
        [1 categories] -9=item non response;
  n09e               %10.0g     Prop. total sales other abroad, prev. year (in %)
        [1 categories] -9=item non response;
  n10                %10.0g     Prop intermed. consump. of turnover, prev. year (in %)
        [1 categories] -9=item non response;
  n15                %10.0g     Sum of all invest., prev. year (DM/EUR)/(Panel: EUR)
        [1 categories] -9=item non response;
  n79                %10.0g     Applicability of sectoral collective agreement
        [4 categories] -9=item non response; 1=industry-wide wage agreement; 2=company agreement; 3=none;
  n80                %10.0g     Orientation towards sectoral collective agreement
        [3 categories] -9=item non response; 1=yes; 2=no;
  n86                %10.0g     State of establishment/office
        [5 categories] -9=item non response; 1=independent company; 2=Head Office; 3=place of business;
          4=middle-level authority;
  n92                %10.0g     Majority/sole ownership
        [7 categories] -9=item non response; 1=western germany; 2=eastern germany; 3=foreign; 4=public;
          5=no principal shareholder; 6=don't know;
  hr2006q            %10.0g     Cross-section weighting factor

  --- iabbp_2007.dta: variables merged into the analysis panel ---
  idnum              %10.0g     Identification number
  o08                %10.0g     Type of business volume
        [5 categories] -9=item non response; 1=volume (without tax); 2=total; 3=total premium paid; 4=budget;
  o09                %10.0g     Business volume (DM/Euro)/(Panel: EUR)
        [1 categories] -9=item non response;
  o85                %10.0g     Gross-wage/total-salary (DM/EUR)/(Panel: EUR)
        [1 categories] -9=item non response;
  o02a               %10.0g     Parts of establishment closed down
        [3 categories] -9=item non response; 0=not marked; 1=yes;
  o02b               %10.0g     Parts of establishment sourced out (nationally)
        [3 categories] -9=item non response; 0=not marked; 1=yes;
  o02c               %10.0g     Parts of establishment sourced out (abroad)
        [3 categories] -9=item non response; 0=not marked; 1=yes;
  o02d               %10.0g     Parts of establishment spun off (nationally)
        [3 categories] -9=item non response; 0=not marked; 1=yes;
  o02e               %10.0g     Parts of establishment spun off (abroad)
        [3 categories] -9=item non response; 0=not marked; 1=yes;
  o04                %10.0g     Establishments incorporated
        [3 categories] -9=item non response; 1=yes; 2=no;
  o10a               %10.0g     Prop. total sales Western Germany (in %)
        [1 categories] -9=item non response;
  o10b               %10.0g     Prop. total sales Eastern Germany (in %)
        [1 categories] -9=item non response;
  o10c               %10.0g     Prop. sales in EMU excl. Ger., prev. year (in %)
        [1 categories] -9=item non response;
  o10d               %10.0g     Prop. sales in EU-accession count., prev. year (in %)
        [1 categories] -9=item non response;
  o10e               %10.0g     Prop. total sales other abroad, prev. year (in %)
        [1 categories] -9=item non response;
  o12                %10.0g     Prop intermed. consump. of turnover, prev. year (in %)
        [1 categories] -9=item non response;
  o18                %10.0g     Sum of all invest., prev. year (DM/EUR)/(Panel: EUR)
        [1 categories] -9=item non response;
  o81                %10.0g     Applicability of sectoral collective agreement
        [4 categories] -9=item non response; 1=industry-wide wage agreement; 2=company agreement; 3=none;
  o82                %10.0g     Orientation towards sectoral collective agreement
        [3 categories] -9=item non response; 1=yes; 2=no;
  o90                %10.0g     State of establishment/office
        [5 categories] -9=item non response; 1=independent company; 2=head office; 3=place of business;
          4=middle-level authority;
  o92                %10.0g     Majority/sole ownership
        [7 categories] -9=item non response; 1=western germany; 2=eastern germany; 3=foreign; 4=public;
          5=no principal shareholder; 6=don't know;
  hr2007q            %10.0g     Cross-section weighting factor

  --- iabbp_2008.dta: variables merged into the analysis panel ---
  idnum              %10.0g     Identification number
  p09                %10.0g     Type of business volume
        [5 categories] -9=item non response; 1=volume (without tax); 2=total; 3=total premium paid; 4=budget;
  p10                %10.0g     Business volume (DM/Euro)/(Panel: EUR)
        [1 categories] -9=item non response;
  p63                %10.0g     Gross-wage/total-salary (DM/EUR)/(Panel: EUR)
        [1 categories] -9=item non response;
  p02a               %10.0g     Parts of establishment closed down
        [3 categories] -9=item non response; 0=not marked; 1=yes;
  p02b               %10.0g     Parts of establishment sourced out (nationally)
        [3 categories] -9=item non response; 0=not marked; 1=yes;
  p02c               %10.0g     Parts of establishment spun off (nationally)
        [3 categories] -9=item non response; 0=not marked; 1=yes;
  p03                %10.0g     Establishments incorporated
        [3 categories] -9=item non response; 1=yes; 2=no;
  p11a               %10.0g     Prop. total sales Western Germany (in %)
        [1 categories] -9=item non response;
  p11b               %10.0g     Prop. total sales Eastern Germany (in %)
        [1 categories] -9=item non response;
  p11c               %10.0g     Prop. business volume abroad, prev. year (in %)
        [1 categories] -9=item non response;
  p13                %10.0g     Prop intermed. consump. of turnover, prev. year (in %)
        [1 categories] -9=item non response;
  p19                %10.0g     Sum of all invest., prev. year (DM/EUR)/(Panel: EUR)
        [1 categories] -9=item non response;
  p59                %10.0g     Applicability of sectoral collective agreement
        [4 categories] -9=item non response; 1=industry-wide wage agreement; 2=company agreement; 3=none;
  p60                %10.0g     Orientation towards sectoral collective agreement
        [3 categories] -9=item non response; 1=yes; 2=no;
  p91                %10.0g     State of establishment/office
        [5 categories] -9=item non response; 1=independent company; 2=head office; 3=place of business;
          4=middle-level authority;
  p94                %10.0g     Majority/sole ownership
        [7 categories] -9=item non response; 1=western germany; 2=eastern germany; 3=foreign; 4=public;
          5=no principal shareholder; 6=don't know;
  hr2008q            %10.0g     Cross-section weighting factor

  --- iabbp_2009.dta: variables merged into the analysis panel ---
  idnum              %10.0g     Identification number
  q06                %10.0g     Type of business volume
        [5 categories] -9=item non response; 1=volume (without tax); 2=total; 3=total premium paid; 4=budget;
  q07                %10.0g     Business volume (DM/Euro)/(Panel: EUR)
        [1 categories] -9=item non response;
  q43                %10.0g     Gross-wage/total-salary (DM/EUR)/(Panel: EUR)
        [1 categories] -9=item non response;
  q02a               %10.0g     Parts of establishment closed down
        [3 categories] -9=item non response; 0=not marked; 1=yes;
  q02b               %10.0g     Parts of establishment sourced out (nationally)
        [3 categories] -9=item non response; 0=not marked; 1=yes;
  q02c               %10.0g     Parts of establishment spun off (nationally)
        [3 categories] -9=item non response; 0=not marked; 1=yes;
  q02d               %10.0g     No parts of estab. closed, sourced-out, or spun-off
        [3 categories] -9=item non response; 0=not marked; 1=yes;
  q03                %10.0g     Establishments incorporated
        [3 categories] -9=item non response; 1=yes; 2=no;
  q08a               %10.0g     Prop. total sales Western Germany (in %)
        [1 categories] -9=item non response;
  q08b               %10.0g     Prop. total sales Eastern Germany (in %)
        [1 categories] -9=item non response;
  q08c               %10.0g     Prop. business volume abroad, prev. year (in %)
        [1 categories] -9=item non response;
  q10                %10.0g     Prop intermed. consump. of turnover, prev. year (in %)
        [1 categories] -9=item non response;
  q17                %10.0g     Sum of all invest., prev. year (DM/EUR)/(Panel: EUR)
        [1 categories] -9=item non response;
  q39                %10.0g     Applicability of sectoral collective agreement
        [4 categories] -9=item non response; 1=industry-wide wage agreement; 2=company agreement; 3=none;
  q40                %10.0g     Orientation towards sectoral collective agreement
        [3 categories] -9=item non response; 1=yes; 2=no;
  q88                %10.0g     State of establishment/office
        [5 categories] -9=item non response; 1=independent company; 2=head office; 3=place of business;
          4=middle-level authority;
  q91                %10.0g     Majority/sole ownership
        [7 categories] -9=item non response; 1=western germany; 2=eastern germany; 3=foreign; 4=public;
          5=no principal shareholder; 6=don't know;
  hr2009q            %10.0g     Cross-section weighting factor

  --- iabbp_2010.dta: variables merged into the analysis panel ---
  idnum              %10.0g     Identification number
  r87                %10.0g     Majority/sole ownership
        [7 categories] -9=item non response; 1=western germany; 2=eastern germany; 3=foreign; 4=public;
          5=no principal shareholder; 6=don't know;
  r83                %10.0g     State of establishment/office
        [5 categories] -9=item non response; 1=independent company; 2=head office; 3=place of business;
          4=middle-level authority;
  r51                %10.0g     Orientation towards sectoral collective agreement
        [3 categories] -9=item non response; 1=yes; 2=no;
  r50                %10.0g     Applicability of sectoral collective agreement
        [4 categories] -9=item non response; 1=industry-wide wage agreement; 2=company agreement; 3=none;
  r20                %10.0g     Sum of all invest., prev. year (DM/EUR)/(Panel: EUR)
        [1 categories] -9=item non response;
  r13                %10.0g     Prop intermed. consump. of turnover, prev. year (in %)
        [1 categories] -9=item non response;
  r11c               %10.0g     Prop. business volume abroad, prev. year (in %)
        [1 categories] -9=item non response;
  r11b               %10.0g     Prop. total sales Eastern Germany (in %)
        [1 categories] -9=item non response;
  r11a               %10.0g     Prop. total sales Western Germany (in %)
        [1 categories] -9=item non response;
  r03                %10.0g     Establishments incorporated
        [3 categories] -9=item non response; 1=yes; 2=no;
  r09                %10.0g     Type of business volume
        [5 categories] -9=item non response; 1=volume (without tax); 2=total; 3=total premium paid; 4=budget;
  r10                %10.0g     Business volume (DM/Euro)/(Panel: EUR)
        [1 categories] -9=item non response;
  r54                %10.0g     Gross-wage/total-salary (DM/EUR)/(Panel: EUR)
        [1 categories] -9=item non response;
  r02a               %10.0g     Parts of establishment closed down
        [3 categories] -9=item non response; 0=not marked; 1=yes;
  r02b               %10.0g     Parts of establishment sourced out (nationally)
        [3 categories] -9=item non response; 0=not marked; 1=yes;
  r02c               %10.0g     Parts of establishment sourced out (abroad)
        [3 categories] -9=item non response; 0=not marked; 1=yes;
  r02d               %10.0g     Parts of establishment spun off (nationally)
        [3 categories] -9=item non response; 0=not marked; 1=yes;
  r02e               %10.0g     Parts of establishment spun off (abroad)
        [3 categories] -9=item non response; 0=not marked; 1=yes;
  r02f               %10.0g     No parts of estab. closed, sourced-out, or spun-off
        [3 categories] -9=item non response; 0=not marked; 1=yes;
  hr2010q            %10.0g     Cross-section weighting factor

  --- iabbp_2011.dta: variables merged into the analysis panel ---
  idnum              %10.0g     Identification number
  s80b               %10.0g     Majority/sole ownership
        [6 categories] -9=item non response; 1=western germany; 2=eastern germany; 3=foreign; 4=non majority owner;
          5=unknown;
  s84                %10.0g     State of establishment/office
        [5 categories] -9=item non response; 1=1; 2=2; 3=3; 4=4;
  s53                %10.0g     Wages/salaries above negotiated wage
        [3 categories] -9=item non response; 1=1; 2=2;
  s52                %10.0g     Applicability of sectoral collective agreement
        [4 categories] -9=item non response; 1=branch company agreement; 2=company agreement; 3=none;
  s17                %10.0g     Sum of all invest., prev. year (DM/EUR)/(Panel: EUR)
        [1 categories] -9=item non response;
  s11                %10.0g     Prop intermed. consump. of turnover, prev. year (in %)
        [1 categories] -9=item non response;
  s09c               %10.0g     Prop. business volume abroad, prev. year (in %)
        [1 categories] -9=item non response;
  s09b               %10.0g     Prop. total sales Eastern Germany (in %)
        [1 categories] -9=item non response;
  s09a               %10.0g     Prop. total sales Western Germany (in %)
        [1 categories] -9=item non response;
  s03                %10.0g     Establishments incorporated
        [3 categories] -9=item non response; 1=yes; 2=no;
  s02d               %10.0g     No parts of estab. closed, sourced-out, or spun-off
        [3 categories] -9=item non response; 0=not marked; 1=yes;
  s02a               %10.0g     Parts of establishment closed down
        [3 categories] -9=item non response; 0=not marked; 1=yes;
  s02b               %10.0g     Parts of establishment sourced out (nationally)
        [3 categories] -9=item non response; 0=not marked; 1=yes;
  s02c               %10.0g     Parts of establishment spun off (nationally)
        [3 categories] -9=item non response; 0=not marked; 1=yes;
  s58                %10.0g     Gross-wage/total-salary (DM/EUR)/(Panel: EUR)
        [1 categories] -9=item non response;
  s08                %10.0g     Business volume (DM/Euro)/(Panel: EUR)
        [1 categories] -9=item non response;
  s07                %10.0g     Type of business volume
        [5 categories] -9=item non response; 1=volume (without tax); 2=total; 3=total premium paid; 4=budget;
  hr2011q            %10.0g     Cross-section weighting factor

  --- iabbp_2012.dta: variables merged into the analysis panel ---
  idnum              %10.0g     Identification number
  t80                %10.0g     State of establishment/office
        [5 categories] -9=item non response; 1=independent company; 2=head office; 3=place of business;
          4=middle-level authority;
  t79b               %10.0g     Majority/sole ownership
        [6 categories] -9=item non response; 1=western germany; 2=eastern germany; 3=foreign; 4=non majority owner;
          5=unknown;
  t48                %10.0g     Applicability of sectoral collective agreement
        [4 categories] -9=item non response; 1=branch company agreement; 2=company agreement; 3=none;
  t49                %10.0g     Orientation towards sectoral collective agreement
        [3 categories] -9=item non response; 1=yes; 2=no;
  t52                %10.0g     Gross-wage/total-salary (DM/EUR)/(Panel: EUR)
        [1 categories] -9=item non response;
  t21                %10.0g     Sum of all invest., prev. year (DM/EUR)/(Panel: EUR)
        [1 categories] -9=item non response;
  t11                %10.0g     Prop intermed. consump. of turnover, prev. year (in %)
        [1 categories] -9=item non response;
  t09a               %10.0g     Prop. total sales Western Germany (in %)
        [1 categories] -9=item non response;
  t09b               %10.0g     Prop. total sales Eastern Germany (in %)
        [1 categories] -9=item non response;
  t09c               %10.0g     Prop. business volume abroad, prev. year (in %)
        [1 categories] -9=item non response;
  t08                %10.0g     Business volume (DM/Euro)/(Panel: EUR)
        [1 categories] -9=item non response;
  t07                %10.0g     Type of business volume
        [5 categories] -9=item non response; 1=volume (without tax); 2=total; 3=total premium paid; 4=budget;
  t02a               %10.0g     Parts of establishment closed down
        [3 categories] -9=item non response; 0=not marked; 1=yes;
  t02b               %10.0g     Parts of establishment sourced out (nationally)
        [3 categories] -9=item non response; 0=not marked; 1=yes;
  t02c               %10.0g     Parts of establishment spun off (nationally)
        [3 categories] -9=item non response; 0=not marked; 1=yes;
  t02d               %10.0g     No parts of estab. closed, sourced-out, or spun-off
        [3 categories] -9=item non response; 0=not marked; 1=yes;
  t03                %10.0g     Establishments incorporated
        [3 categories] -9=item non response; 1=yes; 2=no;
  hr2012q            %10.0g     Cross-section weighting factor

--------------------------------------------------------------------------------
B.4 cpigermany.dta
--------------------------------------------------------------------------------
  Observations: 49    Variables: 4    Unit of observation: year (annual CPI series)

  Note: None of these variables carry Stata value/variable labels; names are self-
  explanatory. jahr = year; rate/yrly = CPI index series; deflator = the factor
  actually applied (merged on jahr, then wagebill/turnover/investment variables
  are multiplied by deflator) in 4_dataset_firm_level.do and
  6_dataset_for_regressions_validation.do to convert nominal EUR to real 2010 EUR
  (see README.txt Section 2.3, Destatis CPI series).

  jahr               %8.0g      
  rate               %8.0g      
  yrly               %8.0g      
  deflator           %8.0g      

--------------------------------------------------------------------------------
B.5 local labor markets.dta
--------------------------------------------------------------------------------
  Observations: 419    Variables: 20    Unit of observation: Kreis (district)

  Note: None of these variables carry Stata value/variable labels. This is the Kreis
  (district) -> functional local-labour-market-region concordance of Kropp &
  Schwengler (2011) (see README.txt Section 8.3 for the data citation), provided directly
  by the IAB. The suffixed variable groups (plain, "2", "11") correspond to
  alternate vintages/delineations of the same Kreis->region mapping (ao_kreis
  identifies the district; *_name gives its name; local_labor* gives the assigned
  local-labour-market-region code; *_share gives the population/employment share
  used to allocate split districts). liab_analysis/prog/2_local_labor_markets.do
  uses only ao_kreis11 and local_labor11 to build the crosswalk applied elsewhere
  in the pipeline.

  ao_kreis           %10.0g     ao_kreis
  ao_kreis_name      %33s       ao_kreis_name
  region             %10.0g     region
  region_name        %22s       region_name
  region_share       %10.0g     region_share
  region2            %10.0g     region2
  region2_name       %22s       region2_name
  region2_share      %10.0g     region2_share
  local_labor        %10.0g     local_labor
  local_labor_name   %22s       local_labor_name
  local_labor_share  %10.0g     local_labor_share
  local_labor2       %10.0g     local_labor2
  local_labor2_name  %22s       local_labor2_name
  local_labor2_share %10.0g     local_labor2_share
  ao_kreis11         %10.0g     ao_kreis11
  ao_kreis11_name    %27s       ao_kreis11_name
  region11           %10.0g     region11
  region11_name      %22s       region11_name
  local_labor11      %10.0g     local_labor11
  local_labor11_name %20s       local_labor11_name

--------------------------------------------------------------------------------
B.6 Onet_Peri_Sparber_beruf_gr.dta
--------------------------------------------------------------------------------
  Observations: 120    Variables: 15    Unit of observation: occupation (beruf_gr, German classification)

  Note: See README.txt Section 2.2 for provenance (O*NET task scores mapped from the
  U.S. occ1990 classification onto German beruf_gr categories, following Peri and
  Sparber 2009). beruf_gr is the merge key into liab_lm_9314_v1_pers.dta /
  sieed_7518_v1.dta (used in 18_immigrant_comparative_advantage.do); beruf_desc is
  the occupation title; the remaining variables are mean O*NET task-content scores
  (manual, limbs, strength, body, language, oral, written, cognitive, perception,
  visual, hearing, vocal) and Nobs is the number of underlying observations behind
  each occupation's mean.

  beruf_gr           %9.0g      
  beruf_desc         %132s      
  manual             %9.0g      (mean) manual
  limbs              %9.0g      (mean) limbs
  strength           %9.0g      (mean) strength
  body               %9.0g      (mean) body
  language           %9.0g      (mean) language
  oral               %9.0g      (mean) oral
  written            %9.0g      (mean) written
  cognitive          %9.0g      (mean) cognitive
  perception         %9.0g      (mean) perception
  visual             %9.0g      (mean) visual
  hearing            %9.0g      (mean) hearing
  vocal              %9.0g      (mean) vocal
  Nobs               %9.0g      

================================================================================
End of Appendix A.
================================================================================