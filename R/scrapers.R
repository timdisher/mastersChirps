#' Create daily ranks
#' 
#' @param table leaderboard  created by fn_lb
fn_ranks <- function(table){
  
  
  # Day 1:2
  pre_cut <- 
    table %>% dplyr::select(r1:r2) %>%
    as.matrix() %>%
    matrixStats::rowCumsums() %>%
    `colnames<-`(paste0("r",1:2)) %>%
    cbind(table %>% dplyr::select(-c(r1:r2))) %>%
    tibble::as_tibble() %>%
      ties(., var = r1) %>%
      ties(., var = r2)
    
    
  
  # Day 3 on limited to those who made the cut
  made_cut <-  pre_cut %>%
    dplyr::filter(!is.na(pos))
  
  ranks_made <- made_cut %>%
     dplyr::select(r3:r4) %>%
     as.matrix() %>%
     matrixStats::rowCumsums() %>% # na.rm by default
     `colnames<-`(paste0("r",3:4)) %>%
     cbind(made_cut %>% dplyr::select(-c(r3:r4))) %>%
     tibble::as_tibble() %>%
     ties(., var = r3) %>%
     ties(., var = r4)
    
   ranks_cut <- pre_cut %>%
     dplyr::filter(is.na(pos)) %>%
    dplyr::mutate(r3_rank = r2_rank,
                  r4_rank = r2_rank)

   
   rbind(ranks_made, ranks_cut)
   }

#' Identify ties
#' 
#' Identify ties and output a table with positions that would have been calculated
#' on the day
#' 
#' @param dat a tibble
#' @param var variable to create a rank variable for
ties <- function(dat, var){
  var <- rlang::enquo(var)
  name <- paste0(rlang::as_name(var) , "_rank")
  
  if(dat %>% dplyr::pull(!! var) %>% is.na() %>% all){
    return(dat %>% dplyr::mutate(!! name := NA))
  }
  
  dat %>%
    dplyr::arrange(!! var) %>%
    dplyr::mutate(!! name := 1:dplyr::n()) %>%
    dplyr::group_by(!! var) %>%
    dplyr::mutate(!! name := min(!! rlang::sym(name))) %>%
    dplyr::ungroup()
}

#' Table scraper