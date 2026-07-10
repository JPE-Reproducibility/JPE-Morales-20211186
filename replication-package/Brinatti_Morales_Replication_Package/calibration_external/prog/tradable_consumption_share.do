/*
Tradeable Consumption Share from WIOD 2012
------------------------------------------
Computes the share of German household final consumption expenditure
originating from tradeable sectors. Result: 0.68.

Input:  WIOT2012_October16_ROW.dta
Output: scalar alpha_tradeable displayed in results window

Tradeable sectors (by WIOD RNr):
  RNr  5-22  : Manufacturing
  RNr 28-30  : Wholesale and retail trade (distributes tradeable goods)
  RNr 37-49  : ICT, finance, professional and technical services
*/

use "C:\Users\E1NXM04\Dropbox\Multinationals and high skill immigration\Data\WIOT2012_October16_ROW.dta", clear

* Keep Germany supply rows only
keep if Country == "DEU"

* Keep household final consumption column and identifiers
keep IndustryCode IndustryDescription RNr vDEU57

* Rename for clarity
rename vDEU57 hh_cons

* Destring if needed (WIOD sometimes stores as string)
destring hh_cons, replace force

* Define tradeable sectors
gen tradeable = ( (RNr >= 5  & RNr <= 22) |   /// Manufacturing
                  (RNr >= 28 & RNr <= 30) |   /// Wholesale & retail trade
                  (RNr >= 37 & RNr <= 49) )   /// ICT, finance, professional services

* Collapse to tradeable / non-tradeable totals
collapse (sum) hh_cons, by(tradeable)

* Compute share
quietly summarize hh_cons
local total = r(sum)

quietly summarize hh_cons if tradeable == 1
local tradeable = r(mean)   // only one row, so mean == value

scalar alpha_tradeable = `tradeable' / `total'

di ""
di "========================================"
di "Share of tradeable household consumption"
di "========================================"
di "  Tradeable HH cons : " %15.0fc `tradeable'
di "  Total HH cons     : " %15.0fc `total'
di "  Share (alpha)     : " %6.2f  scalar(alpha_tradeable)
di "========================================"
