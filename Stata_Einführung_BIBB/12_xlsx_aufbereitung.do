* -------------------------------- *
* Appendix: 
* XLSX-Datei einlesen & labeln 
* -------------------------------- *


* -------------------------------- *
* 1. Schritt: Datenimport aus Excel-Datei

* file -> import -> excel spreadsheet und dann Befehl kopieren aus Ausgabefenster
import excel "D:\oCloud\Home-Cloud\Lehre\BIBB\StataBIBB1\Stata_Einführung_BIBB\Rohdaten.xlsx", sheet("Sheet1") firstrow case(lower) clear

// oder:
cd "D:\oCloud\Home-Cloud\Lehre\BIBB\StataBIBB1\Stata_Einführung_BIBB\"
import excel "Rohdaten.xlsx", sheet("Sheet1") firstrow case(lower) clear

* Überblick gewinnen
list
 * browse

/* Aus Dokumentation wissen wir:
	 
	 
	 id 		Befragten-Identifikationsnummer
	 x1 		Geschlecht 		
					 1 = Frau, 2 = Mann, -4 keine Angabe
			
	 x2 		Haustiere? 
					0 = nein, 1 =  ja, -4  keine Angabe, -9 Datenfehler
	 
	 x3 		Frühaufsteher?
					0 = nein, 1 =  ja, -4  keine Angabe, -9 Datenfehler
	 
	 x4			5er Likert-Skala: Stata macht Spaß
					1 = trifft überhaupt nicht zu
					5 = tifft 	voll zu
				
*/
* -------------------------------- *
* 2. Schritt: Variablen umbenennen -> bezeichnungen anpassen

rename x1 gender
rename x2 pets
rename x3 earlybird
rename x4 stata

* check:
list

* -------------------------------- *
* 3. Schritt: Variablenbeschreibung -> label variable

label variable gender		"Geschlecht"
label variable pets			"Haustierbesitz?"
label variable earlybird	"Sind Sie ein*e Frühaufsteher*in?"
label variable stata     	"Stata macht Spaß"

list 
d


* -------------------------------- *
* 4. Schritt: Werte labels -> label values
tab gender
replace gender = .k if gender == -4
tab gender
tab gender, m

label define gend_lab 1 "Frau" 2 "Mann" .k "keine Angabe"
lab val gender gend_lab
tab gender
tab gender, m

/*
	 pets 			Haustiere? 
						0 = nein, 1 =  ja, -4  keine Angabe, -9 Datenfehler
	 earlybird		Frühaufsteher?
						0 = nein, 1 =  ja, -4  keine Angabe, -9 Datenfehler
*/					

lab def dummy_lab 0 "Nein" 1 "Ja" .k "keine Angabe" .d "Datenfehler"
lab val earlybird dummy_lab

tab earlybird
recode  earlybird (-9=.d) (-4=.k)
	* oder:
	replace earlybird = .k if earlybird == -4
	replace earlybird = .d if earlybird == -9
tab earlybird,m
	

* -------------------------------- *
* exportieren
compress // variablen auf minimale speichergröße bringen
save "Datensatz_ready.dta", replace
	

* -------------------------------- *
* probanden mit datenfehler rausfiltern

list 

list, nol

drop  if earlybird == .d // nur earlybird fehler raus	
keep  if earlybird != .d  // alle außer earlybird == Datenfehler

drop  if earlybird == .d | pets == .d // earlybird oder pet fehler raus
	
* -------------------------------- *
* fortgeschrittene Programmierung: foreach-Schleife

foreach v of varlist earlybird pets {
	replace `v' = .k if `v' == -4
	replace `v' = .d if `v' == -9	
	lab val `v' dummy_lab
}

foreach v of varlist earlybird pets {
	recode  `v' (-9=.d) (-4=.k)
	lab val `v' dummy_lab
}








