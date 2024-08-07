﻿---
title: 'POINT Analysis Code'
subtitle: 'R Analysis Code'
summary: R Analysis Code
authors:
- admin
tags:
- Opioids
- Causal inference
categories: []
date: "2019-03-14T00:00:00Z"
lastmod: "2019-06-20T00:00:00Z"
featured: false
draft: false
image:
  placement: 2
  caption: ""
  focal_point: ""
  preview_only: false
projects:
- POINT
---

The association between alcohol use and pain in people with chronic non-cancer pain prescribed pharmaceutical opioids – a prospective cohort study.
This repository contains R code used in the TMLE analysis of POINT data on the effect of alcohol exposure on chronic pain, by Clare et al. 2019

| Description | Github R code | Download R code |
| --- | --- | --- |
| P1 - Multiple imputation | [Multiple imputation code](https://github.com/philipclare/POINT/blob/master/Code/P1_multiple_imputation.R) | [Download code](https://philipclare.github.io/POINT/Code/P1_multiple_imputation.R) |
| P2 - Longitudinal sample descriptives (article Table 2) | [Longitudinal descriptives code](https://github.com/philipclare/POINT/blob/master/Code/P2_descriptives.R) | [Download code](https://philipclare.github.io/POINT/Code/P2_descriptives.R) |
| P3 - LTMLE primary analysis of alcohol consumption on pain using the package 'ltmle' (1). | [LTMLE analysis code](https://github.com/philipclare/POINT/blob/master/Code/P3_ltmle_primary.R) | [Download code](https://philipclare.github.io/POINT/Code/P3_ltmle_primary.R) |
| P4 - LTMLE sensitivity analysis excluding those who used alcohol to cope with their pain | [LTMLE sensitivity analysis code](https://github.com/philipclare/POINT/blob/master/Code/P4_ltmle_sensitivity.R) | [Download code](https://philipclare.github.io/POINT/Code/P4_ltmle_sensitivity.R) |
| P5 - E-Value sensitivity analysis (2) | [E-value analysis code](https://github.com/philipclare/POINT/blob/master/Code/P5_evalue_analysis.R) | [Download code](https://philipclare.github.io/POINT/Code/P5_evalue_analysis.R) |

1. Lendle SD, Schwab J, Petersen ML, van der Laan MJ. ltmle: An R Package Implementing Targeted Minimum Loss-Based Estimation for Longitudinal Data. Journal of Statistical Software. 2017;81(1):1-21.
2. VanderWeele TJ, Ding P. Sensitivity Analysis in Observational Research: Introducing the E-Value. Annals of Internal Medicine. 2017;167(4):268-274.
J, Petersen ML, van der Laan MJ. ltmle: An R Package Implementing Targeted Minimum Loss-Based Estimation for Longitudinal Data. Journal of Statistical Software. 2017;81(1):1-21.
