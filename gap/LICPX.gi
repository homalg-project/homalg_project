#############################################################################
##
##  LICPX.gi                    LICPX subpackage             Mohamed Barakat
##
##         LICPX = Logical Implications for homalg MODules
##
##  Copyright 2007-2008 Lehrstuhl B für Mathematik, RWTH Aachen
##
##  Implementation stuff for the LICPX subpackage.
##
#############################################################################

####################################
#
# global variables:
#
####################################

# a central place for configuration variables:

InstallValue( LICPX,
        rec(
            )
        );

####################################
#
# logical implications methods:
#
####################################

####################################
#
# global variables:
#
####################################

InstallValue( LogicalImplicationsForHomalgComplexes,
        [ ## IsTorsionFreeModule:
          
          [ IsZero,
            "implies", IsGradedObject ],
          
          [ IsGradedObject,
            "implies", IsComplex ],
          
          [ IsAcyclic,
            "implies", IsComplex ],
          
          [ IsExactSequence,
            "implies", IsComplex ],
          
          [ IsShortExactSequence,
            "implies", IsExactSequence ],
          
          ] );

####################################
#
# logical implications methods:
#
####################################

InstallLogicalImplicationsForHomalg( LogicalImplicationsForHomalgComplexes, IsHomalgComplex );

