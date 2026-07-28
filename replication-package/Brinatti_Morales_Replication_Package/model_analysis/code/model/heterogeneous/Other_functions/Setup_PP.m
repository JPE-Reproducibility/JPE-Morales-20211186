function PP=Setup_PP()

% Setup_PP  Build the structural parameter struct used throughout the model.
%
%   PP = Setup_PP() returns a struct PP holding (i) parameters set outside
%   the model (ii) the 14 SMM-calibrated parameters of Table 1 , and 
%   (iii) baseline values for variables that are  overwritten downstream 
%  (mig_cost, mig_cost_nt, tauxg, tauxg).
%
%   Output:
%
%     PP - struct passed to every equilibrium and calibration routine.

%% Structural parameters


% Model parameters coming from outside the model

epsilon         = 7.9;
kappa           = 6.14;
sigma           = 3.079;
sigmax          = 4.307;
sigmat          = (sigma/(sigma-1))^(1-sigma);
sigmaxt         = (sigmax/(sigmax-1))^(1-sigmax);
alpha           = 1-0.6843;

% Numer of firms and workers 

N_g             = 1000;
N_x             = 1000;
Lx_bar          = 50000;
Ld_bar          = 1000;

% Paramater values that are normalized

xbar            = 1;
mig_cost        = 1;
mig_cost_nt     = 1; 
mu_psi          = 1;
mu_f            = 0;
mu_f_nt         = 0;
mu_psi_nt       = 1; 
sigma_psix      = 0;
f_x             = 0;


% SMM-calibrated parameters (Table 1 of the paper). 

params_guess=[1.1468	0.89498	15207	-54.027	1.5298	0.0028731	2.79E-05	1.3472	0.0019213	0.37262	0.88172	16385	30.826	0.0008021];

sigma_psi   =params_guess(1); 
beta        =params_guess(2); 
sigma_f     =params_guess(3); 
cov_psif    =params_guess(4); 
mu_psix     =params_guess(5); 
f_g         =params_guess(6); 
f_imm       =params_guess(7);
taugx       =params_guess(8);
iota        =params_guess(9);
sigma_psi_nt=params_guess(10);
beta_nt     =params_guess(11);
sigma_f_nt  =params_guess(12);
cov_psif_nt =params_guess(13); 
f_imm_nt    =params_guess(14);
tauxg       = taugx; 

%% Collect the parameters 

PP              =   struct('epsilon', epsilon, 'iota', iota, 'sigma', sigma, 'sigmax', sigmax, ...
                            'beta_nt', beta_nt, 'beta',beta, 'mig_cost', mig_cost, 'mig_cost_nt', mig_cost_nt,...
                            'N_g', N_g, 'mu_psi', mu_psi, 'mu_f', mu_f, 'mu_f_nt', mu_f_nt, 'mu_psi_nt', mu_psi_nt,...
                            'sigma_psi_nt' ,sigma_psi_nt , 'cov_psif_nt',cov_psif_nt , 'sigma_f_nt',sigma_f_nt, ...
                            'f_g' , f_g, 'taugx',taugx , 'sigma_psi', sigma_psi, 'cov_psif' ,cov_psif , 'sigma_f',sigma_f,...
                            'sigmat',sigmat,'sigmaxt',sigmaxt, 'kappa', kappa,'N_x',N_x , 'f_imm', f_imm, 'f_imm_nt' ,f_imm_nt, ...
                            'xbar', xbar ,'alpha',alpha,'f_x',f_x, 'mu_psix',mu_psix , 'sigma_psix',sigma_psix, 'tauxg' , tauxg, ...
                            'Ld_bar',Ld_bar,'Lx_bar',Lx_bar);
end