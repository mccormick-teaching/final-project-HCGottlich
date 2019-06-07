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

# 4 wks average degree (w/ 2 sd)

graphs_4wks         <- aggregator(data_in = data, num_weeks = 4, ret_igraphs = TRUE)
graph_4wks_deg_df   <- boxplot_node_dter(data_list = graphs_4wks, fn = "degree")

# shows even mean stable with outlier 
ggplot(graph_4wks_deg_df, aes_string(x = "Time_Aggregate", y = "degree", col = "Time_Aggregate")) +
  geom_point(stat = "summary", fun.y = "mean") +
  geom_point(stat = "summary", fun.y = "max", color = "red") +
  geom_errorbar(stat = "summary", fun.data = "mean_sdl", fun.args = list(mult = 1)) +
  theme_bw() +
  labs(xlab = "4 Week Time Aggregates", ylab = "Degree", title = paste0("Distribution of degree by 4 week Time Aggregates")) +
  theme(legend.position="none") +
  theme(axis.text.x = element_text(angle = 90, hjust = 1))

#
x <- graph_4wks_deg_df[, sum(degree), by = "Time_Aggregate"]
y <- copy(graph_4wks_deg_df)
y <- setDT(y)[,.SD[quantile(degree, 0.9) < 
                  degree] , by = "Time_Aggregate"]
y <- y[, sum(degree), by = "Time_Aggregate"]
setnames(y, "V1", "Top_10_percent")
all <- merge(x, y, by = "Time_Aggregate")
all[, prop_top_10 := Top_10_percent / V1]

ggplot(all, aes(x = Time_Aggregate, y = prop_top_10)) +
  theme_bw() +
  labs(xlab = "4 Week Time Aggregates", ylab = "Proportion Total Edits", title = paste0("Proportion Edits by Top 10 Percentile Nodes")) +
  theme(legend.position="none") +
  geom_point()

#
# d[, head(.SD, 3), by=cyl]

x <- graph_4wks_deg_df[, sum(degree), by = "Time_Aggregate"]
y <- copy(graph_4wks_deg_df)
y <- setDT(y)[, head(degree, 10) , by = "Time_Aggregate"]
y <- y[, sum(V1), by = "Time_Aggregate"]
setnames(y, "V1", "Top_10")

all <- merge(x, y, by = "Time_Aggregate")
all[, prop_top_10 := Top_10 / V1]

ggplot(all, aes(x = Time_Aggregate, y = prop_top_10)) +
  theme_bw() +
  labs(xlab = "4 Week Time Aggregates", ylab = "Proportion Total Edits", title = paste0("Proportion Edits by Top 10 Nodes")) +
  theme(legend.position="none") +
  geom_point()

# network at 10, 20 , 40

set.seed(42)

graph <- graphs_4wks[[10]]
l = layout_nicely(graph)
plot(main = "Graph of 10th 4-Week Aggregate", 
     graph, 
     vertex.size = (degree(graph) * 50/ sum(degree(graph))) , 
     layout = l, 
     vertex.label = NA, 
     edge.arrow.size = 0.03,
     vertex.color = "#5bdb99")

#
set.seed(42)

graph <- graphs_4wks[[20]]
l = layout_nicely(graph)
plot(main = "Graph of 20th 4-Week Aggregate", 
     graph, 
     vertex.size = (degree(graph) * 150/ sum(degree(graph))) , 
     layout = l, 
     vertex.label = NA, 
     edge.arrow.size = 0.03,
     vertex.color = "#5bdb99")
#
set.seed(42)

graph <- graphs_4wks[[40]]
l = layout_nicely(graph)
plot(main = "Graph of 40th 4-Week Aggregate", 
     graph, 
     vertex.size = (degree(graph) * 200/ sum(degree(graph))) , 
     layout = l, 
     edge.width = 0.001,
     vertex.label = NA, 
     edge.arrow.size = 0.03,
     vertex.color = "#5bdb99")
