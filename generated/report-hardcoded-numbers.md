## Potentially Hardcoded Numeric Constants


We found the following set of hard coded numbers. This may be completely legitimate (parameter input, thresholds for computations, etc), and is hence only for information.

**/Users/florianoswald/actions-runner/_work/JPE-Morales-20211186/JPE-Morales-20211186/replication-package/Brinatti_Morales_Replication_Package/model_analysis/code/model/policies/Counterfactual_to_compare_policies.m**

- Line 19, : x_0 = [0.324335125689236	0.00581557463337593	0.0112510772006092	0.161173107360185	360.337575599209	5559.82876523338	0.876877518300281	0.134468674350414	0.0131989032931598	189.138983349368];
- Line 80, : f_j_tot(psi_tot < median_psi) = min(6.3573e-69, f_j_tot(psi_tot < median_psi));
- Line 82, : f_j_tot(psi_tot > median_psi) = min(2.7830e-27, f_j_tot(psi_tot > median_psi));
- Line 92, : SS.f_j(SS.psi_g < median_psi) = min(1.7631e-70, SS.f_j(SS.psi_g < median_psi));
- Line 95, : SS.f_j(SS.psi_g > median_psi) = min(1.5609e-75, SS.f_j(SS.psi_g > median_psi));

**/Users/florianoswald/actions-runner/_work/JPE-Morales-20211186/JPE-Morales-20211186/replication-package/Brinatti_Morales_Replication_Package/liab_analysis/prog/11_epsilon_pre_trend_test.do**

- Line 106, : estout IV_bsl_L*, varlabels(_cons \_cons)  cells(b(star) se ) starlevels( * 0.10 ** 0.05 *** 0.010) stats(N N_clust)

**/Users/florianoswald/actions-runner/_work/JPE-Morales-20211186/JPE-Morales-20211186/replication-package/Brinatti_Morales_Replication_Package/liab_analysis/prog/estimate_nu_cont.m**

- Line 6, : solve_nu(0.10396153)
- Line 12, : solve_nu(0.08224467)
- Line 18, : solve_nu(0.05933612)
- Line 24, : %(gamma(1 - 2/0.6745) / (gamma(1 - 1/0.6745)^2)) - 1;
- Line 26, : %(gamma(1 - 2/4.0288) / (gamma(1 - 1/4.0288)^2)) - 1;

**/Users/florianoswald/actions-runner/_work/JPE-Morales-20211186/JPE-Morales-20211186/replication-package/Brinatti_Morales_Replication_Package/model_analysis/code/model/heterogeneous/Calibration.m**

- Line 23, : Equil_0 = [0.324335125689298	0.00581557463337634	0.0112510772006113	0.161173107360179	360.337575599634	5559.82876523402	0.876877518299593	0.134468674352483	0.0131989032931402	189.138983348911];

**/Users/florianoswald/actions-runner/_work/JPE-Morales-20211186/JPE-Morales-20211186/replication-package/Brinatti_Morales_Replication_Package/liab_analysis/prog/10_epsilon_estimation.do**

- Line 99, : estout OLS_bsl IV_bsl, varlabels(_cons \_cons)  cells(b(star) se p) starlevels( * 0.10 ** 0.05 *** 0.010) stats(N N_clust)

**/Users/florianoswald/actions-runner/_work/JPE-Morales-20211186/JPE-Morales-20211186/replication-package/Brinatti_Morales_Replication_Package/model_analysis/code/model/heterogeneous/Equations_equilibrium/equilLoop.m**

- Line 120, : sd_min = 0.0001*ones(N_g,1) ;
- Line 176, : sd_min = 0.0001*ones(N_g,1) ;
- Line 182, : tol         = 0.00001 ;
- Line 213, : sd_min = 0.0001*ones(N_g,1) ;
- Line 219, : tol = 0.00001 ;
- Line 248, : sd_min = 0.0001*ones(N_g,1) ;
- Line 254, : tol = 0.00001 ;

