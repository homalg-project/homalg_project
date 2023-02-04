# SPDX-License-Identifier: GPL-2.0-or-later
# RingsForHomalg: Dictionaries of external rings
#
# Declarations
#

##  Declaration stuff for the external computer algebra system LiE.

####################################
#
# global functions and operations:
#
####################################

DeclareGlobalFunction( "_LiE_multiple_delete" );

DeclareGlobalFunction( "InitializeLiEMacros" );

# constructor methods:

####################################
#
# representations:
#
####################################

# a new subrepresentation of the representation IshomalgExternalRingObjectRep:
DeclareRepresentation( "IsHomalgExternalRingObjectInLiERep",
        IshomalgExternalRingObjectRep,
        [  ] );

# a new subrepresentation of the representation IsHomalgExternalRingRep:
DeclareRepresentation( "IsHomalgExternalRingInLiERep",
        IsHomalgExternalRingRep,
        [  ] );
