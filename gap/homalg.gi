#############################################################################
##
##  homalg.gi                   homalg package               Mohamed Barakat
##
##  Copyright 2007-2008 Lehrstuhl B für Mathematik, RWTH Aachen
##
##  Implementation stuff for homalg.
##
#############################################################################

####################################
#
# global variables:
#
####################################

# a central place for configuration variables:

InstallValue( HOMALG,
        rec(
            category := rec(
                            description := "objects and morphisms of a computable Abelian category",
                            short_description := "_for_Abelian_categories",
                            ),
            
            color_display := false,
            
            SubobjectQuotient_uses_Intersect := false,
            
            MaximumNumberOfResolutionSteps := 1001,
            
            AssertionLevel_CheckIfTheyLieInTheSameCategory := 0,
            
           )
);

####################################
#
# global functions:
#
####################################

## a global function for logical implications:
InstallGlobalFunction( LogicalImplicationsForTwoHomalgObjects,
  function( statement, obj_filter, subobj_filter )
    local len, prop_obj, prop_subobj, prop, subobject_getter, len_subobj, rank;
    
    len := Length( statement );
    
    if len < 5 then
        Error( "the first argument must be a list of length at least 5\n" );
    fi;
    
    prop_obj := statement[1];
    prop_subobj := statement[3];
    
    prop := statement[5];
    
    subobject_getter := statement[2];
    
    if Length( prop_obj ) = 1 then
        
        prop_obj := prop_obj[1];
        
        len_subobj := Length( prop_subobj );
        
        if len_subobj = 1 then
            
            InstallImmediateMethod( prop,
                    obj_filter and prop_obj, 0,
                    
              function( o )
                local subobj;
                
                subobj := subobject_getter( o );
                
                if ForAll( prop_subobj[1], p -> Tester( p )( subobj ) and p( subobj ) ) then
                    return true;
                fi;
                
                TryNextMethod( );
                
            end );
            
            InstallImmediateMethod( prop_obj,
                    obj_filter and Tester( prop ), 0,
                    
              function( o )
                local subobj;
                
                subobj := subobject_getter( o );
                
                if ForAll( prop_subobj[1], p -> Tester( p )( subobj ) and p( subobj ) ) and
                   not prop( o ) then
                    return false;
                fi;
                
                TryNextMethod( );
                
            end );
            
            if IsBound( statement[6] ) and IsInt( statement[6] ) then
                rank := statement[6];
            else
                rank := 0;
            fi;
            
            InstallMethod( prop,
                    [ obj_filter ], rank,
                    
              function( o )
                local subobj;
                
                subobj := subobject_getter( o );
                
                if ForAll( prop_subobj[1], p -> Tester( p )( subobj ) and p( subobj ) ) and
                   prop_obj( o ) then
                    return true;
                fi;
                
                TryNextMethod( );
                
            end );
            
            if IsBound( statement[7] ) and IsInt( statement[7] ) then
                
                InstallMethod( prop_obj,
                        [ obj_filter ], statement[7],
                        
                        function( o )
                          local subobj;
                          
                          subobj := subobject_getter( o );
                          
                          if ForAll( prop_subobj[1], p -> Tester( p )( subobj ) and p( subobj ) ) and
                             not prop( o ) then
                              return false;
                          fi;
                          
                          TryNextMethod( );
                          
                      end );
                      
            fi;
            
        elif len_subobj = 3 then
            
            InstallImmediateMethod( prop,
                    obj_filter and prop_obj and IsHomalgLeftObjectOrMorphismOfLeftObjects, 0,
                    
              function( o )
                local subobj;
                
                subobj := subobject_getter( o );
                
                if ForAll( prop_subobj[1], p -> Tester( p )( subobj ) and p( subobj ) ) then
                    return true;
                fi;
                
                TryNextMethod( );
                
            end );
            
            InstallImmediateMethod( prop,
                    obj_filter and prop_obj and IsHomalgRightObjectOrMorphismOfRightObjects, 0,
                    
              function( o )
                local subobj;
                
                subobj := subobject_getter( o );
                
                if ForAll( prop_subobj[2], p -> Tester( p )( subobj ) and p( subobj ) ) then
                    return true;
                fi;
                
                TryNextMethod( );
                
            end );
            
            InstallImmediateMethod( prop_obj,
                    obj_filter and Tester( prop ) and IsHomalgLeftObjectOrMorphismOfLeftObjects, 0,
                    
              function( o )
                local subobj;
                
                subobj := subobject_getter( o );
                
                if ForAll( prop_subobj[1], p -> Tester( p )( subobj ) and p( subobj ) ) and
                   not prop( o ) then
                    return false;
                fi;
                
                TryNextMethod( );
                
            end );
            
            InstallImmediateMethod( prop_obj,
                    obj_filter and Tester( prop ) and IsHomalgRightObjectOrMorphismOfRightObjects, 0,
                    
              function( o )
                local subobj;
                
                subobj := subobject_getter( o );
                
                if ForAll( prop_subobj[2], p -> Tester( p )( subobj ) and p( subobj ) ) and
                   not prop( o ) then
                    return false;
                fi;
                
                TryNextMethod( );
                
            end );
            
            if IsBound( statement[6] ) and IsInt( statement[6] ) then
                rank := statement[6];
            else
                rank := 0;
            fi;
            
            InstallMethod( prop,
                    [ obj_filter and IsHomalgLeftObjectOrMorphismOfLeftObjects ], rank,
                    
              function( o )
                local subobj;
                
                subobj := subobject_getter( o );
                
                if ForAll( prop_subobj[1], p -> Tester( p )( subobj ) and p( subobj ) ) and
                   prop_obj( o ) then
                    return true;
                fi;
                
                TryNextMethod( );
                
            end );
            
            InstallMethod( prop,
                    [ obj_filter and IsHomalgRightObjectOrMorphismOfRightObjects ], 0,
                    
              function( o )
                local subobj;
                
                subobj := subobject_getter( o );
                
                if ForAll( prop_subobj[2], p -> Tester( p )( subobj ) and p( subobj ) ) and
                   prop_obj( o ) then
                    return true;
                fi;
                
                TryNextMethod( );
                
            end );
            
            if IsBound( statement[7] ) and IsInt( statement[7] ) then
                
                InstallMethod( prop_obj,
                        [ obj_filter and IsHomalgLeftObjectOrMorphismOfLeftObjects ], statement[7],
                        
                        function( o )
                          local subobj;
                          
                          subobj := subobject_getter( o );
                          
                          if ForAll( prop_subobj[1], p -> Tester( p )( subobj ) and p( subobj ) ) and
                             not prop( o ) then
                              return false;
                          fi;
                          
                          TryNextMethod( );
                          
                      end );
                      
                InstallMethod( prop_obj,
                        [ obj_filter and IsHomalgRightObjectOrMorphismOfRightObjects ], statement[7],
                        
                        function( o )
                          local subobj;
                    
                          subobj := subobject_getter( o );
                          
                          if ForAll( prop_subobj[2], p -> Tester( p )( subobj ) and p( subobj ) ) and
                             not prop( o ) then
                              return false;
                          fi;
                          
                          TryNextMethod( );
                          
                      end );
                      
            fi;
            
        fi;
        
    fi;
    
end );

