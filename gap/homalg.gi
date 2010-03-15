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

##  <#GAPDoc Label="IsFinitelyPresentedObjectRep">
##  <ManSection>
##    <Filt Type="Representation" Arg="M" Name="IsFinitelyPresentedObjectRep"/>
##    <Returns><C>true</C> or <C>false</C></Returns>
##    <Description>
##      The &GAP; representation of finitley presented &homalg; objects. <P/>
##      (It is a representation of the &GAP; category <Ref Filt="IsHomalgObject"/>,
##       which is a subrepresentation of the &GAP; representations
##      <C>IsHomalgRingOrFinitelyPresentedObjectRep</C>.)
##    <Listing Type="Code"><![CDATA[
DeclareRepresentation( "IsFinitelyPresentedObjectRep",
        IsHomalgObject and
        IsHomalgRingOrFinitelyPresentedObjectRep,
        [ ] );
##  ]]></Listing>
##    </Description>
##  </ManSection>
##  <#/GAPDoc>

##  <#GAPDoc Label="IsStaticFinitelyPresentedObjectRep">
##  <ManSection>
##    <Filt Type="Representation" Arg="M" Name="IsStaticFinitelyPresentedObjectRep"/>
##    <Returns><C>true</C> or <C>false</C></Returns>
##    <Description>
##      The &GAP; representation of finitley presented &homalg; static objects. <P/>
##      (It is a representation of the &GAP; category <Ref Filt="IsHomalgStaticObject"/>,
##       which is a subrepresentation of the &GAP; representations
##      <C>IsFinitelyPresentedObjectRep</C>.)
##    <Listing Type="Code"><![CDATA[
DeclareRepresentation( "IsStaticFinitelyPresentedObjectRep",
        IsHomalgStaticObject and
        IsFinitelyPresentedObjectRep,
        [ ] );
##  ]]></Listing>
##    </Description>
##  </ManSection>
##  <#/GAPDoc>

##  <#GAPDoc Label="IsStaticFinitelyPresentedSubobjectRep">
##  <ManSection>
##    <Filt Type="Representation" Arg="M" Name="IsStaticFinitelyPresentedSubobjectRep"/>
##    <Returns><C>true</C> or <C>false</C></Returns>
##    <Description>
##      The &GAP; representation of finitley presented &homalg; subobjects of static objects. <P/>
##      (It is a representation of the &GAP; category <Ref Filt="IsHomalgStaticObject"/>,
##       which is a subrepresentation of the &GAP; representations
##      <C>IsFinitelyPresentedObjectRep</C>.)
##    <Listing Type="Code"><![CDATA[
DeclareRepresentation( "IsStaticFinitelyPresentedSubobjectRep",
        IsHomalgStaticObject and
        IsFinitelyPresentedObjectRep,
        [ ] );
##  ]]></Listing>
##    </Description>
##  </ManSection>
##  <#/GAPDoc>

##  <#GAPDoc Label="IsMorphismOfFinitelyGeneratedObjectsRep">
##  <ManSection>
##    <Filt Type="Representation" Arg="phi" Name="IsMorphismOfFinitelyGeneratedObjectsRep"/>
##    <Returns><C>true</C> or <C>false</C></Returns>
##    <Description>
##      The &GAP; representation of morphisms of finitley generated &homalg; objects. <P/>
##      (It is a representation of the &GAP; category <Ref Filt="IsHomalgMorphism"/>.)
##    <Listing Type="Code"><![CDATA[
DeclareRepresentation( "IsMorphismOfFinitelyGeneratedObjectsRep",
        IsHomalgMorphism,
        [ ] );
##  ]]></Listing>
##    </Description>
##  </ManSection>
##  <#/GAPDoc>

##  <#GAPDoc Label="IsStaticMorphismOfFinitelyGeneratedObjectsRep">
##  <ManSection>
##    <Filt Type="Representation" Arg="phi" Name="IsStaticMorphismOfFinitelyGeneratedObjectsRep"/>
##    <Returns><C>true</C> or <C>false</C></Returns>
##    <Description>
##      The &GAP; representation of static morphisms of finitley generated &homalg; static objects. <P/>
##      (It is a representation of the &GAP; category <Ref Filt="IsHomalgStaticMorphism"/>,
##       which is a subrepresentation of the &GAP; representation
##       <Ref Filt="IsMorphismOfFinitelyGeneratedObjectsRep"/>.)
##    <Listing Type="Code"><![CDATA[
DeclareRepresentation( "IsStaticMorphismOfFinitelyGeneratedObjectsRep",
        IsHomalgStaticMorphism and
        IsMorphismOfFinitelyGeneratedObjectsRep,
        [ ] );
##  ]]></Listing>
##    </Description>
##  </ManSection>
##  <#/GAPDoc>

####################################
#
# families and types:
#
####################################

####################################
#
# global variables:
#
####################################

# a central place for configuration variables:

InstallValue( HOMALG,
        rec(
            color_display := false,
            
            ByASmallerPresentationDoesNotDecideZero := false,
            
            Intersect_uses_ReducedBasisOfModule := true,
            
            SubQuotient_uses_Intersect := false,
            
            MaximumNumberOfResolutionSteps := 1001,
            
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
        "LIMOD: for homalg submodules",
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