**/Users/florianoswald/actions-runner/_work/JPE-Morales-20211186/JPE-Morales-20211186/replication-package/Brinatti_Morales_Replication_Package/model_analysis/output/tables/sec63_decomposition.tex**

- Line 6, : Closed vs.\ open (heterogeneous) & 0.010 & 9\% larger \\
- Line 7, : Terms-of-trade dampening         & 0.004 & 39\% \\
- Line 8, : Heterogeneity-driven dampening   & 0.006 & 61\% \\

**/Users/florianoswald/actions-runner/_work/JPE-Morales-20211186/JPE-Morales-20211186/replication-package/Brinatti_Morales_Replication_Package/model_analysis/code/model/heterogeneous/Counterfactual_heterogeneous_closed.m**

- Line 20, : x_0 = [0.578875726522049	0.00759842276635184	0.0202194708830934	0.173917333833752	415.690470674497	9826.18039013914	0.884027982171546	0.145807464143012	0.0133617164875731	191.571745308755];

**/Users/florianoswald/actions-runner/_work/JPE-Morales-20211186/JPE-Morales-20211186/replication-package/Brinatti_Morales_Replication_Package/model_analysis/output/tables/tableC7.tex**

- Line 6, : Aggregate $s_T$                                      & 0.91  & 0.91  & $E(1-s_{j,p90})-E(1-s_{j,p50})$, NT  & 0.008 & 0.008 \\
- Line 12, : $E(1-s_{j,p90})-E(1-s_{j,p50})$, T                   & 0.026 & 0.021 & $E(s_j)$                              & 0.94 & 0.93 \\

**/Users/florianoswald/actions-runner/_work/JPE-Morales-20211186/JPE-Morales-20211186/replication-package/Brinatti_Morales_Replication_Package/sieed_analysis/prog/1a_create_data_event_study.do**

- Line 75, : keep if max_wage>=tentgelt-0.001 & max_wage<=tentgelt+0.001

**/Users/florianoswald/actions-runner/_work/JPE-Morales-20211186/JPE-Morales-20211186/replication-package/Brinatti_Morales_Replication_Package/liab_analysis/prog/5_dataset_for_instrument_validation.do**

- Line 69, : keep if max_wage>=tentgelt_orig-0.001 & max_wage<=tentgelt_orig+0.001

**/Users/florianoswald/actions-runner/_work/JPE-Morales-20211186/JPE-Morales-20211186/replication-package/Brinatti_Morales_Replication_Package/liab_analysis/prog/7_dataset_for_epsilon_estimation.do**

- Line 67, : keep if max_wage>=tentgelt_orig-0.001 & max_wage<=tentgelt_orig+0.001

**/Users/florianoswald/actions-runner/_work/JPE-Morales-20211186/JPE-Morales-20211186/replication-package/Brinatti_Morales_Replication_Package/model_analysis/code/model/heterogeneous/Other_functions/Calibration_Res.m**

- Line 58, : || PP.beta >0.9985 || PP.beta_nt>0.9985 || PP.iota<0
- Line 102, : if abs(main_aggregates(1,3))>0.001 || abs(main_aggregates(1,4))>0.001
- Line 130, : Mom_Data_draft  = struct('std_l_rev_cond', 1.38, 'sagg', 0.912, 'std_l_sd_ratio', 1.39, 'moment_correlation', 0.0208, ...
- Line 132, : 'mean_sd', 0.93, 'std_l_rev_nt_cond', 1.29, 'sagg_nt', 0.934, 'std_l_sd_ratio_nt', 1.586, ...
- Line 133, : 'moment_correlation_nt', 0.0084, 'mean_Dimm_nt', 0.61);

**/Users/florianoswald/actions-runner/_work/JPE-Morales-20211186/JPE-Morales-20211186/replication-package/Brinatti_Morales_Replication_Package/model_analysis/output/tables/sec61_aggregates.tex**

- Line 6, : Native workers       & 0.113\% \\
- Line 7, : Firm owners          & 1.306\% \\
- Line 8, : Total income         & 1.284\% \\

