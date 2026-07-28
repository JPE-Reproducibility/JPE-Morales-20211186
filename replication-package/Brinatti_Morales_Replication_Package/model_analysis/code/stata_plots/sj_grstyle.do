* sj_grstyle.do — graph styling for paper figures
*
* This file sets persistent grstyle options used by the bridging plot
* scripts. Originally copied from the Stata Journal documentation example;
* the SJ-specific `sjlog`, demo `sysuse auto`, and `graph export grstyle*.pdf`
* lines have been removed because they require the `sjlog` package and
* produce SJ documentation artifacts, not paper figures.
*
* Requires the `grstyle` package: ssc install grstyle

clear all
grstyle clear

set scheme sj
grstyle init
grstyle color background white
grstyle anglestyle vertical_tick horizontal
grstyle yesno draw_major_hgrid yes
grstyle yesno grid_draw_min yes
grstyle yesno grid_draw_max yes
grstyle color major_grid gs8
grstyle linewidth major_grid thin
grstyle linepattern major_grid dot
grstyle clockdir legend_position 4
grstyle numstyle legend_cols 1
grstyle linestyle legend none
grstyle linewidth plineplot medthick
grstyle color p1markline gs6%0
grstyle color p1markfill gs6%50
grstyle color p2markline gs10%0
grstyle color p2markfill gs10%50
grstyle color ci_area gs12%50
grstyle color ci_arealine gs12%0
grstyle color p1 black
grstyle color p2 black
grstyle linepattern p1 solid
grstyle linepattern p2 dash
