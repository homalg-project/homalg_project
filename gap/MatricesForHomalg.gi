#############################################################################
##
##  MatricesForHomalg.gi        MatricesForHomalg package    Mohamed Barakat
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
DeclareRepresentation( "IsContainerForWeakPointersOfObjectsRep",
        IsContainerForWeakPointersRep,
        [ "weak_pointers", "active", "deleted", "counter", "cache_hits" ] );

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

# a new family:
BindGlobal( "TheFamilyOfContainersForWeakPointersOfObjects",
        NewFamily( "TheFamilyOfContainersForWeakPointersOfObjects" ) );

# a new type:
BindGlobal( "TheTypeContainerForWeakPointersOfObjects",
        NewType( TheFamilyOfContainersForWeakPointersOfObjects,
                IsContainerForWeakPointersOfObjectsRep ) );

####################################
#
# global variables:
#
####################################

# a central place for configuration variables:

InstallValue( HOMALG_MATRICES,
        rec(
            TotalRuntimes := 0,
            OtherInternalMatrixTypes := [ ],
            
            colors := rec(   ## (B)asic (O)perations:
                             BOE := "\033[1;37;40m",	## reduced (E)chelon form: RowReducedEchelonForm/Columns
                             BOB := "\033[1;37;45m",	## (B)asis: BasisOfRow/ColumnModule
                             BOC := "\033[1;37;45m",	## Basis: BasisOfRows/Columns(C)oeff
                             BOD := "\033[1;37;42m",	## existence of a particular solution: (D)ecideZeroRows/Columns
                             BOP := "\033[1;37;42m",	## (P)articular solution: DecideZeroRows/Columns(Effectively)
                             BOH := "\033[1;37;41m",	## solutions of the (H)omogeneous system: SyzygiesGeneratorsOfRows/Columns
                             busy := "\033[01m\033[4;31;40m",
                             done := "\033[01m\033[4;32;40m",
                             ),
            
            matrix_logic_infolevels := [ InfoCOLEM, InfoLIMAT ],
            
            color_display := false,
            
            PreferDenseMatrices := false,
            
            ByASmallerPresentationDoesNotDecideZero := false,
            
            Intersect_uses_ReducedBasisOfModule := true,
            
            SubQuotient_uses_Intersect := false,
            
            MaximumNumberOfResolutionSteps := 1001,
            
            RandomSource := GlobalMersenneTwister,
            
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
                      active := [ ],
                      deleted := [ ],
                      counter := 0,
                      cache_hits := 0 );
    
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
    
    HOMALG_MATRICES.TotalRuntimes := r.user_time;
    
    if IsBound( r.system_time ) and r.system_time <> fail then
        HOMALG_MATRICES.TotalRuntimes := HOMALG_MATRICES.TotalRuntimes + r.system_time;
    fi;
    
    if IsBound( r.user_time_children ) and r.user_time_children <> fail then
        HOMALG_MATRICES.TotalRuntimes := HOMALG_MATRICES.TotalRuntimes + r.user_time_children;
    fi;
    
    if IsBound( r.system_time_children ) and r.system_time_children <> fail then
        HOMALG_MATRICES.TotalRuntimes := HOMALG_MATRICES.TotalRuntimes + r.system_time_children;
    fi;
    
    if Length( arg ) = 0 then
        return HOMALG_MATRICES.TotalRuntimes;
    fi;
    
    return Concatenation( StringTime( HOMALG_MATRICES.TotalRuntimes - arg[1] ), " h" );
    
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
    for p in propertiesS do	## also check if properties already set for both modules coincide
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
    
    ## also check if properties already set for both modules coincide
    
    ## by now, more attributes than the union might be konwn
    attributesS := Intersection2( KnownAttributesOfObject( S ), attributes );
    attributesT := Intersection2( KnownAttributesOfObject( T ), attributes );
    
    for a in Intersection2( attributesS, attributesT ) do
        if ValueGlobal( a )( S ) <> ValueGlobal( a )( T ) then
            Error( "the attribute ", a, " has different values for source and target modules\n" );
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
            "for homalg objects with an underlying object",
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
            "for homalg objects with an underlying object",
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
            "for homalg objects with an underlying object",
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
                    twitter, filter, ValueGlobal( prop_attr ), get_remote_object
                    );
            
        elif IsList( prop_attr ) and Length( prop_attr ) = 2 and ForAll( prop_attr, IsString ) then
            
            InstallImmediateMethodToPushPropertyOrAttributeWithDifferentName(
                    twitter, filter, List( prop_attr, ValueGlobal ), get_remote_object
                    );
            
        fi;
        
    od;
    
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

