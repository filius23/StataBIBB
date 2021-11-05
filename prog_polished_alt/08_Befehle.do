clear all

// Daten eingeben
input miete
301
291
304
324
356
384
407
306
310
230
307
252
306
355
194
320
233
265
214
319
320
256
234
346
223
344
294
253
383
360
305
378
270
327
360
310
345
300
361
253
end

tabstat miete, s(mean)
// Ist das genug Evidenz, um zu sagen dass 320 zu hoch ist?

// t- Wert berechnen
display (305-320)/(52.053/sqrt(40))  

// Fläche links von -1.822533:
display 1-ttail(40-1,-1.822533)

// verdoppeln für beidseitige Flächen:
display (1-ttail(40-1,-1.822533)) *2

// mit ttest geht es schneller:
ttest miete==320


// linksseitig manuell:
display (305-320)/(52.053/sqrt(40))
display 1-ttail(40-1,-1.822533) // Fläche links

// rechtsseitig manuell
display (305-320)/(52.053/sqrt(40))
display ttail(40-1,-1.822533) // Fläche rechts


// Mittelwertvergleiche  -------------------------------------------

// unverbundener ttest
	use Allbus_1980-2018.dta, clear
	keep  if year == 2014 & hs16>0

	// Größenunterschiede zwische Männern und Frauen im Allbus2014
	tabstat hs16,s(mean) by(sex) // Körpergröße für Männer und Frauen berechnen
	dis 178.7179 - 165.8881

tabstat hs16,s(var cv) by(sex) // -> unequal
	// ist das mehr als nur Zufall?
	ttest hs16, by(sex) unequal
	// unequal, weil varianzen für M und F unterschiedlich (Test dafür in Session 9)



// verbundener ttest -> vorher/nachher

webuse bpwide

ttest bp_before==bp_after



// Visualisierung --------------------------------------------------------------

	
//	Einkommensangaben visualisieren ----------------------------------------------------
cd "D:\oCloud\Home-Cloud\Lehre\Methodenseminar\" // wo liegt der Datensatz?
use  "Allbus2018.dta",clear
keep if work == 1 & inc > 0

// t-test für log. Einkommensangaben
gen log_inc = log(inc)
ttest log_inc, by(sex)

ssc install stripplot // ado installieren

// basis plot
stripplot log_inc, over(sex) stack vertical

// marker anpassen, höhe verringern mit width zusammenfassung nebeneinanderliegender Werte verändern
stripplot log_inc, over(sex) stack vertical mcolor("navy %70") msize(small) msymbol(sh) height(0.6)  width(.15)

// Mittelwert und 95% KI hinzufügen
stripplot log_inc, over(sex) stack vertical mcolor("navy %70") msize(small) msymbol(sh) height(0.6) width(.15) ///
	bar

// Mittelwert und 95% KI Optionen
stripplot log_inc, over(sex) stack vertical mcolor("navy %70") msize(small) msymbol(sh) height(0.6) width(.15) ///
	bar(lcolor(black) lwidth(vthin) msize(huge) mean(mcolor(orange) msymbol(o) msize(tiny))) boffset(-0.05)	

stripplot log_inc, over(sex) stack vertical mcolor("navy %60") msize(small) msymbol(sh) height(0.6) width(.15) ///
	bar(lcolor(orange) lwidth(vthin) msize(huge) mean(mcolor(orange) msymbol(o) msize(tiny))) boffset(-0.075) ///
	scheme(plotplain) ytitle("logarithmierte Einkommensangaben") xtitle("") ///
	xlabel(1 "Männer" 2 "Frauen", labsize(medlarge)) ///
	yscale(range(3.8 10)) ///
	title("Einkommensunterschiede zwischen Männern und Frauen 2018") subtitle("arith. Mittel & 95% KI", color(orange)) ///
	caption("Allbus 2018, n = 1477", size(vsmall) pos(5)) aspect(1.25) plotregion(margin(none)) graphregion(margin(none))




