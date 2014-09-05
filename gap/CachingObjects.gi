#############################################################################
##
##                                               ToolsForHomalg package
##
##  Copyright 2013 - 2014, Sebastian Gutsche, TU Kaiserslautern
##                         Sebastian Posur,   RWTH Aachen
##
##
#############################################################################

DeclareRepresentation( "IsCachingObjectRep",
                       IsAttributeStoringRep and IsCachingObject,
                       [ ] );

DeclareRepresentation( "IsWeakCachingObjectRep",
                       IsCachingObjectRep,
                       [ ] );

DeclareRepresentation( "IsCrispCachingObjectRep",
                       IsCachingObjectRep,
                       [ ] );

DeclareRepresentation( "IsMixedCachingObjectRep",
                       IsCachingObjectRep,
                       [ ] );

DeclareRepresentation( "IsCachingObjectWhichConvertsLists",
                       IsCachingObjectRep,
                       [ ] );

BindGlobal( "TheFamilyOfCachingObjects",
            NewFamily( "TheFamilyOfCachingObjects" ) );

BindGlobal( "TheTypeOfWeakCachingObject",
        NewType( TheFamilyOfCachingObjects,
                 IsWeakCachingObjectRep ) );

BindGlobal( "TheTypeOfCrispCachingObject",
        NewType( TheFamilyOfCachingObjects,
                 IsCrispCachingObjectRep ) );

##
InstallGlobalFunction( CATEGORIES_FOR_HOMALG_SET_ALL_CACHES_CRISP,
                       
  function( )
    
    InstallMethod( CachingObject,
                   [ IsBool, IsInt ],
                   
      function( is_crisp, nr_keys )
        
        return CreateCrispCachingObject( nr_keys );
        
    end );
    
end );

##
InstallGlobalFunction( CACHINGOBJECT_HIT,
                       
  function( cache )
    
    cache!.hit_counter := cache!.hit_counter + 1;
    
end );

##
InstallGlobalFunction( CACHINGOBJECT_MISS,
                       
  function( cache )
    
    cache!.miss_counter := cache!.miss_counter + 1;
    
    if cache!.miss_counter mod 10 = 0 then
        
        TOOLS_FOR_HOMALG_CACHE_CLEAN_UP( cache );
        
    fi;
    
end );

InstallGlobalFunction( COMPARE_LISTS_WITH_IDENTICAL,
                       
  function( list1, list2 )
    local i;
    
    if not IsList( list1 ) and not IsList( list2 ) then
        
        return IsIdenticalObj( list1, list2 );
        
    elif not IsList( list1 ) or not IsList( list2 ) then
        
        return false;
        
    fi;
    
    if Length( list1 ) <> Length( list2 ) then
        
        return false;
        
    fi;
    
    if IsString( list1 ) and IsString( list2 ) then
        
        return list1 = list2;
        
    fi;
    
    for i in [ 1 .. Length( list1 ) ] do
        
        if not IsBoundElmWPObj( list1, i ) or not IsBoundElmWPObj( list2, i ) then
            
            return false;
            
        elif not COMPARE_LISTS_WITH_IDENTICAL( ElmWPObj( list1, i ), ElmWPObj( list2, i ) ) then
            
            return false;
            
        fi;
        
    od;
    
    return true;
    
end );

##
InstallGlobalFunction( SEARCH_WPLIST_FOR_OBJECT,
                       
  function( wp_list, object )
    local pos;
    
    for pos in [ 1 .. LengthWPObj( wp_list ) ] do
        
        if IsBoundElmWPObj( wp_list, pos ) then
            
            if IsEqualForCache( object, wp_list[ pos ] ) then
                
                return pos;
                
            fi;
            
        fi;
        
    od;
    
    return fail;
    
end );

