* ---------------------- *
* Kapitel 9 - Regressionsmodelle
* ---------------------- *

* ---------------------- *
* zwei metrische Variablen
use "https://github.com/filius23/Stata_Skript/raw/master/regression_bsp.dta", clear
scatter var1 var2


* ---------------------- *
* kategoriale unabh. Variablen
	cd "D:\Datenspeicher\BIBB_BAuA" // wo liegt der Datensatz?
	use "BIBBBAuA_2018_suf1.0.dta", clear
	mvdecode F518_SUF, mv(99998/99999)

reg F518_SUF i.S1 // i.  für kategoriale Variablen
// gleiches Ergebnis:
	reg F518_SUF S1
	ttest F518_SUF, by(S1) 

* ---------------------- *
* mehrere Kategorien in der UV:
recode S3 (2/4 = 1 "Haupt")(5/6 = 2 "mittlere Reife") (7/9 = 3 "(Fach-)Abi") (else = .), into(educ)
tab S3 educ , m

reg F518_SUF i.educ

* ---------------------- *
* mehrere unabh. Variablen
		
	* Kontrollvariablen
	mvdecode F200, mv(97/99)
	reg F518_SUF i.educ F200 
	su F200
	margins, at( F200 = (15(5)45) educ = (1(1)3))
	marginsplot
	
	* Interaktion zwischen educ und F200
	reg F518_SUF i.educ##c.F200 // 
	margins, at( F200 = (15(5)45) educ = (1(1)3))
	marginsplot
	
	* nicht-linearer Verlauf für F200 -> quadratischer Term
	reg F518_SUF i.educ c.F200##c.F200
	margins, at( F200 = (15(5)45) educ = (1(1)3))
	marginsplot
	
* ---------------------- *
* marginsplot anpassen
	
	marginsplot, /// scheme(s1mono)  ///
				graphregion(fcolor(white)) /// Hintergundfarbe (außerhalb des eigentlichen Plots)
                plot1(color("57 65 101")  msize(small)) /// Farbe & Größe für erste Gruppe
				ci1opts(color("57 65 101")) /// Farbe für Konfidenzintervalle der ersten Gruppe
				plot2(color("177 147 74") msize(small)) ///
				ci2opts(color("177 147 74")) /// 
				plot3(color("16 15 20")   msize(small)) /// 
				ci3opts(color("16 15 20")) /// 
                legend(cols(3) region(color(white) fcolor(white))  )   /// Spaltenzahl, Rahmen- & Hintergrundfarbe für Legende
				xtitle("vertragl. vereinb. Arbeitsstunden") /// Achsentitel
				ylabel(,angle(0)) /// Achen
                ytitle("Einkommen (F518_SUF)") /// 
				title("Titel") ///
                subtitle("Untertitel") ///
                caption("{it:Quelle: Erwerbstätigenbefragung 2018}", size(8pt) position(5) ring(5) )
	graph export "C:\einen\Pfad/angeben/mplot4.png", replace /// speichern png-Datei
	