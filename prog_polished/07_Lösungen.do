* -------------------------- *
* Konfidenzintervalle 
* -------------------------- *


// Punktschätzer & KI für Körpergröße von Frauen
cd "D:\oCloud\Home-Cloud\Lehre\Methodenseminar\" // wo liegt der Datensatz?
use  "Allbus_1980-2018.dta",clear
keep if year == 2014 & sex == 2 & hs16 > 0

tabstat hs16,s(mean n) // Punktschätzer für Mittelwert


// parametrisch
	// SD und N ausgeben lassen:
	tabstat hs16, s(mean sd n)

	//t-Wert nachsehen:
	display invttail( 1707-1,  .025)
	// untere 95%-KI Grenze:
	dis 165.8881 - 1.9613555* 6.512124 / sqrt(1707)
	// obere 95% Grenze:
	dis 165.8881 + 1.9613555* 6.512124 / sqrt(1707)
	// Stata rechnen lassen:
	mean hs16
	// SE per Hand berechnet:
	dis	6.512124 / sqrt(1707)
	
	
//99%
	//t-Wert nachsehen:
	display invttail( 1707-1,  .005)
	// untere 99%-KI Grenze:
	dis 165.8881 - 2.5787143* 6.512124 / sqrt(1707)
	// obere 99% Grenze:
	dis 165.8881 + 2.5787143* 6.512124 / sqrt(1707)
	// Stata rechnen lassen:
	mean hs16, level(99)
	
	
//bootstrapping ---------------------------
	set seed 1212
	bootstrap r(mean), reps(2000): summarize hs16
	// 165.5768 - 166.1994
	mean hs16
	
	
// 99% 
	set seed 1212
	bootstrap r(mean), reps(2000) nodots: summarize hs16,  level(99)    //  165.4789 -  166.2973
	mean hs16, level(99)
	
	
// Weitere Übungen --------------------------

// Frauen
cd "D:\oCloud\Home-Cloud\Lehre\Methodenseminar\" // wo liegt der Datensatz?
use  "Allbus_1980-2018.dta",clear
replace inc = . if inc < 0
keep if work == 1 & !missing(inc) & year == 2016 & sex == 2

	// Mean SD und N ausgeben lassen:
	tabstat inc, s(mean sd n)
	
		//t-Wert nachsehen:
	display invttail( 507-1,  .025) // 1.9646633
	// untere 95%-KI Grenze:
	dis 1820.706 - 1.9646633* 904.5862 / sqrt(507)
	// obere 95% Grenze:
	dis 1820.706 + 1.9646633* 904.5862 / sqrt(507)
	// Stata rechnen lassen:
	mean inc
	
		bootstrap r(mean), reps(2000) nodots: summarize inc

// Männer 
cd "D:\oCloud\Home-Cloud\Lehre\Methodenseminar\" // wo liegt der Datensatz?
use  "Allbus_1980-2018.dta",clear
replace inc = . if inc < 0
keep if work == 1 & !missing(inc) & year == 2016 & sex == 1

	// Mean SD und N ausgeben lassen:
	tabstat inc, s(mean sd n)
	//t-Wert nachsehen:
	display invttail( 914-1,  .025) // 1.9625657
	
	// untere 95%-KI Grenze:
	dis  2503.45 - 1.9625657* 1438.802 / sqrt(914)
	// obere 95% Grenze:
	dis  2503.45 + 1.9625657* 1438.802 / sqrt(914)
	// Stata rechnen lassen:
	mean inc
	
	set seed 1212 
	bootstrap r(mean), reps(200) nodots: summarize inc
	
	
	// Vergleich:
	
	cd "D:\oCloud\Home-Cloud\Lehre\Methodenseminar\" // wo liegt der Datensatz?
	use  "Allbus_1980-2018.dta",clear
	replace inc = . if inc < 0
	keep if work == 1 & !missing(inc) & year == 2016 
	
	
	mean inc if sex == 1
	mean inc if sex == 2
	
	