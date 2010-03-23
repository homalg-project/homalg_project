#############################################################################
##
##  HomalgComplex.gd            Modules package              Mohamed Barakat
##
##  Copyright 2007-2010 Mohamed Barakat, RWTH Aachen
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

DeclareOperation( "PositionOfTheDefaultSetOfRelations",
        [ IsHomalgComplex ] );			## provided to avoid branching in the code and always returns fail

DeclareOperation( "Add",
        [ IsHomalgComplex, IsHomalgMatrix ] );

