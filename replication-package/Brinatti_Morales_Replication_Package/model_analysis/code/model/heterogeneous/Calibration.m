% Calibration.m
% Section 5.4 -- SMM calibration of 14 parameters.


clear;

 global Equil_0_last

%% 0. Basic setups

FolderList      =   {'Other_functions', 'Equations_equilibrium'};
for ii=1:length(FolderList)
    addpath(genpath(FolderList{ii}));
end

%% 1. Setup the parameters

PP      = Setup_PP();
SS      = Heterogeneity(PP);

%% 2. Optimization

Equil_0 = [0.324335125689298	0.00581557463337634	0.0112510772006113	0.161173107360179	360.337575599634	5559.82876523402	0.876877518299593	0.134468674352483	0.0131989032931402	189.138983348911];

InputVec_0      =  [PP.taugx;
                    PP.sigma_psi;
                    PP.cov_psif;
                    PP.sigma_f;
                    PP.beta_nt;
                    PP.beta;
                    PP.sigma_psi_nt;
                    PP.cov_psif_nt;
                    PP.sigma_f_nt;
                    PP.f_g;
                    PP.mu_psix;
                    PP.f_imm;
                    PP.f_imm_nt;
                    PP.iota];

   [Cal_sol,Cal_fval,Cal_exitflag,Cal_output]=...
       fminsearch(   @(InputVec)Calibration_Res(PP, Equil_0 , InputVec),...
      InputVec_0,optimset('MaxIter',100000,'MaxFunEval',100000,'TolFun',1e-4,'TolX',1e-4));

