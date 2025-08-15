# Load library
library(TCGAbiolinks)
library(SummarizedExperiment)

# Define project
project <- "TCGA-BRCA"

# 1. Query RNA-seq count data
query_expr <- GDCquery(
  project = project,
  data.category = "Transcriptome Profiling",
  data.type = "Gene Expression Quantification",
  workflow.type = "STAR - Counts"
)

# Download RNA-seq data
GDCdownload(query_expr)

# Prepare RNA-seq data: this returns a SummarizedExperiment object
data_expr <- GDCprepare(query_expr)

# Access count matrix
counts <- assay(data_expr)
print(dim(counts))       # number of genes x samples
head(counts[,1:5])       # inspect counts for first 5 samples

# Access sample metadata for expression data
sample_metadata <- colData(data_expr)
head(sample_metadata)

library(dplyr)

# Convert to data.frame
df_meta <- as.data.frame(sample_metadata)

# Identify columns that are lists
list_cols <- sapply(df_meta, is.list)
print(list_cols)

# Flatten list columns by extracting the first element or converting to character
for (col in names(df_meta)[list_cols]) {
  # If all list elements are length 1, unlist safely
  if(all(sapply(df_meta[[col]], length) == 1)) {
    df_meta[[col]] <- sapply(df_meta[[col]], `[`, 1)
  } else {
    # Otherwise convert to character (e.g. collapsed string)
    df_meta[[col]] <- sapply(df_meta[[col]], function(x) paste(x, collapse = ";"))
  }
}

# Now write to CSV
write.csv(df_meta, "/Users/f002yt8/Documents/GitHub/HDS-Foundations_of_Data_Science/Final_Project/data/meta_data.csv", row.names = FALSE)