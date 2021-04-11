## code to prepare `entry_picks` dataset goes here

randomNames::randomNames(70)
out <- tabulizer::extract_tables(here::here("data-raw", "2021 Masters Pool - Entry Picks.pdf"))

entry_picks <- do.call(rbind, out) %>% tibble::as_tibble() %>%
  dplyr::filter(!grepl("NamePick", V1)) %>%
  `colnames<-`(c("Name", paste0("pick", 1:8))) %>%
  dplyr::mutate(alt_name = randomNames::randomNames(n = dplyr::n()))

entry_picks_anon <- entry_picks %>% dplyr::select(-Name)

name_dict <- entry_picks %>% dplyr::select(Name, alt_name)

usethis::use_data(entry_picks_anon, overwrite = TRUE)

usethis::use_data(name_dict, overwrite = TRUE)
