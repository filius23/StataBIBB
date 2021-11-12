# schiefe ---------



sk_df <-  
  data.frame(x= 1:10) %>%
  mutate(y1 = round(4/x*4)+ 2,
         y2 = round(4*x/4)+ 2,
         y3 = as.numeric(round(20 - abs(scale(x))*9.5)),
         y4 = 5) %>% 
  bind_rows(data.frame(x=0,y1=12,y2=2,y3=1,y4=5),
            data.frame(x=11,y1=2,y2=9,y3=1,y4=5)) 


sk_df %>% uncount(weights = y2) %>% pull(x) %>% moments::skewness(.)

skew1 <- 
  sk_df %>% 
  ggplot(aes(x=x,y=y2)) +
  geom_col(fill = paletteer::paletteer_d("dutchmasters::pearl_earring")[1]) +
  
  labs(title = "negative Schiefe (rechtssteil/linksschief)" ) + 
  theme_minimal(base_size = 11) +
  theme(panel.grid.major.x = element_blank(),panel.grid.minor.x = element_blank(),
        axis.title = element_blank(), 
        plot.title = element_text(hjust = .5, size = rel(2)))
skew2 <- 
  sk_df %>% 
  ggplot(aes(x=x,y=y3)) +
  geom_col(fill = paletteer::paletteer_d("dutchmasters::pearl_earring")[3]) +
  coord_cartesian(ylim=c(0,19)) +
  labs(title = paste0("Schiefe = 0")) +
  theme_minimal(base_size = 11) +
  theme(panel.grid.major.x = element_blank(),panel.grid.minor.x = element_blank(),
        axis.title = element_blank(), 
        plot.title = element_text(hjust = .5, size = rel(2)))

skew3 <- 
  sk_df %>% 
  ggplot(aes(x=x,y=y2)) +
  geom_col(fill = paletteer::paletteer_d("dutchmasters::pearl_earring")[4]) +
  labs(title = "positive Schiefe (linkssteil/rechtsschief)") +
  theme_minimal(base_size = 11) +
  theme(panel.grid.major.x = element_blank(),panel.grid.minor.x = element_blank(),
        axis.title = element_blank(), 
        plot.title = element_text(hjust = .5))

  
  
skew1 + skew2 + skew3
  
  

kurt1 <- round(sk_df %>% uncount(weights = y3) %>% pull(x) %>% moments::kurtosis(.),2)
pkurt1 <- 
  sk_df %>% 
  ggplot(aes(x=x,y=y3)) +
  geom_col(fill = paletteer::paletteer_d("dutchmasters::pearl_earring")[7]) +
  labs(title = paste0("Wölbung = ",kurt1)) +
  theme_minimal(base_size = 11) +
  theme(panel.grid.major.x = element_blank(),panel.grid.minor.x = element_blank(),
        axis.title = element_blank(), 
        plot.title = element_text(hjust = .5))

kurt2 <- round(sk_df %>% uncount(weights = y4) %>% pull(x) %>% moments::kurtosis(.),2)
pkurt2 <- 
  sk_df %>% 
  ggplot(aes(x=x,y=y2)) +
  geom_col(fill = paletteer::paletteer_d("dutchmasters::pearl_earring")[8]) +
  labs(title = paste0("Wölbung = ",kurt2)) +
  theme_minimal(base_size = 11) +
  theme(panel.grid.major.x = element_blank(),panel.grid.minor.x = element_blank(),
        axis.title = element_blank(), 
        plot.title = element_text(hjust = .5))



kurt_df <-  
  data.frame(x= 1:10) %>%
  mutate(y3 = 30,
         y4 = round(dt(1:10 - 5.5,df=2) * 100),
         y5 = 0) %>% 
  bind_rows(data.frame(x=0 ,y3=1,y4=0,y5=32),
            data.frame(x=11,y3=1,y4=0,y5=32)) 


(kurt5 <- round(kurt_df %>% uncount(weights = y5) %>% pull(x) %>% moments::kurtosis(.),2))
kurt_df %>% 
  ggplot(aes(x=x,y=y5)) +
  geom_col(fill = paletteer::paletteer_d("dutchmasters::pearl_earring")[8]) +
  labs(title = paste0("Wölbung = ",kurt5)) +
  # coord_cartesian(ylim = c(0,15)) + 
  theme_minimal(base_size = 11) +
  theme(panel.grid.major.x = element_blank(),panel.grid.minor.x = element_blank(),
        axis.title = element_blank(), 
        plot.title = element_text(hjust = .5))

  
    
  
  paletteer_d("dutchmasters::milkmaid")[c(10:15)]

m_df %>% 
  ggplot(aes(y=y2,x=y)) +
  geom_col(color = "grey25", aes(fill = factor(id,levels=5:1))) +
  geom_segment(data=data.frame(y1=.95,y2=5.1), size = 1, 
               aes(xend=y2,x=y1,yend=4,y=4), color = "orange") + # mean linie
  geom_segment(data=data.frame(x=3,y1=.95,y2=5.1),size = 1,
               aes(xend=y2,x=y1,yend=3,y=3), color = "#48211A") + # median linie
  geom_segment(data=data.frame(x=2,y1=.95,y2=5.1), size = 1,
               aes(xend=y2,x=y1,yend=2,y=2), color = "#376597") + #20% linie
  geom_label(data= data.frame(lab1="arithm. Mittel"),size = 3,
             aes(y=4.15,x=4.1,label=lab1),fill= "orange",color="grey20",
             label.size = 0,hjust=0,label.padding = unit(.3,"lines")) + # mean label
  geom_label(data= data.frame(lab1="Median"),size = 3,
             aes(y=3.15,x=0,label=lab1),fill= "#48211A",color="grey96",
             label.size = 0,hjust=0,label.padding = unit(.3,"lines")) + # median label
  geom_label(data= data.frame(lab1="20% Perzentil"),size = 3,
             aes(y=1.65,x=3.5,label=lab1),fill= "#376597",color="grey96",
             label.size = 0,hjust=0,label.padding = unit(.3,"lines")) + # 20% label
  scale_fill_manual(values = paletteer::palettes_d$dutchmasters$milkmaid[c(11,7:10)]) +
  scale_x_continuous(breaks = 1:5, labels = c("kleinster","2.kleinster","3","zweitgrößter","größter")) +
  labs(y = "Ausprägungwert", x = "Sortierte Beobachtungen", title = "Datensatz 2") +
  guides(fill = "none", color = "none") +
  theme_minimal(base_size = 11) +
  theme(panel.grid.major.x = element_blank(),panel.grid.minor.x = element_blank(),
        axis.text.x = element_text(size=rel(.5)))