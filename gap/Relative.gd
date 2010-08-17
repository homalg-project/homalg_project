#############################################################################
##
##  Relative.gd                 Sheaves package              Mohamed Barakat
##
##  Copyright 2008-2009, Mohamed Barakat, Universität des Saarlandes
##
##  Declarations of procedures for the relative situation.
##
#############################################################################

####################################
#
# global functions and operations:
#
####################################

# basic operations:

DeclareOperation( "RelativeRepresentationMapOfKoszulId",
        [ IsHomalgModule, IsHomalgRing ] );

DeclareOperation( "RelativeRepresentationMapOfKoszulId",
        [ IsHomalgModule ] );

DeclareOperation( "DegreeZeroSubcomplex",
        [ IsHomalgComplex, IsHomalgRing ] );

DeclareOperation( "DegreeZeroSubcomplex",
        [ IsHomalgComplex ] );

