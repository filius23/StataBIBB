* -------------------------------- *
* 05 Befehle: Variablen erstellen 
* -------------------------------- *

cd "D:\Datenspeicher\BIBB_BAuA" // wo liegt der Datensatz?
use "BIBBBAuA_2018_suf1.0.dta", clear
mvdecode zpalter, mv(9999)

* -------------------------------- *
* generate
* -------------------------------- *
* neue Variable mit Alter in Monaten erstellen (ist natürlich ungenau - nur ein Beispiel)
gen alter_mon = zpalter * 12

// nochmal gen führt zu Fehler:
gen alter_mon = zpalter * 12

// entweder mit drop "frei machen":
drop alter_mon
gen alter_mon = zpalter * 12


* Überprüfen ---------------------
// check 1: in browse nachsehen
bro intnr zpalter alter_mon

//check 1b: missings 
bro intnr zpalter alter_mon if missing(zpalter)

// check 2: plausible werte?
summarize zpalter alter_mon 
dis  1044/12
dis   566.3073 /12
* macht Sinn...
mdesc zpalter alter_mon // 

* -------------------------------- *
// Dummy-Variable erstellen
* -------------------------------- *
d Bula F233
labelbook BULA F233
tab Bula
tab F233
mvdecode Bula F233, mv(97/99)
gen ao_wo = Bula ==  F233

bro Bula F233 ao_wo
list Bula F233 ao_wo in 157/160, clean noobs

tab ao_wo if missing(F233), m // !!! bei missings werden auch Vergleiche durchgeführt

drop ao_wo
gen ao_wo =  Bula ==  F233 if !missing(F233)
tab ao_wo,m 


	// check 1: in browse nachsehen
	bro intnr nuts2 F233_nuts2 pendler
	//check 1b: missings 
	bro intnr nuts2 F233_nuts2 pendler if missing(F233_nuts2)

* -------------------------------- *
* Labeln

label define aowo_lab 0 "ungleich" 1 "gleich"
label values ao_wo aowo_lab
tab ao_wo, m
tab ao_wo, nol // ohne labels

* label verändern:
label define aowo_lab 0 "Ungleich" 1 "Gleich", replace
tab ao_wo 

* -------------------------------- *
* bestehende Variablen verändern
tab gkpol
tab gkpol, nol

recode gkpol (1=1) (2=1) (3=1) (4=2) (5=2) (6=3) (7=3), into(gkpol2)
tab gkpol gkpol2


drop gkpol2 // nochmal neu
recode gkpol (2=1 "Klein") (3=1 "Klein") (4=2 "Mittel") (5=2 "Mittel") ///
				(6=3 "Groß") (7=3 "Groß"), into(gkpol2)
tab gkpol gkpol2
d gkpol
drop gkpol2
recode gkpol (1 2 3=1 "Klein") (4 5=2 "Mittel") (6 7=3 "Groß"), into(gkpol2)
recode gkpol (1/3=1 "Klein") (4 5=2 "Mittel") (6 7=3 "Groß"), into(gkpol2)

/*
	min 	  		Minimalwert
	max 	  		Maximalwert (missings werden hier ausnahmsweise nicht mit eingeschlossen)
	else or * 		alle anderen Werte
	miss 	  		alle missing Werte die nicht von einer anderen Regeln angesprochen werden
	nonmiss 		alle nicht-missing Werte die nicht von einer anderen Regeln angesprochen werden
*/

* -------------------------------- *
* infos aus mehreren Variablen

gen erw_hh = . 			// leere Variable erstellen
replace erw_hh = 1 if F1601 == 2 // alleine -> leben nicht zusammen
replace erw_hh = 2 if F1601 == 1 & F1603 == 1 // zusammenlebend, Partner*in erwerbstätig
replace erw_hh = 3 if F1601 == 1 & F1603 == 2 // zusammenlebend, Partner*in nicht erwerbstätig
replace erw_hh = 1 if inlist(F1600,2,3,4) // keine Partnerschaft -> auch auf 1
*! unverheiratete werden hier nicht als Partnerschaften behandelt

lab define erw_lab 1 "nicht verh./alleine lebend" 2 "verh. & 2 Erwerbspersonen im HH" 3 "verh. & 1 Erwerbsperson"
lab values erw_hh erw_lab
tab erw_hh




