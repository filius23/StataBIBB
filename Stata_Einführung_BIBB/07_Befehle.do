* -------------------------------- *
* Kapitel 7: Inferenz - Hypothesentests und Gewichtung
* -------------------------------- *

use "D:\Datenspeicher\BIBB_BAuA/BIBBBAuA_2018_suf1.0.dta", clear
mvdecode zpalter, mv(9999)
summarize zpalter


display invttail( 3-1, .025) // n -1
display invttail( 3000-1, .025) // n -1

* mean(x) +/- t * sd/sqrt(n)
display invttail( 19836-1, .025) // n -1

* konfidenzintervall berechnen
display 47.19228 + 1.960084* 11.33762 / sqrt(19836) // obere Grenze
display 47.19228 - 1.960084* 11.33762 / sqrt(19836) // untere Grenze

mean zpalter

// standardfehler: sd/sqrt(n)
display 11.33762 / sqrt(19836)


* t-test  vs. hypothetischen Wert
ttest zpalter==47.4






* t-Test Gruppenvergleich
ttest zpalter, by(S1) unequal

* p < 0.05 


* verbundener t-Test
webuse bpwide, clear
browse bp_before bp_after
ttest bp_before==bp_after

* -------------------------------- *
* Gewichtung 
* zurück zur ETB18
use "D:\Datenspeicher\BIBB_BAuA/BIBBBAuA_2018_suf1.0.dta", clear
tabulate S1 // ungewichtet

// pweight -> anteile innerhalb der Stichprobe
svyset _n [pweight=gew2018]
svy: tabulate S1 , col count format(%8.2f)

// "hochgewichten" mit Hochrechnungsfaktor
tabulate S1 [fweight=gew2018_hr17] // Fehlermeldung
tabulate S1 [fweight=round(gew2018_hr17)] // runden führt evtl. zu Abweichung 