InstallGlobalFunction( "TOOLS_FOR_HOMALG_CACHE_CLEAN_UP",
                       
  function( cache )
    local positions, nr_keys, position_lengths, i, current_position_length, current_cache, current_position, j,
          keys_value_list, keys_to_delete, keys_to_delete_length, value_list, new_value, new_keys, new_key_numbers,
          original_lengths, key_reduce_list, k, runtime;
    
#     Print( Runtime() );
    
    positions := List( cache!.keys, i -> Filtered( [ 1 .. Length( i ) ], j -> not IsBoundElmWPObj( i, j ) ) );
    
    nr_keys := cache!.nr_keys;
    
    original_lengths := List( cache!.keys, Length );
    
    for i in [ 1 .. cache!.nr_keys ] do
        
        current_position := positions[ i ];
        
        current_position_length := Length( current_position );
        
        current_cache := cache!.keys[ i ];
        
        for j in [ 0 .. current_position_length - 1 ] do
            
            Remove( current_cache, current_position[ current_position_length - j ] );
            
        od;
        
    od;
    
    position_lengths := List( positions, Length );
    
    keys_to_delete := [ ];
    
    keys_value_list := cache!.keys_value_list;
    
    for i in [ 1 .. Length( keys_value_list ) ] do
        
        if ForAny( [ 1 .. nr_keys ], j -> keys_value_list[ i ][ j ] in positions[ j ] ) or ForAny( [ 1 .. nr_keys ], j -> keys_value_list[ i ][ j ] > original_lengths[ j ] ) then
            
            Add( keys_to_delete, i );
            
        fi;
        
    od;
    
    if keys_to_delete <> [ ] then
        
#         Print( "cleanup\n" );
#         
#         Print( String( keys_to_delete ) );
#         
#         Print( "\n" );
        
        new_keys := [ ];
        
        new_value := [ ];
        
        new_key_numbers := Difference( [ 1 .. Length( keys_value_list ) ], keys_to_delete );
        
        value_list := cache!.value;
        
        for i in [ 1 .. Length( new_key_numbers ) ] do
            
            new_keys[ i ] := keys_value_list[ new_key_numbers[ i ] ];
            
            if IsBound( value_list[ new_key_numbers[ i ] ] ) then
                
                new_value[ i ] := value_list[ new_key_numbers[ i ] ];
                
            fi;
            
        od;
        
        if IsWeakPointerObject( cache!.value ) then
            
            new_value := WeakPointerObj( new_value );
            
        fi;
        
        cache!.keys_value_list := new_keys;
        
        cache!.value := new_value;
        
        cache!.value_list_position := Length( new_key_numbers ) + 1;
        
        ## Sanitize keys
        key_reduce_list := List( [ 1 .. nr_keys ], i -> ListWithIdenticalEntries( original_lengths[ i ], 0 ) );
        
        for i in [ 1 .. nr_keys ] do
            
            for j in [ 1 .. Length( positions[ i ] ) ] do
                
                for k in [ positions[ i ][ j ] .. original_lengths[ i ] ] do
                    
                    key_reduce_list[ i ][ k ] := key_reduce_list[ i ][ k ] + 1;
                    
                od;
                
            od;
            
        od;
        
        for i in [ 1 .. Length( new_keys ) ] do
            
            for j in [ 1 .. nr_keys ] do
                
                new_keys[ i ][ j ] := new_keys[ i ][ j ] - key_reduce_list[ j ][ new_keys[ i ][ j ] ];
                
            od;
            
        od;
        
    fi;
    
#     Print( "time: " );
#     
#     Print( String( Runtime() ) );
#     
#     Print( "\n" );
    
end );

InstallGlobalFunction( CATEGORIES_FOR_HOMALG_PREPARE_CACHING_RECORD,
                       
  function( nr_keys )
    local cache, i;
    
    cache := rec( keys := [ ],
                crisp_keys := [ ],
                nr_keys := nr_keys,
                keys_value_list := [ ],
                value_list_position := 1,
                crisp_key_position := 1,
                hit_counter := 0,
                miss_counter := 0 );
    
    cache.keys := List( [ 1 .. nr_keys ], i -> WeakPointerObj( [ ] ) );
    
    ## This is a memory leak, use it with caution
    cache.crisp_keys := [ ];
    
    return cache;
    
end );

InstallGlobalFunction( CreateWeakCachingObject,
                       
  function( nr_keys )
    local cache, i;
    
    cache := CATEGORIES_FOR_HOMALG_PREPARE_CACHING_RECORD( nr_keys );
    
    cache.value := WeakPointerObj( [ ] );
    
    ObjectifyWithAttributes( cache, TheTypeOfWeakCachingObject );
    
    return cache;
    
end );

InstallGlobalFunction( CreateCrispCachingObject,
                       
  function( nr_keys )
    local cache;
    
    cache := CATEGORIES_FOR_HOMALG_PREPARE_CACHING_RECORD( nr_keys );
    
    cache.value := [ ];
    
    ObjectifyWithAttributes( cache, TheTypeOfCrispCachingObject );
    
    return cache;
    
end );

InstallMethod( CachingObject,
               [ ],
               
  function( )
    
    return CreateWeakCachingObject( 1 );
    
end );

