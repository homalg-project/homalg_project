#############################################################################
##
##  Sage.gd                   RingsForHomalg package          Simon Goertzen
##
##  Copyright 2007-2008 Lehrstuhl B für Mathematik, RWTH Aachen
##
##  Declaration stuff for the external computer algebra system Sage.
##
#############################################################################

####################################
#
# global variables:
#
####################################

DeclareGlobalVariable( "HOMALG_IO_Sage" );

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
