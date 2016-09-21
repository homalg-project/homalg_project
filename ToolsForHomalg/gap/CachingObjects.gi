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

BindGlobal( "TheTypeOfCachingObjects",
        NewType( TheFamilyOfCachingObjects,
                 IsCachingObjectRep ) );

DeclareFilter( "IsWeakCache" );
DeclareFilter( "IsCrispCache" );
DeclareFilter( "IsDisabledCache" );

BindGlobal( "TOOLS_FOR_HOMALG_WEAK_POINTER_TERMINATOR",
            "TOOLS_FOR_HOMALG_WEAK_POINTER_TERMINATOR" );

## FIXME: Make this more efficient
BindGlobal( "RemoveWPObj",
            
  function( weak_pointer, pos )
    local i, length;
    
    length := LengthWPObj( weak_pointer );
    
    for i in [ pos + 1 .. length ] do
        
        if IsBoundElmWPObj( weak_pointer, i ) then
            
            SetElmWPObj( weak_pointer, i - 1, ElmWPObj( weak_pointer, i ) );
            
        else
            
            UnbindElmWPObj( weak_pointer, i - 1 );
            
        fi;
        
    od;
    
    UnbindElmWPObj( weak_pointer, length );
    
end );

## FIXME: REMOVE?
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

##
InstallGlobalFunction( SEARCH_WPLIST_FOR_OBJECT,
                       
  function( wp_list, object, search_positions )
    local pos, obj, length_pos;
    
    length_pos := Length( search_positions );
    
    for pos in [ 0 .. length_pos - 1 ] do
        
        pos := search_positions[ length_pos - pos ];
        
        if IsBoundElmWPObj( wp_list, pos ) then
            
            obj := ElmWPObj( wp_list, pos );
            
            if IsIdenticalObj( object, obj ) or IsEqualForCache( object, ElmWPObj( wp_list, pos ) ) then
                
                return pos;
                
            fi;
            
        fi;
        
    od;
    
    return fail;
    
end );

InstallGlobalFunction( "TOOLS_FOR_HOMALG_CACHE_CLEAN_UP",
  
  function( cache )
    local nr_keys, deleted, i, current_list, current_deleted, cache_key_value, value_delete, j, cache_value;
    
    nr_keys := cache!.nr_keys;
    
    deleted := List( [ 1 .. nr_keys ], i -> [ ] );
    
    for i in [ 1 .. nr_keys ] do
        
        current_deleted := deleted[ i ];
        
        current_list := cache!.keys[ i ];
        
        for j in cache!.keys_search_positions[ i ] do
            
            if not IsBoundElmWPObj( current_list, j ) or ( IsWPObj( ElmWPObj( current_list, j ) ) and LengthWPObj( ElmWPObj( current_list, j ) ) = 0 ) then
                
                Add( current_deleted, j );
                
            fi;
            
        od;
        
        deleted[ i ] := AsSet( current_deleted );
        
        cache!.keys_search_positions[ i ] := Difference( AsSet( cache!.keys_search_positions[ i ] ), deleted[ i ] );
        
    od;
    
    cache_key_value := cache!.keys_value_list;
    
    value_delete := [ ];
    
    for i in cache!.keys_value_search_list do
        
        if ForAny( [ 1 .. nr_keys ], j -> cache_key_value[ i ][ j ] in deleted[ j ] ) then
            
            Add( value_delete, i );
            
        fi;
        
    od;
    
    cache!.keys_value_search_list := Difference( AsSet( cache!.keys_value_search_list ), AsSet( value_delete ) );
    
    cache_value := cache!.value;
    
    value_delete := [ ];
    
    for i in cache!.keys_value_search_list do
        
        if not IsBoundElmWPObj( cache_value, i ) then
            
            Add( value_delete, i );
            
        fi;
        
    od;
    
    cache!.keys_value_search_list := Difference( cache!.keys_value_search_list, AsSet( value_delete ) );
    
end );

