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
  coord_cartesian(ylim=c(0,19)) +
  labs(title = paste0("Wölbung = ",kurt1)) +
  theme_minimal(base_size = 11) +
  theme(panel.grid.major.x = element_blank(),panel.grid.minor.x = element_blank(),
        axis.title = element_blank(), 
        plot.title = element_text(hjust = .5))

kurt2 <- round(sk_df %>% uncount(weights = y4) %>% pull(x) %>% moments::kurtosis(.),2)
kurt1 <- 
  sk_df %>% 
  ggplot(aes(x=x,y=y2)) +
  geom_col(fill = paletteer::paletteer_d("dutchmasters::pearl_earring")[8]) +
  labs(title = paste0("Wölbung = ",kurt2)) +
  theme_minimal(base_size = 11) +
  theme(panel.grid.major.x = element_blank(),panel.grid.minor.x = element_blank(),
        axis.title = element_blank(), 
        plot.title = element_text(hjust = .5))