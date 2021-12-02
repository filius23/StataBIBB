use "BIBBBAuA_2018_suf1.0.dta", clear // hier steht die Datei
summarize zpalter

	preserve
	mvdecode zpalter, mv(9999)
	summarize zpalter
	restore 

summarize zpalter