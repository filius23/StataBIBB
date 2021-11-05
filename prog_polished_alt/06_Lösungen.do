* Zusammenhänge vergleichen & visualisieren


* Übung 1 ---------------------------------------------------------------------
cd D:\oCloud\Home-Cloud\Lehre\Methodenseminar
use  "Allbus2018.dta",clear

keep if lm02 >0 & age > 0
corr lm02 age 
corr lm02 age if sex == 1
corr lm02 age if sex == 2
// insgesamt mittlerer Zusammenhang, bei Frauen (.31) deutlich stärker als bei Männern (.24)

reg lm02 age // insgesamt:  zusätzliches Altersjahr geht mit 1.452889 Minuten mehr Fernsehkonsum einher
reg lm02 age if sex == 1 // Männer: zusätzliches Altersjahr geht mit 1.316567 Minuten mehr Fernsehkonsum einher   
reg lm02 age if sex == 2 // Frauen: zusätzliches Altersjahr geht mit 1.601411 Minuten mehr Fernsehkonsum einher

// vorhergesagte Werte für Männer:
dis 70.59281 +  1.316567 * 30
dis 70.59281 +  1.316567 * 31
// für Frauen:
dis 62.39855 + 1.601411 * 30
dis 62.39855 + 1.601411 * 31

// unterscheiden sich jeweils genau um die Höhe des Koeffizienten

*zB bei Frauen: 
dis 112.04229 -  110.44088



* Grafisch darstellen:
graph twoway ///
	(scatter xt11 age, color("224 182 168") msize(vsmall) msymbol(d)) ///
	(lfit xt11 age, lcolor("41 48 78") lpattern(solid) ), ///
	by(sex,title("Alter & Fernsehkonsum") note("")) ///
	scheme(plotplain) ///
	ytitle("Fernsehkonsum (xt11)") xtitle("Alter (age)") ///
	legend(lab(1 "Fernsehkonsum") lab(2 "Lineare Regressionsgerade"))

graph twoway ///
	(scatter xt11 age if sex == 1, color("42 37 92 %20") msize(vsmall) msymbol(d)) ///
	(scatter xt11 age if sex == 2, color("92 83 28 %20") msize(vsmall) msymbol(d)) ///
	(lfit xt11 age if sex == 1, lcolor("42 37 92") lpattern(solid) ) /// 
	(lfit xt11 age if sex == 2, lcolor("92 83 28") lpattern(solid) ) ///
	, scheme(plotplain) ///
	ytitle("Fernsehkonsum (xt11)") xtitle("Alter (age)") ///
	legend(lab(1 "Fernsehkonsum Männer") lab(2 "Lineare Regressionsgerade Männer") ///
		   lab(3 "Fernsehkonsum Frauen") lab(4 "Lineare Regressionsgerade Frauen"))

	// auffällig: Ausreißer bei Frauen mit sehr langer Fernsehdauer - ggf. ausschließen


* Übung 2 ----------------------------------------------------------------------
cd D:\oCloud\Home-Cloud\Lehre\Methodenseminar
use  "Allbus_1980-2018.dta",clear
keep if year == 2014
drop if hw01 < 0
drop if educ < 0 | educ > 5
tab educ hw01

spearman educ hw01 if sex == 1
spearman educ hw01 if sex == 2
// deutlich stärkerer, positiver zusammenhang bei Männer als bei Frauen
ktau educ hw01 if sex == 1
ktau educ hw01 if sex == 2
// ebenso deutlich stärkerer positiver Zusammenhang

* --> höhere Bildung geht insb. bei Männern mit geringerer Belastung einher, bei Frauen besteht (quasi) kein Zusammenhang

spineplot educ hw01 if sex == 1, name("men", replace) ///
  legend(pos(6) size(vsmall) rows(2)) ///
  xlabel(,labsize(small) axis(2) ) ///
  title("Männer")

spineplot educ hw01 if sex == 2, name("women", replace) ///
	legend(pos(6) size(vsmall) rows(2)) ///
	xlabel(,labsize(small) axis(2) ) ///
	title("Frauen")
graph combine men women, rows(1) iscale(*.95) xsize(4) ysize(2) 


* Übung 3 ----
cd D:\oCloud\Home-Cloud\Lehre\Methodenseminar
use  "Allbus_1980-2018.dta",clear

keep if df01 > 0 & age > 0

tab eastwest df01, chi

tab eastwest df01 if age < 40, chi
dis sqrt(23.8551 / 3813)

tab eastwest df01 if age >= 40, chi
dis sqrt( 107.8065 / 8199)

// bei älteren Befragten besteht ein deutlich stärkerer Zusammenhang -> stärkere Ost/West-Unterschiede


