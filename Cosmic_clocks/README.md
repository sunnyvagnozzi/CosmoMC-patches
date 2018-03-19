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

A. Lewis and S. Bridle, [Cosmological parameters from CMB and other data: a Monte-Carlo approach](https://inspirehep.net/record/590144), [Phys. Rev. D66 (2002) 103511](https://journals.aps.org/prd/abstract/10.1103/PhysRevD.66.103511) [[arXiv: astro-ph/0205436](https://arxiv.org/abs/astro-ph/0205436)] (original CosmoMC paper)

R. Jimenez and A. Loeb, [Constraining cosmological parameters based on relative galaxy ages](https://inspirehep.net/record/559474), [Astrophys.J. 573 (2002) 37-42](http://iopscience.iop.org/article/10.1086/340549/meta) [[arXiv: astro-ph/0106145](https://arxiv.org/abs/astro-ph/0106145)] (original cosmic clocks paper)

J. Simon, L. Verde, and R. Jimenez [Constraints on the redshift dependence of the dark energy potential](http://inspirehep.net/record/666840), [Phys.Rev. D71 (2005) 123001](https://journals.aps.org/prd/abstract/10.1103/PhysRevD.71.123001) [[arXiv: astro-ph/0412269](https://arxiv.org/abs/astro-ph/0412269)]

D. Stern, R. Jimenez, L. Verde, M. Kamionkowski, and S. Adam Stanford [Cosmic Chronometers: Constraining the Equation of State of Dark Energy. I: H(z) Measurements](http://inspirehep.net/record/826046), [JCAP 1002 (2010) 008](http://iopscience.iop.org/article/10.1088/1475-7516/2010/02/008/meta) [[arXiv: 0907.3149](https://arxiv.org/abs/0907.3149)]

M. Moresco *et al.*, [Improved constraints on the expansion rate of the Universe up to z~1.1 from the spectroscopic evolution of cosmic chronometers](http://inspirehep.net/record/1085026), [JCAP 1208 (2012) 006](http://iopscience.iop.org/article/10.1088/1475-7516/2012/08/006) [[arXiv: 1201.3609](https://arxiv.org/abs/1201.3609)]

M. Moresco, L. Verde, L. Pozzetti, R. Jimemez, and A. Cimatti, [New constraints on cosmological parameters and neutrino properties using the expansion rate of the Universe to z~1.75](https://inspirehep.net/record/1086861), [JCAP 1207 (2012) 053](http://iopscience.iop.org/article/10.1088/1475-7516/2012/07/053) [[arXiv: 1201.6658](https://arxiv.org/abs/1201.6658)]

M. Moresco, [Raising the bar: new constraints on the Hubble parameter with cosmic chronometers at z∼2](https://inspirehep.net/record/1347218), [Mon.Not.Roy.Astron.Soc. 450 (2015) no.1, L16-L20](https://academic.oup.com/mnrasl/article-abstract/450/1/L16/985597) [[arXiv: 1503.01116](https://arxiv.org/abs/1503.01116)]

M. Moresco *et al.*, [A 6% measurement of the Hubble parameter at z∼0.45: direct evidence of the epoch of cosmic re-acceleration](https://inspirehep.net/record/1414580), [JCAP 1605 (2016) no.05, 014](http://iopscience.iop.org/article/10.1088/1475-7516/2016/05/014) [[arXiv: 1601.01701](https://arxiv.org/abs/1601.01701)]

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
