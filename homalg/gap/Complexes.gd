# SPDX-License-Identifier: GPL-2.0-or-later
# homalg: A homological algebra meta-package for computable Abelian categories
#
# Declarations
#

##  Declarations of homalg procedures for complexes.

####################################
#
# global functions and operations:
#
####################################

# basic operations:

DeclareOperation( "DefectOfExactness",
        [ IsHomalgComplex, IsInt ] );

DeclareOperation( "Homology",
        [ IsHomalgComplex, IsInt ] );

DeclareOperation( "Cohomology",
        [ IsHomalgComplex, IsInt ] );

DeclareOperation( "Homology",
        [ IsHomalgComplex ] );

DeclareOperation( "Cohomology",
        [ IsHomalgComplex ] );

DeclareOperation( "HorseShoeResolution",
        [ IsList, IsHomalgChainMorphism, IsHomalgChainMorphism, IsHomalgMorphism ] );

DeclareOperation( "Resolution",
        [ IsInt, IsHomalgComplex ] );

DeclareOperation( "Resolution",
        [ IsHomalgComplex ] );

DeclareOperation( "CompleteComplexByResolution",
        [ IsRingElement, IsHomalgComplex ] );

DeclareOperation( "CompleteComplexByResolution",
        [ IsHomalgComplex ] );

DeclareOperation( "ConnectingHomomorphism",
        [ IsHomalgStaticObject,
          IsHomalgStaticMorphism,
          IsHomalgStaticMorphism,
          IsHomalgStaticMorphism,
          IsHomalgStaticObject ] );

DeclareOperation( "ConnectingHomomorphism",
        [ IsHomalgComplex, IsInt ] );

DeclareOperation( "ConnectingHomomorphism",
        [ IsHomalgComplex ] );

DeclareOperation( "ExactTriangle",
        [ IsHomalgComplex ] );

DeclareOperation( "DefectOfExactnessSequence",
        [ IsHomalgComplex ] );

DeclareOperation( "DefectOfExactnessSequence",
        [ IsHomalgStaticMorphism, IsHomalgStaticMorphism ] );

DeclareOperation( "DefectOfExactnessCosequence",
        [ IsHomalgComplex ] );

DeclareOperation( "DefectOfExactnessCosequence",
        [ IsHomalgStaticMorphism, IsHomalgStaticMorphism ] );

