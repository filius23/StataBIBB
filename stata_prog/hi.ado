capture program drop hi
*! test display
program define hi
	     args var1
	*dis "Hello and welcome, `var1'"
	dis "Hello and welcome," "`var1'"

end
		