*Session 4
cd "D:\Datenspeicher\BIBB_BAuA" // wo liegt der Datensatz?
use "BIBBBAuA_2018_suf1.0.dta", clear

// if Bedingungen

list eastwest german sex age mstat if age == 20
list eastwest german sex age mstat if inc < 1000
list eastwest german sex age mstat if sex == 2 & inc < 1000

list intnr 

+ Wie können Sie sich die Zeile anzeigen lassen, welche den/die Befragte*n mit der `respid` 3469 enthält?