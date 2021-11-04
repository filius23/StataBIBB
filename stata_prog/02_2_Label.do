use "D:\oCloud\Home-Cloud\Lehre\Methodenseminar\Allbus2018.dta", clear


return list



return list


mvdecode lm02,mv(-99/-1)
labelbook lm02, problems
lab def lm02 -7 "test", add 
return list

labelbook educ
return list
labelbook educ, detail
drop if educ == 4


help labelbook

lab def educ -7 "test", add 
lab def educ -7 "test2", add 
lab def educ -7 "test2", modify 

dis `r(notused)'

* Zahlencodes einfügen .-------------
numlabel educ, add
tab educ
numlabel educ, remove
tab educ




help labelbook
