---
title: 'Targeted Maximum Likelihood Estimation to adjust for time-varying confounding – a tutorial paper'
subtitle: 'R Markdown and Analysis Code'
summary: R Markdown and Analysis Code
authors:
- admin
tags:
- Tutorial paper
- Causal inference
categories: []
date: "2018-12-04T00:00:00Z"
lastmod: "2018-12-03T00:00:00Z"
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

This repository contains data and a number of snippets of R code, used in the TMLE tutorial by Clare, Dobbins, Bruno and Mattick.

| Description | Markdown | R-code |
| --- | --- | --- |
| Creating the longitudinal dataset used in example analyses. Data creation is done using the package 'simcausal' (1). | [Data Creation Markdown](https://philipclare.github.io/tmletutorial/Markdown/data-creation.nb.html) | [Data Creation Code](https://philipclare.github.io/Code/data-creation.R) |
| Cross-sectional TMLE analysis, both manually and using the package 'tmle' (2). | [Cross-sectional Analysis Markdown](https://philipclare.github.io/tmletutorial/Markdown/cross-sectional.nb.html) | [Cross-sectional Analysis Code](https://philipclare.github.io/Code/cross-sectional.R) |
| Longitudinal TMLE with a single outcome measurement, both manually and using the package 'ltmle' (3). | [Single Outcome Longitudinal Markdown](https://philipclare.github.io/tmletutorial/Markdown/long-single-y.nb.html) | [Single Outcome Longitudinal Code](https://philipclare.github.io/Code/long-single-y.R) |
| Longitudinal TMLE with a repeated outcome measurement, both manually and using the package 'ltmle' (3). | [Repeated Outcome Longitudinal Markdown](https://philipclare.github.io/tmletutorial/Markdown/long-repeated-y.nb.html) | [Repeated Outcome Longitudinal Code](https://philipclare.github.io/Code/long-repeated-y.R) |

The longitudinal dataset, [ldata.RData](/ldata.RData), is also included in the repository.

1. Sofrygin O, van der Laan Mark J, Neugebauer R. simcausal R Package: Conducting Transparent and Reproducible Simulation Studies of Causal Effect Estimation with Complex Longitudinal Data. Journal of Statistical Software. 2017;81(2):1-47.
2. Gruber S, van der Laan MJ. tmle: An R Package for Targeted Maximum Likelihood Estimation. Journal of Statistical Software. 2012;51(13):1-35.
3. Lendle SD, Schwab J, Petersen ML, van der Laan MJ. ltmle: An R Package Implementing Targeted Minimum Loss-Based Estimation for Longitudinal Data. Journal of Statistical Software. 2017;81(1):1-21.
 Petersen ML, van der Laan MJ. ltmle: An R Package Implementing Targeted Minimum Loss-Based Estimation for Longitudinal Data. Journal of Statistical Software. 2017;81(1):1-21.
