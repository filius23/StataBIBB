cd "D:\oCloud\Home-Cloud\Lehre\BIBB\StataBIBB\stata_prog"

sysuse cancer, clear
label variable died "Patient died"
label define ny 0 "No" 1 "Yes", modify
label value died ny

recode studytime (min/10 = 1 "10 or less months") ///
		(11/20 = 2 "11 to 20 months") ///
		(21/30 = 3 "21 to 30 months") ///
		(31/max = 4 "31 or more months") ///
		, gen(stime)

label variable stime "To died or exp. end"
tabout stime died using table2.tex, ///
	cells(freq col cum) format(0 1) clab(No. Col_% Cum_%) ///
	replace ///
	style(tex) bt cl1(2-10) cl2(2-4 5-7 8-10) font(bold) ///
	topf(top.tex) botf(bot.tex) topstr(14cm) botstr(cancer.dta)
	
help tabout	
	
tabout stime died , ///
	cells(freq col cum) format(0 1) clab(No. Col_% Cum_%) 
	
	
	
asdoc tabulate occupation, replace	

tabout stime died  using table2.htm

c(row ci) svy f(3) ///
style(htm) stats(chi2) body font(bold) npos(col) cisep(-) ///
family(Arial) dropc(6) title(Table 2: My second table) ///
fn(Some more useful information, perhaps about the sample design)


tabout race sex diabetes using table2.htm, c(row ci) svy f(3) ///
style(htm) stats(chi2) body font(bold) npos(col) cisep(-) ///
dropc(6) title(Table 2: My second table) ///
fn(Some more useful information, perhaps about the sample design)



// http://tabout.net.au/docs/code.php
do 04_nlsw_data_setup.do
which tabout3
tabout3 south race union sex using table1.htm, replace  c(freq col) f(0c 1)


tabout south race union sex using table1.docx, ///
replace  c(freq col) f(0c 1) ///
style(docx) font(bold)

  ///
title(Table 1: A Simple Example) ///
fn(Source: nlsw88.dta) open



sysuse auto, clear
egen mileage=cut(mpg), group(10)
outreg2 mileage foreign using x.doc, replace cross



reg mpg i.foreign
est store m1
reg mpg i.foreign length
est store m2

esttab m1 m2, label refcat(0.foreign "Domestic")
esttab m1 m2, label refcat(0.foreign "Domestic", label("ReFeReNz") )

 esttab m1 m2, refcat(foreign "Main effects:" turn "Controls:", nolabel) wide label

esttab m1 m2,  refcat(0.foreign "Domestic", label("*ref.*"))



est clear
sysuse cancer, clear
stset studytime, failure(died)
xi: stcox age i.drug, nolog
esttab, eform wide nostar 
esttab, eform wide label nostar refcat(_Idrug_2 "Placebo")