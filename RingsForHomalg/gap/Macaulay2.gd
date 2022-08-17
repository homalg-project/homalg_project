# SPDX-License-Identifier: GPL-2.0-or-later
# RingsForHomalg: Dictionaries of external rings
#
# Declarations
#

##  Declaration stuff for the external computer algebra system Macaulay2.

####################################
#
# global functions and operations:
#
####################################

DeclareGlobalFunction( "_Macaulay2_SetRing" );

DeclareGlobalFunction( "_Macaulay2_SetInvolution" );

DeclareGlobalFunction( "_Macaulay2_multiple_delete" );

DeclareGlobalFunction( "InitializeMacaulay2Macros" );

# constructor methods:

DeclareGlobalFunction( "RingForHomalgInMacaulay2" );

DeclareGlobalFunction( "HomalgRingOfIntegersInMacaulay2" );

DeclareGlobalFunction( "HomalgFieldOfRationalsInMacaulay2" );

# basic operations:


####################################
#
# representations:
#
####################################

# a new subrepresentation of the representation IshomalgExternalRingObjectRep:
DeclareRepresentation( "IsHomalgExternalRingObjectInMacaulay2Rep",
        IshomalgExternalRingObjectRep,
        [  ] );

# a new subrepresentation of the representation IsHomalgExternalRingRep:
DeclareRepresentation( "IsHomalgExternalRingInMacaulay2Rep",
        IsHomalgExternalRingRep,
        [  ] );
