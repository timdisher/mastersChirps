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


## Pre-masters rankings
# I added this after the fact and the only webpage I could could had the table
# populated by what looked like javascript. So just using datapasta here to 
# cheat a little
# 
# Quickly aligned spelling to what was used in the pool for these players:
# 
# 1 Bryson Dechambeau
# 2 Matt Fitzpatrick 
# 3 C.T. Pan         
# 4 Robert MacIntyre  
# 
# Source: https://www.easyofficepools.com/masters-field-listed-by-world-ranking-and-odds-to-win/

p_rank <- data.frame(
  stringsAsFactors = FALSE,
            Golfer = c("Dustin Johnson",
                       "Justin Thomas","Jon Rahm","Collin Morikawa","Bryson Dechambeau",
                       "Xander Schauffele","Patrick Reed","Tyrrell Hatton",
                       "Webb Simpson","Patrick Cantlay","Brooks Koepka",
                       "Rory McIlroy","Tony Finau","Viktor Hovland","Daniel Berger",
                       "Matt Fitzpatrick","Billy Horschel","Paul Casey",
                       "Sungjae Im","Lee Westwood","Harris English",
                       "Scottie Scheffler","Matthew Wolff","Tommy Fleetwood",
                       "Hideki Matsuyama","Joaquin Niemann","Ryan Palmer",
                       "Louis Oosthuizen","Victor Perez","Cameron Smith","Abraham Ancer",
                       "Adam Scott","Jason Kokrak","Kevin Na",
                       "Christiaan Bezuidenhout","Kevin Kisner","Max Homa","Jordan Spieth",
                       "Marc Leishman","Sergio Garcia","Justin Rose",
                       "Matt Kuchar","Corey Conners","Shane Lowry","Robert MacIntyre",
                       "Will Zalatoris","Carlos Ortiz","Matt Wallace",
                       "Si Woo Kim","Brian Harman","Mackenzie Hughes","Jason Day",
                       "Gary Woodland","Bernd Wiesberger","Matt Jones",
                       "Brendon Todd","Lanto Griffin","Bubba Watson",
                       "Sebastian Munoz","Ian Poulter","Dylan Frittelli","Danny Willett",
                       "Cameron Champ","Martin Laird","Michael Thompson",
                       "Zach Johnson","Francesco Molinari","Robert Streb",
                       "Phil Mickelson","Henrik Stenson","Jim Herman","Stewart Cink",
                       "C.T. Pan","Hudson Swafford","Bernhard Langer",
                       "WITHDRAWN - Trevor Immelman","Tyler Strafaci",
                       "Joe Long","Jimmy Walker","Larry Mize","Charl Schwartzel",
                       "Vijay Singh","Ian Woosnam","Jose Maria Olazabal",
                       "Brian Gay","Ollie Osborne","WITHDRAWN - Angel Cabrera",
                       "Sandy Lyle","Mike Weir","Fred Couples"),
              Rank = c(1L,2L,3L,4L,5L,6L,7L,8L,
                       9L,10L,11L,12L,13L,14L,15L,16L,17L,18L,19L,
                       20L,21L,22L,23L,24L,25L,26L,27L,28L,29L,30L,31L,
                       32L,33L,34L,35L,36L,37L,38L,39L,40L,41L,42L,
                       43L,44L,45L,46L,47L,48L,49L,50L,51L,52L,53L,54L,
                       55L,56L,57L,58L,63L,64L,68L,77L,86L,100L,105L,
                       107L,108L,110L,115L,117L,132L,149L,155L,175L,
                       NA,NA,NA,NA,NA,NA,NA,NA,NA,NA,NA,NA,NA,NA,NA,
                       NA)
) %>% as_tibble %>%
  mutate(Rank = ifelse(is.na(Rank), 176, Rank)) #Unranked players all tied for worst

usethis::use_data(p_rank, overwrite = TRUE)
