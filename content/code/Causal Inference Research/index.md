---
title: 'Causal Inference Research Analysis Code'
subtitle: 'Stata and R Analysis Code'
summary: Stata and R Analysis Code
authors:
- admin
tags:
- Monte-Carlo simulation study
- Causal inference
categories: []
date: "2019-03-15T00:00:00Z"
lastmod: "2019-03-22T00:00:00Z"
featured: false
draft: false
image:
  placement: 2
  caption: ""
  focal_point: ""
  preview_only: false
projects:
- causal-inference
---

This repository contains the Stata and R code used in methodological research by Clare et al.

Comparison of methods of adjusting for time-varying confounding under misspecification – A Monte-Carlo simulation study.
The Stata code creates a series of quasi-random datasets using a pre-specified data structure.
Analysis code runs all analyses on those datasets, and saves the results. Note that the code is written to run on Google Compute clusters, using a Linux OS (in order to run the syntax on a Windows-based machine, some changes to the way parallel processing is required (because Windows is not compatible with 'FORK').

Two types of standard error estimates were used, so two sets of analysis code are included. The first calculates standard errors using bootstrapping. The second calculates model-based standard errors, using influence curves for TMLE.

| Description | Github code | Download code |
| --- | --- | --- |
| S1 - Data creation Stata Code | [Data creation code](https://github.com/philipclare/misspecification_simulation/blob/master/Code/S1_data_creation.do) | [Download code](https://philipclare.github.io/misspecification_simulation/Code/S1_data_creation.do) |
| S2 - Analysis with bootstrap SEs - R Code | [Analysis code - Bootstrap](https://github.com/philipclare/misspecification_simulation/blob/master/Code/S2_analysis_code_bootstrap.R) | [Download code](https://philipclare.github.io/misspecification_simulation/Code/S2_analysis_code_bootstrap.R) |
| S3 - Analysis with model-based/influence curve SEs - R Code | [Analysis code - Alternative](https://github.com/philipclare/misspecification_simulation/blob/master/Code/S3_analysis_code_IC.R) | [Download code](https://philipclare.github.io/misspecification_simulation/Code/S3_analysis_code_IC.R) |

Comparison of methods of adjusting for time-varying confounding with missing data – A Monte-Carlo simulation study.
The Stata code creates a series of quasi-random datasets (3 different datasets were used in the simulation) using a pre-specified data structure.
Analysis code runs all analyses on those datasets, and saves the results. Note that the code is written to run on the UNSW Katana cluster computer, which uses a scheduler to sequentially call the R script and pass it the particular iterations of the data to be processed in each step. To run the code on a standard computer, the code can be edited so the parameters passed by the Katana scheduler are defined internally.

| Description | Code |
| --- | --- |
| S1 - Data creation of Dataset 1 - Stata Code | [Data creation code](https://github.com/philipclare/missing_data_simulation/blob/master/Code/S1_data_creation_dataset1.do) | [Download code](https://philipclare.github.io/missing_data_simulation/Code/S1_data_creation_dataset1.do) |
| S2 - Data creation of Dataset 2 - Stata Code | [Data creation code](https://github.com/philipclare/missing_data_simulation/blob/master/Code/S2_data_creation_dataset2.do) | [Download code](https://philipclare.github.io/missing_data_simulation/Code/S2_data_creation_dataset2.do) |
| S3 - Data creation of Dataset 3 - Stata Code | [Data creation code](https://github.com/philipclare/missing_data_simulation/blob/master/Code/S3_data_creation_dataset3.do) | [Download code](https://philipclare.github.io/missing_data_simulation/Code/S3_data_creation_dataset3.do) |
| S4 - Analysis - R Code | [Analysis code](https://github.com/philipclare/missing_data_simulation/blob/master/Code/S4_analysis_code.R) | [Download code](https://philipclare.github.io/missing_data_simulation/Code/S4_analysis_code.R) |

Targeted Maximum Likelihood Estimation to adjust for time-varying confounding – a tutorial paper.
This repository contains data and a number of snippets of R code, used in the TMLE tutorial by Clare, Dobbins, Bruno and Mattick.

| Description | Markdown | Github R code | Download R code |
| --- | --- | --- | --- |
| Creating the longitudinal dataset used in example analyses. Data creation is done using the package 'simcausal' (1). | [Data Creation Markdown](https://philipclare.github.io/tmletutorial/Markdown/data-creation.nb.html) | [Data Creation Code](https://github.com/philipclare/tmletutorial/blob/master/Code/data-creation.R) | [Download code](https://philipclare.github.io/tmletutorial/Code/data-creation.R) |
| Cross-sectional TMLE analysis, both manually and using the package 'tmle' (2). | [Cross-sectional Analysis Markdown](https://philipclare.github.io/tmletutorial/Markdown/cross-sectional.nb.html) | [Cross-sectional Analysis Code](https://github.com/philipclare/tmletutorial/blob/master/Code/cross-sectional.R) | [Download code](https://philipclare.github.io/tmletutorial/Code/cross-sectional.R) |
| Longitudinal TMLE with a single outcome measurement, both manually and using the package 'ltmle' (3). | [Single Outcome Longitudinal Markdown](https://philipclare.github.io/tmletutorial/Markdown/long-single-y.nb.html) | [Single Outcome Longitudinal Code](https://github.com/philipclare/tmletutorial/blob/master/Code/long-single-y.R) | [Download code](https://philipclare.github.io/tmletutorial/Code/long-single-y.R) |
| Longitudinal TMLE with a repeated outcome measurement, both manually and using the package 'ltmle' (3). | [Repeated Outcome Longitudinal Markdown](https://philipclare.github.io/tmletutorial/Markdown/long-repeated-y.nb.html) | [Repeated Outcome Longitudinal Code](https://github.com/philipclare/tmletutorial/blob/master/Code/long-repeated-y.R) | [Download code](https://philipclare.github.io/tmletutorial/Code/long-repeated-y.R) |

The longitudinal dataset, [ldata.RData](https://philipclare.github.io/tmletutorial/ldata.RData), is also included in the repository: https://github.com/philipclare/tmletutorial

1. Sofrygin O, van der Laan Mark J, Neugebauer R. simcausal R Package: Conducting Transparent and Reproducible Simulation Studies of Causal Effect Estimation with Complex Longitudinal Data. Journal of Statistical Software. 2017;81(2):1-47.
2. Gruber S, van der Laan MJ. tmle: An R Package for Targeted Maximum Likelihood Estimation. Journal of Statistical Software. 2012;51(13):1-35.
3. Lendle SD, Schwab J, Petersen ML, van der Laan MJ. ltmle: An R Package Implementing Targeted Minimum Loss-Based Estimation for Longitudinal Data. Journal of Statistical Software. 2017;81(1):1-21.
 Petersen ML, van der Laan MJ. ltmle: An R Package Implementing Targeted Minimum Loss-Based Estimation for Longitudinal Data. Journal of Statistical Software. 2017;81(1):1-21.
