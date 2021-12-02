* ----------------------- *
* 02: Datensätze - Aufgaben
* ----------------------- *

* Laden Sie die Erwerbstätigenbefragung in Stata.
use "C:/Users/Desktop/BIBBBAuA_2018_suf1.0.dta"

* 1 --------------------
	* Die Variable F100_wib1 erfasst, ob die Befragten in einem wissensintensiven Beruf tätig sind (ja/nein).
	* Lassen Sie sich eine Tabelle für F100_wib2 anzeigen. Welche ist die häufigste Ausprägung?


	* Lassen Sie sich die Zahlencodes anstelle der Labels anzeigen (nolabel)

	* Überschreiben Sie alle Codes für fehlende Angaben mit . (Denken Sie an labelbook).

	* Lassen Sie sich mit tabulate die Häufigkeitsauszählung erneut anzeigen. Hat sich die Fallzahl zu vorhin verändert?

* Wie können Sie die fehlenden Werte auch in tabulate auszählen lassen? Lassen Sie sich diese Auszählung anzeigen!

* Für wie viele Befragte liegt keine Angabe zum wissensintensiven Beruf vor? Nutzen Sie mdesc.

* Lassen Sie sich jetzt F100_wib2 getrennt nach der Wohnortgröße ausgeben. Die Variable gkpol beinhaltet die Größenklasse der Wohngemeinde der Befragten in 7 Kategorien (bis 2000 Einwohner, 2000-5000 Einwohner, usw.)
 
	* Welche Merkmalskombination ist die häufigste?
	* Welcher Anteil der Befragten aus Städten mit über 500.000 Einwohnern ist in einem wissenintensiven Beruf tätig?
	
	* Wie hoch ist der Anteil der in einem wissenintensiven Beruf tätig Befragten, die in Orten mit unter 2.000 Einwohnern leben?
	
* Kommentieren Sie ihre bisherigen Befehle mit //! Was haben Sie jeweils gemacht? Probieren Sie auch aus, mit /// einen Befehl über mehrere Zeilen zu verteilen!



* 2 --------------------

	* Die Variable F1104 beinhaltet das Jahr des Schulabschlusses.
	* Verwenden Sie `summarize` um einen Überblick zu dieser Variable zu bekommen
	
* Hat die Variable F1104 Werte, die Sie mit . ersetzen sollten? (Denken Sie an labelbook)
* Führen Sie ggf. die Umcodierung der problematischen Werte auf . durch, um sie so Stata kenntlich zu machen.

* Lassen Sie sich F1104 erneut mit summarize anzeigen: hat alles geklappt wie es soll?

* Für wie viele Befragte liegt kein Schulabschlussjahr vor? Nutzen Sie mdesc.


