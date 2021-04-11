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