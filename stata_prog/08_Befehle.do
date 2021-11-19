* Kapitel 7 - Gewichtung
cd "D:\Datenspeicher\BIBB_BAuA" // wo liegt der Datensatz?
use "BIBBBAuA_2018_suf1.0 - Kopie.dta", clear
mvdecode zpalter, mv(9999)
replace F231 =  . if F231 > 99

* ---------------------- *
* metrische Variablen: korrelation
* ---------------------- *
pwcorr zpalter F231, sig

* ---------------------- *
* ordinal skalierte Variablen: Rangkorrelation & Konkordanzmaße 
* ---------------------- *
* Vorbereitungen
	tab S3, nol
	mvdecode S3, mv(1 10/12 99)
	tab S3
	tab S3, nol
	cap drop educ
	recode S3 (2/4 = 1 "Haupt")(5/6 = 2 "mittlere Reife") (7/9 = 3 "(Fach-)Abi"), into(educ)
	tab educ

	tab F600_12
	tab F600_12, nol
	mvdecode F600_12, mv(9)

tab F600_12 educ // finale Tabelle
	
spearman F600_12 educ // Rangkorrelation
ktau F600_12 educ // Kendall's tau
tab F600_12 educ, gamma // Gamma

* ---------------------- *
* nominal skalierte Variablen: Chi² & Cramér's v
* ---------------------- *
	* Vorbereitungen
	tab F204, nol
	mvdecode F204, mv(9)

tab F204 S1, chi 
tab F204 S1, V
