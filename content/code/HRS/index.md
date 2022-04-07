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
Code for all analysis in the article by Surkalim et al 2022

| Description | Code |
| --- | --- |
| S1 - Data Cleaning in Stata | [Data cleaning](https://github.com/philipclare/HRS/blob/master/Paper 1/S1_Data_cleaning.do) |
| S2 - Imputation in R | [Imputation](https://github.com/philipclare/HRS/blob/master/Paper 1/S2_Imputation.R) |
| S3 - Post-processing of imputed data in R | [Post-processing](https://github.com/philipclare/HRS/blob/master/Paper 1/S3_Post_processing.R) |
| S4 - Data finalise and import into Stata | [Data finalise](https://github.com/philipclare/HRS/blob/master/Paper 1/S4_Data_finalise.do) |
| S5 - Sample characteristics | [Sample characteristics](https://github.com/philipclare/HRS/blob/master/Paper 1/S5_Sample_characteristics.do) |
| S6 - Raw trends | [Raw trends](https://github.com/philipclare/HRS/blob/master/Paper 1/S6_Raw_trends.do) |
| S7 - Trend analysis - sustained | [Trend models - sustained](https://github.com/philipclare/HRS/blob/master/Paper 1/S7_Trend_analyses_sustained.do) |
| S8 - Trend analysis - point | [Trend models - point](https://github.com/philipclare/HRS/blob/master/Paper 1/S8_Trend_analyses_point.do) |
| S9 - Trend analysis - scale indicator | [Trend models - scale](https://github.com/philipclare/HRS/blob/master/Paper 1/S9_Trend_analyses_scale_indicator.do) |
| S10 - Multivariable analysis | [Multivariable analysis](https://github.com/philipclare/HRS/blob/master/Paper 1/S10_Multivariable_analysis.do) |

1. Sonnega A, Faul JD, Ofstedal MB, Langa KM, Phillips JWR, Weir DR. Cohort Profile: the Health and Retirement Study (HRS). International Journal of Epidemiology. 2014;43(2):576-85.