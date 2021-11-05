* Zusammenhangsmaße

* metrische Variablen --------------------------------------------------------
cd D:\oCloud\Home-Cloud\Lehre\Methodenseminar
use "Allbus_1980-2018.dta", clear
keep if year == 2012
mvdecode age hs18, mv(-32/-1)

corr age hs18 // pearson


// Regression
  use "https://github.com/filius23/Stata_Skript/raw/master/regression_bsp.dta", clear
	
// regressionsmodell: erst abh. Variable, dann unabh. Variable	-> vorherzusagende, dann vorhergesagte Variable
reg var2 var1	
	//  Die Gerade steigt also pro Einheit von var1 um 0.5810811.
	// Für var1 = 0 würden wir var2 = 2.135135 vorhersagen.
	// Unser Regressionsmodell kann 84,7% der Streuung um den Mittelwert erklären.
	
// vorhergesagte Werte
	reg var2 var1, noheader 
	
	display 2.1351+0.5811*5 // welcher Wert würde für var1 = 5 vorhergesagt?
	
	// das gleiche ohne Abtippen:
	reg var2 var1
	display _b[_cons] + _b[var1] * 5 // in [] jeweils die Beschriftung der Zeilen schreiben -> hier also _cons und var1
	
	// es geht immer genau um _b[var1] nach oben
	display (_b[_cons] + _b[var1] * 5) - (_b[_cons] + _b[var1] * 4)
	
	
	// vorhergesagte Werte für jede Zeile des Datensatzes:
	predict pred_vorher, xb
	
* Ausführliche Illustration des Regressions-Bsp siehe 05_regression


* ordinale Variablen --------------------------------------------------------
cd D:\oCloud\Home-Cloud\Lehre\Methodenseminar
use  "Allbus_1980-2018.dta",clear
keep if year == 1990
mvdecode educ, mv(-9 6 7)
mvdecode mi02, mv(-9 -8 -7)

tab educ mi02
spearman educ mi02
ktau educ mi02
tab educ mi02, gamma


* nominale Variablen --------------------------------------------------------
cd D:\oCloud\Home-Cloud\Lehre\Methodenseminar
use  "Allbus_1980-2018.dta",clear
keep if year == 2014 & dh01 > 0 & dh04 > 0 & aq03 > 0
tab aq03 dh01
gen aq03b = (aq03 == 4) if !missing(aq03)
list aq03 aq03b in 1/10, nol

tab aq03b dh01
tab aq03 dh04

tab aq03 dh04, chi
dis sqrt(157.1103/(3466*3))

tab aq03b dh01, chi
dis sqrt(89.0092/3466)