// Übungen 3-1--------------

	// Laden Sie den Allbusdatensatz für 2018 Allbus2018.dta in Stata:
cd D:\oCloud\Home-Cloud\Lehre\Methodenseminar
use "Allbus2018.dta"
	
    // Lassen Sie sich eine Tabelle für gkpol anzeigen. Welche ist die häufigste Ausprägung?
tab gkpol
	// Missings?
labelbook gkpol
mvdecode gkpol, mv(-34)

bro gkpol if gkpol == .

tab gkpol // keine Missings mehr
tab gkpol,m // mit Missings 

	// Welcher Anteil der Befragten leben in einem Ort mit höchstens 49.999 Einwohnern?
tab gkpol
// 66.04%
	// Wie groß ist der Anteil der Befragten, die in einem Ort mit mindestens 100.000 Einwohnern leben?
dis 100 -  72.47
	
	// fancy Lösung 
		tab gkpol, nol
		gen größer100000 = (gkpol >= 6) if !missing(gkpol) // erstellt eine variable, die = 1 wenn gkpol >= 6, ansonsten 0 -> wichtig: !missing(gkpol), sonst werden missings auch zu 1 (. ist unendlich)
		tab gkpol größer100000, m
		tab größer100000

	
	
	// Erstellen Sie nun eine Kontigenztabelle mit `sex` und `gkpol`. Welche Merkmalskombination ist die häufigste?
tab gkpol sex
// Männer aus 5.000  - 19.999 EINW (517)
    // Welcher Anteil der Befragten aus Städten mit über 500.000 Einwohnern ist weiblich?
tab gkpol sex, row nofreq
//49.50 %
    // Wie hoch ist der Anteil der Männer an Befragten, die in Orten mit unter 2.000 Einwohnern leben?
tab gkpol sex, row nofreq
// 50.91%	

    // Welcher Anteil der Frauen lebt in Städten mit 50.000 bis 99.999 Einwohnern?
tab gkpol sex, col nofreq
// 6.52%
    // Wie hoch ist der Anteil der Bewohner von Städten mit 20.000 bis 49.999 Einwohnern an allen befragten Männern?
tab gkpol sex, col nofreq
// 15.70	
	
	


// Übung 3-2 ---------------------------------------------------------------------------------------------------
// Forschungsfrage: Vergleichen Sie die Einkommensverteilung für Männer und Frauen!
cd D:\oCloud\Home-Cloud\Lehre\Methodenseminar
use "Allbus2018.dta", clear
	
    // Betrachten Sie die Einkommensverteilungen (Variable `inc`) 
    // Denken Sie daran, die negativen Werte für `di05` mit `.` zu überschreiben! (Entweder mit `replace` oder `mvdecode`)
labelbook inc	
mvdecode inc, mv(-50 -9 -1)
mvdecode inc, mv(-50/-1)
summarize inc, detail

    // Berechnen Sie das arithm. Mittel, den Median, das 25%- und 75%-Quartil sowie die Varianz und Variationskoeffizienten zunächst für alle Fälle aus dem Jahr 1994 - was sagen Ihnen die Werte jeweils?
tabstat inc, s(mean median p25 p75 var cv)	
	// --> 25% der Befragten hatten ein HH-Einkommen bis unter 1000 EUR
	// --> 25% der Befragten hatten ein HH-Einkommen über 2300 EUR 

 tabstat inc, s(mean median p25 p75 var cv)	by(sex)

	
// --> Einkommen in alten BuLä höher, streuung auch etwas größer.
	
	
	
    // Berechnen Sie den Gini-Koeffizenten!
fastgini inc
	
	fastgini inc if sex == 1
	fastgini inc if sex == 2
	// ungleichverteilung der einkommen von Männern größer
	
// Weitere Übungen ---------------------------------------------------------------------------------------------------
// 3
	// Forschungsfrage: Vergleichen Sie die HH-Einkommensverteilung in Ost und West!
