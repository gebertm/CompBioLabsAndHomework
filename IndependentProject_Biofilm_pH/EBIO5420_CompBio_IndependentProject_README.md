# EBIO 5420: Computational Biology

# The Effect of Environmental pH on Different Bacterial Phyla Residing in Showerhead Biofilms 

## The main question to be addressed using these data is: _"how does the pH of water in premise plumbing
systems effect the relative abundance of different biofilm-residing bacterial taxa at the phylum level."_

## *Ecological Background:* _pH dependencies, biofilms, and the Showerhead Microbiome Project_
ph of the surrounding environment, be it in the environment or in culture, is an important determinant of where microbes live (Lauber et al, 2008, 1).
Some bacteria prefer a low pH environment, while others prefer a more neutral, or even highly basic environment. pH also impacts 
the metabolism of microbial cells, as well as cell physiology. Understanding how environmental conditions, like pH, predict the abundance of a
certain bacterial phylum is an important step in being able to predict what bacteria live where, especially when considering potential 
pathogens. 
	Municipal water systems are known to harbor many types of bacteria, and pH of these systems varies based on source of water and geographic 
location (Gebert et al, 2018, 2). Generally, these bacteria live in complex communities within an extracellular matrix composed of "extracellular polymeric substances" (ESP),
secreted by the bacteria. Given the importance of pH in determining where some microbes can be found, understanding how biofilm bacterial communities
are effected by pH can be an important step in determining what types of bacteria reside in municipal water systems, and potentially help to better understand how
pH effects the bacteria across many different biomes. Understanding how environmental factors shape bacterial communities can also be an important component 
of disease epidemiology. Predicting the presence of certain bacterial taxa based on environmental traits can help to better predict potential areas of exposure, and
routes of transmission. 

## *Showerhead Microbiome Project: Background*
The overall goal of the original study was to determine what factors (geographic location, water chemistry, water source, etc) influence the 
relative abundance and biogeographic variation in the genus _Mycobacterium_. The study set out to collect biofilms from municipal and well-water fed 
showerheads across the United States and Europe. Since genus _Mycobacterium_ contains potential pathogens, understanding what contributes to their
presence and survival in showerhead biofilms is an important first step in better understanding the epidemiology of disease.

Volunteer participants across the US and Europe contributed a swab from their household showerhead, which was then sent to CU Boulder for bacterial analysis
using high-throughput sequencing technology. Along with the swab, participants also provided geographic location, basic water chemistry using a dipstrip (for example, 
pH, chlorine, iron concentration) water source, and basic information about their showerheads (material, spray pattern). Metadata was compiled for each participant 
and compared to the relative abundance of genus _Mycobacterium_ across the sample set, as well as the relative abundance of specific mycobacterial species to determine
if different species (especially pathogens) were more abundant in different parts of the US in Europe.

The study looked to determine the presence and relative abundance of genus _Mycobacterium_ in the biofilm samples, and to determine specifically which species 
of mycobacteria were present in the sample. Using the metadata provided by the participants, researchers looked for biogeographic patterns and predictors of presence
and relative abundance of both innocuous and pathogenic mycobacteria.


## Methods

