# Author : Chase
# Date : 5/12/19
# Purpose : Show how to use aggregator
# Notes : Aggregator returns list of igraph objects aggregatedto number of weeks set

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


# example 1: aggregate over two weeks return graphs -- takes ~1min
graphs_2wks <- aggregator(data_in = data, num_weeks = 2, ret_igraphs = TRUE)

# example 2: aggregate over three weeks return graphs
graphs_3wks <- aggregator(data_in = data, num_weeks = 3, ret_igraphs = TRUE)

# example 3: aggregate over month return graphs
graphs_2wks <- aggregator(data_in = data, num_weeks = 4, ret_igraphs = FALSE)
