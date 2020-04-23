# Arguments passed through to R from Katana
args <- commandArgs(trailingOnly = TRUE)

packages <- "/home/z3312911/RPackages"
workdir <- "/home/z3312911/tutorial/"

.libPaths(packages)

libs <- c("tmle","ltmle","SuperLearner","simcausal","MASS","ranger","doParallel","foreach","lme4")
missing <- !libs %in% installed.packages()
if (any(missing)) {
  install.packages(libs[missing])
}

library("tmle")
library("ltmle")
library("SuperLearner")
library("simcausal")
library("MASS")
library("ranger")
library("parallel")
library("doParallel")
library("foreach")
library("lme4")

datacreation <- function() {
  
  # Data creation using 'simcausal'
  # Creates 3 z-distributed baseline (time-constant) variables (ba, bb, bc)
  # Then create a normally distruted 'latent' variable, u_t
  # Initialise the confounder 'l' based on baseline covariates and 'u'
  # Initialise the exposure variable based on baseline covariates and initial 'l'
  # For each t in 1-4, create a new version of u, l and a based on previous observations
  # Create y variables for each t, based on ALL u,l,a 'prior' to that y, as well as y_t-1
  D <- DAG.empty() + 
    node("ba", distr="rnorm", mean=0, sd = 1) +
    node("bb", distr="rnorm", mean=0, sd = 1) +
    node("bc", distr="rnorm", mean=0, sd = 1) +
    
    node("u", t=0, distr="rnorm", mean=0, sd = 1) +
    node("c", t=0, distr="rbern", prob=0) +
    node("l", t=0, distr="rbern", prob=plogis(-2 + 1.5*u[t] + 0.1*ba - 0.1*bb + 0.1*bc)) + 
    node("a", t=0, distr="rbern", prob=plogis(-2 + 1.5*l[t] + 0.2*ba - 0.2*bb + 0.2*bc)) +
    
    node("u", t=1:4, distr="rnorm", mean=0.7*u[t-1], sd = 1) +
    node("c", t=1:4, distr="rbern", prob=ifelse(c[t-1]==1,1,plogis(-4.75 + 2.0*a[t-1] + 2.0*l[t-1]))) +
    node("l", t=1:4, distr="rbern", prob=ifelse(c[t]==1,NA,plogis(-2 + 1.0*a[t-1] + 2.0*l[t-1] + 1.5*u[t] + 0.1*ba - 0.1*bb + 0.1*bc))) +
    node("a", t=1:4, distr="rbern", prob=ifelse(c[t]==1,NA,plogis(-2 + 2.0*a[t-1] + 1.5*l[t] + 0.2*ba - 0.2*bb + 0.2*bc))) +
    
    node("y", t=0, distr="rnorm", mean=(1.00*a[t]
                                        + 0.50*l[t]
                                        + 0.50*u[t]
                                        + 0.2*ba - 0.2*bb + 0.2*bc), sd=1) +
    node("y", t=1, distr="rnorm", mean=ifelse(c[t]==1,NA,(0.80*a[t-1] + 1.00*a[t]
                                                          + 0.50*l[t-1] + 0.50*l[t]
                                                          + 0.50*u[t-1] + 0.50*u[t]
                                                          + 0.2*ba - 0.2*bb + 0.2*bc)), sd=1) +
    node("y", t=2, distr="rnorm", mean=ifelse(c[t]==1,NA,(0.60*a[t-2] + 0.80*a[t-1] + 1.00*a[t]
                                                          + 0.50*l[t-2] + 0.50*l[t-1] + 0.50*l[t]
                                                          + 0.50*u[t-2] + 0.50*u[t-1] + 0.50*u[t]
                                                          + 0.2*ba - 0.2*bb + 0.2*bc)), sd=1) +
    node("y", t=3, distr="rnorm", mean=ifelse(c[t]==1,NA,(0.40*a[t-3] + 0.60*a[t-2] + 0.80*a[t-1] + 1.00*a[t]
                                                          + 0.50*l[t-3] + 0.50*l[t-2] + 0.50*l[t-1] + 0.50*l[t]
                                                          + 0.50*u[t-3] + 0.50*u[t-2] + 0.50*u[t-1] + 0.50*u[t]
                                                          + 0.2*ba - 0.2*bb + 0.2*bc)), sd=1) +
    node("y", t=4, distr="rnorm", mean=ifelse(c[t]==1,NA,(0.20*a[t-4] + 0.40*a[t-3] + 0.60*a[t-2] + 0.80*a[t-1] + 1.00*a[t]
                                                          + 0.50*l[t-4] + 0.50*l[t-3] + 0.50*l[t-2] + 0.50*l[t-1] + 0.50*l[t]
                                                          + 0.50*u[t-4] + 0.50*u[t-3] + 0.50*u[t-2] + 0.50*u[t-1] + 0.50*u[t]
                                                          + 0.2*ba - 0.2*bb + 0.2*bc)), sd=1)
  # Set this causal structure, defining all 'u' variables as latent (so they will not be included in the data)
  D <- suppressWarnings(set.DAG(D, latent.v = c("u_0","u_1","u_2","u_3","u_4")))
  # Create final simulated dataset
  ldata <- simcausal::sim(D,n=1000)
  
  # Convert numeric censoring variables to 'censored' variable for ltmle
  ldata$c_0 <- BinaryToCensoring(is.censored=ldata$c_0)
  ldata$c_1 <- BinaryToCensoring(is.censored=ldata$c_1)
  ldata$c_2 <- BinaryToCensoring(is.censored=ldata$c_2)
  ldata$c_3 <- BinaryToCensoring(is.censored=ldata$c_3)
  ldata$c_4 <- BinaryToCensoring(is.censored=ldata$c_4)

  ldata
  
}  
  
