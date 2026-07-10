function [Res, PP, ExtraDetails, ExitFlag]=Calibration_Res(PP,Equil_0, InputVec)
% Calibration_Res  SMM objective evaluated at a candidate parameter vector.
%
%   [Res, PP, ExtraDetails, ExitFlag] = Calibration_Res(PP, Equil_0, InputVec)
%   maps the 14-element InputVec into the corresponding fields of PP,
%   solves the equilibrium with fsolve, checks that prices and wages are
%   non-negative and that Walras' law holds, computes the simulated moments
%   via ComputeMoments, and returns the weighted-distance objective Res
%   against the 14 Table-C.7 data moments.
%
%   Inputs:
%
%     PP       - parameter struct from Setup_PP. Modified to incorporate InputVec.
%     Equil_0  - 10-element initial guess to start the equilibrium fsolve.
%     InputVec - 14-element candidate vector (the parameters being calibrated).
%
%   Outputs:
%
%     Res          - weighted SMM objective (Inf if the equilibrium is invalid).
%     PP           - parameter struct with the InputVec values inserted.
%     ExtraDetails - struct holding the equilibrium solution, data and model
%                    moments, runtime, and the success flag.
%     ExitFlag     - 1 success, 2 boundary violation, 3 fsolve failure,
%                    4 Walras-law failure.

 global Equil_0_last

tic

%% 1. Read the input vectors

PP.taugx        = InputVec(1);
PP.sigma_psi    = InputVec(2);
PP.cov_psif     = InputVec(3);
PP.sigma_f      = InputVec(4);
PP.beta_nt      = InputVec(5);
PP.beta         = InputVec(6);
PP.sigma_psi_nt = InputVec(7);
PP.cov_psif_nt  = InputVec(8);
PP.sigma_f_nt   = InputVec(9);
PP.f_g          = InputVec(10);
PP.mu_psix      = InputVec(11);
PP.f_imm        = InputVec(12);
PP.f_imm_nt     = InputVec(13);
PP.iota         = InputVec(14);
PP.tauxg        = PP.taugx;
SS              = Heterogeneity(PP);


%% 2. Check boundaries of parameters

var     = [PP.sigma_psi PP.cov_psif; PP.cov_psif PP.sigma_f];
var_nt  = [PP.sigma_psi_nt PP.cov_psif_nt; PP.cov_psif_nt PP.sigma_f_nt];


 if all(eig(var)>0)<1 || all(eig(var_nt)>0)<1 || PP.sigma_psi<=0 || PP.sigma_f<0 ||  PP.f_g<0 || ...
        PP.f_imm<0 ||  PP.taugx<0 ||  PP.tauxg<0 ||  PP.sigma_psi_nt<=0 ||  PP.sigma_f_nt<0 || PP.f_imm_nt<0 ...
        || PP.beta >0.9985 || PP.beta_nt>0.9985 || PP.iota<0

    Res         =   inf;
    ExitFlag    =   2;
    return
end


%% 3. Solve the model

f = @(x)equilLoop(x,PP,SS);

try
      [Equil_sol,~,Equil_EXITFLAG,~] = fsolve(f,Equil_0,optimoptions('fsolve','Display','off'));

      if Equil_EXITFLAG>0
          Equil_0_last = Equil_sol;
      end

catch
        try
        Equil_0 = Equil_0_last;
        [Equil_sol,~,Equil_EXITFLAG,~] = fsolve(f,Equil_0,optimoptions('fsolve','Display','off'));
              if Equil_EXITFLAG>0
                  Equil_0_last = Equil_sol;
              end
        catch
            Res         =   Inf;
            return;
        end

end

if Equil_EXITFLAG <1
    Res         =   inf;
    ExitFlag    =   3;
    return
end


% Check Walras Law (zero excess demand in both labor markets).

[~, main_aggregates, ~, ~, ~] = equilLoop(Equil_sol,PP,SS);

if abs(main_aggregates(1,3))>0.001 || abs(main_aggregates(1,4))>0.001
    Res         =   inf;
    ExitFlag    =   4;
    return
end


%% 4. Simulated moments and SMM objective

Mom             =   ComputeMoments(Equil_sol,PP,SS);

