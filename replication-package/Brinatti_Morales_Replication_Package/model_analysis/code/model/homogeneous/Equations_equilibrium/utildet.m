function [u_tilde] = utildet(sd,wd,PP)
%
% utildet  Unit-cost CES aggregator over natives and immigrants, tradable sector.
%
%   u_tilde = utildet(sd, wd, PP) returns the firm-level unit labor in T
%   sector
%
%   Inputs:
%
%     sd - native domestic share (N_gx1 or scalar).
%     wd - native wage (T sector, scalar).
%     PP - parameter struct (uses beta, epsilon).
%
%   Output:
%
%     u_tilde - unit cost (same shape as sd).

%% 1. Preliminaries: Unpack the parameters

beta = PP.beta;
epsilon = PP.epsilon;

epsilon_aux = 1/(epsilon-1);

%% 2. Computing the values of interest

u_tilde = (beta^(epsilon/(1-epsilon))*wd).*sd.^epsilon_aux ;

end


