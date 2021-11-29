* -------------------------------- *
* 04 Befehle: if-Bedingungen 
* Lösungen
* -------------------------------- *

*  Laden Sie den BIBB/BAuA Erwerbstätigenbefragung 2018 (`BIBBBAuA_2018_suf1.dta`). 

*1 ----------
	* In der Variable `intnr` ist die Interviewnummer abgelegt. Lassen Sie sich die Interviewnummer (`intnr`), Alter (`zpalter`), Geschlecht (`S1`) und die Wohnortgröße (`gkpol`) für den\*die Befragte mit der Interviewnummer 2388097 ausgeben. 

list intnr zpalter S1 gkpol if intnr == 2388097

*2 ----------
	* Ersetzen Sie die Werte 9999 in `zpalter` mit `.`: `mvdecode zpalter, mv(9999)`
mvdecode zpalter, mv(9999)
	
*3 ----------
	* Lassen Sie sich eine Häufigkeitsauszählung der Wohnortgröße für folgende Gruppen ausgeben:
	* Befragte, die jünger als 30 Jahre alt sind (das Alter ist in `zpalter` abgelegt)
tab gkpol if zpalter < 30
	* Befragte, die älter als 60 Jahre alt sind (Denken Sie an den Umgang mit Missings!)
tab gkpol if zpalter > 30 & !missing(zpalter)
tab gkpol if zpalter > 30 & zpalter != .
	* Befragte, die jünger als 30 Jahre alt und weiblich sind (das Geschlecht ist in `S1` erfasst)
tab gkpol if zpalter < 30 &  S1 == 2	
	* Befragte, die zwischen 30 und 60 Jahre alt sind
tab gkpol if inrange(zpalter,30,60)	
	* Befragte, die jünger als 30 Jahre alt sind oder älter als 60 Jahre alt sind  
tab gkpol if zpalter < 30  | inrange(zpalter,60,100)
tab gkpol if zpalter < 30  | (zpalter > 60 & zpalter < 100)	

  
*4 ----------
	* Lassen Sie sich die Wohngröße (`gkpol`) für alle Befragte mit fehlender Altersangabe ausgeben.
tab gkpol if missing(zpalter)
 
 
*5 ---------- 
	* Löschen Sie alle Beobachtungen von Befragten aus Städten mit 500.000 Einwohnern und mehr aus dem Speicher. Denken Sie an die Unterscheidung zwischen Labels und Zahlenwerten.
drop if gkpol == 7	
keep if gkpol < 7	
	