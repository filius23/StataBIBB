// Ergebnisexport


// Protokollieren: log file
cd  D:\oCloud\Home-Cloud\Lehre\Methodenseminar
log using "logfile.txt", text replace // mit replace wird die Datei ggf überschrieben
cd D:\oCloud\Home-Cloud\Lehre\Methodenseminar
use "Allbus2018.dta", clear
mvdecode gkpol, mv(-34)
tab gkpol sex
mvdecode age, mv(-32) // dieses log enthält auch kommentare
su age
log close

ssc install estout
// Tabellen exportieren mit esttab
cd D:\oCloud\Home-Cloud\Lehre\Methodenseminar
use "Allbus2018.dta", clear
mvdecode gkpol, mv(-34)
tab gkpol sex

/// kontingenztabellen ---------------------------------------------------------
	estpost tab  gkpol sex
	eststo tabelle1 // unter tabelle1 ablegen
	
	tab sex eastwest
	estpost tab  sex eastwest
	eststo tabelle2 // unter tabelle2 ablegen
	
	esttab tabelle1
	esttab tabelle1, unstack noobs nonumbers nonotes
	
	
	esttab tabelle1 using tabelle1.rtf, unstack noobs nonotes nonumbers replace
	
	
	
	
	cd  D:\oCloud\Home-Cloud\Lehre\Methodenseminar
	
	esttab tabelle1 using tabelle1.csv, unstack noobs nonotes nonumbers replace scsv
	
	// Zellen-, Spalten- oder Zeilenprozente nicht in tab angeben, sondern erst in esttab:
	esttab tabelle1, cell(pct) unstack noobs nonumbers nonotes // -> Zellenprozente
	esttab tabelle1, cell(colpct) unstack noobs nonumbers nonotes // Spaltenprozt
	esttab tabelle1, cell(rowpct) unstack noobs nonumbers nonotes   // Zeilenprozt
	esttab tabelle1, cell(rowpct) unstack noobs nonumbers nonotes collabels(none) label  // kein "rowpct" in den Spalten
	esttab tabelle1 using tabelle1_zeilenprozente.rtf, cell(rowpct) unstack noobs nonumbers nonotes collabels(none) replace // replace -> überschreibt auch existierende Datei
	

/// tabstat --------------------------------------------------------------------
	cd D:\oCloud\Home-Cloud\Lehre\Methodenseminar
	use "Allbus2018.dta", clear
	mvdecode age inc lm02, mv(-50/-1)
	tabstat  age inc lm02, s(mean sd p50 count)
	
	
	estpost tabstat  age inc lm02,  statistics(mean sd p50 count) listwise  columns(statistics)
	eststo tabstat1
	// achtung! count sind hier nur Beobachtungen, die auf keiner Variable missing sind!
	esttab tabstat1, cells(mean sd) // kennzahlen untereinander
	esttab tabstat1, cells("mean p50 sd count") // nebeneinander mit ""
	esttab tabstat1, cells("mean(label(arith. Mittel)) sd count") noobs nonumber nomtitle  // nebeneinander mit ""
	
	// Zahlen runden:
	esttab tabstat1 using summary1.rtf, cells("mean(label(arith. Mittel) fmt(3)) sd(fmt(5)) count(fmt(0))") noobs nonumber nomtitle replace // 
	
	
	// export mit using...
	esttab tabstat1 using summary1.rtf, cells("mean(label(arith. Mittel)) sd count") noobs nonumber nomtitle  // nebeneinander mit ""

	
/// ttest 

cd "D:\oCloud\Home-Cloud\Lehre\Methodenseminar\" // wo liegt der Datensatz?
use  "Allbus2018.dta",clear
keep if work == 1 & inc > 0	
ttest inc, by(sex)

 estpost ttest inc, by(sex)
 est store ttest1
 esttab ttest1, nonumber nomtitle noobs nonumber ///
 cells("b(star) t p mu_1 mu_2 N_1 N_2")  
 
 esttab ttest1, nonumber nomtitle noobs ///
 cells("b(label(Differenz) star) t p mu_1(label(Männer)) mu_2(label(Frauen))  N_1(label(N(Männer))) N_2(label(N(Frauen)))") nonumber 
 
  esttab ttest1 using ttest.rtf, nonumber nomtitle noobs ///
 cells("b(label(Differenz) star) t p N_1(label(N(Männer))) N_2(label(N(Frauen)))") nonumber  replace
 
 
 esttab ttest1, nonumber nomtitle noobs 	 
 esttab ttest1, noobs cells("b(star fmt(4)) se(fmt(4)) count(fmt(0))") star(* 0.1 ** .05 *** 0.01) 

 
// https://www.ssc.wisc.edu/sscc/pubs/stata_tables.htm	








