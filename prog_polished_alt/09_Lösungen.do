* Übung1 -------------------------------------------
cd "D:\oCloud\Home-Cloud\Lehre\Methodenseminar\" // wo liegt der Datensatz?
use  "Allbus2018.dta",clear
keep if inc>0 & work == 1

gen log_inc = log(inc)

tabstat log_inc , s(var cv) by(sex)

tabstat inc log_inc, s(var cv) by(sex) // Ausprägung mit dem kleineren Wert hat größere Varianz 

tab sex, nol
gen sex_umgekehrt = 3 - sex 
tab sex sex_umgekehrt

// F- Test
// H0: var(sex==1) <= var(sex == 2) -> ratio <= 1 ; HA: var(sex==1) > var(sex == 2) bzw ratio > 1

sdtest log_inc, by(sex)
sdtest log_inc, by(sex_umgekehrt)


// p-Wert für rechtsseitigen Test ist mit 0.5853 deutlich > .05 --> Varianz bei Männern ist nicht sig. größer



* Übung2 -------------------------------------------
cd "D:\oCloud\Home-Cloud\Lehre\Methodenseminar\" // wo liegt der Datensatz?
use  "Allbus2018.dta",clear
keep if rd01>0 

tab rd01
labelbook rd01
gen nchrist = (rd01 == 5)

tab rd01 nchrist

// Binomialtest, Hypothesen:
// H0: p(nchrist) <= .04 HA: p(nchrist) > .04

bitest nchrist == .04

// wir achten für den rechtsseitigen Test hier auf die 1. Zeile:
 // Pr(k >= 105)             = 0.998996  (one-sided test)
 // --> Anteil nicht-christlicher Konfessionsangehöriger ist nicht statistisch sig. > .04


// Übung3: ANOVA  ----------------------------------------------------------------------
cd "D:\oCloud\Home-Cloud\Lehre\Methodenseminar\" // wo liegt der Datensatz?
use "Allbus2018.dta", clear
mvdecode pt01 pt02 pt03 pt04 pt08 pt12 pt14, mv(-9) // missings raus
egen trust = rowmean(pt01 pt02 pt03 pt04 pt08 pt12 pt14) // Mittelwert über ptXX

oneway trust eastwest, tabulate

ttest trust, by(eastwest)
reg trust i.eastwest

// visualisierung
gen eastwestx = eastwest*3

stripplot trust, over(eastwestx) stack  ///
	mcolor("navy %60") msize(small) msymbol(sh) height(2.5) width(.15) ///
	bar(lcolor(orange) lwidth(vthin) msize(huge) mean(mcolor(orange) msymbol(o) msize(tiny))) boffset(-0.075) ///
	scheme(plotplain) xtitle("Vertrauensindex") ytitle("") ///
	ylabel(3 "Alte BuLä" 6 "Neue BuLä", labsize(medlarge)) ///
	title("Vertrauen in staatl. Institutionen 2018") subtitle("arith. Mittel & 95% KI", color(orange)) ///
	caption("Allbus 2018, n = 3477", size(vsmall) pos(5)) plotregion(margin(none)) graphregion(margin(none))