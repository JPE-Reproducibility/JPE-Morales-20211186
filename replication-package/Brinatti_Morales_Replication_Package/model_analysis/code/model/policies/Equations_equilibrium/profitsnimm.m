function [prof_nexp_nt,prof_nexp_t ,prof_exp ] = profitsnimm(sd,Pd,Pd_nt,Px,Yd_t,Yd_nt,Yx,wd,wd_nt,wimm,wimm_nt, PP,SS, transfer)
% profitsnimm  Profit levels for the three statuses without immigrants (policy variant).
%   [prof_nexp_nt, prof_nexp_t, prof_exp] = profitsnimm(sd, ..., transfer)
%   returns profits when the firm hires only natives (sd = 1, fixed cost
%   f_imm does not apply) for the three statuses: non-exporter in NT,
%   non-exporter in T, and exporter in T. The extra `transfer` argument is
%   the per-firm policy transfer (Section 6.4).
%
%   Inputs:
%
%     sd                          - optimal native domestic share (N_gx1).
%     Pd, Pd_nt, Px, Yd_t, Yd_nt, Yx, wd, wd_nt, wimm, wimm_nt
%                                 - equilibrium aggregates.
%     PP, SS                      - parameter and heterogeneity structs.
%     transfer                    - per-firm policy transfer (N_gx1 or scalar).
%
%   Outputs:
%
%     prof_nexp_nt - profit if firm is a non-exporter in NT (N_gx1).
%     prof_nexp_t  - profit if firm is a non-exporter in T  (N_gx1).
%     prof_exp     - profit if firm is an exporter in T     (N_gx1).

%% 1. Preliminaries: Unpack the parameters

sigma       = PP.sigma;
sigmax      = PP.sigmax;
f_g         = PP.f_g;


%% 2. Computing the values of interest

[rev_nexp_nt,rev_nexp_t ,~,rev_exp_only ] = revenues(sd,Pd,Pd_nt,Px,Yd_t,Yd_nt,Yx,wd,wd_nt,wimm,wimm_nt,PP,SS) ;

prof_nexp_nt = rev_nexp_nt  * (1/sigma)                             - wd_nt*transfer;
prof_nexp_t  = rev_nexp_t   * (1/sigma)                             - wd*transfer;
prof_exp     = rev_nexp_t   * (1/sigma) + rev_exp_only * (1/sigmax) - wd*f_g - wd*transfer;


end