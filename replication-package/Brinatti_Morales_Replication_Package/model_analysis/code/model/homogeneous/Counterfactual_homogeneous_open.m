clear;clc;

%% 0. Basic setups

FolderList      =   {'Other_functions', 'Equations_equilibrium'};
for ii=1:length(FolderList)
    addpath(genpath(FolderList{ii}));
end

%% 1. Setup the parameters and migration costs

% x_0 : [wx (T export wage), Pd (T price), Px (export price), wimm (T immigrant wage), pid (T domestic profits), pix (export profits), wd_nt (NT native wage), wimm_nt (NT immigrant wage), Pd_nt (NT price), pid_nt (NT profits)]
x_0=[0.324069846244786	0.00584149331597393	0.0112444387414353	0.138551294800471	344.636188393803	5563.85726904683	0.870058082639788	0.130741430040927	0.013127256485774	181.588838774574];

%% 2. Initial equilibrium

PP_0      = Setup_PP();
SS_0      = Heterogeneity(PP_0);

change_choice    = 1.2;
change_nt_choice = 1.2;
[mig_cost_20, mig_cost_nt_20] = mig_costs_mapping(change_choice, change_nt_choice, x_0, PP_0, SS_0);

f = @(x)equilLoop(x,PP_0,SS_0);
tic
[x_sol_0,~,EXITFLAG_0,~]            = fsolve(f,x_0,optimoptions('fsolve','Display','off'));
toc

%Store equilibrium firm-level variables (GER, GER_nt) and aggregate variables (main_aggregates)
   
[F_0, main_aggregates_0, RoW_0, GER_0, GER_nt_0]  = equilLoop(x_sol_0,PP_0,SS_0);


%% 3. Post-shock equilibrium

PP                    = Setup_PP();
PP.mig_cost           = mig_cost_20;
PP.mig_cost_nt        = mig_cost_nt_20;
SS                    = Heterogeneity(PP);

f = @(x)equilLoop(x,PP,SS);
tic
[x_sol,~,EXITFLAG,~]            = fsolve(f,x_0,optimoptions('fsolve','Display','off'));
toc

%Store equilibrium firm-level variables (GER, GER_nt) and aggregate variables (main_aggregates)

[F, main_aggregates, RoW, GER, GER_nt]      = equilLoop(x_sol,PP,SS);

%% 4. Export workspace

save(fullfile(fileparts(mfilename('fullpath')), 'Results_counterfactuals', ...
    'Counterfactual_homogeneous_open.mat'), ...
    'x_sol_0', 'x_sol', 'main_aggregates_0', 'main_aggregates', ...
    'GER_0', 'GER', 'GER_nt_0', 'GER_nt', 'PP', 'PP_0');
