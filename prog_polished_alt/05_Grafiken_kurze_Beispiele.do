cd D:\oCloud\Home-Cloud\Lehre\Methodenseminar
use "Allbus_1980-2018.dta", clear
keep if year == 2014
	
	// missings ausschließen
	labelbook lm02 age
	mvdecode lm02 age, mv(-32/-1)
	
	reg lm02 age

 twoway scatter lm02 age
 twoway lfit lm02 age
 twoway (scatter lm02 age) (lfit lm02 age)
 
 twoway ///
 (scatter lm02 age, msize(small) mcolor(eltblue%30)) ///
 (lfit lm02 age, lcolor(orange))
 
 
 
 // kategorial 
 
 cd D:\oCloud\Home-Cloud\Lehre\Methodenseminar
use "Allbus_1980-2018.dta", clear
keep if year == 2016
	
	// missings
	labelbook educ fr03b
	mvdecode educ fr03b, mv(-41/-1 6 7)
 tab educ fr03b
 
 ssc install spineplot
  spineplot fr03b educ  
 spineplot fr03b educ , legend(pos(6) size(vsmall) rows(2))  xlabel(,labsize(small) angle(90) axis(2) )
 
 
 


