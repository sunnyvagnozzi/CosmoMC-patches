# CosmoMC-patches

This repository contains a few patches for the popular cosmological MCMC sampler [CosmoMC](https://github.com/cmbant/CosmoMC/), adding some new experiments beyond those present in the public version

## Cosmic_clocks

This repository contains a patch to include the cosmic clocks (CC) likelihood. CC use the differential evolution of passive early-type galaxies to estimate H(z) at various redshifts up to z~2 in a model-independent way: H(z)=-1/(1+z)dz/dt. For the original paper proposing the use of CC, see Jimenez & Loeb, [Constraining cosmological parameters based on relative galaxy ages](https://inspirehep.net/record/559474), [Astrophys.J. 573 (2002) 37-42](http://iopscience.iop.org/article/10.1086/340549/meta) [arXiv: astro-ph/0106145](https://arxiv.org/abs/astro-ph/0106145). For details on how to use this likelihood, see the relevant [README](https://github.com/sunnyvagnozzi/CosmoMC-patches/blob/master/Cosmic_clocks/README.md).