################################################
### Cross-sectional example                   ##
################################################

crosssectional <- function(data,SLlib,SLlib2) {
  # Create subset of data with only baseline variables BA, BB, BC, A0, L0, Y0
  csdata <- data[,c(2,3,4,6,7,8)]
  
  # Manual TMLE
  # Correctly specified
  Q0 <- glm(data=csdata,"y_0 ~ a_0 + l_0 + ba + bb + bc")
  QAW <- data.frame(cbind(QA=predict(Q0,type="response"),
                          Q0=predict(Q0,type="response",newdata=cbind(csdata[,1:4],a_0=0)),
                          Q1=predict(Q0,type="response",newdata=cbind(csdata[,1:4],a_0=1))))
  G <- glm(data=csdata,"a_0 ~ l_0 + ba + bb + bc",family=binomial)
  GAW <- predict(G,type="response")
  HA1 <- csdata[,5]/GAW
  HA0 <- -(1-csdata[,5])/(1-GAW)
  H <- HA1+HA0
  Q1 <- glm(data=data.frame(cbind(Y=csdata[,6],HA1=HA1,HA0=-HA0,QAW)),"Y ~ -1 + HA1 + HA0 + offset(QA)")
  muA1 <- QAW$Q1 + coef(Q1)[1]/GAW
  muA0 <- QAW$Q0 + coef(Q1)[2]/(1-GAW)
  TMLE <- c(coef=mean(muA1-muA0),
            se=var((HA1-HA0)*(csdata[,6]-QAW$QA) + QAW$Q1 - QAW$Q0 - (muA1-muA0))/length(csdata[,1]))
  
  # Outcome model mispecified
  Q0m1 <- glm(data=csdata,"y_0 ~ a_0 + ba + bb + bc")
  QAWm1 <- data.frame(cbind(QA=predict(Q0m1,type="response"),
                            Q0=predict(Q0m1,type="response",newdata=cbind(csdata[,1:4],a_0=0)),
                            Q1=predict(Q0m1,type="response",newdata=cbind(csdata[,1:4],a_0=1))))
  Gm1 <- glm(data=csdata,"a_0 ~ l_0 + ba + bb + bc",family=binomial)
  GAWm1 <- predict(Gm1,type="response")
  HA1m1 <- csdata[,5]/GAWm1
  HA0m1 <- -(1-csdata[,5])/(1-GAWm1)
  Hm1 <- HA1m1+HA0m1
  Q1m1 <- glm(data=data.frame(cbind(Y=csdata[,6],HA1=HA1m1,HA0=-HA0m1,QAWm1)),"Y ~ -1 + HA1 + HA0 + offset(QA)")
  muA1m1 <- QAWm1$Q1 + coef(Q1m1)[1]/GAWm1
  muA0m1 <- QAWm1$Q0 + coef(Q1m1)[2]/(1-GAWm1)
  TMLEm1 <- c(coef=mean(muA1m1-muA0m1),
              se=var((HA1m1-HA0m1)*(csdata[,6]-QAWm1$QA) + QAWm1$Q1 - QAWm1$Q0 - (muA1m1-muA0m1))/length(csdata[,1]))
  
  # Both models mispecified
  Q0m2 <- glm(data=csdata,"y_0 ~ a_0 + ba + bb + bc")
  QAWm2 <- data.frame(cbind(QA=predict(Q0m2,type="response"),
                            Q0=predict(Q0m2,type="response",newdata=cbind(csdata[,1:4],a_0=0)),
                            Q1=predict(Q0m2,type="response",newdata=cbind(csdata[,1:4],a_0=1))))
  Gm2 <- glm(data=csdata,"a_0 ~ ba + bb + bc",family=binomial)
  GAWm2 <- predict(Gm2,type="response")
  HA1m2 <- csdata[,5]/GAWm2
  HA0m2 <- -(1-csdata[,5])/(1-GAWm2)
  Hm2 <- HA1m2+HA0m2
  Q1m2 <- glm(data=data.frame(cbind(Y=csdata[,6],HA1=HA1m2,HA0=-HA0m2,QAWm2)),"Y ~ -1 + HA1 + HA0 + offset(QA)")
  muA1m2 <- QAWm2$Q1 + coef(Q1m2)[1]/GAWm2
  muA0m2 <- QAWm2$Q0 + coef(Q1m2)[2]/(1-GAWm2)
  TMLEm2 <- c(coef=mean(muA1m2-muA0m2),
              se=var((HA1m2-HA0m2)*(csdata[,6]-QAWm2$QA) + QAWm2$Q1 - QAWm2$Q0 - (muA1m2-muA0m2))/length(csdata[,1]))
  
  # GLM-based R-TMLE
  # Correctly specified
  rtmle <- tmle(Y=csdata[,6],A=csdata[,5],W=csdata[,1:4],
                Q.SL.library=SLlib,
                g.SL.library=SLlib,
                Qform="Y~A+l_0+ba+bb+bc",
                gform="A~l_0+ba+bb+bc")
  # Outcome model mispecified
  rtmlem1 <- tmle(Y=csdata[,6],A=csdata[,5],W=csdata[,1:4],
                  Q.SL.library=SLlib,
                  g.SL.library=SLlib,
                  Qform="Y~A+ba+bb+bc",
                  gform="A~l_0+ba+bb+bc")
  # Both models mispecified
  rtmlem2 <- tmle(Y=csdata[,6],A=csdata[,5],W=csdata[,1:4],
                  Q.SL.library=SLlib,
                  g.SL.library=SLlib,
                  Qform="Y~A+ba+bb+bc",
                  gform="A~ba+bb+bc")
  
  # SuperLearner-based LTMLE
  sltmle <- tmle(Y=csdata[,6],A=csdata[,5],W=csdata[,1:4],
                 Q.SL.library=SLlib2,
                 g.SL.library=SLlib2,
                 V=10)
  
  # Create summary table of coefficients and standard errors
  csresults <- matrix(c(coef(summary(Q0))[2,1],coef(summary(Q0))[2,2],
                        coef(summary(Q0m1))[2,1],coef(summary(Q0m1))[2,2],
                        mean(muA1-muA0),sqrt(var((HA1-HA0)*(csdata[,6]-QAW$QA) + QAW$Q1 - QAW$Q0 - (muA1-muA0))/length(csdata[,1])),
                        mean(muA1m1-muA0m1),sqrt(var((HA1m1-HA0m1)*(csdata[,6]-QAWm1$QA) + QAWm1$Q1 - QAWm1$Q0 - (muA1m1-muA0m1))/length(csdata[,1])),
                        mean(muA1m2-muA0m2),sqrt(var((HA1m2-HA0m2)*(csdata[,6]-QAWm2$QA) + QAWm2$Q1 - QAWm2$Q0 - (muA1m2-muA0m2))/length(csdata[,1])),
                        rtmle$estimates$ATE$psi,sqrt(rtmle$estimates$ATE$var.psi),
                        rtmlem1$estimates$ATE$psi,sqrt(rtmlem1$estimates$ATE$var.psi),
                        rtmlem2$estimates$ATE$psi,sqrt(rtmlem2$estimates$ATE$var.psi),
                        sltmle$estimates$ATE$psi,sqrt(sltmle$estimates$ATE$var.psi)),nrow=1,ncol=18,byrow=TRUE)

  csresults 

}

