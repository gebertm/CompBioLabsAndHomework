### The Showerhead Microbiome Project - 16S rRNA Data
### Determine if relative abundance of 1. Cyanobacteria, 2. Bacteroidetes, and 3. Chloroflexi are impacted 
### by the pH of the water system
### MiSeq, 2 X 150
### Manuscript and Dataset: Gebert et al, 2018

# Question: Does pH impact the relative abundance of Cyanobacteria in municipal biofilms

# reading in necessary libraries
library(ggplot2)
library(plyr)
library(plotly)
library(tidyverse)
library(tidyr)

# Reading in OTU table --- Full dataset as a .csv
FullOTUTable <- read.csv('~/Desktop/Spring Semester - 2020 Classwork/EBIO5420 Computational Biology/Showerhead_Microbiome_Full_Combined_otu_table_wTax_noChloroMito_June2017_2000+_Reads.csv', header = TRUE, strip.white = TRUE)

# Reading in full metadata file as a .csv - metadata has been anonymized
FullMetadata <- read.csv('~/Desktop/Spring Semester - 2020 Classwork/EBIO5420 Computational Biology/Showerhead_Microbiome_Full_Metadata_Anonymized_03282020.csv', header = TRUE) 

# Saving the full OTU table (all taxa) as a data frame
FullOTUTable <- data.frame(FullOTUTable)

# Summing all read counts for each row to generate a column of total reads per each taxonomic identifier
# This will condense the enormous table down to one column - easier to complete before splitting taxonomy into 
# unique columns. 
TotalCountsPerOTU <- within(FullOTUTable, rm('X.OTU.ID', 'X', 'taxonomy')) # Removing headers without numerical data
TotalCountsPerOTU_Clean <- TotalCountsPerOTU %>% select(-contains("NTC")) %>% select(-contains("Dust")) %>% select(-contains("EXT")) # Removing extraneous samples 
TotalCountsPerOTU_Clean$ReadSum <- rowSums(TotalCountsPerOTU_Clean) # summing all the reads in the rows, saved as a new column
ReadSum_Rows <- as.data.frame(TotalCountsPerOTU_Clean$ReadSum)

# Splitting taxonomic IDs into separate columns for ease using Tidyr - currently all separated by ; in one column
# https://tidyr.tidyverse.org/reference/separate.html
FullOTU_SplitTaxa <- FullOTUTable %>% separate(taxonomy, c('Kingdom', 'Phylum', 'Class', 'Order', 'Family', 'Genus', 'Species'), sep = ";")

# Adding read sum column on to original OTU table (data frame) so that total viable read counts are included
# This will be used to calculate total relative abundance down the line
FullOTU_SplitTaxa <- FullOTU_SplitTaxa %>% add_column(ReadSum_Rows)

# Removing errant 'X' column -> miscalculated total read numbers
FullOTU_SplitTaxa <- within(FullOTU_SplitTaxa, rm('X'))

# Renaming OTU header to remove leading X.
FullOTU_SplitTaxa <- FullOTU_SplitTaxa %>% rename(OTU_ID = X.OTU.ID)

# Checking for presence of NA values in Phylum column
is.na(FullOTU_SplitTaxa)

# Remove NA rows from dataset - potentially causing problems with subsetting function
FullOTU_SplitTaxa_Clean <- na.omit(FullOTU_SplitTaxa) # removing _all_ NAs from the dataset

# Removing Extraction blanks, control samples, and errant dust samples
FullOTU_SplitTaxa_Clean <- FullOTU_SplitTaxa_Clean %>% select(-contains("NTC")) %>% select(-contains("Dust")) %>% select(-contains("EXT")) # Removing extraneous samples 

# Getting column sums for entire taxa table
AllColumnSum <-FullOTU_SplitTaxa_Clean %>% summarize_if(is.numeric, sum)

# Keep rows where Phylum column is equal to 'Cyanobacteria', 'Bacteroidetes', or 'Chloroflexi'
CyanoRowsOnly <- FullOTU_SplitTaxa_Clean[FullOTU_SplitTaxa_Clean$Phylum == " p__Cyanobacteria", ]
BactRowsOnly <- FullOTU_SplitTaxa_Clean[FullOTU_SplitTaxa_Clean$Phylum == " p__Bacteroidetes", ]
ChloroRowsOnly <- FullOTU_SplitTaxa_Clean[FullOTU_SplitTaxa_Clean$Phylum == " p__Chloroflexi", ]

# Summing all the OTU reads in each of the samples - Counts of Cyanobacteria, Bacteroidetes, Chloroflexi in each sample
Cyano_rowSum <- CyanoRowsOnly %>% summarize_if(is.numeric, sum)
Bact_rowSum <- BactRowsOnly %>% summarize_if(is.numeric, sum)
Chloro_rowSum <- ChloroRowsOnly %>% summarize_if(is.numeric, sum) 

