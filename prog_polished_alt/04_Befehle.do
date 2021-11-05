* --------------- *
* Grafiken
* --------------- *
* einlesen
cd D:\oCloud\Home-Cloud\Lehre\Methodenseminar
use "Allbus2018.dta", clear
replace inc = . if inc < 0
replace age = . if age < 0
replace educ = . if educ < 0
replace agec = . if agec < 0

* metrische Verteilung ---------------------------------------------------------
graph box inc
histogram inc
kdensity inc 

* metrische Verteilung vergleichen  
drop if inc > 10000



graph box inc, by (sex) 




histogram inc, by(sex)
twoway (kdensity inc), by(sex)


* dot plots
graph dot (p25) inc ( mean ) inc (p75) inc, over(sex) ///
	marker(1, msymbol(Dh) mcolor("91 37 97")) ///
	marker(2, msymbol(S) mcolor("150 196 134")) ///
	marker(3, msymbol(Dh) mcolor("91 37 97")) ///
	legend(lab(1 "25%") lab(2 "arith. Mittel") lab(3 "75%") ///
		   col(3) title("Kennzahlen") pos(12)) ///
	title(Einkommensverteilung) ytitle("Einkommen EUR") ///
	yscale(range(0 5000)) ///
	ytick(0 (1000) 5000 ) /// 
	ylabel(0 "Null" 1000(1000)5000) ///
	plotregion(fcolor(gs13%10)) graphregion(fcolor(white)) 
	
	
graph dot (p25) inc ( mean ) inc (p75) inc, over(sex) name("p1")
graph dot (p25) inc ( mean ) inc (p75) inc, over(eastwest) name("p2")

graph combine p1 p2	


	

* kategoriale Verteilung -------------------------------------------------------
graph bar (count) respid, over(educ)
graph bar (count) respid, over(educ) 

* Facetten ---------------------------------------------------------------------
* metrische Verteilung vergleichen  
graph box inc, by(sex) 
histogram inc, by(sex)
twoway (kdensity inc), by(sex)

* kategoriale Verteilung vergleichen 
graph bar (count) respid, over(educ,label(labsize(small)))  by(sex)
graph hbar (count) respid, over(educ,label(labsize(small)))  by(sex)



* gemeinsame Verteilung zweier (oder mehrer) Variablen -------------------------
* mosaic plot mit spineplot
ssc install spineplot // spineplot muss erst installiert werden

	// labels anpassen, um besser auf x-Achse zu passen:
	label copy agec agec1
	label define agec1 1 "18-29" 2 "30-44" 3 "45-59" 4 "60-74" 5 "75-89" 6 "ü 89", modify // modidy -> nur angepasste Labels überschreiben
	// mehr zu Labels in Kapitel 11 
	label value agec agec1

spineplot educ  agec, xlabel(,labsize(small) axis(2)) legend(size(vsmall))



* Streudiagramm 
graph twoway scatter inc age



* Streudiagramm nach Subgruppen -----------------------------------------------
graph twoway (scatter inc age if sex==1) (scatter inc age if sex==2), legend(size(vsmall))




* Boxplot nach Subgruppen ----------------------------------------------------
// aufsplitten nach Bildungsgruppen:
gen inc1 = inc if educ == 1
gen inc2 = inc if educ == 2
gen inc3 = inc if educ == 3
gen inc4 = inc if educ == 4
gen inc5 = inc if educ == 5

graph box inc1-inc5
graph box inc1-inc5, by(sex)



* dot plots
graph dot (p25) age ( mean ) age (p75) age, over(sex)

// Farbe & Form anpassen von marker 1:
graph dot (p25) age ( mean ) age (p75) age, over(sex) title("Verteilung von age") marker(1, msymbol(d) mcolor(orange))



* ---------------------------------------------------------------------------- *
* 						Anpassungen 

* Titel
graph twoway scatter inc age, title("Titel") subtitle("Untertitel") xtitle("x-Achsentitel") ytitle("y-Achsentitel") caption("Bildunterschrift")


