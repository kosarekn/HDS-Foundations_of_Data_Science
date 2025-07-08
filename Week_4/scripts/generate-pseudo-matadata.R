sample_names <- c(paste0("Disease_", 1:5), paste0("Control_", 1:5))

# Create sample metadata data.frame
set.seed(42)
sample_metadata <- data.frame(
  sampleID = sample_names,
  condition = factor(rep(c("Disease", "Control"), each = 5)),
  age = sample(40:70, 10, replace = TRUE),
  sex = sample(c("M", "F"), 10, replace = TRUE),
  batch = sample(c("Batch1", "Batch2"), 10, replace = TRUE)
)

# Set rownames as sample IDs for easy matching
rownames(sample_metadata) <- sample_metadata$sampleID

# View metadata
print(sample_metadata)

# Write out metadata
write.csv(sample_metadata,"/Users/f002yt8/Documents/GitHub/HDS-Foundations_of_Data_Science/Week_4/Data/pseudo_metadata.csv")