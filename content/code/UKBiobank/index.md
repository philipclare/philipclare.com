﻿---
title: 'UK Biobank Analysis Code'
subtitle: 'R Analysis Code'
summary: R Analysis Code
authors:
- admin
tags:
- Physical activity
- Health
- Longitudinal cohort study
categories: []
date: "2025-03-03T00:00:00Z"
lastmod: "2025-03-03T00:00:00Z"
featured: false
draft: false
image:
  placement: 2
  caption: ""
  focal_point: ""
  preview_only: false
projects:
- UK-Biobank
---

## LPA and MVPA analysis
Code for all analysis in the article examining the associations of LPA and MVPA with mortality (Luo, Clare et al 2025).

| Description | R Code |
| --- | --- |
| 1 - Data extraction and cleaning. | [Data cleaning](https://github.com/philipclare/UKBiobank/blob/master/Code/2025a/1_Data_cleaning.R) |
| 2 - Finalise data in preparation for imputation. | [Finalise data](https://github.com/philipclare/UKBiobank/blob/master/Code/2025a/2_Data_finalise.R) |
| 3 - Multiple imputation - impute intermittent missing data | [Imputation](https://github.com/philipclare/UKBiobank/blob/master/Code/2025a/3_Multiple_imputation.R) |
| 4 - Final data creation - finalise imputed data and structure for analysis | [Finalise data](https://github.com/philipclare/UKBiobank/blob/master/Code/2025a/4_Finalise_imputed_data.R) |
| 5 - Evaluate number of degrees of freedom for splines. | [Model fit](https://github.com/philipclare/UKBiobank/blob/master/Code/2025a/5_Model_fit.R) |
| 6 - Fit best performing model based on model fit tests. | [Final models](https://github.com/philipclare/UKBiobank/blob/master/Code/2025a/6_Final_model_estimation.R) |
| 7 - Create primary analysis plots using ggplot2. | [Primary figures](https://github.com/philipclare/UKBiobank/blob/master/Code/2025a/7_Primary_figures.R) |
| 8 - Create sensitivity analysis plots using ggplot2. | [Sensitivity figures](https://github.com/philipclare/UKBiobank/blob/master/Code/2025a/8_Sensitivity_figures.R) |
| 9 - Estimate relative effects (RRs and RDs) from primary analysis. | [Relative results](https://github.com/philipclare/UKBiobank/blob/master/Code/2025a/9_Relative_results_HPC.R) |
| 10 - Create relative effect plots. | [Relative results figures](https://github.com/philipclare/UKBiobank/blob/master/Code/2025a/10_Relative_results_figures.R) |
| 11 - Stratified analysis by sex and age group. | [Age and sex](https://github.com/philipclare/UKBiobank/blob/master/Code/2025a/11_By_age_and_sex.R) |
| 12 - Relative effects for specific counterfactual scenarios. | [Scenarios](https://github.com/philipclare/UKBiobank/blob/master/Code/2025a/12_Scenario_comparisons.R) |