InstallGlobalFunction( CATEGORIES_FOR_HOMALG_PREPARE_CACHING_RECORD,
                       
  function( nr_keys )
    local cache, i;
    
    cache := rec( keys := [ ],
                  keys_positions := [ ],
                crisp_keys := [ ],
                nr_keys := nr_keys,
                keys_value_list := [ ],
                keys_value_search_list := [ ],
                value_list_position := 1,
                crisp_key_position := 1,
                hit_counter := 0,
                miss_counter := 0 );
    
    cache.keys := List( [ 1 .. nr_keys ], i -> WeakPointerObj( [ ] ) );
    
    cache.keys_search_positions := List( [ 1 .. nr_keys ], i -> [ ] );
    
    cache!.keys_positions := List( [ 1 .. nr_keys ], i -> 1 );
    
    ## This is a memory leak, use it with caution
    cache.crisp_keys := [ ];
    
    return cache;
    
end );

InstallGlobalFunction( CreateWeakCachingObject,
                       
  function( nr_keys )
    local cache, i;
    
    cache := CATEGORIES_FOR_HOMALG_PREPARE_CACHING_RECORD( nr_keys );
    
    cache.value := WeakPointerObj( [ ] );
    
    ObjectifyWithAttributes( cache, TheTypeOfCachingObjects );
    
    SetFilterObj( cache, IsWeakCache );
    
    return cache;
    
end );

InstallGlobalFunction( CreateCrispCachingObject,
                       
  function( nr_keys )
    local cache;
    
    cache := CATEGORIES_FOR_HOMALG_PREPARE_CACHING_RECORD( nr_keys );
    
    cache.value := [ ];
    
    ObjectifyWithAttributes( cache, TheTypeOfCachingObjects );
    
    SetFilterObj( cache, IsCrispCache);
    
    return cache;
    
end );

InstallGlobalFunction( TOOLS_FOR_HOMALG_SET_CACHE_PROPERTY,
  
  function( cache, type )
    local new_value_list, i;
    
    type := LowercaseString( type );
    
    if type = "disable" then
        
        SetFilterObj( cache, IsDisabledCache );
        ResetFilterObj( cache, IsCrispCache );
        ResetFilterObj( cache, IsWeakCache );
        
    elif type = "weak" then
        
        SetFilterObj( cache, IsWeakCache );
        ResetFilterObj( cache, IsCrispCache );
        ResetFilterObj( cache, IsDisabledCache );
        
        if not IsWeakPointerObject( cache!.value ) then
            new_value_list := WeakPointerObj( cache!.value );
            cache!.value := new_value_list;
        fi;
        
    elif type = "crisp" then
        
        SetFilterObj( cache, IsCrispCache );
        ResetFilterObj( cache, IsWeakCache );
        ResetFilterObj( cache, IsDisabledCache );
        
        if IsWeakPointerObject( cache!.value ) then
            
            new_value_list := [ ];
            
            for i in [ 1 .. LengthWPObj( cache!.value ) ] do
                
                if IsBoundElmWPObj( cache!.value, i ) then
                    new_value_list[ i ] := ElmWPObj( cache!.value, i );
                fi;
                
            od;
            
            cache!.value := new_value_list;
            
        fi;
        
    else
        
        Error( "Unrecognized conversion for weak pointers" );
        
    fi;
    
end );

InstallGlobalFunction( SetCachingObjectCrisp,
  
  function( cache )
    
    TOOLS_FOR_HOMALG_SET_CACHE_PROPERTY( cache, "crisp" );
    
end );

InstallGlobalFunction( SetCachingObjectWeak,
  
  function( cache )
    
    TOOLS_FOR_HOMALG_SET_CACHE_PROPERTY( cache, "weak" );
    
end );

