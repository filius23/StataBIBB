* -------------------------------- *
* Kapitel 8 - Zusammenhangsmaße
* -------------------------------- *
cd "D:\Datenspeicher\BIBB_BAuA" // wo liegt der Datensatz?
use "BIBBBAuA_2018_suf1.0.dta", clear

* ---------------------- *
* metrische Variablen: korrelation
* ---------------------- *
	
	* Vorbereitungen -> . setzen
	mvdecode zpalter, mv(9999)
	replace F231 =  . if F231 > 99

*Korrelationskoeffizient
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
*Indifferenztabelle:
tab F204 S1, nofreq expected
tab F204 S1, chi V

tab F204 S1, V



	mvdecode F204 F228,  mv(9)