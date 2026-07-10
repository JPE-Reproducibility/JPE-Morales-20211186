function [mig_cost_sol, mig_cost_nt_sol] = mig_costs_mapping(change, change_nt, x_0, PP, SS)

% mig_costs_mapping  Find the migration costs that achieve targeted immigrant inflows.
%
%   [mig_cost_sol, mig_cost_nt_sol] = mig_costs_mapping(change, change_nt,
%   x_0, PP, SS) inverts the labor-market clearing condition by iterating
%   on PP.mig_cost (tradable) and PP.mig_cost_nt (non-tradable) until the
%   counterfactual head-counts of immigrants are scaled by `change` (T)
%   and `change_nt` (NT) relative to the baseline equilibrium.
%
%   Inputs:
%
%     change     - target ratio of post-shock to baseline immigrant
%                  head-count in the tradable sector (e.g. 1.2 for +20%).
%     change_nt  - target ratio in the non-tradable sector.
%     x_0        - initial guess for fsolve at the baseline equilibrium.
%     PP, SS     - parameter and heterogeneity structs.
%
%   Outputs:
%
%     mig_cost_sol    - migration cost in the tradable sector delivering `change`.
%     mig_cost_nt_sol - migration cost in the non-tradable sector delivering `change_nt`.


fsolve_opts = optimoptions('fsolve', 'Display', 'off');


% Baseline equilibrium under the caller's PP.mig_cost / PP.mig_cost_nt ---

f   = @(x) equilLoop(x, PP, SS);
x_0 = fsolve(f, x_0, fsolve_opts);

[~, main_aggregates] = equilLoop(x_0, PP, SS);

Limm_count_orig    = main_aggregates(10);    % baseline tradable immigrant head-count
Limm_nt_count_orig = main_aggregates(11);    % baseline non-tradable immigrant head-count


% Iterate on mig_cost until both target ratios are matched ---

PP.mig_cost    = 0.98;     % initial guess (updated inside the loop)
PP.mig_cost_nt = 0.98;

adjust2     = 0.9;         % relaxation factor on the update step
max_iter2   = 1e6;
omega_tol2  = 1e-5;
omega_crit2 = 1e3;         % initialise above tolerance to enter the loop
omega_iter2 = 0;

while omega_crit2 > omega_tol2 && omega_iter2 < max_iter2

    omega_iter2 = omega_iter2 + 1;

    f   = @(x) equilLoop(x, PP, SS);
    x_0 = fsolve(f, x_0, fsolve_opts);

    [~, main_aggregates] = equilLoop(x_0, PP, SS);
    Limm_count_new    = main_aggregates(10);
    Limm_nt_count_new = main_aggregates(11);

    ratio_t     = Limm_count_new    / Limm_count_orig;
    ratio_nt    = Limm_nt_count_new / Limm_nt_count_orig;
    omega_crit2 = max(abs(ratio_t - change), abs(ratio_nt - change_nt));

    PP.mig_cost    = PP.mig_cost    + adjust2 * PP.mig_cost    * (ratio_t  - change)    / (ratio_t  + change);
    PP.mig_cost_nt = PP.mig_cost_nt + adjust2 * PP.mig_cost_nt * (ratio_nt - change_nt) / (ratio_nt + change_nt);

end

mig_cost_sol    = PP.mig_cost;
mig_cost_nt_sol = PP.mig_cost_nt;

end