InstallGlobalFunction( DeactivateCachingObject,
  
  function( cache )
    
    TOOLS_FOR_HOMALG_SET_CACHE_PROPERTY( cache, "disable" );
    
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
               [ IsCachingObject and IsWeakCache, IsInt, IsObject ],
               
  function( cache, pos, object )
    
    SetElmWPObj( cache!.value, pos, object );
    
end );

InstallMethod( Add,
               [ IsCachingObject and IsCrispCache, IsInt, IsObject ],
               
  function( cache, pos, object )
    
    cache!.value[ pos ] := object;
    
end );

InstallMethod( Add,
               [ IsCachingObject and IsDisabledCache, IsInt, IsObject ],
               
  ReturnTrue );

InstallMethod( GetObject,
               [ IsCachingObject and IsWeakCache, IsInt, IsInt ],
               
  function( cache, pos, key_pos )
    local list, ret_val;
    
    list := cache!.value;
    
    ret_val := ElmWPObj( list, pos );
    
    if IsBoundElmWPObj( list, pos ) then
        
        CACHINGOBJECT_HIT( cache );
        
        return [ ret_val ];
        
    fi;
    
    cache!.value_list_position := cache!.value_list_position - 1;
    
    CACHINGOBJECT_MISS( cache );
    
    return [ ];
    
end );

InstallMethod( GetObject,
               [ IsCachingObject and IsCrispCache, IsInt, IsInt ],
               
  function( cache, pos, key_pos )
    local list;
    
    list := cache!.value;
    
    if IsBound( list[ pos ] ) then
        
        CACHINGOBJECT_HIT( cache );
        
        return [ list[ pos ] ];
        
    fi;
    
#     Remove( cache!.keys_value_list, key_pos );
#     
#     Remove( cache!.value, pos );
    
    cache!.value_list_position := cache!.value_list_position - 1;
    
    CACHINGOBJECT_MISS( cache );
    
    return [ ];
    
end );

InstallMethod( GetObject,
               [ IsCachingObject and IsDisabledCache, IsInt, IsInt ],
               
  function( cache, pos, key_pos )
    
    CACHINGOBJECT_MISS( cache );
    
    return [ ];
    
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
        
        position := SEARCH_WPLIST_FOR_OBJECT( keys[ i ], key_list[ i ], cache!.keys_search_positions[ i ] );
        
        if position = fail then
            
            ##Inject here.
            
            position := cache!.keys_positions[ i ];
            
            Add( cache!.keys_search_positions[ i ], position );
            
            cache!.keys_positions[ i ] := cache!.keys_positions[ i ] + 1;
            
            if IsList( key_list[ i ] ) then
                
                if IsString( key_list[ i ] ) then
                    
                    input_temp := key_list[ i ];
                    
                else
                    
                    input_temp := WeakPointerObj( Concatenation( key_list[ i ], [ TOOLS_FOR_HOMALG_WEAK_POINTER_TERMINATOR ] ) );
                    
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
    
    Add( cache!.keys_value_search_list, entry_position );
    
    Add( cache, entry_position, value );
    
    cache!.value_list_position := entry_position + 1;
    
end );

InstallMethod( SetCacheValue,
               [ IsCachingObject and IsDisabledCache, IsList, IsObject ],
               
  ReturnTrue );


InstallMethod( CacheValue,
               [ IsCachingObject, IsObject ],
               
  function( cache, key )
    
    return CacheValue( cache, [ key ] );
    
end );

