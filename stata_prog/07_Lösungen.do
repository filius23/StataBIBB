* -------------------------------- *
* Kapitel 7: Inferenz - Hypothesentests und Gewichtung
* Lösungen
* -------------------------------- *

use "D:\Datenspeicher\BIBB_BAuA/BIBBBAuA_2018_suf1.0.dta", clear


* 1 -----------------
	* Berechnen Sie das Konfidenzintervall für die durchschnittliche Arbeitszeit (az)
tabstat az, stat(mean sd n)
display invttail( 20012-1, .025)
dis 38.30557 - 1.9600825 * 11.75297 /sqrt(20012)
dis 38.30557 + 1.9600825 * 11.75297 /sqrt(20012)
mean az	
	
* 2 Testen Sie die Hypothese, dass die eigentliche durchschnittliche Arbeitszeit 38.5 Stunden beträgt. Interpretieren Sie die Ergebnisse im Sinne einen rechts-, links- und beidseitigen Tests!
ttest az == 38.5


* 3 Testen Sie die Hypothese, dass ein signifikanter Unterschied in der Arbeitszeit zwischen Männern und Frauen besteht
ttest az, by(S1) unequal


* -------------------------------- *
* Gewichtung 
* 4 Erstellen Sie eine Häufigkeitsauszählung der Ausbildungsabschlüsse - zunächst ohne und dann mit Gewichtung. Verwenden Sie sowohl die `pweights'  als auch die `fweights' an.

use "D:\Datenspeicher\BIBB_BAuA/BIBBBAuA_2018_suf1.0.dta", clear
tabulate  m1202 // ungewichtet


svyset _n [pweight=gew2018]
svy: tabulate m1202 , col count format(%10.3f)


tabulate m1202 [weight=gew2018] // Fehlermeldung
tabulate m1202 [weight=round(gew2018)] // runden führt zu Abweichung - Vergleich mit svy: Ergebnis
tabulate m1202 [weight=round(gew2018*100 000)]

tabulate m1202 [weight=round(gew2018_hr17)]
tabulate m1202 [weight=round(gew2018_hr17*10)]

dis %20.3fc 37434185 / 10