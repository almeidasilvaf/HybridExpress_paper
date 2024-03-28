
library(here)
library(tidyverse)

# Supplementary Table S1: enrichment stats for the cotton data ----
load(here("products", "result_files", "cotton_enrichment_all.rda"))

readr::write_tsv(
    cotton_enrichment_all, 
    file = here("products", "tables", "sup_table_S1.tsv")
)

# Supplementary Table S2: enrichment stats for the rice data set ----
load(here("products", "result_files", "rice_enrichment_all.rda"))

readr::write_tsv(
    rice_enrichment_all, 
    file = here("products", "tables", "sup_table_S2.tsv")
)

# Writing .xlsx files
openxlsx::write.xlsx(
    x = list(S1 = cotton_enrichment_all, S2 = rice_enrichment_all),
    file = here("products", "tables", "sup_tables.xlsx")
)

