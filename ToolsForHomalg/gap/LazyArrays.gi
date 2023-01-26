# SPDX-License-Identifier: GPL-2.0-or-later
# ToolsForHomalg: Special methods and knowledge propagation tools
#
# Implementations
#

BindGlobal( "TheFamilyOfLazyArrays",
        NewFamily( "TheFamilyOfLazyArrays" ) );

BindGlobal( "TheTypeLazyArray",
        NewType( TheFamilyOfLazyArrays,
                IsLazyArray ) );

DeclareRepresentation( "IsLazyInterval",
        IsLazyArray,
        [ ] );

DeclareRepresentation( "IsLazyConstantArray",
        IsLazyArray,
        [ ] );

DeclareRepresentation( "IsLazyArrayFromList",
        IsLazyArray,
        [ ] );

BindGlobal( "TheTypeLazyInterval",
        NewType( TheFamilyOfLazyArrays,
                IsLazyInterval ) );

BindGlobal( "TheTypeLazyConstantArray",
        NewType( TheFamilyOfLazyArrays,
                IsLazyConstantArray ) );

BindGlobal( "TheTypeLazyArrayFromList",
        NewType( TheFamilyOfLazyArrays,
                 IsLazyArrayFromList ) );

## never use LazyArrayWithValues in the code since CompilerForCAP
## might identify multiple different (mutable) lists (e.g., empty lists),
## which  should be changed in different ways, and we do not want
## to call ShallowCopy here
InstallGlobalFunction( LazyArrayWithValues,
  function( length, func, values, type )
    
    Assert( 0, IsInt( length ) and length >= 0 );
    Assert( 0, IsFunction( func ) );
    
    return ObjectifyWithAttributes(
                   rec( length := length, func := func, values := values ), type );
    
end );

##
InstallMethod( Length,
        [ IsLazyArray ],
        
  function( L )
    
    return L!.length;
    
end );

##
InstallMethod( ShallowCopy,
        [ IsLazyArray ], 100001,
        
  function( L )
    
    return LazyArrayWithValues( L!.length, L!.func, ShallowCopy( L!.values ), TheTypeLazyArray );
    
end );

##
InstallMethod( Iterator,
        [ IsLazyArray ],
        
  function( L )
    
    return IteratorByFunctions(
             rec(
                 pos := -1,
                 len := L!.length,
                 list := L,
                 NextIterator :=
                 function( iter )
                   iter!.pos := iter!.pos + 1;
                   return iter!.list[iter!.pos];
                 end,
                 IsDoneIterator :=
                   function( iter )
                     return iter!.pos = iter!.len - 1;
                 end,
                 ShallowCopy :=
                   function( iter )
                     return
                       rec( pos := iter!.pos,
                            len := iter!.len,
                            list := iter!.list );
                   end ) );
                   
end );

##
InstallGlobalFunction( LazyArray,
  function( length, func )
    
    return LazyArrayWithValues( length, func, [ ], TheTypeLazyArray );
    
end );

##
InstallGlobalFunction( LazyStandardInterval,
  function( length )
    
    return LazyArrayWithValues( length, IdFunc, [ ], TheTypeLazyInterval );
    
end );

##
InstallGlobalFunction( LazyInterval,
  function( length, start )
    
    return LazyArrayWithValues( length, i -> start + i, [ ], TheTypeLazyInterval );
    
end );

##
InstallGlobalFunction( LazyConstantArray,
  function( length, number )
    
    return LazyArrayWithValues( length, i -> number, [ ], TheTypeLazyConstantArray );
    
end );

##
InstallGlobalFunction( LazyArrayFromList,
  function( L )
    
    L := ShallowCopy( L );
    
    return LazyArrayWithValues( Length( L ), i -> L[1 + i], L, TheTypeLazyArrayFromList );
    
end );

##
InstallMethod( \[\],
        [ IsLazyArray, IsInt ],
        
  function( L, i )
    local values;

    ## do not use IsBound( L[i] ) since this will invoke a function call
    if i < 0 or i >= L!.length then
        Error( "the index ", i, " is not in the valid range [ 0 .. ", L!.length, " - 1 ]" );
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
        [ IsLazyArray ],
        
  function( L )
    
    Perform( [ 0 .. L!.length - 1 ], i -> L[i] );
    
    return L!.values;
    
end );