cd D:\oCloud\Home-Cloud\Lehre\Methodenseminar
use "Allbus_1980-2018.dta", clear
    // Fokussieren Sie zunächst auf das Befragungsjahr 1994 mit Hilfe von `keep` oder `drop`.
keep if year == 1994	
	
    // Betrachten Sie die HH-Einkommensverteilungen (Variable `di05`) 
    // Denken Sie daran, die negativen Werte für `di05` mit `.` zu überschreiben! (Entweder mit `replace` oder `mvdecode`)
labelbook di05	
mvdecode di05, mv(-50/-1)
drop if di05 < 0
    // Berechnen Sie das arithm. Mittel, den Median, das 25%- und 75%-Quartil sowie die Varianz zunächst für alle Fälle aus dem Jahr 1994 - was sagen Ihnen die Werte jeweils?
tabstat di05, s(p25 p75 var)	
	// --> 25% der Befragten hatten ein HH-Einkommen bis unter 1150 EUR
	// --> 25% der Befragten hatten ein HH-Einkommen über 2600 EUR (umgerechnet...)
	
    // Berechnen Sie den Gini-Koeffizenten!
fastgini di05	
	
    // Berechnen Sie nun alle Werte getrennt nach Ost und West (Variable `eastwest`) - welche Werte erhalten Sie jeweils für die Kennzahlen in Ost und West?
tabstat di05, s(p25 p75 var cv) by(eastwest)	
// --> Einkommen in alten BuLä höher, streuung auch etwas größer.

	fastgini di05 if eastwest == 1
	fastgini di05 if eastwest == 2
	// ungleichverteilung in alten BuLä höher

//4 -----------------------------------------------------------------------------------
// Laden Sie den Allbus 2018 (`Allbus2018.dta`). Erstellen Sie eine Kontingenztabelle für `sex` und `educ`. Welche Merkmalskombination ist die häufigste? Denken Sie daran, fehlende Werte auszuschließen.
cd D:\oCloud\Home-Cloud\Lehre\Methodenseminar
use "Allbus2018.dta", clear
labelbook educ
mvdecode educ , mv(-9)

    // Erstellen Sie für die folgenden Fragen jeweils die passende Variante der Kontingenztabelle mit relativen Häufigkeiten als  Zeilen- oder Spaltenprozenten. 
    // Welcher Anteil der Befragten mit Fachhochschulreife ist männlich?
tab educ sex, nofreq row
// 54.97%
    // Wie hoch ist der Anteil der Frauen an Befragten mit Hauptschulabschluss?
tab educ sex, nofreq row
// 47.65%
    // Welcher Anteil der Frauen hat Abitur?
tab educ sex, nofreq col
// 30.48%
    // Wie hoch ist der Anteil der Realschulabsolventen an allen befragten Männern?
tab educ sex, nofreq col
// 32.30%


//5 -----------------------------------------------------------------------------------	
// Laden Sie den kumulierten Allbusdatensatz (`Allbus_1980-2018.dta`) in Stata und analysieren Sie, wie sich die Anteile der geschiedenen Befragten über die Befragungsjahre verändert haben!
cd D:\oCloud\Home-Cloud\Lehre\Methodenseminar
use "Allbus_1980-2018.dta", clear
    // Das Befragungsjahr finden Sie in der Variable `year`, `mstat` ist die Variable für den Familienstand.
    // Überschreiben Sie die Missings für `mstat`.
labelbook mstat
mvdecode mstat,mv(-41/-9)
    // In welchem Jahr gab es den höchsten Anteil an geschiedenen Befragten? Sie können so eine Variable generieren, welche 1 annimt wenn `mstat` = 4 (geschieden) und nur für allem andere Familienstände.
tab year mstat
gen divorce = (mstat == 4) if !missing(mstat)
tab mstat divorce // kontrolle
tab year divorce
    // Aus welchem Jahr stammen die Angaben der meisten geschiedenen Befragten?
// 2018 mit  330 
	// In welchem Jahr ist der Anteil der geschiedenen Befragten am höchsten?
tab year divorce, row nofreq
// ebenfalls 2018: mit 9.49%

	