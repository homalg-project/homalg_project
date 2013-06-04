#############################################################################
##
##  ToolsForHomalg.gi                                 ToolsForHomalg package
##
##  Copyright 2007-2012, Mohamed Barakat, University of Kaiserslautern
##                       Sebastian Gutsche, RWTH-Aachen University
##                  Markus Lange-Hegermann, RWTH-Aachen University
##
##  Implementations for ToolsForHomalg.
##
#############################################################################

####################################
#
# representations:
#
####################################

##  <#GAPDoc Label="IsStructureObjectOrFinitelyPresentedObjectRep">
##  <ManSection>
##    <Filt Type="Representation" Arg="M" Name="IsStructureObjectOrFinitelyPresentedObjectRep"/>
##    <Returns><C>true</C> or <C>false</C></Returns>
##    <Description>
##      The &GAP; representation of finitley generated &homalg; objects. <P/>
##      It is a representation of the &GAP; category <Ref Filt="IsHomalgObject"/>.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareRepresentation( "IsStructureObjectOrFinitelyPresentedObjectRep",
        IsStructureObjectOrObject,
        [ ] );

# a new representation for the GAP-category IsHomalgObject
# which is a subrepresentation of the representation IsStructureObjectOrFinitelyPresentedObjectRep and IsHomalgRingOrModule:
DeclareRepresentation( "IsHomalgRingOrFinitelyPresentedModuleRep",
        IsStructureObjectOrFinitelyPresentedObjectRep and
        IsHomalgRingOrModule,
        [ ] );

# a new representation for the GAP-category IsContainerForWeakPointers:
DeclareRepresentation( "IsContainerForWeakPointersRep",
        IsContainerForWeakPointers,
        [ "weak_pointers", "active", "deleted", "counter", "cache_hits" ] );

# a new subrepresentation of IsContainerForWeakPointersRep:
DeclareRepresentation( "IsContainerForWeakPointersOnObjectsRep",
        IsContainerForWeakPointersRep,
        [ "weak_pointers", "active", "deleted", "counter", "accessed", "cache_misses", "cache_hits" ] );

# a new subrepresentation of IsContainerForWeakPointersOnObjectsRep:
DeclareRepresentation( "IsContainerForWeakPointersOnComputedValuesRep",
        IsContainerForWeakPointersOnObjectsRep,
        [ "weak_pointers", "weak_pointers_on_values", "active", "deleted", "counter", "accessed", "cache_misses", "cache_hits" ] );

# a new subrepresentation of IsContainerForWeakPointersOnObjectsRep:
DeclareRepresentation( "IsContainerForWeakPointersOnContainersRep",
        IsContainerForWeakPointersOnObjectsRep,
        [ "weak_pointers", "active", "deleted", "counter" ] );

####################################
#
# representations for pointer object
#
####################################

# a new representation for the GAP-category IsContainerForPointers:
DeclareRepresentation( "IsContainerForPointersRep",
        IsContainerForPointers,
        [ "pointers", "counter", "cache_hits", "cache_misses" ] );

# a new subrepresentation of IsContainerForPointersRep:
DeclareRepresentation( "IsContainerForPointersOnObjectsRep",
        IsContainerForPointersRep,
        [ "pointers", "counter", "accessed" ] );

# a new subrepresentation of IsContainerForPointersOnObjectsRep:
DeclareRepresentation( "IsContainerForPointersOnComputedValuesRep",
        IsContainerForPointersOnObjectsRep,
        [ "pointers", "pointers_on_values", "counter", "accessed" ] );

# a new subrepresentation of IsContainerForPointersOnObjectsRep:
DeclareRepresentation( "IsContainerForPointersOnContainersRep",
        IsContainerForPointersOnObjectsRep,
        [ "pointers", "counter" ] );

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

# a new type:
BindGlobal( "TheTypeContainerForWeakPointersOnObjects",
        NewType( TheFamilyOfContainersForWeakPointers,
                IsContainerForWeakPointersOnObjectsRep ) );

# a new type:
BindGlobal( "TheTypeContainerForWeakPointersOnComputedValues",
        NewType( TheFamilyOfContainersForWeakPointers,
                IsContainerForWeakPointersOnComputedValuesRep ) );

# a new type:
BindGlobal( "TheTypeContainerForWeakPointersOnContainers",
        NewType( TheFamilyOfContainersForWeakPointers,
                IsContainerForWeakPointersOnContainersRep ) );

####################################
#
# global variables:
#
####################################

# a central place for configuration variables:

InstallValue( HOMALG_TOOLS,
        rec(
            TotalRuntimes := 0,
            
            ## ContainersForWeakPointers "will be added below",
            
            )
        );

####################################
#
# global functions:
#
####################################

InfoOfObject :=
  function( arg )
    local o, depth, attr, cmpn, prop, tprp, all, i, r, a;
    
    o := arg[1];
    
    if Length( arg ) > 1 then
        depth := arg[2];
    else
        depth := 1;
    fi;
        
    if depth = 0 then
        return o;
    elif IsAttributeStoringRep( o ) then
        attr := KnownAttributesOfObject( o );
        cmpn := Filtered( NamesOfComponents( o ), a -> not( a in attr ) );
        prop := KnownPropertiesOfObject( o );
        
        all := rec( object := o,
                    attributes := attr,
                    components := cmpn,
                    properties := prop );
    elif IsComponentObjectRep( o ) then
        all := rec( object := o, components := NamesOfComponents( o ) );
    else
        return o;
    fi;
    
    ## below o is an AttributeStoringRep or at least a ComponentObjectRep:
    
    for i in NamesOfComponents( all ) do
        if i in [ "attributes" ] then
            r := rec( );
            for a in all.(i) do
                r.(a) := InfoOfObject( ValueGlobal( a )( o ), depth-1 );
            od;
            all.(i) := r;
        elif i in [ "components" ] then
            r := rec( );
            for a in all.(i) do
                r.(a) := InfoOfObject( o!.(a), depth-1 );
            od;
            all.(i) := r;
        elif i = "properties" then
            r := rec( );
            for a in all.(i) do
                r.(a) := ValueGlobal( a )( o );
            od;
            all.(i) := r;
        fi;
    od;
    
    return all;
    
