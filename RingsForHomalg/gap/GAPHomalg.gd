# SPDX-License-Identifier: GPL-2.0-or-later
# RingsForHomalg: Dictionaries of external rings
#
# Declarations
#

##  Declaration stuff for the external computer algebra system GAP.

####################################
#
# global functions and operations:
#
####################################

DeclareGlobalFunction( "_ExternalGAP_multiple_delete" );

DeclareGlobalFunction( "InitializeGAPHomalgMacros" );

# constructor methods:

DeclareGlobalFunction( "RingForHomalgInExternalGAP" );

DeclareGlobalFunction( "HomalgRingOfIntegersInExternalGAP" );

DeclareGlobalFunction( "HomalgFieldOfRationalsInExternalGAP" );

# basic operations:


####################################
#
# representations:
#
####################################

# a new subrepresentation of the representation IshomalgExternalRingObjectRep:
DeclareRepresentation( "IsHomalgExternalRingObjectInGAPRep",
        IshomalgExternalRingObjectRep,
        [  ] );

# a new subrepresentation of the representation IsHomalgExternalRingRep:
DeclareRepresentation( "IsHomalgExternalRingInGAPRep",
        IsHomalgExternalRingRep,
        [  ] );
