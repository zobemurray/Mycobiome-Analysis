#Relative Abundance Visualization

#Bar plot for relative abundance
library(randomcoloR)
library(RColorBrewer)
whole$feature <- rownames(whole)
df <- whole %>% arrange(feature)
df <- df %>% select(feature, everything())
df_long <- df %>%
  pivot_longer(-feature, names_to = "sampleID", values_to = "Abundance")
meta.all$run <- rownames(meta.all)
print(meta.all)
grp_info <- data.frame(sampleID = meta.all$run, Group = meta.all$HNC3)
print(grp_info)
print(df_long)
df_long <- df_long %>%
  left_join(grp_info, by = "sampleID")
df_long %>%
  ggplot(aes(x = Group, y = Abundance)) +
  geom_bar(aes(fill = feature), stat = "identity", position = "fill")
 
num <- length(rownames(whole))
palette <- distinctColorPalette(num) 
pal <- colorRampPalette(brewer.pal(12, "Paired"))(num)
p <- df_long %>%
  ggplot(aes(x = Group, y = Abundance)) +
  geom_bar(aes(fill = feature), stat = "identity", position = "fill") +
  scale_fill_manual(values = pal) +
  scale_y_continuous(name = "Relative Abundance", labels = scales::percent) +
  labs(fill = "Fungi Species", title = "Fungi Species Relative Abundance") +
  xlab("") +
  theme_minimal() +
  theme(axis.text.y = element_text(face = "bold", size = 12), 
        axis.text.x = element_text(face = "bold", size = 12),
        axis.title.y = element_text(face = "bold"),
        axis.title.x = element_text(face = "bold"),
        axis.ticks.y = element_line(),
        panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(), 
        plot.title = element_text(hjust = 0.5, face = "bold"))
plot(p)
ggsave('rela_abun_bar_plot.pdf', plot = p, width = 8, height = 6)
