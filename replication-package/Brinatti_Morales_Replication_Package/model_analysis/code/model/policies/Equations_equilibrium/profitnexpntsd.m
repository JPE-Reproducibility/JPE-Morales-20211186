function [profsd_nexp] = profitnexpntsd(sd, Pd,Pd_nt,Px,Yd_t,Yd_nt,Yx,wd,wd_nt,wimm,wimm_nt,PP,SS)
% profitnexpntsd  First-order condition w.r.t. s_d for a non-tradable non-exporter.
%   profsd_nexp = profitnexpntsd(sd, ...) returns the FOC residual for a
%   firm in the non-tradable sector that hires immigrants. 
%
%   Inputs (per firm in SS or aggregate):
%     sd                          - candidate native domestic share (N_gx1).
%     Pd, Pd_nt, Px, Yd_t, Yd_nt, Yx, wd, wd_nt, wimm, wimm_nt
%                                 - equilibrium aggregates passed through GE.
%     PP, SS                      - parameter and heterogeneity structs.
%   Output:
%
%     profsd_nexp - FOC residual (N_gx1).

%% 1. Preliminaries: Unpack the parameters

epsilon     = PP.epsilon;
iota        = PP.iota;
sigma       = PP.sigma;

psi_g_nt    = SS.psi_g_nt;
f_j_nt      = SS.f_j_nt;

%% 2. Computing the values of interest

[~,D_nt ,~,~, F_nt] = GE(Pd,Pd_nt,Px,Yd_t,Yd_nt,Yx,wd,wd_nt,wimm,wimm_nt,PP);

iot = 1/(iota*(epsilon-1));

profsd_nexp = psi_g_nt.^(sigma-1) * D_nt * (1/sigma) * ((1-sigma)/(epsilon-1)) .* ( sd.^((1-sigma)/(epsilon-1) -1 ) )  + f_j_nt .* F_nt * iot .* sd.^(-2) .* (1./sd-1).^(iot-1) ;

end


