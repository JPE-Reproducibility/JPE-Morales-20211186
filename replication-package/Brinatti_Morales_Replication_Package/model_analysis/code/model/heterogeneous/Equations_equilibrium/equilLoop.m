function [F, main_aggregates, RoW, GER, GER_nt] = equilLoop(x,PP,SS)

% equilLoop  Residual of the general-equilibrium system at prices/wages x.
%
%   [F, main_aggregates, RoW, GER, GER_nt] = equilLoop(x, PP, SS) takes a
%   10-element vector x of equilibrium prices, wages, and aggregate
%   profits, solves the firm problems, aggregates over firms,
%   and returns the 10-element residual F that must equal zero in
%   equilibrium. equilLoop is the function passed to fsolve in every
%   counterfactual / validation / calibration routine.
%
%   Inputs:
%
%     x  - 10x1 vector of prices.
%     PP - parameter struct.
%     SS - heterogeneity struct (firm draws).
%
%   Outputs:
%
%     F                - 10x1 residual of the equilibrium conditions.
%     main_aggregates  - 1x17 vector of aggregate quantities.
%     RoW              - Nx5 matrix of rest-of-world firm-level outcomes.
%     GER              - N_gx19 matrix of German tradable-sector firm outcomes.
%     GER_nt           - N_gx16 matrix of German non-tradable-sector firm outcomes.


%% 1. Preliminaries: Unpack the parameters

epsilon     = PP.epsilon;
iota        = PP.iota;
sigma       = PP.sigma;
sigmax      = PP.sigmax;
mig_cost    = PP.mig_cost;
mig_cost_nt = PP.mig_cost_nt;
N_g         = PP.N_g;
f_g         = PP.f_g;
taugx       = PP.taugx ;
sigmat      = PP.sigmat;
sigmaxt     = PP.sigmaxt;
kappa       = PP.kappa;
f_imm       = PP.f_imm;
f_imm_nt    = PP.f_imm_nt;
alpha       = PP.alpha;
f_x         = PP.f_x;
tauxg       = PP.tauxg;
Lx_bar      = PP.Lx_bar;
Ld_bar      = PP.Ld_bar;

psi_g       = SS.psi_g;
f_j         = SS.f_j;
psi_x       = SS.psi_x;
psi_g_nt    = SS.psi_g_nt;
f_j_nt      = SS.f_j_nt;


%% 2. Preliminaries: Unpack equilibrium variables

wd=1;

wx=x(1);
Pd=x(2);
Px=x(3);
wimm=x(4);
pid=x(5);
pix=x(6);
wd_nt= x(7);
wimm_nt=x(8);
Pd_nt= x(9);
pid_nt=x(10);

%% 3. Labor Supply
% Native (German) and immigrant workers draw idiosyncratic Frechet
% productivity shocks. Below we compute sector shares, the count of
% workers in each sector, and the efficiency-unit aggregates that enter
% the firm side (Limm, Limm_nt, Lx, Ld, Ld_nt).

Pg=(Pd_nt/alpha)^alpha*(Pd/(1-alpha))^(1-alpha);

pi_g_t=((wd/Pg)^kappa)/((wd/Pg)^kappa+(wd_nt/Pg)^kappa);
pi_g_nt=((wd_nt/Pg)^kappa)/((wd/Pg)^kappa+(wd_nt/Pg)^kappa);

pi_x_x=((wx/Px)^kappa)/((wimm/Pg)^kappa*mig_cost^(-kappa)+(wimm_nt/Pg)^kappa*mig_cost_nt^(-kappa)+(wx/Px)^kappa);
pi_x_t=((wimm/Pg)^kappa*mig_cost^(-kappa))/((wimm/Pg)^kappa*mig_cost^(-kappa)+(wimm_nt/Pg)^kappa*mig_cost_nt^(-kappa)+(wx/Px)^kappa);
pi_x_nt=((wimm_nt/Pg)^kappa*mig_cost_nt^(-kappa))/((wimm/Pg)^kappa*mig_cost^(-kappa)+(wimm_nt/Pg)^kappa*mig_cost_nt^(-kappa)+(wx/Px)^kappa);

