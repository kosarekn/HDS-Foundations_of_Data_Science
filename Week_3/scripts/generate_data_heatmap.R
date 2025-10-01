set.seed(123)  # For reproducibility

# Parameters
num_genes <- 100
num_samples <- 10

# Generate gene names and sample names
genes <- paste0("Gene", 1:num_genes)
samples <- paste0("Sample", 1:num_samples)

# Simulating counts from a Negative Binomial distribution
# Different mean expression to add some variability
base_means <- rpois(num_genes, lambda=20) + 10  # Baseline mean expression per gene

counts <- sapply(1:num_samples, function(i) {
  rnbinom(num_genes, size=10, mu=base_means)
})

# Set row and column names
rownames(counts) <- genes
colnames(counts) <- samples

# Convert to a matrix to confirm
counts <- as.matrix(counts)

write.csv(counts,"/Users/f002yt8/Documents/GitHub/HDS-Foundations_of_Data_Science/Week_3/Data/heatmap_counts.csv")



# Create metadata
metadata <- data.frame(
  Sample = samples,
  Disease_Status = sample(c("Case", "Control"), num_samples, replace = TRUE),
  Sex = sample(c("Male", "Female"), num_samples, replace = TRUE),
  stringsAsFactors = FALSE
)


write.csv(metadata,"/Users/f002yt8/Documents/GitHub/HDS-Foundations_of_Data_Science/Week_3/Data/heatmap_metadata.csv",
          row.names = FALSE)





