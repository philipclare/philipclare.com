---
title: 'Australian Parental Supply of Alcohol Longitudinal Study (APSALS) Analysis Code'
subtitle: 'R Analysis Code'
summary: R Analysis Code
authors:
- admin
tags:
- Alcohol
- Adolescence
- Longitudinal cohort study
- Causal inference
categories: []
date: "2019-03-14T00:00:00Z"
lastmod: "2019-06-22T00:00:00Z"
featured: false
draft: false
image:
  placement: 2
  caption: ""
  focal_point: ""
  preview_only: false
projects:
- APSALS
- causal-inference
---

This repository contains R code used in a number of articles using the Australian Parental Supply of Alcohol Longitudinal Study (APSALS).

## The overall effect of parental supply of alcohol across adolescence on alcohol-related harms in early adulthood—a prospective cohort study
Code for all analysis in the article by Clare et al 2020 published in Addiction: https://doi.org/10.1111/add.15005

| Description | R-code |
| --- | --- |
| 1 - Multiple imputation | [Multiple imputation](https://github.com/philipclare/APSALS/blob/master/Code/2020a/A1_multiple_imputation.R) |
| 2 - Final data creation | [Final data creation](https://github.com/philipclare/APSALS/blob/master/Code/2020a/A2_final_data_creation.R) |
| 3 - LTMLE analysis of parental supply of alcohol on harms using the package 'ltmle' (1). | [LTMLE analysis](https://github.com/philipclare/APSALS/blob/master/Code/2020a/A3_ltmle_analysis.R) |
| 4 - LTMLE marginal structural model analysis of earlier initiation of supply. | [LTMLE MSM analysis](https://github.com/philipclare/APSALS/blob/master/Code/2020a/A4_ltmle_msm_analysis.R) |
| 5 - Sensitivity analysis using naive analysis (GLMs) | [Naive analysis](https://github.com/philipclare/APSALS/blob/master/Code/2020a/A5_naive_analysis.R) |
| 6 - E-Value sensitivity analysis | [E-value analysis](https://github.com/philipclare/APSALS/blob/master/Code/2020a/A6_evalue_analysis.R) |
| 7 - Secondary analysis of exposure (parental supply) beginning at age 15. | [LTMLE - supply from age 15](https://github.com/philipclare/APSALS/blob/master/Code/2020a/A7_secondary_supply_at_age_15.R) |
| 8 - Sensitivity analysis with lagged predictors. | [LTMLE - lagged predictors](https://github.com/philipclare/APSALS/blob/master/Code/2020a/A8_sensitivity_lagged_predictors.R) |
| 9 - Sensitivity analysis controlling for past obervations of outcome | [LTMLE - control for past outcomes](https://github.com/philipclare/APSALS/blob/master/Code/2020a/A9_sensitivity_control_for_past_outcomes.R) |
| 10 - Sensitivity analysis with continuous outcomes. | [LTMLE - continuous outcomes](https://github.com/philipclare/APSALS/blob/master/Code/2020a/A10_sensitivity_continuous_outcomes.R) |

## Changes in mental health and help-seeking among young Australian adults during the COVID-19 pandemic: a prospective cohort study
R and Stata code for all analysis of APSALS COVID-19 Alcohol paper, Upton et al 2021 published in Psychological Medicine: https://doi.org/10.1017/S0033291721001963

| Description | R-code |
| --- | --- |
| 1 - Missing data patterns | [Missing data](https://github.com/philipclare/APSALS/blob/master/Code/2021a/S1_Covid_MH_Missing_data_patterns.do) |
| 2 - Multiple imputation | [Multiple imputation](https://github.com/philipclare/APSALS/blob/master/Code/2021a/S2_Covid_MH_Imputation.R) |
| 3 - Final data creation | [Final data creation](https://github.com/philipclare/APSALS/blob/master/Code/2021a/S3_Covid_MH_Data_finalise_after_imputation.R) |
| 4 - Import MI data into Stata for analysis | [Stata import](https://github.com/philipclare/APSALS/blob/master/Code/2021a/S4_Covid_MH_Import_mh_data_into_Stata.do) |
| 5 - Primary analysis with data in long-form | [Primary long-form analysis](https://github.com/philipclare/APSALS/blob/master/Code/2021a/S5_Covid_MH_Primary mh long analysis.do) |
| 6 - Primary analysis with data in wide-form | [Primary wide-form analysis](https://github.com/philipclare/APSALS/blob/master/Code/2021a/S6_Covid_MH_Primary mh wide analysis.do) |
| 7 - Additional analysis comparing COVID subsample to full APSALS cohort | [Additional table](https://github.com/philipclare/APSALS/blob/master/Code/2021a/S7_Covid_MH_Table E1.R) |

## Alcohol use among young Australian adults during the COVID-19 pandemic: a prospective cohort study 
R and Stata code for all analysis of APSALS COVID-19 Alcohol paper, Clare et al 2021 published in Addiction: https://doi.org/10.1111/add.15599

| Description | R-code |
| --- | --- |
| 1 - Multiple imputation | [Multiple imputation](https://github.com/philipclare/APSALS/blob/master/Code/2021b/S1_multiple_imputation.R) |
| 2 - Final data creation | [Final data creation](https://github.com/philipclare/APSALS/blob/master/Code/2021b/S2_data_finalise_after_imputation.R) |
| 3 - Import MI data into Stata for analysis | [Stata import](https://github.com/philipclare/APSALS/blob/master/Code/2021b/S3_import_data_into_stata.do) |
| 4 - Cross-sectional descriptives in R | [Cross-sectional descriptives](https://github.com/philipclare/APSALS/blob/master/Code/2021b/S3_import_data_into_stata.do) |
| 5 - Longitudinal descriptives in Stata | [Longitudinal descriptives](https://github.com/philipclare/APSALS/blob/master/Code/2021b/S5_longitudinal_descriptives.do) |
| 6 - Primary analyses using mixed effects models with discrete time | [Primary analyis](https://github.com/philipclare/APSALS/blob/master/Code/2021b/S6_primary_analysis.do) |
| 7 - Sensitivity analysis using continuous time and 'high risk' consumption variable | [Sensitivity analysis](https://github.com/philipclare/APSALS/blob/master/Code/2021b/S7_sensitivity_analysis.do) |

## Tobacco and vaping characteristics over 5 years in the Australian Parental Supply of Alcohol Longitudinal Study (APSALS) 
R and Stata code for all analysis of APSALS COVID-19 Tobacco paper, Boland et al 2024, in progress

| Description | R-code |
| --- | --- |
| 1 - Multiple imputation | [Multiple imputation](https://github.com/philipclare/APSALS/blob/master/Code/2024a/S1_imputation.R) |
| 2 - Final data creation | [Final data creation](https://github.com/philipclare/APSALS/blob/master/Code/2024a/S2_data_finalise.do) |
| 3 - Descriptive statistics | [Descriptives](https://github.com/philipclare/APSALS/blob/master/Code/2024a/S3_descriptives.do) |
| 4 - Analysis of raw trends | [Trends](https://github.com/philipclare/APSALS/blob/master/Code/2024a/S4_trends.do) |
| 5 - Multivariable regression models | [Models](https://github.com/philipclare/APSALS/blob/master/Code/2024a/S5_models.do) |
| 6 - Correlation analysis | [Correlation](https://github.com/philipclare/APSALS/blob/master/Code/2024a/S6_correlation.do) |.

## Does the trajectory of alcohol use and related harm differ based on the age of initiation to alcohol? Results from a prospective cohort study.
R and Stata code for all analysis of APSALS Initiation trajectories paper, Clare et al 2024, being presented at KBS2024.

| Description | R-code |
| --- | --- |
| 1 - Create data subset from APSALS cohort data | [Data creation](https://github.com/philipclare/APSALS/blob/master/Code/2024b/R1_data_creation.do) |
| 2 - Multiple imputation | [Multiple imputation](https://github.com/philipclare/APSALS/blob/master/Code/2024b/R2_multiple_imputation.R) |
| 3 - Test model fit of nonlinear terms | [Model fit](https://github.com/philipclare/APSALS/blob/master/Code/2024b/R3_model_fit.do) |
| 4 - Primary analysis | [Primary analysis](https://github.com/philipclare/APSALS/blob/master/Code/2024b/R4_primary_analysis.do) |
| 5 - Secondary analysis | [Secondary analysis](https://github.com/philipclare/APSALS/blob/master/Code/2024b/R5_secondary_analysis.do) |
| 6 - Pool MI results using Rubin's rubles to get final estimates | [Pool results](https://github.com/philipclare/APSALS/blob/master/Code/2024b/R6_pool_MI_results.R) |
| 7 - Create primary analysis figures using ggplot | [Create primary figures](https://github.com/philipclare/APSALS/blob/master/Code/2024b/R7_create_primary_figures.R) |
| 8 - Create secondary analysis figures using ggplot | [Create secondary figures](https://github.com/philipclare/APSALS/blob/master/Code/2024b/R8_create_secondary_figures.R) |
| 9 - Descriptive statistics | [Descriptives](https://github.com/philipclare/APSALS/blob/master/Code/2024b/R9_descriptive_statistics.do) |
| 10 - Generate missing data summary for appendix | [Missing data](https://github.com/philipclare/APSALS/blob/master/Code/2024b/R10_missing_data_summary.do) |


1. Lendle SD, Schwab J, Petersen ML, van der Laan MJ. ltmle: An R Package Implementing Targeted Minimum Loss-Based Estimation for Longitudinal Data. Journal of Statistical Software. 2017;81(1):1-21.
