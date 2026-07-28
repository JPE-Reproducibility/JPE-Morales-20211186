function [profsd_exp] = profitexpsd(sd,Pd,Pd_nt,Px,Yd_t,Yd_nt,Yx,wd,wd_nt,wimm,wimm_nt,PP,SS)
%
% profitexpsd  First-order condition w.r.t. s_d for a tradable exporter.
%
%   profsd_exp = profitexpsd(sd, Pd, Pd_nt, Px, Yd_t, Yd_nt, Yx, wd, wd_nt,
%   wimm, wimm_nt, PP, SS) returns the derivative of profit with respect
%   to the native domestic share s_d, evaluated firm-by-firm at sd, for a
%   firm in the tradable sector that exports and hires immigrants. The
%   bisection inside equilLoop drives this residual to zero to recover
%   the firm's optimal s_d.
%
%   Inputs (per firm in SS or aggregate):
%     sd                          - candidate native domestic share (N_gx1).
%     Pd, Pd_nt, Px, Yd_t, Yd_nt, Yx, wd, wd_nt, wimm, wimm_nt
%                                 - equilibrium aggregates passed through GE.
%     PP, SS                      - parameter and heterogeneity structs.
%
%   Output:
%
%     profsd_exp - FOC residual (N_gx1).

%% 1. Preliminaries: Unpack the parameters

epsilon     = PP.epsilon;
iota        = PP.iota;
sigma       = PP.sigma;
sigmax      = PP.sigmax;
taugx       = PP.taugx;

psi_g       = SS.psi_g; 
f_j         = SS.f_j;


%% 2. Computing the values of interest

[D_t,~ ,Dexp,F_t, ~] = GE(Pd,Pd_nt,Px,Yd_t,Yd_nt,Yx,wd,wd_nt,wimm,wimm_nt,PP);

iot = 1/(iota*(epsilon-1));

profsd_exp  = psi_g.^(sigma-1) *((D_t )/sigma) * ((1-sigma)/(epsilon-1)) .* ( sd.^((1-sigma)/(epsilon-1) -1 ) ) ...
            + psi_g.^(sigmax-1)*((Dexp)/sigmax)* (1+taugx)^(1-sigmax) * ((1-sigmax)/(epsilon-1)) .* ( sd.^((1-sigmax)/(epsilon-1) -1 ) ) ...
            + f_j .* F_t * iot .* sd.^(-2) .* (1./sd-1).^(iot-1) ;

end

