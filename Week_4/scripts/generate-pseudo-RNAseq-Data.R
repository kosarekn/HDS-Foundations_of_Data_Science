# Install necessary packages if missing
if (!requireNamespace("BiocManager", quietly = TRUE))
  install.packages("BiocManager")

if (!requireNamespace("biomaRt", quietly = TRUE))
  BiocManager::install("biomaRt")

library(biomaRt)
library(dplyr)

# Connect to Ensembl using biomaRt
ensembl <- useMart("ensembl", dataset = "hsapiens_gene_ensembl")

# Get all protein-coding genes gene symbols
genes_df <- getBM(attributes = c("hgnc_symbol", "gene_biotype"),
                  filters = "biotype",
                  values = "protein_coding",
                  mart = ensembl)

# Remove empty gene symbols
genes_df <- genes_df %>% 
  filter(hgnc_symbol != "" & !is.na(hgnc_symbol)) %>%
  distinct(hgnc_symbol)

# How many?
cat("Number of unique protein-coding gene symbols:", nrow(genes_df), "\n")

set.seed(123)

# Sample 500 unique protein-coding genes
selected_genes <- sample(genes_df$hgnc_symbol, 500, replace = FALSE)

# Sample names (5 diseased, 5 control)
sample_names <- c(paste0("Disease_", 1:5), paste0("Control_", 1:5))

# Simulate counts matrix
counts_matrix <- matrix(nrow = 500, ncol = 10)
rownames(counts_matrix) <- selected_genes
colnames(counts_matrix) <- sample_names

# Mean expression for controls (random between 20 and 100)
control_means <- runif(500, min = 20, max = 100)

# Select 50 genes to be upregulated in disease
upregulated_genes <- sample(1:500, 50)

# Dispersion parameter for NB simulation
dispersion <- 10

for (i in 1:500) {
  disease_mean <- control_means[i]
  if (i %in% upregulated_genes) {
    disease_mean <- disease_mean * runif(1, 1.5, 3)
  }
  
  counts_matrix[i, 1:5] <- rnbinom(5, mu = disease_mean, size = dispersion)
  counts_matrix[i, 6:10] <- rnbinom(5, mu = control_means[i], size = dispersion)
}

counts_matrix <- round(counts_matrix)

# Quick check
head(counts_matrix[,1:6])

# Convert to integer matrix (counts)
counts_matrix <- round(counts_matrix)

# Print first few rows and columns
print(head(counts_matrix[, 1:6]))

# Optional: save to file
write.csv(counts_matrix, "/Users/f002yt8/Documents/GitHub/HDS-Foundations_of_Data_Science/Week_4/Data/pseudo_rnaseq_counts.csv", quote = FALSE)

# The result: counts_matrix with 500 genes (rows) and 10 samples (columns)