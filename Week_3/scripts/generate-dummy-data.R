# Function to generate data frame
generate_dataframe <- function(n, start_id) {
  # Generate data frame
  df <- data.frame(
    # Unique Participant ID starting from the provided start_id
    Participant_ID = paste0("P", start_id:(start_id + n - 1)),
    # Sex (randomly distributed)
    Sex = sample(c("Male", "Female"), n, replace = TRUE),
    # Age (normally distributed between 18 and 85)
    Age = round(rnorm(n, mean = 50, sd = 15)),
    # Socioeconomic Status
    Socioeconomic_Status = sample(c("Low", "Medium", "High"), n, replace = TRUE),
    # Disease Status
    Disease_Status = sample(c("Case", "Control"), n, replace = TRUE)
  )
  
  # Ensure Age is within 18-85 range
  df$Age <- pmax(18, pmin(df$Age, 85))
  
  # Generate CReactive_Protein with different distributions for Case and Control
  df$CReactive_Protein <- ifelse(df$Disease_Status == "Control",
                                 # Controls: mostly low values
                                 round(runif(n, min = 0.3, max = 1.0), 2),
                                 # Cases: higher values
                                 round(runif(n, min = 1.0, max = 50), 2)
  )
  
  return(df)
}

# Number of data frames to generate
num_dataframes <- 5

# Number of participants per data frame
n_participants <- 200

# Base directory for saving files
base_dir <- "/Users/f002yt8/Documents/GitHub/HDS-Foundations_of_Data_Science/Week_3/Data/In-Class-Exercises/"

# Create the directory if it doesn't exist
dir.create(base_dir, recursive = TRUE, showWarnings = FALSE)

# Initialize the starting ID
current_start_id <- 1

# Generate and save multiple data frames
for (i in 1:num_dataframes) {
  # Set a seed for reproducibility within each iteration
  set.seed(i * 100)
  
  # Generate data frame with unique IDs
  df <- generate_dataframe(n_participants, current_start_id)
  
  # Create filename
  filename <- paste0("dummy_data_", i, ".csv")
  
  # Full path
  full_path <- file.path(base_dir, filename)
  
  # Save to CSV
  write.csv(df, full_path, row.names = FALSE)
  
  # Print confirmation
  cat("Generated and saved", filename, "with IDs", 
      current_start_id, "to", current_start_id + n_participants - 1, "\n")
  
  # Update the starting ID for the next iteration
  current_start_id <- current_start_id + n_participants
}

# Optional: List the files created
list.files(base_dir, pattern = "dummy_data_")