* Achsen:
graph twoway scatter inc age, title("") subtitle("") xtitle("") ytitle("") caption("") xtick(0 (10) 100 )  xlabel(0 "Null" 10 "zehn" 20 (10) 100) xscale(range(0 100))




* Text einfügen
graph twoway scatter inc age, text(17500 80 "text")




* Textformatierung
graph twoway scatter inc age, title("{stSerif:Einkommen {bf:fett} {it:kursiv}}") subtitle("Text{superscript:hochgestellt}{subscript:tiefgestellt}") xtitle("Alter {it:age}") ytitle("{stMono:Einkommen}") xlabel(0 " {stMono:Null}" 10 "{bf:zehn}" 20 (10) 100) text(15000 20 "Hier ein Symbol: {&Omega}") xscale(range(0 100))



* Textgröße
graph twoway scatter inc age, ///
 title("Text1", size(vsmall)) ///
 subtitle("Untertitel",size(large)) /// 
  xtitle("Alter",size(small)) ytitle("{stMono:Einkommen}",size(vhuge)) ///
  xlabel(0 " {stMono:Null}" 10 "{bf:zehn}" 20 (10) 100 , labsize(tiny) angle(90))



// text drehen mit angle
graph bar (count) respid, over(gkpol,label(labsize(small) angle(90)))

* Legende -> Option legend
graph twoway (scatter inc age if sex==1) (scatter inc age if sex==2), legend(lab(1 "Männer") lab(2 "Frauen") title("Geschlecht"))
graph twoway (scatter inc age if sex==1) (scatter inc age if sex==2), legend(lab(1 "Männer") lab(2 "Frauen") title("Geschlecht") pos(9)) // andere position


* Marker 
graph twoway scatter inc age, msymbol(D) msize(small) mcolor(sand)


//mcolor bei übereinander gelegten Scatterplots:
graph twoway (scatter inc age if sex==1, mcolor(orange) msize(small)) (scatter inc age if sex==2, mcolor(sand) msymbol(D) msize(small)), legend(lab(1 "Männer") lab(2 "Frauen")) 

// umrandung
graph twoway (scatter inc age if sex==1, mcolor(orange) msize(small) mlcolor(gs3) mlwidth(vthin)) (scatter inc age if sex==2, mcolor(sand) msymbol(D) msize(small) mlcolor(gs3) mlwidth(vvthin)), legend(lab(1 "Männer") lab(2 "Frauen")) 




* Farben -----------------------------------------------------------------------
graph twoway ///
	(scatter inc age if sex==1, mcolor("91	37 97") msize(small)) ///
	(scatter inc age if sex==2, mcolor("150 196 134") msymbol(D) msize(small)), ///
	legend(lab(1 "Männer") lab(2 "Frauen")) 



* transparenz
graph twoway ///
	(scatter inc age if sex==1, mcolor("91	37 97 %30") msize(small)) ///
	(scatter inc age if sex==2, mcolor("150 196 134 %30") msymbol(D) msize(small)), ///
	legend(lab(1 "Männer") lab(2 "Frauen")) 




* hintergründe einfärben
graph twoway (scatter inc age if sex==1, mcolor("91	37 97") msize(small)) (scatter inc age if sex==2, mcolor("150 196 134") msymbol(D)), legend(lab(1 "Männer") lab(2 "Frauen") region(fcolor(red))) plotregion(fcolor(eltblue)) graphregion(fcolor(olive_teal))




* Farben in Boxplots
graph box inc1 inc2 , ///
	box(1, color("orange") blcolor(black)) marker(1, mcolor("purple")  msymbol("Dh") ) ///
	box(2, color("159 97 184") blcolor(navy)) marker(2, mcolor("gs45")  msymbol("Sh") ) 



* farben in bar
graph bar (count) respid, over(eastwest) bar(1,fcolor(orange) color(gs4))

* Schemata ---------------------------------------------------------------------
graph twoway scatter inc age , scheme(sj)


