#############################################################################
##
##  HomalgTable.gi          homalg package                   Mohamed Barakat
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

InstallMethod( ViewObj,
        "for a homalg ring package conversion table",
        [IsHomalgTable],
        
  function( o )
    
    Print("<A homalg ring package conversion table>");
    
end );

InstallMethod( CertainRows,
        "for a homalg table",
        [IsHomalgTable],
        
  function(RP)
    local certain_rows;
    
    certain_rows := function(M,plist) return M.normal{plist}; end;
    
    return certain_rows;
    
end );

