#############################################################################
##
##  Integers.gi             homalg package                   Mohamed Barakat
##
##  Copyright 2007 Lehrstuhl B für Mathematik, RWTH Aachen
##
##  The ring of integers
##
#############################################################################

InstallMethod( HomalgTable,
        "for the integers",
        [ IsIntegers ],
        
  function( arg )
    local R, RP;
    
    R := arg[1];
    
    SetGlobalDim( R, 1 );
    
    RP := rec( ring := R );
    
    ObjectifyWithAttributes(
            RP, HomalgTableType,
            
            ## Can optionally be provided by the RingPackage
            ## (homalg functions check if these functions are defined or not)
            ## (HomalgTable gives no default value)
            BestBasis, SmithNormalFormIntegerMatTransforms,
            
            ## Must be defined if other functions are not defined
            TriangularBasis, HermiteNormalFormIntegerMatTransform );
    
    SetHomalgTable( R, RP );
    
    return RP;
    
end );

