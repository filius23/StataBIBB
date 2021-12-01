* -------------------------------- *
* 03 Befehle: Deskriptive Statistik 
* -------------------------------- *


use D:/Datenspeicher/BIBB_BAuA/BIBBBAuA_2018_suf1.0.dta, clear

*  cut() -> metrisch zu kategorial
mvdecode zpalter, mv(9999)
egen age_cat = cut(zpalter), at(15 18 35 60 100 )  label
tabulate age_cat

* summarize
summarize zpalter
summarize zpalter, detail

* tabstat --------------------------------------
tabstat zpalter, s(mean median var cv)

* percentile
centile age, centile(35)

* getrennt nach M/F:
tabstat zpalter, s(mean median var cv) by(S1)

* Streuungsmaße 
tabstat zpalter, s(var)
tabstat zpalter, s(sd)
tabstat zpalter, s(cv)
tabstat zpalter, s(cv) by(S1)


* GINI Koeffizient -----------------------
ssc install fastgini // einmalig nötig
which fastgini // check
fastgini F518_SUF

* Gini für F & M getrennt
fastgini F518_SUF if S1 == 1
fastgini F518_SUF if S1 == 2
