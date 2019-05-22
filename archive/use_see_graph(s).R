library(data.table)

# set repo/core path
repo_path <- "C:/Users/Harri/Desktop/repos/CSSS_PROJ/"

# load functions
source(paste0(repo_path, "utils/aggregator.R"))
source(paste0(repo_path, "utils/see_graph(s).R"))

# aggregate and graph

data_root <- "C:/Users/Harri/Desktop/repos/data_for_csss_proj/"
data      <- fread(paste0(data_root, "wiki-talk-temporal.txt"))
usernames <- fread(paste0(data_root, "wiki-talk-temporal-usernames.txt"))
setnames(usernames, c("node", "username"))

# aggregator function
graphs_16wks         <- aggregator(data_in = data, num_weeks = 16, ret_igraphs = TRUE)

#' [See Graph]
graph <- graphs_16wks[[1]]

dt <- data.table(node = V(graph))
dt <- merge(dt, usernames, by = "node")
V(graph)$name <- dt[,username]

see_graph(graph = graph, color_by = "degree")

#' [See Graphs - didn't even try since almost certainly would freeze computer with 100,000+ node graphs]

# see_graphs(graphs_16wks, color_by = "degree")