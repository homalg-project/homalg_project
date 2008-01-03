#############################################################################
##
##  Integers.gi                 homalg package               Mohamed Barakat
##
##  Copyright 2007 Lehrstuhl B für Mathematik, RWTH Aachen
##
##  The ring of integers
##
#############################################################################

####################################
#
# constructor functions and methods:
#
####################################

InstallMethod( CreateHomalgTable,
        "for the integers",
        [ IsIntegers ],
        
  function( arg )
    local RP;
    
    RP := rec( 
               ## Can optionally be provided by the RingPackage
               ## (homalg functions check if these functions are defined or not)
               ## (HomalgTable gives no default value)
               BestBasis := 
                 function( M, R )  return SmithNormalFormIntegerMatTransforms( Eval( M ) );  end,
               
               ## Must be defined if other functions are not defined
               TriangularBasis :=
                 function( M, R ) return HermiteNormalFormIntegerMatTransform ( Eval ( M ) ); end 
          );
                 
    Objectify( HomalgTableType, RP );
    
    return RP;
    
end );