% Pack the 14 simulated moments that target Table C.7.
Mom_Model       =   struct('sagg', Mom.sagg, ...
                           'sagg_nt', Mom.sagg_nt, ...
                           'std_l_rev_cond', Mom.std_l_rev_cond, ...
                           'std_l_rev_nt_cond', Mom.std_l_rev_nt_cond, ...
                           'std_l_sd_ratio', Mom.std_l_sd_ratio, ...
                           'std_l_sd_ratio_nt', Mom.std_l_sd_ratio_nt, ...
                           'moment_correlation', Mom.moment_correlation, ...
                           'moment_correlation_nt', Mom.moment_correlation_nt, ...
                           'mean_Dimm', Mom.mean_Dimm, ...
                           'mean_Dimm_nt', Mom.mean_Dimm_nt, ...
                           'mean_Dexp', Mom.mean_Dexp, ...
                           'moment_tau', Mom.moment_tau, ...
                           'GDP_RoW_Ger', Mom.GDP_RoW_Ger, ...
                           'mean_sd', Mom.mean_sd);

% Targeted data moments.
Mom_Data_draft  = struct('std_l_rev_cond', 1.38, 'sagg', 0.912, 'std_l_sd_ratio', 1.39, 'moment_correlation', 0.0208, ...
                         'GDP_RoW_Ger', 0.32, 'mean_Dexp', 0.37, 'mean_Dimm', 0.62, 'moment_tau', 0.79, ...
                         'mean_sd', 0.93, 'std_l_rev_nt_cond', 1.29, 'sagg_nt', 0.934, 'std_l_sd_ratio_nt', 1.586, ...
                         'moment_correlation_nt', 0.0084, 'mean_Dimm_nt', 0.61);

% Data minus model, in the order used by the weight matrix below.
Mom_Diff_draft = [   Mom_Data_draft.std_l_rev_cond           - Mom_Model.std_l_rev_cond , ...
                     Mom_Data_draft.sagg                     - Mom_Model.sagg , ...
                     Mom_Data_draft.std_l_sd_ratio           - Mom_Model.std_l_sd_ratio , ...
                     Mom_Data_draft.moment_correlation       - Mom_Model.moment_correlation , ...
                     Mom_Data_draft.GDP_RoW_Ger              - Mom_Model.GDP_RoW_Ger , ...
                     Mom_Data_draft.mean_Dimm                - Mom_Model.mean_Dimm , ...
                     Mom_Data_draft.mean_Dexp                - Mom_Model.mean_Dexp , ...
                     Mom_Data_draft.moment_tau               - Mom_Model.moment_tau , ...
                     Mom_Data_draft.std_l_rev_nt_cond        - Mom_Model.std_l_rev_nt_cond , ...
                     Mom_Data_draft.sagg_nt                  - Mom_Model.sagg_nt , ...
                     Mom_Data_draft.std_l_sd_ratio_nt        - Mom_Model.std_l_sd_ratio_nt , ...
                     Mom_Data_draft.moment_correlation_nt    - Mom_Model.moment_correlation_nt , ...
                     Mom_Data_draft.mean_Dimm_nt             - Mom_Model.mean_Dimm_nt , ...
                     Mom_Data_draft.mean_sd                  - Mom_Model.mean_sd];


% Diagonal weight matrix. Each diagonal entry is 1/data^2; some moments
% are scaled up so they contribute on a comparable order of magnitude.

MomWeight       =   struct('std_l_rev_cond', 1, 'sagg', 1, 'std_l_sd_ratio', 1, 'moment_correlation', 1, ...
                           'GDP_RoW_Ger', 1, 'mean_Dimm', 1, 'mean_Dexp', 1, 'moment_tau', 1, ...
                           'std_l_rev_nt_cond', 1, 'sagg_nt', 1, 'std_l_sd_ratio_nt', 1, ...
                           'moment_correlation_nt', 1, 'mean_Dimm_nt', 1, 'mean_sd', 1);

weight_mat          = eye(size(Mom_Diff_draft,2),size(Mom_Diff_draft,2));

