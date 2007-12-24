#############################################################################
##
##  HomalgTable.gi          homalg package                   Mohamed Barakat
##
##  Copyright 2007 Lehrstuhl B für Mathematik, RWTH Aachen
##
##  Implementation stuff for rings.
##
#############################################################################

# A new Family
BindGlobal("HomalgTableFamily",
        NewFamily("HomalgTableFamily"));

# We have different representations:
DeclareRepresentation( "IsHomalgTableRep", IsHomalgTable, ["ring"]);

BindGlobal("HomalgTableType",
        NewType(HomalgTableFamily,
                IsHomalgTableRep));

##
InstallMethod( CreateHomalgTable,
        "for a ring",
        [IsSemiringWithOneAndZero],
        
  function ( arg )
    local RP;
    
    RP := rec(ring:=arg[1]);
    
    Objectify(HomalgTableType,RP);
    
    return RP;
end );

##
InstallMethod( ViewObj,
        "for a homalg ring package conversion table",
        [IsHomalgTable],
        
  function( o )
    
    Print("<A homalg ring package conversion table>");
    
end );

##
InstallMethod( CertainRows,
        "for a homalg table",
        [IsHomalgTable],
        
  function(RP)
    
    return CertainRows;
    
end );

##
InstallMethod( CertainRows,
        "for a homalg matrix",
        [IsObject, IsList],
        
  function(M, plist)
    
    return M.normal{plist};
    
end );