InstallMethod( CachingObject,
               [ IsBool ],
               
  function( is_crisp )
    
    return CachingObject( is_crisp, 1 );
    
end );

InstallMethod( CachingObject,
               [ IsBool, IsInt ],
               
  function( is_crisp, nr_keys )
    
    if is_crisp = true then
        
        return CreateCrispCachingObject( nr_keys );
        
    fi;
    
    return CreateWeakCachingObject( nr_keys );
    
end );

InstallMethod( CachingObject,
               [ IsInt, IsBool ],
               
  function( nr_keys, is_crisp )
    
    return CachingObject( is_crisp, nr_keys );
    
end );

InstallMethod( CachingObject,
               [ IsInt ],
               
  function( nr_keys )
    
    return CachingObject( false, nr_keys );
    
end );

InstallMethod( Add,
               [ IsWeakCachingObjectRep, IsInt, IsObject ],
               
  function( cache, pos, object )
    
    SetElmWPObj( cache!.value, pos, object );
    
end );

InstallMethod( Add,
               [ IsCrispCachingObjectRep, IsInt, IsObject ],
               
  function( cache, pos, object )
    
    cache!.value[ pos ] := object;
    
end );

InstallMethod( GetObject,
               [ IsWeakCachingObjectRep, IsInt, IsInt ],
               
  function( cache, pos, key_pos )
    local list;
    
    list := cache!.value;
    
    if IsBoundElmWPObj( list, pos ) then
        
        CACHINGOBJECT_HIT( cache );
        
        return ElmWPObj( list, pos );
        
    fi;
    
    Remove( cache!.keys_value_list, key_pos );
    
    Remove( cache!.value, pos );
    
    cache!.value_list_position := cache!.value_list_position - 1;
    
    CACHINGOBJECT_MISS( cache );
    
    return SuPeRfail;
    
end );

InstallMethod( GetObject,
               [ IsCrispCachingObjectRep, IsInt, IsInt ],
               
  function( cache, pos, key_pos )
    local list;
    
    list := cache!.value;
    
    if IsBound( list[ pos ] ) then
        
        CACHINGOBJECT_HIT( cache );
        
        return list[ pos ];
        
    fi;
    
    Remove( cache!.keys_value_list, key_pos );
    
    Remove( cache!.value, pos );
    
    cache!.value_list_position := cache!.value_list_position - 1;
    
    CACHINGOBJECT_MISS( cache );
    
    return SuPeRfail;
    
end );

InstallMethod( SetCacheValue,
               [ IsCachingObject, IsObject, IsObject ],
               
  function( cache, key, value )
    
    SetCacheValue( cache, [ key ], value );
    
end );

InstallMethod( SetCacheValue,
               [ IsCachingObject, IsList, IsObject ],
               
  function( cache, key_list, value )
    local keys, length_key_list, i, position, entry_position, entry_key, wp_list, crisp_keys,
          input_temp;
    
    length_key_list := Length( key_list );
    
    if cache!.nr_keys <> length_key_list then
        
        Error( "cache supports only keys of length ", String( cache!.nr_keys ) );
        
    fi;
    
    keys := cache!.keys;
    
    entry_key := [ ];
    
    crisp_keys := cache!.crisp_keys;
    
    for i in [ 1 .. length_key_list ] do
        
        position := SEARCH_WPLIST_FOR_OBJECT( keys[ i ], key_list[ i ] );
        
        if position = fail then
            
            ##Inject here.
            position := LengthWPObj( keys[ i ] ) + 1;
            
            if IsList( key_list[ i ] ) then
                
                if IsString( key_list[ i ] ) then
                    
                    input_temp := key_list[ i ];
                    
                else
                    
                    input_temp := WeakPointerObj( key_list[ i ] );
                    
                fi;
                
                Add( crisp_keys, input_temp );
                
                SetElmWPObj( keys[ i ], position, input_temp );
                
            else
                
                SetElmWPObj( keys[ i ], position, key_list[ i ] );
                
            fi;
            
        fi;
        
        entry_key[ i ] := position;
        
    od;
    
    entry_position := cache!.value_list_position;
    
    cache!.keys_value_list[ entry_position ] := entry_key;
    
    Add( cache, entry_position, value );
    
    cache!.value_list_position := entry_position + 1;
    
end );

InstallMethod( CacheValue,
               [ IsCachingObject, IsObject ],
               
  function( cache, key )
    
    return CacheValue( cache, [ key ] );
    
end );

