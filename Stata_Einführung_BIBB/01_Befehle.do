// Taschenrechnerfunktion
display 3 + 12
display sqrt(9)

// Datensatz einlesen

cd "C:/Kurse/Stata_BIBB/data/" // wo liegt der Datensatz?
pwd
use "BIBBBAuA_2018_suf1.0.dta"

use "C:/Kurse/Stata_BIBB/data/BIBBBAuA_2018_suf1.0.dta"

describe, short // infos zum Datensatz
describe F209 // Infos zu F209
d F209* // infos zu allen Variablen, die mit F209 beginnen

labelbook F209


browse // Datensatzsatz ansehen
browse intnr Bula gkpol Stib zpalter // nur einige Variablen ansehen
browse intnr Bula gkpol Stib zpalter, nol // dahinter liegende Zahlencodes

list  intnr Bula gkpol Stib zpalter  in 1/10 // in ausgabefenster anzeigen
list  intnr Bula gkpol Stib zpalter  in 1/10, nol // auch hier ohne labels anzeigen 

// Variablen & Bezeichnungen suchen
lookfor "Englisch"
lookfor "englisch" // Groß/Kleinschreibung wird ignoriert

