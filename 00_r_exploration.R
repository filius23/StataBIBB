if(Sys.getenv("USERNAME") == "Filser" ) .libPaths("D:/R-library4")  # set library
library(tidyverse)
baua <- haven::read_dta("D:/Datenspeicher/BIBB_BAuA/BIBBBAuA_2018_suf1.0.dta")
baua2 <- readstata13::read.dta13("D:/Datenspeicher/BIBB_BAuA/BIBBBAuA_2018_suf1.0.dta",convert.factors = F)

baua %>% select(where(function(x) sum(is.na(x)) / length(x) < 0.5))


baua2 %>% select(where(function(x) sum(as.numeric(x) == 9999) > 0 ))

xt <- baua2 %>% summarise(across(everything(), ~sum(as.numeric(.x) %in% c(9999,-4:-1)) > 0 ))  %>% 
  t(.) %>% data.frame(.) %>% rownames_to_column(.,var = "var") %>% janitor::clean_names() %>% tibble() %>% filter(x)


labs <- baua %>% map(.,~attributes(.x)$label) %>% bind_rows(.) %>% 
  t(.) %>% data.frame() %>% rownames_to_column(.,var = "var") %>% janitor::clean_names() %>% tibble() 
ndis <- 
  baua2 %>% summarise(across(everything(), ~length(unique(.x)  )) )  %>% 
  t(.) %>% data.frame(ndis = .) %>% rownames_to_column(.,var = "var") %>% janitor::clean_names() %>% tibble() 


ndis %>% left_join(labs, by ="var") %>% 
  arrange(ndis) %>% filter(ndis %in% 3:5) %>% print(.,n=Inf)




xt <- baua2 %>% summarise(across(everything(), ~sum(as.numeric(.x) %in% c(9999)) > 0 ))  %>% 
  t(.) %>% data.frame(.) %>% rownames_to_column(.,var = "var") %>% janitor::clean_names() %>% tibble() %>% filter(x)




  

unique(baua$zpalter) %>% length(.)



#run render in background -------------------
 bookdown::preview_chapter("09_mreg.Rmd")

rm(baua)
chap <- "09_mreg.Rmd"
rstudioapi::jobRunScript(path = "00_build.R",importEnv = T)


# befehle ----
knitr::purl(input = "07_gewichtung.Rmd",output = "./stata_prog/07_Befehle.do")