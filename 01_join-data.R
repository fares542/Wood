# Load libraries
library("readxl")
library("tidyr")

# Join datafiles together into ds
ds <- NULL
# Files to read
file_is <- 1 : 11
# Read each file
for(file_i in file_is) {
  # Read one file
  ds_temp <- read_excel(paste0("data_raw/datafile_", file_i, ".xlsx"), col_names = FALSE)
  ds_temp$file_i <- file_i  
  if (is.null(ds)) {
    ds <- ds_temp
  } else {
    ds <- rbind(ds, ds_temp)
  }
}

# Make ds tidy
ds_tidy <- pivot_wider(
  data = ds,
  id_cols = "file_i",
  names_from = "...1",
  values_from = "...2"
)
write.csv(ds_tidy, file = "data_interim/ds_tidy.csv")

