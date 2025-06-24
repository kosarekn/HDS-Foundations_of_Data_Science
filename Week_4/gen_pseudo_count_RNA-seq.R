# Set seed for reproducibility
set.seed(123)

# Define parameters
num_genes <- 100       # number of genes
num_samples <- 5       # number of samples

# Simulate mean expression levels for each gene (could represent average counts)
# Let's assume genes have varying mean counts from low (5) to high (1000)
gene_means <- runif(num_genes, min=5, max=1000)

# Initialize a matrix to store counts: rows = genes, columns = samples
counts <- matrix(nrow=num_genes, ncol=num_samples)

# For each gene and sample, generate counts from Poisson with gene-specific mean
for (i in 1:num_genes) {
  counts[i, ] <- rpois(num_samples, lambda = gene_means[i])
}

# Convert to data frame with gene names
gene_names <- paste0("Gene", sprintf("%03d", 1:num_genes))
colnames(counts) <- paste0("Sample", 1:num_samples)
counts_df <- data.frame(Gene = gene_names, counts, check.names=FALSE)

# Write to CSV file
write.csv(counts_df, "/Users/f002yt8/Documents/GitHub/HDS-Foundations_of_Data_Science/Week_4/Data/data.csv", row.names = FALSE)

# Print message to confirm
cat("Simulated RNA-seq count data written to 'data.csv'\n")