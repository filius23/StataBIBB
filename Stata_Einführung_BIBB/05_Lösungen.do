* -------------------------------- *
* 05 Befehle: Variablen erstellen 
* Lösungen
* -------------------------------- *

cd "D:\Datenspeicher\BIBB_BAuA" // wo liegt der Datensatz?
use "BIBBBAuA_2018_suf1.0.dta", clear

* 5-1: AO-WO NUTS-2 -----------------------------------
d nuts2 F233_nuts2
labelbook nuts2 
mvdecode nuts2 F233_nuts2, mv(99996/99999)

gen pendler =  nuts2 == F233_nuts2 if !missing(F233_nuts2)
tab pendler, m

	// check 1: in browse nachsehen
	bro intnr nuts2 F233_nuts2 pendler
	list intnr nuts2 F233_nuts2 pendler
	//check 1b: missings 
	bro intnr nuts2 F233_nuts2 pendler if missing(F233_nuts2)

label define pend1 		0 "AO != WO" 1 "AO == WO"
label values pendler 	pend1	
tab pendler
	
* Label S1 ändern
tab S1
describe S1
label define S1 	1 "Männer" 2 "Frauen", replace
tab S1
	
* 5-2: Schulabschluss zusammenfassen -----------
tab F1108
labelbook F1108
recode F1108 (1/2=1 "(sehr) gut") (3/4=2 "bestanden") (7/9=3 "fehlend"), into(F1108_neu)
tab F1108 F1108_neu

* 5-3: Besondere Arbeitszeiten ------------------
d F209 F223
tab1 F209 F223
tab1 F209 F223, nol
mvdecode F209 F223, mv(9)

gen a_zeit = .
replace a_zeit = 1 if F209 == 1 & F223 == 2 // zwischen 7-19 Uhr & keine Sonntagsarbeit
replace a_zeit = 2 if F209 == 2 & F223 == 2 // nicht zwischen 7-19 Uhr aber keine Sonntagsarbeit
replace a_zeit = 3 if F209 == 1 & F223 == 1 // zwischen 7-19 Uhr aber Sonntagsarbeit
replace a_zeit = 4 if F209 == 2 & F223 == 1 // nicht zwischen 7-19 Uhr und Sonntagsarbeit
tab a_zeit
lab def azeit_lab 1 "zwischen 7-19 Uhr & keine Sonntagsarbeit" 2 "nicht zwischen 7-19 Uhr aber keine Sonntagsarbeit" ///
		3 "zwischen 7-19 Uhr aber Sonntagsarbeit" 4 "nicht zwischen 7-19 Uhr und Sonntagsarbeit"

lab values a_zeit azeit_lab