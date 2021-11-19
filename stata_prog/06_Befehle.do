* Kapitel 6 - egen & Hilfe + by
cd "D:\Datenspeicher\BIBB_BAuA" // wo liegt der Datensatz?
use "BIBBBAuA_2018_suf1.0.dta", clear
mvdecode zpalter, mv(9999)

* ---------------------- *
* egen
* ---------------------- *
// mit egen sind viele Operationen bei der Generierung von Variablen schnell erledigt
egen age_cat = cut(zpalter), at(15 18 35 60 100 )  label
tab age_cat

// die Labels könnten wir anpassen:
d age_cat
labelbook age_cat
label def age_cat 0 "15 bis 17" 1 "18 bis 34" 2 "45 bis 59" 3 "60 bis max", replace
tab age_cat


egen durchschnittsalter = mean(zpalter)
gen abw_durchschn =  zpalter - durchschnittsalter // abweichung von Durchschnittsalter


// diff
mvdecode Bula F233, mv(97/99)
cap drop ao_* // löschen falls vorhanden
gen ao_wo =  Bula ==  F233 if !missing(F233)
egen ao_wo2 = diff( Bula F233) if !missing(F233)

tab ao_wo ao_wo2,m
tab ao_wo*      ,m // kürzer mit wild-card

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

* Möglichkeit 1: sort. dann by:
sort S1
by S1: egen mean_byS1 = mean(zpalter)

* Möglichkeit 2: bysort
bysort S1: egen mean_byS1 = mean(zpalter)