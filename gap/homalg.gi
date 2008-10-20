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
# representations:
#
####################################

# a new representation for the GAP-category IsHomalgRingOrObject:
DeclareRepresentation( "IsHomalgRingOrFinitelyPresentedObjectRep",
        IsHomalgRingOrObject,
        [ ] );

# a new representation for the GAP-category IsHomalgObject
# which is a subrepresentation of the representation IsHomalgRingOrFinitelyPresentedObjectRep:
DeclareRepresentation( "IsHomalgRingOrFinitelyPresentedModuleRep",
        IsHomalgRingOrFinitelyPresentedObjectRep,
        [ ] );

# a new representation for the GAP-category IsHomalgObject
# which is a subrepresentation of the representation IsHomalgRingOrFinitelyPresentedObjectRep:
DeclareRepresentation( "IsFinitelyPresentedObjectRep",
        IsHomalgObject and IsHomalgRingOrFinitelyPresentedObjectRep,
        [ ] );

# a new representation for the GAP-category IsHomalgMorphism:
DeclareRepresentation( "IsMorphismOfFinitelyGeneratedModulesRep",
        IsHomalgMorphism,
        [ ] );

# a new representation for the GAP-category IsContainerForWeakPointers:
DeclareRepresentation( "IsContainerForWeakPointersRep",
        IsContainerForWeakPointers,
        [ "weak_pointers", "counter", "deleted" ] );

####################################
#
# families and types:
#
####################################

# a new family:
BindGlobal( "TheFamilyOfContainersForWeakPointers",
        NewFamily( "TheFamilyOfContainersForWeakPointers" ) );

# a new type:
BindGlobal( "TheTypeContainerForWeakPointers",
        NewType( TheFamilyOfContainersForWeakPointers,
                IsContainerForWeakPointersRep ) );

####################################
#
# global variables:
#
####################################

# a central place for configuration variables:

InstallValue( HOMALG,
        rec(
            TotalRuntimes := 0,
            OtherInternalMatrixTypes := [ ],
            
            color_BOT := "\033[1;37;40m",		## (T)riangular basis: TriangularBasisOfRows/Columns
            color_BOW := "\033[1;37;40m",		## Triangular basis: TriangularBasisOfRows/Columns( M, W )
            color_BOB := "\033[1;37;45m",		## (B)asis: BasisOfRow/ColumnModule
            color_BOC := "\033[1;37;45m",		## Basis: BasisOfRows/Columns(C)oeff
            color_BOD := "\033[1;37;42m",		## existence of a particular solution: (D)ecideZeroRows/Columns
            color_BOP := "\033[1;37;42m",		## (P)articular solution: DecideZeroRows/Columns(Effectively)
            color_BOH := "\033[1;37;41m",		## solutions of the (H)omogeneous system: SyzygiesGeneratorsOfRows/Columns
            color_busy := "\033[01m\033[4;31;40m",
            color_done := "\033[01m\033[4;32;40m",
            
            color_display := false,
            
            PreferDenseMatrices := false,
            
            MaximumNumberOfResolutionSteps := 1001,
            
           )
);

####################################
#
# global functions:
#
####################################

##
InstallGlobalFunction( ContainerForWeakPointers,
  function( arg )
    local nargs, container, component, type;
    
    nargs := Length( arg );
    
    container := rec( weak_pointers := WeakPointerObj( [ ] ),
                      counter := 0,
                      deleted := [ ] );
    
    for component in arg{[ 2 .. nargs ]} do
        container.( component[1] ) := component[2];
    od;
               
    type := arg[1];
    
    ## Objectify:
    Objectify( type, container );
    
    return container;
    
end );

##
InstallGlobalFunction( homalgTotalRuntimes,
  function( arg )
    local r, t;
    
    r := Runtimes( );
    
    HOMALG.TotalRuntimes := r.user_time;
    
    if IsBound( r.system_time ) then
        HOMALG.TotalRuntimes := HOMALG.TotalRuntimes + r.system_time;
    fi;
    
    if IsBound( r.user_time_children ) then
        HOMALG.TotalRuntimes := HOMALG.TotalRuntimes + r.user_time_children;
    fi;
    
    if IsBound( r.system_time_children ) then
        HOMALG.TotalRuntimes := HOMALG.TotalRuntimes + r.system_time_children;
    fi;
    
    if Length( arg ) = 0 then
        return HOMALG.TotalRuntimes;
    fi;
    
    return TimeToString( HOMALG.TotalRuntimes - arg[1] );
    
end );