##
InstallMethod( \=,
        [ IsLazyArray, IsLazyArray ],
        
  function( L1, L2 )
    
    return L1!.length = L2!.length and
           ( IsIdenticalObj( L1!.func, L2!.func ) or
             ForAll( LazyStandardInterval( L1!.length ), i -> L1[i] = L2[i] ) );
    
end );

##
InstallMethod( ListOp,
        [ IsLazyArray, IsFunction ],
        
  function( L, g )
    
    return LazyArray( L!.length, x -> g( L!.func( x ) ) );
    
end );

##
InstallMethod( IsBound\[\],
        [ IsLazyArray, IsInt ],
        
  function( L, i )
    
    if i >= 0 and i < L!.length then
        return true;
    fi;
    
    return false;
    
end );

##
InstallOtherMethod( Unbind\[\],
        [ IsLazyArray, IsInt ],
        
  function( L, i )
    
    Error( "this operation is not permitted for lazy arrays\n" );
    
end );

##
InstallMethod( Position,
        [ IsLazyArray, IsObject, IsInt ],
        
  function( L, o, start )
    
    return First( [ start .. L!.length - 1 ], i -> L[i] = o );
    
end );

##
InstallMethod( \in,
        [ IsObject, IsLazyArray ],
        
  function( o, L )
    
    return IsInt( Position( L, o ) );
    
end );

##
InstallOtherMethod( \[\]\:\=,
        [ IsLazyArray, IsInt, IsObject ],
        
  function( L, i, o )
    
    L!.values[1 + i] := o;
    
    return o;
    
end );

##
InstallMethod( \{\},
        [ IsLazyArray, IsList ], 100001,
        
  function( L, l )
    
    Error( "not implemented yet\n" );
    
end );

##
InstallOtherMethod( \{\}\:\=,
        [ IsLazyArray, IsList, IsList ],
        
  function( L, l, o )
    
    Error( "not implemented yet\n" );
    
end );

##
InstallOtherMethod( Add,
        [ IsLazyArray, IsObject ],
        
  function( L, o )
    local l, func;
    
    l := L!.length;
    
    L!.length := l + 1;
    
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
        [ IsLazyArray, IsList ],
        
  function( L, l )
    
    Error( "not implemented yet\n" );
    
end );

##
InstallOtherMethod( Append,
        [ IsLazyArray, IsLazyArray ],
        
  function( L1, L2 )
    local l1, func1, func2, i;
    
    l1 := L1!.length;
    
    func1 := ShallowCopy( L1!.func );
    func2 := ShallowCopy( L2!.func );
    
    L1!.length := l1 + L2!.length;
    
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
InstallMethod( SSortedList,
        [ IsLazyArray ],
        
  function( L )
    
    return SSortedList( ListOfValues( L ) );
    
end );

##
InstallMethod( ViewObj,
        [ IsLazyArray ],
        
  function( L )
    
    Print( "LazyArray of length ", L!.length, " and evaluated values: " );
    ViewObj( L!.values );
    
end );

##
InstallMethod( PrintObj,
        [ IsLazyArray ],
        
  function( L )
    local values;
    
    values := L!.values;
    
    PrintObj( values );
    
    if not L!.length = Length( values ) then
        Print( ".?."  );
    fi;
    
end );

##
InstallMethod( PrintObj,
        [ IsLazyInterval ],
        
  function( L )
    
    if Length( L ) < 3 then
        PrintObj( ListOfValues( L ) );
    else
        Print( "[ ", L[0], " .. ", L[Length( L ) - 1 ], " ]" );
    fi;
    
end );

##
InstallMethod( PrintObj,
        [ IsLazyConstantArray ],
        
  function( L )
    
    if Length( L ) < 3 then
        PrintObj( ListOfValues( L ) );
    else
        Print( "[ .. ", L[0], " .. ]"  );
    fi;
    
end );
