#############################################################################
##
##  Singular.gd               RingsForHomalg package         Mohamed Barakat
##                                                    Markus Lange-Hegermann
##
##  Copyright 2007-2008 Lehrstuhl B für Mathematik, RWTH Aachen
##
##  Declaration stuff for the external computer algebra system Singular.
##
#############################################################################

#############################################################################
# forbidden expressions inside of Singular
# dummy_variable     to emulate Q by Q[dummy_variable]
#############################################################################

####################################
#
# global variables:
#
####################################

DeclareGlobalVariable( "HOMALG_IO_Singular" );

DeclareGlobalVariable( "SingularMacros" );

####################################
#
# global functions and operations:
#
####################################

DeclareGlobalFunction( "_Singular_SetRing" );

DeclareGlobalFunction( "_Singular_SetInvolution" );

DeclareGlobalFunction( "_Singular_multiple_delete" );

DeclareGlobalFunction( "InitializeSingularMacros" );

# constructor methods:

DeclareGlobalFunction( "RingForHomalgInSingular" );

DeclareGlobalFunction( "HomalgFieldOfRationalsInSingular" );

DeclareGlobalFunction( "HomalgRingOfIntegersInSingular" );

DeclareOperation( "HomalgQRingInSingular", [ IsFreePolynomialRing, IsHomalgRingRelations ] );
DeclareOperation( "HomalgQRingInSingular", [ IsFreePolynomialRing, IsRingElement ] ); # also includes IsHomalgMatrix
DeclareOperation( "HomalgQRingInSingular", [ IsFreePolynomialRing, IsList ] ); # also includes IsString


####################################
#
# representations:
#
####################################

# a new subrepresentation of the representation IshomalgExternalRingObjectRep:
DeclareRepresentation( "IsHomalgExternalRingObjectInSingularRep",
        IshomalgExternalRingObjectRep,
        [  ] );

# a new subrepresentation of the representation IsHomalgExternalRingRep:
DeclareRepresentation( "IsHomalgExternalRingInSingularRep",
        IsHomalgExternalRingRep,
        [  ] );

# a new subrepresentation of the representation IsHomalgExternalRingRep:
DeclareRepresentation( "IsHomalgExternalQRingInSingularRep",
        IsHomalgExternalRingInSingularRep,
        [  ] );