**/Users/florianoswald/actions-runner/_work/JPE-Morales-20211186/JPE-Morales-20211186/replication-package/Brinatti_Morales_Replication_Package/liab_analysis/prog/15_epsilon_shift_share.do**

- Line 14, : regressed on firm characteristics (~0.001)
- Line 163, : estout res_shall, varlabels(_cons \_cons)  cells(b(star) se) starlevels( * 0.10 ** 0.05 *** 0.010) stats(N r2)

**/Users/florianoswald/actions-runner/_work/JPE-Morales-20211186/JPE-Morales-20211186/replication-package/Brinatti_Morales_Replication_Package/model_analysis/code/stata_plots/Counterfactual_plots_policies.do**

- Line 217, : local scale = 35574.74425262905 / 1000

**/Users/florianoswald/actions-runner/_work/JPE-Morales-20211186/JPE-Morales-20211186/replication-package/Brinatti_Morales_Replication_Package/sieed_analysis/prog/1c_create_data_figA7.do**

- Line 65, : keep if max_wage>=tentgelt-0.001 & max_wage<=tentgelt+0.001

**/Users/florianoswald/actions-runner/_work/JPE-Morales-20211186/JPE-Morales-20211186/replication-package/Brinatti_Morales_Replication_Package/model_analysis/code/model/homogeneous/Counterfactual_homogeneous_closed.m**

- Line 14, : x_0=[0.57999176032787	0.00764473134010395	0.0202584589255632	0.148658861071155	404.093696183629	9855.48852820677	0.879515211155746	0.141791330058895	0.0133132059479747	186.548471147845];

**/Users/florianoswald/actions-runner/_work/JPE-Morales-20211186/JPE-Morales-20211186/replication-package/Brinatti_Morales_Replication_Package/model_analysis/code/model/homogeneous/Other_functions/Setup_PP.m**

- Line 21, : sigma           = 3.079;
- Line 22, : sigmax          = 4.307;
- Line 25, : alpha           = 1-0.6843;
- Line 49, : params_guess=[1.1468	0.89498	15207	-54.027	1.5298	0.0028731	2.79E-05	1.3472	0.0019213	0.37262	0.88172	16385	30.826	0.0008021];

**/Users/florianoswald/actions-runner/_work/JPE-Morales-20211186/JPE-Morales-20211186/replication-package/Brinatti_Morales_Replication_Package/model_analysis/code/model/homogeneous/Counterfactual_homogeneous_open.m**

- Line 13, : x_0=[0.324069846244786	0.00584149331597393	0.0112444387414353	0.138551294800471	344.636188393803	5563.85726904683	0.870058082639788	0.130741430040927	0.013127256485774	181.588838774574];

**/Users/florianoswald/actions-runner/_work/JPE-Morales-20211186/JPE-Morales-20211186/replication-package/Brinatti_Morales_Replication_Package/liab_analysis/prog/3_crosswalk_occupation_blossfeld.do**

- Line 8, : *              https://labourmarketresearch.springeropen.com/articles/10.1186/s12651-020-00275-9

**/Users/florianoswald/actions-runner/_work/JPE-Morales-20211186/JPE-Morales-20211186/replication-package/Brinatti_Morales_Replication_Package/model_analysis/output/tables/table2.tex**

- Line 6, : Heterogeneous $s_j$             & 0.113\% & 0.123\% & 1.09\% \\
- Line 7, : Homogeneous within-sector $s_j$ & 0.051\% & 0.055\% &           \\

**/Users/florianoswald/actions-runner/_work/JPE-Morales-20211186/JPE-Morales-20211186/replication-package/Brinatti_Morales_Replication_Package/liab_analysis/prog/12_epsilon_firm_characteristics.do**

- Line 96, : estout IV_bsl exp_sh_03 l_emp_tot_03 emp_sh_coll_03 premium_03, varlabels(_cons \_cons)  cells(b(star) se ) starlevels( * 0.10 ** 0.05 *** 0.010) stats(N N_clust)

**/Users/florianoswald/actions-runner/_work/JPE-Morales-20211186/JPE-Morales-20211186/replication-package/Brinatti_Morales_Replication_Package/model_analysis/code/model/Export_latex_tables.m**

