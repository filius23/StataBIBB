// Taschenrechnerfunktion
display 3 + 12
display sqrt(9)

// Datensatz einlesen

cd "D:\Datenspeicher\BIBB_BAuA" // wo liegt der Datensatz?
use "BIBBBAuA_2018_suf1.0.dta"

describe, short // infos zum Datensatz
describe F209 // Infos zu F209
d F209* // infos zu allen Variablen, die mit F209 beginnen

browse // Datensatzsatz ansehen
browse intnr Bula gkpol Stib zpalter // nur einige Variablen ansehen

browse intnr Bula gkpol Stib zpalter, nol // dahinter liegende Zahlencodes

list  intnr Bula gkpol Stib zpalter  in 1/10 // in ausgabefenster anzeigen
list  intnr Bula gkpol Stib zpalter  in 1/10, nol // auch hier ohne labels anzeigen 

// Variablen & Bezeichnungen suchen
lookfor "Englisch"
lookfor "englisch" // Groß/Kleinschreibung wird ignoriert

// if Bedingungen

list eastwest german sex age mstat if age == 20
list eastwest german sex age mstat if inc < 1000
list eastwest german sex age mstat if sex == 2 & inc < 1000

bro eastwest german sex age mstat if sex == 2 | inc < 1000

// Operatoren: >, <, ==, >=, <=, != oder ~= (ungleich)

// inrange
bro sex land if age >= 20 & age <= 30
bro sex land if inrange(age,20,30)

