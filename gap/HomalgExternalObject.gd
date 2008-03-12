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
# global functions and operations:
#
####################################

# constructor methods:

DeclareGlobalFunction( "HomalgExternalObject" );

# basic operations:

DeclareOperation( "HomalgPointer",
        [ IsHomalgExternalObject ] );

DeclareOperation( "HomalgExternalCASystem",
        [ IsHomalgExternalObject ] );

DeclareOperation( "HomalgExternalCASystemVersion",
        [ IsHomalgExternalObject ] );