# Creating a dataframe consisting of SampleID, sum of total reads per sample, and sum of total reads per sample for each
# of the bacterial phyla
Cyano_Merged <- rbind(Cyano_rowSum, AllColumnSum)
Bact_Merged <- rbind(Bact_rowSum, AllColumnSum)
Chloro_Merged <- rbind(Chloro_rowSum, AllColumnSum)

# Transposing the dataframe - will make downstream analysis easier
CyanoMerged_Transposed <- as.data.frame(t(Cyano_Merged))
BactMerged_Transposed <- as.data.frame(t(Bact_Merged))
ChloroMerged_Transposed <- as.data.frame(t(Chloro_Merged))

# Renaming, Column 0, V1 and V2 headers in data frame to reflect actual data - bacterial read counts per sample and total read counts per sample
Cyano_RelAbundTable <- tibble::rownames_to_column(CyanoMerged_Transposed, "ID.Number")
Cyano_RelAbundTable <- Cyano_RelAbundTable %>% rename(CyanoReadCounts = V1, TotalReadCounts = V2) 
Bact_RelAbundTable <- tibble::rownames_to_column(BactMerged_Transposed, "ID.Number")
Bact_RelAbundTable <- Bact_RelAbundTable %>% rename(BacteroidetesReadCounts = V1, TotalReadCounts = V2)
Chloro_RelAbundTable <- tibble::rownames_to_column(ChloroMerged_Transposed, "ID.Number")
Chloro_RelAbundTable <- Chloro_RelAbundTable %>% rename(ChloroflexiReadCounts = V1, TotalReadCounts = V2)

# Calculating relative abundance of Cyanobacteria/Bacteroidetes/Chloroflexi in the dataset - Relative abundance = (phylum of interest total reads per sample / total reads per sample) * 100
Cyano_RelAbundTable$CyanoRelativeAbundance <- ((Cyano_RelAbundTable$CyanoReadCounts / Cyano_RelAbundTable$TotalReadCounts) * 100)
Bact_RelAbundTable$BacterRelativeAbundance <- ((Bact_RelAbundTable$BacteroidetesReadCounts / Bact_RelAbundTable$TotalReadCounts) * 100)
Chloro_RelAbundTable$ChloroRelativeAbundance <- ((Chloro_RelAbundTable$ChloroflexiReadCounts / Chloro_RelAbundTable$TotalReadCounts) * 100)

# Combining all three phyla into one table for downstream analysis
FullRelAbundTable <- bind_cols(Cyano_RelAbundTable, Bact_RelAbundTable, Chloro_RelAbundTable)
FullRelAbundTable <- subset(FullRelAbundTable, select = -c(ID.Number1, ID.Number2, TotalReadCounts1, TotalReadCounts2))
##### Now dealing with the metadata file (creating a dataframe of sampleID and pH value) #####

# Making a dataframe of only SampleID and pH of water for each sample 
# Cleaning up data frame
FullMetadata <- as.data.frame(FullMetadata)
pH_data_Full <- FullMetadata %>% select(ID.Number, pH) # Selecting SampleID and pH columns - creating new dataframe

# Removing NAs and Non-integers ('>' characters)
pH_data_Full_clean <- pH_data_Full %>% na_if("") %>% na.omit

# Combining two data frames - generating 1 dataframe with SampleID, Cyano Relative Abundance, and pH value
# Potentially going to need to remove special characters, although pH does not need to be continuous
DataTable_PhylaRelAbund_pH <- FullRelAbundTable %>% inner_join(pH_data_Full_clean)

# Removing rows where pH is < 6.2 - very broad and not terribly informative for this study
DataTable_PhylaRelAbund_pH <- subset(DataTable_PhylaRelAbund_pH, DataTable_PhylaRelAbund_pH$pH != "< 6.2")

# Figure 1: Boxplot representing the 3 bacterial phyla and their average relative abundance
library(cowplot)
# Boxplots - x-axis: pH, y-axis: relative abundance
pH_Plot_Bacter <- ggplot(data = DataTable_PhylaRelAbund_pH, aes(x = pH, y = BacterRelativeAbundance )) +
  geom_boxplot(color="black", fill="green", alpha=0.9) + labs(x = "pH of Water Source", y = "Relative Abundance of Bacteroidetes (%)") + 
  theme(axis.text.x = element_text(angle = 70, hjust = 1))
pH_Plot_Cyano <- ggplot(data = DataTable_PhylaRelAbund_pH, aes(x = pH, y = CyanoRelativeAbundance )) +
  geom_boxplot(color="black", fill="yellow", alpha=0.9) + labs(x = "pH of Water Source", y = "Relative Abundance of Cyanobacteria (%)") +
  theme(axis.text.x = element_text(angle = 70, hjust = 1))
