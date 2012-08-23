#############################################################################
##
##  HomalgSubobject.gi          homalg package               Mohamed Barakat
##
##  Copyright 2007-2010 Mohamed Barakat, RWTH Aachen
##
##  Implementations for subobjects of objects of (Abelian) categories.
##
#############################################################################

####################################
#
# representations:
#
####################################

##  <#GAPDoc Label="IsStaticFinitelyPresentedSubobjectRep">
##  <ManSection>
##    <Filt Type="Representation" Arg="M" Name="IsStaticFinitelyPresentedSubobjectRep"/>
##    <Returns><C>true</C> or <C>false</C></Returns>
##    <Description>
##      The &GAP; representation of finitley presented &homalg; subobjects of static objects. <P/>
##      (It is a representation of the &GAP; category <Ref Filt="IsHomalgStaticObject"/>,
##       which is a subrepresentation of the &GAP; representations
##       <C>IsStaticFinitelyPresentedObjectOrSubobjectRep</C> and
##       <C>IsFinitelyPresentedObjectRep</C>.)
##    <Listing Type="Code"><![CDATA[
DeclareRepresentation( "IsStaticFinitelyPresentedSubobjectRep",
        IsStaticFinitelyPresentedObjectOrSubobjectRep and
        IsFinitelyPresentedObjectRep,
        [ ] );
##  ]]></Listing>
##    </Description>
##  </ManSection>
##  <#/GAPDoc>

####################################
#
# methods for attributes:
#
####################################

##
InstallMethod( SuperObject,
        "for homalg subobjects",
        [ IsStaticFinitelyPresentedSubobjectRep ],
        
  function( M )
    
    return Range( MorphismHavingSubobjectAsItsImage( M ) );
    
end );

####################################
#
# methods for operations:
#
####################################

##
InstallMethod( MorphismHavingSubobjectAsItsImage,
        "for homalg subobjects",
        [ IsStaticFinitelyPresentedSubobjectRep ],
  function( M )
    
    if HasEmbeddingInSuperObject( M ) then
        return EmbeddingInSuperObject( M );
    fi;
    
    return M!.map_having_subobject_as_its_image;
    
end );

##
InstallMethod( HomalgCategory,
        "for homalg static subobjects",
        [ IsStaticFinitelyPresentedSubobjectRep ],
        
  function( M )
    
    return HomalgCategory( SuperObject( M ) );
    
end );

##  <#GAPDoc Label="UnderlyingObject">
##  <ManSection>
##    <Oper Arg="M" Name="UnderlyingObject" Label="for subobjects"/>
##    <Returns>a &homalg; object</Returns>
##    <Description>
##      In case <A>M</A> was defined as a subobject of some object <M>L</M> the object underlying the subobject <M>M</M> is returned.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
InstallMethod( UnderlyingObject,
        "for homalg subobjects",
        [ IsStaticFinitelyPresentedSubobjectRep ],
        
  function( M )
    
    return Source( EmbeddingInSuperObject( M ) );
    
end );

##
InstallMethod( \=,
        "for homalg subobjects",
        [ IsStaticFinitelyPresentedSubobjectRep, IsStaticFinitelyPresentedSubobjectRep ],
        
  function( J, K )
    
    return IsSubset( J, K ) and IsSubset( K, J );
    
end );

##
InstallMethod( ByASmallerPresentation,
        "for homalg subobjects",
        [ IsStaticFinitelyPresentedSubobjectRep ],
        
  function( M )
    local emb;
    
    emb := EmbeddingInSuperObject( M );
    
    ByASmallerPresentation( Source( emb ) );
    
    DecideZero( emb );
    
    return M;
    
end );

##
InstallMethod( MatchPropertiesAndAttributesOfSubobjectAndUnderlyingObject,
        "for a subobject and its underlying object",
        [ IsStaticFinitelyPresentedSubobjectRep, IsStaticFinitelyPresentedObjectRep ],
        
  function( I, M )
    
    ## we don't check if M is the underlying object of I
    ## to avoid infinite loops as EmbeddingInSuperObject
    ## will be invoked
    if ConstructedAsAnIdeal( I ) then
        
        MatchPropertiesAndAttributes( I, M,
                LIOBJ.intrinsic_properties_shared_with_subobjects_and_ideals,
                LIOBJ.intrinsic_attributes_shared_with_subobjects_and_ideals );
        
    else
        
        MatchPropertiesAndAttributes( I, M,
                LIOBJ.intrinsic_properties_shared_with_subobjects_which_are_not_ideals,
                LIOBJ.intrinsic_attributes_shared_with_subobjects_which_are_not_ideals );
        
    fi;
    
end );

##
InstallMethod( \=,
        "for a homalg subobject and a homalg structure object",
        [ IsStaticFinitelyPresentedSubobjectRep, IsStructureObject ],
        
  function( J, R )
    local equal;
    
    if not IsIdenticalObj( HomalgRing( J ), R ) then
        Error( "the structure object of the subobject and the given structure object are not identical\n" );
    fi;
    
    equal := IsSubset( J, FullSubobject( SuperObject( J ) ) );
    
    if equal then
        SetIsZero( J, IsZero( R ) );
    fi;
    
    return equal;
    
end );

##
InstallMethod( \=,
        "for a homalg structure object and a homalg subobject",
        [ IsStructureObject, IsStaticFinitelyPresentedSubobjectRep ],
        
  function( R, J )
    
    return J = R;
    
end );

##
InstallMethod( IsOne,
        "for a homalg subobject and a homalg structure object",
        [ IsStaticFinitelyPresentedSubobjectRep ],
        
  function( J )
    
    ## the following uses IsSubset in one direction only; see above
    return J = HomalgRing( J );
    
end );

##
InstallMethod( IsSubset,
        "for a homalg subobject and a homalg structure object",
        [ IsStaticFinitelyPresentedSubobjectRep, IsStructureObject ],
        
  function( J, R )
    
    ## the following uses IsSubset in one direction only; see above
    return J = R;
    
end );

####################################
#
# constructor functions and methods:
#
####################################

##
InstallMethod( \*,
        "for homalg subobjects",
        [ IsStructureObject, IsStaticFinitelyPresentedSubobjectRep ], 20001,
        
  function( R, M )
    
    return ImageSubobject( R * MorphismHavingSubobjectAsItsImage( M ) );
    
end );

##  <#GAPDoc Label="Subobject">
##  <ManSection>
##    <Oper Arg="phi" Name="Subobject" Label="constructor for subobjects using morphisms"/>
##    <Returns>a &homalg; subobject</Returns>
##    <Description>
##      A synonym of <Ref Attr="ImageSubobject"/>.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
InstallMethod( Subobject,
        "constructor for homalg subobjects",
        [ IsHomalgStaticMorphism ],
        
  ImageSubobject );

##
InstallMethod( Pullback,
        "for a morphism of structure objects and a static subobject",
        [ IsStructureObjectMorphism, IsStaticFinitelyPresentedSubobjectRep ],
        
  function( phi, I )
    local mor;
    
    mor := MorphismHavingSubobjectAsItsImage( I );
    
    mor := Pullback( phi, mor );
    
    return ImageSubobject( mor );
    
end );
