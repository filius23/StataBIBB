* --------------- *
* Grafiken
* --------------- *
* einlesen
cd D:\oCloud\Home-Cloud\Lehre\Methodenseminar
use "Allbus2018.dta", clear
replace inc = . if inc < 0
replace age = . if age < 0
replace educ = . if educ < 0
replace agec = . if agec < 0

* metrische Verteilung ---------------------------------------------------------
graph box inc
histogram inc
kdensity inc 

* metrische Verteilung vergleichen  
graph box inc, by(sex) 
histogram inc, by(sex)
twoway (kdensity inc), by(sex)

/// Frage: wie kann ich die Skala von boxplots verändern?
graph box inc, by(sex) yscale(range(0 1000000)) // erweitern geht
graph box inc, by(sex) yscale(range(0 100)) // "zoomen" nicht


// dot plots
graph dot (p25) inc ( mean ) inc (p75) inc, over(sex)


// ein Dotplot mit sehr vielen Optionen zum selbst ausprobieren:
graph dot (p25) inc ( mean ) inc (p75) inc, over(sex) ///
	marker(1, msymbol(Dh) mcolor("91 37 97")) /// ersten Marker anpassen --> p25, msymbol ändert die Form, mcolor die Farbe
	marker(2, msymbol(S) mcolor("150 196 134")) /// zweiten Marker anpassen --> mean
	marker(3, msymbol(Dh) mcolor("91 37 97")) /// dritten marker anpassen  --> p75
	legend(lab(1 "25%") lab(2 "arith. Mittel") lab(3 "75%") /// beschriftung ändern, wieder der Reihe nach
		   col(3) title("Kennzahlen") pos(12)) /// in 3 Spalten anzeigen Legende, einen Titel geben, oben positionieren ("auf 12 Uhr")
	title(Einkommensverteilung) ytitle("Einkommen EUR") /// Überschrift für gesamte Grafik, Achse beschriften
	yscale(range(0 5000)) /// Achse ausdehnen
	ytick(0 (1000) 5000 ) /// Achsen-Marker bei 0 - 5000 in 1000er Schritten
	ylabel(0 "Null" 1000(1000)5000) /// Achsenbeschriftung anpassen -> 0 mit Null, dann Zahlen in 1000er Schritten
	plotregion(fcolor(gs13%10)) graphregion(fcolor(white)) // Farbe für Grafikfläche und Hintergrund
	

// 2 grafiken kombinieren
graph dot (p25) inc ( mean ) inc (p75) inc, over(sex) name("p1", replace) // , replace ersetzt ggf bereits existierende Grafik
graph dot (p25) inc ( mean ) inc (p75) inc, over(eastwest) name("p2", replace)

graph combine p1 p2	


	