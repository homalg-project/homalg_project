#############################################################################
##
##  homalg.gi                   MatricesForHomalg package    Mohamed Barakat
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

##  <#GAPDoc Label="IsHomalgRingOrFinitelyPresentedObjectRep">
##  <ManSection>
##    <Filt Type="Representation" Arg="M" Name="IsHomalgRingOrFinitelyPresentedObjectRep"/>
##    <Returns><C>true</C> or <C>false</C></Returns>
##    <Description>
##      The &GAP; representation of finitley generated &homalg; objects. <P/>
##      It is a representation of the &GAP; category <Ref Filt="IsHomalgObject"/>.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareRepresentation( "IsHomalgRingOrFinitelyPresentedObjectRep",
        IsHomalgRingOrObject,
        [ ] );

# a new representation for the GAP-category IsHomalgObject
# which is a subrepresentation of the representation IsHomalgRingOrFinitelyPresentedObjectRep and IsHomalgRingOrModule:
DeclareRepresentation( "IsHomalgRingOrFinitelyPresentedModuleRep",
        IsHomalgRingOrFinitelyPresentedObjectRep and
        IsHomalgRingOrModule,
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

InstallValue( HOMALG_MATRICES,
        rec(
            TotalRuntimes := 0,
            OtherInternalMatrixTypes := [ ],
            
            color_BOE := "\033[1;37;40m",		## reduced (E)chelon form: RowReducedEchelonForm/Columns
            color_BOB := "\033[1;37;45m",		## (B)asis: BasisOfRow/ColumnModule
            color_BOC := "\033[1;37;45m",		## Basis: BasisOfRows/Columns(C)oeff
            color_BOD := "\033[1;37;42m",		## existence of a particular solution: (D)ecideZeroRows/Columns
            color_BOP := "\033[1;37;42m",		## (P)articular solution: DecideZeroRows/Columns(Effectively)
            color_BOH := "\033[1;37;41m",		## solutions of the (H)omogeneous system: SyzygiesGeneratorsOfRows/Columns
            color_busy := "\033[01m\033[4;31;40m",
            color_done := "\033[01m\033[4;32;40m",
            
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
                      counter := 0,
                      deleted := [ ],
                      ring_creation_numbers := [ ] );
    
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
  function( S, T, properties, attributes )
    local propertiesS, propertiesT, attributesS, attributesT, p, a;
    
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
    
end );

##
InstallGlobalFunction( AddToAhomalgTable,
  function( RP, RP_addon )
    local component;
    
    for component in NamesOfComponents( RP_addon ) do
        RP.(component) := RP_addon.(component);
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
        SetInfoLevel( InfoCOLEM, 1 );
        SetInfoLevel( InfoLIMAT, 1 );
        SetInfoLevel( InfoHomalgBasicOperations, 1 );
    elif mode = "basic" then
        SetInfoLevel( InfoHomalgBasicOperations, 3 );
        homalgMode( "logic" );
    elif mode = "debug" then
        SetInfoLevel( InfoHomalgBasicOperations, 4 );
        homalgMode( "logic" );
    elif mode = "logic" then
        HOMALG_MATRICES.color_display := true;
        SetInfoLevel( InfoCOLEM, 2 );
        SetInfoLevel( InfoLIMAT, 2 );
    fi;
    
    if nargs > 1 and IsString( arg[2] ) then
        homalgMode( arg[2] );
    fi;
    
end );
##  ]]></Listing>
##    </Description>
##  </ManSection>
##  <#/GAPDoc>

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

