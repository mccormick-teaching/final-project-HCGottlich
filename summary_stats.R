#' [*!*!*NEED TO INSTALL PACMAN LIBRARY TO LOAD AGGREGATOR!*!*!]

library(data.table)

# set repo/core path
repo_path <- "C:/Users/Harri/Desktop/repos/CSSS_PROJ/"
#' [***********^^ Set to own!**********]

# load functions
source(paste0(repo_path, "utils/aggregator.R"))
source(paste0(repo_path, "utils/statgrapher.R"))

# aggregate and graph

data_root <- "C:/Users/Harri/Desktop/repos/data_for_csss_proj/"
data <- fread(paste0(data_root, "wiki-talk-temporal.txt"))

# 4 wks graph transitvity, number of nodes, number of edges, reciprocity

graphs_4wks         <- aggregator(data_in = data, num_weeks = 4, ret_igraphs = TRUE)

graph_4wks_trans_df <- graph_stat_grapher(data_list = graphs_4wks, g_fn = "transitivity", graph = TRUE, wk_agg = "4")
graph_4wks_trans_df <- graph_stat_grapher(data_list = graphs_4wks, g_fn = "vcount", graph = TRUE, wk_agg = "4")
graph_4wks_trans_df <- graph_stat_grapher(data_list = graphs_4wks, g_fn = "ecount", graph = TRUE, wk_agg = "4")
graph_4wks_trans_df <- graph_stat_grapher(data_list = graphs_4wks, g_fn = "reciprocity", graph = TRUE, wk_agg = "4")

# 5 wks graph transitvity, number of nodes, number of edges, reciprocity

graphs_5wks         <- aggregator(data_in = data, num_weeks = 5, ret_igraphs = TRUE)

graph_5wks_trans_df <- graph_stat_grapher(data_list = graphs_5wks, g_fn = "transitivity", graph = TRUE, wk_agg = "5")
graph_5wks_trans_df <- graph_stat_grapher(data_list = graphs_5wks, g_fn = "vcount", graph = TRUE, wk_agg = "5")
graph_5wks_trans_df <- graph_stat_grapher(data_list = graphs_5wks, g_fn = "ecount", graph = TRUE, wk_agg = "5")
graph_5wks_trans_df <- graph_stat_grapher(data_list = graphs_5wks, g_fn = "reciprocity", graph = TRUE, wk_agg = "5")

# 3 wks graph transitvity, number of nodes, number of edges, reciprocity

graphs_3wks         <- aggregator(data_in = data, num_weeks = 3, ret_igraphs = TRUE)
g <- graphs_3wks[1:111]
graph_3wks_trans_df <- graph_stat_grapher(data_list = g, g_fn = "transitivity", graph = TRUE, wk_agg = "3")
graph_3wks_trans_df <- graph_stat_grapher(data_list = g, g_fn = "vcount", graph = TRUE, wk_agg = "3")
graph_3wks_trans_df <- graph_stat_grapher(data_list = g, g_fn = "ecount", graph = TRUE, wk_agg = "3")
graph_3wks_trans_df <- graph_stat_grapher(data_list = g, g_fn = "reciprocity", graph = TRUE, wk_agg = "3")
