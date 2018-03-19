# Cosmic clocks

## Introduction

This repository contains a patch to [CosmoMC](https://github.com/cmbant/CosmoMC/) to include the cosmic clocks (CC) likelihood. CC use the differential evolution of passive early-type galaxies to estimate H(z) at various redshifts up to z~2 in a model-independent way: H(z)=-1/(1+z)dz/dt.              For the original paper proposing the use of CC, see Jimenez & Loeb, [Constraining cosmological parameters based on relative galaxy ages](https://inspirehep.net/record/559474), [Astrophys.J. 573 (2002) 37-42](http://iopscience.iop.org/article/10.1086/340549/meta) [arXiv: astro-ph/0106145](https://arxiv.org/abs/astro-ph/0106145)  

## Usage

You should first make sure to have a working CosmoMC installation. Then, simply copy the content of the [source](https://github.com/sunnyvagnozzi/CosmoMC-patches/tree/master/Cosmic_clocks/source) repository into your CosmoMC/source folder.

Alternatively (which you might want to do e.g. if you adding this patch on top of another CosmoMC patch, and thus have already modified your Makefile), you can choose to only copy [CC.f90](https://github.com/sunnyvagnozzi/CosmoMC-patches/blob/master/Cosmic_clocks/source/CC.f90). Then, you have to modify your CosmoMC/source/DataLikelihoods.f90 by adding the following two lines (around lines 15 and 40):

    use CC
and

    call CCLikelihood_Add(DataLikelihoods, Ini)
Then, you will also have to modify your Makefile by adding the following to lines (around lines 180 and 250):

    DATAMODULES += $(OUTPUT_DIR)/CC.o
and

    $(OUTPUT_DIR)/CC.o: $(OUTPUT_DIR)/Calculator_CAMB.o $(OUTPUT_DIR)/Calculator_Cosmology.o $(OUTPUT_DIR)/CosmoTheory.o $(OUTPUT_DIR)/CosmologyTypes.o $(OUTPUT_DIR)/Likelihood_Cosmology.o


Next, you should copy the content of the [batch2](https://github.com/sunnyvagnozzi/CosmoMC-patches/tree/master/Cosmic_clocks/batch2) repository to your CosmoMC/data folder, and similarly for the [data](https://github.com/sunnyvagnozzi/CosmoMC-patches/tree/master/Cosmic_clocks/data) repository.

Once you've done all this, you can go back to your CosmoMC folder, type "Make", and you're good to go. Note that this will create an executable called *cosmomc_cc* (in order not to confuse it with other executables), but you can override this modifying line 301 of source/Makefile. To include the CC likelihood in your analysis, simply add:

    DEFAULT(batch2/CC.ini)
to your top-level configuration file.

## References

If you use these codes in your research, please cite the following papers:

A. Lewis and S. Bridle, [Cosmological parameters from CMB and other data: a Monte-Carlo approach](https://inspirehep.net/record/590144), [Phys. Rev. D66 (2002) 103511](https://journals.aps.org/prd/abstract/10.1103/PhysRevD.66.103511) [[arXiv: astro-ph/0205436](https://arxiv.org/abs/astro-ph/0205436)]

# Support

If you experience any problems with the codes, or to report bugs, please email [sunny.vagnozzi@fysik.su.se](mailto:sunny.vagnozzi@fysik.su.se) (unless you're a robot, of course)

************************************************************************************************

This research was supported by:

   <a href="http://www.okc.albanova.se/"><img src="http://www.okc.albanova.se/polopoly_fs/1.327382.1491483655!/image/image.jpg_gen/derivatives/logotype_h130/image.jpg"
height="100px"></a>
   <a href="https://www.su.se/"><img src="http://resources.mynewsdesk.com/image/upload/t_open_graph_image/ayjgabd4qxqbpj4pu4nl.jpg"
height="100px"></a>
      <a href="https://www.nordita.org/"><img src="https://yt3.ggpht.com/a-/AJLlDp3bQ-UG2qVRBjqfsEbsUaDs_fd8yBPkMnPCXg=s900-mo-c-c0xffffffff-rj-k-no"
height="100px"></a>
   <a href="http://www.ceico.cz/"><img src="https://academicpositions.eu/uploads/46e/083/46e083d07d2516e6b22c300bfe4731ac.jpeg" height="100px"></a>
   <a href="https://www.fzu.cz/"><img src="https://www.fzu.cz/sites/default/files/logo-FZU-velke_1000x600px.jpg" height="100px"></a>
