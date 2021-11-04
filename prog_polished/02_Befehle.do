*Session 2
cd D:\oCloud\Home-Cloud\Lehre\Methodenseminar

use "Allbus2018.dta"
describe sex

help browse

describe sex, simple
describe, short
help describe
help tab
describe pv01 age sex, short

// befehle sind zeilenbasiert
describe pv01 age
sex

// mit /// können Zeilen verbunden werden
d pv01 age ///
sex

d pv01 age /// hier kann ein kommentar stehen
sex // hier geht es weiter

* kommentar
d pv01 age // einfacher kommentar


// Auszählen --------------------------
tabulate sex
tab sex 

tabulate age // unübersichtlich

summarize age // besser
summarize age inc // klappt auch mit mehreren Variablen

// neue Variable erstellen -----------------------s
gen age_mon = age * 12 
su age_mon
d,s
gen age_mon = age * 12 // fehler: gibt es schon


drop age_mon
gen age_mon = age * 12 
su age_mon age

// 2.4 Bestehende Variablen verändern ---------------------
replace age_mon = age * 12 
browse respid age age_mon // kontrolle


// keep / drop ------------------------------
keep if inc >= 1500 // alle mit inc >=1500 behalten
d,s

use Allbus2018.dta // fehler
clear

use Allbus2018.dta // neu laden
drop if inc < 1500
d,s

// fehlende werte
summarize age
labelbook age

replace age = . if age == -32
mvdecode age, mv(-32)

summarize age

gen age_mon = age * 12 if age > 0 

bro age age_mon if age < 0, nol


// mvdecode
mvdecode dm03 dg03 isced97, mv(-32 -10)

// labelbook zeigt ggf. miss Werte
labelbook cs06
mvdecode cs06, mv(-11/-1) // alles -11 - -1 als missing

// mdesc 
ssc install mdesc
mdesc age dm03 dg03 isced97

// if & missings
list sex land age if age > 92 // enthält auch die missings!


list sex land age if inrange(age,92.1,100)
list sex land age if age > 92 & !missing(age)

// labels und if
tabulate sex

keep if sex == "FRAU"

bro sex age 
tabulate sex, nolabel
keep if sex == 2
d,s
// speichern 
save "Allbus2018_neu.dta", replace
