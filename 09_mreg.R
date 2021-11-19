


set.seed(90459)
baua <- readstata13::read.dta13("D:/Datenspeicher/BIBB_BAuA/BIBBBAuA_2018_suf1.0.dta",convert.factors = F,
                                select.cols = c("S1","F518_SUF","S3","F200")) %>% 
  mutate(F518_SUF = ifelse(F518_SUF>99997,NA,F518_SUF),
         F200 = ifelse(F200>95,NA,F200),
         sex1  = factor(S1, levels = 1:2, labels = c("Männer","Frauen")),
         S3 = ifelse(S3 %in% 2:9,S3,NA),
         educ = case_when(S3 %in% 2:4 ~ "1",
                          S3 %in% 5:6 ~ "2",
                          S3 %in% 7:9 ~ "3")) %>% 
  select(S1,F518_SUF,S3, educ,sex1,F200) %>% 
  filter(F518_SUF<99998) %>% 
  sample_n(500) %>% 
  group_by(S1) %>% 
  mutate(mean_inc = mean(F518_SUF,na.rm = T), n1 = 1:n() ) %>% ungroup(.)


m9ia <- lm(F518_SUF ~ F200 * sex1, baua)
pred_df <- expand.grid(sex1 = levels(baua$sex1),F200 = seq(5,45,5))
pred_df$inc_p <- predict(m9ia,pred_df)

pred_dfb <- 
  expand.grid(fisei08=c(35,70),misei08=c(33.33,43.33,53.33)) %>% 
  mutate(isei08_m2 = predict(m2,.)) %>% 
  group_by(fisei08) %>% 
  mutate(isei08_m2d = lead(isei08_m2),
         lab_end = isei08_m2 + ( isei08_m2d - isei08_m2)/2,
         lab_end2 = isei08_m2 + ( isei08_m2d - isei08_m2)/4,
         lab1 = paste0("Delta:~10%*%~widehat(beta[2])==", sprintf("%2.4f",m2$coefficients[3]*10)) %>% 
           ifelse(is.na(lab_end),NA,.),
         lab2 = "\u03B2\u0302")

pred_dfb$lab_pos = pred_dfb$lab_end + c(-7,-7,7,7,0,0)
pred_dfb$lab_posx = pred_dfb$fisei08 + c(-5,5,-5,5,0,0)
pred_dfb$curve =  c(.5,-.5,-.5,.5,NA,NA)

ggplot(baua, aes(y = F518_SUF, x = F200)) + 
  geom_point(color = "grey20",alpha = .5, shape = 21, fill = "grey98") 

  geom_line(data= pred_df,aes(y=isei08_m2,color = factor(misei08)), size = .65) +
  geom_segment(data= pred_dfb,aes(y=isei08_m2,yend=isei08_m2d,xend=fisei08,color = factor(misei08)),
               arrow = arrow(length = unit(.015,"npc"),type = "closed"),show.legend = F,) + # Pfeile
  lapply(split(pred_dfb, 1:nrow(pred_dfb)), function(dat) {
    geom_curve(data = dat, aes(y=lab_end2, x = fisei08,yend=lab_pos,xend=lab_posx,color = factor(misei08)), curvature = dat["curve"],show.legend = F, size = .25) }
  ) +
  geom_label(data= pred_dfb,
             aes(y = lab_pos, label = lab1,color = factor(misei08)),
             family = "Nunito",show.legend = F, 
             fill = alpha("white",.85),
             size = 3, hjust = c(1,0,1,0,1,0), parse = T,label.size = 0.1) +
  scale_color_manual(values = viridis::magma(9,end = .9,begin=.1)[c(3,5,7)]) +
  labs(color = "misei08") +
  guides(colour = guide_legend(override.aes = list(shape = 15,size = 4, linetype = 1) ,
                               label.position ="right" , ncol = 3,reverse = F) ) +
  theme_x +
  theme(legend.position = "top",legend.text = element_text(family =  "Nunito"))