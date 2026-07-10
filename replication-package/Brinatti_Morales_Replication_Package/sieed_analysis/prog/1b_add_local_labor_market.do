********************************************************************************
* 1b_add_local_labor_market.do
*
* Purpose:
*   Maps German administrative districts (Kreise, identified by the variable
*   ao_kreis) to functional local labor market areas following the commuting-
*   zone delineation of Kropp and Schwengler (2011). The resulting crosswalk
*   is saved as a lookup table and merged into the regression datasets so that
*   local labor market fixed effects can be included in the event study
*   (equation 1) and the model validation regressions (equation 20).
*
*   The mapping is applied at the Kreis level: each Kreis is assigned to the
*   local labor market whose identifier (local_labor) corresponds to its
*   primary commuting hub, following Kropp and Schwengler (2011). The
*   identifier encodes the core district of the labor market area.
*
* Inputs:
*   ${data}/individual_level_sieed.dta           - Individual SIEED panel
*                                                   (created by 1a)
*   ${orig}/SIEED_7518_v1_bhp_basis_v1.dta       - BHP establishment file
*                                                   (provides ao_kreis)
*
* Outputs:
*   ${data}/local_labor_market.dta  - Crosswalk from ao_kreis to local_labor
*                                     (one row per distinct Kreis in the SIEED)
*
* Reference:
*   Kropp, P. and Schwengler, B. (2011). Delineation of Functional Labour
*   Market Regions: A Methodological Approach. Raumforschung und Raumordnung,
*   69(1), 45-62.
********************************************************************************


set seed 1234

cap log close

log using "${log}/1b_add_local_labor_market.log", replace


****************************Analysis on individual hiring countries****************


use "${data}/individual_level_sieed.dta", clear


* Merge in the BHP establishment file to obtain the district identifier
* (ao_kreis) and industry code (w93_3_gen) for each establishment-year.
merge m:1 betnr jahr using "${orig}/SIEED_7518_v1_bhp_basis_v1.dta", keepusing(ao_kreis w93_3_gen)
drop if _m!=3
drop _m


* Retain one row per distinct Kreis present in the SIEED sample.
keep ao_kreis
duplicates drop ao_kreis, force

gen local_labor=.


*-------------------------------------------------------------------------------
* Kreis-to-local-labor-market mapping
*
* Each replace statement assigns the Kreis (ao_kreis) to its parent local
* labor market area (local_labor) following Kropp and Schwengler (2011).
* The local_labor identifier is the Kreis code of the anchor city or district
* of the functional labor market area. All Kreise in Germany that appear in
* the SIEED are covered; the final sum command verifies that no Kreis is left
* unassigned (local_labor==.).
*-------------------------------------------------------------------------------

