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

DeclareOperation( "AddTotalEmbeddingsToCollapsedFirstSpectralSequence",
        [ IsHomalgSpectralSequenceAssociatedToAFilteredComplex, IsList ] );

DeclareOperation( "AddTotalEmbeddingsToSpectralSequence",
        [ IsHomalgSpectralSequenceAssociatedToAFilteredComplex, IsList ] );

DeclareOperation( "AddSpectralFiltrationOfTotalDefects",
        [ IsHomalgSpectralSequenceAssociatedToAFilteredComplex, IsList ] );

DeclareOperation( "AddSpectralFiltrationOfTotalDefects",
        [ IsHomalgSpectralSequenceAssociatedToAFilteredComplex ] );

DeclareOperation( "SecondSpectralSequenceWithFiltrationOfTotalDefects",
        [ IsHomalgBicomplex, IsList ] );

DeclareOperation( "SecondSpectralSequenceWithFiltrationOfTotalDefects",
        [ IsHomalgBicomplex ] );

DeclareOperation( "SecondSpectralSequenceWithCollapsedFirstSpectralSequence",
        [ IsHomalgBicomplex, IsList ] );

DeclareOperation( "SecondSpectralSequenceWithCollapsedFirstSpectralSequence",
        [ IsHomalgBicomplex ] );

DeclareOperation( "SecondSpectralSequenceWithFiltration",
        [ IsHomalgBicomplex, IsList ] );

DeclareOperation( "SecondSpectralSequenceWithFiltration",
        [ IsHomalgBicomplex ] );

DeclareOperation( "GrothendieckSpectralSequence",
        [ IsHomalgFunctor, IsHomalgFunctor, IsHomalgModule, IsList ] );

DeclareOperation( "GrothendieckSpectralSequence",
        [ IsHomalgFunctor, IsHomalgFunctor, IsHomalgModule ] );

DeclareOperation( "FiltrationOfTotalDefectOfSpectralSequence",
        [ IsHomalgSpectralSequence, IsInt ] );

DeclareOperation( "FiltrationOfTotalDefectOfSpectralSequence",
        [ IsHomalgSpectralSequence ] );

DeclareOperation( "FiltrationOfObjectInCollapsedSheetOfFirstSpectralSequence",
        [ IsHomalgSpectralSequence, IsInt ] );

DeclareOperation( "FiltrationOfObjectInCollapsedSheetOfFirstSpectralSequence",
        [ IsHomalgSpectralSequence ] );

DeclareOperation( "FiltrationBySpectralSequence",
        [ IsHomalgSpectralSequence, IsInt ] );

DeclareOperation( "FiltrationBySpectralSequence",
        [ IsHomalgSpectralSequence ] );

