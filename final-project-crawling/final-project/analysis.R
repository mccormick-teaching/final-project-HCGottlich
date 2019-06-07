
# Author : Chase
# Date : 5/12/19
# Purpose : Show how to use aggregator
# Notes : Aggregator returns list of igraph objects aggregatedto number of weeks set

#' [*!*!*NEED TO INSTALL PACMAN LIBRARY TO LOAD AGGREGATOR!*!*!]

library(data.table)


# load function
source("aggregator.R")

# load data
data <- fread("~/Downloads/wiki-talk-temporal.txt")

#load the undirected graph
g <- graph_from_data_frame(data,directed = T)

# remove duplicate edges i.e. make it unweighted
g2 <- simplify(g)
?simplify
s <- decompose.graph(g2)
s2 <- table(sapply(s, vcount))%>%as.data.frame()
s2%>%View()

write_graph(g2, 'wiki_undirected_graph.gml', format ="gml")

# example 1: aggregate over two weeks return graphs -- takes ~1min
graphs_2wks <- aggregator(data_in = data, num_weeks = 2, ret_igraphs = TRUE)

# example 2: aggregate over three weeks return graphs
graphs_3wks <- aggregator(data_in = data, num_weeks = 3, ret_igraphs = TRUE)

# example 3: aggregate over month return graphs
graphs_4wks <- aggregator(data_in = data, num_weeks = 4, ret_igraphs = TRUE)

# example 4: aggregate over each year
graphs_52wks <- aggregator(data_in = data, num_weeks = 52, ret_igraphs = TRUE)

# plot and fit the power law distribution

fit_power_law = function(graph,type) {
  # calculate degree
  d = degree(graph, mode = type)
  d <- d[d>0]
  m_sp = displ$new(d)
  est_sp = estimate_xmin(m_sp)
  m_sp$setXmin(est_sp)
  #plot(m_sp, pch=16, bg=2,xlab="Degree", ylab="PDF")
  #tmp <- locator(1)
  #text(tmp, paste0("alpha: ",round(m_sp$pars,2),", kmin:",m_sp$xmin))
  #lines(m_sp, col=3, lwd=3)
  #abline(v = est_sp$xmin,col="red")
  m_sp
}

l <- lapply(graphs_52wks,fit_power_law, "out")


dev.off()
plot(l[[1]],bg=2,pch = 15,panel.first = grid(10, lty = 1, lwd = 2),xlab="Degree distribution (Out)",ylab="PDF")
par(new=TRUE)
plot(l[[2]],axes=FALSE,pch=16,xlab="Degree distribution (Out)",ylab="PDF")
par(new=TRUE)
plot(l[[3]],axes=FALSE,pch=17,xlab="Degree distribution (Out)",ylab="PDF")
par(new=TRUE)
plot(l[[4]],axes=FALSE,pch=18,xlab="Degree distribution (Out)",ylab="PDF")
par(new=TRUE)
plot(l[[5]],axes=FALSE,pch=19,xlab="Degree distribution (Out)",ylab="PDF")
par(new=TRUE)
plot(l[[6]],axes=FALSE,pch=20,xlab="Degree distribution (Out)",ylab="PDF")
par(new=TRUE)
plot(l[[7]],axes=FALSE,pch=21,xlab="Degree distribution (Out)",ylab="PDF")

l <- lapply(graphs_52wks,fit_power_law,"in")




data.frame(graphs_4wks[[1]])
tmp <- as.data.frame(get.edgelist(graphs_4wks[[1]]))
colnames(tmp) <- c("recruiter","id")
get.edgelist(graphs_4wks[[5]])

data <- data[,1:2]
colnames(data) <- c("recruiter","id")
library(poweRlaw)



d <- degree(graphs_4wks[[10]])
d <- d[d>0]
m_sp = displ$new(d)
est_sp = estimate_xmin(m_sp)
m_sp$setXmin(est_sp)
plot(m_sp, pch=16, bg=2,xlab="Degree", ylab="PDF")

graphs_4wks[1:10][1]

#plot(unlist(l)[[1]])

#######
# SAMPLING TECHNIQUES
#######

# start a node
# if that node has more than 3 nodes, sample 3 nodes
# run the above step on each of the new nodes


#RANDOM WALK
g <- graphs_52wks[[1]]
g2 <- as.undirected(g, mode = "collapse")

nodes <- c()
num_new <- c()
for(i in 1:5000){
  w <- random_walk(g2,sample(V(g2),1),1000, mode="out",stuck = "return")
  og_num <- length(nodes)
  nodes <- c(nodes, as.vector(w))
  num_new <- c(num_new, length(nodes) - og_num)
  nodes <- unique(nodes)
}

plot(seq(1,5000), num_new)

length(unique(nodes))
length(nodes)
vcount(g)
as.vector(w)

