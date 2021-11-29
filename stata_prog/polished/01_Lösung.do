* -------------------------------- *
* Session 1: erste Schritte - Lösungen
* -------------------------------- *

*2 ------------
dis 2 * 4
dis 2 / 8
dis 2 ^ 2 // (Potenz)
dis sqrt(9) // (Wurzel)

*3 ------------
pwd
cd "D:\Datenspeicher\BIBB_BAuA/"
use "BIBBBAuA_2018_suf1.0.dta",clear

*4 ------------
describe
browse

*5 ------------
describe, short

*6 ------------
lookfor "kind"
des F1604
browse F1604
browse F1604, nol

* Profi-Aufgabe ---
import spss using "BIBBBAuA_2018_suf1.0.sav", clear