DeclareRepresentation( "IsLazyArrayRep",
        IsLazyArray,
        [ ] );

BindGlobal( "TheFamilyOfLazyArrays",
        NewFamily( "TheFamilyOfLazyArrays" ) );

BindGlobal( "TheTypeLazyArrayRep",
        NewType( TheFamilyOfLazyArrays,
                IsLazyArrayRep ) );

##
InstallGlobalFunction( LazyArray,
  function( domain, func )
    
    return ObjectifyWithAttributes(
                   rec( domain := domain, func := func, values := [ ] ), TheTypeLazyArrayRep );
    
end );

##
InstallMethod( Length,
        [ IsLazyArrayRep ],
        
  function( L )
    
    return Length( L!.domain );
    
end );

##
InstallMethod( ListOfValues,
        [ IsLazyArrayRep ],
        
  function( L )
    
    Perform( [ 1 .. Length( L ) ], i -> L[i] );
    
    return L!.values;
    
end );

##
InstallMethod( \=,
        [ IsLazyArrayRep, IsLazyArrayRep ],
        
  function( L1, L2 )
    
    return Length( L1 ) = Length( L2 ) and
           ( ( L1!.domain = L2!.domain and IsIdenticalObj( L1!.func, L2!.func ) ) or
             ForAll( [ 1 .. Length( L1 ) ], i -> L1[i] = L2[i] ) );
    
end );

##
InstallMethod( ListOp,
        [ IsLazyArrayRep, IsFunction ],
        
  function( L, g )
    
    return LazyArray( L!.domain, x -> g( L!.func( x ) ) );
    
end );

##
InstallMethod( ShallowCopy,
        [ IsLazyArrayRep ], 100001,
        
  function( L )
    local copy;
    
    copy := LazyArray( ShallowCopy( L!.domain ), L!.func );
    
    copy!.values := ShallowCopy( L!.values );
    
    return copy;
    
end );

##
InstallMethod( IsBound\[\],
        [ IsLazyArrayRep, IsPosInt ],
        
  function( L, i )
    
    return i in [ 1 .. Length( L ) ];
    
end );

##
InstallOtherMethod( Unbind\[\],
        [ IsLazyArrayRep, IsPosInt ],
        
  function( L, i )
    
    Error( "this operation is not permitted for lazy lists\n" );
    
end );

##
InstallMethod( Position,
        [ IsLazyArrayRep, IsObject ],
        
  function( L, o )
    
    return First( [ 1 .. Length( L ) ], i -> L[i] = o );
    
end );

##
InstallOtherMethod( \[\],
        [ IsLazyArrayRep, IsObject ],
        
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
        [ IsLazyArrayRep, IsPosInt ],
        
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
        [ IsLazyArrayRep, IsPosInt, IsObject ],
        
  function( L, i, o )
    
    L!.values[i] := o;
    
    return o;
    
end );

##
InstallMethod( \{\},
        [ IsLazyArrayRep, IsList ], 100001,
        
  function( L, l )
    
    Error( "not implemented yet\n" );
    
end );

##
InstallOtherMethod( \{\}\:\=,
        [ IsLazyArrayRep, IsList, IsList ],
        
  function( L, l, o )

    Error( "not implemented yet\n" );
    
end );

##
InstallOtherMethod( Add,
        [ IsLazyArrayRep, IsObject ],
        
  function( L, o )
    
    Error( "not implemented yet\n" );
    
end );

##
InstallOtherMethod( Append,
        [ IsLazyArrayRep, IsList ],
        
  function( L, l )
    
    Error( "not implemented yet\n" );
    
end );

##
InstallOtherMethod( Append,
        [ IsLazyArrayRep, IsLazyArrayRep ],
        
  function( L1, L2 )
    
    Error( "not implemented yet\n" );
    
end );

##
InstallMethod( FilteredOp,
        [ IsLazyArrayRep, IsFunction ], 100001,
        
  function( L, f )
    
    return Filtered( ListOfValues( L ), f );
    
end );

##
InstallMethod( ForAllOp,
        [ IsLazyArrayRep, IsFunction ],
        
  function( L, f )
    
    return ForAllOp( [ 1 .. Length( L ) ], i -> f( L[i] ) );
    
end );

##
InstallMethod( ForAnyOp,
        [ IsLazyArrayRep, IsFunction ],
        
  function( L, f )
    
    return ForAnyOp( [ 1 .. Length( L ) ], i -> f( L[i] ) );
    
end );

##
InstallMethod( ViewObj,
        [ IsLazyArrayRep ],
        
  function( L )
    
    Print( "LazyArray with evaluated values: " );
    ViewObj( L!.values );
    
end );

##
InstallMethod( PrintObj,
        [ IsLazyArrayRep ],
        
  function( L )
    
    PrintObj( ListOfValues( L ) );
    
end );
