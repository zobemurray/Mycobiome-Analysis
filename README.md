# Characterizing the Fungal Community Landscape and Building a Predictive Model for Head and Neck Cancer

## Work done in collaberation with Ya-Mei Hu, Yi Zhang, Tao Ren, and Zheng Xia during the Biomedical & Bioinformatics Internship and Training Experience (B-BRITE) summer program through the Knight Cancer Institute, Oregon Health & Science University, Portland, OR.

### QCandClassification: uses KneadData to do quality control on the sequence data, removing low quality reads with Trimmomatic and human (hg19) contaminants from sequences with bowtie2. Classification of each sequence's fungi was done using Kraken2 and abundances were estimated using the Bracken tool. Script was made usign vim.

### Preprocessing: the rest of the code was done via RStudio. Here I loaded all the Bracken species abundance files and put them into a single data frame. I then converted the count values into relative abundance. After filtering out non-significant abundancies, I created three new data frames that hold the data from either one of the two datasets or the combined data sets without the FEP (intra-oral epithelial polyps) samples (just HNC and Healthy/Normal cases). These four data frames were analyzed using the following code.

### MaAsLin2: MaAsLin2 was used for finding significant associations between species abundance and different variables from the metadata. MaAsLin2 produces visualizations for multivariant associations. File shows how I created a heatmap for the univariant association analysis (Batch2).

### Diversity: alpha and beta diversity were done using the Shannon and Bray Curtis indexes respectfully. A boxplot was created using ggpubr and the PCoA scatter plot was made using ggplot2.

### PredictionModel: Creating a Random Forest model using the relative abundance data with the HNC and Normal samples. This was done with the caret package.
