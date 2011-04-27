#############################################################################
##
##  HomalgExternalRing.gd     HomalgToCAS package            Mohamed Barakat
##
##  Copyright 2007-2008 Lehrstuhl B für Mathematik, RWTH Aachen
##
##  Declaration stuff for external rings.
##
#############################################################################

####################################
#
# global functions and operations:
#
####################################

# basic operations:

DeclareOperation( "homalgPointer",
        [ IsHomalgRingElement ] );

DeclareOperation( "homalgExternalCASystem",
        [ IsHomalgRingElement ] );

DeclareOperation( "homalgExternalCASystemVersion",
        [ IsHomalgRingElement ] );

DeclareOperation( "homalgStream",
        [ IsHomalgRingElement ] );

DeclareOperation( "homalgExternalCASystemPID",
        [ IsHomalgRingElement ] );

DeclareOperation( "homalgPointer",
        [ IsHomalgRing ] );

DeclareOperation( "homalgExternalCASystem",
        [ IsHomalgRing ] );

DeclareOperation( "homalgExternalCASystemVersion",
        [ IsHomalgRing ] );

DeclareOperation( "homalgStream",
        [ IsHomalgRing ] );

DeclareOperation( "homalgExternalCASystemPID",
        [ IsHomalgRing ] );

DeclareOperation( "homalgLastWarning",
        [ IsHomalgRing ] );

DeclareOperation( "homalgNrOfWarnings",
        [ IsHomalgRing ] );

DeclareGlobalFunction( "LetWeakPointerListOnExternalObjectsContainRingCreationNumbers" );

DeclareGlobalFunction( "AddTohomalgTablesOfCreatedExternalRings" );

# constructors:

DeclareGlobalFunction( "CreateHomalgExternalRing" );

DeclareGlobalFunction( "HomalgExternalRingElement" );

