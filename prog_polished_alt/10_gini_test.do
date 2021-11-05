cd D:\oCloud\Home-Cloud\Lehre\Methodenseminar
use "Allbus2018.dta"

mvdecode di05, mv(-50/-1)
fastgini di05
return list

preserve 
keep if eastwest == 1 & !missing(di05)
bootstrap r(gini), nodots reps(2000): fastgini di05
matrix west = r(table)
restore

preserve 
keep if eastwest == 2 & !missing(di05)
bootstrap r(gini), nodots reps(2000): fastgini di05
matrix east = r(table)
restore

matrix list west 
matrix list east

* t-Test
* Test statistic = (Gini_a - Gini_b) / sqrt[ SE(Gini_a) + SE(Gini_a) ]
dis (.31482668-.31012879)/sqrt(.00797458+.00847429)

// t-Test für HA: differenz > 0 --> rechtsseitiger Test mit df = 2-1
dis ttail(2,.03662982)

