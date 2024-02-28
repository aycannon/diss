clear *
cd "/Users/acannon/Dropbox"
* ssc install estout
import excel "diss_data/Google Trends Data.xlsx",firstrow 


gen t = _n
tsset t


gl vars "Benefits Indeed Linkedin SkyScanner Emirates Holiday Film DIY Gifts Clothes Jobs Merc Toyota Resort RyanAir Museums McD Gucci LV Zara fm"

local va Benefits Indeed Linkedin SkyScanner Emirates Holiday Film DIY Gifts Clothes Jobs Merc Toyota Resort RyanAir Museums McD Gucci LV Zara fm

foreach v in $va {
	gen D_`v' = `v'.D
}

foreach vars in $vars {
    qui summarize `vars'
    local mean_`vars' = r(mean)
    local sd_`vars' = r(sd)
    
    gen std_`vars' = (`vars' - `mean_`vars'') / `sd_`vars''
}


asdoc pca std*

export excel "diss_data/Google trends Data.xlsx", replace firstrow(variables)

/*
-0.2751, 0.3088, 0.2419, 0.2419, -0.0303, -0.2056, 0.0179, -0.1335, 0.2195, 0.0238, -0.0034, 0.1473, -0.0730, -0.0987, -0.2715, -0.1405, 0.2998, 0.2868 ,0.3217 ,0.3189, 0.3006

   -0.275
    0.309
    0.242
    0.250
   -0.030
   -0.206
    0.018
   -0.134
    0.220
    0.024
   -0.003
    0.147
   -0.073
   -0.099
   -0.272
   -0.141
    0.300
    0.287
    0.322
    0.319
    0.301
