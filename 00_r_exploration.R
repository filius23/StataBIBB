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



xt <- baua2 %>% summarise(across(everything(), ~sum(as.numeric(.x) %in% c(9999)) > 0 ))  %>% 
  t(.) %>% data.frame(.) %>% rownames_to_column(.,var = "var") %>% janitor::clean_names() %>% tibble() %>% filter(x)




ndis <- 
  baua2 %>% summarise(across(everything(), ~length(unique(.x)  )) )  %>% 
  t(.) %>% data.frame(ndis = .) %>% rownames_to_column(.,var = "var") %>% janitor::clean_names() %>% tibble() 


xt %>% left_join(ndis) %>% left_join(labs, by ="var") %>% 
  arrange(ndis) %>% filter(ndis %in% 3:5) %>% print(.,n=Inf)



unique(baua$zpalter) %>% length(.)


# schiefe ---------

paletteer::paletteer_d("dutchmasters::pearl_earring")

sk_df <-  
  data.frame(x= 1:10) %>%
  mutate(y1 = round(4/x*4)+ 2,
         y2 = round(4*x/4)+ 2,
         y3 = as.numeric(round(20 - abs(scale(x))*9.5)),
         y4 = 5) %>% 
  bind_rows(data.frame(x=0,y1=12,y2=2,y3=1,y4=5),
            data.frame(x=11,y1=2,y2=9,y3=1,y4=5))

  sk_df %>% 
  ggplot(aes(x=x,y=y3)) +
  geom_col(color = "grey25", fill = NA) +
  coord_cartesian(ylim=c(0,19))


  sk_df %>% uncount(weights = y3) %>% pull(x) %>% moments::kurtosis(.)
  sk_df %>% uncount(weights = y1) %>% pull(x) %>% moments::kurtosis(.)
  sk_df %>% uncount(weights = y4) %>% pull(x) %>% moments::skewness()
  

  
  



  m_df %>% 
  ggplot(aes(y=id,x=y)) +
  geom_col(color = "grey25", aes(fill = factor(id,levels=5:1))) +
  geom_segment(data=data.frame(x=3,y1=1.1,y2=4.9),size = 1.5,
               aes(xend=y2,x=y1,yend=3,y=3), color = "#48211A") +
  geom_label(data= data.frame(lab1="Median: 50% der Werte\nsind größer/kleiner"),
             aes(y=3.05,x=3,label=lab1),fill= "#48211A",color="grey96",label.size = 0,hjust=0,label.padding = unit(.3,"lines")) + 
  geom_segment(data=data.frame(y1=1.05,y2=4.9), size = 1.5, linetype = 2,
                aes(xend=y2,x=y1,yend=3,y=3), color = "orange") +
  geom_label(data= data.frame(lab1="arithm. Mittel\n(Durchschnitt)"),
               aes(y=3.05,x=2,label=lab1),fill= "orange",color="grey20",label.size = 0,hjust=0,label.padding = unit(.3,"lines")) + 
  geom_segment(data=data.frame(x=2,y1=1.1,y2=4.9), size = 1.5,
               aes(xend=y2,x=y1,yend=2,y=2), color = "#376597") +
  geom_label(data= data.frame(lab1="20% Perzentil:\n20% der Werte sind kleiner\n80% der Werte sind größer"),
             aes(y=2.05,x=1,label=lab1),fill= "#376597",color="grey96",label.size = 0,hjust=0,label.padding = unit(.3,"lines")) + 
  scale_fill_manual(values = paletteer::palettes_d$dutchmasters$milkmaid[6:13]) +
  scale_x_continuous(breaks = 1:5, labels = c("kleinster","2.kleinster","3","zweitgrößter","größter")) +
  labs(y = "Ausprägungwert", x = "Sortierte Beobachtungen") +
  guides(fill = "none", color = "none") +
  theme_minimal(base_size = 11) +
    coord_flip() +
  theme(panel.grid.major.x = element_blank(),panel.grid.minor.x = element_blank())
  
  