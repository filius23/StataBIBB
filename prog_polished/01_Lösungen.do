
// Übungen 1 -------------------------------------------------------------------

display 2 * 4
display 2 / 8
display 2 ^ sqrt(4) + 5

// Lesen Sie den Allbus 2018 in Stata ein.
  // In welchem Arbeitsverzeichnis befinden Sie sich aktuell?

pwd // aktuelles Verzeichnis

  // In welchem Ordner haben Sie die Datensätze aus ILIAS abgelegt? Navigieren Sie Stata mit `cd` in eben diesen Ordner, in dem die Datensätze abgelegt sind!
cd "D:\oCloud\Home-Cloud\Lehre\Methodenseminar" // wo liegt der Datensatz?
use "Allbus2018.dta"

  // Nutzen Sie `describe` und `browse`, um sich einen Überblick über den Datensatz zu verschaffen.
describe,s
browse

  // Wie viele Variablen und wie viele Fälle enthält der Datensatz?
describe,s
// 3477 (obs) --> Zeilen , 708 vars --> Variablen

  // Unter welchem Variablennamen ist die Parteipräferenz der Befragten ablegt?
lookfor "partei"  
describe pa04 
 
  // Lassen Sie sich diese Variable im Datenexplorer mit `browse` anzeigen.
browse pa04
  // Lassen Sie sich die gleiche Anzeige mit den Zahlencodes anzeigen.
browse pa04, nol
  // Welche Information ist in der Variable `respid` abgelegt? 
desc respid
  // Wie können Sie sich die Zeile anzeigen lassen, welche den/die Befragte*n mit der `respid` 3469 enthält?
bro if respid == 3469
list if respid == 3469
  // Wie alt ist der/die Befragte mit der `respid` 3469? Welches Geschlecht und welche Wahlabsicht hat die Person angegeben? Tipp: Das Alter ist in `age` ablegt, die Absicht in `pv01`.
bro respid age pv01 if respid == 3469
list respid age pv01 if respid == 3469
  
  
// Profi Übungen ---------------------------------------------------------------
// csv-import
import delimited "Allbus2018.csv",  varnames(1) clear 
// spss import
import spss using "Allbus2018.sav", clear

 
 



