function [SS] = Heterogeneity(PP)

% Heterogeneity  Draw firm-level productivity and fixed-cost realizations.
%
%   SS = Heterogeneity(PP) generates N_g lognormal draws of (psi_g, f_j)
%   for the tradable sector and (psi_g_nt, f_j_nt) for the non-tradable
%   sector from bivariate distributions whose moments are stored in PP,
%   plus N_x draws of psi_x for the rest of the world.
%
%   Input:
%
%     PP - parameter struct from Setup_PP.
%
%   Output:
%
%     SS - struct with fields psi_g, f_j, psi_x, psi_g_nt, f_j_nt.


% Loading the parameters of the distributions

mu_psi       = PP.mu_psi;
mu_f         = PP.mu_f;
sigma_psi    = PP.sigma_psi;
cov_psif     = PP.cov_psif;
sigma_f      = PP.sigma_f;

mu_psi_nt    = PP.mu_psi_nt;
mu_f_nt      = PP.mu_f_nt;
sigma_psi_nt = PP.sigma_psi_nt;
cov_psif_nt  = PP.cov_psif_nt;
sigma_f_nt   = PP.sigma_f_nt;

mu_psix      = PP.mu_psix;
sigma_psix   = PP.sigma_psix;

N_g          = PP.N_g;
N_x          = PP.N_x;

% The random seed is fixed so the same firm sample is used every time

seed = 321;

% Heterogeneity realizations

rng('default');
rng(seed);

mu     = [mu_psi    mu_f];
var    = [sigma_psi   cov_psif;
          cov_psif    sigma_f];

mu_nt  = [mu_psi_nt   mu_f_nt];
var_nt = [sigma_psi_nt  cov_psif_nt;
          cov_psif_nt   sigma_f_nt];

normal_draw    = exp(mvnrnd(mu,    var,    N_g));
normal_draw_x  = exp(mu_psix + sigma_psix * randn(N_x, 1));
normal_draw_nt = exp(mvnrnd(mu_nt, var_nt, N_g));

psi_g    = normal_draw(:, 1);
f_j      = normal_draw(:, 2);
psi_x    = normal_draw_x(:, 1);
psi_g_nt = normal_draw_nt(:, 1);
f_j_nt   = normal_draw_nt(:, 2);

% Truncate top 0.5% extreme values in productivities

pct_psi_g    = prctile(psi_g,    99.5);
pct_psi_x    = prctile(psi_x,    99.5);
pct_psi_g_nt = prctile(psi_g_nt, 99.5);

psi_g(   psi_g    > pct_psi_g   ) = pct_psi_g;
psi_x(   psi_x    > pct_psi_x   ) = pct_psi_x;
psi_g_nt(psi_g_nt > pct_psi_g_nt) = pct_psi_g_nt;


%% Collect the parameters

SS = struct('psi_g',    psi_g, ...
            'f_j',      f_j, ...
            'psi_x',    psi_x, ...
            'psi_g_nt', psi_g_nt, ...
            'f_j_nt',   f_j_nt);

end
