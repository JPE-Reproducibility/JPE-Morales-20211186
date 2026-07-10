function [prof_nexp_nt,prof_nexp_t ,prof_exp ] = profits(sd,Pd,Pd_nt,Px,Yd_t,Yd_nt,Yx,wd,wd_nt,wimm,wimm_nt,PP,SS)
%
% profits  Profit levels for the three immigrant-hiring statuses.
%
%   [prof_nexp_nt, prof_nexp_t, prof_exp] = profits(sd, ...) returns the
%   per-firm profit at the firm-specific optimal s_d for three statuses
%   that hire immigrants: non-exporter in NT, non-exporter in T, exporter
%   in T. 
%
%   Inputs:
%
%     sd                          - optimal native domestic share (N_gx1).
%     Pd, Pd_nt, Px, Yd_t, Yd_nt, Yx, wd, wd_nt, wimm, wimm_nt
%                                 - equilibrium aggregates.
%     PP, SS                      - parameter and heterogeneity structs.
%
%   Outputs:
%
%     prof_nexp_nt - profit if firm is a non-exporter in NT (N_gx1).
%     prof_nexp_t  - profit if firm is a non-exporter in T  (N_gx1).
%     prof_exp     - profit if firm is an exporter in T     (N_gx1).

%% 1. Preliminaries: Unpack the parameters

epsilon     = PP.epsilon;
iota        = PP.iota;
sigma       = PP.sigma;
sigmax      = PP.sigmax;
f_imm       = PP.f_imm;
f_imm_nt    = PP.f_imm_nt;
f_g         = PP.f_g; 

f_j_nt      = SS.f_j_nt;
f_j         = SS.f_j;


%% 2. Computing the values of interest

 [~,~ ,~,F_t, F_nt] = GE(Pd,Pd_nt,Px,Yd_t,Yd_nt,Yx,wd,wd_nt,wimm,wimm_nt,PP);

 iot = 1/(iota*(epsilon-1));

[rev_nexp_nt,rev_nexp_t ,~,rev_exp_only ] = revenues(sd,Pd,Pd_nt,Px,Yd_t,Yd_nt,Yx,wd,wd_nt,wimm,wimm_nt,PP,SS) ;

prof_nexp_nt = rev_nexp_nt  * (1/sigma)                             - f_j_nt .* F_nt.* (1./sd-1).^(iot) - wd_nt*f_imm_nt ;
prof_nexp_t  = rev_nexp_t   * (1/sigma)                             - f_j    .* F_t .* (1./sd-1).^(iot) - wd*f_imm ;
prof_exp     = rev_nexp_t   * (1/sigma) + rev_exp_only * (1/sigmax) - f_j    .* F_t .* (1./sd-1).^(iot) - wd*f_imm  - wd*f_g;

end