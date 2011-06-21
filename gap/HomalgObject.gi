#############################################################################
##
##  HomalgObject.gi             homalg package               Mohamed Barakat
##
##  Copyright 2007-2010, Mohamed Barakat, University of Kaiserslautern
##
##  Implementations for objects of (Abelian) categories.
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
##      <C>IsStructureObjectOrFinitelyPresentedObjectRep</C>.)
##    <Listing Type="Code"><![CDATA[
DeclareRepresentation( "IsFinitelyPresentedObjectRep",
        IsHomalgObject and
        IsStructureObjectOrFinitelyPresentedObjectRep,
        [ ] );
##  ]]></Listing>
##    </Description>
##  </ManSection>
##  <#/GAPDoc>

##  <#GAPDoc Label="IsStaticFinitelyPresentedObjectOrSubobjectRep">
##  <ManSection>
##    <Filt Type="Representation" Arg="M" Name="IsStaticFinitelyPresentedObjectOrSubobjectRep"/>
##    <Returns><C>true</C> or <C>false</C></Returns>
##    <Description>
##      The &GAP; representation of finitley presented &homalg; static objects. <P/>
##      (It is a representation of the &GAP; category <Ref Filt="IsHomalgStaticObject"/>.)
##    <Listing Type="Code"><![CDATA[
DeclareRepresentation( "IsStaticFinitelyPresentedObjectOrSubobjectRep",
        IsHomalgStaticObject,
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
##       <C>IsStaticFinitelyPresentedObjectOrSubobjectRep</C> and
##       <C>IsFinitelyPresentedObjectRep</C>.)
##    <Listing Type="Code"><![CDATA[
DeclareRepresentation( "IsStaticFinitelyPresentedObjectRep",
        IsStaticFinitelyPresentedObjectOrSubobjectRep and
        IsFinitelyPresentedObjectRep,
        [ ] );
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
InstallMethod( PositionOfTheDefaultPresentation,
        "for everything (returns fail)",
        [ IsObject ],
  function( a )
    
    return fail;
    
end );

##
InstallMethod( CategoryOfObject,
        "for homalg objects",
        [ IsHomalgObjectOrMorphism ],
        
  function( M )
    
    if IsBound(M!.category) then
        return M!.category;
    fi;
    
    Error( "the component category is not bound\n" );
    
end );

##
InstallMethod( MorphismConstructor,
        "for a homalg object",
        [ IsHomalgObjectOrMorphism ],
        
  function( M )
    local cat;
    
    cat := CategoryOfObject( M );
    
    if IsBound(cat!.MorphismConstructor) then
        return cat!.MorphismConstructor;
    fi;
    
    Error( "the component MorphismConstructor is not bound\n" );
    
end );

##
InstallMethod( MorphismConstructor,
        "for two homalg objects",
        [ IsObject, IsObject ],
        
  function( M, N )
    
    if IsHomalgObjectOrMorphism( M ) then
        return MorphismConstructor( M );
    elif IsHomalgObjectOrMorphism( N ) then
        return MorphismConstructor( N );
    fi;
    
    Error( "neither of the two arguments is a homalg object or a homalg morphism\n" );
    
end );

##
InstallMethod( ShallowCopy,
        "for homalg objects",
        [ IsHomalgObject ],
        
  function( M )
    
    return Source( AnIsomorphism( M ) );
    
end );

##
InstallMethod( FunctorOfGenesis,
        "for a homalg object and an integer",
        [ IsHomalgObject, IsInt ],
        
  function( M, pos )
    local genesis;
    
    if HasGenesis( M ) then
        genesis := Genesis( M );
        if IsList( genesis ) and genesis <> [ ] then
            genesis := genesis[( ( pos - 1 ) mod Length( genesis ) ) + 1];
            if IsList( genesis ) and genesis <> [ ] then
                genesis := genesis[1];
                if IsBound( genesis.Functor ) then
                    return genesis.Functor;
                fi;
            fi;
        fi;
    fi;
    
    return false;
    
end );

##
InstallMethod( FunctorOfGenesis,
        "for a homalg object",
        [ IsHomalgObject ],
        
  function( M )
    
    return FunctorOfGenesis( M, 0 );	## the last functor
    
end );

##
InstallMethod( ArgumentsOfGenesis,
        "for a homalg object and a positive integer",
        [ IsHomalgObject, IsInt ],
        
  function( M, pos )
    local genesis;
    
    if HasGenesis( M ) then
        genesis := Genesis( M );
        if IsList( genesis ) and genesis <> [ ] then
            genesis := genesis[( ( pos - 1 ) mod Length( genesis ) ) + 1];
            if IsList( genesis ) and genesis <> [ ] then
                genesis := genesis[1];
                if IsBound( genesis.arguments_of_functor ) then
                    return genesis.arguments_of_functor;
                fi;
            fi;
        fi;
    fi;
    
    return false;
    
end );

##
InstallMethod( ArgumentsOfGenesis,
        "for a homalg object",
        [ IsHomalgObject ],
        
  function( M )
    
    return ArgumentsOfGenesis( M, 0 );	## the last functor
    
end );
