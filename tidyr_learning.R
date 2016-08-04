#Required packages
library("tidyr")
library("dplyr")
#Grab csv from GitHub (not readily availble on local)
vignette_url <- "https://raw.githubusercontent.com/hadley/tidyr/master/vignettes/"
preg_path <- paste0(vignette_url, "preg.csv")
preg <- read.csv(preg_path, stringsAsFactors = FALSE)
preg

#First tidying example from vignette
preg2 <- preg %>% 
  gather(treatment, n, treatmenta:treatmentb) %>%
  mutate(treatment = gsub("treatment", "", treatment)) %>%
  arrange(name, treatment)

#Grab pew csv from GitHub
pew_path <- paste0(vignette_url, "pew.csv")
pew <- read.csv(pew_path, stringsAsFactors = FALSE)
tbl_df(pew)