##
InstallGlobalFunction( InstallLogicalImplicationsForHomalgObjects,
  function( arg )
    local nargs, properties, filter, subobj_filter, statement;
    
    nargs := Length( arg );
    
    if nargs < 2 then
        Error( "too few arguments\n" );
    fi;
    
    properties := arg[1];
    filter := arg[2];
    
    if nargs = 2 then
    
        for statement in properties do;
            
            LogicalImplicationsForOneHomalgObject( statement, filter );
            
        od;
        
    elif nargs = 3 then
        
        subobj_filter := arg[3];
        
        for statement in properties do;
            
            LogicalImplicationsForTwoHomalgObjects( statement, filter, subobj_filter );
            
        od;
        
    fi;
    
end );

## a global function for logical implications of subobjects:
InstallGlobalFunction( LogicalImplicationsForHomalgSubobjects,
  function( prop_attr, filter_subobject, test_underlying_object, fetch_underlying_object )
    
    InstallImmediateMethod( prop_attr,
            filter_subobject and test_underlying_object, 0,
            
      function( o )
        if Tester( prop_attr )( fetch_underlying_object( o ) ) then
            return prop_attr( fetch_underlying_object( o ) );
        fi;
        
        TryNextMethod( );
        
      end );
    
    InstallMethod( prop_attr,
        "for homalg subobjects",
        [ filter_subobject ],
        
      function( o )
        
        return prop_attr( fetch_underlying_object( o ) );
        
      end );
    
end );

## a global function for logical implications of subobjects:
InstallGlobalFunction( InstallLogicalImplicationsForHomalgSubobjects,
  function( properties_attributes, filter_subobject, test_underlying_object, fetch_underlying_object )
    local s;
    
    for s in properties_attributes do
        LogicalImplicationsForHomalgSubobjects( s, filter_subobject, test_underlying_object, fetch_underlying_object );
    od;
    
end );