replace local_labor=1001000 if ao_kreis==1001
replace local_labor=1002000 if ao_kreis==1002
replace local_labor=1003000 if ao_kreis==1003
replace local_labor=1002000 if ao_kreis==1004
replace local_labor=2000000 if ao_kreis==1051
replace local_labor=2000000 if ao_kreis==1053
replace local_labor=1001000 if ao_kreis==1054
replace local_labor=1003000 if ao_kreis==1055
replace local_labor=2000000 if ao_kreis==1056
replace local_labor=1002000 if ao_kreis==1057
replace local_labor=1002000 if ao_kreis==1058
replace local_labor=1001000 if ao_kreis==1059
replace local_labor=2000000 if ao_kreis==1060
replace local_labor=2000000 if ao_kreis==1061
replace local_labor=2000000 if ao_kreis==1062
replace local_labor=2000000 if ao_kreis==2000
replace local_labor=3101000 if ao_kreis==3101
replace local_labor=3101000 if ao_kreis==3102
replace local_labor=3103000 if ao_kreis==3103
replace local_labor=3103000 if ao_kreis==3151
replace local_labor=3152012 if ao_kreis==3152
replace local_labor=3101000 if ao_kreis==3153
replace local_labor=3103000 if ao_kreis==3154
replace local_labor=3152012 if ao_kreis==3155
replace local_labor=3152012 if ao_kreis==3156
replace local_labor=3101000 if ao_kreis==3157
replace local_labor=3101000 if ao_kreis==3158
replace local_labor=3241001 if ao_kreis==3241
replace local_labor=4011000 if ao_kreis==3251
replace local_labor=3241001 if ao_kreis==3252
replace local_labor=3254021 if ao_kreis==3254
replace local_labor=5774032 if ao_kreis==3255
replace local_labor=3241001 if ao_kreis==3256
replace local_labor=3241001 if ao_kreis==3257
replace local_labor=3241001 if ao_kreis==3351
replace local_labor=4012000 if ao_kreis==3352
replace local_labor=2000000 if ao_kreis==3353
replace local_labor=2000000 if ao_kreis==3354
replace local_labor=2000000 if ao_kreis==3355
replace local_labor=4011000 if ao_kreis==3356
replace local_labor=4011000 if ao_kreis==3357
replace local_labor=3241001 if ao_kreis==3358
replace local_labor=2000000 if ao_kreis==3359
replace local_labor=2000000 if ao_kreis==3360
replace local_labor=4011000 if ao_kreis==3361
replace local_labor=4011000 if ao_kreis==3401
replace local_labor=3402000 if ao_kreis==3402
replace local_labor=3403000 if ao_kreis==3403
replace local_labor=3404000 if ao_kreis==3404
replace local_labor=3403000 if ao_kreis==3405
replace local_labor=3403000 if ao_kreis==3451
replace local_labor=3402000 if ao_kreis==3452
replace local_labor=3403000 if ao_kreis==3453
replace local_labor=3454041 if ao_kreis==3454
replace local_labor=3403000 if ao_kreis==3455
replace local_labor=5515000 if ao_kreis==3456
replace local_labor=3402000 if ao_kreis==3457
replace local_labor=4011000 if ao_kreis==3458
replace local_labor=3404000 if ao_kreis==3459
replace local_labor=3460006 if ao_kreis==3460
replace local_labor=3403000 if ao_kreis==3461
replace local_labor=3402000 if ao_kreis==3462
replace local_labor=4011000 if ao_kreis==4011
replace local_labor=4012000 if ao_kreis==4012
replace local_labor=5111000 if ao_kreis==5111
replace local_labor=5113000 if ao_kreis==5112
replace local_labor=5113000 if ao_kreis==5113
replace local_labor=5111000 if ao_kreis==5114
replace local_labor=5116000 if ao_kreis==5116
replace local_labor=5113000 if ao_kreis==5117
replace local_labor=5113000 if ao_kreis==5119
replace local_labor=5111000 if ao_kreis==5120
replace local_labor=5111000 if ao_kreis==5122
replace local_labor=5111000 if ao_kreis==5124
replace local_labor=5154036 if ao_kreis==5154
replace local_labor=5111000 if ao_kreis==5158
replace local_labor=5111000 if ao_kreis==5162
replace local_labor=5111000 if ao_kreis==5166
replace local_labor=5113000 if ao_kreis==5170
replace local_labor=5315000 if ao_kreis==5314
replace local_labor=5315000 if ao_kreis==5315
replace local_labor=5315000 if ao_kreis==5316
replace local_labor=5334002 if ao_kreis==5334
replace local_labor=5358008 if ao_kreis==5358
replace local_labor=5315000 if ao_kreis==5362
replace local_labor=5315000 if ao_kreis==5366
replace local_labor=5116000 if ao_kreis==5370
replace local_labor=5374012 if ao_kreis==5374
replace local_labor=5315000 if ao_kreis==5378
replace local_labor=5315000 if ao_kreis==5382
replace local_labor=5113000 if ao_kreis==5512
replace local_labor=5113000 if ao_kreis==5513
replace local_labor=5515000 if ao_kreis==5515
replace local_labor=5554020 if ao_kreis==5554
replace local_labor=5515000 if ao_kreis==5558
replace local_labor=5113000 if ao_kreis==5562
replace local_labor=5515000 if ao_kreis==5566
replace local_labor=5515000 if ao_kreis==5570
replace local_labor=5711000 if ao_kreis==5711
replace local_labor=5711000 if ao_kreis==5754
replace local_labor=5758004 if ao_kreis==5758
replace local_labor=5774032 if ao_kreis==5762
replace local_labor=5766020 if ao_kreis==5766
replace local_labor=5770024 if ao_kreis==5770
replace local_labor=5774032 if ao_kreis==5774
replace local_labor=5113000 if ao_kreis==5911
replace local_labor=5113000 if ao_kreis==5913
replace local_labor=5113000 if ao_kreis==5914
replace local_labor=5113000 if ao_kreis==5915
replace local_labor=5113000 if ao_kreis==5916
replace local_labor=5113000 if ao_kreis==5954
replace local_labor=5958004 if ao_kreis==5958
replace local_labor=5962032 if ao_kreis==5962
replace local_labor=5970040 if ao_kreis==5966
replace local_labor=5970040 if ao_kreis==5970
replace local_labor=5958004 if ao_kreis==5974
replace local_labor=5113000 if ao_kreis==5978
replace local_labor=6411000 if ao_kreis==6411
replace local_labor=6412000 if ao_kreis==6412
replace local_labor=6412000 if ao_kreis==6413
replace local_labor=6414000 if ao_kreis==6414
replace local_labor=8222000 if ao_kreis==6431
replace local_labor=6411000 if ao_kreis==6432
replace local_labor=6412000 if ao_kreis==6433
replace local_labor=6412000 if ao_kreis==6434
replace local_labor=6412000 if ao_kreis==6435
replace local_labor=6412000 if ao_kreis==6436
replace local_labor=6411000 if ao_kreis==6437
replace local_labor=6412000 if ao_kreis==6438
replace local_labor=6414000 if ao_kreis==6439
replace local_labor=6412000 if ao_kreis==6440
replace local_labor=6531005 if ao_kreis==6531
replace local_labor=6531005 if ao_kreis==6532
replace local_labor=6412000 if ao_kreis==6533
replace local_labor=6534014 if ao_kreis==6534
replace local_labor=6412000 if ao_kreis==6535
replace local_labor=6611000 if ao_kreis==6611
replace local_labor=6631009 if ao_kreis==6631
replace local_labor=6611000 if ao_kreis==6632
replace local_labor=6611000 if ao_kreis==6633
replace local_labor=6611000 if ao_kreis==6634
replace local_labor=6611000 if ao_kreis==6635
replace local_labor=6611000 if ao_kreis==6636
replace local_labor=7111000 if ao_kreis==7111
replace local_labor=5315000 if ao_kreis==7131
replace local_labor=5970040 if ao_kreis==7132
replace local_labor=6414000 if ao_kreis==7133
replace local_labor=6414000 if ao_kreis==7134
replace local_labor=7111000 if ao_kreis==7135
replace local_labor=7111000 if ao_kreis==7137
replace local_labor=7111000 if ao_kreis==7138
replace local_labor=7111000 if ao_kreis==7140
replace local_labor=6412000 if ao_kreis==7141
replace local_labor=7111000 if ao_kreis==7143
replace local_labor=7211000 if ao_kreis==7211
replace local_labor=7211000 if ao_kreis==7231
replace local_labor=7211000 if ao_kreis==7232
replace local_labor=7211000 if ao_kreis==7233
replace local_labor=7211000 if ao_kreis==7235
replace local_labor=8222000 if ao_kreis==7311
replace local_labor=7312000 if ao_kreis==7312
replace local_labor=7316000 if ao_kreis==7313
replace local_labor=8222000 if ao_kreis==7314
replace local_labor=6414000 if ao_kreis==7315
replace local_labor=7316000 if ao_kreis==7316
replace local_labor=10045114 if ao_kreis==7317
replace local_labor=8222000 if ao_kreis==7318
replace local_labor=8222000 if ao_kreis==7319
replace local_labor=10045114 if ao_kreis==7320
replace local_labor=6414000 if ao_kreis==7331
replace local_labor=8222000 if ao_kreis==7332
replace local_labor=8222000 if ao_kreis==7333
replace local_labor=7316000 if ao_kreis==7334
replace local_labor=7312000 if ao_kreis==7335
replace local_labor=7312000 if ao_kreis==7336
replace local_labor=7316000 if ao_kreis==7337
replace local_labor=8222000 if ao_kreis==7338
replace local_labor=6414000 if ao_kreis==7339
replace local_labor=10045114 if ao_kreis==7340
replace local_labor=8111000 if ao_kreis==8111
replace local_labor=8111000 if ao_kreis==8115
replace local_labor=8111000 if ao_kreis==8116
replace local_labor=8117026 if ao_kreis==8117
replace local_labor=8111000 if ao_kreis==8118
replace local_labor=8111000 if ao_kreis==8119
replace local_labor=8121000 if ao_kreis==8121
replace local_labor=8121000 if ao_kreis==8125
replace local_labor=8121000 if ao_kreis==8126
replace local_labor=8127076 if ao_kreis==8127
replace local_labor=8127076 if ao_kreis==8128
replace local_labor=8136088 if ao_kreis==8135
replace local_labor=8136088 if ao_kreis==8136
replace local_labor=8212000 if ao_kreis==8211
replace local_labor=8212000 if ao_kreis==8212
replace local_labor=8212000 if ao_kreis==8215
replace local_labor=8212000 if ao_kreis==8216
replace local_labor=8222000 if ao_kreis==8221
replace local_labor=8222000 if ao_kreis==8222
replace local_labor=8121000 if ao_kreis==8225
replace local_labor=8222000 if ao_kreis==8226
replace local_labor=8231000 if ao_kreis==8231
replace local_labor=8111000 if ao_kreis==8235
replace local_labor=8231000 if ao_kreis==8236
replace local_labor=8111000 if ao_kreis==8237
replace local_labor=8311000 if ao_kreis==8311
replace local_labor=8311000 if ao_kreis==8315
replace local_labor=8311000 if ao_kreis==8316
replace local_labor=8317096 if ao_kreis==8317
replace local_labor=8326074 if ao_kreis==8325
replace local_labor=8326074 if ao_kreis==8326
replace local_labor=8326074 if ao_kreis==8327
replace local_labor=8335075 if ao_kreis==8335
replace local_labor=8336050 if ao_kreis==8336
replace local_labor=8336050 if ao_kreis==8337
replace local_labor=8415061 if ao_kreis==8415
replace local_labor=8111000 if ao_kreis==8416
replace local_labor=8417079 if ao_kreis==8417
replace local_labor=8421000 if ao_kreis==8421
replace local_labor=8421000 if ao_kreis==8425
replace local_labor=8421000 if ao_kreis==8426
replace local_labor=8435016 if ao_kreis==8435
replace local_labor=8436064 if ao_kreis==8436
replace local_labor=8421000 if ao_kreis==8437
replace local_labor=9161000 if ao_kreis==9161
replace local_labor=9162000 if ao_kreis==9162
replace local_labor=9162000 if ao_kreis==9163
replace local_labor=9171112 if ao_kreis==9171
replace local_labor=9189155 if ao_kreis==9172
replace local_labor=9162000 if ao_kreis==9173
replace local_labor=9162000 if ao_kreis==9174
replace local_labor=9162000 if ao_kreis==9175
replace local_labor=9161000 if ao_kreis==9176
replace local_labor=9162000 if ao_kreis==9177
replace local_labor=9162000 if ao_kreis==9178
replace local_labor=9162000 if ao_kreis==9179
replace local_labor=9162000 if ao_kreis==9180
replace local_labor=9162000 if ao_kreis==9181
replace local_labor=9162000 if ao_kreis==9182
replace local_labor=9162000 if ao_kreis==9183
replace local_labor=9162000 if ao_kreis==9184
replace local_labor=9161000 if ao_kreis==9185
replace local_labor=9161000 if ao_kreis==9186
replace local_labor=9162000 if ao_kreis==9187
replace local_labor=9162000 if ao_kreis==9188
replace local_labor=9189155 if ao_kreis==9189
replace local_labor=9162000 if ao_kreis==9190
replace local_labor=9261000 if ao_kreis==9261
replace local_labor=9262000 if ao_kreis==9262
replace local_labor=9362000 if ao_kreis==9263
replace local_labor=9271119 if ao_kreis==9271
replace local_labor=9262000 if ao_kreis==9272
replace local_labor=9161000 if ao_kreis==9273
replace local_labor=9261000 if ao_kreis==9274
replace local_labor=9262000 if ao_kreis==9275
replace local_labor=9271119 if ao_kreis==9276
replace local_labor=9171112 if ao_kreis==9277
replace local_labor=9362000 if ao_kreis==9278
replace local_labor=9261000 if ao_kreis==9279
replace local_labor=9564000 if ao_kreis==9361
replace local_labor=9362000 if ao_kreis==9362
replace local_labor=9363000 if ao_kreis==9363
replace local_labor=9564000 if ao_kreis==9371
replace local_labor=9362000 if ao_kreis==9372
replace local_labor=9564000 if ao_kreis==9373
replace local_labor=9363000 if ao_kreis==9374
replace local_labor=9362000 if ao_kreis==9375
replace local_labor=9362000 if ao_kreis==9376
replace local_labor=9479136 if ao_kreis==9377
replace local_labor=9461000 if ao_kreis==9461
replace local_labor=9462000 if ao_kreis==9462
replace local_labor=9463000 if ao_kreis==9463
replace local_labor=9464000 if ao_kreis==9464
replace local_labor=9461000 if ao_kreis==9471
replace local_labor=9462000 if ao_kreis==9472
replace local_labor=9463000 if ao_kreis==9473
replace local_labor=9564000 if ao_kreis==9474
replace local_labor=9464000 if ao_kreis==9475
replace local_labor=9463000 if ao_kreis==9476
replace local_labor=9462000 if ao_kreis==9477
replace local_labor=9463000 if ao_kreis==9478
replace local_labor=9479136 if ao_kreis==9479
replace local_labor=9564000 if ao_kreis==9561
replace local_labor=9564000 if ao_kreis==9562
replace local_labor=9564000 if ao_kreis==9563
replace local_labor=9564000 if ao_kreis==9564
replace local_labor=9564000 if ao_kreis==9565
replace local_labor=9564000 if ao_kreis==9571
replace local_labor=9564000 if ao_kreis==9572
replace local_labor=9564000 if ao_kreis==9573
replace local_labor=9564000 if ao_kreis==9574
replace local_labor=9564000 if ao_kreis==9575
replace local_labor=9564000 if ao_kreis==9576
replace local_labor=9564000 if ao_kreis==9577
replace local_labor=9661000 if ao_kreis==9661
replace local_labor=9662000 if ao_kreis==9662
replace local_labor=9663000 if ao_kreis==9663
replace local_labor=9661000 if ao_kreis==9671
replace local_labor=9662000 if ao_kreis==9672
replace local_labor=9662000 if ao_kreis==9673
replace local_labor=9662000 if ao_kreis==9674
replace local_labor=9663000 if ao_kreis==9675
replace local_labor=9661000 if ao_kreis==9676
replace local_labor=9663000 if ao_kreis==9677
replace local_labor=9662000 if ao_kreis==9678
replace local_labor=9663000 if ao_kreis==9679
replace local_labor=9761000 if ao_kreis==9761
replace local_labor=9162000 if ao_kreis==9762
replace local_labor=9763000 if ao_kreis==9763
replace local_labor=9764000 if ao_kreis==9764
replace local_labor=9761000 if ao_kreis==9771
replace local_labor=9761000 if ao_kreis==9772
replace local_labor=9761000 if ao_kreis==9773
replace local_labor=9761000 if ao_kreis==9774
replace local_labor=8421000 if ao_kreis==9775
replace local_labor=8436064 if ao_kreis==9776
replace local_labor=9162000 if ao_kreis==9777
replace local_labor=9764000 if ao_kreis==9778
replace local_labor=9761000 if ao_kreis==9779
replace local_labor=9763000 if ao_kreis==9780
replace local_labor=10041100 if ao_kreis==10041
replace local_labor=10041100 if ao_kreis==10042
replace local_labor=10041100 if ao_kreis==10043
replace local_labor=10041100 if ao_kreis==10044
replace local_labor=10045114 if ao_kreis==10045
replace local_labor=10041100 if ao_kreis==10046
replace local_labor=11000000 if ao_kreis==11000
replace local_labor=11000000 if ao_kreis==12051
replace local_labor=12052000 if ao_kreis==12052
replace local_labor=11000000 if ao_kreis==12053
replace local_labor=11000000 if ao_kreis==12054
replace local_labor=11000000 if ao_kreis==12060
replace local_labor=11000000 if ao_kreis==12061
replace local_labor=12052000 if ao_kreis==12062
replace local_labor=11000000 if ao_kreis==12063
replace local_labor=11000000 if ao_kreis==12064
replace local_labor=11000000 if ao_kreis==12065
replace local_labor=12052000 if ao_kreis==12066
replace local_labor=11000000 if ao_kreis==12067
replace local_labor=11000000 if ao_kreis==12068
replace local_labor=11000000 if ao_kreis==12069
replace local_labor=11000000 if ao_kreis==12070
replace local_labor=12052000 if ao_kreis==12071
replace local_labor=11000000 if ao_kreis==12072
replace local_labor=11000000 if ao_kreis==12073
replace local_labor=13003000 if ao_kreis==13003
replace local_labor=13004000 if ao_kreis==13004
replace local_labor=13071107 if ao_kreis==13071
replace local_labor=13003000 if ao_kreis==13072
replace local_labor=13075039 if ao_kreis==13073
replace local_labor=13004000 if ao_kreis==13074
replace local_labor=13075039 if ao_kreis==13075
replace local_labor=13004000 if ao_kreis==13076
replace local_labor=14511000 if ao_kreis==14511
replace local_labor=14511000 if ao_kreis==14521
replace local_labor=14511000 if ao_kreis==14522
replace local_labor=14523320 if ao_kreis==14523
replace local_labor=14524330 if ao_kreis==14524
replace local_labor=14612000 if ao_kreis==14612
replace local_labor=14612000 if ao_kreis==14625
replace local_labor=14612000 if ao_kreis==14626
replace local_labor=14612000 if ao_kreis==14627
replace local_labor=14612000 if ao_kreis==14628
replace local_labor=14713000 if ao_kreis==14713
replace local_labor=14713000 if ao_kreis==14729
replace local_labor=14713000 if ao_kreis==14730
replace local_labor=15001000 if ao_kreis==15001
replace local_labor=15002000 if ao_kreis==15002
replace local_labor=15003000 if ao_kreis==15003
replace local_labor=15003000 if ao_kreis==15081
replace local_labor=15001000 if ao_kreis==15082
replace local_labor=15003000 if ao_kreis==15083
replace local_labor=15002000 if ao_kreis==15084
replace local_labor=15085370 if ao_kreis==15085
replace local_labor=15003000 if ao_kreis==15086
replace local_labor=15002000 if ao_kreis==15087
replace local_labor=15002000 if ao_kreis==15088
replace local_labor=15003000 if ao_kreis==15089
replace local_labor=15003000 if ao_kreis==15090
replace local_labor=15001000 if ao_kreis==15091
replace local_labor=16051000 if ao_kreis==16051
replace local_labor=16052000 if ao_kreis==16052
replace local_labor=16053000 if ao_kreis==16053
replace local_labor=16054000 if ao_kreis==16054
replace local_labor=16051000 if ao_kreis==16055
replace local_labor=16051000 if ao_kreis==16056
replace local_labor=3152012 if ao_kreis==16061
replace local_labor=3152012 if ao_kreis==16062
replace local_labor=16051000 if ao_kreis==16063
replace local_labor=16051000 if ao_kreis==16064
replace local_labor=16051000 if ao_kreis==16065
replace local_labor=16054000 if ao_kreis==16066
replace local_labor=16051000 if ao_kreis==16067
replace local_labor=16051000 if ao_kreis==16068
replace local_labor=16054000 if ao_kreis==16069
replace local_labor=16051000 if ao_kreis==16070
replace local_labor=16051000 if ao_kreis==16071
replace local_labor=9463000 if ao_kreis==16072
replace local_labor=16051000 if ao_kreis==16073
replace local_labor=16053000 if ao_kreis==16074
replace local_labor=16051000 if ao_kreis==16075
replace local_labor=16052000 if ao_kreis==16076
replace local_labor=14713000 if ao_kreis==16077

* Verify that every Kreis in the SIEED sample has been assigned to a local
* labor market. The observation count below should be zero.
sum if local_labor==.


save "${data}/local_labor_market.dta", replace

log close