##
InstallMethod( CacheValue,
               [ IsCachingObject, IsList ],
               
  function( cache, key_list )
    local length_key_list, keys, position, i, entry_key, crisp_keys, keys_value_list;
    
    length_key_list := Length( key_list );
    
    if cache!.nr_keys <> length_key_list then
        
        Error( "cache supports only keys of length ", String( cache!.nr_keys ) );
        
    fi;
    
    keys := cache!.keys;
    
    crisp_keys := cache!.crisp_keys;
    
    entry_key := [ ];
    
    for i in [ 1 .. length_key_list ] do
        
        position := SEARCH_WPLIST_FOR_OBJECT( keys[ i ], key_list[ i ], cache!.keys_search_positions[ i ] );
        
        if position = fail then
            
            CACHINGOBJECT_MISS( cache );
            
            return [ ];
            
        fi;
        
        entry_key[ i ] := position;
        
    od;
    
    keys_value_list := cache!.keys_value_list;
    
    position := fail;
    
    for i in cache!.keys_value_search_list do
        
        if keys_value_list[ i ] = entry_key then
            
            position := i;
            break;
            
        fi;
        
    od;
    
    if position = fail then
        
        CACHINGOBJECT_MISS( cache );
        
        return [ ];
        
    fi;
    
    return GetObject( cache, position, position );
    
end );

InstallMethod( CacheValue,
               [ IsCachingObject and IsDisabledCache, IsList ],
               
  function( cache, key_list )
    
    return [ ];
    
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
    local new_func, i, filt_list, crisp, arg_nr, cache, func, install_func, install_has_func, install_set_func, install_has_and_set,
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
            
            if value <> [ ] then
                
                return value[ 1 ];
                
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
    
    install_has_and_set := ValueOption( "InstallHasAndSet" );
    
    if install_has_and_set <> true then
        install_has_and_set := false;
    fi;
    
    if install_has_and_set then
        
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
        
    fi;
    
end );

##
InstallGlobalFunction( InstallMethodWithCacheFromObject,
                       
  function( arg )
    local new_func, func, i, filt_list, cache_object, install_name, install_func, install_has_func, install_set_func, install_has_and_set;
    
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
            
            if value <> [ ] then
                
                return value[ 1 ];
                
            fi;
            
            value := CallFuncList( func, arg );
            
            SetCacheValue( cache, arg, value );
            
            return value;
            
        end;
        
    else
        
        new_func := func;
        
    fi;
    
    install_has_and_set := ValueOption( "InstallHasAndSet" );
    
    if install_has_and_set <> true then
        install_has_and_set := false;
    fi;
    
    if install_has_and_set then
        
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
        
    fi;
    
    arg[ Length( arg ) ] := new_func;
    
    install_func := ValueOption( "InstallMethod" );
    
    if install_func = fail then
        
        install_func := InstallMethod;
        
    fi;
    
    CallFuncList( InstallMethod, arg );
    
end );

##
InstallGlobalFunction( CacheFromObjectWrapper,
                       
  function( func, cache_name, cache_object )
    local new_func;
    
    new_func := function( arg )
      local value, cache;
        
        cache := CachingObject( arg[ cache_object ], cache_name, Length( arg ) );
        
        value := CacheValue( cache, arg );
        
        if value <> [ ] then
            
            return value[ 1 ];
            
        fi;
        
        value := CallFuncList( func, arg );
        
        SetCacheValue( cache, arg, value );
        
        return value;
        
    end;
    
    return new_func;
    
end );

##
InstallMethod( InstallHas,
               [ IsCachingObject, IsString, IsList ],
               
  function( cache, name, filter )
    local has_name;
    
    if not IsBoundGlobal( name ) then return; fi;
    
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
        
        return cache_return <> [ ];
        
    end );
    
end );

