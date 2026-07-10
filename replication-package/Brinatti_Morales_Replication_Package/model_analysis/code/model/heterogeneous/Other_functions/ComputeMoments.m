function Mom=ComputeMoments(Solution,PP,SS)
% ComputeMoments  Compute the 14 simulated moments at a given equilibrium.
%
%   Mom = ComputeMoments(Solution, PP, SS) evaluates equilLoop at the
%   equilibrium prices/wages and returns a struct with the 14 moments
%   that target Table C.7 of Brinatti & Morales (2026) and are consumed
%   by the SMM objective in Calibration_Res.
%
%   Inputs:
%
%     Solution - 10-element equilibrium vector (output of fsolve on equilLoop).
%     PP, SS   - parameter and heterogeneity structs (unused here but kept
%                for signature compatibility with the calibration call).
%
%   Output:
%
%     Mom - struct with the 14 simulated moments listed at the bottom.

%% 1. Equilibrium values

[~, main_aggregates, RoW, GER, GER_nt] = equilLoop(Solution,PP,SS);

wimm    = Solution(4);
wd_nt   = Solution(7);
wimm_nt = Solution(8);

rev_expo            = GER(:,14);
rev_dom             = GER(:,12) - GER(:,14);

Ld_alt_aux          = main_aggregates(1,5);
I_alt_aux           = main_aggregates(1,6);
Ld_alt_nt_aux       = main_aggregates(1,7);
I_alt_nt_aux        = main_aggregates(1,8);
Limm_count_aux      = main_aggregates(1,10);
Limm_nt_count_aux   = main_aggregates(1,11);
Lx_count_aux        = main_aggregates(1,12);
Ld_count_aux        = main_aggregates(1,13);
Ld_nt_count_aux     = main_aggregates(1,14);

workers_ger         = Limm_count_aux+Limm_nt_count_aux+Ld_count_aux+Ld_nt_count_aux;

%% 2. Aggregate immigrant share by sector (sagg, sagg_nt)

sagg        = Ld_alt_aux/(wimm*I_alt_aux+Ld_alt_aux);
sagg_nt     = wd_nt*Ld_alt_nt_aux/(wimm_nt*I_alt_nt_aux+wd_nt*Ld_alt_nt_aux);

%% 3. Dispersion of (1-s)/s (std_l_sd_ratio, std_l_sd_ratio_nt)

ratio_sd            = (1-GER(:,5))./GER(:,5);
indexToNonZero_T    = ((1-GER(:,5)).*GER(:,5))~=0;
std_l_sd_ratio      = std(log(ratio_sd(indexToNonZero_T)));

ratio_sd_nt         = (1-GER_nt(:,4))./GER_nt(:,4);
indexToNonZero_NT   = ((1-GER_nt(:,4)).*GER_nt(:,4))~=0;
std_l_sd_ratio_nt   = std(log(ratio_sd_nt(indexToNonZero_NT)));

%% 4. Share of firms hiring immigrants / exporting

mean_Dimm       = mean(GER(:,4));        % T sector, hire immigrants
mean_Dimm_nt    = mean(GER_nt(:,3));     % NT sector, hire immigrants
mean_Dexp       = mean(GER(:,3));        % T sector, exporters

%% 5. GDP per capita: RoW relative to Germany

GDP_RoW_Ger = (sum(RoW(:,5))/(Lx_count_aux)) / ((sum(GER(:,12))+sum(GER_nt(:,10)))/(workers_ger));

%% 6. Average immigrant share across all firms (T + NT)

mean_sd = mean([GER(:,5);GER_nt(:,4)]);

%% 7. Std of log(rev), conditional on s_j (and on exporter status in T)

l_rev = log(GER(:,12));
[~,~,r] = regress(l_rev, [GER(:,5) GER(:,3)]);
std_l_rev_cond = std(r) ;

l_rev_nt = log(GER_nt(:,10));
[~,~,r_nt] = regress(l_rev_nt, GER_nt(:,4));
std_l_rev_nt_cond = std(r_nt);

%% 8. Expected export-to-domestic revenue ratio in T

moment_tau = sum(rev_expo(rev_expo>0))/sum(rev_dom(rev_expo>0));

%% 9. p90 - p50 difference in (1 - s_j), with deciles formed jointly
%     across T and NT (moment_correlation, moment_correlation_nt)

revenues_all = [GER(:,12); GER_nt(:,10)];

p50_rev_all = (revenues_all>prctile(revenues_all,50) & revenues_all<prctile(revenues_all,60));
p90_rev_all = (revenues_all>prctile(revenues_all,80) & revenues_all<prctile(revenues_all,90));

p50_rev_T  = p50_rev_all(1:size(GER(:,12),1));
p50_rev_NT = p50_rev_all(size(GER(:,12),1)+1:size(revenues_all,1));
p90_rev_T  = p90_rev_all(1:size(GER(:,12),1));
p90_rev_NT = p90_rev_all(size(GER(:,12),1)+1:size(revenues_all,1));

sdom_p50_T = [GER(:,5) p50_rev_T];
sdom_p90_T = [GER(:,5) p90_rev_T];

median_p50_T = 1-mean(sdom_p50_T(sdom_p50_T(:,2)==1));
median_p90_T = 1-mean(sdom_p90_T(sdom_p90_T(:,2)==1));

moment_correlation = median_p90_T - median_p50_T;

sdom_p50_NT = [GER_nt(:,4) p50_rev_NT];
sdom_p90_NT = [GER_nt(:,4) p90_rev_NT];

median_p50_NT = 1-mean(sdom_p50_NT(sdom_p50_NT(:,2)==1));
median_p90_NT = 1-mean(sdom_p90_NT(sdom_p90_NT(:,2)==1));

moment_correlation_nt = median_p90_NT - median_p50_NT;


%% 10. Collect the 14 moments

Mom = struct('sagg',                   sagg, ...
             'sagg_nt',                sagg_nt, ...
             'std_l_rev_cond',         std_l_rev_cond, ...
             'std_l_rev_nt_cond',      std_l_rev_nt_cond, ...
             'std_l_sd_ratio',         std_l_sd_ratio, ...
             'std_l_sd_ratio_nt',      std_l_sd_ratio_nt, ...
             'moment_correlation',     moment_correlation, ...
             'moment_correlation_nt',  moment_correlation_nt, ...
             'mean_Dimm',              mean_Dimm, ...
             'mean_Dimm_nt',           mean_Dimm_nt, ...
             'mean_Dexp',              mean_Dexp, ...
             'moment_tau',             moment_tau, ...
             'GDP_RoW_Ger',            GDP_RoW_Ger, ...
             'mean_sd',                mean_sd);

end
