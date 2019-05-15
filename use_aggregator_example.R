# Author : Chase
# Date : 5/12/19
# Purpose : Show how to use aggregator
# Notes : Aggregator returns list of igraph objects aggregatedto number of weeks set

#' [*!*!*NEED TO INSTALL PACMAN LIBRARY TO LOAD AGGREGATOR!*!*!]

library(data.table)

# set repo/core path
repo_path <- "C:/Users/Harri/Desktop/repos/wikipedia-user-edits/"
setwd(repo_path)

# load function
source("utils/aggregator.R")

# load data
data_repo <- "..."
data <- fread(paste0("/wiki-talk-temporal.txt"))

# example 1: aggregate over two weeks return graphs -- takes ~1min
graphs_2wks <- aggregator(data_in = data, num_weeks = 2, ret_igraphs = TRUE)

# example 2: aggregate over three weeks return graphs
graphs_3wks <- aggregator(data_in = data, num_weeks = 3, ret_igraphs = TRUE)

# example 3: aggregate over month return graphs
graphs_2wks <- aggregator(data_in = data, num_weeks = 4, ret_igraphs = FALSE)
