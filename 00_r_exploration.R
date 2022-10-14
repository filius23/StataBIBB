if(Sys.getenv("USERNAME") == "filse" ) .libPaths("D:/R-library4")  # set library
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


install.packages(c('gganimate','sf'),lib = "D:/R-library4")

  

unique(baua$zpalter) %>% length(.)



#run render in background -------------------
 bookdown::preview_chapter("00_build.R")

rm(baua)
chap <- "09_mreg.Rmd"
chp1 <- c('index.Rmd','01-IntroI.Rmd','02-Datensaetze.Rmd','03_Deskription.Rmd','04_if_label.Rmd','05_gen.Rmd','06_egen.Rmd','07_gewichtung.Rmd',
          '08_zshg.Rmd', '09_mreg.Rmd',
          '21_bgregression.Rmd',
          '22_anova.Rmd',
          '30_literatur.Rmd',
          '31_appendix.Rmd')


map(1:length(chp1), function(x){
  chap <- chp1[x]
  rstudioapi::jobRunScript(path = "00_build.R",importEnv = T) 
  Sys.sleep(60*3)
})


# befehle ----
knitr::purl(input = "07_gewichtung.Rmd",output = "./stata_prog/07_Befehle.do")


pagedown::chrome_print(rmarkdown::render('../pdf/StataBIBB1.Rmd'))