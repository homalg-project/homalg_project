#############################################################################
##
##  RingForHomalg.gi        homalg package                   Mohamed Barakat
##
##  Copyright 2007 Lehrstuhl B für Mathematik, RWTH Aachen
##
##  Implementation stuff for rings.
##
#############################################################################

InstallMethod( CreateHomalgTable,
        "for a ring",
        [IsSemiringWithOneAndZero],
        
  function ( arg )
    local RP;
    
    RP := rec(ring:=arg[1]);
    
    Objectify(HomalgTableType,RP);
    
    return RP;
end );

InstallMethod( CertainRows,
        "for a homalg matrix",
        [IsHomalgTable],
        
  function(RP)
    local certain_rows;
    
    certain_rows := function(M,plist) return M.normal{plist}; end;
    
    return certain_rows;
    
end );

InstallMethod( ViewObj,
        "for a homalg ring package conversion table",
        [IsHomalgTable],
        
  function( o )
    
    Print("<A homalg ring package conversion table>");
    
end );

InstallMethod( HomalgTable,
        "for the integers",
        [IsIntegers],
        
  function( arg )
    local R,RP;
    
    R := arg[1];
    
    SetGlobalDim(R,1);
    
    RP := CreateHomalgTable(R);
    
    ## Can optionally be provided by the RingPackage
    ## (homalg functions check if these functions are defined or not)
    ## (`homalg/tablename` gives no default value)
    SetBestBasis(RP,SmithNormalFormIntegerMatTransforms);
    
    ## Must be defined if other functions are not defined
    SetTriangularBasis(RP,HermiteNormalFormIntegerMatTransform);
    
    SetHomalgTable(R,RP);
    
    return RP;
    
end );

