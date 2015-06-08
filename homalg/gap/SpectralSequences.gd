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

DeclareOperation( "AddTotalEmbeddingsToCollapsedToZeroSpectralSequence",
        [ IsHomalgSpectralSequenceAssociatedToAFilteredComplex, IsList ] );

DeclareOperation( "AddTotalEmbeddingsToSpectralSequence",
        [ IsHomalgSpectralSequenceAssociatedToAFilteredComplex, IsList ] );

DeclareOperation( "AddSpectralFiltrationOfObjects",
        [ IsHomalgSpectralSequenceAssociatedToAFilteredComplex, IsList, IsRecord ] );

DeclareOperation( "AddSpectralFiltrationOfObjectsInCollapsedToZeroTransposedSpectralSequence",
        [ IsHomalgSpectralSequenceAssociatedToAFilteredComplex, IsInt, IsList ] );

DeclareOperation( "AddSpectralFiltrationOfObjectsInCollapsedToZeroTransposedSpectralSequence",
        [ IsHomalgSpectralSequenceAssociatedToAFilteredComplex, IsList ] );

DeclareOperation( "AddSpectralFiltrationOfObjectsInCollapsedToZeroTransposedSpectralSequence",
        [ IsHomalgSpectralSequenceAssociatedToAFilteredComplex, IsInt ] );

DeclareOperation( "AddSpectralFiltrationOfObjectsInCollapsedToZeroTransposedSpectralSequence",
        [ IsHomalgSpectralSequenceAssociatedToAFilteredComplex ] );

DeclareOperation( "AddSpectralFiltrationOfTotalDefects",
        [ IsHomalgSpectralSequenceAssociatedToAFilteredComplex, IsList ] );

DeclareOperation( "AddSpectralFiltrationOfTotalDefects",
        [ IsHomalgSpectralSequenceAssociatedToAFilteredComplex ] );

DeclareOperation( "SpectralSequenceWithFiltrationOfCollapsedToZeroTransposedSpectralSequence",
        [ IsHomalgBicomplex, IsInt, IsInt, IsList ] );

DeclareOperation( "SpectralSequenceWithFiltrationOfCollapsedToZeroTransposedSpectralSequence",
        [ IsHomalgBicomplex, IsList ] );

DeclareOperation( "SpectralSequenceWithFiltrationOfCollapsedToZeroTransposedSpectralSequence",
        [ IsHomalgBicomplex, IsInt, IsInt ] );

DeclareOperation( "SpectralSequenceWithFiltrationOfCollapsedToZeroTransposedSpectralSequence",
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
        [ IsHomalgFunctor, IsHomalgFunctor, IsHomalgStaticObject ] );

DeclareOperation( "BidualizingBicomplex",
        [ IsHomalgStaticObject ] );

DeclareOperation( "EnrichAssociatedFirstGrothendieckSpectralSequence",
        [ IsHomalgSpectralSequenceAssociatedToABicomplex ] );

DeclareOperation( "GrothendieckSpectralSequence",
        [ IsHomalgFunctor, IsHomalgFunctor, IsHomalgStaticObject, IsList ] );

DeclareOperation( "GrothendieckSpectralSequence",
        [ IsHomalgFunctor, IsHomalgFunctor, IsHomalgStaticObject ] );

DeclareOperation( "BidualizingSpectralSequence",
        [ IsHomalgStaticObject, IsList ] );

DeclareOperation( "BidualizingSpectralSequence",
        [ IsHomalgStaticObject ] );