- Line 169, : %  Markup (aggregate, model output)             |      3.0833
- Line 185, : %    ÷ FT-hours / all-hours ratio (39.43 / 34.432 = 1.1452)     | ÷ 1.1452
- Line 681, : Equil_0 = [0.324335125689298  0.00581557463337634 ...
- Line 682, : 0.0112510772006113 0.161173107360179 ...
- Line 683, : 360.337575599634   5559.82876523402 ...
- Line 684, : 0.876877518299593  0.134468674352483 ...
- Line 685, : 0.0131989032931402 189.138983348911];

**/Users/florianoswald/actions-runner/_work/JPE-Morales-20211186/JPE-Morales-20211186/replication-package/Brinatti_Morales_Replication_Package/model_analysis/output/tables/sec61_dollar_gains.tex**

- Line 6, : Native workers   & 0.113\% & \$1.8 \\
- Line 7, : Firm owners      & 1.306\% & \$20.8 \\
- Line 8, : Total income     & 1.284\% & \$22.5 \\

**/Users/florianoswald/actions-runner/_work/JPE-Morales-20211186/JPE-Morales-20211186/replication-package/Brinatti_Morales_Replication_Package/model_analysis/code/model/heterogeneous/Counterfactual_heterogeneous_open.m**

- Line 17, : x_0   = [0.324335125689298	0.00581557463337634	0.0112510772006113	0.161173107360179	360.337575599634	5559.82876523402	0.876877518299593	0.134468674352483	0.0131989032931402	189.138983348911];

**/Users/florianoswald/actions-runner/_work/JPE-Morales-20211186/JPE-Morales-20211186/replication-package/Brinatti_Morales_Replication_Package/model_analysis/code/stata_plots/Counterfactual_plots_heterog.do**

- Line 84, : local total_natives_DE = 35574.74425262905

**/Users/florianoswald/actions-runner/_work/JPE-Morales-20211186/JPE-Morales-20211186/replication-package/Brinatti_Morales_Replication_Package/model_analysis/code/model/heterogeneous/Other_functions/Setup_PP.m**

- Line 21, : sigma           = 3.079;
- Line 22, : sigmax          = 4.307;
- Line 25, : alpha           = 1-0.6843;
- Line 49, : params_guess=[1.1468	0.89498	15207	-54.027	1.5298	0.0028731	2.79E-05	1.3472	0.0019213	0.37262	0.88172	16385	30.826	0.0008021];

**/Users/florianoswald/actions-runner/_work/JPE-Morales-20211186/JPE-Morales-20211186/replication-package/Brinatti_Morales_Replication_Package/model_analysis/code/model/policies/Equations_equilibrium/equilLoop.m**

- Line 124, : sd_min = 0.0001*ones(N_g,1) ;
- Line 180, : sd_min = 0.0001*ones(N_g,1) ;
- Line 186, : tol         = 0.00001 ;
- Line 217, : sd_min = 0.0001*ones(N_g,1) ;
- Line 223, : tol = 0.00001 ;
- Line 252, : sd_min = 0.0001*ones(N_g,1) ;
- Line 258, : tol = 0.00001 ;

**/Users/florianoswald/actions-runner/_work/JPE-Morales-20211186/JPE-Morales-20211186/replication-package/Brinatti_Morales_Replication_Package/model_analysis/output/tables/table1.tex**

- Line 8, : Dispersion in $\psi_j$, T        & $\sigma_{\psi,T}$      & 1.15     & Fixed cost of immigrants, NT       & $f_{imm,NT}$         & 0.0008 \\
- Line 10, : Dispersion in $f_j$, T           & $\sigma_{f,T}$         & 15207    & Fixed cost of exporting            & $f_g$                & 0.003 \\
- Line 12, : Covariance of $\psi$ and $f_j$, T & $\sigma_{\psi,f,T}$    & -54.03   & Elasticity $s_j$ to $n$            & $\iota$              & 0.002 \\

