# SPDX-License-Identifier: GPL-2.0-or-later
# ToolsForHomalg: Special methods and knowledge propagation tools
#
# Implementations
#

DeclareRepresentation( "IsLazyHListRep",
        IsLazyHList,
        [ ] );

BindGlobal( "TheFamilyOfLazyHLists",
        NewFamily( "TheFamilyOfLazyHLists" ) );

BindGlobal( "TheTypeLazyHListRep",
        NewType( TheFamilyOfLazyHLists,
                IsLazyHListRep ) );

##
InstallGlobalFunction( LazyHList,
  function( domain, func )
    
    return ObjectifyWithAttributes(
                   rec( domain := domain, func := func, values := [ ] ), TheTypeLazyHListRep );
    
end );

##
InstallMethod( Length,
        [ IsLazyHListRep ],
        
  function( L )
    
    return Length( L!.domain );
    
end );

##
InstallMethod( LastOp,
        [ IsLazyHListRep ],
        
  function( L )
    
    return L[Length( L )];
    
end );

## fallback method
InstallOtherMethod( ListOfValues,
        [ IsList ],
        
  IdFunc );

##
InstallMethod( ListOfValues,
        [ IsLazyHListRep ],
        
  function( L )
    
    Perform( [ 1 .. Length( L ) ], i -> L[i] );
    
    return L!.values;
    
end );

##
InstallMethod( \=,
        [ IsLazyHListRep, IsLazyHListRep ],
        
  function( L1, L2 )
    
    return Length( L1 ) = Length( L2 ) and
           ( ( L1!.domain = L2!.domain and IsIdenticalObj( L1!.func, L2!.func ) ) or
             ForAll( [ 1 .. Length( L1 ) ], i -> L1[i] = L2[i] ) );
    
end );

##
InstallMethod( ListOp,
        [ IsLazyHListRep, IsFunction ],
        
  function( L, g )
    
    return LazyHList( L!.domain, x -> g( L!.func( x ) ) );
    
end );

##
InstallMethod( ShallowCopy,
        [ IsLazyHListRep ], 100001,
        
  function( L )
    local copy;
    
    copy := LazyHList( ShallowCopy( L!.domain ), L!.func );
    
    copy!.values := ShallowCopy( L!.values );
    
    return copy;
    
end );

##
InstallMethod( IsBound\[\],
        [ IsLazyHListRep, IsPosInt ],
        
  function( L, i )
    
    return i in [ 1 .. Length( L ) ];
    
end );

##
InstallOtherMethod( Unbind\[\],
        [ IsLazyHListRep, IsPosInt ],
        
  function( L, i )
    
    Error( "this operation is not permitted for lazy lists\n" );
    
end );

##
InstallMethod( Position,
        [ IsLazyHListRep, IsObject ],
        
  function( L, o )
    
    return First( [ 1 .. Length( L ) ], i -> L[i] = o );
    
end );

##
InstallOtherMethod( \[\],
        [ IsLazyHListRep, IsObject ],
        
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
        [ IsLazyHListRep, IsPosInt ],
        
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
        [ IsLazyHListRep, IsPosInt, IsObject ],
        
  function( L, i, o )
    
    L!.values[i] := o;
    
    return o;
    
end );

##
InstallMethod( \{\},
        [ IsLazyHListRep, IsList ], 100001,
        
  function( L, l )
    
    return LazyHList( l, i -> L[i] );
    
end );

##
InstallOtherMethod( \{\}\:\=,
        [ IsLazyHListRep, IsList, IsList ],
        
  function( L, l, o )

    Error( "not implemented yet\n" );
    
end );

##
InstallOtherMethod( Add,
        [ IsLazyHListRep, IsObject ],
        
  function( L, o )
    
    Error( "not implemented yet\n" );
    
end );

##
InstallOtherMethod( Append,
        [ IsLazyHListRep, IsList ],
        
  function( L, l )
    
    Error( "not implemented yet\n" );
    
end );

##
InstallOtherMethod( Append,
        [ IsLazyHListRep, IsLazyHListRep ],
        
  function( L1, L2 )
    
    Error( "not implemented yet\n" );
    
end );

##
InstallMethod( FilteredOp,
        [ IsLazyHListRep, IsFunction ], 100001,
        
  function( L, f )
    
    return Filtered( ListOfValues( L ), f );
    
end );

##
InstallMethod( ForAllOp,
        [ IsLazyHListRep, IsFunction ],
        
  function( L, f )
    
    return ForAllOp( [ 1 .. Length( L ) ], i -> f( L[i] ) );
    
end );

##
InstallMethod( ForAnyOp,
        [ IsLazyHListRep, IsFunction ],
        
  function( L, f )
    
    return ForAnyOp( [ 1 .. Length( L ) ], i -> f( L[i] ) );
    
end );

##
InstallMethod( ViewObj,
        [ IsLazyHListRep ],
        
  function( L )
    
    Print( "LazyHList of length ", Length( L ), " and evaluated values: " );
    ViewObj( L!.values );
    
end );

##
InstallMethod( PrintObj,
        [ IsLazyHListRep ],
        
  function( L )
    
    PrintObj( ListOfValues( L ) );
    
end );
