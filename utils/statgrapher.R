# Author : Chase
# Date : 5/21/19
# Purpose : Graph graph statistics for given list of graphs

cat("\n Package requirements: pacman (will download all others)")

require(pacman)
p_load(data.table, igraph, ggplot2, plotly)

padder <- function(x, pad_val){
  if (length(x) < pad_val){
    diff <- pad_val - length(x)
    vec  <- c(x, rep(NA, diff))
  } else{
    vec  <- x
  }
  return(vec) 
}

graph_stat_grapher <- function(data_list, g_fn, fn_name = NA, graph = FALSE, wk_agg = "Not Provided"){
  
  if (is.na(fn_name)){
    fn_name <- g_fn
  }
    
  data  <- lapply(data_list, eval(g_fn))
  deg_df  <- data.table(matrix(unlist(data), nrow = 1, byrow= FALSE))
  setnames(deg_df, paste0(as.character(1: ncol(deg_df))))
    
  deg_df    <- melt(deg_df, measure.vars = paste0(as.character(1: ncol(deg_df))), variable.name = "Time_Aggregate", value.name = g_fn)
    
    if (graph == TRUE){
      
      p <-  ggplot(deg_df, aes_string(x = "Time_Aggregate", y = as.character(g_fn), col = "Time_Aggregate")) +
        geom_point(alpha = 0.5) +
        labs(xlab = "Time_Aggregate", ylab = g_fn, title = paste0("Distribution of ", fn_name, " by Time_Aggregate of ", as.character(wk_agg), " weeks")) +
        theme_bw() +
        theme(legend.position="none") +
        theme(axis.text.x = element_text(angle = 90, hjust = 1))
      print(p)
      
    }
    
    return(deg_df)
  
} 

boxplot_node_dter <- function(data_list, fn, graph = FALSE){
  
  data_list <- graphs_16wks
  fn <- "degree"
  
  data <- lapply(data_list, eval(fn))
  pad_val <- max(unlist(lapply(data, length)))
  
  for (i in 1:length(data)){
    data[[i]] <- padder(data[[i]], pad_val = pad_val)
  }
  
  deg_df <- data.table(matrix(unlist(data), nrow = pad_val, byrow= FALSE))
  setnames(deg_df, paste0(as.character(1: ncol(deg_df))))
  deg_df <- melt(deg_df, measure.vars = paste0(as.character(1: ncol(deg_df))), variable.name = "Time_Aggregate", value.name = fn)
  deg_df <- deg_df[!(is.na(get(fn)))]
  
  return(deg_df)
  
}

histogram_node_grapher <- function(data_list, fn){
  
  for (i in 1:length(data_list)){
  
    x <- get(fn)(data_list[[i]])
    p <- hist(x , 
         col="forestgreen", 
         xlim=c(0, 1.05 * max(x)),
         xlab="Vertex Degree", 
         ylab="Frequency", 
         main= paste0("Time Aggregate ", i, " of ", length(data_list)))
         
  }
}

