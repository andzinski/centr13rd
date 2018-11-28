plot_octets <- function(tbl_in) {
  
  tbl_oct <- tbl_in %>%
    ft_regex_tokenizer(input_col = "src", output_col="oct", pattern="\\.") %>% 
    sdf_separate_column("oct") %>%
    mutate(
      oct_1 = as.numeric(oct_1),
      oct_2 = as.numeric(oct_2)
    )
  
  tbl_plot <- tbl_oct %>% 
    mutate(
      x1=oct_1 %% 16, y1=(oct_1-(oct_1 %% 16))/16,
      x2=oct_2 %% 16, y2=(oct_2-(oct_2 %% 16))/16
    ) %>%
    mutate(
      x=x1*16+x2,
      y=y1*16+y2
    ) %>%  
    group_by(x,y) %>%
    summarise(s=sum(count, na.rm=T)) %>%
    collect() 
  
  tbl_plot %>%
    ggplot() +
    geom_raster(aes(x,y,fill=s)) +
    scale_fill_gradient(low="green",high="red",trans="log",breaks=c(10^2,10^4,10^6,10^8)) +
    scale_x_continuous(breaks = seq(0,256,by=16)) +
    scale_y_continuous(breaks = seq(0,256,by=16)) + 
    theme(
      panel.grid.major = element_line(colour = "gray", linetype = "dotted"),
      panel.background = element_blank(),
      axis.title.x=element_blank(),
      axis.title.y=element_blank(),
      axis.ticks.x=element_blank(),
      axis.text.x = element_blank()
    ) 
}