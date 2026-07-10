*--------------------------------------------------------------------------
* master.do
*
* Master Stata script: runs all bridging plots that combine MATLAB model
* outputs with empirical data to produce the paper's figures.
*
* Prerequisite: master.m has been run successfully and the intermediate
* MATLAB outputs are in ../output/intermediate/.
*
* Set the global `base` to the absolute path before running.
*--------------------------------------------------------------------------

* The global `base` is set by the top-level master_file.do before this file
* is called. To run this file standalone, uncomment and set the line below:
* global base "ABSOLUTE PATH/model_analysis"

cd "${base}"

* Load shared graph styling

do "code/stata_plots/sj_grstyle.do"

*--------------------------------------------------------------------------
* Figure 3: data vs. model elasticities by firm size decile (Section 5.5)
*--------------------------------------------------------------------------

cd "${base}/output/intermediate/heterogeneous"
do "${base}/code/stata_plots/Validation_cross_CI_heterog.do"

*--------------------------------------------------------------------------
* Figure 4: native reallocation across firms (Section 6.1)
* Also produces Table 2 numerical comparisons
*--------------------------------------------------------------------------

cd "${base}/output/intermediate"
do "${base}/code/stata_plots/Counterfactual_plots_heterog.do"

*--------------------------------------------------------------------------
* Figure D1, Figure D2: alternative policies (Appendix D.2 and D.3)
*--------------------------------------------------------------------------

cd "${base}/output/intermediate/policies"
do "${base}/code/stata_plots/Counterfactual_plots_policies.do"

cd "${base}"

display "Master Stata script complete. Figures in output/figures/"
