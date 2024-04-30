---
title: 'Health and Retirement Study (HRS) Cohort Analysis'
subtitle: 'R and Stata Analysis Code'
summary: R and Stata Analysis Code
authors:
- admin
tags:
- Loneliness
- Population survey
- Cohort study
categories: []
date: "2022-04-04T00:00:00Z"
lastmod: "2022-04-04T00:00:00Z"
featured: false
draft: false
image:
  placement: 2
  caption: ""
  focal_point: ""
  preview_only: false
projects:
- HRS
---

This repository contains R and Stata code used in a number of articles using the Health and Retirement Study (HRS) Cohort Analysis (1).

## When loneliness becomes a problem: Point prevalence and sustained loneliness comparisons in older American adults of the Health and Retirement Study
Code for all analysis in the article by Surkalim et al 2023, published in the Journals of Gerontology: https://doi.org/10.1093/geronb/gbad062

| Description | Code |
| --- | --- |
| S1 - Data Cleaning in Stata | [Data cleaning](https://github.com/philipclare/HRS/blob/master/2023/S1_Data_cleaning.do) |
| S2 - Imputation in R | [Imputation](https://github.com/philipclare/HRS/blob/master/2023/S2_Imputation.R) |
| S3 - Post-processing of imputed data in R | [Post-processing](https://github.com/philipclare/HRS/blob/master/2023/S3_Post_processing.R) |
| S4 - Data finalise and import into Stata | [Data finalise](https://github.com/philipclare/HRS/blob/master/2023/S4_Data_finalise.do) |
| S5 - Sample characteristics | [Sample characteristics](https://github.com/philipclare/HRS/blob/master/2023/S5_Sample_characteristics.do) |
| S6 - Raw trends | [Raw trends](https://github.com/philipclare/HRS/blob/master/2023/S6_Raw_trends.do) |
| S7 - Trend analysis - sustained | [Trend models - sustained](https://github.com/philipclare/HRS/blob/master/2023/S7_Trend_analyses_sustained.do) |
| S8 - Trend analysis - point | [Trend models - point](https://github.com/philipclare/HRS/blob/master/2023/S8_Trend_analyses_point.do) |
| S9 - Trend analysis - scale indicator | [Trend models - scale](https://github.com/philipclare/HRS/blob/master/2023/S9_Trend_analyses_scale_indicator.do) |
| S10 - Multivariable analysis | [Multivariable analysis](https://github.com/philipclare/HRS/blob/master/2023/S10_Multivariable_analysis.do) |

## Exercise to socialize? Bidirectional relationships between physical activity and loneliness in middle-aged and older American adults
Code for all analysis in the article by Surkalim et al 2024, published in the American Journal of Epidemiology: https://doi.org/10.1093/aje/kwae001

| Description | Code |
| --- | --- |
| S0 - Data Cleaning in Stata | [Data cleaning](https://github.com/philipclare/HRS/blob/master/2024/S0_data_cleaning.do) |
| S1 - Imputation in R | [Imputation](https://github.com/philipclare/HRS/blob/master/2024/S1_multiple_imputation.R) |
| S2 - Post-processing of imputed data in R | [Post-processing](https://github.com/philipclare/HRS/blob/master/2023/S2_data_finalise.R) |
| S3 - RI-CLPM models using lavaan in R | [RI-CLPM](https://github.com/philipclare/HRS/blob/master/2023/S3_RICLPM_analysis_using_lavaan.do) |
| S4 - Pooled results from imputation using Rubin's rules | [Pooled results](https://github.com/philipclare/HRS/blob/master/2023/S4_pooled_results.do) |
| S5 - Mixed effects models for comparison purposes | [GLMMS](https://github.com/philipclare/HRS/blob/master/2023/S5_GLMMs.do) |
| S6 - Socio-demographics table | [Demographics](https://github.com/philipclare/HRS/blob/master/2023/S6_table_1.do) |
1. Sonnega A, Faul JD, Ofstedal MB, Langa KM, Phillips JWR, Weir DR. Cohort Profile: the Health and Retirement Study (HRS). International Journal of Epidemiology. 2014;43(2):576-85.