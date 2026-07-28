function [profsd_nexp] = profitnexptsd(sd,Pd,Pd_nt,Px,Yd_t,Yd_nt,Yx,wd,wd_nt,wimm,wimm_nt,PP,SS)
%
% profitnexptsd  First-order condition w.r.t. s_d for a tradable non-exporter.
%
%   profsd_nexp = profitnexptsd(sd, ...) returns the FOC residual for a
%   non-exporting firm in the tradable sector.
%
%   Inputs:
%
%     sd          - candidate native domestic share (N_gx1).
%     Pd, Pd_nt, Px, Yd_t, Yd_nt, Yx, wd, wd_nt, wimm, wimm_nt
%                 - equilibrium aggregates passed through GE.
%     PP, SS      - parameter and heterogeneity structs.
%
%   Output:
%
%     profsd_nexp - FOC residual (N_gx1).

%% 1. Preliminaries: Unpack the parameters

epsilon     = PP.epsilon;
iota        = PP.iota;
sigma       = PP.sigma;

psi_g = SS.psi_g; 
f_j   = SS.f_j;


%% 2. Computing the values of interest

[D_t,~ ,~,F_t, ~] = GE(Pd,Pd_nt,Px,Yd_t,Yd_nt,Yx,wd,wd_nt,wimm,wimm_nt,PP);

iot = 1/(iota*(epsilon-1));

profsd_nexp = psi_g.^(sigma-1) * D_t * (1/sigma) * ((1-sigma)/(epsilon-1)) .* ( sd.^((1-sigma)/(epsilon-1) -1 ) )  + f_j .* F_t * iot .* sd.^(-2) .* (1./sd-1).^(iot-1) ;

end