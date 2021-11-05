* -------------------------- *
* Zusammenhänge vergleichen
* -------------------------- *

* metrische Merkmale ----------------------------------------------------
cd D:\oCloud\Home-Cloud\Lehre\Methodenseminar
use  Allbus_1980-2018.dta   , clear
keep if year == 2012
mvdecode age hs18, mv(-32 -13)

d age hs18 // Variablen ansehen

corr age hs18 if sex == 1
corr age hs18 if sex == 2

reg hs18 age if sex == 1
reg hs18 age if sex == 2

* Grafisch darstellen:
graph twoway (scatter hs18 age) (lfit hs18 age)

graph twoway (scatter hs18 age) (lfit hs18 age), by(sex)

graph twoway ///
	(scatter hs18 age, color("224 182 168") msize(vsmall) msymbol(d)) ///
	(lfit hs18 age, lcolor("41 48 78") lpattern(solid) ), ///
	by(sex,title("Alter & Body Mass Index") note("")) ///
	scheme(plotplain) ///
	ytitle("Body Mass Index (hs18)") xtitle("Alter (age)") ///
	legend(lab(1 "Body Mass Index") lab(2 "Lineare Regressionsgerade"))

	// oder zwei Linien & Punkte in einer Grafik:
graph twoway ///
	(scatter hs18 age if sex == 1,  msize(vsmall) msymbol(d)) ///
	(scatter hs18 age if sex == 2, msize(vsmall) msymbol(d)) ///
	(lfit hs18 age if sex == 1,  lpattern(solid) ) /// 
	(lfit hs18 age if sex == 2,  lpattern(solid) ) 

graph twoway ///
	(scatter hs18 age if sex == 1, color("42 37 92 %20") msize(vsmall) msymbol(d)) ///
	(scatter hs18 age if sex == 2, color("92 83 28 %20") msize(vsmall) msymbol(d)) ///
	(lfit hs18 age if sex == 1, lcolor("42 37 92") lpattern(solid) ) /// 
	(lfit hs18 age if sex == 2, lcolor("92 83 28") lpattern(solid) ) ///
	, scheme(plotplain) ///
	ytitle("Body Mass Index (hs18)") xtitle("Alter (age)") ///
	legend(lab(1 "Body Mass Index Männer") lab(2 "Lineare Regressionsgerade Männer") ///
		   lab(3 "Body Mass Index Frauen") lab(4 "Lineare Regressionsgerade Frauen"))



* ordinale Merkmale ----------------------------------------------------
cd D:\oCloud\Home-Cloud\Lehre\Methodenseminar
use  Allbus_1980-2018.dta   , clear
keep if year == 1990
mvdecode educ, mv(-9 6 7)
mvdecode mi02, mv(-9 -8 -7)

d educ mi02 // Variablen ansehens

spearman educ mi02 if sex== 1
spearman educ mi02 if sex== 2

ktau educ mi02 if sex == 1
ktau educ mi02 if sex == 2

tab educ mi02 if sex == 1, gamma nofreq
tab educ mi02 if sex == 2, gamma nofreq


* Mosaikplot
spineplot educ mi02 if sex == 1, name("mos_men", replace) ///
  legend(pos(6) size(vsmall) rows(2)) ///
  xlabel(,labsize(small) axis(2) ) ///
  title("Männer")

spineplot educ mi02 if sex == 2, name("mos_women", replace) ///
	legend(pos(6) size(vsmall) rows(2)) ///
	xlabel(,labsize(small) axis(2) ) ///
	title("Frauen")

graph combine mos_men mos_women, rows(1) iscale(*.95) xsize(4) ysize(2) 



* Nominale Merkmale ----------------------------------------------------
cd D:\oCloud\Home-Cloud\Lehre\Methodenseminar
use  Allbus_1980-2018.dta   , clear
keep if year == 2014 & dh04 > 0 & aq03 > 0
gen aq03b = (aq03 == 4) // Dummy: Haustier ja (0) oder nein (1)
tab aq03 aq03b


tab aq03b dh04 if sex == 1, chi
dis sqrt(76.7064/1748)
tab aq03 dh04 if sex == 2, chi
dis sqrt( 70.0439/1698*3 )



* -------------------------- *
* Scatterplot für kategoriale Variablen: Jitter
* -------------------------- *
cd D:\oCloud\Home-Cloud\Lehre\Methodenseminar
use  Allbus_1980-2018.dta   , clear
keep if year == 1990
mvdecode educ, mv(-9 6 7)
mvdecode mi02, mv(-9 -8 -7)

twoway scatter mi02 educ, by(sex) 

twoway scatter mi02 educ, by(sex) jitter(10) msize(vsmall) mcolor(eggshell) mlcolor(black) mlwidth(vthin) 


