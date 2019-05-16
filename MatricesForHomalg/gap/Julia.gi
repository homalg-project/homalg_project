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
