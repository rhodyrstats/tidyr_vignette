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
pew <- tbl_df(read.csv(pew_path, stringsAsFactors = FALSE))
pew
pew_tidy <- pew %>%
  gather(income, frequency, -religion)

#grab billboard data from GitHub
billboard_path <- paste0(vignette_url,"billboard.csv")
billboard <- tbl_df(read.csv(billboard_path, stringsAsFactors = FALSE))
billboard

billboard2 <- billboard %>%
  gather(week, rank,wk1:wk76,na.rm=T)
billboard2

billboard3 <- billboard2 %>%
  mutate(
    week = extract_numeric(week),
    date = as.Date(date.entered) + 7 * (week - 1)) %>%
  select(-date.entered)
billboard3

billboard3 %>% arrange(artist, track, week)
billboard3 %>% arrange(desc(date), rank)

#grab tb data from GitHub
tb_path <- paste0(vignette_url,"tb.csv")
tb <- tbl_df(read.csv(tb_path, stringsAsFactors = FALSE))
tb

tb2 <- tb %>% 
  gather(demo, n, -iso2, -year, na.rm = TRUE)
tb2

tb3 <- tb2 %>% 
  separate(demo, c("sex", "age"), 1)
tb3

tb4

#grab weather data from GitHub
weather_path <- paste0(vignette_url,"weather.csv")
weather <- tbl_df(read.csv(weather_path, stringsAsFactors = FALSE))
weather

weather2 <- weather %>%
  gather(day, value, d1:d31, na.rm = TRUE)
weather2

weather3 <- weather2 %>% 
  mutate(day = extract_numeric(day)) %>%
  select(id, year, month, day, element, value) %>%
  arrange(id, year, month, day)
weather3

weather3 %>% spread(element, value)

song <- billboard3 %>% 
  select(artist, track, year, time) %>%
  unique() %>%
  mutate(song_id = row_number())
song

rank <- billboard3 %>%
  left_join(song, c("artist", "track", "year", "time")) %>%
  select(song_id, date, week, rank) %>%
  arrange(song_id, date)
rank
