* for filling in the gaps in the 7 month yield
clear *
cd "/Users/acannon/Dropbox/"
* ssc install estout
import excel "diss_data/more indicators.xlsx",firstrow sh("Sheet2")
drop M N O P Q R S T U V W X Y Z AA AB AC AD AE AF

encode period, gen(period1)
destring m7, gen(month)
ipolate month period1, gen(month2)
* replace month = . in 241

* drop month2

encode new_cars, g(car)
encode land_sales_volume, g(land)

recast float car
recast float land

g t = _n
tsset t
tsline car

g month_var = mod(_n-1,12) + 1
label define month_lab 1 "jan" 2 "feb" 3 "mar" 4 "apr" 5 "may" 6 "jun" 7 "jul" 8 "aug" 9 "sep" 10 "oct" 11 "nov" 12 "dec"
label values month_var month_lab
* drop month_var
* drop date_m

* g t2 = t*t 
* g t3 = t2 * t

reg car i.month_var i.year
predict resid_car, resid
* drop resid_car
tsline resid_car

tsline land
reg land i.month_var i.year
predict resid_land, resid
tsline resid_land

* drop resid_land


foreach vars in resid_land resid_car {
    qui summarize `vars'
    local mean_`vars' = r(mean)
    local sd_`vars' = r(sd)
    
    gen std_`vars' = (`vars' - `mean_`vars'') / `sd_`vars''
}


tsline std_resid_land std_resid_car

export excel "diss_data/more.xlsx", replace firstrow(variables)