pH_Plot_Chloro <- ggplot(data = DataTable_PhylaRelAbund_pH, aes(x = pH, y = ChloroRelativeAbundance )) +
  geom_boxplot(color="black", fill="orange", alpha=0.9) + labs(x = "pH of Water Source", y = "Relative Abundance of Chloroplexi (%)") +
  theme(axis.text.x = element_text(angle = 70, hjust = 1))

# Scatterplots 
pH_Plot_Bacter_scatter <- ggplot(data = DataTable_PhylaRelAbund_pH, aes(x = pH, y = BacterRelativeAbundance )) +
  geom_jitter(shape=21, fill='plum', size=1.5) + labs(title = "Bacteroidetes", x = "pH of Water Source", y = "Relative Abundance (%)") +
  theme(axis.line=element_line(size=1, color='black'),
        text=element_text(family = 'Times', face='bold', size=8),
        panel.grid.major = element_line(color='grey'),
        panel.grid.minor = element_blank(),
        panel.border = element_blank(), panel.background = element_blank(),
        axis.text.x=element_text(color='black', size=8, face='bold', angle = 70, hjust = 1),
        axis.text.y=element_text(color='black', size=8, face='bold'))
pH_Plot_Cyano_scatter <- ggplot(data = DataTable_PhylaRelAbund_pH, aes(x = pH, y = CyanoRelativeAbundance )) +
  geom_jitter(shape=21, fill='red', size=1.5) + labs(title = "Cyanobacteria", x = "pH of Water Source", y = "Relative Abundance (%)") +
  theme(axis.line=element_line(size=1, color='black'),
        text=element_text(family = 'Times', face='bold', size=8),
        panel.grid.major = element_line(color='grey'),
        panel.grid.minor = element_blank(),
        panel.border = element_blank(), panel.background = element_blank(),
        axis.text.x=element_text(color='black', size=8, face='bold', angle = 70, hjust = 1),
        axis.text.y=element_text(color='black', size=8, face='bold'))
pH_Plot_Chloro_scatter <- ggplot(data = DataTable_PhylaRelAbund_pH, aes(x = pH, y = ChloroRelativeAbundance )) +
  geom_jitter(shape=21, fill='orange', size=1.5) + labs(title = "Chloroflexi", x = "pH of Water Source", y = "Relative Abundance (%)") +
  theme(axis.line=element_line(size=1, color='black'),
        text=element_text(family = 'Times', face='bold', size=8),
        panel.grid.major = element_line(color='grey'),
        panel.grid.minor = element_blank(),
        panel.border = element_blank(), panel.background = element_blank(),
        axis.text.x=element_text(color='black', size=8, face='bold', angle = 70, hjust = 1),
        axis.text.y=element_text(color='black', size=8, face='bold'))


# Using cowplot to create one figure - easier to compare side by side
plot_grid(pH_Plot_Bacter, pH_Plot_Chloro, pH_Plot_Cyano, nrow = 1, labels = c('A', 'B', 'C'))

# Renaming plots for stacked effect using cowplot
firstPlot <- pH_Plot_Bacter_scatter
secondPlot <- pH_Plot_Cyano_scatter
thirdPlot <- pH_Plot_Chloro_scatter

# Generating 1 figure from 3 plots using cowplot -- stacked effect
fullPlot <- plot_grid(firstPlot, secondPlot, thirdPlot, labels=c('', ''), ncol=1)
fullPlot

# Does pH effect relative abundance of Cyanobacteria?
# Linear Regression + Pearson Correlation  
model_bact <- lm(DataTable_PhylaRelAbund_pH$BacterRelativeAbundance ~ DataTable_PhylaRelAbund_pH$pH)
print(summary(model_bact))  

model_chloro <- lm(DataTable_PhylaRelAbund_pH$ChloroRelativeAbundance ~ DataTable_PhylaRelAbund_pH$pH)
print(summary(model_chloro))

model_cyano <- lm(DataTable_PhylaRelAbund_pH$CyanoRelativeAbundance ~ DataTable_PhylaRelAbund_pH$pH)
print(summary(model_cyano))


Model_bact2 <- cor.test(as.numeric(DataTable_PhylaRelAbund_pH$BacterRelativeAbundance), as.numeric(DataTable_PhylaRelAbund_pH$pH),
         method="pearson",
         continuity = FALSE,
         conf.level = 0.95)
model_bact2

model_chloro2 <- cor.test(as.numeric(DataTable_PhylaRelAbund_pH$ChloroRelativeAbundance), as.numeric(DataTable_PhylaRelAbund_pH$pH),
                        method="pearson",
                        continuity = FALSE,
                        conf.level = 0.95)
model_chloro2

model_cyano2 <- cor.test(as.numeric(DataTable_PhylaRelAbund_pH$CyanoRelativeAbundance), as.numeric(DataTable_PhylaRelAbund_pH$pH),
                        method="pearson",
                        continuity = FALSE,
                        conf.level = 0.95)
model_cyano2


