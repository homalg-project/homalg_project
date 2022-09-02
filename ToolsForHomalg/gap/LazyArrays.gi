# SPDX-License-Identifier: GPL-2.0-or-later
# ToolsForHomalg: Special methods and knowledge propagation tools
#
# Implementations
#

DeclareRepresentation( "IsLazyArrayRep",
        IsLazyArray,
        [ ] );

BindGlobal( "TheFamilyOfLazyArrays",
        NewFamily( "TheFamilyOfLazyArrays" ) );

BindGlobal( "TheTypeLazyArrayRep",
        NewType( TheFamilyOfLazyArrays,
                IsLazyArrayRep ) );

## LazyArray must ShallowCopy the third argument to protect it from CompilerForCAP
## that might identify multiple different (mutable) lists (e.g., empty lists),
## which  should be changed in different ways
InstallGlobalFunction( LazyArray,
  function( length, func, values )
    
    return ObjectifyWithAttributes(
                   rec( length := length, range := [ 0 .. length - 1 ], func := ShallowCopy( func ), values := ShallowCopy( values ) ), TheTypeLazyArrayRep );
    
end );

##
InstallGlobalFunction( LazyArrayFromList,
  function( L )
    
    return LazyArray( Length( L ), i -> L[1 + i], L );
    
end );

##
InstallMethod( Length,
        [ IsLazyArrayRep ],
        
  function( L )
    
    return Length( L!.range );
    
end );

##
InstallMethod( \[\],
        [ IsLazyArrayRep, IsInt ],
        
  function( L, i )
    local values;
    
    if not i in L!.range then
        Error( "the index ", i, " is not in the valid range ", L!.range );
    fi;
    
    values := L!.values;
    
    if not IsBound( values[1 + i] ) then
        values[1 + i] := L!.func( i );
    else
        Assert( 4, values[1 + i] = L!.func( i ) );
    fi;
    
    return values[1 + i];
    
end );

##
InstallMethod( ListOfValues,
        [ IsLazyArrayRep ],
        
  function( L )
    
    Perform( L!.range, i -> L[i] );
    
    return L!.values;
    
end );

##
InstallMethod( \=,
        [ IsLazyArrayRep, IsLazyArrayRep ],
        
  function( L1, L2 )
    
    return L1!.length = L2!.length and
           ( IsIdenticalObj( L1!.func, L2!.func ) or
             ForAll( L1!.range, i -> L1[i] = L2[i] ) );
    
end );

##
InstallMethod( ListOp,
        [ IsLazyArrayRep, IsFunction ],
        
  function( L, g )
    
    return LazyArray( L!.range, x -> g( L!.func( x ) ) );
    
end );

##
InstallMethod( ShallowCopy,
        [ IsLazyArrayRep ], 100001,
        
  function( L )
    
    ## LazyArray shallow-copies the values
    return LazyArray( L!.length, ShallowCopy( L!.func ), L!.values );
    
end );

##
InstallMethod( IsBound\[\],
        [ IsLazyArrayRep, IsInt ],
        
  function( L, i )
    
    return i in L!.range;
    
end );

##
InstallOtherMethod( Unbind\[\],
        [ IsLazyArrayRep, IsInt ],
        
  function( L, i )
    
    Error( "this operation is not permitted for lazy arrays\n" );
    
end );

##
InstallMethod( Position,
        [ IsLazyArrayRep, IsObject, IsInt ],
        
  function( L, o, start )
    
    return First( [ start .. L!.length - 1 ], i -> L[i] = o );
    
end );

##
InstallMethod( \in,
        [ IsObject, IsLazyArrayRep ],
        
  function( o, L )
    
    return IsInt( Position( L, o ) );
    
end );

##
InstallOtherMethod( \[\]\:\=,
        [ IsLazyArrayRep, IsInt, IsObject ],
        
  function( L, i, o )
    
    L!.values[1 + i] := o;
    
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
    local l, func;
    
    l := L!.length;
    
    L!.length := l + 1;
    
    L!.range := [ 0 .. L!.length - 1 ];
    
    L!.values[L!.length] := o;
    
    func := ShallowCopy( L!.func );
    
    L!.func :=
      function( i )
        if i = l then
            return o;
        else
            return func( i );
        fi;
    end;
    
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
    local l1, func1, func2, i;
    
    l1 := L1!.length;
    
    func1 := ShallowCopy( L1!.func );
    func2 := ShallowCopy( L2!.func );
    
    L1!.length := l1 + L2!.length;
    
    L1!.range := [ 0 .. L1!.length - 1 ];
    
    for i in [ 1 .. Length( L2!.values ) ] do
        if IsBound(  L2!.values[i] ) then
            L1!.values[l1 + i] := L2!.values[i];
        fi;
    od;
    
    L1!.func :=
      function( i )
        if i < l1 then
            return func1( i );
        else
            return func2( i - l1 );
        fi;
    end;
    
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
    
    return ForAllOp( L!.range, i -> f( L[i] ) );
    
end );

##
InstallMethod( ForAnyOp,
        [ IsLazyArrayRep, IsFunction ],
        
  function( L, f )
    
    return ForAnyOp( L!.range, i -> f( L[i] ) );
    
end );

##
InstallMethod( SSortedList,
        [ IsLazyArrayRep ],
        
  function( L )
    
    return SSortedList( ListOfValues( L ) );
    
end );

##
InstallMethod( Iterator,
        [ IsLazyArrayRep ],
        
  function( L )
    
    return IteratorByFunctions(
             rec(
                 pos := -1,
                 length := L!.length,
                 NextIterator :=
                 function( iter )
                   iter!.pos := iter!.pos + 1;
                   return L[iter!.pos];
                 end,
                 IsDoneIterator :=
                   function( iter )
                     return iter!.pos = iter!.length - 1;
                 end,
                 ShallowCopy :=
                   function( iter )
                     return
                       rec( pos := iter!.pos,
                            length := iter!.length,
                            NextIterator := iter!.NextIterator,
                            IsDoneIterator := iter!.IsDoneIterator,
                            ShallowCopy := iter!.ShallowCopy );
                   end ) );
                   
end );

##
InstallMethod( ViewObj,
        [ IsLazyArrayRep ],
        
  function( L )
    
    Print( "LazyArray of length ", L!.length, " and evaluated values: " );
    ViewObj( L!.values );
    
end );

##
InstallMethod( PrintObj,
        [ IsLazyArrayRep ],
        
  function( L )
    local values;
    
    values := L!.values;
    
    if L!.length = Length( values ) then
        PrintObj( values );
    else
        PrintObj( values);
        Print( ".?."  );
    fi;
    
end );