##
InstallGlobalFunction( AddLeftRightLogicalImplicationsForHomalg,
  function( list, properties )
    local prop, property, left_property, right_property, add;
    
    for prop in properties do;
        
        if IsList( prop ) and Length( prop ) = 2 and ForAll( prop, IsString ) then
            
            property := ValueGlobal( Concatenation( prop[1], prop[2] ) );
            left_property := ValueGlobal( Concatenation( prop[1], "Left", prop[2] ) );
            right_property := ValueGlobal( Concatenation( prop[1], "Right", prop[2] ) );
            
            add := [
                    
                    [ left_property, "and", right_property,
                      "define", property ],
                    
                    [ property,
                      "implies by definition", left_property ],
                    
                    [ property,
                      "implies by definition", right_property ],
                    
                    [ IsCommutative, "and", left_property,
                      "trivially imply", right_property ],
                    
                    [ IsCommutative, "and", right_property,
                      "trivially imply", left_property ],
                    
		    ## we also need these two for their contra positions to get installed
                    [ IsCommutative, "and", left_property,
                      "trivially imply", property ],
                    
                    [ IsCommutative, "and", right_property,
                      "trivially imply", property ],
                    
                    ];
            
        elif IsList( prop ) and Length( prop ) = 3 and ForAll( prop, IsString ) then
            
            property := ValueGlobal( Concatenation( prop[1], prop[2] ) );
            left_property := ValueGlobal( Concatenation( prop[1], "Left", prop[2] ) );
            right_property := ValueGlobal( Concatenation( prop[1], "Right", prop[2] ) );
            
            add := [
                    
                    [ IsCommutative, "and", left_property,
                      "trivally imply", right_property ],
                    
                    [ IsCommutative, "and", left_property,
                      "trivally imply", property ],
                    
                    [ IsCommutative, "and", right_property,
                      "trivally imply", left_property ],
                    
                    [ IsCommutative, "and", right_property,
                      "trivally imply", property ],
                    
                    [ IsCommutative, "and", property,
                      "trivally imply", left_property ],
                    
                    [ IsCommutative, "and", property,
                      "trivally imply", right_property ]
                    
                    ];
            
        fi;
        
        Append( list, add );
        
    od;
    
end );

## a global function for logical implications:
InstallGlobalFunction( LogicalImplicationsForOneHomalgObject,
  function( statement, filter )
    local len, propA, propB, propC, prop;
    
    len := Length( statement );
    
    if len = 3 then
        
        propA := statement[1];
        prop := statement[3];
        
        InstallTrueMethod( prop, filter and propA );
        
        InstallImmediateMethod( propA,
                filter and Tester( prop ), 0,
                
          function( o )
            if not prop( o ) then
                return false;
            fi;
            
            TryNextMethod( );
            
        end );
        
    elif len = 5 then
        
        propA := statement[1];
        propB := statement[3];
        prop := statement[5];
        
        InstallTrueMethod( prop, filter and propA and propB );
        
        InstallImmediateMethod( propA,
                filter and Tester( propB ) and Tester( prop ), 0,
                
          function( o )
            if propB( o ) and not prop( o ) then
                return false;
            fi;
            
            TryNextMethod( );
            
        end );
        
        InstallImmediateMethod( propB,
                filter and Tester( propA ) and Tester( prop ), 0,
                
          function( o )
            if propA( o ) and not prop( o ) then
                return false;
            fi;
            
            TryNextMethod( );
            
        end );
        
    elif len = 7 then
        
        propA := statement[1];
        propB := statement[3];
        propC := statement[5];
        prop := statement[7];
        
        InstallTrueMethod( prop, filter and propA and propB and propC );
        
        InstallImmediateMethod( propA,
                filter and Tester( propB ) and Tester( propC ) and Tester( prop ), 0,
                
          function( o )
            if propB( o ) and propC( o ) and not prop( o ) then
                return false;
            fi;
            
            TryNextMethod( );
            
        end );
        
        InstallImmediateMethod( propB,
                filter and Tester( propA ) and Tester( propC ) and Tester( prop ), 0,
                
          function( o )
            if propA( o ) and propC( o ) and not prop( o ) then
                return false;
            fi;
            
            TryNextMethod( );
            
        end );
        
        InstallImmediateMethod( propC,
                filter and Tester( propA ) and Tester( propB ) and Tester( prop ), 0,
                
          function( o )
            if propA( o ) and propB( o ) and not prop( o ) then
                return false;
            fi;
            
            TryNextMethod( );
            
        end );
        
    fi;
    
end );

