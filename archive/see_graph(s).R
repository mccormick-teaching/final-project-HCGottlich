# Author : Chase
# Date : 5/21/19
# Purpose : Viz graphs for list of graphs

cat("\n Package requirements: pacman (will download all others)")

require(pacman)
p_load(data.table, igraph, RColorBrewer)

par(bg = "grey27")

see_graph <- function(graph, color_by){
  
  graph = graph
  color_by = "degree"
  
  V(graph)$label <- get(color_by)(graph)
  
  cols <- brewer.pal(9, "YlOrRd")
  my_cols <- colorRampPalette(cols, max(V(graph)$label))
  
  plot(graph,
       vertex.size = 10.0,
       vertex.color = my_cols,
       vertex.label.cex = .5,
       edge.arrow.size = 0.2,
       vertex.label.color = "white",
       vertex.frame.color = "white")
  
}

see_graphs(graph_list, color_by){
  
  for (graphs in graph_list){
    see_graph(graph)
  }
  
}