##############################################################
### Longitudinal example with single outcome measurement    ##
##############################################################

longitudinal1 <- function(ldata,SLlib,SLlib3) {
  
  # Define q and g forms for manually specified LTMLE models
  qforma <- c(l_0="Q.kplus1 ~ ba + bb + bc",
              l_1="Q.kplus1 ~ ba + bb + bc + l_0 + a_0",
              l_2="Q.kplus1 ~ ba + bb + bc + l_0 + a_0 + l_1 + a_1",
              l_3="Q.kplus1 ~ ba + bb + bc + l_0 + a_0 + l_1 + a_1 + l_2 + a_2",
              l_4="Q.kplus1 ~ ba + bb + bc + l_0 + a_0 + l_1 + a_1 + l_2 + a_2 + l_3 + a_3",
              y_4="Q.kplus1 ~ ba + bb + bc + l_0 + a_0 + l_1 + a_1 + l_2 + a_2 + l_3 + a_3 + l_4 + a_4")
  mqforma <- c(l_0="Q.kplus1 ~ ba + bb + bc",
               l_1="Q.kplus1 ~ ba + bb + bc + a_0",
               l_2="Q.kplus1 ~ ba + bb + bc + a_0 + a_1",
               l_3="Q.kplus1 ~ ba + bb + bc + a_0 + a_1 + a_2",
               l_4="Q.kplus1 ~ ba + bb + bc + a_0 + a_1 + a_2 + a_3",
               y_4="Q.kplus1 ~ ba + bb + bc + a_0 + a_1 + a_2 + a_3 + a_4")
  
  gforma <- c(c_0="c_0 ~ ba + bb + bc",
              a_0="a_0 ~ ba + bb + bc + l_0",
              c_1="c_1 ~ ba + bb + bc + l_0 + a_0 ",
              a_1="a_1 ~ ba + bb + bc + l_0 + a_0 + l_1",
              c_2="c_2 ~ ba + bb + bc + l_0 + a_0 + l_1 + a_1",
              a_2="a_2 ~ ba + bb + bc + l_0 + a_0 + l_1 + a_1 + l_2",
              c_3="c_3 ~ ba + bb + bc + l_0 + a_0 + l_1 + a_1 + l_2 + a_2",
              a_3="a_3 ~ ba + bb + bc + l_0 + a_0 + l_1 + a_1 + l_2 + a_2 + l_3",
              c_4="c_4 ~ ba + bb + bc + l_0 + a_0 + l_1 + a_1 + l_2 + a_2 + l_3 + a_3",
              a_4="a_4 ~ ba + bb + bc + l_0 + a_0 + l_1 + a_1 + l_2 + a_2 + l_3 + a_3 + l_4")
  mgforma <- c(c_0="c_0 ~ ba + bb + bc",
               a_0="a_0 ~ ba + bb + bc",
               c_1="c_1 ~ ba + bb + bc + a_0",
               a_1="a_1 ~ ba + bb + bc + a_0",
               c_2="c_2 ~ ba + bb + bc + a_0 + a_1",
               a_2="a_2 ~ ba + bb + bc + a_0 + a_1",
               c_3="c_3 ~ ba + bb + bc + a_0 + a_1 + a_2",
               a_3="a_3 ~ ba + bb + bc + a_0 + a_1 + a_2",
               c_4="c_4 ~ ba + bb + bc + a_0 + a_1 + a_2 + a_3",
               a_4="a_4 ~ ba + bb + bc + a_0 + a_1 + a_2 + a_3")
  
  # Create data subset with all observations of exposure and confounders, but only final outcome Y4
  ldata2 <- ldata[,c(-1,-8,-12,-16,-20)]
  
  # NAIVE ANALYSIS #
  # Correctly specified
  LGLM <- glm(data=ldata,"y_4 ~ a_0 + a_1 + a_2 + a_3 + a_4 + l_0 + l_1 + l_2 + l_3 + l_4 + ba + bb + bc")
  V1<-vcov(LGLM) # Save variance-covariance matrix to calculate joint standard error
  # Incorrectly specified
  LGLMm <- glm(data=ldata,"y_4 ~ a_0 + a_1 + a_2 + a_3 + a_4 + ba + bb + bc")
  V2<-vcov(LGLMm) # Save variance-covariance matrix to calculate joint standard error
  
  # TMLE ANALYSIS #
  # Estimation using just GLMs
  # Correctly specified
  rltmle1 <- suppressWarnings(ltmle(ldata2,
                                    Anodes=c("a_0","a_1","a_2","a_3","a_4"),
                                    Lnodes=c("l_0","l_1","l_2","l_3","l_4"),
                                    Cnodes=c("c_0","c_1","c_2","c_3","c_4"),
                                    Ynodes="y_4",
                                    abar=list(c(1,1,1,1,1),c(0,0,0,0,0)),
                                    SL.library=SLlib,
                                    Qform=qforma,gform=gforma,
                                    estimate.time=FALSE,
                                    survivalOutcome=FALSE))
  
  # Outcome model misspecified
  rltmle1m1 <- suppressWarnings(ltmle(ldata2,
                                      Anodes=c("a_0","a_1","a_2","a_3","a_4"),
                                      Lnodes=c("l_0","l_1","l_2","l_3","l_4"),
                                      Cnodes=c("c_0","c_1","c_2","c_3","c_4"),
                                      Ynodes="y_4",
                                      abar=list(c(1,1,1,1,1),c(0,0,0,0,0)),
                                      SL.library=SLlib,
                                      Qform=mqforma,gform=gforma,
                                      estimate.time=FALSE,
                                      survivalOutcome=FALSE))
  
  # Both models misspecified
  rltmle1m2 <- suppressWarnings(ltmle(ldata2,
                                      Anodes=c("a_0","a_1","a_2","a_3","a_4"),
                                      Lnodes=c("l_0","l_1","l_2","l_3","l_4"),
                                      Cnodes=c("c_0","c_1","c_2","c_3","c_4"),
                                      Ynodes="y_4",
                                      abar=list(c(1,1,1,1,1),c(0,0,0,0,0)),
                                      SL.library=SLlib,
                                      Qform=mqforma,gform=mgforma,
                                      estimate.time=FALSE,
                                      survivalOutcome=FALSE))
  
  # Estimation via SuperLearner
  slltmle1 <- suppressWarnings(ltmle(ldata2,
                                     Anodes=c("a_0","a_1","a_2","a_3","a_4"),
                                     Lnodes=c("l_0","l_1","l_2","l_3","l_4"),
                                     Cnodes=c("c_0","c_1","c_2","c_3","c_4"),
                                     Ynodes="y_4",
                                     abar=list(c(1,1,1,1,1),c(0,0,0,0,0)),
                                     SL.library=SLlib3,
                                     SL.cvControl=list(V=10),
                                     estimate.time=FALSE,
                                     survivalOutcome=FALSE))
  
  # Create summary table of coefficients and standard errors
  lresults1 <- matrix(c(coef(LGLM)[2]+coef(LGLM)[3]+coef(LGLM)[4]+coef(LGLM)[5]+coef(LGLM)[6],
                        V1[2,2] + V1[3,3] + V1[4,4] + V1[5,5] + V1[6,6]
                        + 2*V1[2,3]+ 2*V1[2,4] + 2*V1[2,5] + 2*V1[2,6]
                        + 2*V1[3,4] + 2*V1[3,5] + 2*V1[3,6]
                        + 2*V1[4,5] + 2*V1[4,6]
                        + 2*V1[5,6],
                        coef(LGLMm)[2]+coef(LGLMm)[3]+coef(LGLMm)[4]+coef(LGLMm)[5]+coef(LGLMm)[6],
                        V2[2,2] + V2[3,3] + V2[4,4] + V2[5,5] + V2[6,6]
                        + 2*V2[2,3]+ 2*V2[2,4] + 2*V2[2,5] + 2*V2[2,6]
                        + 2*V2[3,4] + 2*V2[3,5] + 2*V2[3,6]
                        + 2*V2[4,5] + 2*V2[4,6]
                        + 2*V2[5,6],
                        summary(rltmle1)$effect.measures$ATE$estimate,
                        summary(rltmle1)$effect.measures$ATE$std.dev,
                        summary(rltmle1m1)$effect.measures$ATE$estimate,
                        summary(rltmle1m1)$effect.measures$ATE$std.dev,
                        summary(rltmle1m2)$effect.measures$ATE$estimate,
                        summary(rltmle1m2)$effect.measures$ATE$std.dev,
                        summary(slltmle1)$effect.measures$ATE$estimate,
                        summary(slltmle1)$effect.measures$ATE$std.dev),nrow=1,ncol=12,byrow=TRUE)

  lresults1
  
}

  ##############################################################
  ### Longitudinal example with repeated outcome measurement  ##
  ##############################################################

