*Import der Beispieldaten (direkt aus meiner github Seite)
use "https://github.com/filius23/Stata_Skript/raw/master/regression_bsp.dta", clear

* scatterplot
graph twoway scatter var2 var1 

* arith Mittel berechnen
su var2

* arith Mittel einzeichnen
graph twoway scatter var2 var1 , yline(4.75 , lc("grey50") lp(dash))  text(4 5 "mean = 4.75", place(e) box)

* Variable mit Mittelwert erstellen
egen mean_var2 = mean(var2)
list // ansehen

* Mittelwerte einzeichnen
graph twoway (scatter var2 var1 ) ///
 (scatter mean_var2 var1, mcolor("orange") ) ///
 , yline(4.75 , lc("grey50") lp(dash))  text(4 5 "mean = 4.75", place(e) box) 

* legende ausblenden
graph twoway (scatter var2 var1 ) ///
 (scatter mean_var2 var1, mcolor("orange") ) ///
 ,yline(4.75 , lc("grey50") lp(dash))  text(4 5 "mean = 4.75", place(e) box) legend(off) 

* Abweichungen vom Mittelwert
graph twoway (scatter var2 var1 ) ///
 (scatter mean_var2 var1, mcolor("orange") ) ///
 (rspike mean_var2 var2 var1, lc("red") lp("shortdash") lwidth(medium) ) ///
 ,yline(4.75 , lc("grey50") lp(dash))  text(4 5 "mean = 4.75", place(e) box) legend(off) 

* Abweichungen berechnen:
gen m_abw = var2 - mean_var2 // Abweichung vom Mittelwert
tabstat m_abw, s(sum) // gleich Null!
gen m_abw2 = m_abw^2 // quadrierte Abweichungen
tabstat m_abw2, s(sum)


* Regressionsgerade einzeichnen
graph twoway (scatter var2 var1 ) ///
 (scatter mean_var2 var1, mcolor("orange") ) ///
 (rspike mean_var2 var2 var1, lc("red") lp("shortdash") lwidth(medium) ) ///
 (lfit var2 var1, lc("navy") ) ///
 ,yline(4.75 , lc("grey50") lp(dash))  text(4 5 "mean = 4.75", place(e) box) legend(off) 


* Regression schätzen
reg var2 var1

* welchen wert würden wir für var1 = 5 vorhersagen?
dis 2.1351 + 0.5811 * 5
	// das gleiche ohne Abtippen:
	reg var2 var1
	display _b[_cons] + _b[var1] * 5 // in [] jeweils die Beschriftung der Zeilen schreiben -> hier also _cons und var1
	
* Vorhergesagte Werte mit predict "per Hand"
gen man_vorher = 2.1351 + 0.5811 * var1

* Vorhergesagte Werte mit predict
predict pred_vorher, xb
list, abbreviate(20)   


* vorhergesagte Werte einzeichnen
graph twoway (scatter var2 var1 ) ///
 (scatter mean_var2 var1, mcolor("orange") ) ///
 (rspike mean_var2 var2 var1, lc("red") lp("shortdash") lwidth(medium) ) ///
 (lfit var2 var1, lc("navy") ) ///
 (scatter reg_vorhersagen var1, mcolor("0 118 192") ) ///
 ,yline(4.75 , lc("grey50") lp(dash))  text(4 5 "mean = 4.75", place(e) box) legend(off) 


* Residuen  einzeichnen
graph twoway (scatter var2 var1 ) ///
 (scatter mean_var2 var1, mcolor("orange") ) ///
 (rspike mean_var2 var2 var1, lc("red") lp("shortdash") lwidth(medium) ) ///
 (lfit var2 var1, lc("navy") ) ///
 (scatter pred_vorher var1, mcolor("0 118 192") ) ///
 (rspike pred_vorher var2 var1, lc("0 118 192") lwidth(thin) ) ///
 ,yline(4.75 , lc("grey50") lp(dash))  text(4 5 "mean = 4.75", place(e) box) legend(off) 

* Residuen berechnen 
gen res = var2 - pred_vorher // per Hand: Differenz zwischen beobachtetem und vorhergesagtem Wert
list

	tabstat res, s(sum) // summe der (unquadrierten) Residuen ist immer Null!
	
// oder mit predict:
reg var2 var1 // zunächst nochmal die regression laufen lassen
predict p_res , residuals

list


// Summe der quadrierten Residuen
gen res2 = res^2
total m_abw2
total res2 


// R² per hand berechnen:
dis (14.75 -  2.256757) / 14.75
reg var2 var1 // R-squared       =    0.8470