The data for the study was a result of a 2018 publication titled [*'Ecological analyses of Mycobacteria in showerhead biofilms and their relevance to human health'*](https://mbio.asm.org/content/9/5/e01614-18.abstract)

The 16S rRNA data were produced by a high-throughput sequencing effort of 700+ biofilm swabs from premise plumbing biofilm swabs from across the United States and Europe.
The process consisted of recruiting volunteer participants to collect biofilm from their showerheads, sending it back to the University of Colorado, and subsequently, extracting and
sequencing the bacterial DNA on the swab. The data was then processed using the USearch pipeline (Edgar) to pick operational taxonomic units (OTUs) and to classify the OTUs using
a reference database (Greengenes 16S database in this case). 
The resulting information, after sequencing and data processing, was a table of all the bacterial taxa that were present in the biofilm sample 
collected on the swab (a proxy for the biofilm that was collecting in the showerhead as a whole, as well as in the premise plumbing). 
	Also collected, using inexpensive test strips, was basic water chemistry data, which included a rough estimate of pH. 
 
The initial data itself consisted of 2 Excel files - one OTU table (which consisted of sampleID with corresponding read counts and taxonomic identification), and one metadata file, populated with a tremendous amount
of information regarding water chemistry, as well as geographic location, and basic information about the showerhead itself (material, use frequency, etc). Neither file was particularly large (given it was the output
of the raw sequence data, which was much larger). The metadata file was 151KB, while the OTU table was 7.6 MB. Some of the issues that were initially noted was small inconsistencies in data reporting

## Approach

In the original analyses, the focus was primarily on the potential respiratory pathogen, mycobacteria. Relative abundance of genus Mycobacterium was determined by comparing number of reads of mycobacteria to the
number of total reads per sample (# of mycobacterial reads for sample x / # of total reads for sample x). This allows for one to determine how much of the biofilm swab sample bacterial community was made up
of genus Mycobacterium. The relative abundance of genus Mycobacterium was then compared to the collected water chemistry data to look for patterns or correlations, for example, with levels of chlorine. 

The data was originally stitched together using Excel. Figures were made either in R or using a propriety statistical analysis package. 

My approach and analysis was done entirely in R. Starting with the raw data (a complete OTU table in which samples with less than 2000 reads had already been removed, and a complete metadata file), and
in order to create a fully reproducible work flow, I began my analyses by choosing three bacterial phyla (Bacteroidetes, Cyanobacteria, and Chloroflexi) in order to further investigate how pH effected each
taxa individually. This involved first splitting the 'taxonomy' column into the individual components of the Linnaean classifaction system, so that sorting by individual phylum would be much easier. It was also important
to remove any samples initially that did not need to be included in the analysis (for example, clean control samples, as well as samples that were not from biofilms).	

Next, it was important to begin to remove any inconsistencies and missing data from the dataset, to prevent any downstream issues. For example, this involved removing NAs and any holes from the table. 

Given the sheer volume of the dataset, it was important to parse the OTU table so that just the 3 phyla of interest were represented, with all the samples of interest included. This condensing a very large table into
one that is only the read counts for each sample where the phyla are present. With a condensed table, the next two steps were calculating total read counts per sample for each of the taxa in each sample, as well as the
total read counts for each sample. This allows for the calculation of relative abundance for each individual phylum. 


The final step, after cleaning up the table, parsing out the phyla that were not of interest, and calculating relative abundance for each of the phyla per sample, was to combine the pH readings from the metadata, which
involved combining to dataframes. 

The result of the code is an abridged table, with all relavent samples present, parsed by phyla, with corresponding taxon of interest reads per sample, total reads per sample, and relative abundance (%). This allowed 
for two graphs to be made for each of the taxa of interest, as well as statistical tests to be run to determine how each bacterial phylum responded to the pH of water in a premise plumbing system. 


## Results and Concluding Statements

Looking at both the graphical representations of the data, as well as the output from the linear regression, it appears as though there is no strong correlation between the pH of the water in the premise plumbing 
system and the relative abundance of each of the bacterial taxa. This does not necessarily mean that pH is not having an effect on bacterial relative abundance for Bacteroidetes, Cyanobacteria, and Chloroflexi, but 
rather it means that there is not a strong enough correlation to say anything definitive regarding the response to this environmental parameter. This helps to potentially address, albeit on a surface level, my question
of how does pH impact the relative abundance of bacteria in biofilms. 

This is not surprising for 2 reasons, 1) because it is very difficult to disentangle the effects of multiple environmental parameters on biofilm residing bacterial communities, and 2) it pH likely does not impact 
bacterial taxa in a linear fashion, given that each taxa can have a range of tolerances.



#### _References:_
1. Lauber, C.L., Strickland, M.S., Bradford, M.A., Fierer, Noah The influence of soil properties on the structure of bacterial and fungal communities across land-use types. Soil Biology and Biochemistry, 2008. 40(9): p. 2407 - 2415.
[https://doi.org/10.1016/j.soilbio.2008.05.021](https://doi.org/10.1016/j.soilbio.2008.05.021)

2. Gebert MJ, Delgado-Baquerizo M, Oliverio AM, Webster TM, Nichols LM, Honda JR, Chan ED, Adjemian J, Dunn RR, Fierer N. 2018. Ecological analyses of mycobacteria in showerhead biofilms and their relevance to human health. 
mBio 9:e01614-18. [https://doi.org/10.1128/mBio.01614-18](https://doi.org/10.1128/mBio.01614-18)








