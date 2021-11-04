

// Übung1 ----------------
clear
set obs 50
set seed 0441
gen height_sample1 =  rnormal(170,9.26)

tabstat height_sample1, s(mean sd n)

// Hier: beidseitiger Test weil vermuteter *Unterschied*!

// H0: µ = 172, HA: µ != 172

// per Hand!

// t-Wert berechnen:
dis (170.4774 - 172) / (8.513443 / sqrt(50))
// p-Wert für eine Seite berechnen
display 1-ttail(49,  -1.2646362 ) // 1- weil ttail "von rechts schaut"

// beidseitiger Test --> p-Wert *2
display (1-ttail(49,  -1.2646362 )) * 2
display (1-ttail(49,  (170.4774 - 172) / (8.513443 / sqrt(50))) ) * 2  // alles auf einmal in einem Befehl

// mit ttest
ttest height_sample1 == 172

// beidseitiger Test ergibt p >> 0.05 --> H0 beibehalten, keine sig. Differenz zu 172

// Übung 2 -----------------------------------

cd "D:\oCloud\Home-Cloud\Lehre\Methodenseminar\" // wo liegt der Datensatz?
use  "Allbus2018.dta",clear
keep if work == 1 & inc > 0

gen log_inc = log(inc)

	tabstat log_inc, s(mean var) by(eastwest) // 
	// unequal, weil varianzen für M und F unterschiedlich (Test dafür in Session 9)
	
	// Hypothese "höher" --> rechtsseitiger Test
	// H0 log_inc(west) <= log_inc(east); HA: log_inc(west) > log_inc(east)
ttest log_inc, by(eastwest)  unequal
	//  --> rechte Spalte: p << 0,05 --> einkommen in West sig. höher als in Ost


	
	
// Übung 3-----------------------------------
// verbundener ttest -> vorher/nachher
webuse fuel,clear
browse
ttest mpg1 == mpg2



// weitere Übungen -------------------------------------------------------------

// 4 ****************
	clear
	set obs 50
	set seed 0441
	gen height_sample2 =  rnormal(173,6.15)
	tabstat height_sample2, s(mean sd n)
// "größer" --> rechtsseitiger Test
// H0: height <= 173 HA: height > 173
	ttest height_sample2 == 173
// hier ist der rechtsseitige Test ausschlaggebend -> p-Wert =  0.3467, also H0 beibehalten, SP-Wert ist nicht sig. höher 
	
	
// 5 ****************	
 cd "D:\oCloud\Home-Cloud\Lehre\Methodenseminar\" // wo liegt der Datensatz?
use "Allbus_1980-2018.dta", clear
replace inc = . if inc <0 
keep if year == 2018  & work == 1 & inc > 0

gen log_inc = log(inc)
// Unterschied --> beiseitiger Test
// H0: log(inc) == 7.6 HA: log(inc) != 7.6

ttest log_inc == 7.6

// da der p-Wert = 0.0559 und damit größer 0,05 können wir die H0 nicht verwerfen --> kein Hinweis dass der Experte unrecht hatte
	

// 6 ****************		
 cd "D:\oCloud\Home-Cloud\Lehre\Methodenseminar\" // wo liegt der Datensatz?
use "Allbus_1980-2018.dta", clear
keep if inrange(yborn,1960,1979)
mvdecode dg12, mv(-51/-1)

gen b70s = (yborn > 1969)
tab yborn b70s

// H0: dg12(60s) >=  dg12(70s)  HA: dg12(60s) <  dg12(70s)

ttest dg12, by(b70s)

// der linksseitige Test ergibt einen p-Wert von Pr(T < t) = 0.9417 --> 60er geborene sind nicht sig. früher ausgezogen
	
// 7 ***********************
 cd "D:\oCloud\Home-Cloud\Lehre\Methodenseminar\" // wo liegt der Datensatz?
use "Allbus_1980-2018.dta", clear
keep if year == 2014 & hs18 > 0 & hs16>0 & sex == 2

d hs18 hs16

tabstat hs16, s(median) 
gen tall = (hs16 > 160)

tab hs16 tall // kontrolle

// H0: bmi(tall) <= bmi(small) HA: bmi(tall) > bmi(small)

ttest hs18, by(tall)

// rechtsseitige Test (Ha: diff > 0) ergibt Pr(T > t) = 0.0000 --> größere Frauen haben einen höheren BMI



