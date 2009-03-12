#############################################################################
##
##  SpectralSequence.gd         homalg package               Mohamed Barakat
##
##  Copyright 2007-2008 Lehrstuhl B für Mathematik, RWTH Aachen
##
##  Declaration stuff for homalg spectral sequences.
##
#############################################################################

####################################
#
# global functions and operations:
#
####################################

# basic operations:

DeclareOperation( "AddTotalEmbeddingsToCollapsedSpectralSequence",
        [ IsHomalgSpectralSequenceAssociatedToAFilteredComplex, IsList ] );

DeclareOperation( "AddTotalEmbeddingsToSpectralSequence",
        [ IsHomalgSpectralSequenceAssociatedToAFilteredComplex, IsList ] );

DeclareOperation( "AddSpectralFiltrationOfObjectsInCollapsedTransposedSpectralSequence",
        [ IsHomalgSpectralSequenceAssociatedToAFilteredComplex, IsInt, IsList ] );

DeclareOperation( "AddSpectralFiltrationOfObjectsInCollapsedTransposedSpectralSequence",
        [ IsHomalgSpectralSequenceAssociatedToAFilteredComplex, IsInt ] );

DeclareOperation( "AddSpectralFiltrationOfObjectsInCollapsedTransposedSpectralSequence",
        [ IsHomalgSpectralSequenceAssociatedToAFilteredComplex ] );

DeclareOperation( "AddSpectralFiltrationOfTotalDefects",
        [ IsHomalgSpectralSequenceAssociatedToAFilteredComplex, IsList ] );

DeclareOperation( "AddSpectralFiltrationOfTotalDefects",
        [ IsHomalgSpectralSequenceAssociatedToAFilteredComplex ] );

DeclareOperation( "SpectralSequenceWithFiltrationOfCollapsedTransposedSpectralSequence",
        [ IsHomalgBicomplex, IsInt, IsInt, IsList ] );

DeclareOperation( "SpectralSequenceWithFiltrationOfCollapsedTransposedSpectralSequence",
        [ IsHomalgBicomplex, IsList ] );

DeclareOperation( "SpectralSequenceWithFiltrationOfCollapsedTransposedSpectralSequence",
        [ IsHomalgBicomplex, IsInt, IsInt ] );

DeclareOperation( "SpectralSequenceWithFiltrationOfCollapsedTransposedSpectralSequence",
        [ IsHomalgBicomplex ] );

DeclareOperation( "SpectralSequenceWithFiltrationOfTotalDefects",
        [ IsHomalgBicomplex, IsInt, IsList ] );

DeclareOperation( "SpectralSequenceWithFiltrationOfTotalDefects",
        [ IsHomalgBicomplex, IsList ] );

DeclareOperation( "SpectralSequenceWithFiltrationOfTotalDefects",
        [ IsHomalgBicomplex, IsInt ] );

DeclareOperation( "SpectralSequenceWithFiltrationOfTotalDefects",
        [ IsHomalgBicomplex ] );

DeclareOperation( "SecondSpectralSequenceWithFiltration",
        [ IsHomalgBicomplex, IsInt, IsInt, IsList ] );

DeclareOperation( "SecondSpectralSequenceWithFiltration",
        [ IsHomalgBicomplex, IsList ] );

DeclareOperation( "SecondSpectralSequenceWithFiltration",
        [ IsHomalgBicomplex, IsInt, IsInt ] );

DeclareOperation( "SecondSpectralSequenceWithFiltration",
        [ IsHomalgBicomplex ] );

DeclareOperation( "GrothendieckBicomplex",
        [ IsHomalgFunctor, IsHomalgFunctor, IsHomalgModule ] );

DeclareOperation( "EnrichAssociatedFirstGrothendieckSpectralSequence",
        [ IsHomalgSpectralSequenceAssociatedToABicomplex, IsHomalgFunctor ] );

DeclareOperation( "GrothendieckSpectralSequence",
        [ IsHomalgFunctor, IsHomalgFunctor, IsHomalgModule, IsList ] );

DeclareOperation( "GrothendieckSpectralSequence",
        [ IsHomalgFunctor, IsHomalgFunctor, IsHomalgModule ] );

