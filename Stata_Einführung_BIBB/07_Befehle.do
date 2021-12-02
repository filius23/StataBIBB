* -------------------------------- *
* Kapitel 7: Inferenz - Hypothesentests und Gewichtung
* -------------------------------- *

use "D:\Datenspeicher\BIBB_BAuA/BIBBBAuA_2018_suf1.0.dta", clear
mvdecode zpalter, mv(9999)
summarize zpalter

* konfidenzintervall berechnen
dis 47.19228 + 1.960084* 11.33762 / sqrt(19836) // obere Grenze
dis 47.19228 - 1.960084* 11.33762 / sqrt(19836) // untere Grenze

mean zpalter


* t-test  vs. hypothetischen Wert
ttest zpalter==47.4

* t-Test Gruppenvergleich
ttest zpalter, by(S1) unequal


* verbundener t-Test
webuse bpwide, clear
browse bp_before bp_after
ttest bp_before==bp_after

* -------------------------------- *
* Gewichtung 
* zurück zur ETB18
use "D:\Datenspeicher\BIBB_BAuA/BIBBBAuA_2018_suf1.0.dta", clear
tabulate S1 // ungewichtet


svyset _n [pweight=gew2018]
svy: tabulate S1 , col count


tabulate S1 [weight=gew2018] // Fehlermeldung
tabulate S1 [weight=round(gew2018)] // runden führt zu Abweichung - Vergleich mit svy: Ergebnis

tabulate S1 [weight=round(gew2018*100 000)]



