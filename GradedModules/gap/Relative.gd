#############################################################################
##
##  Relative.gd                 Graded Modules package
##
##  Copyright 2008-2010, Mohamed Barakat, University of Kaiserslautern
##                       Markus Lange-Hegermann, RWTH Aachen
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

