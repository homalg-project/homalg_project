# SPDX-License-Identifier: GPL-2.0-or-later
# HomalgToCAS: A window to the outer world
#
# Declarations
#

##  Declaration stuff for external rings.

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

DeclareGlobalFunction( "AppendTohomalgTablesOfCreatedExternalRings" );

# constructors:

DeclareGlobalFunction( "CreateHomalgExternalRing" );

DeclareGlobalFunction( "HomalgExternalRingElement" );