* ---------------------- *
* weitere Aufgaben
* Wissensquizdauer & age

cd D:\oCloud\Home-Cloud\Lehre\Methodenseminar
use  "Allbus2018.dta",clear

keep if xt11 > 0 & age > 0
corr age xt11
corr age xt11 if sex == 1
corr age xt11 if sex == 2

// insgesamt geringer/kein Zusammenhang, bei Frauen (.15) deutlich stärker als bei Männern (.04)

reg xt11 age // insgesamt:  zusätzliches Altersjahr geht mit  .9668326  Minuten mehr Quizdauer einher
reg xt11 age if sex == 1 // Männer: zusätzliches Altersjahr geht mit .5727837 Minuten mehr Quizdauer einher   
reg xt11 age if sex == 2 // Frauen: zusätzliches Altersjahr geht mit 1.41421   Minuten mehr Quizdauer einher

// vorhergesagte Werte für Männer:
dis 46.0486 + .0452189 * 30
dis 46.0486 + .0452189 * 31
// für Frauen:
dis 43.73796 + .0602994 * 30
dis 43.73796 + .0602994 * 31



* Grafisch darstellen:
graph twoway ///
	(scatter xt11 age, color("224 182 168") msize(vsmall) msymbol(d)) ///
	(lfit xt11 age, lcolor("41 48 78") lpattern(solid) ), ///
	by(sex,title("Alter & Fernsehkonsum") note("")) ///
	scheme(plotplain) ///
	ytitle("Quizdauer (xt11)") xtitle("Alter (age)") ///
	legend(lab(1 "Quizdauer") lab(2 "Lineare Regressionsgerade"))

graph twoway ///
	(scatter xt11 age if sex == 1, color("42 37 92 %20") msize(vsmall) msymbol(d)) ///
	(scatter xt11 age if sex == 2, color("92 83 28 %20") msize(vsmall) msymbol(d)) ///
	(lfit xt11 age if sex == 1, lcolor("42 37 92") lpattern(solid) ) /// 
	(lfit xt11 age if sex == 2, lcolor("92 83 28") lpattern(solid) ) ///
	, scheme(plotplain) ///
	ytitle("Quizdauer (xt11)") xtitle("Alter (age)") ///
	legend(lab(1 "Quizdauer Männer") lab(2 "Lineare Regressionsgerade Männer") ///
		   lab(3 "Quizdauer Frauen") lab(4 "Lineare Regressionsgerade Frauen"))


	// auffällig: Ausreißer bei Männern mit sehr langer Fernsehdauer - ggf. ausschließen

	drop if xt11  > 2000 // oder 
	
	graph twoway ///
	(scatter xt11 age, color("224 182 168") msize(vsmall) msymbol(d)) ///
	(lfit xt11 age, lcolor("41 48 78") lpattern(solid) ), ///
	by(sex,title("Alter & Fernsehkonsum") note("")) ///
	scheme(plotplain) ///
	ytitle("Quizdauer (xt11)") xtitle("Alter (age)") ///
	legend(lab(1 "Quizdauer") lab(2 "Lineare Regressionsgerade"))

	
	graph twoway ///
	(scatter xt11 age if sex == 1, color("42 37 92 %20") msize(vsmall) msymbol(d)) ///
	(scatter xt11 age if sex == 2, color("92 83 28 %20") msize(vsmall) msymbol(d)) ///
	(lfit xt11 age if sex == 1, lcolor("42 37 92") lpattern(solid) ) /// 
	(lfit xt11 age if sex == 2, lcolor("92 83 28") lpattern(solid) ) ///
	, scheme(plotplain) ///
	ytitle("Quizdauer (xt11)") xtitle("Alter (age)") ///
	legend(lab(1 "Quizdauer Männer") lab(2 "Lineare Regressionsgerade Männer") ///
		   lab(3 "Quizdauer Frauen") lab(4 "Lineare Regressionsgerade Frauen"))


	
	
* ---------------------- *
* Profi-Übungen
* Indexbildung 


cd D:\oCloud\Home-Cloud\Lehre\Methodenseminar
use  "Allbus2018.dta",clear

mvdecode px01 px02 px03 px04 px05 px06 px07 px08 px09 px10, mv(-10/-1)
mvdecode age , mv(-50/-1)
egen rechts = rowmean(px01 px02 px03 px04 px05 px06 px07 px08 px09 px10)

summarize rechts // geht von 1 bis 5

corr rechts age // geringer Zusammenhang
reg rechts age

	display _b[_cons] + _b[age] * 30
	display _b[_cons] + _b[age] * 70
