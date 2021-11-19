* Kapitel 6 - Lösungen
cd "D:\Datenspeicher\BIBB_BAuA" // wo liegt der Datensatz?
use "BIBBBAuA_2018_suf1.0.dta", clear
mvdecode F518_SUF, mv( 99995/  99999)

// Laden Sie den BIBB/BAuA Erwerbstätigenbefragung 2018 (`BIBBBAuA_2018_suf1.dta`). 

* ---------------- *
*1 Bilden Sie mit Hilfe von `egen` verschiedene Einkommensklassen (bspw. ab 0EUR in 1000EUR-Schritten bis 72000EUR). Nutzen Sie die `numlist`-Funktion mit `(start(intervall)stop)`. 
* ---------------- *

egen inc_cat = cut()
egen inc_cat = cut(F518_SUF), at(0(1000)5000 72000)  label

tab inc_cat
tab inc_cat, nolabel
// Verändern Sie Labels.
lab def inc_cat 0 "bis 999" 1 "1000 bis 1999" 2 "2000 bis 2999" 3 "3000 bis 3999" 4 "4000 bis 4999" 5 "über 5000", replace
tab inc_cat


* ---------------- *
* 2 Welche Variablen bekommen Sie mit `describe` angezeigt, wenn Sie entweder `describe F21`, `describe F21*`, `describe F21?`, `describe F2*4` oder `describe F2?4` verwenden?
* ---------------- *
describe F21
describe F21*
describe F21?
describe F2*4
describe F2?4

// Öffnen Sie die Hilfe für `egen` und lassen Sie ein Beispiel Schritt für Schritt durchlaufen - beobachten Sie was passiert, indem Sie mit `browse` den Datensatz betrachten.

* ---------------- *
* 4 Berechnen Sie das Durchschnittseinkommen (basierend auf `F518_SUF`) getrennt für Männer und Frauen und legen Sie es in einer neuen Variable `m_inc_byS1` ab.
* ---------------- *
mvdecode F518_SUF, mv(99998/99999)
bysort S1: egen m_inc_byS1 = mean(F518_SUF)

* ---------------- *
* 5 Wie würden Sie jetzt für jede\*n Befragten berechnen, um wieviel ihr\*sein Einkommen vom geschlechtsspezifischen Durchschnittswert unterscheidet?
* ---------------- *
gen abw_m_inc = F518_SUF - m_inc_byS1