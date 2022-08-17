# SPDX-License-Identifier: GPL-2.0-or-later
# RingsForHomalg: Dictionaries of external rings
#
# Declarations
#

##  Declaration stuff for the external computer algebra system Sage.

####################################
#
# global variables:
#
####################################

BindGlobal( "SageMacros", rec() );

####################################
#
# global functions and operations:
#
####################################

DeclareGlobalFunction( "_Sage_multiple_delete" );

DeclareGlobalFunction( "InitializeSageMacros" );

# constructor methods:

DeclareGlobalFunction( "RingForHomalgInSage" );

DeclareGlobalFunction( "HomalgRingOfIntegersInSage" );

DeclareGlobalFunction( "HomalgFieldOfRationalsInSage" );

# basic operations:


####################################
#
# representations:
#
####################################

# a new subrepresentation of the representation IshomalgExternalRingObjectRep:
DeclareRepresentation( "IsHomalgExternalRingObjectInSageRep",
        IshomalgExternalRingObjectRep,
        [  ] );

# a new subrepresentation of the representation IsHomalgExternalRingRep:
DeclareRepresentation( "IsHomalgExternalRingInSageRep",
        IsHomalgExternalRingRep,
        [  ] );
