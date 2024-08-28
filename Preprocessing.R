#Preprocessing

#Putting names of the kraken output files into data frame
lines <- data.frame(sample= c("SRR20632992_fungi.S.bracken", "SRR20632999_fungi.S.bracken", "SRR20633000_fungi.S.bracken", "SRR20633001_fungi.S.bracken", 
"SRR20632994_fungi.S.bracken", "SRR20632993_fungi.S.bracken", "SRR20633003_fungi.S.bracken", "SRR20633014_fungi.S.bracken", "SRR20633018_fungi.S.bracken", 
"SRR20633019_fungi.S.bracken", "SRR20633023_fungi.S.bracken", "SRR20633025_fungi.S.bracken", "SRR20633031_fungi.S.bracken", "SRR20633038_fungi.S.bracken", 
"SRR20633039_fungi.S.bracken", "SRR20633040_fungi.S.bracken", "SRR20633044_fungi.S.bracken", "SRR20633050_fungi.S.bracken", "SRR20633053_fungi.S.bracken", 
"SRR20633054_fungi.S.bracken", "SRR20633055_fungi.S.bracken", "SRR20632995_fungi.S.bracken", "SRR20632996_fungi.S.bracken", "SRR20632997_fungi.S.bracken", 
"SRR20632998_fungi.S.bracken", "SRR20633005_fungi.S.bracken", "SRR20633007_fungi.S.bracken", "SRR20633009_fungi.S.bracken", "SRR20633012_fungi.S.bracken", 
"SRR20633022_fungi.S.bracken", "SRR20633026_fungi.S.bracken", "SRR20633033_fungi.S.bracken", "SRR20633034_fungi.S.bracken", "SRR20633035_fungi.S.bracken", 
"SRR20633043_fungi.S.bracken", "SRR20633045_fungi.S.bracken", "SRR20633048_fungi.S.bracken", "SRR20633052_fungi.S.bracken", "SRR20633056_fungi.S.bracken", 
"SRR20633058_fungi.S.bracken", "SRR20633059_fungi.S.bracken", "SRR20633002_fungi.S.bracken", "SRR20633004_fungi.S.bracken", "SRR20633006_fungi.S.bracken", 
"SRR20633008_fungi.S.bracken", "SRR20633010_fungi.S.bracken", "SRR20633011_fungi.S.bracken", "SRR20633013_fungi.S.bracken", "SRR20633015_fungi.S.bracken", 
"SRR20633016_fungi.S.bracken", "SRR20633017_fungi.S.bracken", "SRR20633020_fungi.S.bracken", "SRR20633021_fungi.S.bracken", "SRR20633024_fungi.S.bracken", 
"SRR20633027_fungi.S.bracken", "SRR20633028_fungi.S.bracken", "SRR20633029_fungi.S.bracken", "SRR20633030_fungi.S.bracken", "SRR20633032_fungi.S.bracken", 
"SRR20633036_fungi.S.bracken", "SRR20633037_fungi.S.bracken", "SRR20633041_fungi.S.bracken", "SRR20633042_fungi.S.bracken", "SRR20633046_fungi.S.bracken", 
"SRR20633047_fungi.S.bracken", "SRR20633049_fungi.S.bracken", "SRR20633051_fungi.S.bracken", "SRR20633057_fungi.S.bracken", "SRR20633060_fungi.S.bracken", 
"SRR20633061_fungi.S.bracken", "SRR5886210_fungi.S.bracken", "SRR5886211_fungi.S.bracken", "SRR5886212_fungi.S.bracken", "SRR5886213_fungi.S.bracken", 
"SRR5886214_fungi.S.bracken", "SRR5886215_fungi.S.bracken", "SRR5886216_fungi.S.bracken", "SRR5886217_fungi.S.bracken", "SRR5886218_fungi.S.bracken", 
"SRR5886252_fungi.S.bracken", "SRR5886253_fungi.S.bracken", "SRR5886254_fungi.S.bracken", "SRR5886273_fungi.S.bracken", "SRR5886274_fungi.S.bracken", 
"SRR5886275_fungi.S.bracken", "SRR5886276_fungi.S.bracken", "SRR5886277_fungi.S.bracken", "SRR5886278_fungi.S.bracken", "SRR5886301_fungi.S.bracken", 
"SRR5886302_fungi.S.bracken", "SRR5886324_fungi.S.bracken", "SRR5886337_fungi.S.bracken", "SRR5886338_fungi.S.bracken", "SRR5886339_fungi.S.bracken", 
"SRR5886487_fungi.S.bracken", "SRR5886488_fungi.S.bracken", "SRR5886489_fungi.S.bracken", "SRR5452621_fungi.S.bracken", "SRR5452622_fungi.S.bracken", 
"SRR5452626_fungi.S.bracken", "SRR5452627_fungi.S.bracken", "SRR5452629_fungi.S.bracken", "SRR5452633_fungi.S.bracken", "SRR5452637_fungi.S.bracken", 
"SRR5452638_fungi.S.bracken", "SRR5452639_fungi.S.bracken", "SRR5452641_fungi.S.bracken", "SRR5452643_fungi.S.bracken", "SRR5452644_fungi.S.bracken", 
"SRR5452650_fungi.S.bracken", "SRR5452656_fungi.S.bracken", "SRR5452659_fungi.S.bracken", "SRR5452660_fungi.S.bracken", "SRR5452662_fungi.S.bracken", 
"SRR5452671_fungi.S.bracken", "SRR5452676_fungi.S.bracken", "SRR5452677_fungi.S.bracken", "SRR5452678_fungi.S.bracken", "SRR5452679_fungi.S.bracken", 
"SRR5452680_fungi.S.bracken", "SRR5452681_fungi.S.bracken", "SRR5452682_fungi.S.bracken"
))