weight_mat(1,1)     = MomWeight.std_l_rev_cond*(1/Mom_Data_draft.std_l_rev_cond^2);
weight_mat(2,2)     = MomWeight.sagg*(1/Mom_Data_draft.sagg^2)*100000000;
weight_mat(3,3)     = MomWeight.std_l_sd_ratio*(1/Mom_Data_draft.std_l_sd_ratio^2)*100000;
weight_mat(4,4)     = MomWeight.moment_correlation*(1/Mom_Data_draft.moment_correlation^2)*40000;
weight_mat(5,5)     = MomWeight.GDP_RoW_Ger*(1/Mom_Data_draft.GDP_RoW_Ger^2)*1000;
weight_mat(6,6)     = MomWeight.mean_Dimm*(1/Mom_Data_draft.mean_Dimm^2);
weight_mat(7,7)     = MomWeight.mean_Dexp*(1/Mom_Data_draft.mean_Dexp^2);
weight_mat(8,8)     = MomWeight.moment_tau*(1/Mom_Data_draft.moment_tau^2);
weight_mat(9,9)     = MomWeight.std_l_rev_nt_cond*(1/Mom_Data_draft.std_l_rev_nt_cond^2);
weight_mat(10,10)   = MomWeight.sagg_nt*(1/Mom_Data_draft.sagg_nt^2)*100000000;
weight_mat(11,11)   = MomWeight.std_l_sd_ratio_nt*(1/Mom_Data_draft.std_l_sd_ratio_nt^2)*100000;
weight_mat(12,12)   = MomWeight.moment_correlation_nt*(1/Mom_Data_draft.moment_correlation_nt^2)*40000;
weight_mat(13,13)   = MomWeight.mean_Dimm_nt*(1/Mom_Data_draft.mean_Dimm_nt^2);
weight_mat(14,14)   = MomWeight.mean_sd*(1/Mom_Data_draft.mean_sd^2)*1000;

Res             =   (Mom_Diff_draft)*weight_mat*(Mom_Diff_draft)';

ExitFlag        =   1;

Time_elapsed    =   toc;


ExtraDetails    =   struct('ExitFlag', ExitFlag, 'PP', PP, 'SS', SS, 'Equil_sol', Equil_sol, ...
                           'Mom_Data_draft', Mom_Data_draft, 'Mom_Model', Mom_Model, ...
                           'Res', Res, 'Time_elapsed', Time_elapsed);


%% 5. Print the snapshot

Mom_List    = {'std_l_rev_cond', 'sagg', 'std_l_sd_ratio', 'moment_correlation', 'GDP_RoW_Ger', ...
               'mean_Dexp', 'mean_Dimm', 'moment_tau', 'mean_sd', ...
               'std_l_rev_nt_cond', 'sagg_nt', 'std_l_sd_ratio_nt', 'moment_correlation_nt', 'mean_Dimm_nt'};

Mom_values =[Mom_Data_draft.std_l_rev_cond            , Mom_Model.std_l_rev_cond,        PP.sigma_psi    ; ...
             Mom_Data_draft.sagg                      , Mom_Model.sagg,                  PP.beta         ; ...
             Mom_Data_draft.std_l_sd_ratio            , Mom_Model.std_l_sd_ratio,        PP.sigma_f      ; ...
             Mom_Data_draft.moment_correlation        , Mom_Model.moment_correlation,    PP.cov_psif     ; ...
             Mom_Data_draft.GDP_RoW_Ger               , Mom_Model.GDP_RoW_Ger,           PP.mu_psix      ; ...
             Mom_Data_draft.mean_Dexp                 , Mom_Model.mean_Dexp,             PP.f_g          ; ...
             Mom_Data_draft.mean_Dimm                 , Mom_Model.mean_Dimm,             PP.f_imm        ; ...
             Mom_Data_draft.moment_tau                , Mom_Model.moment_tau,            PP.taugx        ; ...
             Mom_Data_draft.mean_sd                   , Mom_Model.mean_sd,               PP.iota         ; ...
             Mom_Data_draft.std_l_rev_nt_cond         , Mom_Model.std_l_rev_nt_cond,     PP.sigma_psi_nt ; ...
             Mom_Data_draft.sagg_nt                   , Mom_Model.sagg_nt,               PP.beta_nt      ; ...
             Mom_Data_draft.std_l_sd_ratio_nt         , Mom_Model.std_l_sd_ratio_nt,     PP.sigma_f_nt   ; ...
             Mom_Data_draft.moment_correlation_nt     , Mom_Model.moment_correlation_nt, PP.cov_psif_nt  ; ...
             Mom_Data_draft.mean_Dimm_nt              , Mom_Model.mean_Dimm_nt,          PP.f_imm_nt];

MomTab      = array2table(Mom_values, 'VariableNames', {'Data', 'Model', 'Parameters'}, 'RowNames', Mom_List);
display(MomTab);

return