##
InstallMethod( CacheValue,
               [ IsCachingObject, IsList ],
               
  function( cache, key_list )
    local length_key_list, keys, position, i, entry_key, crisp_keys;
    
    length_key_list := Length( key_list );
    
    if cache!.nr_keys <> length_key_list then
        
        Error( "cache supports only keys of length ", String( cache!.nr_keys ) );
        
    fi;
    
    keys := cache!.keys;
    
    crisp_keys := cache!.crisp_keys;
    
    entry_key := [ ];
    
    for i in [ 1 .. length_key_list ] do
        
        position := SEARCH_WPLIST_FOR_OBJECT( keys[ i ], key_list[ i ] );
        
        if position = fail then
            
            CACHINGOBJECT_MISS( cache );
            
            return SuPeRfail;
            
        fi;
        
        entry_key[ i ] := position;
        
    od;
    
    position := Position( cache!.keys_value_list, entry_key );
    
    if position = fail then
        
        CACHINGOBJECT_MISS( cache );
        
        return SuPeRfail;
        
    fi;
    
    return GetObject( cache, position, position );
    
end );

##
InstallGlobalFunction( InstallMethodWithCrispCache,
                       
  function( arg )
    
    PushOptions( rec( CrispCache := true ) );
    
    CallFuncList( InstallMethodWithCache, arg );
    
end );

## InstallMethod( opr[, info][, famp], args-filts[, val], method )
##
InstallGlobalFunction( InstallMethodWithCache,
                       
  function( arg )
    local new_func, i, filt_list, crisp, arg_nr, cache, func, install_func, install_has_func, install_set_func,
          cache_string;
    
    cache := ValueOption( "Cache" );
    
    ##find filter list
    for i in [ 2 .. 4 ] do
        
        if not IsString( arg[ i ] ) and not IsFunction( arg[ i ] ) then
            
            filt_list := arg[ i ];
            
            break;
            
        fi;
        
    od;
    
    if not IsBound( filt_list ) then
        
        Error( "something went wrong. This should not happen" );
        
    fi;
    
    crisp := ValueOption( "CrispCache" );
    
    if crisp = fail then
        
        crisp := false;
        
    fi;
    
    arg_nr := Length( filt_list );
    
    if cache = fail then
        
        cache := CachingObject( crisp, arg_nr );
        
    fi;
    
    func := arg[ Length( arg ) ];
    
    if cache <> false then
        
        new_func := function( arg )
          local value;
            
            value := CacheValue( cache, arg );
            
            if value <> SuPeRfail then
                
                return value;
                
            fi;
            
            value := CallFuncList( func, arg );
            
            SetCacheValue( cache, arg, value );
            
            return value;
            
        end;
        
        if TOOLS_FOR_HOMALG_SAVED_CACHES_FROM_INSTALL_METHOD_WITH_CACHE.STORE_CACHES = true then
            
            cache_string := NameFunction( arg[ 1 ] );
            
            if IsString( arg[ 2 ] ) then
                
                Append( cache_string, Concatenation( "_", ReplacedString( arg[ 2 ], "_" ) ) );
                
            fi;
            
            Append( cache_string, Concatenation( "_for_", JoinStringsWithSeparator( List( filt_list, NameFunction ), "_" ) ) );
            
            TOOLS_FOR_HOMALG_SAVED_CACHES_FROM_INSTALL_METHOD_WITH_CACHE.(cache_string) := cache;
            
        fi;
        
    else
        
        new_func := func;
        
    fi;
    
    arg[ Length( arg ) ] := new_func;
    
    install_func := ValueOption( "InstallMethod" );
    
    if install_func = fail then
        
        install_func := InstallMethod;
        
    fi;
    
    CallFuncList( install_func, arg );
    
    install_has_func := ValueOption( "InstallHas" );
    
    if install_has_func = fail then
        
        install_has_func := InstallHas;
        
    fi;
    
    install_has_func( cache, NameFunction( arg[ 1 ] ), filt_list );
    
    install_set_func := ValueOption( "InstallSet" );
    
    if install_set_func = fail then
        
        install_set_func := InstallSet;
        
    fi;
    
    install_set_func( cache, NameFunction( arg[ 1 ] ), filt_list );
    
end );

