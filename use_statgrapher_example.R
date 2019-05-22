#' [*!*!*NEED TO INSTALL PACMAN LIBRARY TO LOAD Utils!*!*!]

library(data.table)

# set repo/core path
repo_path <- "C:/Users/Harri/Desktop/repos/CSSS_PROJ/"

# load functions
source(paste0(repo_path, "utils/aggregator.R"))
source(paste0(repo_path, "utils/statgrapher.R"))

# aggregate and graph

data_root <- "C:/Users/Harri/Desktop/repos/data_for_csss_proj/"
#' [***********^^ Set to own!**********]

data <- fread(paste0(data_root, "wiki-talk-temporal.txt"))

# aggregator function
graphs_16wks         <- aggregator(data_in = data, num_weeks = 16, ret_igraphs = TRUE)

# example 1 -- graph statistics: aggregate over 16 weeks; graph transitvity
graph_16wks_trans_df <- graph_stat_grapher(data_list = graphs_16wks, g_fn = "transitivity", averaged = FALSE, graph = TRUE)

# example 2 -- node statistics boxplot: aggregate over 16 weeks, take degree of each node, graph boxplot of each graph

graph_16wks_deg_df   <- boxplot_node_dter(data_list = graphs_16wks, fn = "degree")

#can not graph directly due to number of nodes -- filter returned df on which aggregates you want to see
deg_df_subset <- graph_16wks_deg_df[Time_Aggregate %in% c(1:5)]

ggplot(deg_df_subset, aes_string(x = "Time_Aggregate", y = "degree", col = "Time_Aggregate")) +
    geom_point(alpha = 0.5) +
    geom_boxplot() +
    labs(xlab = "Time_Aggregate", ylab = "degree", title = paste0("Distribution of degree by Time_Aggregate")) +
    theme_bw() +
    theme(legend.position="none") +
    theme(axis.text.x = element_text(angle = 90, hjust = 1))

# example 3: aggregate over 16 weeks, take degree of each node, graph histogram of each graph
histogram_node_grapher(data_list = graphs_16wks, fn = "degree")

# example 4: showing how to export above to pdf for ease

out_file <- ("...")
# ^^ path to save to
# dev.off() in console until says can not shut down null device

pdf(out_file)
histogram_node_grapher(data_list = graphs_16wks, fn = "degree")
dev.off()