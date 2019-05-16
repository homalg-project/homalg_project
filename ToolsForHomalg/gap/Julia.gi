##
InstallOtherMethod( SplitString,
        "for two Julia objects",
        [ IsJuliaObject, IsJuliaObject ],

  function( str, sep )
    
    str := JuliaToGAP( IsString, str );
    
    sep := JuliaToGAP( IsString, sep );
    
    return SplitString( str, sep );
    
end );

##
InstallOtherMethod( Read,
        "for a Julia object",
        [ IsJuliaObject ],

  function( str )
    
    str := JuliaToGAP( IsString, str );
    
    Read( str );
    
end );
