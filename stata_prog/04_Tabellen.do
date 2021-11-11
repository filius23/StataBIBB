use "D:\oCloud\Home-Cloud\Lehre\Methodenseminar\Allbus2018.dta", clear


* tabellenexport

* https://www.youtube.com/watch?v=su7kVsxF-uc



stats(N x_mean r2 r2_a,

label("Observations" "Mean treatment" "R-squared" "Adj. R-squared"))
se noconstant noabbrev nomtitles
mgroups("Log new highly educated apprentices", pattern(1 0 0))