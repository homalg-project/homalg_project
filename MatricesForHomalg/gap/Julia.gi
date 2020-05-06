##
InstallOtherMethod( \*,
        "for homalg rings",
        [ IsHomalgRing, IsJuliaObject ], 1001, ## for this method to be triggered first it has to have at least the same rank as the above method
        
  function( R, indets )
    
    indets := JuliaToGAP( IsString, indets );
    
    return R * indets;
    
end );

##
InstallOtherMethod( \[\],
        "for homalg rings",
        [ IsHomalgRing, IsJuliaObject ], 1001, ## for this method to be triggered first it has to have at least the same rank as the above method
        
  function( R, indets )
    
    indets := JuliaToGAP( IsString, indets );
    
    return R[indets];
    
end );

##
InstallOtherMethod( CertainRows,
        "for homalg matrices",
        [ IsHomalgMatrix, IsJuliaObject ], 1001,
        
  function( M, rows )
    
    rows := JuliaToGAP( IsList, rows );
    
    return CertainRows( M, rows );
    
end );

##
InstallOtherMethod( CertainColumns,
        "for homalg matrices",
        [ IsHomalgMatrix, IsJuliaObject ], 1001,
        
  function( M, cols )
    
    cols := JuliaToGAP( IsList, cols );
    
    return CertainColumns( M, cols );
    
end );
