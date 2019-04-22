#' get Mining Dataset
#'
#' @export
#' @importFrom fs path file_temp
#' @importFrom readr read_csv cols col_character col_datetime parse_number locale
#' @importFrom dplyr mutate_at vars
#' @importFrom utils download.file unzip
#' @return a [tibble][tibble::tibble-package]
get_mining_data <- function(){
  tar <- "https://drive.google.com/uc?export=download&id=1qGzEgZG9l9hV5U-d3J2FfUKUZEKqNtVm"
  temps <- fs::path(fs::file_temp(), ext = "zip")
  if (.Platform$OS.type == "windows") {
    utils::download.file(tar, destfile = temps, mode = 'wb')
  } else {
    utils::download.file(tar, destfile = temps)
  }

  temp_path <- fs::path_temp()

  utils::unzip(zipfile = temps, exdir = temp_path, overwrite = T)
  temp_unzip <- fs::path(fs::path_temp(), "MiningProcess_Flotation_Plant_Database", ext = "csv")

  readr::read_csv(
    temp_unzip,
    col_types = readr::cols(.default = readr::col_character(),
                     date = readr::col_datetime(format = ""))
  ) %>%
    dplyr::mutate_at(
      dplyr::vars(-date),
      ~ readr::parse_number(., locale = readr::locale(decimal_mark = ","))
    ) -> tem
  file.remove(temps)
  file.remove(temp_unzip)
  return(tem)
}
