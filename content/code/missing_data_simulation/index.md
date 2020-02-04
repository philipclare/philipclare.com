---
title: 'Comparison of methods of adjusting for time-varying confounding with missing data – A Monte-Carlo simulation study'
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

This repository contains the Stata and R code used in the missing data simulation by Clare et al. 2019

The Stata code creates a series of quasi-random datasets (3 different datasets were used in the simulation) using a pre-specified data structure.
Analysis code runs all analyses on those datasets, and saves the results. Note that the code is written to run on the UNSW Katana cluster computer, which uses a scheduler to sequentially call the R script and pass it the particular iterations of the data to be processed in each step. To run the code on a standard computer, the code can be edited so the parameters passed by the Katana scheduler are defined internally.

| Description | Code |
| --- | --- |
| S1 - Data creation of Dataset 1 - Stata Code | [Data creation code](https://github.com/philipclare/missing_data_simulation/blob/master/Code/S1_data_creation_dataset1.do) | [Download code](https://philipclare.github.io/missing_data_simulation/Code/S1_data_creation_dataset1.do) |
| S2 - Data creation of Dataset 2 - Stata Code | [Data creation code](https://github.com/philipclare/missing_data_simulation/blob/master/Code/S2_data_creation_dataset2.do) | [Download code](https://philipclare.github.io/missing_data_simulation/Code/S2_data_creation_dataset2.do) |
| S3 - Data creation of Dataset 3 - Stata Code | [Data creation code](https://github.com/philipclare/missing_data_simulation/blob/master/Code/S3_data_creation_dataset3.do) | [Download code](https://philipclare.github.io/missing_data_simulation/Code/S3_data_creation_dataset3.do) |
| S4 - Analysis - R Code | [Analysis code](https://github.com/philipclare/missing_data_simulation/blob/master/Code/S4_analysis_code.R) | [Download code](https://philipclare.github.io/missing_data_simulation/Code/S4_analysis_code.R) |
