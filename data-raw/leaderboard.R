## code to prepare `leaderboard` dataset goes here


url <- "https://www.espn.com/golf/leaderboard"
webpage <- rvest::read_html(url) 

leaderboard <- 
  webpage %>% 
  rvest::html_node("table") %>% # find tables (there's just the one)
  rvest::html_table()  %>% # read as tibble
  janitor::clean_names() %>% # make lower case snake_case names
  dplyr::select(player, pos,tot, dplyr::starts_with("r")) %>% 
  dplyr::filter(! grepl("cut", player)) %>%
  dplyr::mutate(pos = stringr::str_remove(pos, "T")) %>%
  dplyr::mutate_at(dplyr::vars(-c(player)), as.numeric)

# Safety in case tables move or something
if(Sys.Date() < "2021-04-13"){

usethis::use_data(leaderboard, overwrite = TRUE)
}
