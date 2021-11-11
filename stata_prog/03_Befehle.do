*Session 3
cd "D:\Datenspeicher\BIBB_BAuA" // wo liegt der Datensatz?
use "BIBBBAuA_2018_suf1.0.dta", clear

// metrische Variablen ----------------------
tab zpalter  // seeeehr lange tabelle
labelbook ZPALTER
mvdecode zpalter, mv(9999)

// kategorisieren
	egen age_cat = cut(zpalter), at(15 18 35 60 100 ) label
	tab age_cat
			
// summarize
summarize zpalter
su zpalter // abkürzung: su
summarize zpalter, detail
// tabstat
tabstat zpalter, s(mean median var cv) by(S1)
// streuungsmaße
tabstat zpalter, s(var sd cv)
tabstat zpalter, s(var sd cv) by(S1)
tabstat zpalter, s(var sd cv p25 p50)

// gini 
labelbook F518
mvdecode F518_SUF, mv( 99998/ 99999)
ssc install fastgini
fastgini F518_SUF
tabstat F518_SUF, s(mean median var cv)
