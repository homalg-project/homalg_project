#############################################################################
##
##                                               ToolsForHomalg package
##
##  Copyright 2013-2014, Sebastian Gutsche, TU Kaiserslautern
##                       Sebastian Posur,   RWTH Aachen
##
#! @Chapter Caches
##
#############################################################################

DeclareCategory( "IsCachingObject",
                 IsObject );

DeclareGlobalFunction( "CATEGORIES_FOR_HOMALG_SET_ALL_CACHES_CRISP" );

DeclareGlobalFunction( "CATEGORIES_FOR_HOMALG_PREPARE_CACHING_RECORD" );

DeclareGlobalFunction( "SEARCH_WPLIST_FOR_OBJECT" );

DeclareGlobalFunction( "CACHINGOBJECT_HIT" );

DeclareGlobalFunction( "CACHINGOBJECT_MISS" );

DeclareGlobalFunction( "COMPARE_LISTS_WITH_IDENTICAL" );

DeclareGlobalFunction( "CreateWeakCachingObject" );

DeclareGlobalFunction( "CreateCrispCachingObject" );

DeclareGlobalFunction( "TOOLS_FOR_HOMALG_CACHE_CLEAN_UP" );

DeclareGlobalFunction( "TOOLS_FOR_HOMALG_SET_CACHE_PROPERTY" );


#! @Section Object constructors

#!  Caches are objects which store for a fixed number of keys
#!  a value, so they are a map Obj^k -> Obj, while the k is
#!  fixed. A cache ususally stores the result in a weak pointer
#!  list, which means that if the value which the cache should store
#!  is not referenced in the system anymore, it will not be remembered
#!  by the cache. However, caches can be set to store the value permanently (crisp),
#!  or not to store any new value at all (inaktive). In that case, already stored values
#!  are still in the cache and can be accessed once the cache is set active again.

#! @BeginGroup
#! @Returns a cache
#! @Arguments [k],[is_crisp]
#! @Description
#!  If no argument is given, the function returns a weak cache with key length one,
#!  if an integer k is given, a weak cache with key length k, and if the bool is_crisp
#!  is true, a crisp cache with the corresponding length.
DeclareOperation( "CachingObject",
                  [ ] );

#!
DeclareOperation( "CachingObject",
                  [ IsObject ] );

#!
DeclareOperation( "CachingObject",
                  [ IsObject, IsObject ] );

#! @EndGroup

#! @BeginGroup
#! @Arguments object, cache_name, length, [is_crisp]
#! @Description
#!  This methods are not installed, they serve as an interface
#!  for InstallMethodWithCacheFromObject.
DeclareOperation( "CachingObject",
                  [ IsObject, IsObject, IsInt ] );

#!
DeclareOperation( "CachingObject",
                  [ IsObject, IsObject, IsInt, IsBool ] );

#! @EndGroup

DeclareOperation( "Add",
                  [ IsCachingObject, IsInt, IsObject ] );

DeclareOperation( "GetObject",
                  [ IsCachingObject, IsInt, IsInt ] );

#! @Section Setters, getters

#! @Returns stored value
#! @Arguments cache, key
#! @Description
#!  If there is a value stored in the cache for key, which can be a single key for
#!  caches with key length one or a list of keys depending on the key length of the cache,
#!  this method returns the value, otherwise SuPeRfail.
DeclareOperation( "CacheValue",
                  [ IsCachingObject, IsObject ] );

#! @Arguments cache, key, value
#! @Description
#!  Sets the value of key of the cache to value.
DeclareOperation( "SetCacheValue",
                  [ IsCachingObject, IsObject, IsObject ] );

#! @Arguments obj1, obj2
#! @Returns true or false
#! @Description
#!  This function is used to compare objects for the caches.
#!  The standard way is IsIdenticalObj, and lists are compared recursive
#!  with this function. It is possible and recommended to overload this function as needed.
DeclareOperation( "IsEqualForCache",
                  [ IsObject, IsObject ] );

#! @Section Managing functions

#! @BeginGroup
#! @Arguments cache
#! @Returns nothing
#! @Description
#!  Sets the caching to crisp, weak, or deativates the cache completely.
DeclareGlobalFunction( "SetCachingObjectCrisp" );

#!
DeclareGlobalFunction( "SetCachingObjectWeak" );

#!
DeclareGlobalFunction( "DeactivateCachingObject" );

#! @Section Install functions

#! @Arguments Like InstallMethod
#! @Description
#!  Installs a method like InstallMethod, but additionally puts a cache layer around it
#!  so that the result is cached. It is possible to give the cache as the option Cache,
#!  to use the same cache for more than one method or store it somewhere to have access to
#!  the cache.
DeclareGlobalFunction( "InstallMethodWithCache" );


DeclareSynonym( "InstallMethodWithWeakCache", InstallMethodWithCache );

#! @Description
#!  Like InstallMethodWithCache, but with a crisp cache.
DeclareGlobalFunction( "InstallMethodWithCrispCache" );

#! @Arguments Like InstallMethod
#! @Description
#!  This works just like InstallMethodWithCache, but it extracts
#!  the cache via the CachingObject method from one of its arguments.
#!  The CachingObject must then be implemented for one of the arguments,
#!  and the option ArgumentNumber can specify which option to be used.
#!  As second argument for CachingObject a string is used, which can identify
#!  the cache. Standard is the name of the operation, for which the method is
#!  installed, but it can be specified using the CacheName option.
DeclareGlobalFunction( "InstallMethodWithCacheFromObject" );

## Installed for CachingObject, Int, String
DeclareOperation( "InstallHas",
                  [ IsObject, IsString, IsList ] );

DeclareOperation( "InstallSet",
                  [ IsObject, IsString, IsList ] );

DeclareOperation( "DeclareHasAndSet",
                  [ IsString, IsList ] );

DeclareOperation( "DeclareOperationWithCache",
                  [ IsString, IsList ] );

DeclareGlobalFunction( "CacheFromObjectWrapper" );

################################
##
## Debug functions
##
################################

DeclareGlobalVariable( "TOOLS_FOR_HOMALG_SAVED_CACHES_FROM_INSTALL_METHOD_WITH_CACHE" );

DeclareGlobalFunction( "TOOLS_FOR_HOMALG_STORE_CACHES" );
