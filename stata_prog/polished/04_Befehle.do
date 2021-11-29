* -------------------------------- *
* 04 Befehle: if-Bedingungen 
* -------------------------------- *

use D:/Datenspeicher/BIBB_BAuA/BIBBBAuA_2018_suf1.0.dta, clear
labelbook ZPALTER
mvdecode zpalter, mv(9999)

** if einfach anhängen:
fastgini F518_SUF if S1 == 2

list S1 S3 S2_j zpalter if zpalter == 81
list S1 S3 S2_j zpalter if S2_j < 1936

* auszählungen für eine spezielle Gruppe --------
tabulate S1 if zpalter == 81

* mehrere Bedingungen verbinden -------------
* UND:  & 
list S1 if zpalter > 81 & F518_SUF < 1000
* eine Bedingung reicht: | -> oder
tabulate S1 if zpalter == 81 | F518_SUF < 1000 // 81 Jahre alt oder unter 1000EUR Einkommen

* spezielle Operatoren --------------------
* inrange
tabulate S1 if zpalter >= 20 & zpalter <= 30
tabulate S1 if inrange(zpalter,20,30)
* inlist
tabulate S1 if zpalter == 15 | zpalter == 79 | zpalter == 80 | zpalter == 82
tabulate S1 if inlist(zpalter,15,79,80,82)

*missing 
tab S1 if missing(zpalter)


* if und labels ---------------------------
tab S1
tab S1 if S1 == "weiblich"
describe S1

tabulate S1, nol
tab S1 if S1 == 2


* if und missings  -------------------------
list S1 S3 zpalter if zpalter > 81
list S1 S3 zpalter if zpalter > 81, nol
list S1 Bula zpalter if inrange(zpalter,81.5,100)
list S1 Bula zpalter if zpalter > 81 & !missing(zpalter)


* keep/drop -------------
keep if zpalter < 30
drop if zpalter >= 30
describe, short
