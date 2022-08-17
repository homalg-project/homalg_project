# SPDX-License-Identifier: GPL-2.0-or-later
# RingsForHomalg: Dictionaries of external rings
#
# Declarations
#

##  Declaration stuff for the external computer algebra system Maple.

####################################
#
# global functions and operations:
#
####################################

DeclareGlobalFunction( "_MapleHomalg_SetRing" );

DeclareGlobalFunction( "_Maple_multiple_delete" );

DeclareGlobalFunction( "InitializeMapleMacros" );

# constructor methods:

DeclareGlobalFunction( "RingForHomalgInMapleUsingPIR" );

DeclareGlobalFunction( "RingForHomalgInMapleUsingInvolutive" );

DeclareGlobalFunction( "RingForHomalgInMapleUsingJanet" );

DeclareGlobalFunction( "RingForHomalgInMapleUsingJanetOre" );

DeclareGlobalFunction( "RingForHomalgInMapleUsingOreModules" );

DeclareGlobalFunction( "HomalgRingOfIntegersInMaple" );

DeclareGlobalFunction( "HomalgFieldOfRationalsInMaple" );

DeclareGlobalFunction( "MapleHomalgOptions" );

# basic operations:


####################################
#
# representations:
#
####################################

# a new subrepresentation of the representation IshomalgExternalRingObjectRep:
DeclareRepresentation( "IsHomalgExternalRingObjectInMapleRep",
        IshomalgExternalRingObjectRep,
        [  ] );

# five new subrepresentations of the representation IsHomalgExternalRingObjectInMapleRep:
DeclareRepresentation( "IsHomalgExternalRingObjectInMapleUsingPIRRep",
        IsHomalgExternalRingObjectInMapleRep,
        [  ] );

DeclareRepresentation( "IsHomalgExternalRingObjectInMapleUsingInvolutiveRep",
        IsHomalgExternalRingObjectInMapleRep,
        [  ] );

DeclareRepresentation( "IsHomalgExternalRingObjectInMapleUsingJanetRep",
        IsHomalgExternalRingObjectInMapleRep,
        [  ] );

DeclareRepresentation( "IsHomalgExternalRingObjectInMapleUsingJanetOreRep",
        IsHomalgExternalRingObjectInMapleRep,
        [  ] );

DeclareRepresentation( "IsHomalgExternalRingObjectInMapleUsingOreModulesRep",
        IsHomalgExternalRingObjectInMapleRep,
        [  ] );

# a new subrepresentation of the representation IsHomalgExternalRingRep:
DeclareRepresentation( "IsHomalgExternalRingInMapleRep",
        IsHomalgExternalRingRep,
        [  ] );