longitudinal2 <- function(ldata,SLlib,SLlib3) {  
  
  # Define q and g forms for manually specified LTMLE models
  qformb <- c(l_0="Q.kplus1 ~ ba + bb + bc",
              y_0="Q.kplus1 ~ ba + bb + bc + l_0 + a_0",
              l_1="Q.kplus1 ~ ba + bb + bc + l_0 + a_0 + y_0",
              y_1="Q.kplus1 ~ ba + bb + bc + l_0 + a_0 + y_0 + l_1 + a_1",
              l_2="Q.kplus1 ~ ba + bb + bc + l_0 + a_0 + y_0 + l_1 + a_1 + y_1",
              y_2="Q.kplus1 ~ ba + bb + bc + l_0 + a_0 + y_0 + l_1 + a_1 + y_1 + l_2 + a_2",
              l_3="Q.kplus1 ~ ba + bb + bc + l_0 + a_0 + y_0 + l_1 + a_1 + y_1 + l_2 + a_2 + y_2",
              y_3="Q.kplus1 ~ ba + bb + bc + l_0 + a_0 + y_0 + l_1 + a_1 + y_1 + l_2 + a_2 + y_2 + l_3 + a_3",
              l_4="Q.kplus1 ~ ba + bb + bc + l_0 + a_0 + y_0 + l_1 + a_1 + y_1 + l_2 + a_2 + y_2 + l_3 + a_3 + y_3",
              y_4="Q.kplus1 ~ ba + bb + bc + l_0 + a_0 + y_0 + l_1 + a_1 + y_1 + l_2 + a_2 + y_2 + l_3 + a_3 + y_3 + l_4 + a_4")
  mqformb <- c(l_0="Q.kplus1 ~ ba + bb + bc",
               y_0="Q.kplus1 ~ ba + bb + bc + a_0",
               l_1="Q.kplus1 ~ ba + bb + bc + a_0 + y_0",
               y_1="Q.kplus1 ~ ba + bb + bc + a_0 + y_0 + a_1",
               l_2="Q.kplus1 ~ ba + bb + bc + a_0 + y_0 + a_1 + y_1",
               y_2="Q.kplus1 ~ ba + bb + bc + a_0 + y_0 + a_1 + y_1 + a_2",
               l_3="Q.kplus1 ~ ba + bb + bc + a_0 + y_0 + a_1 + y_1 + a_2 + y_2",
               y_3="Q.kplus1 ~ ba + bb + bc + a_0 + y_0 + a_1 + y_1 + a_2 + y_2 + a_3",
               l_4="Q.kplus1 ~ ba + bb + bc + a_0 + y_0 + a_1 + y_1 + a_2 + y_2 + a_3 + y_3",
               y_4="Q.kplus1 ~ ba + bb + bc + a_0 + y_0 + a_1 + y_1 + a_2 + y_2 + a_3 + y_3 + a_4")
  
  gformb <- c(c_0="c_0 ~ ba + bb + bc",
              a_0="a_0 ~ ba + bb + bc + l_0",
              c_1="c_1 ~ ba + bb + bc + l_0 + a_0 + y_0",
              a_1="a_1 ~ ba + bb + bc + l_0 + a_0 + y_0 + l_1",
              c_2="c_2 ~ ba + bb + bc + l_0 + a_0 + y_0 + l_1 + a_1 + y_1",
              a_2="a_2 ~ ba + bb + bc + l_0 + a_0 + y_0 + l_1 + a_1 + y_1 + l_2",
              c_3="c_3 ~ ba + bb + bc + l_0 + a_0 + y_0 + l_1 + a_1 + y_1 + l_2 + a_2 + y_2",
              a_3="a_3 ~ ba + bb + bc + l_0 + a_0 + y_0 + l_1 + a_1 + y_1 + l_2 + a_2 + y_2 + l_3",
              c_4="c_4 ~ ba + bb + bc + l_0 + a_0 + y_0 + l_1 + a_1 + y_1 + l_2 + a_2 + y_2 + l_3 + a_3 + y_3",
              a_4="a_4 ~ ba + bb + bc + l_0 + a_0 + y_0 + l_1 + a_1 + y_1 + l_2 + a_2 + y_2 + l_3 + a_3 + y_3 + l_4")
  mgformb <- c(c_0="c_0 ~ ba + bb + bc",
               a_0="a_0 ~ ba + bb + bc",
               c_1="c_1 ~ ba + bb + bc + a_0 + y_0",
               a_1="a_1 ~ ba + bb + bc + a_0 + y_0",
               c_2="c_2 ~ ba + bb + bc + a_0 + y_0 + a_1 + y_1",
               a_2="a_2 ~ ba + bb + bc + a_0 + y_0 + a_1 + y_1",
               c_3="c_3 ~ ba + bb + bc + a_0 + y_0 + a_1 + y_1 + a_2 + y_2",
               a_3="a_3 ~ ba + bb + bc + a_0 + y_0 + a_1 + y_1 + a_2 + y_2",
               c_4="c_4 ~ ba + bb + bc + a_0 + y_0 + a_1 + y_1 + a_2 + y_2 + a_3 + y_3",
               a_4="a_4 ~ ba + bb + bc + a_0 + y_0 + a_1 + y_1 + a_2 + y_2 + a_3 + y_3")
  
  # TMLE ANALYSIS #
  # Estimation using just GLMs
  # Correctly specified
  rltmle2 <- suppressWarnings(ltmle(ldata[,-1],
                                    Anodes=c("a_0","a_1","a_2","a_3","a_4"),
                                    Lnodes=c("l_0","l_1","l_2","l_3","l_4"),
                                    Cnodes=c("c_0","c_1","c_2","c_3","c_4"),
                                    Ynodes=c("y_0","y_1","y_2","y_3","y_4"),
                                    survivalOutcome=FALSE,
                                    abar=list(c(1,1,1,1,1),c(0,0,0,0,0)),
                                    SL.library=SLlib,
                                    Qform=qformb,gform=gformb,
                                    estimate.time=FALSE))
  # Outcome model misspecified
  rltmle2m1 <- suppressWarnings(ltmle(ldata[,-1],
                                      Anodes=c("a_0","a_1","a_2","a_3","a_4"),
                                      Lnodes=c("l_0","l_1","l_2","l_3","l_4"),
                                      Cnodes=c("c_0","c_1","c_2","c_3","c_4"),
                                      Ynodes=c("y_0","y_1","y_2","y_3","y_4"),
                                      survivalOutcome=FALSE,
                                      abar=list(c(1,1,1,1,1),c(0,0,0,0,0)),
                                      SL.library=SLlib,
                                      Qform=mqformb,gform=gformb,
                                      estimate.time=FALSE))
  # Both models misspecified
  rltmle2m2 <- suppressWarnings(ltmle(ldata[,-1],
                                      Anodes=c("a_0","a_1","a_2","a_3","a_4"),
                                      Lnodes=c("l_0","l_1","l_2","l_3","l_4"),
                                      Cnodes=c("c_0","c_1","c_2","c_3","c_4"),
                                      Ynodes=c("y_0","y_1","y_2","y_3","y_4"),
                                      survivalOutcome=FALSE,
                                      abar=list(c(1,1,1,1,1),c(0,0,0,0,0)),
                                      SL.library=SLlib,
                                      Qform=mqformb,gform=mgformb,
                                      estimate.time=FALSE))
  
  # Estimation using SuperLearner
  slltmle2 <- suppressWarnings(ltmle(ldata[,-1],
                                     Anodes=c("a_0","a_1","a_2","a_3","a_4"),
                                     Lnodes=c("l_0","l_1","l_2","l_3","l_4"),
                                     Cnodes=c("c_0","c_1","c_2","c_3","c_4"),
                                     Ynodes=c("y_0","y_1","y_2","y_3","y_4"),
                                     survivalOutcome=FALSE,
                                     abar=list(c(1,1,1,1,1),c(0,0,0,0,0)),
                                     SL.library=SLlib3,
                                     SL.cvControl = list(V=10),
                                     estimate.time=FALSE))
  
  # NAIVE ANALYSIS #
  # Create cumulative exposure and confounder variables for naive analysis
  ldata$acum_0 <- ldata$a_0
  ldata$acum_1 <- ldata$acum_0 + ldata$a_1
  ldata$acum_2 <- ldata$acum_1 + ldata$a_2
  ldata$acum_3 <- ldata$acum_2 + ldata$a_3
  ldata$acum_4 <- ldata$acum_3 + ldata$a_4
  ldata$lcum_0 <- ldata$l_0
  ldata$lcum_1 <- ldata$lcum_0 + ldata$l_1
  ldata$lcum_2 <- ldata$lcum_1 + ldata$l_2
  ldata$lcum_3 <- ldata$lcum_2 + ldata$l_3
  ldata$lcum_4 <- ldata$lcum_3 + ldata$l_4
  
  # Create long-form data for GLM analysis
  longdata <- reshape(data=ldata,varying=list(c(8,12,16,20,24),c(7,11,15,19,23),c(25:29),c(6,10,14,18,22),c(30:34),c(5,9,13,17,21)),
                      v.names=c("y","a","acum","l","lcum","c"),
                      idvar="ID",timevar="obs",direction="long", sep = "_")
  # Correctly specified cumulative exposure model using random intercept model
  LRI <- lmer("y ~ acum + lcum + ba + bb + bc + (1|ID)",data=longdata)
  # Incorrectly specified cumulative exposure model
  LRIm <- lmer("y ~ acum + ba + bb + bc + (1|ID)",data=longdata)
  
  # Create summary table of coefficients and standard errors
  lresults2 <- matrix(c(5*coef(summary(LRI))[2,1],
                        5*coef(summary(LRI))[2,2],
                        5*coef(summary(LRIm))[2,1],
                        5*coef(summary(LRIm))[2,2],
                        summary(rltmle2)$effect.measures$ATE$estimate,
                        summary(rltmle2)$effect.measures$ATE$std.dev,
                        summary(rltmle2m1)$effect.measures$ATE$estimate,
                        summary(rltmle2m1)$effect.measures$ATE$std.dev,
                        summary(rltmle2m2)$effect.measures$ATE$estimate,
                        summary(rltmle2m2)$effect.measures$ATE$std.dev,
                        summary(slltmle2)$effect.measures$ATE$estimate,
                        summary(slltmle2)$effect.measures$ATE$std.dev),nrow=1,ncol=12,byrow=TRUE)
  
  lresults2
  
}

# Create list of random forest wrappers with different values of mtry
ranger_tune_1 <- create.Learner("SL.ranger", tune=list(mtry = c(1,2)))
ranger_tune_2 <- create.Learner("SL.ranger", tune=list(mtry = c(1,2,3,4)))
# Define SuperLearner libraries to be used by SL-TMLE
SLlib <- c("SL.glm")
SLlib2 <- c("SL.glm","SL.glm.interaction",ranger_tune_1$names)
SLlib3 <- list(Q=c("SL.glm","SL.glm.interaction","SL.stepAIC"),
               g=c("SL.glm","SL.glm.interaction","SL.stepAIC",ranger_tune_2$names))

