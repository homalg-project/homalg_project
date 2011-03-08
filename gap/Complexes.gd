#############################################################################
##
##  Complexes.gd                homalg package               Mohamed Barakat
##
##  Copyright 2007-2008 Lehrstuhl B für Mathematik, RWTH Aachen
##
##  Declarations of homalg procedures for complexes.
##
#############################################################################

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

DeclareOperation( "Resolution",
        [ IsInt, IsHomalgComplex ] );

DeclareOperation( "Resolution",
        [ IsHomalgComplex ] );

DeclareOperation( "CompleteComplexByResolution",
        [ IsInt, IsHomalgComplex ] );

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

