
* -------------------------------- *
// Index aus F700_02 F700_10 bilden
* -------------------------------- *
d F700_02 F700_10
labelbook F700_02 F700_10
mvdecode F700_02 F700_10, mv(9)

tab F700_02
tab F700_02 , nol
recode F700_02 (4=1) (3=2) (2=3) (1=4), into(F700_02_rev)
tab F700_02 F700_02_rev // check mit ausgangsvariable

* Tipp: einfach 1+höchste Ausprägung - Variable:
gen F700_02_rev2 = 5 - F700_02
tab F700_02 F700_02_rev2 // check mit ausgangsvariable

tab F700_02_rev F700_02_rev2 // beide Wege führen zum gleichen Ziel


gen index = (F700_02 + F700_10)/2