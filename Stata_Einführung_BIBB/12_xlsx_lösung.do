* -------------------------------- *
* Appendix: 
* XLSX-Datei einlesen & labeln 
* Lösung zur Übung
* -------------------------------- *

cd "D:\oCloud\Home-Cloud\Lehre\BIBB\StataBIBB1\Stata_Einführung_BIBB\"
import excel "Rohdaten2.xlsx", sheet("Sheet1") firstrow case(lower) clear

list

* Variablen umbenennen
rename x1 gender
rename x2 pets
rename x3 earlybird
rename x4 stata

* Schritt: Variablenbeschreibung -> label variable
label variable gender		"Geschlecht"
label variable pets			"Haustierbesitz?"
label variable earlybird	"Sind Sie ein*e Frühaufsteher*in?"
label variable stata     	"Stata macht Spaß"

list 
d


* gender -> Werte labels -> label values
tab gender
replace gender = .k if gender == -4
tab gender
tab gender, m

label define gend_lab 0 "Frau" 1 "Mann" .k "keine Angabe"
lab val gender gend_lab
tab gender
tab gender, m


* schleife für pets & earlybird
lab def dummy_lab 0 "Nein" 1 "Ja" .k "keine Angabe" .d "Datenfehler"
foreach v of varlist earlybird pets {
	replace `v' = .k if `v' == -4 	// keine Angabe 
	replace `v' = .d if `v' == -9	// Datenfehler	
	lab val `v' dummy_lab
}

list

* likert skala labeln
label define lik_lab 0 "trifft überhaupt nicht zu" 4 "tifft voll zu"
lab values stata lik_lab


list
