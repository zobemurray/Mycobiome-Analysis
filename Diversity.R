#Alph and Beta Diversity

#Calculating using the shannon diversity
alpha_diversity <- diversity(t(whole), index = "shannon")
alpha_diversity <- data.frame(Sample = names(alpha_diversity), AlphaDiversity = alpha_diversity)
print(alpha_diversity)
metaW <- meta.all[rownames(meta.all) %in% alpha_diversity$Sample, ]
alpha_diversity <- alpha_diversity[alpha_diversity$Sample %in% rownames(metaW), ]
#Merging the diversity and meta data for plotting
combined_alpha <- merge(alpha_diversity, metaW, by.x = "Sample", by.y = "row.names")
print(as.matrix(combined_alpha))
Group <- metaW$HNC3
#Creating the p-value comparisons
compare <- list(c("FEP", "Normal"), c("HNC", "FEP"), c("HNC", "Normal"))
#Creating box plot of alpha diversity data
plot <- ggboxplot(
  combined_alpha, x = "HNC3", y = "AlphaDiversity", color = "HNC3", palette = "jco", add = "jitter"
) +
  stat_compare_means(comparisons = compare) + 
  stat_compare_means(label.y = 3) +
  ggtitle("Shannon Diversity by Group") +
  theme(plot.title = element_text(hjust = 0.5, face = "bold")) +
  labs(x = "HNC Status", y = "Alpha Diversity Index")
print(plot)
ggsave('all_shannon_boxplot.pdf', plot = plot, width = 8, height = 6)

#Calculating using the bray curtis diversity
beta_diversity <- vegdist(t(whole), method = "bray")
#Creating a PCoA data frame to use for graphing
pcoa_result <- cmdscale(beta_diversity, k = 2, eig = TRUE)
pcoa_df <- data.frame(Sample = rownames(pcoa_result$points), PCoA1 = pcoa_result$points[,1], PCoA2 = pcoa_result$points[,2])
 
metaW <- meta.all[rownames(meta.all) %in% pcoa_df$Sample, ]
pcoa_df <- pcoa_df[pcoa_df$Sample %in% rownames(metaW), ]
#Merging the diversity and meta data for plotting
combined_beta <- merge(pcoa_df, metaW, by.x = "Sample", by.y = "row.names")
Group <- metaW$HNC3
#Creating a PCoA plot of the bray curtis diversity
plot <- ggplot(combined_beta, aes(x = PCoA1, y = PCoA2, color = Group)) +
  geom_point(size = 3) +
  labs(title = "PCoA of Beta Diversity (Bray Curtis)",
       x = "PCoA Axis 1",
       y = "PCoA Axis 2") +
  theme_minimal() +
  theme(plot.title = element_text(hjust = 0.5, face = "bold"))
print(plot)
ggsave('all_bray_pcoa.pdf', plot = plot, width = 8, height = 6)
