# Author : Chase
# Date : 5/12/19
# Purpose : Aggregate over time window
# Notes : TBI load node names with nodes
 
cat("\n Package requirements: pacman (will download all others)")
 
require(pacman)
p_load(data.table, anytime, igraph)
 
cat("Loading function aggregator: 
    \n***THIS FUNCTION ASSUMES YOU DID NOT CHANGE THE data FROM DOWNLOAD (though easy to generalize if needed)***)
    \n\n First Argument is data, an datatable object\n Second Argument is num_weeks, a numeric number of weeks to aggregate from first date\n Third Argument is ret_igraphs, TRUE if you want list per period of igraph objects or FALSE if you just want labeled datatable
    \n Returns datatable or simplified list of graphs\n Periods without any edges not removed (important)\n Additional features tbi is naming nodes")

aggregator <- function(data_in, num_weeks, ret_igraphs){

  # data table copies by references, so need to save to not change base
  
  data_wiki <- copy(data_in)
  
  # set-up variables 
  
  setnames(data_wiki, c("from", "to", "time"))
  data_wiki[, time := anydate(time)]
  setorder(data_wiki, time)
  
  days <- num_weeks * 7
  name <- paste0("period_", as.character(num_weeks), "_weeks")
  diff <- data_wiki[nrow(data_wiki), time] - data_wiki[1, time]
  diff <- as.numeric(diff / days)
  
  # assign period to dates
  
  start <- data_wiki[1, time]
  data_wiki[, (name) := NaN]
  
  for (per in 1:ceiling(diff)){
    data_wiki[(time < (start + (days * per)))
         &
         (time >= (start + (days * (per - 1)))), (name) := per]
  }
  
  if (ret_igraphs == FALSE){
    return(data_wiki)
  } else {
    
    # slice by each and convert, append to list
    
    igraphs <- list()
    
    for (ind in 1:as.numeric(data_wiki[nrow(data_wiki), get(name)])){
      x <- data_wiki[get(name) == ind]
      x <- x[, c(1,2)]
      x <- simplify(graph_from_data_frame(x))
      igraphs[[ind]] <- x
    }
    return(igraphs)
  }
}
