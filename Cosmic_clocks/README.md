# Cosmic clocks

## Introduction

This repository contains a patch to [CosmoMC](https://github.com/cmbant/CosmoMC/) to include the cosmic clocks (CC) likelihood. CC use the differential evolution of passive early-type galaxies to estimate H(z) at various redshifts up to z~2 in a model-independent way: H(z)=-1/(1+z)dz/dt.              For the original paper proposing the use of CC, see Jimenez & Loeb, [Constraining cosmological parameters based on relative galaxy ages](https://inspirehep.net/record/559474), [Astrophys.J. 573 (2002) 37-42](http://iopscience.iop.org/article/10.1086/340549/meta) [arXiv: astro-ph/0106145](https://arxiv.org/abs/astro-ph/0106145)  

## Usage

You should first make sure to have a working CosmoMC installation. Then, simply copy the content of the [source](https://github.com/sunnyvagnozzi/CosmoMC-patches/tree/master/Cosmic_clocks/source) repository into your CosmoMC/source folder.

Alternatively (which you might want to do e.g. if you adding this patch on top of another CosmoMC patch, and thus have already modified your Makefile), you can choose to only copy [CC.f90](https://github.com/sunnyvagnozzi/CosmoMC-patches/blob/master/Cosmic_clocks/source/CC.f90). Then, you have to modify your CosmoMC/source/DataLikelihoods.f90 by adding the following two lines:

    use CC
and

    call CCLikelihood_Add(DataLikelihoods, Ini)
Then, you 
