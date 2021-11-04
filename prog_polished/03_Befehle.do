*Session 3
cd D:\oCloud\Home-Cloud\Lehre\Methodenseminar
use "Allbus2018.dta"

describe xr20

// tabulate -------------------
tabulate xr20
tabulate xr20,nol
labelbook xr20
mvdecode xr20, mv(-10 -9 -8) // missings raus
mvdecode xr20, mv(-10/-8) // macht das gleiche


tabulate xr20 sex
tabulate xr20 sex, cell // relative häufigkeiten

tabulate xr20 sex, cell nofreq // relative häufigkeiten ohne absolute häufigkeiten

// Zeilenprozente
tabulate xr20 sex, row nofreq
// Spaltenprozente
tabulate xr20 sex, col nofreq


// metrische Variablen ----------------------
tab age if age < 43 // seeeehr lange tabelle
labelbook age
mvdecode age, mv(-32)

// kategorisieren
	egen age_cat = cut(age), at( 18 35 60 100 )
	tab age_cat
		// exkurs: labeln
		label define age_cat_lab 18 "18-34 Jahre" 35 "35-29  Jahre" 60 "über 60 Jahre" 
		label values age_cat age_cat_lab
		tab age_cat
	
// summarize
summarize age	
su age
summarize age, detail
// tabstat
tabstat age, s(mean median var cv) by(eastwest)
// streuungsmaße
tabstat age, s(var sd cv)

// gini 
mvdecode di05, mv(-50/-1)
ssc install fastgini
fastgini di05
tabstat age, s(mean median var cv)
fastgini di05 if eastwest == 1
fastgini di05 if eastwest == 2