end;

##
InstallGlobalFunction( ContainerForWeakPointers,
  function( arg )
    local nargs, container, component, type, containers;
    
    nargs := Length( arg );
    
    container := rec( weak_pointers := WeakPointerObj( [ ] ),
                      active := [ ],
                      deleted := [ ],
                      counter := 0,
                      accessed := 0,
                      cache_misses := 0,
                      cache_hits := 0 );
    
    for component in arg{[ 2 .. nargs ]} do
        container.( component[1] ) := component[2];
    od;
    
    type := arg[1];
    
    ## Objectify:
    Objectify( type, container );
    
    if IsBound( HOMALG_TOOLS.ContainersForWeakPointers ) then
        _AddElmWPObj_ForHomalg( HOMALG_TOOLS.ContainersForWeakPointers, container );
    fi;
    
    if IsContainerForWeakPointersOnComputedValuesRep( container ) then
        container!.weak_pointers_on_values := WeakPointerObj( [ ] );
    fi;
    
    return container;
    
end );

HOMALG_TOOLS.ContainersForWeakPointers := ContainerForWeakPointers( TheTypeContainerForWeakPointersOnContainers );
Unbind( HOMALG_TOOLS.ContainersForWeakPointers!.accessed );
Unbind( HOMALG_TOOLS.ContainersForWeakPointers!.cache_misses );
Unbind( HOMALG_TOOLS.ContainersForWeakPointers!.cache_hits );