Limm=Lx_bar*pi_x_t*gamma(1-1/kappa)*(pi_x_t)^(-1/kappa);
Limm_nt=Lx_bar*pi_x_nt*gamma(1-1/kappa)*(pi_x_nt)^(-1/kappa);
Lx=Lx_bar*pi_x_x*gamma(1-1/kappa)*(pi_x_x)^(-1/kappa);

Ld=Ld_bar*pi_g_t*gamma(1-1/kappa)*(pi_g_t)^(-1/kappa);
Ld_nt=Ld_bar*pi_g_nt*gamma(1-1/kappa)*(pi_g_nt)^(-1/kappa);

Limm_count=Lx_bar*pi_x_t;
Limm_nt_count=Lx_bar*pi_x_nt;
Lx_count=Lx_bar*pi_x_x;
Ld_count=Ld_bar*pi_g_t;
Ld_nt_count=Ld_bar*pi_g_nt;


%% 4. Labor Demand

%% 4.1. Aggregate variables (relevant for firms' decisions)
% Total income / GDP entering the CES demand at the sector level.

Yx = (Lx*wx)+pix;
Yd= (Ld*wd+Limm*wimm+Ld_nt*wd_nt+Limm_nt*wimm_nt)+pid+pid_nt;

Yd_nt=alpha*Yd;
Yd_t=(1-alpha)*Yd;


%% 4.2. Germany

%% 4.2.0. Preliminary: bracket the immigrant-share FOC at sd_min and sd_max
% For each of the three interior statuses (NT non-exporter, T non-exporter,
% T exporter) check that the FOC has opposite signs at sd_min=1e-4 and
% sd_max=1 for every firm. If it doesn't, bisection cannot find a root;
% set F = Inf so fsolve learns the current prices are off-equilibrium.

sd_min = 0.0001*ones(N_g,1) ;
sd_max = 1*ones(N_g,1);

%non exporter in NT (hirin immigrants)
    profitsd_min = profitnexpntsd(sd_min,Pd,Pd_nt,Px,Yd_t,Yd_nt,Yx,wd,wd_nt,wimm,wimm_nt,PP,SS);
    profitsd_max = profitnexpntsd(sd_max,Pd,Pd_nt,Px,Yd_t,Yd_nt,Yx,wd,wd_nt,wimm,wimm_nt,PP,SS);
    
    check_nexp_nt = profitsd_min.*profitsd_max  ;
    check_nexp_nt(~isfinite(check_nexp_nt)) = NaN ; 
    clear profitsd_min profitsd_max

%non exporter in T (hirin immigrants)
    profitsd_min = profitnexptsd(sd_min,Pd,Pd_nt,Px,Yd_t,Yd_nt,Yx,wd,wd_nt,wimm,wimm_nt,PP,SS);
    profitsd_max = profitnexptsd(sd_max,Pd,Pd_nt,Px,Yd_t,Yd_nt,Yx,wd,wd_nt,wimm,wimm_nt,PP,SS);

    check_nexp_t = profitsd_min.*profitsd_max ;
    check_nexp_t(~isfinite(check_nexp_t)) = NaN ; 
    clear profitsd_min profitsd_max

% exporter in T (hirin immigrants)
    profitsd_min = profitexpsd(sd_min,Pd,Pd_nt,Px,Yd_t,Yd_nt,Yx,wd,wd_nt,wimm,wimm_nt,PP,SS);
    profitsd_max = profitexpsd(sd_max,Pd,Pd_nt,Px,Yd_t,Yd_nt,Yx,wd,wd_nt,wimm,wimm_nt,PP,SS);

    check_exp_t = profitsd_min.*profitsd_max  ;
    check_exp_t(~isfinite(check_exp_t)) = NaN ;     
    clear profitsd_min profitsd_max

 %If the check is OK for each firm in each status, compute the optimal choices
 % and aggregate. Otherwise set a excess of demand or supply (e.g. non-zero F)


 if max(check_nexp_nt)>0 || max(check_nexp_t)>0 || max(check_exp_t)>0
        F(1)=Inf;
        F(2)=Inf;
        F(3)=Inf;
        F(4)=Inf;
        F(5)=Inf;
        F(6)=Inf;
        F(7)=Inf;
        F(8)=Inf;
        F(9)=Inf;
        F(10)=Inf;

        GER             = Inf*zeros(N_g, 14);
        GER_nt          = Inf*zeros(N_g, 11);
        RoW             = Inf*zeros(N_g, 5);
        main_aggregates = Inf*zeros(1, 17);

        return;


 else

%% 4.2.1. Firms in the NT sector: optimal immigrant share (conditional on hiring imm)
% Bisection on profitnexpntsd(s, ...) = 0 over s in [sd_min, sd_max].

sd_min = 0.0001*ones(N_g,1) ;
sd_max = 1*ones(N_g,1);

% Initialize the bisection
c           = 0;
accuracy    = 10 ; 
tol         = 0.00001 ;
iter_max    = 100;


while (accuracy > tol & c<iter_max)
 
 c          = c + 1;
 sd_0       = (sd_min + sd_max)/2;
 accuracy   = max(abs(profitnexpntsd(sd_0,Pd,Pd_nt,Px,Yd_t,Yd_nt,Yx,wd,wd_nt,wimm,wimm_nt,PP,SS))) ;
 
% Update the bracket: if the FOC changes sign between sd_min and sd_0 keep [sd_min, sd_0]; otherwise keep [sd_0, sd_max].

D_upd_max = (profitnexpntsd(sd_min,Pd,Pd_nt,Px,Yd_t,Yd_nt,Yx,wd,wd_nt,wimm,wimm_nt,PP,SS).*profitnexpntsd(sd_0,Pd,Pd_nt,Px,Yd_t,Yd_nt,Yx,wd,wd_nt,wimm,wimm_nt,PP,SS) < 0 );
sd_max    = sd_max + D_upd_max.* (sd_0 - sd_max) ; 

D_upd_min = (profitnexpntsd(sd_max, Pd,Pd_nt,Px,Yd_t,Yd_nt,Yx,wd,wd_nt,wimm,wimm_nt,PP,SS).*profitnexpntsd(sd_0,Pd,Pd_nt,Px,Yd_t,Yd_nt,Yx,wd,wd_nt,wimm,wimm_nt,PP,SS) < 0 );
sd_min    = sd_min + D_upd_min.* (sd_0 - sd_min) ; 


end

sd_nexp_nt                = sd_0;
FOC_nexp_nt               = profitnexpntsd(sd_nexp_nt,Pd,Pd_nt,Px,Yd_t,Yd_nt,Yx,wd,wd_nt,wimm,wimm_nt,PP,SS);
[prof_nexp_imm_nt,~,~]    = profits(sd_nexp_nt,Pd,Pd_nt,Px,Yd_t,Yd_nt,Yx,wd,wd_nt,wimm,wimm_nt,PP,SS);
[rev_nexp_imm_nt,~ ,~,~ ] = revenues(sd_nexp_nt,Pd,Pd_nt,Px,Yd_t,Yd_nt,Yx,wd,wd_nt,wimm,wimm_nt,PP,SS);



%% 4.2.2. Firms in the T sector: optimal immigrant share (conditional on hiring imm and not exporting)
% Bisection on profitnexptsd(s, ...) = 0.

sd_min = 0.0001*ones(N_g,1) ;
sd_max = 1*ones(N_g,1);

% Initialize the bisection
c=0;
accuracy = 10 ; 
tol = 0.00001 ;
iter_max=100;


while (accuracy > tol & c<iter_max)
 c = c + 1;
 
 sd_0 = (sd_min + sd_max)/2;
 
 accuracy = max(abs(profitnexptsd(sd_0,Pd,Pd_nt,Px,Yd_t,Yd_nt,Yx,wd,wd_nt,wimm,wimm_nt,PP,SS))) ;
 
% Update the bracket: if the FOC changes sign between sd_min and sd_0 keep [sd_min, sd_0]; otherwise keep [sd_0, sd_max].

D_upd_max = (profitnexptsd(sd_min,Pd,Pd_nt,Px,Yd_t,Yd_nt,Yx,wd,wd_nt,wimm,wimm_nt,PP,SS).*profitnexptsd(sd_0,Pd,Pd_nt,Px,Yd_t,Yd_nt,Yx,wd,wd_nt,wimm,wimm_nt,PP,SS) < 0 );
sd_max    = sd_max + D_upd_max.* (sd_0 - sd_max) ; 

D_upd_min = (profitnexptsd(sd_max,Pd,Pd_nt,Px,Yd_t,Yd_nt,Yx,wd,wd_nt,wimm,wimm_nt,PP,SS).*profitnexptsd(sd_0,Pd,Pd_nt,Px,Yd_t,Yd_nt,Yx,wd,wd_nt,wimm,wimm_nt,PP,SS) < 0 );
sd_min    = sd_min + D_upd_min.* (sd_0 - sd_min) ; 
end
sd_nexp            = sd_0;
FOC_nexp            = profitnexptsd(sd_nexp,Pd,Pd_nt,Px,Yd_t,Yd_nt,Yx,wd,wd_nt,wimm,wimm_nt,PP,SS);
[~,prof_nexp_imm,~]   = profits(sd_nexp,Pd,Pd_nt,Px,Yd_t,Yd_nt,Yx,wd,wd_nt,wimm,wimm_nt,PP,SS);
[~,rev_nexp_imm ,~,~ ] = revenues(sd_nexp,Pd,Pd_nt,Px,Yd_t,Yd_nt,Yx,wd,wd_nt,wimm,wimm_nt,PP,SS);



%% 4.2.3. Firms in the T sector: optimal immigrant share (conditional on hiring imm and exporting)
% Bisection on profitexpsd(s, ...) = 0.

sd_min = 0.0001*ones(N_g,1) ;
sd_max = 1*ones(N_g,1);

% Initialize the bisection
c=0;
accuracy = 10 ; 
tol = 0.00001 ;
iter_max=100;

while (accuracy > tol & c<iter_max)
 c = c + 1;
 
 sd_0 = (sd_min + sd_max)/2;
 
 accuracy = max(abs(profitexpsd(sd_0,Pd,Pd_nt,Px,Yd_t,Yd_nt,Yx,wd,wd_nt,wimm,wimm_nt,PP,SS))) ;


% Update the bracket: if the FOC changes sign between sd_min and sd_0 keep [sd_min, sd_0]; otherwise keep [sd_0, sd_max].

D_upd_max = (profitexpsd(sd_min,Pd,Pd_nt,Px,Yd_t,Yd_nt,Yx,wd,wd_nt,wimm,wimm_nt,PP,SS).*profitexpsd(sd_0,Pd,Pd_nt,Px,Yd_t,Yd_nt,Yx,wd,wd_nt,wimm,wimm_nt,PP,SS) < 0 );
sd_max    = sd_max + D_upd_max.* (sd_0 - sd_max) ; 

D_upd_min = (profitexpsd(sd_max,Pd,Pd_nt,Px,Yd_t,Yd_nt,Yx,wd,wd_nt,wimm,wimm_nt,PP,SS).*profitexpsd(sd_0,Pd,Pd_nt,Px,Yd_t,Yd_nt,Yx,wd,wd_nt,wimm,wimm_nt,PP,SS) < 0 );
sd_min    = sd_min + D_upd_min.* (sd_0 - sd_min) ; 


end

sd_exp             = sd_0;
FOC_exp             = profitexpsd(sd_exp,Pd,Pd_nt,Px,Yd_t,Yd_nt,Yx,wd,wd_nt,wimm,wimm_nt,PP,SS);
[~,~,prof_exp_imm]  = profits(sd_exp,Pd,Pd_nt,Px,Yd_t,Yd_nt,Yx,wd,wd_nt,wimm,wimm_nt,PP,SS);
[~,~ ,rev_exp_imm,rev_exp_imm_onlyexp ] = revenues(sd_exp,Pd,Pd_nt,Px,Yd_t,Yd_nt,Yx,wd,wd_nt,wimm,wimm_nt,PP,SS);


%% 4.2.4. Firms in the T and NT sectors: discrete choice (export or not, hire imm or not)
% Choose the status that yields the highest profit, comparing the conditional
%  payoffs (computed above) with the payoff of not hiring immigrants.

% Revenues and profits conditional on NOT hiring immigrants (s = 1)
[prof_nexp_nimm_nt,prof_nexp_nimm,prof_exp_nimm] = profitsnimm(ones(N_g,1),Pd,Pd_nt,Px,Yd_t,Yd_nt,Yx,wd,wd_nt,wimm,wimm_nt,PP,SS);

% Argmax over the 4 statuses available to a T firm
prof_conditional = [prof_nexp_imm , prof_exp_imm , prof_nexp_nimm , prof_exp_nimm ];
[prof,prof_pos]= max(prof_conditional,[],2);

% Argmax over the 2 statuses available to an NT firm (no export choice)
prof_conditional_nt = [prof_nexp_imm_nt , prof_nexp_nimm_nt];
[prof_nt,prof_pos_nt]= max(prof_conditional_nt,[],2);

% Dummy exporter, Dummy hirer immigrant for each firm

D_imm_nexp  = (prof_pos ==1);
D_imm_exp   = (prof_pos ==2);
D_nimm_nexp = (prof_pos ==3);
D_nimm_exp  = (prof_pos ==4);

D_exporter = D_imm_exp + D_nimm_exp;
D_imm      = D_imm_exp + D_imm_nexp;

D_imm_nexp_nt  = (prof_pos_nt ==1);
D_nimm_nexp_nt = (prof_pos_nt ==2);

D_imm_nt      = D_imm_nexp_nt;


%% 4.2.5. Store firm-level variables
% Domestic share, unit cost, prices, quantities, revenues,labor and immigrant 
% demands, fixed costs, and assembly of the GER and GER_nt matrices used 
% downstream by Stata and the export helpers.

% Revenues for the no-immigrants statuses (s = 1) -- reused by T and NT firms that did not hire immigrants.
[rev_nexp_nimm_nt, rev_nexp_nimm, rev_exp_nimm, rev_exp_nimm_onlyexp] = revenues(ones(N_g,1), Pd, Pd_nt, Px, Yd_t, Yd_nt, Yx, wd, wd_nt, wimm, wimm_nt, PP, SS);

% T sector: immigrant share, unit cost, total revenue, export revenue, domestic revenue
sdom        = D_imm_exp.*sd_exp + D_imm_nexp.*sd_nexp + D_nimm_exp + D_nimm_nexp;
u_tilde     = D_imm.*utildet(sdom, wd, PP) + (1-D_imm)*utildet(1, wd, PP);
rev         = D_imm_exp.*rev_exp_imm + D_imm_nexp.*rev_nexp_imm + D_nimm_exp.*rev_exp_nimm + D_nimm_nexp.*rev_nexp_nimm;
rev_exports = D_imm_exp.*rev_exp_imm_onlyexp + D_nimm_exp.*rev_exp_nimm_onlyexp;
rev_dom     = rev - rev_exports;

% NT sector: immigrant share, unit cost, revenue 
sdom_nt     = D_imm_nexp_nt.*sd_nexp_nt + D_nimm_nexp_nt;
u_tilde_nt  = D_imm_nt.*utildent(sdom_nt, wd_nt, PP) + (1-D_imm_nt)*utildent(1, wd_nt, PP);
rev_nt      = D_imm_nexp_nt.*rev_nexp_imm_nt + D_nimm_nexp_nt.*rev_nexp_nimm_nt;

% T sector: unit cost per productivity unit (u), CES markup price for domestic (p_dd) and export (p_ddx) markets, and quantities (q_dd and q_dx).
u           = u_tilde ./ psi_g;
p_dd        = sigma /(sigma -1) * u;
p_ddx       = sigmax/(sigmax-1) * u;
q_dd        = p_dd.^(-sigma) * Pd^(sigma-1) * Yd_t;
q_dx          = (p_ddx.*(1+taugx)).^(-sigmax) * Px^(sigmax-1) * Yx;

% NT sector: unit cost per productivity unit (u_nt), CES markup price (p_dd_nt), and quantity (q_dd_nt).
u_nt        = u_tilde_nt ./ psi_g_nt;
p_dd_nt     = sigma/(sigma-1) * u_nt;
q_dd_nt     = p_dd_nt.^(-sigma) * Pd_nt^(sigma-1) * Yd_nt;

% Endogenous fixed-cost of hiring immigrants (fe_j, fe_j_nt); scales with the chosen immigrant share via F_t, F_nt.
[~, ~, ~, F_t, F_nt] = GE(Pd, Pd_nt, Px, Yd_t, Yd_nt, Yx, wd, wd_nt, wimm, wimm_nt, PP);
fe_j        = f_j    * (F_t /wd)    .* (((1-sdom)   ./sdom)   .^(1/(iota*(epsilon-1))));
fe_j_nt     = f_j_nt * (F_nt/wd_nt) .* (((1-sdom_nt)./sdom_nt).^(1/(iota*(epsilon-1))));

% Firm-level demand for native (Ld_alt_j) and immigrant (I_alt_j) labor, in efficiency units.
% T: native efficiency units cover the domestic + export wage bills plus the three fixed costs (immigrant-hiring fe_j, immigrant-base f_imm, exporter f_g).
Ld_alt_j    = (1/wd)      * ( ((sigma-1)/sigma).*rev_dom.*sdom + ((sigmax-1)/sigmax).*rev_exports.*sdom + D_imm.*wd.*fe_j + D_imm.*wd*f_imm + D_exporter.*wd*f_g );
I_alt_j     = (1/wimm)    * ( (1-sdom).*((sigma-1)/sigma).*rev_dom + (1-sdom).*((sigmax-1)/sigmax).*rev_exports );

% NT: native efficiency units cover the domestic wage bill plus the two immigrant fixed costs (fe_j_nt, f_imm_nt).
Ld_alt_nt_j = (1/wd_nt)   * ( ((sigma-1)/sigma).*rev_nt.*sdom_nt + D_imm_nt.*wd_nt.*fe_j_nt + D_imm_nt.*wd_nt*f_imm_nt );
I_alt_nt_j  = (1/wimm_nt) * ( (1-sdom_nt).*((sigma-1)/sigma).*rev_nt );

% Total wage bill per firm (native + immigrant).
Cost_tot_j    = Ld_alt_j   .*wd    + I_alt_j   .*wimm;
Cost_tot_nt_j = Ld_alt_nt_j.*wd_nt + I_alt_nt_j.*wimm_nt;

% Firm-level outcome matrices consumed by the Stata helpers downstream.
GER    = [psi_g,    f_j,    D_exporter, D_imm,    sdom,    u_tilde,    u,    p_dd,    prof,    q_dd, q_dx,    rev,    fe_j,    rev_exports, ...
          Ld_alt_j,    I_alt_j,    Cost_tot_j,    I_alt_j   ./Ld_alt_j,    (wimm   *I_alt_j)   ./(wd   *Ld_alt_j)];

GER_nt = [psi_g_nt, f_j_nt,             D_imm_nt, sdom_nt, u_tilde_nt, u_nt, p_dd_nt, prof_nt, q_dd_nt,       rev_nt, fe_j_nt, ...
          Ld_alt_nt_j, I_alt_nt_j, Cost_tot_nt_j, I_alt_nt_j./Ld_alt_nt_j, (wimm_nt*I_alt_nt_j)./(wd_nt*Ld_alt_nt_j)];

 
%% 4.3. RoW
% Foreign firms have no immigrant-share margin: only the export decision.
% Foreign firms are assumed to be homogeneous (See Heterogeneity.m)

%Profit conditional on exporting and conditional on no exporting

rev_nexp_RoW = Px^(sigmax-1)*Yx*(wx./psi_x).^(1-sigmax)*(sigmaxt);
rev_exp_only_RoW  = Pd^(sigma-1)*Yd_t*sigmat*((wx./psi_x)*(1+tauxg)).^(1-sigma);
rev_exp_RoW  = rev_nexp_RoW + rev_exp_only_RoW ;

prof_nexp_RoW = rev_nexp_RoW./sigmax;
prof_exp_RoW  = prof_nexp_RoW + rev_exp_only_RoW./sigma - wx*f_x;

%Export decision and exporter dummy

D_exporter_RoW = prof_exp_RoW > prof_nexp_RoW;

%Profit of each firm

prof_RoW       = D_exporter_RoW.*prof_exp_RoW+(1-D_exporter_RoW).*prof_nexp_RoW;

%Revenue of each firm

rev_RoW=D_exporter_RoW.*rev_exp_RoW+(1-D_exporter_RoW).*rev_nexp_RoW;
rev_exports_RoW=D_exporter_RoW.*(Pd^(sigma-1)*Yd_t*sigmat*((wx./psi_x)*(1+tauxg)).^(1-sigma));
rev_dom_RoW=rev_RoW-rev_exports_RoW;

%Price charged by each firm to the domestic market

p_xx = sigmax/(sigmax-1) * wx./psi_x ;
p_xxd= sigma/(sigma-1) * wx./psi_x ;

% Assemble the RoW firm-level matrix

RoW = [psi_x , D_exporter_RoW , p_xx , prof_RoW, rev_RoW];


%% 5. Equilibrium
% Aggregate sectoral price indices and the 10 market-clearing residuals
% F(1)..F(10) that fsolve drives to zero. main_aggregates packs the
% counterfactual outputs the calling script consumes.

% T sector price-index components (sum of price^(1-sigma) over relevant firms).

P_dx    = D_exporter'     * (p_ddx .* (1+taugx)).^(1-sigmax);   % T-imports in Germany (Germany imports from RoW exporters)
P_xd    = D_exporter_RoW' * (p_xxd * (1+tauxg)).^(1-sigma);       % T-exports in RoW (RoW imports from Germany exporters)
P_dd    = sum(p_dd.^(1-sigma));                                   % T-domestic price index in Germany
P_xx    = sum(p_xx.^(1-sigmax));                                  % RoW-domestic price index in RoW

% T sector trade shares (fraction of sectoral demand met domestically).

lmd_dd  = P_dd / (P_dd + P_xd);
lmd_xx  = P_xx / (P_xx + P_dx);

% NT sector price index (no trade).

P_dd_nt = (sum(p_dd_nt.^(1-sigma)))^(1/(1-sigma));

% Aggregate efficiency-unit demand for native (Ld_alt) and immigrant (I_alt) labor, by sector.

Ld_alt    = (1/wd)      * ( sum(((sigma-1)/sigma).*rev_dom.*sdom) + sum(((sigmax-1)/sigmax).*rev_exports.*sdom) + sum(D_imm.*wd.*fe_j) + sum(D_imm.*wd*f_imm) + sum(D_exporter.*wd*f_g) );
I_alt     = (1/wimm)    * ( sum((1-sdom).*((sigma-1)/sigma).*rev_dom) + sum((1-sdom).*((sigmax-1)/sigmax).*rev_exports) );

Ld_alt_nt = (1/wd_nt)   * ( sum(((sigma-1)/sigma).*rev_nt.*sdom_nt) + sum(D_imm_nt.*wd_nt.*fe_j_nt) + sum(D_imm_nt.*wd_nt*f_imm_nt) );
I_alt_nt  = (1/wimm_nt) * sum((1-sdom_nt).*((sigma-1)/sigma).*rev_nt);

% Trade balance and the 17-element aggregate-outputs vector used by the calling counterfactual scripts.

trade_balance   = sum(rev_exports_RoW) - sum(rev_exports);
main_aggregates = [lmd_dd, lmd_xx, trade_balance, Ld_alt-Ld, Ld_alt, I_alt, Ld_alt_nt, I_alt_nt, Lx, Limm_count, Limm_nt_count, Lx_count, Ld_count, Ld_nt_count, sum(rev_exports), sum(rev), sum(rev_nt)];

% 10 market-clearing residuals (F = 0 in equilibrium); fsolve drives F to 0 to recover the equilibrium x.

F(1)  = Lx      - (1/wx) * ( sum(((sigmax-1)/sigmax).*rev_dom_RoW) + sum(((sigma-1)/sigma).*rev_exports_RoW) + sum(wx*f_x.*D_exporter_RoW) );   % RoW native labor market
F(2)  = Limm    - I_alt;                                       % T immigrant labor market
F(3)  = Pd      - (P_dd + P_xd)^(1/(1-sigma));                 % T price index consistency (Germany)
F(4)  = Px      - (P_xx + P_dx)^(1/(1-sigmax));                % T price index consistency (RoW)
F(5)  = pid     - sum(prof);                                   % T aggregate profit consistency
F(6)  = pix     - sum(prof_RoW);                               % RoW aggregate profit consistency
F(7)  = Pd_nt   - P_dd_nt;                                     % NT price index consistency
F(8)  = Ld_nt   - Ld_alt_nt;                                   % NT native labor market
F(9)  = Limm_nt - I_alt_nt;                                    % NT immigrant labor market
F(10) = pid_nt  - sum(prof_nt);                                % NT aggregate profit consistency

end
end
