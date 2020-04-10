# The Effect of pH on Different Bacterial Phylum in Showerhead Biofilms

## **Introduction** ##

ph of the surrounding environment, be it in the environment or in culture, is an important determinant of where microbes live (Lauber et al, 2008).
Some bacteria prefer a low pH environment, while others prefer a more neutral, or even highly basic environment. pH also impacts 
the metabolism of microbial cells, as well as cell physiology. Understanding how environmental conditions, like pH, predict the abundance of a
certain bacterial phylum is an important step in being able to predict what bacteria live where, especially when considering potential 
pathogens. 
	Municipal water systems are known to harbor many types of bacteria, and pH of these systems varies based on source of water and geographic 
location (Gebert et al, 2018). Given the importance of pH in determining where some microbes can be found, understanding how biofilm bacterial communities
are effected by pH can be an important step in determining what types of bacteria reside in municipal water systems, and potentially help to better understand how
pH effects the bacteria across many different biomes. 

This knowledge of the greater impact and influence of pH on microbial assembly and function has lead me to ask the question,
_"does pH impact the relative abundance of certain bacterial phylum in municipal biofilms?"_

  
## **Summary of the Data**

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

## **Type of Data**

**Format:** The data is stored as two large .csv files - one containing the metadata for each sample, the other containing the SampleID, a column with all the taxonomy present
in the dataset, numbers corresponding to the number of sequencing reads for each of the taxonomic reads in each of the samples (i.e., a tally of different bacterial taxa
in each sample). 

**Size of data:** Metadata - 151KB / OTU table - 7.6 MB
Line Count: Metadata - 622 lines, 22 columns / 5,764 rows (Taxonomic IDs), 609 columns (Sample IDs)

**Challenges:** Both tables are very large, so looking through each cell for inconsistencies will not be feasible. Code will have to be written to take into account that there
is some variation in data recording (for example pH of less than 6 is recorded as <6, and that some data is missing altogether - blanks and zeros). Another challenge will 
be parsing the enormous files to look at a very small subset of the data, and subsequently merging the two parsed data frames into one working document. There are also some 
columns (controls and extraneous unrelated samples) mixed in that will need to be removed. 

## Analysis ##

The published study looked specifically at one genus of bacteria in the biofilm samples, given its clinical significance. While it is important to better understand sources
and routes of pathogenic exposure in our day to day lives, it is equally as important to better understand how pH predicts what other types of bacteria are present,
both in built systems like plumbing, and out in the environment (for example, in soil). The larger ecological question of _how does pH impact bacterial assembly_ 
can be addressed by looking at how relative abundance of different bacterial phylum are impacted by differences in pH. 
	One of the challenges involved with this kind of analysis is that we cannot say for certain that pH of the environment is the direct cause of shifts 
in relative abundance. It is very challenging, in a system as complicated as a biofilm, with many moving parts, so isolate one environmental factor and attempt to correlate it with
an outcome like relative abundance. Although we can not for certain say that pH is definitively and solely causing the differences in relative abundance in biofilms of certain bacterial 
phylum, we can begin to look at what could potentially be driving these ecological differences and begin to better understand the roles that environmental factors play in presence of 
certain bacteria.

The analysis will include a linear regression, since both variables are _continuous_, looking at pH vs. relative abundance of a few interesting bacterial phylum, for example, 
Cyanobacteria. This will allow me to say something about the relationship between relative abundance of a certain bacterial phylum and pH of the environment.


#### _References:_
Gebert MJ, Delgado-Baquerizo M, Oliverio AM, Webster TM, Nichols LM, Honda JR, Chan ED, Adjemian J, Dunn RR, Fierer N. 2018. Ecological analyses of mycobacteria in showerhead biofilms and their relevance to human health. 
mBio 9:e01614-18. [https://doi.org/10.1128/mBio.01614-18](https://doi.org/10.1128/mBio.01614-18)