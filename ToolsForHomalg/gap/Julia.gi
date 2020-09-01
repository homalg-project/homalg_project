## fallback method
InstallMethod( ConvertJuliaToGAP,
        [ IsObject ],

  IdFunc );

##
InstallMethod( ConvertJuliaToGAP,
        [ IsJuliaObject ],

  function( jobj )
    local L;
    
    if Julia.Base.typeof( jobj ) = Julia.Base.String then
        L := JuliaToGAP( IsString, jobj );
        return L;
    fi;
    
    L := JuliaToGAP( IsList, jobj );
    
    return ConvertJuliaToGAP( L );
    
end );

##
InstallMethod( ConvertJuliaToGAP,
        [ IsList ],

  function( L );
    
    return List( L, ConvertJuliaToGAP );
    
end );

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

##
InstallMethod( VisualizeInJulia,
        "for a string",
        [ IsString ],
        
  function( str )
    
    Julia.Base.display(
            Julia.Base.MIME( GAPToJulia( "image/svg+xml" ) ),
            GAPToJulia( DotToSVG( str ) ) );
    
end );

##
InstallGlobalFunction( IsRunningInJupyter,
  function( )
    
    return JuliaEvalString( "isdefined(Main, :IJulia) && Main.IJulia.inited" );
    
end );
