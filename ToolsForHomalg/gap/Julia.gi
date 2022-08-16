# SPDX-License-Identifier: GPL-2.0-or-later
# ToolsForHomalg: Special methods and knowledge propagation tools
#
# Implementations
#

## fallback method
InstallMethod( ConvertJuliaToGAP,
        [ IsObject ],

  IdFunc );

##
InstallMethod( ConvertJuliaToGAP,
        [ IsJuliaObject ],

  function( jobj )
    local L;
    
    if Julia.Base.isa( jobj, Julia.Base.Array ) then
        L := JuliaToGAP( IsList, jobj );
        return ConvertJuliaToGAP( L );
    elif Julia.Base.typeof( jobj ) = Julia.Base.String then
        L := JuliaToGAP( IsString, jobj );
    elif Julia.Base.isa( jobj, Julia.Base.Int ) then
        L := JuliaToGAP( IsInt, jobj );
    elif Julia.Base.isa( jobj, Julia.Base.Rational ) then
        L := JuliaToGAP( IsRat, jobj );
    else
        Error( "only the julia types { Array, String, Int, Rational } are currently supported but got ",
               Julia.Base.typeof( jobj ), "\n" );
    fi;
    
    return L;
    
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
InstallGlobalFunction( IsRunningInJupyter,
  function( )
    
    return JuliaEvalString( "isdefined(Main, :IJulia) && Main.IJulia.inited" );
    
end );

##
InstallGlobalFunction( IsRunningInPluto,
  function( )
    
    return JuliaEvalString( "isdefined(Main, :PlutoRunner) && Main.PlutoRunner isa Module" );
    
end );

##
InstallMethod( Visualize,
        "for a string",
        [ IsString ],
        
  function( str )
    
    if IsRunningInJupyter( ) then
        
        return Julia.Base.display(
                       Julia.Base.MIME( GAPToJulia( "image/svg+xml" ) ),
                       GAPToJulia( DotToSVG( str ) ) );
        
    elif IsRunningInPluto( ) then
        
        JuliaEvalString( "import PlutoUI" );
        
        return Julia.PlutoUI.Show(
                       Julia.Base.MIME( GAPToJulia( "image/svg+xml" ) ),
                       GAPToJulia( DotToSVG( str ) ) );
        
    fi;
    
    TryNextMethod( );
    
end );
