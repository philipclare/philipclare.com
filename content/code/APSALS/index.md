---
title: 'The overall effect of parental supply of alcohol across adolescence on alcohol-related harms in early adulthood – a prospective cohort study'
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

This repository contains R code used in the TMLE analysis of parental supply of alcohol on harms in the APSALS dataset by Clare et al. 2019

| Description | R-code |
| --- | --- |
| A1 - Multiple imputation | [Multiple imputation code](https://github.com/philipclare/APSALS/blob/master/Code/A1_multiple_imputation.R) |
| A2 - Final data creation | [Final data creation code](https://github.com/philipclare/APSALS/blob/master/Code/A2_final_data_creation.R) |
| A3 - LTMLE analysis of parental supply of alcohol on harms using 'ltmle' (1). | [LTMLE analysis code](https://github.com/philipclare/APSALS/blob/master/Code/A3_ltmle_analysis.R) |
| A4 - Paramaterisation of marginal structural model from LTMLE analysis of parental supply of alcohol on harms using 'ltmleMSM' (1). | [LTMLE MSM analysis code](https://github.com/philipclare/APSALS/blob/master/Code/A4_ltmle_msm_analysis.R) |
| A5 - Naive analysis using generalised linear models | [Naive analysis code](https://github.com/philipclare/APSALS/blob/master/Code/A5_naive_analysis.R) |
| A6 - E-Value sensitivity analysis | [E-value analysis code](https://github.com/philipclare/APSALS/blob/master/Code/A6_evalue_analysis.R) |
| A7 - Secondary analysis comparing supply from age 15 to no supply | [Secondary analysis code](https://github.com/philipclare/APSALS/blob/master/Code/A7_secondary_supply_at_age_15.R) |
| A8 - Sensitivity analysis including only lagged covariates/confounders | [Sensitivity analysis 1 code](https://github.com/philipclare/APSALS/blob/master/Code/A8_sensitivity_lagged_predictors.R) |
| A9 - Sensitivity analysis including past outcomes as confounders | [Sensitivity analysis 2 code](https://github.com/philipclare/APSALS/blob/master/Code/A9_sensitivity_control_for_past_outcomes.R) |
| A10 - Sensitivity analysis using continuous rather than binary outcomes | [Sensitivity analysis 3 code](https://github.com/philipclare/APSALS/blob/master/Code/A10_sensitivity_continuous_outcomes.R) |

1. Lendle SD, Schwab J, Petersen ML, van der Laan MJ. ltmle: An R Package Implementing Targeted Minimum Loss-Based Estimation for Longitudinal Data. Journal of Statistical Software. 2017;81(1):1-21.