## a global function for logical implications:
InstallGlobalFunction( LogicalImplicationsForTwoHomalgObjects,
  function( statement, obj_filter, subobj_filter )
    local len, prop_obj, prop_subobj, prop, subobject_getter, len_obj, len_subobj;
    
    len := Length( statement );
    
    if len <> 5 then
        Error( "the first argument must be a list of length 5\n" );
    fi;
    
    prop_obj := statement[1];
    prop_subobj := statement[3];
    
    prop := statement[5];
    
    subobject_getter := statement[2];
    
    len_obj := Length( prop_obj );
    len_subobj := Length( prop_subobj );
    
    if len_obj = 1 and len_subobj = 1 then
        
        prop_obj := prop_obj[1];
        prop_subobj := prop_subobj[1];
        
        if IsList( prop_subobj ) then
            len_subobj := Length( prop_subobj );
        fi;
        
        if len_subobj = 3 then
            
            InstallImmediateMethod( prop,
                    obj_filter and prop_obj and IsHomalgLeftObjectOrMorphismOfLeftObjects, 0,
                    
              function( o )
                local subobj;
                
                subobj := subobject_getter( o );
                
                if Tester( prop_subobj[1] )( subobj ) and prop_subobj[1]( subobj ) then
                    return true;
                fi;
                
                TryNextMethod( );
                
            end );
            
            InstallImmediateMethod( prop,
                    obj_filter and prop_obj and IsHomalgRightObjectOrMorphismOfRightObjects, 0,
                    
              function( o )
                local subobj;
                
                subobj := subobject_getter( o );
                
                if Tester( prop_subobj[2] )( subobj ) and prop_subobj[2]( subobj ) then
                    return true;
                fi;
                
                TryNextMethod( );
                
            end );
            
            InstallImmediateMethod( prop_obj,
                    obj_filter and Tester( prop ) and IsHomalgLeftObjectOrMorphismOfLeftObjects, 0,
                    
              function( o )
                local subobj;
                
                subobj := subobject_getter( o );
                
                if Tester( prop_subobj[1] )( subobj ) and prop_subobj[1]( subobj ) and
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
                
                if Tester( prop_subobj[2] )( subobj ) and prop_subobj[2]( subobj ) and
                   not prop( o ) then
                    return false;
                fi;
                
                TryNextMethod( );
                
            end );
            
        fi;
        
    fi;
    
end );

