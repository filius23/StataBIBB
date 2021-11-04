* -------------------------- *
* weitere Tests
* -------------------------- *


* F-Test ------------------------------------------------------------------
cd "D:\oCloud\Home-Cloud\Lehre\Methodenseminar\" // wo liegt der Datensatz?
use  "Allbus_1980-2018.dta",clear
keep  if year == 2014 & hs16 > 0
tabstat hs16, s(var cv) by(sex)

// F-Wert per hand:
	dis 51.55268 / 42.40775 //var(m) / var(f)


	sdtest hs16, by(sex)
// rechtsseitiger Test (rechte Spalte) --> p << 0,05 -> Varianz bei M größer




* binomial test ------------------------------------------------------------
cd "D:\oCloud\Home-Cloud\Lehre\Methodenseminar\" // wo liegt der Datensatz?
use  "Allbus_1980-2018.dta",clear
keep  if year == 2014 & aq03>0
gen pet = (aq03 == 4)
tab aq03 pet

bitest pet == .67
//  Pr(k >= 2374)              = 0.033408  (one-sided test) --> Anteil ist sig. höher (rechtss.)
//  Pr(k <= 2374)              = 0.969210  (one-sided test) --> Anteil ist nicht sig. niedriger (linkss.)
//  Pr(k <= 2271 or k >= 2374) = 0.065472  (two-sided test) --> Anteil ist nicht sig. *verschieden* (beidseitiger Test)



* chi² -----------------------------------------------------------------------
cd "D:\oCloud\Home-Cloud\Lehre\Methodenseminar\" // wo liegt der Datensatz?
use  "Allbus_1980-2018.dta",clear
keep  if year == 2014 & aq03>0
gen pet = (aq03 == 4)

tab sex pet, chi // p<<<0,05 --> sig. Zusammenhang


* t-tests in Regressionen ---------------------
cd D:\oCloud\Home-Cloud\Lehre\Methodenseminar
use "Allbus_1980-2018.dta", clear
keep if year == 2014
mvdecode lm02 age, mv(-32/-1)
reg lm02 age



* ANOVA -----------------------
cd "D:\oCloud\Home-Cloud\Lehre\Methodenseminar\" // wo liegt der Datensatz?
use Allbus2018.dta, clear
keep if inc > 0 &  educ > 0vn	

* ANOVA mit 2 Gruppen
oneway inc sex, tabulate
dis  (506278204/ 5.3905e+09) // R² berechnen

ttest inc, by(sex) unequ
reg inc i.sex

* ANOVA mit mehreren Gruppen
oneway inc educ, tabulate
reg inc i.educ
dis (492795287 /  5.3905e+09) // R² per hand

reg inc ib3.educ


