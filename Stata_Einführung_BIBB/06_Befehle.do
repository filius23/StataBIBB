* -------------------------------- *
* Session 6: egen & Hilfe + by
* -------------------------------- *

cd "D:\Datenspeicher\BIBB_BAuA" // wo liegt der Datensatz?
use "BIBBBAuA_2018_suf1.0.dta", clear
mvdecode zpalter, mv(9999)

* ---------------------- *
* egen
* ---------------------- *
// mit egen sind viele Operationen bei der Generierung von Variablen schnell erledigt
tab zpalter

	// so könnte man es auch machen:
	gen age_cat2 = .
	replace age_cat2 = 1 if zpalter < 18
	replace age_cat2 = 2 if zpalter < 25
		
egen age_cat = cut(zpalter), at(15 18 35 60 100 )  label
tab age_cat

// die Labels könnten wir anpassen:
describe age_cat
labelbook age_cat
label def age_cat 0 "15 bis 17" 1 "18 bis 34" 2 "45 bis 59" 3 "60 bis max", replace
tab age_cat

// so ginge es auch:
	tabstat zpalter, s(mean)
	gen durchschnittsalter = 47.19228
	
// schöner:
egen durchschnittsalter = mean(zpalter)
gen abw_durchschn =  zpalter - durchschnittsalter // abweichung von Durchschnittsalter


// diff
mvdecode Bula F233, mv(97/99)
cap drop ao_* // löschen falls vorhanden
gen ao_wo =  Bula ==  F233 if !missing(F233)
egen ao_wo2 = diff( Bula F233) if !missing(F233)

tab ao_wo ao_wo2,m
tab ao_wo*      ,m // kürzer mit wild-card

d ao*

* ---------------------- *
* help
* ---------------------- *
help egen 
// numlist
// varlist vs varname
// #
// Beispielsyntax unten

* ---------------------- *
* by  -
* ---------------------- *

by S1: egen mean_byS1 = mean(zpalter) // Fehler muss erst sortiert werden
* Fehlermeldung weil nicht sortiert

* Möglichkeit 1: sort. dann by:
*	sort S1
* 	by S1: egen mean_byS1 = mean(zpalter)

* Möglichkeit 2: bysort
bysort S1: egen mean_byS1 = mean(zpalter)

sort intnr // wieder die ursprüngliche Sortierung herstellen

*check: erste 10 Fälle ansehen 
list S1 zpalter durchschnittsalter mean_byS1 in 1/10


