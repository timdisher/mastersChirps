## code to prepare `entry_picks` dataset goes here

out <- tabulizer::extract_tables(here::here("data-raw", "2021 Masters Pool - Entry Picks.pdf"))

final <- do.call(rbind, out) %>% tibble::as_tibble() %>%
  dplyr::filter(!grepl("NamePick", V1)) %>%
  `colnames<-`(c("Name", paste0("pick", 1:8)))

nrow(final) == 272

usethis::use_data(entry_picks, overwrite = TRUE)
