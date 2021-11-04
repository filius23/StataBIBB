
* Übung 4-1 --------------------------------------------------------------------
cd D:\oCloud\Home-Cloud\Lehre\Methodenseminar
use "Allbus_1980-2018.dta", clear

keep if year == 2014

labelbook hs18
mvdecode hs18, mv(-32/-1)
su hs18


hist hs18
graph box hs18, by(sex)
histogram hs18, by(sex)
twoway (kdensity hs18), by(sex) 


graph bar (count), over(eastwest)
graph bar (count), over(eastwest) by(sex)


* Übung 4-2 --------------------------------------------------------------------

* Mosaikplot 
cd D:\oCloud\Home-Cloud\Lehre\Methodenseminar
use "Allbus_1980-2018.dta", clear
keep if year == 2016
labelbook mc02
mvdecode mc02, mv(-11/-1)
tab mc02
ssc install spineplot
spineplot educ mc02
spineplot mc02 educ


* alter & politikquiz
cd D:\oCloud\Home-Cloud\Lehre\Methodenseminar
use "Allbus2018.dta", clear

labelbook xt11
mvdecode xt11, mv(-41)
labelbook age
mvdecode age, mv(-32)


* boxplot 
gen xt11_east = xt11 if eastwest == 2
gen xt11_west = xt11 if eastwest == 1

graph box xt11_west xt11_east
graph box xt11_west xt11_east, by(sex)

* scatter
twoway (scatter xt11_east age) (scatter xt11_west age)

// Farben anpassen:
twoway (scatter xt11_east age, mcolor("red%30")) (scatter xt11_west age if xt11 < 8000, mcolor("navy%30"))

* dot plot
graph dot (p25) xt11 ( mean ) xt11 (p75) xt11
graph dot (p25) xt11 ( mean ) xt11 (p75) xt11 if xt11 < 3000, over(educ)