##
InstallGlobalFunction( homalgTotalRuntimes,
  function( arg )
    local r, t;
    
    r := Runtimes( );
    
    HOMALG_TOOLS.TotalRuntimes := r.user_time;
    
    if IsBound( r.system_time ) and r.system_time <> fail then
        HOMALG_TOOLS.TotalRuntimes := HOMALG_TOOLS.TotalRuntimes + r.system_time;
    fi;
    
    if IsBound( r.user_time_children ) and r.user_time_children <> fail then
        HOMALG_TOOLS.TotalRuntimes := HOMALG_TOOLS.TotalRuntimes + r.user_time_children;
    fi;
    
    if IsBound( r.system_time_children ) and r.system_time_children <> fail then
        HOMALG_TOOLS.TotalRuntimes := HOMALG_TOOLS.TotalRuntimes + r.system_time_children;
    fi;
    
    if Length( arg ) = 0 then
        return HOMALG_TOOLS.TotalRuntimes;
    fi;
    
    t := HOMALG_TOOLS.TotalRuntimes - arg[1];
    
    if Length( arg ) > 1 then
        return Concatenation( StringTime( t ), " h" );
    fi;
    
    return t;
    
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
            
        elif IsList( prop ) and Length( prop ) = 3 and ForAll( prop{[ 1 .. 2 ]}, IsString ) and IsOperation( prop[3] ) then
            
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

##
InstallGlobalFunction( InstallLogicalImplicationsForHomalgBasicObjects,
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
            
            LogicalImplicationsForTwoHomalgBasicObjects( statement, filter, subobj_filter );
            
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
    if filter = IsStructureObject then
        
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
InstallGlobalFunction( MatchPropertiesAndAttributes,
  function( arg )
    local S, T, properties, attributes, propertiesS, propertiesT,
          attributesS, attributesT, p, a, components, c;
    
    S := arg[1];
    T := arg[2];
    properties := arg[3];
    attributes := arg[4];
    
    propertiesS := Intersection2( KnownPropertiesOfObject( S ), properties );
    propertiesT := Intersection2( KnownPropertiesOfObject( T ), properties );
    
    attributesS := Intersection2( KnownAttributesOfObject( S ), attributes );
    attributesT := Intersection2( KnownAttributesOfObject( T ), attributes );
    
    ## for properties:
    for p in propertiesS do	## also check if properties already set for both objects coincide
        Setter( ValueGlobal( p ) )( T, ValueGlobal( p )( S ) );
    od;
    
    ## now backwards
    for p in Difference( propertiesT, propertiesS ) do
        Setter( ValueGlobal( p ) )( S, ValueGlobal( p )( T ) );
    od;
    
    ## for attributes:
    for a in Difference( attributesS, attributesT ) do
        Setter( ValueGlobal( a ) )( T, ValueGlobal( a )( S ) );
    od;
    
    ## now backwards
    for a in Difference( attributesT, attributesS ) do
        Setter( ValueGlobal( a ) )( S, ValueGlobal( a )( T ) );
    od;
    
    ## also check if properties already set for both objects coincide
    
    ## by now, more attributes than the union might be konwn
    attributesS := Intersection2( KnownAttributesOfObject( S ), attributes );
    attributesT := Intersection2( KnownAttributesOfObject( T ), attributes );
    
    for a in Intersection2( attributesS, attributesT ) do
        if ValueGlobal( a )( S ) <> ValueGlobal( a )( T ) then
            Error( "the attribute ", a, " has different values for source and target object\n" );
        fi;
    od;
    
    if Length( arg ) > 4 then
        components := arg[5];
        
        for c in components do
            if IsBound( S!.(c) ) and not IsBound( T!.(c) ) then
                T!.(c) := S!.(c);
            elif IsBound( T!.(c) ) and not IsBound( S!.(c) ) then
                S!.(c) := T!.(c);
            fi;
        od;
        
    fi;
    
end );

##
InstallGlobalFunction( InstallImmediateMethodToPullPropertyOrAttribute,
  function( filter1, filter2, prop_attr, trigger, get_remote_object );
    
    InstallImmediateMethod( prop_attr,
            filter1 and Tester( trigger ), 0,
            
      function( M )
        local U;
        
        U := get_remote_object( M );
        
        if Tester( prop_attr )( U ) then
            return prop_attr( U );
        fi;
        
        TryNextMethod();
        
    end );
    
    InstallMethod( prop_attr,
            "for homalg objects with an underlying object (PullPropertyOrAttribute)",
            [ filter2 ],
            
      function( M )
        
        return prop_attr( get_remote_object( M ) );
        
    end );
    
end );

##
InstallGlobalFunction( InstallImmediateMethodToConditionallyPullPropertyOrAttribute,
  function( filter1, filter2, prop_attr, condition, trigger, get_remote_object );
    
    InstallImmediateMethod( prop_attr,
            filter1 and Tester( trigger ) and condition, 0,
            
      function( M )
        local U;
        
        U := get_remote_object( M );
        
        if Tester( prop_attr )( U ) then
            return prop_attr( U );
        fi;
        
        TryNextMethod();
        
    end );
    
    InstallMethod( prop_attr,
            "for homalg objects with an underlying object (ConditionallyPullPropertyOrAttribute)",
            [ filter2 ],
            
      function( M )
        
        return condition( M ) and prop_attr( get_remote_object( M ) );
        
    end );
    
end );

##
InstallGlobalFunction( InstallImmediateMethodToPullPropertyOrAttributeWithDifferentName,
  function( filter1, filter2, prop_attr, trigger, get_remote_object );
    
    InstallImmediateMethod( prop_attr[1],
            filter1 and Tester( trigger ), 0,
            
      function( M )
        local U;
        
        U := get_remote_object( M );
        
        if Tester( prop_attr[2] )( U ) then
            return prop_attr[2]( U );
        fi;
        
        TryNextMethod();
        
    end );
    
    InstallMethod( prop_attr[1],
            "for homalg objects with an underlying object (PullPropertyOrAttributeWithDifferentName)",
            [ filter2 ],
            
      function( M )
        
        return prop_attr[2]( get_remote_object( M ) );
        
    end );
    
end );

##
InstallGlobalFunction( InstallImmediateMethodToPullPropertiesOrAttributes,
  function( filter1, filter2, PROP_ATTR, triggers, get_remote_object )
    local trigger, prop_attr;
    
    for trigger in triggers do
        
        for prop_attr in PROP_ATTR do
            
            if IsString( prop_attr ) then
                
                if prop_attr <> trigger then
                    InstallImmediateMethodToPullPropertyOrAttribute(
                            filter1,
                            filter2,
                            ValueGlobal( prop_attr ),
                            ValueGlobal( trigger ),
                            get_remote_object
                            );
                fi;
                
            elif IsList( prop_attr ) and Length( prop_attr ) = 2 and
              IsString( prop_attr[1] ) and IsList( prop_attr[2] ) and IsString( prop_attr[2][1] ) then
                
                if prop_attr[1] <> trigger then
                    InstallImmediateMethodToConditionallyPullPropertyOrAttribute(
                            filter1,
                            filter2,
                            ValueGlobal( prop_attr[1] ),
                            ValueGlobal( prop_attr[2][1] ),
                            ValueGlobal( trigger ),
                            get_remote_object
                            );
                fi;
                
            elif IsList( prop_attr ) and Length( prop_attr ) = 2 and ForAll( prop_attr, IsString ) then
                
                if prop_attr[1] <> trigger then
                    InstallImmediateMethodToPullPropertyOrAttributeWithDifferentName(
                            filter1,
                            filter2,
                            List( prop_attr, ValueGlobal ),
                            ValueGlobal( trigger ),
                            get_remote_object
                            );
                fi;
                
            fi;
            
        od;
        
    od;
    
end );

##
InstallGlobalFunction( InstallImmediateMethodToPullTrueProperty,
  function( filter1, filter2, prop, trigger, get_remote_object );
    
    InstallImmediateMethod( prop,
            filter1 and Tester( trigger ), 0,
            
      function( M )
        local U;
        
        U := get_remote_object( M );
        
        if Tester( prop )( U ) and prop( U ) then
            return true;
        fi;
        
        TryNextMethod();
        
    end );
    
    InstallMethod( prop,
            "for homalg objects with an underlying object (MethodToPullTrueProperty)",
            [ filter2 ],
            
      function( M )
        
        if prop( get_remote_object( M ) ) then
            return true;
        fi;
        
        TryNextMethod();
        
    end );
    
end );

##
InstallGlobalFunction( InstallImmediateMethodToConditionallyPullTrueProperty,
  function( filter1, filter2, prop, condition, trigger, get_remote_object );
    
    InstallImmediateMethod( prop,
            filter1 and Tester( trigger ) and condition, 0,
            
      function( M )
        local U;
        
        U := get_remote_object( M );
        
        if Tester( prop )( U ) and prop( U ) then
            return true;
        fi;
        
        TryNextMethod();
        
    end );
    
    InstallMethod( prop,
            "for homalg objects with an underlying object (ConditionallyPullTrueProperty)",
            [ filter2 ],
            
      function( M )
        
        if condition( M ) and prop( get_remote_object( M ) ) then
            return true;
        fi;
        
        TryNextMethod();
        
    end );
    
end );

##
InstallGlobalFunction( InstallImmediateMethodToPullTruePropertyWithDifferentName,
  function( filter1, filter2, prop, trigger, get_remote_object );
    
    InstallImmediateMethod( prop[1],
            filter1 and Tester( trigger ), 0,
            
      function( M )
        local U;
        
        U := get_remote_object( M );
        
        if Tester( prop[2] )( U ) and prop[2]( U ) then
            return true;
        fi;
        
        TryNextMethod();
        
    end );
    
    InstallMethod( prop[1],
            "for homalg objects with an underlying object (PullTruePropertyWithDifferentName)",
            [ filter2 ],
            
      function( M )
        
        if prop[2]( get_remote_object( M ) ) then
            return true;
        fi;
        
        TryNextMethod();
        
    end );
    
end );

##
InstallGlobalFunction( InstallImmediateMethodToPullTrueProperties,
  function( filter1, filter2, PROP, triggers, get_remote_object )
    local trigger, prop;
    
    for trigger in triggers do
        
        for prop in PROP do
            
            if IsString( prop ) then
                
                if prop <> trigger then
                    InstallImmediateMethodToPullTrueProperty(
                            filter1,
                            filter2,
                            ValueGlobal( prop ),
                            ValueGlobal( trigger ),
                            get_remote_object
                            );
                fi;
                
            elif IsList( prop ) and Length( prop ) = 2 and
              IsString( prop[1] ) and IsList( prop[2] ) and IsString( prop[2][1] ) then
                
                if prop[1] <> trigger then
                    InstallImmediateMethodToConditionallyPullTrueProperty(
                            filter1,
                            filter2,
                            ValueGlobal( prop[1] ),
                            ValueGlobal( prop[2][1] ),
                            ValueGlobal( trigger ),
                            get_remote_object
                            );
                fi;
                
            elif IsList( prop ) and Length( prop ) = 2 and ForAll( prop, IsString ) then
                
                if prop[1] <> trigger then
                    InstallImmediateMethodToPullTruePropertyWithDifferentName(
                            filter1,
                            filter2,
                            List( prop, ValueGlobal ),
                            ValueGlobal( trigger ),
                            get_remote_object
                            );
                fi;
                
            fi;
            
        od;
        
    od;
    
end );

##
InstallGlobalFunction( InstallImmediateMethodToPullFalseProperty,
  function( filter1, filter2, prop, trigger, get_remote_object );
    
    InstallImmediateMethod( prop,
            filter1 and Tester( trigger ), 0,
            
      function( M )
        local U;
        
        U := get_remote_object( M );
        
        if Tester( prop )( U ) and not prop( U ) then
            return false;
        fi;
        
        TryNextMethod();
        
    end );
    
    InstallMethod( prop,
            "for homalg objects with an underlying object (PullFalseProperty)",
            [ filter2 ],
            
      function( M )
        
        if not prop( get_remote_object( M ) ) then
            return false;
        fi;
        
        TryNextMethod();
        
    end );
    
end );

##
InstallGlobalFunction( InstallImmediateMethodToConditionallyPullFalseProperty,
  function( filter1, filter2, prop, condition, trigger, get_remote_object );
    
    InstallImmediateMethod( prop,
            filter1 and Tester( trigger ) and condition, 0,
            
      function( M )
        local U;
        
        U := get_remote_object( M );
        
        if Tester( prop )( U ) and not prop( U ) then
            return false;
        fi;
        
        TryNextMethod();
        
    end );
    
    InstallMethod( prop,
            "for homalg objects with an underlying object (ConditionallyPullFalseProperty)",
            [ filter2 ],
            
      function( M )
        
        if condition( M ) and not prop( get_remote_object( M ) ) then
            return false;
        fi;
        
        TryNextMethod();
        
    end );
    
end );

##
InstallGlobalFunction( InstallImmediateMethodToPullFalsePropertyWithDifferentName,
  function( filter1, filter2, prop, trigger, get_remote_object );
    
    InstallImmediateMethod( prop[1],
            filter1 and Tester( trigger ), 0,
            
      function( M )
        local U;
        
        U := get_remote_object( M );
        
        if Tester( prop[2] )( U ) and not prop[2]( U ) then
            return false;
        fi;
        
        TryNextMethod();
        
    end );
    
    InstallMethod( prop[1],
            "for homalg objects with an underlying object (PullFalsePropertyWithDifferentName)",
            [ filter2 ],
            
      function( M )
        
        if not prop[2]( get_remote_object( M ) ) then
            return false;
        fi;
        
        TryNextMethod();
        
    end );
    
end );

##
InstallGlobalFunction( InstallImmediateMethodToPullFalseProperties,
  function( filter1, filter2, PROP, triggers, get_remote_object )
    local trigger, prop;
    
    for trigger in triggers do
        
        for prop in PROP do
            
            if IsString( prop ) then
                
                if prop <> trigger then
                    InstallImmediateMethodToPullFalseProperty(
                            filter1,
                            filter2,
                            ValueGlobal( prop ),
                            ValueGlobal( trigger ),
                            get_remote_object
                            );
                fi;
                
            elif IsList( prop ) and Length( prop ) = 2 and
              IsString( prop[1] ) and IsList( prop[2] ) and IsString( prop[2][1] ) then
                
                if prop[1] <> trigger then
                    InstallImmediateMethodToConditionallyPullFalseProperty(
                            filter1,
                            filter2,
                            ValueGlobal( prop[1] ),
                            ValueGlobal( prop[2][1] ),
                            ValueGlobal( trigger ),
                            get_remote_object
                            );
                fi;
                
            elif IsList( prop ) and Length( prop ) = 2 and ForAll( prop, IsString ) then
                
                if prop[1] <> trigger then
                    InstallImmediateMethodToPullFalsePropertyWithDifferentName(
                            filter1,
                            filter2,
                            List( prop, ValueGlobal ),
                            ValueGlobal( trigger ),
                            get_remote_object
                            );
                fi;
                
            fi;
            
        od;
        
    od;
    
end );

##
InstallGlobalFunction( InstallImmediateMethodToPushPropertyOrAttribute,
  function( twitter, filter, prop_attr, get_remote_object )
    
    InstallImmediateMethod( twitter,
            filter and Tester( prop_attr ), 0,
            
      function( M )
        
        Setter( prop_attr )( get_remote_object( M ), prop_attr( M ) );
        
        TryNextMethod( );
        
    end );
    
end );

##
InstallGlobalFunction( InstallImmediateMethodToConditionallyPushPropertyOrAttribute,
  function( twitter, filter, prop_attr, condition, get_remote_object )
    
    InstallImmediateMethod( twitter,
            filter and Tester( prop_attr ) and condition, 0,
            
      function( M )
        
        Setter( prop_attr )( get_remote_object( M ), prop_attr( M ) );
        
        TryNextMethod( );
        
    end );
    
end );

##
InstallGlobalFunction( InstallImmediateMethodToPushPropertyOrAttributeWithDifferentName,
  function( twitter, filter, prop_attr, get_remote_object )
    
    InstallImmediateMethod( twitter,
            filter and Tester( prop_attr[1] ), 0,
            
      function( M )
        
        Setter( prop_attr[2] )( get_remote_object( M ), prop_attr[1]( M ) );
        
        TryNextMethod( );
        
    end );
    
end );

##
InstallGlobalFunction( InstallImmediateMethodToPushPropertiesOrAttributes,
  function( twitter, filter, PROP_ATTR, get_remote_object )
    local prop_attr;
    
    for prop_attr in PROP_ATTR do
        if IsString( prop_attr ) then
            
            InstallImmediateMethodToPushPropertyOrAttribute(
                    twitter,
                    filter,
                    ValueGlobal( prop_attr ),
                    get_remote_object
                    );
            
        elif IsList( prop_attr ) and Length( prop_attr ) = 2 and
          IsString( prop_attr[1] ) and IsList( prop_attr[2] ) and IsString( prop_attr[2][1] ) then
            
            InstallImmediateMethodToConditionallyPushPropertyOrAttribute(
                    twitter,
                    filter,
                    ValueGlobal( prop_attr[1] ),
                    ValueGlobal( prop_attr[2][1] ),
                    get_remote_object
                    );
            
        elif IsList( prop_attr ) and Length( prop_attr ) = 2 and ForAll( prop_attr, IsString ) then
            
            InstallImmediateMethodToPushPropertyOrAttributeWithDifferentName(
                    twitter,
                    filter,
                    List( prop_attr, ValueGlobal ),
                    get_remote_object
                    );
            
        fi;
        
    od;
    
end );

##
InstallGlobalFunction( InstallImmediateMethodToPushTrueProperty,
  function( twitter, filter, prop, get_remote_object )
    
    InstallImmediateMethod( twitter,
            filter and prop, 0,
            
      function( M )
        
        Setter( prop )( get_remote_object( M ), true );
        
        TryNextMethod( );
        
    end );
    
end );

##
InstallGlobalFunction( InstallImmediateMethodToPushTruePropertyWithDifferentName,
  function( twitter, filter, prop, get_remote_object )
    
    InstallImmediateMethod( twitter,
            filter and prop[1], 0,
            
      function( M )
        
        Setter( prop[2] )( get_remote_object( M ), true );
        
        TryNextMethod( );
        
    end );
    
end );

##
InstallGlobalFunction( InstallImmediateMethodToPushTrueProperties,
  function( twitter, filter, PROP, get_remote_object )
    local prop;
    
    for prop in PROP do
        if IsString( prop ) then
            
            InstallImmediateMethodToPushTrueProperty(
                    twitter, filter, ValueGlobal( prop ), get_remote_object
                    );
            
        elif IsList( prop ) and Length( prop ) = 2 and ForAll( prop, IsString ) then
            
            InstallImmediateMethodToPushTruePropertyWithDifferentName(
                    twitter, filter, List( prop, ValueGlobal ), get_remote_object
                    );
            
        fi;
        
    od;
    
end );

##
InstallGlobalFunction( InstallImmediateMethodToPushFalseProperty,
  function( twitter, filter, prop, get_remote_object )
    
    InstallImmediateMethod( twitter,
            filter and Tester( prop ), 0,
            
      function( M )
        
        if not prop( M ) then
            Setter( prop )( get_remote_object( M ), false );
        fi;
        
        TryNextMethod( );
        
    end );
    
end );

##
InstallGlobalFunction( InstallImmediateMethodToPushFalsePropertyWithDifferentName,
  function( twitter, filter, prop, get_remote_object )
    
    InstallImmediateMethod( twitter,
            filter and Tester( prop[1] ), 0,
            
      function( M )
        
        if not prop[1]( M ) then
            Setter( prop[2] )( get_remote_object( M ), false );
        fi;
        
        TryNextMethod( );
        
    end );
    
end );

##
InstallGlobalFunction( InstallImmediateMethodToPushFalseProperties,
  function( twitter, filter, PROP, get_remote_object )
    local prop;
    
    for prop in PROP do
        if IsString( prop ) then
            
            InstallImmediateMethodToPushFalseProperty(
                    twitter, filter, ValueGlobal( prop ), get_remote_object
                    );
            
        elif IsList( prop ) and Length( prop ) = 2 and ForAll( prop, IsString ) then
            
            InstallImmediateMethodToPushFalsePropertyWithDifferentName(
                    twitter, filter, List( prop, ValueGlobal ), get_remote_object
                    );
            
        fi;
        
    od;
    
end );

# This function declares an attribute, but does not install the standard getter.
# instead, a getter given as third argument is installed.
# the primary use of this method is for morphism aids: we are able to set lazy
# morphism aids and compute them by the getter.
##
InstallGlobalFunction( DeclareAttributeWithCustomGetter,
  function ( arg )
    local  attr, name, custom_getter, nname, gvar, pos, filter;
    name := arg[1];
    custom_getter := arg[3];
    if ISB_GVAR( name )  then
        Error( "expected a name not bound" );
    else
        attr := CALL_FUNC_LIST( NewAttribute, arg );
        BIND_GLOBAL( name, custom_getter );
        nname := "Set";
        APPEND_LIST_INTR( nname, name );
        BIND_GLOBAL( nname, SETTER_FILTER( attr ) );
        nname := "Has";
        APPEND_LIST_INTR( nname, name );
        BIND_GLOBAL( nname, TESTER_FILTER( attr ) );
    fi;
    return;
end );

##
InstallGlobalFunction( AppendToAhomalgTable,
  function( RP, RP_addon )
    local component;
    
    for component in NamesOfComponents( RP_addon ) do
        RP!.(component) := RP_addon.(component);
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
InstallGlobalFunction( IncreaseExistingCounterInObject,
  function( o, component )
    
    o!.(component) := o!.(component) + 1;
    
end );

InstallGlobalFunction( IncreaseExistingCounterInObjectWithTiming,
  function( o, component, t )
    
    o!.(component) := o!.(component) + [ 1, t ];
    
end );

##
InstallGlobalFunction( IncreaseCounterInObject,
  function( o, component )
    
    if IsBound( o!.(component) ) then
        o!.(component) := o!.(component) + 1;
    else
        o!.(component) := 1;
    fi;
    
end );

##
InstallGlobalFunction( MemoryToString,
  function( memory )
    local m;
    
    m := memory;
    
    if m < 1024 then
        return Concatenation( String( m ), " Bytes" );
    fi;
    
    m := Float( m / 1024 );
    
    if m < 1024 then
        return Concatenation( String( m ), " KB" );
    fi;
    
    m := Float( m / 1024 );
    
    if m < 1024 then
        return Concatenation( String( m ), " MB" );
    fi;
    
    m := Float( m / 1024 );
    
    if m < 1024 then
        return Concatenation( String( m ), " GB" );
    fi;
    
    m := Float( m / 1024 );
    
    return Concatenation( String( m ), " TB" );
    
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

##
InstallMethod( ExamplesForHomalg,
        [ IsInt ], 0,
        
  function( d )
    
    if LoadPackage( "ExamplesForHomalg" ) = true then
        ExamplesForHomalg( d );
    else
        return fail;
    fi;
    
end );

##
InstallMethod( UpdateContainerOfWeakPointers,
        "for containers of weak pointer lists",
        [ IsContainerForWeakPointersRep ],
        
  function( container )
    local weak_pointers, l, active, l_active, i;
    
    weak_pointers := container!.weak_pointers;
    
    l := LengthWPObj( weak_pointers );
    
    active := Filtered( container!.active, i -> i <= l );
    
    l_active := Length( active );
    
    i := 1;
    
    while i <= l_active do
        if ElmWPObj( weak_pointers, active[i] ) <> fail then
            i := i + 1;
        else	## active[i] is no longer active
            Remove( active, i );
            l_active := l_active - 1;
        fi;
    od;
    
    ## UpdateContainerOfWeakPointers is only called
    ## from view and display methods, which we do not want
    ## to count as accesses:
    # container!.accessed := container!.accessed + 1;
    
    container!.active := active;
    container!.deleted := Difference( [ 1 .. l ], active );
    
end );

##
InstallMethod( UpdateContainerOfWeakPointers,
        "for containers of weak pointer lists",
        [ IsContainerForWeakPointersOnComputedValuesRep ],
        
  function( container )
    local weak_pointers, weak_pointers_on_values, l, active, l_active, i;
    
    weak_pointers := container!.weak_pointers;
    weak_pointers_on_values := container!.weak_pointers_on_values;
    
    l := Minimum( LengthWPObj( weak_pointers ), LengthWPObj( weak_pointers_on_values ) );
    
    active := Filtered( container!.active, i -> i <= l );
    
    l_active := Length( active );
    
    i := 1;
    
    while i <= l_active do
        if ElmWPObj( weak_pointers, active[i] ) <> fail and
           ElmWPObj( weak_pointers_on_values, active[i] ) <> fail then
            i := i + 1;
        else	## active[i] is no longer active
            Remove( active, i );
            l_active := l_active - 1;
        fi;
    od;
    
    ## UpdateContainerOfWeakPointers is only called
    ## from view and display methods, which we do not want
    ## to count as accesses:
    # container!.accessed := container!.accessed + 1;
    
    container!.active := active;
    container!.deleted := Difference( [ 1 .. l ], active );
    
end );

##
InstallGlobalFunction( _AddElmWPObj_ForHomalg,
  function( container, obj )
    local weak_pointers, l, deleted, active, l_active, d;
    
    weak_pointers := container!.weak_pointers;
    
    l := LengthWPObj( weak_pointers );
    
    deleted := Filtered( container!.deleted, i -> i <= l );
    active := Filtered( container!.active, i -> i <= l );
    
    ## check assertion
    Assert( 10,
            Intersection2( deleted, active ) = [ ] and
            Union2( deleted, active ) = [ 1 .. l ] );
    
    l_active := Length( active );
    
    if deleted = [ ] then
        SetElmWPObj( weak_pointers, l_active + 1, obj );
        Add( active, l_active + 1 );
        l := l + 1;
    else
        d := deleted[1];
        SetElmWPObj( weak_pointers, d, obj );
        Remove( deleted, 1 );
        Add( active, d, d );
    fi;
    
    container!.deleted := deleted;
    container!.active := active;
    
    ## here we increase container!.counter instead of container!.accessed;
    container!.counter := container!.counter + 1;
    
end );

##
InstallGlobalFunction( _AddTwoElmWPObj_ForHomalg,
  function( container, ref, value )
    local weak_pointers, weak_pointers_on_values, l, deleted, active, l_active, d;
    
    weak_pointers := container!.weak_pointers;
    weak_pointers_on_values := container!.weak_pointers_on_values;
    
    l := Minimum( LengthWPObj( weak_pointers ), LengthWPObj( weak_pointers_on_values ) );
    
    deleted := Filtered( container!.deleted, i -> i <= l );
    active := Filtered( container!.active, i -> i <= l );
    
    ## check assertion
    Assert( 10,
            Intersection2( deleted, active ) = [ ] and
            Union2( deleted, active ) = [ 1 .. l ] );
    
    l_active := Length( active );
    
    if deleted = [ ] then
        SetElmWPObj( weak_pointers, l_active + 1, ref );
        SetElmWPObj( weak_pointers_on_values, l_active + 1, value );
        Add( active, l_active + 1 );
        l := l + 1;
    else
        d := deleted[1];
        SetElmWPObj( weak_pointers, d, ref );
        SetElmWPObj( weak_pointers_on_values, d, value );
        Remove( deleted, 1 );
        Add( active, d, d );
    fi;
    
    container!.deleted := deleted;
    container!.active := active;
    
    ## here we increase container!.counter instead of container!.accessed;
    container!.counter := container!.counter + 1;
    
end );

##
InstallMethod( _ElmWPObj_ForHomalg,
        "for a container of weak pointer lists and two objects (a reference and a return fail value)",
        [ IsContainerForWeakPointersOnComputedValuesRep, IsObject, IsObject ], 0,
        
  function( container, obj, FAIL )
    local weak_pointers, weak_pointers_on_values, l, active, cache_hit, l_active, i, ref, value;
    
    weak_pointers := container!.weak_pointers;
    weak_pointers_on_values := container!.weak_pointers_on_values;
    
    l := Minimum( LengthWPObj( weak_pointers ), LengthWPObj( weak_pointers_on_values ) );
    
    active := Filtered( container!.active, i -> i <= l );
    
    cache_hit := false;
    
    l_active := Length( active );
    
    i := 1;
    
    while i <= l_active do
        value := ElmWPObj( weak_pointers_on_values, active[i] );
        if value <> fail then
            ref := ElmWPObj( weak_pointers, active[i] );
            if ref <> fail then
                if IsIdenticalObj( ref, obj ) then
                    cache_hit := true;
                    break;
                fi;
                i := i + 1;
            else	## active[i] is no longer active
                Remove( active, i );
                l_active := l_active - 1;
            fi;
        else	## active[i] is no longer active
            Remove( active, i );
            l_active := l_active - 1;
        fi;
    od;
    
    container!.active := active;
    container!.deleted := Difference( [ 1 .. l ], active );
    
    container!.accessed := container!.accessed + 1;
    container!.cache_misses := container!.cache_misses + i - 1;
    
    if cache_hit then
        container!.cache_hits := container!.cache_hits + 1;
        return value;
    fi;
    
    return FAIL;
    
end );

####################################
#
# View, Print, and Display methods:
#
####################################

##
InstallMethod( ViewObj,
        "for weak pointer containers of objects",
        [ IsContainerForWeakPointersOnObjectsRep ],
        
  function( o )
    local a;
    
    UpdateContainerOfWeakPointers( o );
    
    a := Length( o!.active );
    
    Print( "<A container for weak pointers " );
    
    if IsBound( o!.operation ) then
        Print( "on computed values of ", o!.operation );
    else
        Print( "on objects" );
    fi;
    
    Print( ": active = ", a, ", deleted = ", o!.counter - a, ", counter = ", o!.counter, ", accessed = ", o!.accessed, ", cache_misses = ", o!.cache_misses, ", cache_hits = ", o!.cache_hits, ">" );
    
end );

##
InstallMethod( ViewObj,
        "for weak pointer containers of containers",
        [ IsContainerForWeakPointersOnContainersRep ],
        
  function( o )
    local a;
    
    UpdateContainerOfWeakPointers( o );
    
    a := Length( o!.active );
    
    Print( "<A container for weak pointers on containers: active = ", a, ", deleted = ", o!.counter - a, ", counter = ", o!.counter, ">" );
    
end );

##
InstallMethod( Display,
        "for weak pointer containers of objects",
        [ IsContainerForWeakPointersOnObjectsRep ],
        
  function( o )
    local weak_pointers;
    
    weak_pointers := o!.weak_pointers;
    
    Print( List( [ 1 .. LengthWPObj( weak_pointers ) ], function( i ) if IsBoundElmWPObj( weak_pointers, i ) then return i; else return 0; fi; end ), "\n" );
    
end );

##
InstallMethod( Display,
        "for weak pointer containers of containers",
        [ IsContainerForWeakPointersOnContainersRep ],
        
  function( o )
    local weak_pointers, a, obj;
    
    UpdateContainerOfWeakPointers( o );
    
    weak_pointers := o!.weak_pointers;
    
    for a in o!.active do
        obj := ElmWPObj( weak_pointers, a );
        if obj <> fail and
           ( not IsBound( obj!.counter ) or obj!.counter <> 0 ) then
            Print( a, ":\t" );
            ViewObj( obj );
            Print( "\n" );
        fi;
    od;
    
end );

##
InstallMethod( Display,
        "for weak pointer containers of containers",
        [ IsContainerForWeakPointersOnContainersRep, IsString ],
        
  function( o, string )
    local weak_pointers, a, obj;
    
    string := LowercaseString( string );
    
    if string = "a" or string = "all" then
        
        UpdateContainerOfWeakPointers( o );
        
        weak_pointers := o!.weak_pointers;
        
        for a in o!.active do
            obj := ElmWPObj( weak_pointers, a );
            if obj <> fail then
                Print( a, ":\t" );
                ViewObj( obj );
                Print( "\n" );
            fi;
        od;
        
    else
        
        Display( o );
        
    fi;
    
end );

####################################
#
# ContainerForPointers
#
####################################

# a new family:
BindGlobal( "TheFamilyOfContainersForPointers",
        NewFamily( "TheFamilyOfContainersForPointers" ) );

# a new type:
BindGlobal( "TheTypeContainerForPointers",
        NewType( TheFamilyOfContainersForPointers,
                IsContainerForPointersRep ) );

# a new type:
BindGlobal( "TheTypeContainerForPointersOnObjects",
        NewType( TheFamilyOfContainersForPointers,
                IsContainerForPointersOnObjectsRep ) );

# a new type:
BindGlobal( "TheTypeContainerForPointersOnComputedValues",
        NewType( TheFamilyOfContainersForPointers,
                IsContainerForPointersOnComputedValuesRep ) );

# a new type:
BindGlobal( "TheTypeContainerForPointersOnContainers",
        NewType( TheFamilyOfContainersForPointers,
                IsContainerForPointersOnContainersRep ) );

##
InstallGlobalFunction( ContainerForPointers,
  function( arg )
    local nargs, container, component, type, containers;
    
    nargs := Length( arg );
    
    container := rec( pointers :=  [ ],
                      counter := 0,
                      accessed := 0,
                      cache_hits := 0,
                      cache_misses := 0 );
    
    for component in arg{[ 2 .. nargs ]} do
        container.( component[1] ) := component[2];
    od;
    
    type := arg[1];
    
    ## Objectify:
    Objectify( type, container );
    
    if IsBound( HOMALG_TOOLS.ContainersForPointers ) then
        _AddElmPObj_ForHomalg( HOMALG_TOOLS.ContainersForPointers, container );
    fi;
    
    if IsContainerForPointersOnComputedValuesRep( container ) then
        container!.pointers_on_values := [ ];
    fi;
    
    return container;
    
end );

HOMALG_TOOLS.ContainersForPointers := ContainerForPointers( TheTypeContainerForPointersOnContainers );
Unbind( HOMALG_TOOLS.ContainersForPointers!.accessed );

##
InstallGlobalFunction( _AddElmPObj_ForHomalg,
  function( container, obj )
    
    Add( container!.pointers, obj );
    
    ## here we increase container!.counter instead of container!.accessed;
    container!.counter := container!.counter + 1;
    
end );

##
InstallGlobalFunction( _AddTwoElmPObj_ForHomalg,
  function( container, ref, value )
    
    Add( container!.pointers, ref );
    Add( container!.pointers_on_values, value );
    
    ## here we increase container!.counter instead of container!.accessed;
    container!.counter := container!.counter + 1;
    
end );

##
InstallMethod( _ElmPObj_ForHomalg,
        "for a container of weak pointer lists and two objects (a reference and a return fail value)",
        [ IsContainerForPointersOnComputedValuesRep, IsObject, IsObject ], 0,
        
  function( container, obj, FAIL )
    local pointers, pointers_on_values, l, cache_hit, i;
    
    pointers := container!.pointers;
    
    pointers_on_values := container!.pointers_on_values;
    
    l := Length( pointers );
    
    i := 1;
    
    cache_hit := false;
    
    while i <= l do
        
        if IsIdenticalObj( pointers[ i ], obj ) then
            
            cache_hit := true;
            
            break;
            
        fi;
        
        i := i + 1;
        
    od;
    
    container!.accessed := container!.accessed + 1;
    container!.cache_misses := container!.cache_misses + i - 1;
    
    if cache_hit then
        container!.cache_hits := container!.cache_hits + 1;
        return pointers_on_values[ i ];
    fi;
    
    return FAIL;
    
end );

####################################
#
# View, Print, and Display methods:
#
####################################

##
InstallMethod( ViewObj,
        "for pointer containers of objects",
        [ IsContainerForPointersOnObjectsRep ],
        
  function( o )
    local a;
    
    a := Length( o!.pointers );
    
    Print( "<A container for pointers " );
    
    if IsBound( o!.operation ) then
        Print( "on computed values of ", o!.operation );
    else
        Print( "on objects" );
    fi;
    
    Print( ": active = ", a, ", counter = ", o!.counter, ", accessed = ", o!.accessed, ", cache_misses = ", o!.cache_misses, ", cache_hits = ", o!.cache_hits, ">" );
    
end );

##
InstallMethod( ViewObj,
        "for pointer containers of containers",
        [ IsContainerForPointersOnContainersRep ],
        
  function( o )
    local a;
    
    a := Length( o!.pointers );
    
    Print( "<A container for weak pointers on containers: active = ", a, ", counter = ", o!.counter, ">" );
    
end );

##
InstallMethod( Display,
        "for pointer containers of objects",
        [ IsContainerForPointersOnObjectsRep ],
        
  function( o )
    
    Print( o!.pointers, "\n" );
    
end );

##
InstallMethod( Display,
        "for pointer containers of containers",
        [ IsContainerForPointersOnContainersRep ],
        
  function( o )
    local a, pointers;
    
    pointers := o!.pointers;
    
    for a in [ 1 .. Length( pointers ) ] do
        
        Print( a, ":\t" );
        
        ViewObj( pointers[ a ] );
        
        Print( "\n" );
        
    od;
    
end );

##
InstallMethod( Display,
        "for pointer containers of containers",
        [ IsContainerForPointersOnContainersRep, IsString ],
        
  function( o, string )
    
    Display( o );
    
end );
