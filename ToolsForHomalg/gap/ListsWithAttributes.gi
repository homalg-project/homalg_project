# SPDX-License-Identifier: GPL-2.0-or-later
# ToolsForHomalg: Special methods and knowledge propagation tools
#
# Implementations
#

DeclareRepresentation( "IsListWithAttributesRep",
        IsListWithAttributes,
        [ ] );

BindGlobal( "TheFamilyOfListsWithAttributes",
        NewFamily( "TheFamilyOfListsWithAttributes" ) );

BindGlobal( "TheTypeListWithAttributesRep",
        NewType( TheFamilyOfListsWithAttributes,
                IsListWithAttributesRep ) );

##
InstallGlobalFunction( TypedListWithAttributes,
  function( L, type, arg... )
    
    arg := Immutable( arg );
    
    return CallFuncList( ObjectifyWithAttributes,
                   Concatenation( [ rec( list := L, type := type, attributes := arg ), type ], arg ) );
    
end );

##
InstallGlobalFunction( ListWithAttributes,
  function( L, arg... )
    
    return CallFuncList( TypedListWithAttributes,
                   Concatenation( [ L, TheTypeListWithAttributesRep ], arg ) );
    
end );

##
InstallMethod( Length,
        [ IsListWithAttributesRep ],
        
  function( L )
    
    return Length( L!.list );
    
end );

##
InstallMethod( \=,
        [ IsListWithAttributesRep, IsListWithAttributesRep ],
        
  function( L1, L2 )
    
    return L1!.list = L2!.list and L1!.attributes = L2!.attributes;
    
end );

##
InstallMethod( ShallowCopy,
        [ IsListWithAttributesRep ], 100001,
        
  function( L )
    
    return CallFuncList( TypedListWithAttributes,
                   Concatenation( [ ShallowCopy( L!.list ), L!.type ], L!.attributes ) );
    
end );

##
InstallMethod( IsBound\[\],
        [ IsListWithAttributesRep, IsPosInt ],
        
  function( L, i )
    
    return IsBound( L!.list[i] );
    
end );

##
InstallOtherMethod( Unbind\[\],
        [ IsListWithAttributesRep, IsPosInt ],
        
  function( L, i )
    
    Unbind( L!.list[i] );
    
end );

##
InstallMethod( Position,
        [ IsListWithAttributesRep, IsObject ],
        
  function( L, o )
    
    return Position( L!.list, o );
    
end );

##
InstallMethod( \[\],
        [ IsListWithAttributesRep, IsPosInt ],
        
  function( L, i )
    
    return L!.list[i];
    
end );

##
InstallOtherMethod( \[\]\:\=,
        [ IsListWithAttributesRep, IsPosInt, IsObject ],
        
  function( L, i, o )

    L!.list[i] := o;
    
    return L;
    
end );

##
InstallMethod( \{\},
        [ IsListWithAttributesRep, IsList ], 100001,
        
  function( L, l )
    
    return CallFuncList( TypedListWithAttributes,
                   Concatenation( [ L!.list{l}, L!.type ], L!.attributes ) );
    
end );

##
InstallOtherMethod( \{\}\:\=,
        [ IsListWithAttributesRep, IsList, IsList ],
        
  function( L, l, o )

    L!.list{l} := o;
    
    return L;
    
end );

##
InstallOtherMethod( Add,
        [ IsListWithAttributesRep, IsObject ],
        
  function( L, o )
    
    Add( L!.list, o );
    
end );

##
InstallOtherMethod( Append,
        [ IsListWithAttributesRep, IsList ],
        
  function( L, l )
    
    Append( L!.list, l );
    
end );

##
InstallOtherMethod( Append,
        [ IsListWithAttributesRep, IsListWithAttributesRep ],
        
  function( L1, L2 )
    
    Append( L1, L2!.list );
    
end );

##
InstallMethod( FilteredOp,
        [ IsListWithAttributesRep, IsFunction ], 100001,
        
  function( L, f )
    
    return CallFuncList( TypedListWithAttributes,
                   Concatenation( [ Filtered( L!.list, f ), L!.type ], L!.attributes ) );
    
end );

##
InstallMethod( ForAllOp,
        [ IsListWithAttributesRep, IsFunction ],
        
  function( L, f )
    
    return ForAllOp( L!.list, f );
    
end );

##
InstallMethod( ForAnyOp,
        [ IsListWithAttributesRep, IsFunction ],
        
  function( L, f )
    
    return ForAnyOp( L!.list, f );
    
end );

##
InstallMethod( ViewObj,
        [ IsListWithAttributesRep ],
        
  function( L )
    
    ViewObj( L!.list );
    
end );
