* Kapitel 7 - Gewichtung
cd "D:\Datenspeicher\BIBB_BAuA" // wo liegt der Datensatz?
use "BIBBBAuA_2018_suf1.0.dta", clear
mvdecode zpalter, mv(9999)



// pweight
svyset _n [pweight=gew2018]
tabulate S1
svy: tabulate S1
svy: tabulate S1, count format(%11.0g)
svy: tabulate S1, 	col count format(%11.0g)
svy: tabulate F1600, col count format(%11.0g)
svy: tabulate Mig, 	col count format(%11.0g)
svy: tabulate S1 Mig, 	row col count format(%11.0g)

svyset _n [fweight=c]
tab S1
svy: tab S1, 	col count format(%11.0g)

su gew2018
d gew2018
tabulate S1 [fweight=round(gew2018)] 
svy: tabulate S1, count col format(%11.0g)

tabulate S1 [fweight=round(gew2018_hr17)] // runden führt zu Abweichung - Vergleich mit svy: Ergebnis
tabulate S1 [fweight=round(gew2018_hr17*100)] 



tab S1 [weight=gew2018] // problem: Nachkommastellen
tabulate S1 [weight=round(gew2018)] // runden führt zu Abweichung - Vergleich mit svy: Ergebnis

tabulate S1 [weight=round(gew2018*100 000)] // work-around: multiplizieren und runden




cd D:\oCloud\Home-Cloud\Lehre\Methodenseminar
use  Allbus_1980-2018.dta   , clear
keep if year == 2012
svyset _n [pweight=wghtpew]
svy: tabulate eastwest , col count
tab eastwest [weight = wghtpew]
tab eastwest [weight = round(wghtpew*100 000)]