##
InstallGlobalFunction( InstallLogicalImplicationsForHomalg,
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

## a global function for left/right attributes:
InstallGlobalFunction( LeftRightAttributesForHomalg,
  function( attr, filter )
    local attribute, left_attribute, right_attribute;
    
    attribute := ValueGlobal( attr );
    left_attribute := ValueGlobal( Concatenation( "Left", attr ) );
    right_attribute := ValueGlobal( Concatenation( "Right", attr ) );
    
    InstallImmediateMethod( left_attribute,
            filter and Tester( attribute ), 0,
            
      function( o )
        
        return attribute( o );
        
    end );
    
    InstallImmediateMethod( right_attribute,
            filter and Tester( attribute ), 0,
            
      function( o )
        
        return attribute( o );
        
    end );
    
    InstallImmediateMethod( attribute,
            filter and Tester( left_attribute ) and Tester( right_attribute ), 0,
            
      function( o )
        local l;
        
        l := left_attribute( o );
        
        if l = right_attribute( o ) then
            return l;
        fi;
        
        TryNextMethod( );
        
    end );
    
    ## extra for homalg rings
    if filter = IsHomalgRing then
        
        InstallImmediateMethod( left_attribute,
                filter and Tester( right_attribute ) and IsCommutative, 0,
                
          function( o )
            
            return right_attribute( o );
            
        end );
        
        InstallImmediateMethod( right_attribute,
                filter and Tester( left_attribute ) and IsCommutative, 0,
                
          function( o )
            
            return left_attribute( o );
            
        end );
        
    fi;
    
end );

##
InstallGlobalFunction( InstallLeftRightAttributesForHomalg,
  function( attributes, filter )
    local attribute;
    
    for attribute in attributes do;
        
        LeftRightAttributesForHomalg( attribute, filter );
        
    od;
    
end );

##
InstallGlobalFunction( homalgNamesOfComponentsToIntLists,
  function( arg )
    
    return Filtered(
                   List( NamesOfComponents( arg[1] ),
                         function( a )
                           local l;
                           l := SplitString( a, ",", "[ ]" );
                           if Length( l ) = 1 then
                               if Length( l[1] ) <= 24 then
                                   return Int( l[1] );
                               else
                                   return fail;
                               fi;
                           else
                               return List( l, Int );
                           fi;
                         end
                       ),
                  b -> b <> fail );
end );

##
InstallGlobalFunction( homalgMode,
  function( arg )
    local nargs, mode;
    
    nargs := Length( arg );
    
    if nargs = 0 or ( IsString( arg[1] ) and arg[1] = "" ) then
        mode := "default";
    elif IsString( arg[1] ) then	## now we know, the string is not empty
        if LowercaseString( arg[1]{[1]} ) = "a" then
            mode := "all";
        elif LowercaseString( arg[1]{[1]} ) = "b" then
            mode := "basic";
        elif LowercaseString( arg[1]{[1]} ) = "d" then
            mode := "debug";
        elif LowercaseString( arg[1]{[1]} ) = "f" then
            mode := "file";
        elif LowercaseString( arg[1]{[1]} ) = "p" then
            mode := "picto";
        else
            mode := "";
        fi;
    else
        Error( "the first argument must be a string\n" );
    fi;
    
    if mode = "default" then
        HOMALG.color_display := false;
        SetInfoLevel( InfoCOLEM, 1 );
        SetInfoLevel( InfoLIMAT, 1 );
        SetInfoLevel( InfoHomalgBasicOperations, 1 );
    elif mode = "all" then
        HOMALG.color_display := true;
        SetInfoLevel( InfoCOLEM, 2 );
        SetInfoLevel( InfoLIMAT, 2 );
        SetInfoLevel( InfoHomalgBasicOperations, 4 );
    elif mode = "basic" then
        HOMALG.color_display := true;
        SetInfoLevel( InfoCOLEM, 2 );
        SetInfoLevel( InfoLIMAT, 2 );
        SetInfoLevel( InfoHomalgBasicOperations, 3 );
    elif mode = "debug" then
        HOMALG.color_display := true;
        SetInfoLevel( InfoCOLEM, 2 );
        SetInfoLevel( InfoLIMAT, 2 );
        SetInfoLevel( InfoHomalgBasicOperations, 4 );
    elif mode = "file" then
        HOMALG.color_display := true;
        SetInfoLevel( InfoCOLEM, 2 );
        SetInfoLevel( InfoLIMAT, 2 );
        SetInfoLevel( InfoHomalgBasicOperations, 1 );
    elif mode = "picto" then
        HOMALG.color_display := true;
        SetInfoLevel( InfoCOLEM, 2 );
        SetInfoLevel( InfoLIMAT, 2 );
        SetInfoLevel( InfoHomalgBasicOperations, 1 );
    fi;
    
end );

####################################
#
# methods for operations:
#
####################################

##
InstallMethod( ExamplesForHomalg,
        [  ], 0,
        
  function( )
    
    if LoadPackage( "ExamplesForHomalg" ) = true then
        ExamplesForHomalg( );
    else
        return fail;
    fi;
    
end );