ssc install blindschemes // für plotplain
graph twoway scatter inc age, scheme(plotplain) 



* Boxplot mit vielen Optionen -------------------------------------------------

use "Allbus2018.dta", clear

replace inc = . if inc < 0
replace age = . if age < 0

egen age_c = cut(age), at(20,35,50,65)
lab def agec1 20 "20-34" 35 "35-49" 50 "50-64"
lab val age_c agec1
gen inc_m = inc if sex == 1
gen inc_f = inc if sex == 2
lab var inc_m "Männer"
lab var inc_f "Frauen"

graph box inc inc_f, over(age_c) ///
scheme(lean1) ///
box(1, color("0 41 93")) marker(1, mcolor("0 41 93")  msymbol("o") ) medline(lcolor("204 175 105")) /// optionen box1
box(2, color("146 143 107")) marker(2, mcolor("146 143 107")  msymbol("o") ) /// box2 anpassen
legend(cols(2) pos(12) region(fcolor("249 247 241") lcolor("16 74 138")))  /// Legende
ytitle("{stSerif:Einkommen}{superscript:2018}") b1title("Alter") /// Achsenbeschriftung
title("Einkommen") caption("{bf:Quelle}: Allbus 2018 {it:eigene Berechnungen}",position(5)) /// titel usw.
plotregion(fcolor("252 251 248")) graphregion(fcolor("249 247 241")) // Hintergrundfarben


* Scatter mit vielen Optionen -------------------------------------------------
webuse bpwide, clear
graph twoway  ///
( scatter bp_before bp_after if agegrp == 1, mc("0 62 81") msymbol(o) ) /// Altersgruppe 1 -> dunkle Punkte
( scatter bp_before bp_after if agegrp == 2, mc("0 125 186") msymbol(d)  ) /// Altersgruppe 2 -> blaue Rhomben
( scatter bp_before bp_after if agegrp == 3, mc("214 210 196") msymbol(s)  ) /// Altersgruppe 3 -> Vierecke
, scheme(lean2) /// Schema
legend(lab(1 "30-45") lab(2 "{stMono:46-59}") lab(3 "60+") lcolor("16 74 138") region(fcolor("249 247 241") lcolor("16 74 138")) pos(6) cols(3)  )  /// legende -> 3 Spalten
xtitle("{stSerif:Blutdruck nachher}") ytitle("{stMono:Blutdruck vorher}") /// Achsenbeschriftung
text(185 172 "Ein Text" "über {stSerif: 2} Zeilen") title("{&Delta}p={stSerif:R}*V") // Textfeld einfügen




* Pyramide --------------------------------------------------------------------
cd D:\oCloud\Home-Cloud\Lehre\Methodenseminar
use "Allbus2018.dta", clear
tab agec
keep if sex > 0
keep if agec > 0
collapse (count) respid , by(sex age)
list
rename respid total
gen total_m = total if sex == 1
gen total_f = total if sex == 2
twoway (bar total_m age, horizontal) (bar total_f age, horizontal)


gen neg_total_m = -total_m
twoway (bar neg_total_m age, horizontal) (bar total_f age, horizontal)  

twoway( bar neg_total_m age, horizontal )(bar total_f age, horizontal) ,xlabel( -40 "40" -30 "30" -20 "20" -10 "10" 0 10(10)40 ) legend(off) text(100 -8 "Männer") text(100 8 "Frauen") 

*+* Farben
twoway ///
	(bar neg_total_m age, horizontal fcolor("60 117 153")) ///
	(bar total_f age, horizontal fcolor("201 255 247")) , /// 
	xlabel( -40 "40" -30 "30" -20 "20" -10 "10" 0 10(10)40 ) ///
	legend(off) text(100 -8 "Männer") text(100 8 "Frauen") ///
	xscale(range(0 50)) xtick(-50 (10) 50 ) ///
	scheme(plotplain) xtitle("{stSerif: Anzahl Befragte}") ytitle("{stSerif: Alter Befragte(r)}")



