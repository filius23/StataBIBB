// Übungen 1 ---------------------------

//  Laden Sie den Datensatz `Allbus2018` erneut in Stata. 
cd "D:\oCloud\Home-Cloud\Lehre\Methodenseminar\" // wo liegt der Datensatz?
use "Allbus2018.dta", clear
// oder
clear
use "Allbus2018.dta"

	// Lassen Sie sich mit Hilfe von `tabulate` die Variable `gkpol` anzeigen.
tab gkpol
	
	// Lassen Sie sich die Zahlencodes anstelle der Labels anzeigen.
tab gkpol, nol
	// Überschreiben Sie alle Codes für fehlende Angaben mit `.`
labelbook gkpol
mvdecode gkpol, mv(-34)	
replace gkpol = . if gkpol == -34

	// Lassen Sie sich mit `tabulate` die Häufigkeitsauszählung erneut anzeigen. Hat sich die Fallzahl vorhin verändert?
tab gkpol
mdesc gkpol
	// Wie können Sie die fehlenden Werte auch in `tabulate` auszählen lassen? Lassen Sie sich diese Auszählung anzeigen!
tab gkpol
	// Löschen Sie alle Beobachtungen von Befragten aus Städten mit 500.000 Einwohnern und mehr aus dem Speicher.
drop if gkpol == 7	
drop if gkpol > 6
	
keep if gkpol < 7	
	
	// Kontrollieren Sie mit einem erneuten `tabulate`-Befehl, ob alle Fälle weg sind. (Denken Sie an die fehlenden Werte!)
tab gkpol
mdesc gkpol	
// Kommentieren Sie ihre bisherigen Befehle mit `//`! Was haben Sie jeweils gemacht? Probieren Sie auch aus, mit `///` einen Befehl über mehrere Zeilen zu verteilen!

tab ///
	gkpol

// Übungen 2 ---------------------------

// Laden Sie den Datensatz `Allbus2018` in Stata. 
cd D:\oCloud\Home-Cloud\Lehre\Methodenseminar
use "Allbus2018.dta", clear
	// In welcher Variable ist das Geburtsjahr der Befragten abgelegt?
	lookfor "geburt"
	// --> 
	
	// Nutzen Sie `summarize` für einen Überblick. Missings? 
	summarize yborn
	labelbook yborn
	
	// Überschreiben Sie diese negativen Werte mit `.`, um sie so Stata kenntlich zu machen.
	mvdecode yborn, mv(-9)
	//oder
	replace yborn = . if yborn == -9
	
	// Erstellen Sie eine neue Variable mit dem Alter der Befragten im Jahr 2020! 
	gen age_2020 = 2020  - yborn
	*gen age_2020 = age + 2
	
	// Lassen Sie sich das Geburtsjahr und die neu erstellte Variable für die ersten 20 Beobachtungen anzeigen - hat alles geklappt wie es soll?
	
	list yborn age_2020 in 1/20
	browse  yborn age_2020 
	// Wählen Sie alle Befragten aus, die nach 1960 geboren wurden und löschen Sie alle anderen aus dem Speicher. 
	
	keep if yborn > 1960
	// oder
	drop           if yborn <= 				1960
	
	// Wie viele Spalten hat der Datensatz nach dieser Veränderung? Wie viele Zeilen? 
	describe, short
	
	// Sind die Befragten mit fehlenden Geburtsjahrangaben noch im Datensatz? Nutzen Sie `mdesc`!
	mdesc yborn 
	
	




// Profi-Übungen 2 -----------------------------------

// Laden Sie den Datensatz `Allbus2018` erneut in Stata. 
clear
use "Allbus2018.dta"
	// Behalten Sie nur die Befragten, die zwischen 1970 und 1980 geboren wurden im Speicher!
	// Wie hilft Ihnen `inrange` hier weiter?
keep if inrange(yborn,1970,1980)



