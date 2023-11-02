# Freshwater-Responses-to-Salinization
By: Donya A. Mohamed1, Richard H. Walker, Abigail C. Belvin, Joshua B. Mouser, Amanda Pennino, Stephen Plont, Christopher D. Robinson, Lucy B. Smith, Jyoti Thapa, Carl E. Zipper, Paul L. Angermeier, Sally A. Entrekin

# Background
# Abstract
Freshwater salinization is increasing due to climate change, agriculture, urbanization, mining, and other anthropogenic activities, threatening freshwater animals and their ecosystems. Still, studies of taxon-specific responses and comparisons across major aquatic groups are rare. Understanding taxon-specific salt responses will allow us to better understand taxon sensitivities and therefore help prioritize conservation efforts across groups. We conducted a comprehensive review of freshwater animal responses, characterizing 5924 responses across 585 articles of freshwater mollusks, crustaceans, zooplankton, non-arthropod invertebrates, insects, fishes, and amphibians. Common focal ions across all studies and groups included Na+and Cl- based ions, as opposed to more toxic ions such as K+, HCO3-, Mg2+ and ion mixtures that commonly result from resource extraction, irrigation, and urban infrastructure. As expected, negative responses to salinization predominated within all taxonomic groups across all laboratory and field studies:  78% for non-arthropod invertebrates, 68% for zooplankton, 62% for amphibians, 62% for insects, 56% for mollusks, 56% for freshwater crustaceans, and 51% for fishes. Insects were the most well-studied of these taxa, with 26% of reviewed articles focusing on insect-salt responses. Effect sizes were calculated for select taxa at the population-level and compared within the context of different ions and primary threats. Insect-specific responses to salinization have been reported, but other taxon-specific salt-response predictions are less known. We predict that taxa with shorter life spans, external respiratory structures, and multiple life stages are traits that confer greater sensitivity to rising salt ion concentrations in freshwater systems. Knowledge of taxon-specific responses could help identify the most immediate conservation needs across taxonomic groups. 

# Methods
Effect sizes were calculated using Hedges d, which is defined as the difference in mean between the treatment and control groups, divided by the pooled SD X J, where J incorporates the precision of effect size estimates based on the sample sizes
![image](https://github.com/donya-moee/Freshwater-Responses-to-Salinization/assets/144273386/9d5e28f8-e599-4f0f-9725-52d28e2fbd04)
![image](https://github.com/donya-moee/Freshwater-Responses-to-Salinization/assets/144273386/d474719c-2804-4af8-9dc6-3fe9e8a0a0b6)

## Review Process
We started with 585 papers in the database across all taxa and identified papers that we could extract effect size data from by identifying if they had mean ctrl/trt data.. After that, we looked at the level of biological responses and decided to focus on  just population level responses (676). We then focused on pop abundance. From the population abundance responses, we identified the top 3 primary threats and decided to focus on biotic responses to mining and agriculture. . From the road salt responses, we compared responses across 3 main ion groupings. Mining responses focused on specific conductance, but had associated ions of ca, mg, so4, and hco3. We did not look at these ions nested because they were not the same across primary threats. The reason why we approached the analysis this way is due to data availability 
![image](https://github.com/donya-moee/Freshwater-Responses-to-Salinization/assets/144273386/f0251204-a011-4a6e-b13d-07e63e3669fb)


## Meta-Analysis
We used the appropriate methods from Ferreria et al 2023 and Jackson et al 2016 to conduct the meta-analysis. first, we calculate individual effect sizes (hedges d) per taxa per study. Then, we conduct Nonparametric bootstrapping to determine confidence intervals around means. Overall effect size is then calculated using the random effects model of meta-analysis, which considers within-study variance and between-study variance associated with effect sizes. subgroup analyses are used to estimate mean effect sizes for subgroups using the random effects model, and finally, heterogeneity test to determine variation between and within each category (ANOVA). 
![image](https://github.com/donya-moee/Freshwater-Responses-to-Salinization/assets/144273386/34c5e645-37d6-46eb-a067-17f9fe3e7c40)


# Results
Results are produced by running the code. The final output should be the last boxplot at the end comparing taxon responses to road salt vs mining. 

# How to run the code
You run the code all the way through using only one excel file: "updated ES w J.xlsx". I personally have a folder saved on my drive and had to set my working directory to access that file. If you do the same, you should be able to simply set the working directory and run the code all the way through and it should work. 
