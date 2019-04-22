## code to prepare `DATASET` dataset goes here
## need to permition of gdrive

library(googledrive)
library(dplyr)
library(furrr)
library(purrr)
library(magrittr)
library(readxl)
library(fs)

plan(multiprocess)
#
# drive_ls(
#   path = as_id("1SkQCZuSamolWFFQxUDXO1httHiW9qKUq"),
#   type = "xlsx",
#   recursive = T
# ) %$%
#   future_map2(id,
#               name,
#               .progress = T,
#               ~ purrr::safely(drive_download)(
#                 as_id(.x),
#                 path = fs::path("data-raw", .y),
#                 overwrite = T
#               ))

drive_ls(
  path = as_id("1kT5kxkaSEWyJwD2vuM-ElkWcQmJOIjOD"),
  recursive = T
) %>%
  filter(grepl("^LGLA_", name)) %$%
  future_map2(id,
              name,
              .progress = T,
              ~ purrr::safely(drive_download)(
                as_id(.x),
                path = fs::path("data-raw", .y),
                overwrite = T
              ))

dir_ls("./data-raw/", glob = "*.xlsx") %>%
  map(~readxl::excel_sheets(.x))

readxl::read_xlsx("./data-raw/LGLA_Avocado.xlsx") %>%
  select(-1) -> avocado

readxl::read_xlsx("./data-raw/LGLA_Churn_Modelling.xlsx") -> churn

readxl::read_xlsx("./data-raw/LGLA_Employee_10Year_Termination.xlsx") -> emp_tmnt

readxl::read_xlsx("./data-raw/LGLA_Employee_Attrition_Performance.xlsx") -> emp_attr

readxl::read_xlsx("./data-raw/LGLA_Mall_Customers.xlsx") -> mall

readxl::read_xlsx("./data-raw/LGLA_GiveMeSomeCredit_training.xlsx") %>%
  select(-1) -> credit_train

readxl::read_xlsx("./data-raw/LGLA_GiveMeSomeCredit_test.xlsx") %>%
  select(-1) -> credit_test

readxl::read_xlsx("./data-raw/LGLA_VideoGameSales.xlsx") -> games

readxl::read_xlsx("./data-raw/LGLA_Online_Retail.xlsx") -> retail

## mining data

unzip(zipfile = "data-raw/LGLA_Mining_Process.zip", exdir = "./data-raw")
library(dplyr)
library(readr)
read_csv(
  "data-raw/MiningProcess_Flotation_Plant_Database.csv",
  col_types = cols(.default = col_character(),
                   date = col_datetime(format = ""))
  , n_max = 100
) %>%
  mutate_at(
    vars(-date),
    ~ parse_number(., locale = locale(decimal_mark = ","))
  ) -> mining_samples

usethis::use_data(avocado,
                  churn,
                  emp_tmnt,
                  emp_attr,
                  mall,
                  credit_train,
                  credit_test,
                  games,
                  retail,
                  mining_samples,
                  overwrite = T)


