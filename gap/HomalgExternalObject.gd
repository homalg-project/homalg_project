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

# basic operations:

DeclareOperation( "HomalgPointer",
        [ IsHomalgExternalObject ] );

DeclareOperation( "HomalgExternalCASystem",
        [ IsHomalgExternalObject ] );

DeclareOperation( "HomalgExternalCASystemVersion",
        [ IsHomalgExternalObject ] );

DeclareOperation( "HomalgStream",
        [ IsHomalgExternalObject ] );

DeclareOperation( "HomalgExternalCASystemPID",
        [ IsHomalgExternalObject ] );

DeclareOperation( "HomalgLastWarning",
        [ IsHomalgExternalObject ] );

DeclareOperation( "HomalgNrOfWarnings",
        [ IsHomalgExternalObject ] );

# constructor methods:

DeclareGlobalFunction( "HomalgExternalObject" );

