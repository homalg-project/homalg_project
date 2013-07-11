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

DeclareAttributeWithDocumentation( "GeneratorsOfPrimeIdeal",
        IsHomalgRing,
        "Generators of prime ideal at which the base of the fake local ring is localized at",
        "a &homalg; matrix"
);

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

#DeclareOperation( "LocalizeBaseRingAtPrime",
DeclareOperationWithDocumentation( "LocalizeBaseRingAtPrime",
        [ IsHomalgRing, IsList, IsList ],
        [ "Constructor for the fake ring localized at prime ideal",
          "second line of documentation" ],
        ""
);

# DeclareOperation( "LocalizeBaseRingAtPrime",
DeclareOperationWithDocumentation( "LocalizeBaseRingAtPrime",
        [ IsHomalgRing, IsList ] ,
        "Constructor for the fake ring localized at prime ideal",
        ""
);

# DeclareGlobalFunction( "ElementOfHomalgFakeLocalRing" );
DeclareGlobalFunctionWithDocumentation( "ElementOfHomalgFakeLocalRing",
        "Constructor for elements of fake local ring localized at prime ideal",
        ""
);
        
# DeclareOperation( "BlindlyCopyMatrixPropertiesToFakeLocalMatrix",
DeclareOperationWithDocumentation( "BlindlyCopyMatrixPropertiesToFakeLocalMatrix",
        [ IsHomalgMatrix, IsHomalgMatrix ],
        "",
        ""
);

# DeclareOperation( "MatrixOverHomalgFakeLocalRing",
DeclareOperationWithDocumentation( "MatrixOverHomalgFakeLocalRing",
        [ IsHomalgMatrix, IsHomalgRing ],
        "Constructor for matrices over fake local ring localized at prime ideal",
        ""
);

DeclareOperationWithDocumentation( "AssociatedResidueClassRing",
        [ IsHomalgRing ],
        "Returns globalR modulo the prime ideal",
        ""
);

DeclareOperationWithDocumentation( "AssociatedResidueClassRing",
        [ IsHomalgRingElement ],
        "Returns globalR modulo the prime ideal",
        ""
);

DeclareOperationWithDocumentation( "AssociatedResidueClassRing",
        [ IsHomalgMatrix ],
        "Returns globalR modulo the prime ideal",
        ""
);
