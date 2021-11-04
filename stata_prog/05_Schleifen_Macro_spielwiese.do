use "D:\oCloud\Home-Cloud\Lehre\Methodenseminar\Allbus2018.dta", clear

* "future you"


* Zeilen zusammenklappen

{ // hier steht ganz viel syntax
    * hier
	* steht 
	* ganz 
	* viel 
	* syntax
}

* https://data.princeton.edu/stata/programming
* https://www.stata.com/netcourse/writing-own-commands-nc251/
do DoFile s 1

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


** existiert eine Variable?
capture confirm  variable lm02
if !_rc dis "ja"
if _rc 	dis	"nein"

** ist variable numerisch?
capture confirm numeric variable lm02
if !_rc dis "ja"
if _rc 	dis	"nein"

**ist sie 

str18 

foreach i of varlist sin3* {
	local longlabel: var label `i'
	local shortlabel = substr("`longlabel'",1,12)
	label var `i' "`shortlabel'"
}


// mapply pendant
local nlist 2002 2002 2004 2012 
local ilist 26 27 28 29 
local jlist 23 22 21 20 

forval m = 1/4 { 
    gettoken n nlist : nlist 
    gettoken i ilist : ilist 
    gettoken j jlist : jlist 
	di "n = " `n' " i = " `i' " j = " `j'
}

// tokenize

local listname "age educ inc"
tokenize `listname'
mac li

tokenize some words
di "1=|`1'|, 2=|`2'|, 3=|`3'|" // 3 ist leer ->


// program define
which hi
hi Sandy
hi Sandy und Andreas
hi "Sandy und Andreas" 

dis "asd" "sad"


// value labels kopieren & dann anpassen






* ================== *
* verzeichnisse verwalten
* mkdir
* list files .....


