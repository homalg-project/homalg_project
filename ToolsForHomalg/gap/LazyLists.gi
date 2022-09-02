# SPDX-License-Identifier: GPL-2.0-or-later
# ToolsForHomalg: Special methods and knowledge propagation tools
#
# Implementations
#

DeclareRepresentation( "IsLazyListRep",
        IsLazyList,
        [ ] );

BindGlobal( "TheFamilyOfLazyLists",
        NewFamily( "TheFamilyOfLazyLists" ) );

BindGlobal( "TheTypeLazyListRep",
        NewType( TheFamilyOfLazyLists,
                IsLazyListRep ) );

##
InstallGlobalFunction( LazyList,
  function( domain, func )
    
    return ObjectifyWithAttributes(
                   rec( domain := domain, func := func, values := [ ] ), TheTypeLazyListRep );
    
end );

##
InstallMethod( Length,
        [ IsLazyListRep ],
        
  function( L )
    
    return Length( L!.domain );
    
end );

##
InstallMethod( ListOfValues,
        [ IsLazyListRep ],
        
  function( L )
    
    Perform( [ 1 .. Length( L ) ], i -> L[i] );
    
    return L!.values;
    
end );

##
InstallMethod( \=,
        [ IsLazyListRep, IsLazyListRep ],
        
  function( L1, L2 )
    
    return Length( L1 ) = Length( L2 ) and
           ( ( L1!.domain = L2!.domain and IsIdenticalObj( L1!.func, L2!.func ) ) or
             ForAll( [ 1 .. Length( L1 ) ], i -> L1[i] = L2[i] ) );
    
end );

##
InstallMethod( ListOp,
        [ IsLazyListRep, IsFunction ],
        
  function( L, g )
    
    return LazyList( L!.domain, x -> g( L!.func( x ) ) );
    
end );

##
InstallMethod( ShallowCopy,
        [ IsLazyListRep ], 100001,
        
  function( L )
    local copy;
    
    copy := LazyList( ShallowCopy( L!.domain ), L!.func );
    
    copy!.values := ShallowCopy( L!.values );
    
    return copy;
    
end );

##
InstallMethod( IsBound\[\],
        [ IsLazyListRep, IsPosInt ],
        
  function( L, i )
    
    return i in [ 1 .. Length( L ) ];
    
end );

##
InstallOtherMethod( Unbind\[\],
        [ IsLazyListRep, IsPosInt ],
        
  function( L, i )
    
    Error( "this operation is not permitted for lazy lists\n" );
    
end );

##
InstallMethod( Position,
        [ IsLazyListRep, IsObject ],
        
  function( L, o )
    
    return First( [ 1 .. Length( L ) ], i -> L[i] = o );
    
end );

##
InstallOtherMethod( \[\],
        [ IsLazyListRep, IsObject ],
        
  function( L, o )
    local i;
    
    i := Position( L!.domain, o );
    
    if not IsBound( L!.values[i] ) then
        L!.values[i] := L!.func( o );
    fi;
    
    return L!.values[i];
    
end );

##
InstallMethod( \[\],
        [ IsLazyListRep, IsPosInt ],
        
  function( L, i )
    local values;
    
    values := L!.values;
    
    if not IsBound( values[i] ) then
        values[i] := L!.func( L!.domain[i] );
    fi;
    
    return values[i];
    
end );

##
InstallOtherMethod( \[\]\:\=,
        [ IsLazyListRep, IsPosInt, IsObject ],
        
  function( L, i, o )
    
    L!.values[i] := o;
    
    return o;
    
end );

##
InstallMethod( \{\},
        [ IsLazyListRep, IsList ], 100001,
        
  function( L, l )
    
    Error( "not implemented yet\n" );
    
end );

##
InstallOtherMethod( \{\}\:\=,
        [ IsLazyListRep, IsList, IsList ],
        
  function( L, l, o )

    Error( "not implemented yet\n" );
    
end );

##
InstallOtherMethod( Add,
        [ IsLazyListRep, IsObject ],
        
  function( L, o )
    
    Error( "not implemented yet\n" );
    
end );

##
InstallOtherMethod( Append,
        [ IsLazyListRep, IsList ],
        
  function( L, l )
    
    Error( "not implemented yet\n" );
    
end );

##
InstallOtherMethod( Append,
        [ IsLazyListRep, IsLazyListRep ],
        
  function( L1, L2 )
    
    Error( "not implemented yet\n" );
    
end );

##
InstallMethod( FilteredOp,
        [ IsLazyListRep, IsFunction ], 100001,
        
  function( L, f )
    
    return Filtered( ListOfValues( L ), f );
    
end );

##
InstallMethod( ForAllOp,
        [ IsLazyListRep, IsFunction ],
        
  function( L, f )
    
    return ForAllOp( [ 1 .. Length( L ) ], i -> f( L[i] ) );
    
end );

##
InstallMethod( ForAnyOp,
        [ IsLazyListRep, IsFunction ],
        
  function( L, f )
    
    return ForAnyOp( [ 1 .. Length( L ) ], i -> f( L[i] ) );
    
end );

##
InstallMethod( ViewObj,
        [ IsLazyListRep ],
        
  function( L )
    
    Print( "LazyList of length ", Length( L ), " and evaluated values: " );
    ViewObj( L!.values );
    
end );

##
InstallMethod( PrintObj,
        [ IsLazyListRep ],
        
  function( L )
    
    PrintObj( ListOfValues( L ) );
    
end );
