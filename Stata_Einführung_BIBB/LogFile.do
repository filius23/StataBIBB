


log using "D:\oCloud\Home-Cloud\Lehre\BIBB\StataBIBB1\Stata_Einführung_BIBB/logfile.txt", text replace // mit replace wird die Datei ggf überschrieben
* ------------------------------------------------ *
* Alter, Bildung, Geschlecht in der ETB 2018
* ------------------------------------------------ *
global data "D:\Datenspeicher\BIBB_BAuA/"
use "${data}/BIBBBAuA_2018_suf1.0.dta", clear
mvdecode zpalter, mv(9999)	  // dieses log enthält auch kommentare
mvdecode m1202,mv(-1)   // noch einen 

* ------------------------ *
* Auswertung
* ------------------------ *
tab m1202 S1
su zpalter 

log close