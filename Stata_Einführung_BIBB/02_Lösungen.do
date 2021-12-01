* ----------------------- *
* 02: Datensätze - Aufgaben
* ----------------------- *

* Laden Sie die Erwerbstätigenbefragung in Stata.
use "BIBBBAuA_2018_suf1.0.dta"

* 1 --------------------
	* Die Variable F100_wib1 erfasst, ob die Befragten in einem wissensintensiven Beruf tätig sind (ja/nein).
	* Lassen Sie sich eine Tabelle für F100_wib2 anzeigen. Welche ist die häufigste Ausprägung?
tab F100_wib2


	* Lassen Sie sich die Zahlencodes anstelle der Labels anzeigen (nolabel)
tab F100_wib2, nol

	* Überschreiben Sie alle Codes für fehlende Angaben mit . (Denken Sie an labelbook).
mvdecode F100_wib2, mv(-4)

	* Lassen Sie sich mit tabulate die Häufigkeitsauszählung erneut anzeigen. Hat sich die Fallzahl zu vorhin verändert?
tab F100_wib2

* Wie können Sie die fehlenden Werte auch in tabulate auszählen lassen? Lassen Sie sich diese Auszählung anzeigen!
tab F100_wib2, m

* Für wie viele Befragte liegt keine Angabe zum wissensintensiven Beruf vor? Nutzen Sie mdesc.
mdesc F100_wib2

* Lassen Sie sich jetzt F100_wib2 getrennt nach der Wohnortgröße ausgeben. Die Variable gkpol beinhaltet die Größenklasse der Wohngemeinde der Befragten in 7 Kategorien (bis 2000 Einwohner, 2000-5000 Einwohner, usw.)
tab F100_wib2 gkpol 
 
	* Welche Merkmalskombination ist die häufigste?
	* Welcher Anteil der Befragten aus Städten mit über 500.000 Einwohnern ist in einem wissenintensiven Beruf tätig?
tab F100_wib2 gkpol , col	
	
	* Wie hoch ist der Anteil der in einem wissenintensiven Beruf tätig Befragten, die in Orten mit unter 2.000 Einwohnern leben?
tab F100_wib2 gkpol , row	
	
* Kommentieren Sie ihre bisherigen Befehle mit //! Was haben Sie jeweils gemacht? Probieren Sie auch aus, mit /// einen Befehl über mehrere Zeilen zu verteilen!

tab F100_wib2 gkpol , row	 // Zeilenprozente
tab F100_wib2 gkpol , /// table
		row	 // Zeilenprozente


* 2 --------------------

	* Die Variable F1104 beinhaltet das Jahr des Schulabschlusses.
	* Verwenden Sie `summarize` um einen Überblick zu dieser Variable zu bekommen
su 	F1104
	
* Hat die Variable F1104 Werte, die Sie mit . ersetzen sollten? (Denken Sie an labelbook)
d F1104
labelbook  labels220

* Führen Sie ggf. die Umcodierung der problematischen Werte auf . durch, um sie so Stata kenntlich zu machen.
mvdecode  F1104, mv(9999)
* Lassen Sie sich F1104 erneut mit summarize anzeigen: hat alles geklappt wie es soll?
su F1104
* Für wie viele Befragte liegt kein Schulabschlussjahr vor? Nutzen Sie mdesc.
mdesc F1104

