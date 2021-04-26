# install.packages("devtools")
devtools::install_github("VerbalExpressions/RVerbalExpressions")

library(RVerbalExpressions)

strings = c(	'La 47, Sec, 46, T12S, R12E','	HWY 115, Sec 3, R3E, T4N','Beside US 167, Sec. 53, 53, T8S, R4E')


expr =  rx_alpha() 
stringr::str_extract_all(strings,expr)  


expr =   rx_alpha() %>% rx_digit() %>%  rx_alpha() 
stringr::str_extract_all(strings,expr)  


expr =  rx_alpha() %>% rx_word() %>% rx_alpha() 
stringr::str_extract_all(strings,expr) 


expr
