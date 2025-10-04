# ============================================================
# install_packages.R
# Script to install all required R packages for microbiome and metabolomics analysis
# ============================================================

# Helper function to install CRAN packages if missing
install_if_missing <- function(pkg) {
  if (!requireNamespace(pkg, quietly = TRUE)) {
    install.packages(pkg, repos = "https://cloud.r-project.org")
  }
}

# ------------------------------------------------------------
# 1. Install CRAN packages
# ------------------------------------------------------------
cran_packages <- c(
  "dplyr", "tidyr", "stringr", "tibble", "ggplot2", "ggpubr",
  "vegan", "RColorBrewer", "gridExtra", "pheatmap", "patchwork",
  "devtools", "remotes", "pairwiseAdonis", "DRomics", "ggfortify",
  "janitor", "tidyverse", "ARTool"
)

invisible(lapply(cran_packages, install_if_missing))

# ------------------------------------------------------------
# 2. Install Bioconductor packages
# ------------------------------------------------------------
if (!requireNamespace("BiocManager", quietly = TRUE)) {
  install.packages("BiocManager", repos = "https://cloud.r-project.org")
}

bioc_packages <- c(
  "dada2", "phyloseq", "limma", "DESeq2",
  "SummarizedExperiment", "ctc", "ComplexHeatmap", "InteractiveComplexHeatmap"
)

invisible(lapply(bioc_packages, function(pkg) {
  if (!requireNamespace(pkg, quietly = TRUE)) {
    BiocManager::install(pkg, ask = FALSE, update = FALSE)
  }
}))

# ------------------------------------------------------------
# 3. Install GitHub packages (if not already installed)
# ------------------------------------------------------------
if (!requireNamespace("remotes", quietly = TRUE)) {
  install.packages("remotes", repos = "https://cloud.r-project.org")
}

github_packages <- list(
  "jokergoo/ComplexHeatmap",
  "jokergoo/InteractiveComplexHeatmap",
  "pmartinezarbizu/pairwiseAdonis/pairwiseAdonis"
)

for (repo in github_packages) {
  pkg <- basename(repo)
  if (!requireNamespace(pkg, quietly = TRUE)) {
    remotes::install_github(repo, dependencies = TRUE, upgrade = "never")
  }
}

# ------------------------------------------------------------
# 4. Confirmation message
# ------------------------------------------------------------
message("All required packages have been checked and installed successfully.")
