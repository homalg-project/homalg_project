# SPDX-License-Identifier: GPL-2.0-or-later
# MatricesForHomalg: Matrices for the homalg project
#
# Implementations
#

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

##
InstallMethod( ExportIndeterminatesToJulia,
        "for homalg rings",
        [ IsHomalgRing ],
        
  function( R )
    local indets, x_name, x;
    
    indets := Indeterminates( R );
    
    for x in indets do
        x_name := String( x );
        if IsBoundGlobal( x_name ) then
            if not IsHomalgRingElement( ValueGlobal( x_name ) ) then
                Error( "the name ", x_name, " is not bound to a homalg ring element\n" );
            elif IsReadOnlyGlobal( x_name ) then
                MakeReadWriteGlobal( x_name );
            fi;
            UnbindGlobal( x_name );
        fi;
        BindGlobal( x_name, x );
        JuliaEvalString( Concatenation( x_name, " = GAP.Globals.", x_name ) );
    od;
    
    return indets;
    
end );

##
InstallMethod( ExportRationalParametersToJulia,
        "for homalg rings",
        [ IsHomalgRing and HasRationalParameters ],
        
  function( R )
    local params, x_name, x;
    
    params := RationalParameters( R );
    
    for x in params do
        x_name := ShallowCopy( String( x ) );
        RemoveCharacters( x_name, "()" );
        if IsBoundGlobal( x_name ) then
            if not IsHomalgRingElement( ValueGlobal( x_name ) ) then
                Error( "the name ", x_name, " is not bound to a homalg ring element\n" );
            elif IsReadOnlyGlobal( x_name ) then
                MakeReadWriteGlobal( x_name );
            fi;
            UnbindGlobal( x_name );
        fi;
        BindGlobal( x_name, x );
        JuliaEvalString( Concatenation( x_name, " = GAP.Globals.", x_name ) );
    od;
    
    return params;
    
end );

##
InstallMethod( ExportVariablesToJulia,
        "for homalg rings",
        [ IsHomalgRing ],
        
  function( R )
    
    return ExportIndeterminatesToJulia( R );
    
end );

##
InstallMethod( ExportVariablesToJulia,
        "for homalg rings",
        [ IsHomalgRing and HasRationalParameters ],
        
  function( R )
    
    return Concatenation(
                   ExportRationalParametersToJulia( R ),
                   ExportIndeterminatesToJulia( R ) );
    
end );
