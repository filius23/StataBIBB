
* Übung 5-1 --------------------------------------------------------------------
cd D:\oCloud\Home-Cloud\Lehre\Methodenseminar
use "Allbus_1980-2018.dta", clear
keep if year == 2014
	
	// missings ausschließen
	labelbook lm02 age
	mvdecode lm02 age, mv(-32/-1)
	// kontrolle:
	summarize  lm02 age
	
	// zwei metrische Merkmale -> pearson correlation
	corr lm02 age 
	// --> .22, also schwacher Zusammenhang
	
	// vorhersage: regressionsmodell
	reg lm02 age
	
// vorhergesagte Werte 
	// 50
	display 95.58535+1.16511*50 // welcher Wert würde für age = 50 vorhergesagt?
	display 95.58535+1.16511*51 // welcher Wert würde für age = 51 vorhergesagt?
	display 95.58535+1.16511*52 // welcher Wert würde für age = 52 vorhergesagt?
	
	// entspricht genau dem Koeffizienten für age (notwendigerweise):
	display (95.58535+1.16511*51) - (95.58535+1.16511*50)
	display (95.58535+1.16511*52) - (95.58535+1.16511*51)
	
// das gleiche ohne Abtippen:
	reg lm02 age
	display _b[_cons] + _b[age] * 50
	display _b[_cons] + _b[age] * 51
	display _b[_cons] + _b[age] * 52
	
	display (_b[_cons] + _b[age] * 52) - (_b[_cons] + _b[age] * 51)
	

	
// Übung 5-2 -------------------------------------------------------------------	
cd D:\oCloud\Home-Cloud\Lehre\Methodenseminar
use "Allbus_1980-2018.dta", clear
keep if year == 2016
	
	// missings
	labelbook educ fr03b
	mvdecode educ fr03b, mv(-41/-1 6 7)
	// oder:
	drop if educ < 0 | educ > 5 | fr03b < 0
	keep if inrange(educ,0,5) & fr03b > 0
	
	// Kontrolle:
	tab educ fr03b
	
	spearman educ fr03b // --> (gerade) noch geringer Zusammenhang
	// je höher educ, desto höher fr03b --> je höher Bildung desto höher Ablehnung
	
	ktau  educ fr03b // --> deutlich schwächer
	tab educ fr03b, gamma // stärkster Zusammenhang weil ties (uneindeutige Fälle) einfach ignoriert werden
	
	
	// übrigens: Zusammenhang ist im Westen deutlich stärker:
	spearman educ fr03b if eastwest == 1 
	spearman educ fr03b if eastwest == 2

	
// Übung 5-3 -------------------------------------------------------------------	
cd D:\oCloud\Home-Cloud\Lehre\Methodenseminar
use "Allbus2018.dta", clear
	
	// missings
	mvdecode cf01 gkpol dh01, mv(-50/-1)
	//	oder 
	drop if cf01 < 0 | gkpol < 0

// Odds Ratio:
tab cf01 sex	
dis (554/1116) / (196/1565)
// --> Frauen haben 3.963728-fache Odds/Chance, sich nachts in der Umgebung unsicher zu fühlen	
	
// PHI:
	tab cf01 sex, chi
	dis sqrt( 243.8395 / 3431) // --> mittlerer Zusammenhang laut Definition oben
	

	
// Übung 5-4 -------------------------------------------------------------------
cd D:\oCloud\Home-Cloud\Lehre\Methodenseminar
use "Allbus_1980-2018.dta", clear
keep if year == 2014

	mvdecode hs18 inc, mv(-50/-1)
	
	corr  hs18 inc // --> kein Zusammenhang
	
	
// Übung 5-5 -------------------------------------------------------------------
cd D:\oCloud\Home-Cloud\Lehre\Methodenseminar
use "Allbus2018.dta", clear
	
	mvdecode gkpol px01, mv(-50/-1)
	
	spearman gkpol px01 // --> negativer Zusammenhang (aber gering)
	// --> je größer Wohnort, desto geringer die zustimmung
	ktau gkpol px01
	
	
// Übung 5-6 -------------------------------------------------------------------
cd D:\oCloud\Home-Cloud\Lehre\Methodenseminar
use "Allbus2018.dta", clear
	keep if sex == 2
	
	mvdecode gkpol cf01, mv(-50/-1)
		
	// Odds für unsicher 5000-19.999 vs 500.000 + :
	dis (109/356) / (89/154)
	// --> Frauen in Orten mit 5000-19999 haben .5297942-fache Odds/Chance, sich nachts in der Umgebung unsicher zu fühlen	im Vgl zu Frauen aus Großstädten mit > 500.000 Einwohnern
	
	tab cf01 gkpol, chi
	dis sqrt(87.1169/1637)
	// geringer Zusammenhang
	
	
	
	
	
	