##
InstallGlobalFunction( InstallMethodWithCacheFromObject,
                       
  function( arg )
    local new_func, func, i, filt_list, cache_object, install_name, install_func, install_has_func, install_set_func;
    
    install_name := NameFunction( arg[ 1 ] );
    
    cache_object := ValueOption( "ArgumentNumber" );
    
    if cache_object = fail then
        
        cache_object := 1;
        
    fi;
    
    func := arg[ Length( arg ) ];
    
    for i in [ 2 .. 4 ] do
        
        if not IsString( arg[ i ] ) and not IsFunction( arg[ i ] ) then
            
            filt_list := arg[ i ];
            
            break;
            
        fi;
        
    od;
    
    install_name := NameFunction( arg[ 1 ] );
    
    if cache_object <> false then
        
        new_func := function( arg )
          local value, cache;
            
            cache := CachingObject( arg[ cache_object ], install_name, Length( arg ) );
            
            value := CacheValue( cache, arg );
            
            if value <> SuPeRfail then
                
                return value;
                
            fi;
            
            value := CallFuncList( func, arg );
            
            SetCacheValue( cache, arg, value );
            
            return value;
            
        end;
        
    else
        
        new_func := func;
        
    fi;
    
    install_has_func := ValueOption( "InstallHas" );
    
    if install_has_func = fail then
        
        install_has_func := InstallHas;
        
    fi;
    
    install_has_func( cache_object, install_name, filt_list );
    
    install_set_func := ValueOption( "InstallSet" );
    
    if install_set_func = fail then
        
        install_set_func := InstallSet;
        
    fi;
    
    install_set_func( cache_object, install_name, filt_list );
    
    arg[ Length( arg ) ] := new_func;
    
    install_func := ValueOption( "InstallMethod" );
    
    if install_func = fail then
        
        install_func := InstallMethod;
        
    fi;
    
    CallFuncList( InstallMethod, arg );
    
end );

##
InstallMethod( InstallHas,
               [ IsCachingObject, IsString, IsList ],
               
  function( cache, name, filter )
    local has_name;
    
    has_name := Concatenation( "Has", name );
    
    if not IsBoundGlobal( has_name ) then
        
        DeclareOperation( has_name,
                          filter );
        
    fi;
    
    InstallOtherMethod( ValueGlobal( has_name ),
                        filter,
                        
      function( arg )
        local cache_return;
        
        cache_return := CacheValue( cache, arg );
        
        return cache_return <> SuPeRfail;
        
    end );
    
end );

##
InstallMethod( InstallSet,
               [ IsCachingObject, IsString, IsList ],
               
  function( cache, name, filter )
    local set_name, install_func;
    
    set_name := Concatenation( "Set", name );
    
    if not IsBoundGlobal( set_name ) then
        
        DeclareOperation( set_name,
                          Concatenation( filter, [ IsObject ] ) );
        
    fi;
    
    install_func := ValueOption( "InstallMethod" );
    
    if install_func = fail then
        
        install_func := InstallOtherMethod;
        
    fi;
    
    install_func( ValueGlobal( set_name ),
                  Concatenation( filter, [ IsObject ] ),
                        
      function( arg )
        local cache_return, cache_call;
        
        cache_call := arg{[ 1 .. Length( filter ) - 1 ]};
        
        cache_return := CacheValue( cache, cache_call );
        
        if cache_return = SuPeRfail then
            
            CallFuncList( SetCacheValue, [ cache, cache_call, arg[ Length( arg ) ] ] );
            
        fi;
        
    end : InstallMethod := InstallOtherMethod );
    
end );

##
InstallMethod( InstallHas,
               [ IsInt, IsString, IsList ],
               
  function( cache_number, name, filter )
    local has_name;
    
    has_name := Concatenation( "Has", name );
    
    if not IsBoundGlobal( has_name ) then
        
        DeclareOperation( has_name,
                          filter );
        
    fi;
    
    InstallOtherMethod( ValueGlobal( has_name ),
                        filter,
                        
      function( arg )
        local cache, cache_return;
        
        cache := CachingObject( arg[ cache_number ], name, Length( filter ) );
        
        cache_return := CacheValue( cache, arg );
        
        return cache_return <> SuPeRfail;
        
    end );
    
end );

