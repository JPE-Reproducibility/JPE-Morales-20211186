## Filepaths Analysis Details

**/Users/florianoswald/actions-runner/_work/JPE-Morales-20211186/JPE-Morales-20211186/replication-package/Brinatti_Morales_Replication_Package/liab_analysis/prog/11_epsilon_pre_trend_test.do**

- Line 63, unix : gen l_emp_imm_eff_nat = log(emp_imm_eff/nemp_nat_ft)

**/Users/florianoswald/actions-runner/_work/JPE-Morales-20211186/JPE-Morales-20211186/replication-package/Brinatti_Morales_Replication_Package/liab_analysis/prog/estimate_nu_cont.m**

- Line 24, unix : %(gamma(1 - 2/0.6745) / (gamma(1 - 1/0.6745)^2)) - 1;
- Line 26, unix : %(gamma(1 - 2/4.0288) / (gamma(1 - 1/4.0288)^2)) - 1;

**/Users/florianoswald/actions-runner/_work/JPE-Morales-20211186/JPE-Morales-20211186/replication-package/Brinatti_Morales_Replication_Package/model_analysis/code/model/heterogeneous/Equations_equilibrium/equilLoop.m**

- Line 3, unix : % equilLoop  Residual of the general-equilibrium system at prices/wages x.
- Line 79, unix : pi_g_t=((wd/Pg)^kappa)/((wd/Pg)^kappa+(wd_nt/Pg)^kappa);
- Line 80, unix : pi_g_nt=((wd_nt/Pg)^kappa)/((wd/Pg)^kappa+(wd_nt/Pg)^kappa);

**/Users/florianoswald/actions-runner/_work/JPE-Morales-20211186/JPE-Morales-20211186/replication-package/Brinatti_Morales_Replication_Package/liab_analysis/prog/10_epsilon_estimation.do**

- Line 12, unix : log(WageBill_imm/WageBill_nat)_jt = beta log(ImmEff/NatEmp)_jt + FE + u
- Line 63, unix : gen l_emp_imm_eff_nat=log(emp_imm_eff/nemp_nat_ft)

**/Users/florianoswald/actions-runner/_work/JPE-Morales-20211186/JPE-Morales-20211186/replication-package/Brinatti_Morales_Replication_Package/liab_analysis/prog/6_dataset_for_regressions_validation.do**

- Line 153, unix : gen wb_mig_ger = wb_mig/wb_ger
- Line 159, unix : gen cost_sales 		= cost/turnover

**/Users/florianoswald/actions-runner/_work/JPE-Morales-20211186/JPE-Morales-20211186/replication-package/Brinatti_Morales_Replication_Package/sieed_analysis/prog/2a_results_event_studies.do**

