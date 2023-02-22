# SPDX-License-Identifier: GPL-2.0-or-later
# ToolsForHomalg: Special methods and knowledge propagation tools
#
# Implementations
#

DeclareRepresentation( "IsZFunctionRep",
                       IsComponentObjectRep and IsAttributeStoringRep,
                       [ ] );

DeclareRepresentation( "IsZFunctionWithInductiveSidesRep",
                       IsComponentObjectRep and IsAttributeStoringRep,
                       [ ] );

BindGlobal( "FamilyOfZFunctions",
            NewFamily( "z functions" ) );

BindGlobal( "FamilyOfZFunctionsWithInductiveSides",
            NewFamily( "z functions with inductive sides" ) );

BindGlobal( "TheTypeOfZFunctions",
            NewType( FamilyOfZFunctions,
                     IsZFunction and IsZFunctionRep ) );

BindGlobal( "TheTypeOfZFunctionsWithInductiveSides",
            NewType( FamilyOfZFunctionsWithInductiveSides,
                     IsZFunctionWithInductiveSides and IsZFunctionWithInductiveSidesRep ) );

##
InstallGlobalFunction( VoidZFunction,
  function( )
    local z_function;
    
    z_function := rec( );
    
    ObjectifyWithAttributes( z_function, TheTypeOfZFunctions );
    
    return z_function;
    
end );


##
InstallMethod( AsZFunction,
          [ IsFunction ],
  
  function( func )
    local z_function;
    
    z_function := rec( );
    
    ObjectifyWithAttributes( z_function, TheTypeOfZFunctions,
                            UnderlyingFunction, func );
    
    return z_function;
    
end );

##
InstallMethod( ZFunctionWithInductiveSides,
          [ IsInt, IsObject, IsFunction, IsFunction, IsFunction ],
  
  function( N, value_N, lower_func, upper_func, compare_func )
    local z_function, func;
    
    func :=
      function( i )
        local prev_value, value;
        
        if i = N then
          
          return value_N;
          
        elif i > N then
          
          if HasStableUpperValue( z_function ) then
            
            return StableUpperValue( z_function );
            
          else
            
            prev_value := z_function[ i - 1 ];
            
            value := upper_func( prev_value );
            
            if compare_func( value, prev_value ) then
              
              SetStableUpperValue( z_function, i - 1, value );
              
            fi;
            
            return value;
            
          fi;
          
        elif i < N then
          
          if HasStableLowerValue( z_function ) then
            
            return StableLowerValue( z_function );
            
          else
            
            prev_value := z_function[ i + 1 ];
            
            value := lower_func( prev_value );
            
            if compare_func( value, prev_value ) then
              
              SetStableLowerValue( z_function, i + 1, value );
              
            fi;
            
            return value;
            
          fi;
          
        fi;
        
      end;
    
    z_function := rec();
    
    ObjectifyWithAttributes( z_function, TheTypeOfZFunctionsWithInductiveSides,
            UnderlyingFunction, func,
            StartingIndex, N,
            StartingValue, value_N,
            UpperFunction, upper_func,
            LowerFunction, lower_func,
            CompareFunction, compare_func );
    
    return z_function;
    
end );

##
InstallMethod( SetStableLowerValue,
          [ IsZFunction, IsInt, IsObject ],
  
  function( z_func, n, val )
    
    SetStableLowerValue( z_func, val );
    
    SetIndexOfStableLowerValue( z_func, n );
    
end );

##
InstallMethod( SetStableUpperValue,
          [ IsZFunction, IsInt, IsObject ],
  
  function( z_func, n, val )
    
    SetStableUpperValue( z_func, val );
    
    SetIndexOfStableUpperValue( z_func, n );
    
end );


##
InstallMethod( ZFunctionValueOp,
          [ IsZFunction, IsInt ],
  
  { z_function, i } -> UnderlyingFunction( z_function )( i )
);

##
InstallMethod( ZFunctionValueOp,
          [ IsZFunction and HasIndexOfStableLowerValue, IsInt ],
  
  function( z_function, i )
    
    if i <= IndexOfStableLowerValue( z_function ) then
      return StableLowerValue( z_function );
    else
      TryNextMethod( );
    fi;
    
end );

##
InstallMethod( ZFunctionValueOp,
          [ IsZFunction and HasIndexOfStableUpperValue, IsInt ],
  
  function( z_function, i )
    
    if i >= IndexOfStableUpperValue( z_function ) then
      return StableUpperValue( z_function );
    else
      TryNextMethod( );
    fi;
    
end );

##
InstallMethod( \[\],
          [ IsZFunction, IsInt ],
  
  { z_function, i } -> ZFunctionValue( z_function, i )
);

##
InstallMethod( ApplyMap,
          [ IsDenseList, IsFunction ],
  
  function( z_functions, map )
    local z_function;
    
    z_function := AsZFunction( i -> CallFuncList( map, List( z_functions, z_function -> z_function[ i ] ) ) );
    
    SetBaseZFunctions( z_function, z_functions );
    
    SetAppliedMap( z_function, map );
    
    return z_function;
    
end );

##
InstallMethod( ApplyMap,
          [ IsZFunction, IsFunction ],
  
  { z_function, map } -> ApplyMap( [ z_function ], map )
);

##
InstallMethod( CombineZFunctions,
          [ IsDenseList ],
  
  L -> ApplyMap( L, function( arg ) return arg; end )
);

##
InstallMethod( Reflection,
          [ IsZFunction ],
  
  function( z_function )
    local reflection;
    
    reflection := AsZFunction( i -> z_function[ -i ] );
    
    SetReflection( reflection, z_function );
    
    return reflection;
    
end );

##
InstallMethod( Replace,
          [ IsZFunction, IsInt, IsDenseList ],
  function( z_function, n, L )
    local func;
    
    func :=
      function( i )
        
        if i in [ n .. n + Length( L ) - 1 ] then
          
          return L[ i - n + 1 ];
          
        else
          
          return z_function[ i ];
          
        fi;
        
      end;
      
    return AsZFunction( func );
    
end );

##
InstallMethod( ApplyShiftOp,
          [ IsZFunction, IsInt ],
  
  function( z_function, n )
    local shift;
    
    shift := AsZFunction( i -> z_function[ i + n ] );
    
    SetApplyShift( shift, -n, z_function );
    
    return shift;
    
end );

##
InstallMethod( ViewObj,
          [ IsZFunction ],
  
  function( z_function )
    
    Print( "<ZFunction>" );
    
end );