##
InstallMethod( InstallSet,
               [ IsInt, IsString, IsList ],
               
  function( cache_number, name, filter )
    local set_name, install_func;
    
    set_name := Concatenation( "Set", name );
    
    if not IsBoundGlobal( set_name ) then
        
        DeclareOperation( set_name,
                          Concatenation( filter, [ IsObject ] ) );
        
    fi;
    
    install_func := ValueOption( "InstallMethod" );
    
    if install_func = fail then
        
        install_func := InstallOtherMethod;
        
    fi;
    
    install_func( ValueGlobal( set_name ),
                  Concatenation( filter, [ IsObject ] ),
                        
      function( arg )
        local cache, cache_key, cache_return;
        
        cache := CachingObject( arg[ cache_number ], name, Length( arg ) - 1 );
        
        cache_key := arg{[ 1 .. Length( arg ) - 1 ]};
        
        cache_return := CacheValue( cache, cache_key );
        
        if cache_return = SuPeRfail then
            
            CallFuncList( SetCacheValue, [ cache, cache_key, arg[ Length( arg ) ] ] );
            
        fi;
        
    end : InstallMethod := InstallOtherMethod );
    
end );

##
InstallMethod( InstallHas,
               [ IsBool, IsString, IsList ],
               
  function( cache, name, filter )
    local has_name;
    
    has_name := Concatenation( "Has", name );
    
    if not IsBoundGlobal( has_name ) then
        
        DeclareOperation( has_name,
                          filter );
        
    fi;
    
    InstallOtherMethod( ValueGlobal( has_name ),
                        filter,
                        
      ReturnFalse );
    
end );

##
InstallMethod( InstallSet,
               [ IsBool, IsString, IsList ],
               
  function( cache, name, filter )
    local has_name, set_name;
    
    set_name := Concatenation( "Set", name );
    
    if not IsBoundGlobal( set_name ) then
        
        DeclareOperation( set_name,
                          Concatenation( filter, [ IsObject ] ) );
        
    fi;
    
    InstallOtherMethod( ValueGlobal( set_name ),
                        Concatenation( filter, [ IsObject ] ),
                        
      function( arg )
        
        return;
        
    end );
    
end );

##
InstallMethod( DeclareHasAndSet,
               [ IsString, IsList ],
               
  function( name, filter )
    local has_name, set_name;
    
    has_name := Concatenation( "Has", name );
    
    set_name := Concatenation( "Set", name );
    
    DeclareOperation( has_name, filter );
    
    Add( filter, IsObject );
    
    DeclareOperation( set_name, filter );
    
end );

##
InstallMethod( DeclareOperationWithCache,
               [ IsString, IsList ],
               
  function( name, filter )
    local has_name, set_name;
    
    DeclareOperation( name, filter );
    
    DeclareHasAndSet( name, filter );
    
end );

##
InstallMethod( IsEqualForCache,
               [ IsObject, IsObject ],
               
  IsIdenticalObj );



##
InstallMethod( IsEqualForCache,
               [ IsList, IsList ],
               
  function( list1, list2 )
    local length;
    
    length := Length( list1 );
    
    if Length( list2 ) <> length then
        
        return false;
        
    fi;
    
    return ForAll( [ 1 .. length ], i -> IsEqualForCache( list1[ i ], list2[ i ] ) );
    
end );

##
InstallMethod( IsEqualForCache,
               [ IsString, IsString ],
               
  \= );

##
BindGlobal( "TOOLS_FOR_HOMALG_CACHE_INSTALL_VIEW",
            
  function( )
    local func, filter, graph;
    
    func := function( obj )
        local string;
        
        string := "";
        
        if IsWeakCachingObjectRep( obj ) then
            
            Append( string, "weak " );
            
        elif IsCrispCachingObjectRep( obj ) then
            
            Append( string, "crisp " );
            
        fi;
        
        Append( string, "cache with " );
        
        Append( string, String( obj!.hit_counter ) );
        
        Append( string, " hits and " );
        
        Append( string, String( obj!.miss_counter ) );
        
        Append( string, " misses" );
        
        return string;
        
    end;
    
    filter := IsCachingObject;
    
    graph := CreatePrintingGraph( filter, func );
    
    InstallPrintFunctionsOutOfPrintingGraph( graph );
    
end );

#####################################
##
## Debug
##
#####################################

InstallValue( TOOLS_FOR_HOMALG_SAVED_CACHES_FROM_INSTALL_METHOD_WITH_CACHE,
              rec( STORE_CACHES := false ) );

InstallGlobalFunction( TOOLS_FOR_HOMALG_STORE_CACHES,
                       
  function( switch )
    
    if not switch = true and not switch = false then
        
        Error( "argument must be either true or false" );
        
    fi;
    
    TOOLS_FOR_HOMALG_SAVED_CACHES_FROM_INSTALL_METHOD_WITH_CACHE.STORE_CACHES := switch;
    
end );

