#MaAsLin2

library(ggplot2)
library(vegan)
library(Maaslin2)
#prepping data for MaAslin2
meta1$HNC2 <- factor(meta1$HNC2, levels = c("yes", "no", "fep"))
meta1$smoking <- factor(meta1$smoking, levels = c("current", "former", "never"))
meta2$HNC2 <- factor(meta2$HNC2, levels = c("yes", "no", "fep"))
#Batch with no FEP MaAsLin2 analysis
maaslin_results <- Maaslin2(
  input_data = batch3,
  input_metadata = meta3,
  output = "maaslinFeat3",
  fixed_effects = c("HNC2", "gender"),
  random_effects = NULL,
  reference = "HNC2,no"
)
#Analyzing with MaAsLin2 and storing output in folders
maaslin_results <- Maaslin2(
  input_data = batch1,
  input_metadata = meta1,
  output = "maaslinFeat1",
  fixed_effects = c("gender", "age", "smoking"),
  random_effects = NULL
)
 
maaslin_results <- Maaslin2(
  input_data = batch2,
  input_metadata = meta2,
  output = "maaslinFeat2",
  fixed_effects = c("HNC3"),
  random_effects = NULL,
  reference = "HNC3,FEP"
)
library(pheatmap)
#Making heatmap for batch 2
signif <- read.csv(file = "~/maaslinFeat2/significant_results.tsv", sep = "\t")
 
signif <- signif %>%
  mutate(log_qval_sign = -log(qval) * sign(coef))
 
heatmap_data <- signif %>%
  select(feature, metadata, log_qval_sign) %>%
  pivot_wider(names_from = metadata, values_from = log_qval_sign) %>%
  column_to_rownames(var = "feature")
print(heatmap_data)
labels <- heatmap_data
labels[labels > 0] <- "+"
labels[labels != "+"] <- "-"
#labels[labels > 1] <- "+"
 
map <- pheatmap(as.matrix(heatmap_data),
         main = "Significant associations (-log(qval)*sign(coeff))",
         cellwidth = 30, cellheight = 30,
         display_numbers = as.matrix(labels),
         fontsize_number = 10,
         color = colorRampPalette(c("blue", "white", "red"))(100),
         cluster_rows = FALSE, cluster_cols = FALSE,
         breaks = seq(-3, 3, length.out = 101))
ggsave('batch2_maaslin_heatmap.pdf', plot = map, width = 20, height = 12)
