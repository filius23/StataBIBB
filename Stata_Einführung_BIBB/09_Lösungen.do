* ---------------------- *
* Kapitel 9 - Regressionsmodelle
* Lösungen
* ---------------------- *
	cd "D:\Datenspeicher\BIBB_BAuA" // wo liegt der Datensatz?
	use "BIBBBAuA_2018_suf1.0.dta", clear
	mvdecode zpalter, mv(9999)
	mvdecode m1202,mv(-1)
* ---------------------- *
* 1: Berechnen Sie ein Regressionsmodell mit der Arbeitszeit (`az`) aus der Hauptbeschäftigung als abh. Variable und dem Alter der Befragten (`zpalter`) als unabh. Variable: arbeiten ältere Befragte eher mehr oder eher weniger? Wie ist der Koeffizient zu interpretieren? Was können Sie über die Varianzaufklärung sagen?

reg az zpalter 

// Um 1 Jahr ältere Befragte arbeiten durchschnittlich 0.027 Stunden weniger, der Koeffizient ist statistisch signifikant

* ---------------------- *
* 2: Berechnen Sie ein Regressionsmodell mit der Arbeitszeit (`az`) aus der Hauptbeschäftigung als abh. Variable und der Ausbildung der Befragten (`m1202`) als unabh. Variable: wie sind die Koeffizienten zu interpretieren? 

mvdecode m1202,mv(-1)
reg az i.m1202
tab m1202
tab m1202, nol
margins, at(m1202 = (1 2 3 4))
margins, at(m1202 = (1(1)4) )
marginsplot

 * label bearbeiten
 d m1202
	label define M1202 1 "ohne" 2 "dual" 3 "aufstieg" 4 "uni", replace
 tab m1202
 
 
* Im Vergleich zu Befragten ohne Ausbildungsabschluss arbeiten Befragte mit duale o. schulische Berufsausbildung/einf.,mittl. Beamte  um 2.72h mehr, stat.  signifikant
* Im Vergleich zu Befragten ohne Ausbildungsabschluss arbeiten Befragte mit Aufstiegsfortbildung (Meister, Techniker, kfm. AFB u.ä.)  um 6.33h mehr, stat.  signifikant
* Im Vergleich zu Befragten ohne Ausbildungsabschluss arbeiten Befragte mit         Fachhochschule, Universität/ geh., höhere Beamte  um 5.16h mehr, stat.  signifikant

* ---------------------- *
* 3. Erstellen Sie ein multivariates Modell mit `az` als abhängiger Variable hat und der Ausbildung (`m1202`)  und dem Alter der Befragten (`zpalter`) als unabhängiger Variable.

reg az i.m1202 zpalter

* Bei Konstanthaltung des Alters arbeiten Befragte mit duale o. schulische Berufsausbildung/einf.,mittl. Beamte im Vergleich zu Befragten ohne Ausbildungsabschluss um 3h mehr, stat.  signifikant
* Bei Konstanthaltung des Alters arbeiten arbeiten Befragte mit Aufstiegsfortbildung im Vergleich zu Befragten ohne Ausbildungsabschluss um 6.64h mehr, stat.  signifikant
* Bei Konstanthaltung des Alters arbeiten Befragte mit Fachhochschule, Universität/ geh., höhere Beamte im Vergleich zu Befragten ohne Ausbildungsabschluss arbeiten um 5.47h mehr, stat.  signifikant

* Bei Konstanthaltung des Ausbildungsabschluss geht mit einem um 1 Jahr höheren Lebensalter eine um .039h geringere Arbeitszeit einher, statistisch signifikant


* ---------------------- *
* 4. Verändern Sie das multivariate Modell aus 3. um eine Interaktion zwischen der Ausbildung (`m1202`)  und dem Alter der Befragten (`zpalter`)

reg az i.m1202##c.zpalter

* ---------------------- *
* 5. Erstellen Sie einen `marginsplot` für das Modell aus 4 
margins, at( zpalter = (20(5)65) m1202 = (1(1)3))
marginsplot


	
* ---------------------- *
* marginsplot anpassen
	
	marginsplot, /// 
				graphregion(fcolor(white)) /// Hintergundfarbe (außerhalb des eigentlichen Plots)
                plot1(color("57 65 101")  msize(small)) /// Farbe & Größe für erste Gruppe
				ci1opts(color("57 65 101")) /// Farbe für Konfidenzintervalle der ersten Gruppe
				plot2(color("177 147 74") msize(small)) ///
				ci2opts(color("177 147 74")) /// 
				plot3(color("16 15 20")   msize(small)) /// 
				ci3opts(color("16 15 20")) /// 
                legend(cols(1) region(color(white) fcolor(white))  )   /// Spaltenzahl, Rahmen- & Hintergrundfarbe für Legende
				xtitle("vertragl. vereinb. Arbeitsstunden") /// Achsentitel
				ylabel(,angle(0)) /// Achen
                ytitle("Einkommen (F518_SUF)") /// 
				title("Titel") ///
                subtitle("Untertitel") ///
                caption("{it:Quelle: Erwerbstätigenbefragung 2018}", size(8pt) position(5) ring(5) )
	graph export "C:\einen\Pfad/angeben/mplot4.png", replace /// speichern png-Datei
	