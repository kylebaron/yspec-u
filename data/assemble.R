library(dplyr)
library(data.table)

all <- fread("data/analysis3.csv", na.strings = ".")

#' Introduction 
intro <- distinct(all, ID, WT, AGE, EGFR, SEX, STUDY, RF)
intro <- group_by(intro, STUDY, RF) %>% slice(1:2) %>% ungroup()
intro <- mutate(
  intro, 
  ID = row_number(), 
  C  = ifelse(ID==8, "C", NA_character_)
) %>% select(C, ID, everything())
message("writing intro.csv")
fwrite(x = intro, file = "data/intro.csv")


#' Firstonly
first <- group_by(all, ID) %>% slice(1) %>% ungroup()
message("writing firstonly.csv")
fwrite(x = first, file = "data/firstonly.csv")
