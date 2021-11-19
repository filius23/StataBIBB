df2 <- 
  df %>% 
  pivot_longer(cols = matches("y\\d"),names_to = "set", values_to = "y") %>% 
  group_by(set) %>% 
  mutate(cor =  sprintf("%.3f",cor(x,y)),
         my= mean(y),
         mx= mean(x))  %>% 
  group_by(set) %>% nest() %>% 
  mutate(m = map(data,~lm(y~x,data=.x) %>% broom::tidy(.)),
         r2 = map(data,~summary(lm(y~x,data=.x))$r.squared ) %>% unlist(.) ) %>% 
  unnest(data) %>% 
  unnest(m) %>% 
  mutate(term = ifelse(term=="x","b1","b0")) %>% 
  select(-matches("statistic|std\\.|p\\.va")) %>% 
  pivot_wider(names_from = term,values_from = estimate) %>% 
  mutate(reg_fm = paste0("hat(italic(y))==~",format(b0, digits = 2),"~+~",format(b1, digits = 2),"%*%~italic(x)")) 
  # mutate(reg_fm = paste0("italic(y) == ", format(b0, digits = 2), " + ",format(b1, digits = 2)," %*%")) 


ggplot(df2,aes(x,y)) + 
  geom_point(shape = 21, color = "#020C3D", fill = "grey98") + 
  geom_hline(aes(yintercept = my),size = .75, color = "orange") +
  geom_vline(aes(xintercept = mx),size = .75, color = "navy") +
  geom_smooth(method = "lm",se=F, color = "#129FB3",size = .75) +
  geom_label(data = distinct(df2,cor,set,b0,b1,reg_fm), 
             aes(x = 0,y = 108,
                 label =  paste0("Pearson's r = ",cor) ),
             fill = alpha("grey99",.89), color = "grey25",
             family = "serif",
             hjust= .5, label.size = 0, label.r = unit(.2,"lines")) +
  geom_label(data = distinct(df2,cor,set,b0,b1,reg_fm), 
             aes(x = 0,y = 92,
                 label =  reg_fm),
             fill = alpha("grey99",.89), color = "grey25",
             family = "serif",
             parse = T,
             hjust= .5, label.size = 0, label.r = unit(.2,"lines")) +
  facet_wrap(~set,nrow = 2) +
  coord_cartesian(ylim = c(-72,115)) +
  theme_minimal() +
  theme(
    panel.background = element_rect(fill = "grey98", color = NA),
    strip.text = element_blank()) 



## regex ---------------

unique(df2$b1)

df3 <- 
  tibble(f = 1:2,
         x = 2:2,y=2:2,
         b0 = c(0.74,17.57),
         b1 = c(1.16,-1.16)) %>% 
  mutate(reg_fm = paste0("hat(italic(y))==~",format(b0, digits = 2),"~+~",format(b1, digits = 2),"%*%~italic(x)")) 
  # mutate(reg_fm = paste0("italic(y) == ",format(b0, digits = 2), " + ",format(b1, digits = 2)," %*% italic(x)*")) 


ggplot(df3,aes(x,y)) + 
  geom_label(aes(x = 2,y = 2,
                 label =  reg_fm),
             fill = alpha("grey99",.99), color = "grey25",
             family = "serif",
             parse = T,
             hjust= .5, label.size = 0, label.r = unit(.2,"lines")) +
  facet_wrap(~f,nrow = 2) 
  