##  <#GAPDoc Label="homalgMode">
##  <ManSection>
##    <Meth Arg="str[, str2]" Name="homalgMode"/>
##    <Description>
##      This function sets different modes which influence how much of the basic matrix operations and
##      the logical matrix methods become visible (&see; Appendices <Ref Chap="Basic_Operations"/>, <Ref Chap="Logic"/>).
##      Handling the string <A>str</A> is <E>not</E> case-sensitive.
##      If a second string <A>str2</A> is given, then <C>homalgMode</C>( <A>str2</A> ) is invoked at the end.
##      In case you let &homalg; delegate matrix operations to an external system the you might also want to
##      check <C>homalgIOMode</C> in the &HomalgToCAS; package manual.
##      <Table Align="l|c|l">
##      <Row>
##        <Item><A>str</A></Item>
##        <Item><A>str</A> (long form)</Item>
##        <Item>mode description</Item>
##      </Row>
##      <HorLine/>
##      <Row><Item></Item><Item></Item><Item></Item></Row>
##      <Row>
##        <Item>""</Item>
##        <Item>""</Item>
##        <Item>the default mode, i.e. the computation protocol won't be visible</Item>
##      </Row>
##      <Row>
##        <Item></Item>
##        <Item></Item>
##        <Item>(<C>homalgMode</C>( ) is a short form for <C>homalgMode</C>( "" ))</Item>
##      </Row>
##      <Row><Item></Item><Item></Item><Item></Item></Row>
##      <Row>
##        <Item>"b"</Item>
##        <Item>"basic"</Item>
##        <Item>make the basic matrix operations visible + <C>homalgMode</C>( "logic" )</Item>
##      </Row>
##      <Row><Item></Item><Item></Item><Item></Item></Row>
##      <Row>
##        <Item>"d"</Item>
##        <Item>"debug"</Item>
##        <Item>same as "basic" but also makes <C>Row/ColumnReducedEchelonForm</C> visible</Item>
##      </Row>
##      <Row><Item></Item><Item></Item><Item></Item></Row>
##      <Row>
##        <Item>"l"</Item>
##        <Item>"logic"</Item>
##        <Item>make the logical methods in &LIMAT; and &COLEM; visible</Item>
##      </Row>
##      <Row><Item></Item><Item></Item><Item></Item></Row>
##      <HorLine/>
##      </Table>
##      All modes other than the "default"-mode only set their specific values and leave
##      the other values untouched, which allows combining them to some extent. This also means that
##      in order to get from one mode to a new mode (without the aim to combine them)
##      one needs to reset to the "default"-mode first. This can be done using <C>homalgMode</C>( "", new_mode );
##      <Listing Type="Code"><![CDATA[
InstallGlobalFunction( homalgMode,
  function( arg )
    local nargs, mode, s;
    
    nargs := Length( arg );
    
    if nargs = 0 or ( IsString( arg[1] ) and arg[1] = "" ) then
        mode := "default";
    elif IsString( arg[1] ) then	## now we know, the string is not empty
        s := arg[1];
        if LowercaseString( s{[1]} ) = "b" then
            mode := "basic";
        elif LowercaseString( s{[1]} ) = "d" then
            mode := "debug";
        elif LowercaseString( s{[1]} ) = "l" then
            mode := "logic";
        else
            mode := "";
        fi;
    else
        Error( "the first argument must be a string\n" );
    fi;
    
    if mode = "default" then
        HOMALG_MATRICES.color_display := false;
        for s in HOMALG_MATRICES.matrix_logic_infolevels do
            SetInfoLevel( s, 1 );
        od;
        SetInfoLevel( InfoHomalgBasicOperations, 1 );
    elif mode = "basic" then
        SetInfoLevel( InfoHomalgBasicOperations, 3 );
        homalgMode( "logic" );
    elif mode = "debug" then
        SetInfoLevel( InfoHomalgBasicOperations, 4 );
        homalgMode( "logic" );
    elif mode = "logic" then
        HOMALG_MATRICES.color_display := true;
        for s in HOMALG_MATRICES.matrix_logic_infolevels do
            SetInfoLevel( s, 2 );
        od;
    fi;
    
    if nargs > 1 and IsString( arg[2] ) then
        homalgMode( arg[2] );
    fi;
    
end );
##  ]]></Listing>
##    </Description>
##  </ManSection>
##  <#/GAPDoc>

##
InstallGlobalFunction( IncreaseExistingCounterInObject,
  function( o, component )
    
    o!.(component) := o!.(component) + 1;
    
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
    
    container!.active := active;
    container!.deleted := Difference( [ 1 .. l ], active );
    
end );

##
InstallMethod( _AddElmWPObj_ForHomalg,
        [ IsContainerForWeakPointersOfObjectsRep, IsObject ], 0,
        
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
    
    container!.counter := container!.counter + 1;
    
end );

##
InstallMethod( _ElmWPObj_ForHomalg,
        [ IsContainerForWeakPointersOfObjectsRep, IsObject, IsObject ], 0,
        
  function( container, obj, FAIL )
    local weak_pointers, l, active, cache_hit, l_active, i, old;
    
    weak_pointers := container!.weak_pointers;
    
    l := LengthWPObj( weak_pointers );
    
    active := Filtered( container!.active, i -> i <= l );
    
    cache_hit := false;
    
    l_active := Length( active );
    
    i := 1;
    
    while i <= l_active do
        old := ElmWPObj( weak_pointers, active[i] );
        if old <> fail then
            if IsIdenticalObj( old[1], obj ) then
                cache_hit := true;
		break;
            fi;
            i := i + 1;
        else	## active[i] is no l_activeonger active
            Remove( active, i );
            l_active := l_active - 1;
        fi;
    od;
    
    container!.active := active;
    container!.deleted := Difference( [ 1 .. l ], active );
    
    if cache_hit then
        container!.cache_hits := container!.cache_hits + 1;
        return old[2];
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
        "for weak pointer containers of matrices",
        [ IsContainerForWeakPointersOfObjectsRep ],
        
  function( o )
    local a;
    
    UpdateContainerOfWeakPointers( o );
    
    a := Length( o!.active );
    
    Print( "<A container for weak pointers on objects: active = ", a, ", deleted = ", o!.counter - a, ">" );
    
end );

##
InstallMethod( Display,
        "for weak pointer containers of matrices",
        [ IsContainerForWeakPointersOfObjectsRep ],
        
  function( o )
    local weak_pointers;
    
    weak_pointers := o!.weak_pointers;
    
    Print( List( [ 1 .. LengthWPObj( weak_pointers ) ], function( i ) if IsBoundElmWPObj( weak_pointers, i ) then return i; else return 0; fi; end ), "\n" );
    
end );
