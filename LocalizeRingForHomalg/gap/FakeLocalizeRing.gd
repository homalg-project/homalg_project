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

#! @Chapter Fake localize ring

####################################
#
#! @Section Attributes:
#
####################################

#! @Description
#!  Generators of prime ideal at which the base of the fake local ring is localized at
#! @Returns a &homalg; matrix
DeclareAttribute( "GeneratorsOfPrimeIdeal",
                  IsHomalgRing );

####################################
#
# global functions and operations:
#
####################################

#! @Section constructor methods:

################################################################################
## The ring of the type k(X)[Y] is used mainly in Quillen-Suslin (esp. proc Horrocks)
## These rings will not be used for computaions like Groebner Basis and related.
## Such ring is called "fake" local ring.
################################################################################

# Here we want to localize at a prime ideal p in k[X]
# The expected ring in the algorithm is k[X]_p[Y]
#! @Description
#!  Constructor for the fake ring localized at prime ideal
#!  second line of documentation
#! @Returns 
DeclareOperation( "LocalizeBaseRingAtPrime",
                  [ IsHomalgRing, IsList, IsList ] );

#! @Description
#!  Constructor for the fake ring localized at prime ideal
#! @Returns 
DeclareOperation( "LocalizeBaseRingAtPrime",
                  [ IsHomalgRing, IsList ] );

#! @Description
#!  Constructor for elements of fake local ring localized at prime ideal
#! @Returns 
DeclareGlobalFunction( "ElementOfHomalgFakeLocalRing" );

#! @Description
#!  
#! @Returns 
DeclareOperation( "BlindlyCopyMatrixPropertiesToFakeLocalMatrix",
                  [ IsHomalgMatrix, IsHomalgMatrix ] );

#! @Description
#!  Constructor for matrices over fake local ring localized at prime ideal
#! @Returns 
DeclareOperation( "MatrixOverHomalgFakeLocalRing",
                  [ IsHomalgMatrix, IsHomalgRing ] );

#! @Description
#!  Returns globalR modulo the prime ideal
#! @Returns 
DeclareOperation( "AssociatedResidueClassRing",
                  [ IsHomalgRing ] );

#! @Description
#!  Returns globalR modulo the prime ideal
#! @Returns 
DeclareOperation( "AssociatedResidueClassRing",
                  [ IsHomalgRingElement ] );

#! @Description
#!  Returns globalR modulo the prime ideal
#! @Returns 
DeclareOperation( "AssociatedResidueClassRing",
                  [ IsHomalgMatrix ] );
