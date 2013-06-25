#############################################################################
##
##  FakeLocalizeRing.gi                        LocalizeRingForHomalg package  
##
##  Copyright 2013, Mohamed Barakat, University of Kaiserslautern
##                  Vinay Wagh, Indian Institute of Technology Guwahati
##
##  Declarations of procedures for "fake" localized rings.
##
#############################################################################

####################################
#
# attributes:
#
####################################

DeclareAttribute( "GeneratorsOfPrimeIdeal",
        IsHomalgRing );

####################################
#
# global functions and operations:
#
####################################

# constructor methods:

################################################################################
## The ring of the type k(X)[Y] is used mainly in Quillen-Suslin (esp. proc Horrocks)
## These rings will not be used for computaions like Groebner Basis and related.
## Such ring is called "fake" local ring.
################################################################################

# Here we want to localize at a prime ideal p in k[X]
# The expected ring in the algorithm is k[X]_p[Y]
DeclareOperation( "LocalizeAtPrime",
        [ IsHomalgRing, IsList, IsList ] );
#        [ IsHomalgRing, IsList, IsHomalgModule ] );

DeclareGlobalFunction( "ElementOfHomalgFakeLocalRing" );

DeclareOperation( "BlindlyCopyMatrixPropertiesToFakeLocalMatrix",
        [ IsHomalgMatrix, IsHomalgMatrix ] );

DeclareOperation( "MatrixOverHomalgFakeLocalRing",
        [ IsHomalgMatrix, IsRingElement, IsHomalgRing ] );

DeclareOperation( "MatrixOverHomalgFakeLocalRing",
        [ IsHomalgMatrix, IsHomalgRing ] );

# ##
# DeclareOperation( "NumeratorOfPolynomial",
#         [ IsElementOfHomalgFakeLocalRingRep ] );

