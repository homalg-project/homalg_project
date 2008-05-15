#############################################################################
##
##  homalgExternalObject.gd     homalg package               Mohamed Barakat
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

DeclareCategory( "IshomalgExternalObject",
        IsAttributeStoringRep );

DeclareCategory( "IsContainerForWeakPointersOnHomalgExternalObjects",
        IsComponentObjectRep );

####################################
#
# global functions and operations:
#
####################################

# basic operations:

DeclareOperation( "homalgPointer",
        [ IshomalgExternalObject ] );

DeclareOperation( "homalgExternalCASystem",
        [ IshomalgExternalObject ] );

DeclareOperation( "homalgExternalCASystemVersion",
        [ IshomalgExternalObject ] );

DeclareOperation( "homalgStream",
        [ IshomalgExternalObject ] );

DeclareOperation( "homalgExternalCASystemPID",
        [ IshomalgExternalObject ] );

DeclareOperation( "homalgLastWarning",
        [ IshomalgExternalObject ] );

DeclareOperation( "homalgNrOfWarnings",
        [ IshomalgExternalObject ] );

# constructor methods:

DeclareGlobalFunction( "ContainerForWeakPointersOnHomalgExternalObjects" );

DeclareGlobalFunction( "homalgExternalObject" );