- Line 82, unix : gen ind_2dig=floor(w93_3_gen/10)
- Line 150, unix : gen employment_relative=emp_/emp_tot_2010
- Line 153, unix : gen imm_share=emp_/emp_imm
- Line 156, unix : gen employment_relative_new=emp_new_hire_/emp_tot_2010
- Line 157, unix : gen employment_relative_new06=emp_new_hire_/emp_tot_2006
- Line 163, unix : gen employment_relative_ent=emp_new_ent_/emp_tot_2010
- Line 164, unix : gen employment_relative_ent06=emp_new_ent_/emp_tot_2006
- Line 238, unix : forval x=2006/2018 {

**/Users/florianoswald/actions-runner/_work/JPE-Morales-20211186/JPE-Morales-20211186/replication-package/Brinatti_Morales_Replication_Package/sieed_analysis/prog/1a_create_data_event_study.do**

- Line 319, unix : forval x=2002/2018 {

**/Users/florianoswald/actions-runner/_work/JPE-Morales-20211186/JPE-Morales-20211186/replication-package/Brinatti_Morales_Replication_Package/sieed_analysis/prog/2c_results_figA5.do**

- Line 99, unix : gen nhir_imm_nat 		= nhir_imm_ft/nhir_nat_ft

**/Users/florianoswald/actions-runner/_work/JPE-Morales-20211186/JPE-Morales-20211186/replication-package/Brinatti_Morales_Replication_Package/liab_analysis/prog/7_dataset_for_epsilon_estimation.do**

- Line 219, unix : gen ao_bula=floor(ao_kreis/1000)
- Line 224, unix : gen ind_2dig=floor(w93_3_gen/10)
- Line 292, unix : gen share_03_1=nemp_orkt/nemp_imm_rkt if jahr==2003
- Line 295, unix : gen sharew_03_1=wemp_orkt/wemp_imm_rkt if jahr==2003
- Line 303, unix : gen share_03_1_f=nemp_oft/nemp_imm_ft if jahr==2003
- Line 306, unix : gen sharew_03_1_f=wemp_oft/wemp_imm_ft if jahr==2003
- Line 458, unix : gen l_wbill_imm_nat = log(wemp_imm_ft/wemp_nat_ft)
- Line 459, unix : gen l_emp_imm_nat   = log(nemp_imm_ft/nemp_nat_ft)
- Line 460, unix : gen wb_mig_ger	    = wemp_imm_ft/wemp_nat_ft
- Line 982, unix : gen cost_sales 	= cost/turnover
- Line 993, unix : gen premium 	= (wemp_imm_ft/nemp_imm_ft)/(wemp_nat_ft/nemp_nat_ft)

**/Users/florianoswald/actions-runner/_work/JPE-Morales-20211186/JPE-Morales-20211186/replication-package/Brinatti_Morales_Replication_Package/master_file.do**

- Line 57, unix : Analysis (submit in Presentation/Publication Mode):
- Line 97, unix : Analysis (submit in Presentation/Publication Mode):
- Line 136, unix : 1. MATLAB: scripts/master.m  - calibration, counterfactuals, policies,
- Line 138, unix : D1-D3; Section 6.1/6.3 blocks)
- Line 139, unix : 2. Stata:  scripts/master.do - plots (Figures 3, 4, D1, D2)
- Line 143, unix : /Applications/MATLAB_R2023b.app/bin/matlab

**/Users/florianoswald/actions-runner/_work/JPE-Morales-20211186/JPE-Morales-20211186/replication-package/Brinatti_Morales_Replication_Package/liab_analysis/prog/13_estimate_epsilon_sigma.do**

- Line 59, unix : gen l_emp_imm_eff_nat=log(emp_imm_eff/nemp_nat_ft)
- Line 85, unix : gen markdown1 = 1/markup1

**/Users/florianoswald/actions-runner/_work/JPE-Morales-20211186/JPE-Morales-20211186/replication-package/Brinatti_Morales_Replication_Package/model_analysis/code/model/heterogeneous/Other_functions/Calibration_Res.m**

- Line 152, unix : % Diagonal weight matrix. Each diagonal entry is 1/data^2; some moments

**/Users/florianoswald/actions-runner/_work/JPE-Morales-20211186/JPE-Morales-20211186/replication-package/Brinatti_Morales_Replication_Package/liab_analysis/prog/8_validation_regressions.do**

- Line 387, unix : forval x=1/6 {
- Line 396, unix : forval x=7/12 {

**/Users/florianoswald/actions-runner/_work/JPE-Morales-20211186/JPE-Morales-20211186/replication-package/Brinatti_Morales_Replication_Package/model_analysis/code/model/homogeneous/Equations_equilibrium/equilLoop.m**

- Line 3, unix : % equilLoop  Residual of the general-equilibrium system at prices/wages x.
- Line 84, unix : pi_g_t=((wd/Pg)^kappa)/((wd/Pg)^kappa+(wd_nt/Pg)^kappa);
- Line 85, unix : pi_g_nt=((wd_nt/Pg)^kappa)/((wd/Pg)^kappa+(wd_nt/Pg)^kappa);
- Line 124, unix : sd_nexp_nt                = num_nt/den_nt;
- Line 134, unix : sd_nexp                = num_t/den_t;
- Line 142, unix : sd_exp             = num_t/den_t;

**/Users/florianoswald/actions-runner/_work/JPE-Morales-20211186/JPE-Morales-20211186/replication-package/Brinatti_Morales_Replication_Package/liab_analysis/prog/15_epsilon_shift_share.do**

- Line 17, unix : FDZ note: The first preserve/restore block (Table 1) outputs estout with
- Line 67, unix : foreach x of numlist 2/10 {
- Line 107, unix : gen l_emp_imm_eff_nat=log(emp_imm_eff/nemp_nat_ft)
- Line 137, unix : foreach x of numlist 2/10 {

**/Users/florianoswald/actions-runner/_work/JPE-Morales-20211186/JPE-Morales-20211186/replication-package/Brinatti_Morales_Replication_Package/model_analysis/code/stata_plots/Counterfactual_plots_policies.do**

- Line 255, unix : forvalues i = 1/4 {

**/Users/florianoswald/actions-runner/_work/JPE-Morales-20211186/JPE-Morales-20211186/replication-package/Brinatti_Morales_Replication_Package/model_analysis/code/model/heterogeneous/Equations_equilibrium/profitsnimm.m**

- Line 8, unix : %   optimal hiring/exporting status.

**/Users/florianoswald/actions-runner/_work/JPE-Morales-20211186/JPE-Morales-20211186/replication-package/Brinatti_Morales_Replication_Package/liab_analysis/prog/1_cleaning_data.do**

- Line 96, unix : gen share_in_estab=tot_days/360
- Line 112, unix : gen daily_wage=tot_earn/tot_days

**/Users/florianoswald/actions-runner/_work/JPE-Morales-20211186/JPE-Morales-20211186/replication-package/Brinatti_Morales_Replication_Package/liab_analysis/prog/4_dataset_firm_level.do**

- Line 63, unix : gen ind_2dig=floor(w93_3_gen/10)

**/Users/florianoswald/actions-runner/_work/JPE-Morales-20211186/JPE-Morales-20211186/replication-package/Brinatti_Morales_Replication_Package/liab_analysis/prog/16_estimate_nu.do**

- Line 45, unix : The CV^2 is computed as (sd/mean)^2 from the sum output.

**/Users/florianoswald/actions-runner/_work/JPE-Morales-20211186/JPE-Morales-20211186/replication-package/Brinatti_Morales_Replication_Package/liab_analysis/prog/18_immigrant_comparative_advantage.do**

- Line 138, unix : PANEL B SCALARS — compute BEFORE any preserve/restore so they survive
- Line 165, unix : Single preserve/restore — no nesting.
- Line 282, unix : forvalues n = 2/10 {
- Line 288, unix : forvalues n = 2/10 {
- Line 295, unix : forvalues n = 2/10 {
- Line 303, unix : Single preserve/restore — scalars from above are still in memory.
- Line 524, unix : forvalues n = 1/10 {
- Line 578, unix : forvalues n = 2/10 {
- Line 609, unix : forvalues n = 2/10 {

**/Users/florianoswald/actions-runner/_work/JPE-Morales-20211186/JPE-Morales-20211186/replication-package/Brinatti_Morales_Replication_Package/liab_analysis/prog/19_moments_calculation.do**

- Line 78, unix : gen markdown1 = 1/markup1
- Line 203, unix : gen dom_share=wbill_german_tot/wbill_tot_tot
- Line 295, unix : gen export_to_dom_rev=(exports_foreign/100)/(1-(exports_foreign/100))

**/Users/florianoswald/actions-runner/_work/JPE-Morales-20211186/JPE-Morales-20211186/replication-package/Brinatti_Morales_Replication_Package/liab_analysis/prog/solve_nu.m**

- Line 3, unix : % beta = Gamma(1 - 2/x) / (Gamma(1 - 1/x))^2 - 1
- Line 6, unix : equation = @(x) (gamma(1 - 2/x) / (gamma(1 - 1/x)^2)) - (beta_val + 1);
- Line 16, windows : fprintf('The value of x for beta_val = %.4f is: %.4f\n', beta_val, x);

**/Users/florianoswald/actions-runner/_work/JPE-Morales-20211186/JPE-Morales-20211186/replication-package/Brinatti_Morales_Replication_Package/liab_analysis/prog/master.do**

- Line 23, unix : Analysis (submit in Presentation/Publication Mode):

**/Users/florianoswald/actions-runner/_work/JPE-Morales-20211186/JPE-Morales-20211186/replication-package/Brinatti_Morales_Replication_Package/liab_analysis/prog/12_epsilon_firm_characteristics.do**

- Line 53, unix : gen l_emp_imm_eff_nat=log(emp_imm_eff/nemp_nat_ft)

**/Users/florianoswald/actions-runner/_work/JPE-Morales-20211186/JPE-Morales-20211186/replication-package/Brinatti_Morales_Replication_Package/model_analysis/code/model/Export_latex_tables.m**

- Line 7, unix : %   code/model/heterogeneous/Results_counterfactuals/Counterfactual_heterogeneous_open.mat
- Line 8, unix : %   code/model/heterogeneous/Results_counterfactuals/Counterfactual_heterogeneous_closed.mat
- Line 9, unix : %   code/model/homogeneous/Results_counterfactuals/Counterfactual_homogeneous_open.mat
- Line 10, unix : %   code/model/homogeneous/Results_counterfactuals/Counterfactual_homogeneous_closed.mat
- Line 11, unix : %   code/model/policies/Counterfactual_to_compare_policies_{basef,top10,bottom_onlyt,top_onlyt,nobasef}.mat
- Line 12, unix : %   code/model/heterogeneous/Setup_PP.m + Calibration_Res.m  (Table 1 and C.7)
- Line 16, unix : %   output/tables/table1.tex
- Line 17, unix : %   output/tables/table2.tex
- Line 18, unix : %   output/tables/tableC7.tex
- Line 19, unix : %   output/tables/tableD1.tex
- Line 20, unix : %   output/tables/tableD2.tex
- Line 21, unix : %   output/tables/tableD3.tex
- Line 22, unix : %   output/tables/sec61_aggregates.tex
- Line 23, unix : %   output/tables/sec61_dollar_gains.tex
- Line 24, unix : %   output/tables/sec63_decomposition.tex
- Line 47, unix : 'code/model/heterogeneous/Results_counterfactuals/Counterfactual_heterogeneous_open.mat'));
- Line 49, unix : 'code/model/heterogeneous/Results_counterfactuals/Counterfactual_heterogeneous_closed.mat'));
- Line 51, unix : 'code/model/homogeneous/Results_counterfactuals/Counterfactual_homogeneous_open.mat'));
- Line 53, unix : 'code/model/homogeneous/Results_counterfactuals/Counterfactual_homogeneous_closed.mat'));
- Line 57, unix : pol_dir = fullfile(pkg_root, 'code/model/policies/Results_counterfactuals');
- Line 88, windows : fprintf(fid, '%% Auto-generated by Export_latex_tables.m\n');
- Line 90, windows : fprintf(fid, '\\toprule\n');
- Line 92, windows : fprintf(fid, '\\midrule\n');
- Line 100, windows : fprintf(fid, '\\bottomrule\n');
- Line 103, windows : fprintf('Wrote %s\n', fullfile(tables_out, 'table1.tex'));
- Line 120, windows : fprintf(fid, '%% Auto-generated by Export_latex_tables.m\n');
- Line 122, windows : fprintf(fid, '\\toprule\n');
- Line 123, unix : fprintf(fid, ' & Open to Trade & Trade Autarky & Autarky/Open \\\\\n');
- Line 124, windows : fprintf(fid, '\\midrule\n');
- Line 127, unix : fprintf(fid, 'Homogeneous/Heterogeneous       & %.0f\\%%   &              &           \\\\\n', ratio_homog_heterog_open);
- Line 128, windows : fprintf(fid, '\\bottomrule\n');
- Line 131, windows : fprintf('Wrote %s\n', fullfile(tables_out, 'table2.tex'));
- Line 142, windows : fprintf(fid, '%% Auto-generated by Export_latex_tables.m\n');
- Line 144, windows : fprintf(fid, '\\toprule\n');
- Line 146, windows : fprintf(fid, '\\midrule\n');
- Line 150, windows : fprintf(fid, '\\bottomrule\n');
- Line 153, windows : fprintf('Wrote %s\n', fullfile(tables_out, 'sec61_aggregates.tex'));
- Line 200, unix : 'code/model/heterogeneous/Results_counterfactuals/Counterfactual_heterogeneous_open.mat'), ...
- Line 229, windows : fprintf(fid, '%% Auto-generated by Export_latex_tables.m\n');
- Line 231, windows : fprintf(fid, '\\toprule\n');
- Line 233, windows : fprintf(fid, '\\midrule\n');
- Line 237, windows : fprintf(fid, '\\bottomrule\n');
- Line 240, windows : fprintf('Wrote %s\n', fullfile(tables_out, 'sec61_dollar_gains.tex'));
- Line 254, windows : fprintf(fid, '%% Auto-generated by Export_latex_tables.m\n');
- Line 256, windows : fprintf(fid, '\\toprule\n');
- Line 258, windows : fprintf(fid, '\\midrule\n');
- Line 262, windows : fprintf(fid, '\\bottomrule\n');
- Line 265, windows : fprintf('Wrote %s\n', fullfile(tables_out, 'sec63_decomposition.tex'));
- Line 272, windows : fprintf(fid, '%% Auto-generated by Export_latex_tables.m\n');
- Line 274, windows : fprintf(fid, '\\toprule\n');
- Line 276, windows : fprintf(fid, '\\midrule\n');
- Line 284, windows : fprintf(fid, '\\bottomrule\n');
- Line 287, windows : fprintf('Wrote %s\n', fullfile(tables_out, 'tableC7.tex'));
- Line 294, windows : fprintf(fid, '%% Auto-generated by Export_latex_tables.m\n');
- Line 296, windows : fprintf(fid, '\\toprule\n');
- Line 300, windows : fprintf(fid, '\\midrule\n');
- Line 305, windows : fprintf(fid, '\\midrule\n');
- Line 309, windows : fprintf(fid, '\\bottomrule\n');
- Line 312, windows : fprintf('Wrote %s\n', fullfile(tables_out, 'tableD1.tex'));
- Line 319, windows : fprintf(fid, '%% Auto-generated by Export_latex_tables.m\n');
- Line 321, windows : fprintf(fid, '\\toprule\n');
- Line 323, windows : fprintf(fid, '\\midrule\n');
- Line 326, windows : fprintf(fid, '\\midrule\n');
- Line 333, windows : fprintf(fid, '\\midrule\n');
- Line 342, windows : fprintf(fid, '\\bottomrule\n');
- Line 345, windows : fprintf('Wrote %s\n', fullfile(tables_out, 'tableD2.tex'));
- Line 352, windows : fprintf(fid, '%% Auto-generated by Export_latex_tables.m\n');
- Line 354, windows : fprintf(fid, '\\toprule\n');
- Line 356, windows : fprintf(fid, '\\midrule\n');
- Line 358, windows : fprintf(fid, '\\midrule\n');
- Line 364, windows : fprintf(fid, '\\midrule\n');
- Line 370, windows : fprintf(fid, '\\bottomrule\n');
- Line 373, windows : fprintf('Wrote %s\n', fullfile(tables_out, 'tableD3.tex'));
- Line 423, unix : earn_p_ch = (earn/p) / (earn_0/p_0) - 1;
- Line 431, unix : prof_p_ch = (prof/p) / (prof_0/p_0) - 1;
- Line 452, unix : % --- Wages (labor units = earn_T/NT per native head; effective units
- Line 453, unix : % = w_T/NT and w_imm_T/NT per effective unit) ---
- Line 464, unix : w_imm_NT_ch   = (wimm_nt/norm) / (wimm_nt_0/norm_0) - 1;
- Line 524, unix : earn_p_ch = (earn/p) / (earn_0/p_0) - 1;
- Line 580, unix : earn_p_ch = (earn/p) / (earn_0/p_0) - 1;
- Line 639, unix : earn_p/earn_p_0         - 1; ...
- Line 640, unix : w_T_p/w_T_p_0           - 1; ...
- Line 641, unix : w_NT_p/w_NT_p_0         - 1; ...
- Line 642, unix : w_imm_T_p/w_imm_T_p_0   - 1; ...
- Line 643, unix : w_imm_NT_p/w_imm_NT_p_0 - 1; ...
- Line 644, unix : emp_nat_T/emp_nat_T_0   - 1; ...
- Line 645, unix : emp_nat_NT/emp_nat_NT_0 - 1; ...
- Line 646, unix : emp_imm_T/emp_imm_T_0   - 1; ...
- Line 647, unix : emp_imm_NT/emp_imm_NT_0 - 1];

**/Users/florianoswald/actions-runner/_work/JPE-Morales-20211186/JPE-Morales-20211186/replication-package/Brinatti_Morales_Replication_Package/model_analysis/code/model/heterogeneous/Other_functions/ComputeMoments.m**

- Line 5, unix : %   equilibrium prices/wages and returns a struct with the 14 moments

**/Users/florianoswald/actions-runner/_work/JPE-Morales-20211186/JPE-Morales-20211186/replication-package/Brinatti_Morales_Replication_Package/model_analysis/code/stata_plots/Validation_cross_CI_heterog.do**

- Line 82, unix : gen rev_hat     = D.rev/L.rev

**/Users/florianoswald/actions-runner/_work/JPE-Morales-20211186/JPE-Morales-20211186/replication-package/Brinatti_Morales_Replication_Package/model_analysis/output/tables/table2.tex**

- Line 4, unix : & Open to Trade & Trade Autarky & Autarky/Open \\
- Line 8, unix : Homogeneous/Heterogeneous       & 45\%   &              &           \\

**/Users/florianoswald/actions-runner/_work/JPE-Morales-20211186/JPE-Morales-20211186/replication-package/Brinatti_Morales_Replication_Package/liab_analysis/prog/17_empirical_facts.do**

- Line 10, unix : tables with point estimates (survey-weighted medians/means) and 95%
- Line 138, unix : forvalues g = 1/20 {

**/Users/florianoswald/actions-runner/_work/JPE-Morales-20211186/JPE-Morales-20211186/replication-package/Brinatti_Morales_Replication_Package/model_analysis/code/model/policies/Equations_equilibrium/equilLoop.m**

- Line 3, unix : % equilLoop  Residual of the general-equilibrium system at prices/wages x.
- Line 83, unix : pi_g_t=((wd/Pg)^kappa)/((wd/Pg)^kappa+(wd_nt/Pg)^kappa);
- Line 84, unix : pi_g_nt=((wd_nt/Pg)^kappa)/((wd/Pg)^kappa+(wd_nt/Pg)^kappa);

**/Users/florianoswald/actions-runner/_work/JPE-Morales-20211186/JPE-Morales-20211186/replication-package/Brinatti_Morales_Replication_Package/model_analysis/scripts/master.m**

- Line 26, unix : % xlsx outputs are written directly into output/intermediate/heterogeneous/
- Line 32, unix : fprintf('\n[1/7] Heterogeneous open economy (Sec 6.1, 6.2; Table 2 col 1; Figure 4; Table D1)\n');
- Line 34, unix : write_GER_xlsx('Results_counterfactuals/Counterfactual_heterogeneous_open.mat', ...
- Line 44, unix : % Copy .mat workspaces to output/intermediate/heterogeneous/
- Line 56, unix : fprintf('\n[4/7] Homogeneous open economy (Sec 6.2; Table 2 col 1 row 2)\n');
- Line 75, mixed : fprintf('\n[6/7] Policy counterfactual %d/%d: %s\n', ii, numel(policy_labels), policy_labels{ii});
- Line 83, unix : % .mat workspaces stage in Results_counterfactuals/ and are copied to output/intermediate/.
- Line 96, mixed : fprintf('\n[7/7] Done. Intermediate outputs in: %s\n', out_intermediate);
- Line 97, unix : fprintf('       Now run scripts/master.do in Stata to produce figures.\n');

