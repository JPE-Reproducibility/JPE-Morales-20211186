function write_GER_xlsx(mat_path, xlsx_path)

% write_GER_xlsx  Write the firm-level GER xlsx file Stata uses.

%   write_GER_xlsx(mat_path, xlsx_path) loads GER_0, GER, GER_nt_0, GER_nt
%   from a heterogeneous-model equilibrium workspace and writes the 4-sheet 
%   xlsx that Counterfactual_plots_heterog.do and Validation_cross_CI_heterog.do
%   use.

GER_list    = {'psi_g', 'f_j', 'D_exporter' , 'D_imm' , 'sdom', 'u_tilde', 'u', 'p_dd', 'prof','q_dd','q_dx', 'rev','fe_j','rev_exports',...
          'Ld_alt_j', 'I_alt_j', 'Cost_tot_j', 'I_alt_j./Ld_alt_j', '(wimm*I_alt_j)./(wd*Ld_alt_j)'};

GER_nt_list = {'psi_g_nt' , 'f_j_nt', 'D_imm_nt' , 'sdom_nt' , 'u_tilde_nt' , 'u_nt' , 'p_dd_nt' , 'prof_nt', 'q_dd_nt','rev_nt', 'fe_j_nt', ...
          'Ld_alt_nt_j', 'I_alt_nt_j', 'Cost_tot_nt_j', 'I_alt_nt_j./Ld_alt_nt_j', '(wimm_nt*I_alt_nt_j)./(wd_nt*Ld_alt_nt_j)'};

W = load(mat_path, 'GER_0', 'GER', 'GER_nt_0', 'GER_nt');

writetable(array2table(W.GER_0,    'VariableNames', GER_list),    xlsx_path, 'Sheet', 'GER_0',    'WriteRowNames', true);
writetable(array2table(W.GER_nt_0, 'VariableNames', GER_nt_list), xlsx_path, 'Sheet', 'GER_nt_0', 'WriteRowNames', true);
writetable(array2table(W.GER,      'VariableNames', GER_list),    xlsx_path, 'Sheet', 'GER',      'WriteRowNames', true);
writetable(array2table(W.GER_nt,   'VariableNames', GER_nt_list), xlsx_path, 'Sheet', 'GER_nt',   'WriteRowNames', true);

end
