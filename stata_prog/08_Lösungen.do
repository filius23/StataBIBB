* Kapitel 7 - Gewichtung
cd "D:\Datenspeicher\BIBB_BAuA" // wo liegt der Datensatz?
use "BIBBBAuA_2018_suf1.0 - Kopie.dta", clear

* ---------------------- *
*1:  Untersuchen Sie den Zusammenhang zwischen der Wochenarbeitszeit und dem Einkommen der Befragten. Welches Maß ist das richtige?
* ---------------------- *
	mvdecode F518_SUF, mv(99998/99999)
	
*Korrelationskoeffizient
pwcorr F518_SUF az, sig
// (Praktisch) kein Zusammenhang, stat. signifikant

* ---------------------- *
* 
* ---------------------- *
* Vorbereitungen
	recode S3 (2/4 = 1 "Haupt")(5/6 = 2 "mittlere Reife") (7/9 = 3 "(Fach-)Abi") (else = .), into(educ)
	mvdecode F411_01, mv(9)
	
tab educ F411_01	
tab educ F411_01, nol // finale Tabelle
	
spearman educ F411_01 // Rangkorrelation
ktau 	 educ F411_01 // Kendall's tau
tab 	 educ F411_01, gamma // Gamma

* ---------------------- *
* nominal skalierte Variablen: Chi² & Cramér's v
* ---------------------- *
	* Vorbereitungen
	d F103 F228
	tab F103 F228
	tab F103 F228, nol
	mvdecode  F103 F228, mv(9)

tab F103 F228, chi 
tab F103 F228, V
// geringer, signifikanter Zusammenhang