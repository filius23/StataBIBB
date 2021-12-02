* -------------------------------- *
* 03 Befehle: Deskriptive Statistik 
* Lösungen
* -------------------------------- *


use D:/Datenspeicher/BIBB_BAuA/BIBBBAuA_2018_suf1.0.dta, clear

* 1 ---------------------------
	* Laden Sie den BIBB/BAuA Erwerbstätigenbefragung 2018 (`BIBBBAuA_2018_suf1.dta`). Analysieren Sie die Einkommensangaben (`F518_SUF`):
    * Denken Sie daran, die fehlenden Werte für `F518_SUF` mit als Missing zu überschreiben! (bspw. `mvdecode`, sehen Sie mit `labelbook F518` Codebuch nach, welche Werte als fehlende Angaben zu betrachten sind)
d F518_SUF
labelbook F518
mvdecode F518_SUF, mv( 99998/99999)
mdesc F518_SUF
	
	* Betrachten Sie die Einkommensangaben mit `summarize`
su F518_SUF
    * Für wie viele Beobachtungen haben Sie eine gültige Angabe (nicht-Missing)?
* 16,635 
    * Wo liegt das arith. Mittel für die Einkommensangaben?
*3532.109 
    * Wie können Sie sich den Median mit Hilfe von `summarize` ausgeben lassen?
su F518_SUF, detail
su F518_SUF, d
    * Bei welchem Wert liegt die 75%-Perzentilsgrenze?
*  4200  
    * Sind die Einkommensangaben eher rechts- oder linksschief verteilt?
* Skewness       9.843536 -> linkssteil, rechtsschief	
	

* Verwenden Sie jetzt `tabstat`, um folgende Kennzahlen für `F518_SUF` zu berechnen:
    * Das arithm. Mittel, den Median, das 25%- und 75%-Quartil sowie die Varianz und den Variationskoeffizienten - was sagen Ihnen die Werte jeweils?
tabstat 	F518_SUF, stat(mean p25 p50 p75 var cv)

    * Berechnen Sie nun alle Werte getrennt für Männer und Frauen (Variable `S1`) - welche Werte erhalten Sie jeweils für die Kennzahlen?
tabstat 	F518_SUF, stat(mean p25 p50 p75 var cv) by(S1)
    * Vergleichen Sie die Werte! Wie unterscheiden sich die Einkommensangaben zwischen Männern und Frauen?
  
  
  
* Berechnen Sie den Gini-Koeffizenten für `F518_SUF`! (Denken Sie daran, vor der ersten Verwendung `fastgini` zu installieren - siehe [hier](#gini))
fastgini F518_SUF if S1 == 1
fastgini F518_SUF if S1 == 2