##
InstallMethod( InstallSet,
               [ IsCachingObject, IsString, IsList ],
               
  function( cache, name, filter )
    local set_name, install_func, is_attribute;
    
    if not IsBoundGlobal( name ) then return; fi;
    
    set_name := Concatenation( "Set", name );
    
    if not IsBoundGlobal( set_name ) then
        
        DeclareOperation( set_name,
                          Concatenation( filter, [ IsObject ] ) );
        
    fi;
    
    install_func := ValueOption( "InstallMethod" );
    
    if install_func = fail then
        
        install_func := InstallOtherMethod;
        
    fi;
    
    
    is_attribute := Tester( ValueGlobal( name ) ) <> false;
    
    install_func( ValueGlobal( set_name ),
                  Concatenation( filter, [ IsObject ] ),
                  
      function( arg )
        local cache_return, cache_call;
        
        cache_call := arg{[ 1 .. Length( arg ) - 1 ]};
        
        cache_return := CacheValue( cache, cache_call );
        
        if cache_return = [ ] then
            
            CallFuncList( SetCacheValue, [ cache, cache_call, arg[ Length( arg ) ] ] );
            
        fi;
        
    end : InstallMethod := InstallMethod );
    
end );

##
InstallMethod( InstallHas,
               [ IsInt, IsString, IsList ],
               
  function( cache_number, name, filter )
    local has_name;
    
    if not IsBoundGlobal( name ) then return; fi;
    
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
        
        return cache_return <> [ ];
        
    end );
    
end );

##
InstallMethod( InstallSet,
               [ IsInt, IsString, IsList ],
               
  function( cache_number, name, filter )
    local set_name, install_func;
    
    if not IsBoundGlobal( name ) then return; fi;
    
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
        
        if cache_return = [ ] then
            
            CallFuncList( SetCacheValue, [ cache, cache_key, arg[ Length( arg ) ] ] );
            
        fi;
        
    end : InstallMethod := InstallOtherMethod );
    
end );

##
InstallMethod( InstallHas,
               [ IsBool, IsString, IsList ],
               
  function( cache, name, filter )
    local has_name;
    
    if not IsBoundGlobal( name ) then return; fi;
    
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
    
    if not IsBoundGlobal( name ) then return; fi;
    
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
               [ IsWPObj, IsWPObj ],
               
  function( list1, list2 )
    local length;
    
    length := LengthWPObj( list1 );
    
    if LengthWPObj( list2 ) <> length then
        
        return false;
        
    fi;
    
    return ForAll( [ 1 .. length ], i -> IsBoundElmWPObj( list1, i ) and IsBoundElmWPObj( list2, i ) and IsEqualForCache( ElmWPObj( list1, i ), ElmWPObj( list2, i ) ) );
    
end );

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
               [ IsList, IsWeakPointerObject ],
               
  function( list, wp_obj )
    local length, i;
    
    length := Length( list );
    
    if LengthWPObj( wp_obj ) - 1 <> length then
        
        return false;
        
    fi;
    
    for i in [ 1 .. length ] do
        
        if not IsBoundElmWPObj( wp_obj, i ) or not IsEqualForCache( list[ i ], ElmWPObj( wp_obj, i ) ) then
            
            return false;
            
        fi;
        
    od;
    
    return true;
    
end );

##
InstallMethod( IsEqualForCache,
               [ IsWeakPointerObject, IsList ],
               
  function( wp_obj, list )
    return IsEqualForCache( list, wp_obj );
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

InstallGlobalFunction( FunctionWithCache,
  
  function( func )
    local new_func, nr_args, cache;
    
    nr_args := NumberArgumentsFunction( func );
    
    if nr_args = -1 then
        
        Error( "no caching possible, variable number of arguments" );
        
        return func;
        
    fi;
    
    cache := ValueOption( "Cache" );
    
    if IsString( cache ) and cache = "crisp" then
        
        cache := CachingObject( true, nr_args );
        
    elif not IsCachingObject( cache ) then
        
        cache := CachingObject( false, nr_args );
        
    fi;
    
    new_func := function( arg )
      local ret_val;
        
        ret_val := CacheValue( cache, arg );
        
        if ret_val = [ ] then
            
            ret_val := CallFuncList( func, arg );
            
            SetCacheValue( cache, arg, ret_val );
            
        else
            
            ret_val := ret_val[ 1 ];
            
        fi;
        
        return ret_val;
        
    end;
    
    return new_func;
    
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

