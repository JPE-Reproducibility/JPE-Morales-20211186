function [D_t,D_nt ,Dexp,F_t, F_nt] = GE(Pd,Pd_nt,Px,Yd_t,Yd_nt,Yx,wd,wd_nt,wimm,wimm_nt, PP)
% GE  Aggregate demand shifters and fixed-cost units entering firm problems.
%   [D_t, D_nt, Dexp, F_t, F_nt] = GE(Pd, Pd_nt, Px, Yd_t, Yd_nt, Yx, wd,
%   wd_nt, wimm, wimm_nt, PP) computes the firm-level demand shifters in
%   the tradable sector (D_t), non-tradable sector (D_nt), and export
%   market (Dexp), together with the per-source fixed-cost units F_t and
%   F_nt that govern the cost of hiring immigrants. The shifters depend
%   only on aggregate prices, expenditures, and the wage block; they
%   enter the closed-form revenue and FOC expressions.
%
%   Inputs:
%
%     Pd, Pd_nt, Px       - price indices in T, NT, and RoW.
%     Yd_t, Yd_nt, Yx     - aggregate expenditures on T, NT, and RoW.
%     wd, wd_nt           - native wages in T and NT.
%     wimm, wimm_nt       - immigrant wages in T and NT.
%     PP                  - parameter struct.
%   Outputs:
%
%     D_t, D_nt, Dexp     - firm-level demand shifters (T, NT, exports).
%     F_t, F_nt           - per-source fixed-cost units in T and NT.


%% 1. Preliminaries: Unpack the parameters

sigma       = PP.sigma ;
sigmat      = PP.sigmat;
sigmax      = PP.sigmax;
sigmaxt     = PP.sigmaxt; 
beta        = PP.beta;
beta_nt     = PP.beta_nt;
epsilon     = PP.epsilon;
xbar        = PP.xbar;
iota        = PP.iota;

%% 2. Computing the values of interest

D_t     = Pd^(sigma-1)*   Yd_t* (sigmat)*( (beta^(epsilon/(1-epsilon))*wd)^(1-sigma) );

D_nt    = Pd_nt^(sigma-1)*Yd_nt*(sigmat)*( (beta_nt^(epsilon/(1-epsilon))*wd_nt)^(1-sigma) );

Dexp    = Px^(sigmax-1)*   Yx*   (sigmaxt)*( (beta^(epsilon/(1-epsilon))*wd)^(1-sigmax) );

F_t      = wd*xbar*( ((beta^epsilon*wd^(1-epsilon))/((1-beta)^epsilon*wimm^(1-epsilon)))^(1/(iota*(epsilon-1)))  );
             
F_nt     = wd_nt*xbar*( ((beta_nt^epsilon*wd_nt^(1-epsilon))/((1-beta_nt)^epsilon*wimm_nt^(1-epsilon)))^(1/(iota*(epsilon-1)))  );
            
end

