#############################################################################
##
##  HomalgComplex.gd            Modules package              Mohamed Barakat
##
##  Copyright 2007-2010, Mohamed Barakat, University of Kaiserslautern
##
##  Declaration stuff for homalg complexes.
##
#############################################################################

####################################
#
# global functions and operations:
#
####################################

# constructors:

DeclareOperation( "*",
        [ IsHomalgRing, IsHomalgComplex ] );

DeclareOperation( "*",
        [ IsHomalgComplex, IsHomalgRing ] );

# basic operations:

DeclareOperation( "Add",
        [ IsHomalgComplex, IsHomalgMatrix ] );