#reading in the files
library(dplyr)
#Creating data frame to hold all the sample's bracken abundances
oraldf <- data.frame(name = c("NA"))
num <- nrow(lines)
base_dir <- "~/oralSpecies"
i <- 1
#While loop goes through each sample's bracken data and adds the species name and the abundances in the sample to the oral data frame
while(i <= num){
  line <- lines$sample[i]
  path <- file.path(base_dir, line)
  df <- read.table(path, header = TRUE, sep = '\t', fill = TRUE)
  i <- i+1
  df <- data.frame(
    name = c(df$name),
    sample = c(df$new_est_reads)
)
  line <- gsub("_fungi.S.bracken", "", line)
  names(df)[names(df) == "sample"] <- line
  oraldf <- full_join(oraldf, df, by = 'name')
  oraldf[is.na(oraldf)] <- 0
}
oraldf <- slice(oraldf, -1)
print(oraldf)
write.csv(oraldf, file = "oral_merged_species3.csv")

#Preprocess
#preprocess packages
library("tidyverse")
 
#converting relative abundance

#enumerating columns
file_count <- read.csv("oral_merged_species3.csv", stringsAsFactors = FALSE, header = TRUE, row.names = 1, check.names = FALSE)
print(file_count)
 
#Getting relative abundances for the samples while
numeric_columns <- sapply(file_count, is.numeric) #Making sure not to change the chr type column
All_counts <- data.frame(apply(file_count[, numeric_columns], 2, sum))
colnames(All_counts) <- "Sum"
file_rela <- file_count
print(file_rela)
file_rela[, numeric_columns] <- sweep(file_count[, numeric_columns], 2, All_counts$Sum, "/")
file_rela <- cbind(file_count[, !numeric_columns, drop = FALSE], file_rela[, numeric_columns])
print(file_rela)
write.csv(file_rela, "oral_merged_rela3.csv")

#Splitting up the data
whole <- read.csv("oral_merged_rela3.csv", stringsAsFactors = FALSE, header = TRUE, check.names = FALSE)
 
meta.all <- read.csv(file= "~/OSCC_meta_data3.csv", stringsAsFactors = FALSE, row.names = 1, header = TRUE)
#Creating new column with more official HNC names
meta.all$HNC3 <- ifelse(meta.all$HNC2 == "no", "Normal", ifelse(meta.all$HNC2 == "yes", "HNC", "FEP"))
meta.all$HNC3 <- factor(meta.all$HNC3, levels = c("Normal", "FEP", "HNC"))
#Filtering and splitting up the data sets for analysis
rownames(whole) <- whole$name
whole <- whole[, -c(1, 2)]
whole <- whole[rowSums(whole > 0) > 3,]
print(whole)
meta1 <- subset(meta.all, batch == "batch1")
meta2 <- subset(meta.all, batch == "batch2")
meta3 <- meta.all[meta.all$HNC2 != "fep", ]
batch1 <- whole %>%
  select(all_of(rownames(meta1)))
batch2 <- whole %>%
  select(all_of(rownames(meta2)))
batch3 <- whole %>% 
  select(all_of(row.names(meta3)))
print(batch1)
print(batch2)
print(batch3)
write.csv(whole, "oral_fil_rela.csv")
