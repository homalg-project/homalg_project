#############################################################################
##
##  Oscar.gd               RingsForHomalg package         Mohamed Barakat
##                                                    Markus Lange-Hegermann
##
##  Copyright 2007-2008 Lehrstuhl B für Mathematik, RWTH Aachen
##
##  Declaration stuff for the external computer algebra system Oscar.
##
#############################################################################

#############################################################################
# forbidden expressions inside of Oscar
# dummy_variable     to emulate Q by Q[dummy_variable]
#############################################################################

####################################
#
# global functions and operations:
#
####################################

DeclareGlobalFunction( "_Oscar_SetRing" );

DeclareGlobalFunction( "_Oscar_SetInvolution" );

DeclareGlobalFunction( "_Oscar_multiple_delete" );

DeclareGlobalFunction( "InitializeOscarMacros" );

# constructor methods:

DeclareGlobalFunction( "RingForHomalgInOscar" );

DeclareGlobalFunction( "HomalgFieldOfRationalsInOscar" );

DeclareGlobalFunction( "HomalgRingOfIntegersInOscar" );

DeclareGlobalFunction( "HomalgRingOfCyclotomicIntegersInOscar" );

DeclareGlobalFunction( "HomalgRingOfGoldenRatioIntegersInOscar" );

DeclareOperation( "HomalgQRingInOscar", [ IsFreePolynomialRing, IsHomalgRingRelations ] );
DeclareOperation( "HomalgQRingInOscar", [ IsFreePolynomialRing, IsRingElement ] ); # also includes IsHomalgMatrix
DeclareOperation( "HomalgQRingInOscar", [ IsFreePolynomialRing, IsList ] ); # also includes IsString


####################################
#
# representations:
#
####################################

# a new subrepresentation of the representation IshomalgExternalRingObjectRep:
DeclareRepresentation( "IsHomalgExternalRingObjectInOscarRep",
        IshomalgExternalRingObjectRep,
        [  ] );

# a new subrepresentation of the representation IsHomalgExternalRingRep:
DeclareRepresentation( "IsHomalgExternalRingInOscarRep",
        IsHomalgExternalRingRep,
        [  ] );