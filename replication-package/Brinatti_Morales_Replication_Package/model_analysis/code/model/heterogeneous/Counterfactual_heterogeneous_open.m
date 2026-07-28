clear;clc;

%% 0. Basic setups

FolderList      =   {'Other_functions', 'Equations_equilibrium'};
for ii=1:length(FolderList)
    addpath(genpath(FolderList{ii}));
end


%% 1. Setup the parameters

PP      = Setup_PP();
SS      = Heterogeneity(PP);

% x_0 : [wx (T export wage), Pd (T price), Px (export price), wimm (T immigrant wage), pid (T domestic profits), pix (export profits), wd_nt (NT native wage), wimm_nt (NT immigrant wage), Pd_nt (NT price), pid_nt (NT profits)]
x_0   = [0.324335125689298	0.00581557463337634	0.0112510772006113	0.161173107360179	360.337575599634	5559.82876523402	0.876877518299593	0.134468674352483	0.0131989032931402	189.138983348911];

% Map the targeted shock -- a 20% rise in the within-sector number of
% immigrants (1.2 = +20% in tradable T, 1.2 = +20% in non-tradable NT) - to 
% the migration-cost reductions that deliver it. mig_costs_mapping returns 
% migration costs in each sector (mig_cost_20 for T, mig_cost_nt_20 for NT)
% that achieve those within-sector targets.

change_choice       = 1.2;
change_nt_choice    = 1.2;

[mig_cost_20,mig_cost_nt_20] = mig_costs_mapping(change_choice, change_nt_choice,x_0, PP, SS);

%% 2. Initial equilibrium

PP_0      = Setup_PP();
SS_0      = Heterogeneity(PP_0);

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
    'Counterfactual_heterogeneous_open.mat'), ...
    'x_sol_0', 'x_sol', 'main_aggregates_0', 'main_aggregates', ...
    'GER_0', 'GER', 'GER_nt_0', 'GER_nt', 'PP', 'PP_0');
