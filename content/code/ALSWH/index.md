---
title: 'Australian Longitudinal Study of Women’s Health (ALSWH) Analysis Code'
subtitle: 'R and Stata Analysis Code'
summary: R and Stata Analysis Code
authors:
- admin
tags:
- Physical activity
- Health
- Longitudinal cohort study
- Causal inference
categories: []
date: "2022-11-10T00:00:00Z"
lastmod: "2022-11-10T00:00:00Z"
featured: false
draft: false
image:
  placement: 2
  caption: ""
  focal_point: ""
  preview_only: false
projects:
- ALSWH
- causal-inference
---

## Causal effects of physical activity patterns on health-related quality of life
Code for all analysis in the article by Nguyen-duy et al 2023a.

| Description | R Code |
| --- | --- |
| 1 - Data extraction - pull relevant variables from each wave | [Data extraction](https://github.com/philipclare/ALSWH/blob/master/Code/2022a/1_Data_Extraction.R) |
| 2 - Merge data - merge waves and create derived variables | [Merge data](https://github.com/philipclare/ALSWH/blob/master/Code/2022a/2_Data_Merge.R) |
| 3 - Multiple imputation - impute intermittent missing data | [Imputation](https://github.com/philipclare/ALSWH/blob/master/Code/2022a/3_Multiple_Imputation.R) |
| 4 - Final data creation - finalise imputed data and structure for analysis | [Finalise data](https://github.com/philipclare/ALSWH/blob/master/Code/2022a/4_Data_Finalise.R) |
| 5 - LTMLE analysis - using dynamic regimes based on age, using the package 'ltmle' (1). | [Naive analysis](https://github.com/philipclare/ALSWH/blob/master/Code/2022a/5_Dynamic_Regimes.R) |
| 6 - Sensitivty analysis using lower physical activity cut-point. | [Sensitivity 1](https://github.com/philipclare/ALSWH/blob/master/Code/2022a/6_Dynamic_Regimes_Sensitivity1.R) |
| 7 - Sensitivty analysis excluding variables wholly missing in some waves. | [Sensitivity 1](https://github.com/philipclare/ALSWH/blob/master/Code/2022a/7_Dynamic_Regimes_Sensitivity2.R) |
| 8 - Pool results across imputations and create analysis figures | [Pool results](https://github.com/philipclare/ALSWH/blob/master/Code/2022a/8_Pool_Results.R) |

## Physical activity trajectories and associations with health-related quality of life
Code for all analysis in the article by Nguyen-duy et al 2023b.

| Description | R Code |
| --- | --- |
| 1 - Data extraction - pull relevant variables from each wave | [Data extraction](https://github.com/philipclare/ALSWH/blob/master/Code/2022b/1_Data_Extraction.R) |
| 2 - Multiple imputation - impute intermittent missing data | [Imputation](https://github.com/philipclare/ALSWH/blob/master/Code/2022b/2_Multiple_Imputation.R) |
| 3 - Final data creation - finalise imputed data and structure for analysis | [Finalise data](https://github.com/philipclare/ALSWH/blob/master/Code/2022b/3_Data_Finalise.R) |
| 4 - Data import - import imputed data into Stata for analysis | [Stata import](https://github.com/philipclare/ALSWH/blob/master/Code/2022b/4_Data_Import.do) |
| 5 - Assess model fit - check number of classes using information criteria | [Model fit](https://github.com/philipclare/ALSWH/blob/master/Code/2022b/5_Model_Fit.do) |
| 6 - Class probabilities - estimate class probabilities from best fitting model | [Class probabilities](https://github.com/philipclare/ALSWH/blob/master/Code/2022b/6_Class_Probabilities.do) |
| 7 - BCH Weights - estimate BCH weights based on BCH method (2). | [BCH Weights](https://github.com/philipclare/ALSWH/blob/master/Code/2022b/7_Calculate_BCH_Weights.do) |
| 8 - ML models - regress class membership on baseline covariates using ML method (2). | [ML Models](https://github.com/philipclare/ALSWH/blob/master/Code/2022b/8_Latent_Class_Regressions_ML.do) |
| 9 - BCH models - distal outcome models and regression of class membership on baseline covariates using BCH method (2). | [BCH Models](https://github.com/philipclare/ALSWH/blob/master/Code/2022b/9_Distal_Models_BCH.do) |

1. Lendle SD, Schwab J, Petersen ML, van der Laan MJ. ltmle: An R Package Implementing Targeted Minimum Loss-Based Estimation for Longitudinal Data. Journal of Statistical Software. 2017;81(1):1-21.
2. Vermunt JK. Latent Class Modeling with Covariates: Two Improved Three-Step Approaches. Political Analysis. 2010;18(4):450-469.



