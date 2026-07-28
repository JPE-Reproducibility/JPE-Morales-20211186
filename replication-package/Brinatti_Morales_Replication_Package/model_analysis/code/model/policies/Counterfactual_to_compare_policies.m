clearvars -except policy_label; clc;

%% 0. Basic setups

% Setup_PP and Heterogeneity are shared with the heterogeneous model.

this_dir            = fileparts(mfilename('fullpath'));   
pkg_root            = fullfile(this_dir, '..', '..', '..');  
het_other_functions = fullfile(this_dir, '..', 'heterogeneous', 'Other_functions');
results_dir         = fullfile(this_dir, 'Results_counterfactuals');
out_pol             = fullfile(pkg_root, 'output', 'intermediate', 'policies');
if ~exist(results_dir, 'dir'); mkdir(results_dir); end
if ~exist(out_pol,     'dir'); mkdir(out_pol);     end

addpath(genpath(het_other_functions));
addpath(genpath(fullfile(this_dir, 'Equations_equilibrium')));

% x_0 : [wx (T export wage), Pd (T price), Px (export price), wimm (T immigrant wage), pid (T domestic profits), pix (export profits), wd_nt (NT native wage), wimm_nt (NT immigrant wage), Pd_nt (NT price), pid_nt (NT profits)]
x_0 = [0.324335125689236	0.00581557463337593	0.0112510772006092	0.161173107360185	360.337575599209	5559.82876523338	0.876877518300281	0.134468674350414	0.0131989032931598	189.138983349368];

%% 1. Setup the parameters

PP_0      = Setup_PP();
SS_0      = Heterogeneity(PP_0);

f_j_orig        = SS_0.f_j;
f_j_nt_orig     = SS_0.f_j_nt;

SS_0            =   struct('psi_g',SS_0.psi_g,'f_j',SS_0.f_j,'psi_x',SS_0.psi_x,'psi_g_nt',SS_0.psi_g_nt,'f_j_nt',SS_0.f_j_nt,'f_j_orig', f_j_orig, 'f_j_nt_orig', f_j_nt_orig);

%% 2. Initial equilibrium

f = @(x)equilLoop(x,PP_0,SS_0);
tic
[x_sol_0,~,EXITFLAG_0,~]            = fsolve(f,x_0,optimoptions('fsolve','Display','off'));
toc

%Store equilibrium firm-level variables (GER, GER_nt) and aggregate variables (main_aggregates)
    
    [F_0, main_aggregates_0, RoW_0, GER_0, GER_nt_0]  = equilLoop(x_sol_0,PP_0,SS_0);


%% 3. Counterfactual changing fixed costs for small firms

% policy_label values:
%   'basef'         - Policy 1 (D.2): subsidy to bottom-psi firms (cross-sector)
%   'top10'         - Policy 2 (D.2): subsidy to top-psi firms (cross-sector)
%   'bottom_onlyt'  - Policy 3 (D.2): subsidy to bottom-psi tradable firms only
%   'top_onlyt'     - Policy 4 (D.2): subsidy to top-psi tradable firms only
%   'nobasef'       - Appendix D.3: eliminate immigrant fixed cost f^imm


PP                    = Setup_PP();
SS                    = Heterogeneity(PP);

f_j_orig    = SS.f_j;
f_j_nt_orig = SS.f_j_nt;
psi_tot     = [SS.psi_g; SS.psi_g_nt];
f_j_tot_orig=[f_j_orig;f_j_nt_orig];
f_j_tot     = f_j_tot_orig;
median_psi  = median(psi_tot);


% Default to Policy 1 if not provided externally
if ~exist('policy_label','var') || isempty(policy_label)
    policy_label = 'basef';
end

% Section A: f_imm modification (only for D.3)
switch policy_label
    case 'nobasef'
        PP.f_imm    = 0;
        PP.f_imm_nt = 0;
end

% Section B: cross-sector f_j modification (Policies 1 and 2)
f_j_tot = f_j_tot_orig;
switch policy_label
    case 'basef'    % Policy 1
        f_j_tot(psi_tot < median_psi) = min(6.3573e-69, f_j_tot(psi_tot < median_psi));
    case 'top10'    % Policy 2
        f_j_tot(psi_tot > median_psi) = min(2.7830e-27, f_j_tot(psi_tot > median_psi));
end

SS.f_j    = f_j_tot(1:1000, 1);
SS.f_j_nt = f_j_tot(1001:2000, 1);

% Section C: tradable-only f_j modification (Policies 3 and 4)
switch policy_label
    case 'bottom_onlyt'  % Policy 3
        SS.f_j = f_j_orig;
        SS.f_j(SS.psi_g < median_psi) = min(1.7631e-70, SS.f_j(SS.psi_g < median_psi));
    case 'top_onlyt'     % Policy 4
        SS.f_j = f_j_orig;
        SS.f_j(SS.psi_g > median_psi) = min(1.5609e-75, SS.f_j(SS.psi_g > median_psi));
end


% Re-pack SS as a flat struct (drops fields equilLoop does not use)

SS              =   struct('psi_g',SS.psi_g,'f_j',SS.f_j,'psi_x',SS.psi_x,'psi_g_nt',SS.psi_g_nt,'f_j_nt',SS.f_j_nt,'f_j_orig', f_j_orig, 'f_j_nt_orig', f_j_nt_orig);

f = @(x)equilLoop(x,PP,SS);
tic
[x_sol,~,EXITFLAG,~]            = fsolve(f,x_0,optimoptions('fsolve','Display','off'));
toc

%Store equilibrium firm-level variables (GER, GER_nt) and aggregate variables (main_aggregates)
    
[F, main_aggregates, RoW, GER, GER_nt]      = equilLoop(x_sol,PP,SS);



%% 4. Export workspace

mat_file = ['Counterfactual_to_compare_policies_' policy_label '.mat'];
save(fullfile(results_dir, mat_file), ...
    'x_sol_0', 'x_sol', 'main_aggregates_0', 'main_aggregates', ...
    'GER_0', 'GER', 'GER_nt_0', 'GER_nt', 'PP', 'PP_0', 'policy_label', ...
    'f_j_orig', 'f_j_nt_orig');
