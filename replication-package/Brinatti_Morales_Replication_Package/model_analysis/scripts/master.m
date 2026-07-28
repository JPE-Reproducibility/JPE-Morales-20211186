% master.m
% 
% Master MATLAB script: runs all model code needed to reproduce
% Sections 5.5, 6, and Appendix D of the paper.

% Run from inside .../scripts/ (this file's folder), or set the
% pkg_root variable below to the absolute path accordingly.

clear; clc;



% --- Setup ---

this_file = mfilename('fullpath');
[scripts_dir,~,~] = fileparts(this_file);
pkg_root          = fullfile(scripts_dir, '..');          
out_intermediate  = fullfile(pkg_root, 'output', 'intermediate');

%% =============================================================
%  HETEROGENEOUS MODEL (Sections 5.5, 6.1, 6.3 baseline)
%  =============================================================

cd(fullfile(pkg_root, 'code', 'model', 'heterogeneous'));

% xlsx outputs are written directly into output/intermediate/heterogeneous/
% (the path Stata reads); .mat workspaces still stage in
% Results_counterfactuals/ and are copied afterwards.
out_het = fullfile(out_intermediate, 'heterogeneous');
if ~exist(out_het, 'dir'); mkdir(out_het); end

fprintf('\n[1/7] Heterogeneous open economy (Sec 6.1, 6.2; Table 2 col 1; Figure 4; Table D1)\n');
run_isolated('Counterfactual_heterogeneous_open.m');
write_GER_xlsx('Results_counterfactuals/Counterfactual_heterogeneous_open.mat', ...
               fullfile(out_het, 'Results_GER_Baseline.xlsx'));

fprintf('\n[2/7] Heterogeneous closed economy / autarky (Sec 6.3; Table 2 col 2 row 1)\n');
run_isolated('Counterfactual_heterogeneous_closed.m');

% Figure 3 (Sec 5.5) model side is produced directly by
% Counterfactual_heterogeneous_open.m -> Results_GER_Baseline.xlsx, which
% Validation_cross_CI_heterog.do reads.

% Copy .mat workspaces to output/intermediate/heterogeneous/
copyfile('Results_counterfactuals/*.mat',  out_het);

%% =============================================================
%  HOMOGENEOUS MODEL (Section 6.2, 6.3 comparison)
%  =============================================================

cd(fullfile(pkg_root, 'code', 'model', 'homogeneous'));

out_homog = fullfile(out_intermediate, 'homogeneous');
if ~exist(out_homog, 'dir'); mkdir(out_homog); end

fprintf('\n[4/7] Homogeneous open economy (Sec 6.2; Table 2 col 1 row 2)\n');
run_isolated('Counterfactual_homogeneous_open.m');

fprintf('\n[5/7] Homogeneous closed economy / autarky (Sec 6.3; Table 2 col 2 row 2)\n');
run_isolated('Counterfactual_homogeneous_closed.m');

copyfile('Results_counterfactuals/*.mat',  out_homog);

%% =============================================================
%  POLICY COUNTERFACTUALS (Sec 6.4 / Appendix D.2 and D.3)
%  =============================================================

cd(fullfile(pkg_root, 'code', 'model', 'policies'));

out_pol = fullfile(out_intermediate, 'policies');
if ~exist(out_pol, 'dir'); mkdir(out_pol); end

policy_labels = {'basef', 'top10', 'bottom_onlyt', 'top_onlyt', 'nobasef'};
for ii = 1:numel(policy_labels)
    fprintf('\n[6/7] Policy counterfactual %d/%d: %s\n', ii, numel(policy_labels), policy_labels{ii});
    run_policy('Counterfactual_to_compare_policies.m', policy_labels{ii});
    mat_file  = ['Counterfactual_to_compare_policies_' policy_labels{ii} '.mat'];
    xlsx_file = ['Validation_GER_output_subsidy_notax_'  policy_labels{ii} '.xlsx'];
    write_GER_xlsx_policy(fullfile('Results_counterfactuals', mat_file), ...
                          fullfile(out_pol, xlsx_file));
end

% .mat workspaces stage in Results_counterfactuals/ and are copied to output/intermediate/.
copyfile('Results_counterfactuals/*.mat', out_pol);


%% =============================================================
%  EXPORT LaTeX TABLES
%  =============================================================

fprintf('\nExporting LaTeX tables (table2, tableD1, tableD2, tableD3, sec61_aggregates, sec61_dollar_gains, sec63_decomposition)\n');
cd(fullfile(pkg_root, 'code', 'model'));
run_isolated('Export_latex_tables.m');
cd(scripts_dir);

fprintf('\n[7/7] Done. Intermediate outputs in: %s\n', out_intermediate);
fprintf('       Now run scripts/master.do in Stata to produce figures.\n');

function run_isolated(script_name)
    run(script_name);
end

function run_policy(script_name, policy_label) 
    run(script_name);
end
