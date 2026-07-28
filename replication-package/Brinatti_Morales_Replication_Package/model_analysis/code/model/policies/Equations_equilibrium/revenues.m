function [rev_nexp_nt,rev_nexp_t ,rev_exp,rev_exp_only ] = revenues(sd,Pd,Pd_nt,Px,Yd_t,Yd_nt,Yx,wd,wd_nt,wimm,wimm_nt, PP, SS)
% revenues  Firm revenues for the three immigrant-hiring statuses.
%
%   [rev_nexp_nt, rev_nexp_t, rev_exp, rev_exp_only] = revenues(sd, ...)
%   returns per-firm revenues at native domestic share sd: domestic
%   revenue if the firm is a non-exporter in NT or in T, total revenue
%   (domestic + exports) if the firm is an exporter in T, and the export
%   component alone.
%
%   Inputs:
%
%     sd                          - native domestic share (N_gx1).
%     Pd, Pd_nt, Px, Yd_t, Yd_nt, Yx, wd, wd_nt, wimm, wimm_nt
%                                 - equilibrium aggregates.
%     PP, SS                      - parameter and heterogeneity structs.
%
%   Outputs:
%
%     rev_nexp_nt   - domestic revenue, NT non-exporter (N_gx1).
%     rev_nexp_t    - domestic revenue, T  non-exporter (N_gx1).
%     rev_exp       - total revenue, T exporter (N_gx1).
%     rev_exp_only  - export component of rev_exp (N_gx1).

%% 1. Preliminaries: Unpack the parameters

epsilon     = PP.epsilon;
sigma       = PP.sigma;
sigmax      = PP.sigmax;
taugx       = PP.taugx;

psi_g       = SS.psi_g;
psi_g_nt    = SS.psi_g_nt;

%% 2. Computing the values of interest

[D_t,D_nt ,Dexp,~, ~] = GE(Pd,Pd_nt,Px,Yd_t,Yd_nt,Yx,wd,wd_nt,wimm,wimm_nt, PP);

rev_nexp_nt = psi_g_nt.^(sigma-1) * D_nt      .* ( sd.^((1-sigma)/(epsilon-1)  ) ) ;
rev_nexp_t  = psi_g.^(sigma-1)    * D_t       .* ( sd.^((1-sigma)/(epsilon-1)  ) ) ;
rev_exp_only    = psi_g.^(sigmax-1)    * Dexp    .* ((1+taugx)).^(1-sigmax)  .*( sd.^((1-sigmax)/(epsilon-1)  ) ) ;
rev_exp     = rev_nexp_t  + rev_exp_only  ;


end