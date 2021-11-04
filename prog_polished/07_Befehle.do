* -------------------------- *
* Konfidenzintervalle 
* -------------------------- *
cd "D:\oCloud\Home-Cloud\Lehre\Methodenseminar\" // wo liegt der Datensatz?
use  "Allbus_1980-2018.dta",clear
keep if year == 2014 & sex ==  1 & hs16 > 0

tabstat hs16,s(mean) // Punktschätzer für Mittelwert

display invttail(9999,0.025) // bei welchem t-Wert liegen 2.5% rechts davon?
display invttail(9999,0.975) // bei welchem t-Wert liegen 2.5% links / 97.5% rechts davon?

display invnormal(.025)

// Leider funktioniert `invnormal` umgekehrt von `invttail` und kumuliert von links nach rechts - wie man es erwarten würde....)
// invnormal die Fläche *links*, invttail die Fläche *rechts* 
// daher sind entsprechen sich  invnormal(.025)  und  invttail(df,   .975) 
display invnormal(.025) // z-Wert aus Standard-NV
display invttail(3,   .975)
display invttail(30,  .975)
display invttail(300, .975)
display invttail(3000,.975)

// 90 KI und 99 KI:
display invttail(9999,   .05)
display invttail(9999,  .005)

// 95% KI berechnen ---------------------------------------------------------
// Fallzahl nachsehen
tabstat hs16, s(n)
display invttail( 1758-1,  .025)

// SD und N ausgeben lassen:
tabstat hs16, s(mean sd n)

// untere 95%-KI Grenze:
dis 178.7179 - 1.9613151* 7.18002 / sqrt(1758)
// obere 95% Grenze:
dis 178.7179 + 1.9613151* 7.18002 / sqrt(1758)


// 90% KI berechnen ---------------------------------------------------------
// Fallzahl nachsehen
tabstat hs16, s(n)
display invttail( 1758-1,  .05)

// SD und N ausgeben lassen:
tabstat hs16, s(mean sd n)

// untere 90%-KI Grenze:
dis 178.7179 - 1.6457213* 7.18002 / sqrt(1758)
// obere 90% Grenze:
dis 178.7179 + 1.6457213* 7.18002 / sqrt(1758)


// alles von Stata machen lassen ----------------------
mean hs16 // Standard ist 95%
mean hs16,level(90) // mit level(90) kann das 90%-KI angefordert werden#


* --------------------------------------------------------------------------- *
* bootstrapping
set seed 1212
bootstrap r(mean), reps(100): summarize hs16

set seed 1212
bootstrap r(mean), reps(100) nodots  : summarize hs16,  level(90)    



// um seed zu löschen neu laden:
clear all // alles aus dem Speicher löschen
cd "D:\oCloud\Home-Cloud\Lehre\Methodenseminar\" // wo liegt der Datensatz?
use  "Allbus_1980-2018.dta",clear
keep if year == 2014 & sex ==  1 & hs16 > 0
bootstrap r(mean), reps(100): summarize hs16, level(90)      


* --------------------------------------------------------------------------- *
* Befehle zum Anhang -----------------.

* Standard-NV
// wie groß ist Fläche links von -.674?
display normal(-0.674) 
// wieviel % aller IQ-Werte sind also kleiner als 130?
display normal(2)

// wie hoch muss IQ sein, um zu Top 1% zu gehören?
display invnormal(.99)
display 100 + 2.3263479*15 

// Welcher IQ ist höchstens unter den niedrigsten 1%?
display invnormal(.01)
100 + -2.3263479*15 

* Student t-Verteilung
// wie viel % liegen rechts eines  t-Werts von 1 bei df = 2?
display ttail(2,1)
// wie viel % liegen *links* eines t-Werts von 1 bei df = 2?
display 1- ttail(2,1)

// nachsehen wieviel Fläche links von t=2 bei df=14 liegt
dis 1-ttail(14,2)

// wie hoch muss t sein um bei df=14 die Fläche in 99%/1% zu teilen?
dis invttail(14,.99)

// obere/rechte Grenze berechnen für Top 1%:
display 100 + 2.6244941* 15


 