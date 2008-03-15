#############################################################################
##
##  HomalgExternalObject.gd     homalg package               Mohamed Barakat
##
##  Copyright 2007-2008 Lehrstuhl B für Mathematik, RWTH Aachen
##
##  Declaration stuff for homalg's external objects.
##
#############################################################################

####################################
#
# categories:
#
####################################

# a new category of objects:

DeclareCategory( "IsHomalgExternalObject",
        IsAttributeStoringRep );

####################################
#
# properties:
#
####################################

DeclareProperty( "IsHomalgExternalObjectWithIOStream",
        IsHomalgExternalObject );

####################################
#
# global functions and operations:
#
####################################

# basic operations:

DeclareOperation( "HomalgPointer",
        [ IsHomalgExternalObject ] );

DeclareOperation( "HomalgExternalCASystem",
        [ IsHomalgExternalObject ] );

DeclareOperation( "HomalgExternalCASystemVersion",
        [ IsHomalgExternalObject ] );

# constructor methods:

DeclareGlobalFunction( "HomalgExternalObject" );

