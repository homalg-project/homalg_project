#############################################################################
##
##  LocalRing.gd    LocalizeRingForHomalg package            Mohamed Barakat
##                                                    Markus Lange-Hegermann
##
##  Copyright 2009, Mohamed Barakat, Universität des Saarlandes
##           Markus Lange-Hegermann, RWTH-Aachen University
##
##  Declarations of procedures for localized rings.
##
#############################################################################

####################################
#
# global functions and operations:
#
####################################

# constructor methods:

DeclareOperation( "CreateHomalgTableForLocalizedRings",
        [ IsHomalgRing ] );

DeclareGlobalFunction( "CreateHomalgLocalizedRing" );

DeclareOperation( "LocalizeAt",
        [ IsHomalgRing ] );

DeclareGlobalFunction( "HomalgLocalRingElement" );

DeclareOperation( "BlindlyCopyMatrixPropertiesToLocalMatrix",
        [ IsHomalgMatrix, IsHomalgMatrix ] );

# basic operations:

DeclareOperation( "AssociatedGlobalRing",
        [ IsHomalgRing ] );

DeclareOperation( "AssociatedGlobalRing",
        [ IsHomalgRingElement ] );

DeclareOperation( "AssociatedGlobalRing",
        [ IsHomalgMatrix ] );

DeclareOperation( "NumeratorOfLocalElement",
        [ IsHomalgRingElement ] );

DeclareOperation( "DenominatorOfLocalElement",
        [ IsHomalgRingElement ] );

DeclareOperation( "HomalgLocalMatrix",
        [ IsHomalgMatrix, IsRingElement, IsHomalgRing ] );

DeclareOperation( "HomalgLocalMatrix",
        [ IsHomalgMatrix, IsHomalgRing ] );
