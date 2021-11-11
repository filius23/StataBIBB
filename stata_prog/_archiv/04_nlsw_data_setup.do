set seed 14921918
sysuse nlsw88, clear

la var union "Member of a union"
la def union 0 "Not a union member" ///
	1 "Union member", modify
la val union union

la var south "Location"
la def south 0 "Does not live in the South" ///
	1 "Lives in the South", modify
la val south south

la var race "Race"
la def race 1 "White" 2 "Black" ///
	3 "Other", modify
la val race race

la var collgrad "Education"
la def collgrad 0 "Not college graduate"  ///
	1 "College graduate", modify
la val collgrad collgrad

la var married "Marital status"
la def married 0 "Single" 1 "Married", modify
la val married married

gen wt = 10 * runiform()
gen int fwt = ceil(wt)

gen inc = 1000 * runiform()
gen income = cond(inc < 300, inc + 360, inc +200)
la var income "Income"

gen sex = cond(wt<5, 1, 2)
la var sex "Sex"
la def sex 1 "Male" 2 "Female", modify
replace sex = cond(wt<0.5, ., sex)
la val sex sex

gen pregnant = cond(wt>8.5, 1, 2)
la var pregnant "Currently pregnant"
la def pregnant 1 "Pregnant" 2 "Not pregnant" ///
	, modify
replace pregnant = cond(sex==1, ., pregnant)
la val pregnant pregnant

la var industry "Industry"
la var occupation "Occupation"
