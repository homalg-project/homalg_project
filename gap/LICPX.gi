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
            color := "\033[4;30;46m" )
        );

##
InstallValue( LogicalImplicationsForHomalgComplexes,
        [ 
          
          [ IsZero,
            "implies", IsGradedObject ],
          
          [ IsGradedObject,
            "implies", IsComplex ],
          
          [ IsAcyclic,
            "implies", IsComplex ],
          
          [ IsComplex,
            "implies", IsSequence ],
          
          [ IsExactSequence,
            "implies", IsComplex ],
          
          [ IsShortExactSequence,
            "implies", IsExactSequence ],
          
          [ IsExactTriangle,
            "implies", IsTriangle ],
          
          [ IsExactTriangle,
            "implies", IsExactSequence ],
          
          [ IsSplitShortExactSequence,
            "implies", IsShortExactSequence ],
          
          ] );

####################################
#
# logical implications methods:
#
####################################

InstallLogicalImplicationsForHomalg( LogicalImplicationsForHomalgComplexes, IsHomalgComplex );

