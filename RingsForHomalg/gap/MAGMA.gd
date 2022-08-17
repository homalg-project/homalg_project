# SPDX-License-Identifier: GPL-2.0-or-later
# RingsForHomalg: Dictionaries of external rings
#
# Declarations
#

##  Declaration stuff for the external computer algebra system MAGMA.

####################################
#
# global functions and operations:
#
####################################

DeclareGlobalFunction( "_MAGMA_SetRing" );

DeclareGlobalFunction( "_MAGMA_multiple_delete" );

DeclareGlobalFunction( "InitializeMAGMAMacros" );

# constructor methods:

DeclareGlobalFunction( "RingForHomalgInMAGMA" );

DeclareGlobalFunction( "HomalgRingOfIntegersInMAGMA" );

DeclareGlobalFunction( "HomalgFieldOfRationalsInMAGMA" );

DeclareGlobalFunction( "HomalgCyclotomicFieldInMAGMA" );

# basic operations:


####################################
#
# representations:
#
####################################

# a new subrepresentation of the representation IshomalgExternalRingObjectRep:
DeclareRepresentation( "IsHomalgExternalRingObjectInMAGMARep",
        IshomalgExternalRingObjectRep,
        [  ] );

# a new subrepresentation of the representation IsHomalgExternalRingRep:
DeclareRepresentation( "IsHomalgExternalRingInMAGMARep",
        IsHomalgExternalRingRep,
        [  ] );
