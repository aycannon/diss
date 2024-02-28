clear *
cd "/Users/acannon/Dropbox"
* ssc install estout
import excel "diss_data/gt_diff.xlsx",firstrow 


gen t = _n
tsset t

gl vars "Benefits Indeed Linkedin SkyScanner Emirates Holiday Film DIY Gifts Clothes Jobs Merc Toyota Resort RyanAir Museums McD Gucci LV Zara fm"

gl months "jan feb mar apr may jun jul aug sep oct nov dec"

gen jan = (mod(t - 1, 12) == 0)
gen feb = (mod(t - 2, 12) == 0)
gen mar = (mod(t - 3, 12) == 0)
gen apr = (mod(t - 4, 12) == 0)
gen may = (mod(t - 5, 12) == 0)
gen jun = (mod(t - 6, 12) == 0)
gen jul = (mod(t - 7, 12) == 0)
gen aug = (mod(t - 8, 12) == 0)
gen sep = (mod(t - 9, 12) == 0)
gen oct = (mod(t - 10, 12) == 0)
gen nov = (mod(t - 11, 12) == 0)
gen dec = (mod(t, 12) == 0)

foreach v in $vars {
    reg `v' t $months
    predict resid_`v', resid
}

loc residuals "resid_Benefits resid_Indeed resid_Linkedin resid_SkyScanner resid_Emirates resid_Holiday resid_Film resid_DIY resid_Gifts resid_Clothes resid_Jobs resid_Merc resid_Toyota resid_Resort resid_RyanAir resid_Museums resid_McD resid_Gucci resid_LV resid_Zara resid_fm"

foreach vars of local residuals {
    qui summarize `vars'
    local mean_`vars' = r(mean)
    local sd_`vars' = r(sd)
    
    gen std_`vars' = (`vars' - `mean_`vars'') / `sd_`vars''
}

* drop resid*


tsline std_resid_LV

pca std*

export excel "diss_data/std_gt.xlsx", replace firstrow(variables)

/* PC1 rotations non trended:
0.1417, 0.2640, 0.2119, 0.2852, 0.2340, 0.2362, -0.1103, 0.0195, -0.3094, -0.1433, 0.2992, 0.1512, 0.2555,  0.2879, 0.2679 , 0.1161, -0.0032, -0.2649, -0.2493, -0.2505, 0.0609 

PC1 rotations for de-trended and de-seasoned and standardised data
-0.0268,0.4361,0.2970,0.4448,0.1754,0.0226,-0.0843,-0.1768,-0.3240,0.0958,0.2119,0.1849,0.1853,0.2209,0.0963,0.1309,0.0688,-0.2044,-0.2247,-0.1791,0.1469
*/


