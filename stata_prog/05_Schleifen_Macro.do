use "D:\oCloud\Home-Cloud\Lehre\Methodenseminar\Allbus2018.dta", clear


foreach v in lm0? {

    *capture confirm numeric variable `v'
    *if !_rc {

    *label dir
    *labelbook `r(names)'
	labelbook `: value label `v''
    *}

}


return list
dis `r(notused)'


** existiert eine Variable? -----------------------------------
capture confirm  variable lm02
if !_rc dis "ja"
if _rc 	dis	"nein"

** ist variable numerisch?
capture confirm numeric variable lm02
if !_rc dis "ja"
if _rc 	dis	"nein"

** ist variable string?
capture confirm string variable version
if !_rc dis "ja"
if _rc 	dis	"nein"

** schleife aus levelsof  -----------------------------------
levelsof educ, loc(edc)
dis "`edc'"

foreach e in `edc' {
    dis "`e'"	
	tab educ if educ == `e'
}

levelsof educ
return list


* ------------------------- 
mvdecode inc educ lm02 sex, mv(-99/-1)

reg inc i.educ c.lm02##i.sex
ereturn list
est store "`e(cmdline)'"

dis ustrregexra("`e(cmdline)'","\s","")
dis ustrregexra("`e(cmdline)'","\s.*","") // alles nach dem ersten Space
dis ustrregexra("`e(cmdline)'",".","") // alles weg
dis ustrregexra("`e(cmdline)'","\\.","")
 
 
help f_ustrregexm
clear
set obs 1
gen x = ""
replace x = "abcdefghiJKLMN 11123 asdas" in 1
gen t1 = ustrregexs(0) if ustrregexm(x, "\w+")  // first word
gen t1a = ustrregexs(1) if ustrregexm(x, "\w+")  // first word