function [u_tilde] = utildent(sd,wd_nt,PP)
% utildent  Unit-cost CES aggregator over natives and immigrants, non-tradable sector.
%
%   u_tilde = utildet(sd, wd, PP) returns the firm-level unit labor in NT
%   sector
%
%   Inputs:
%
%     sd     - native domestic share (N_gx1 or scalar).
%     wd_nt  - native wage (NT sector, scalar).
%     PP     - parameter struct (uses beta_nt, epsilon).
%
%   Output:
%
%     u_tilde - unit cost (same shape as sd).

%% 1. Preliminaries: Unpack the parameters

beta_nt     = PP.beta_nt;
epsilon     = PP.epsilon;

%% 2. Computing the values of interest

epsilon_aux = 1/(epsilon-1);

u_tilde     = (beta_nt^(epsilon/(1-epsilon))*wd_nt).*sd.^epsilon_aux ;

end