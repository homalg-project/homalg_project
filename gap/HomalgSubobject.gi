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
    
    return Range( MapHavingSubobjectAsItsImage( M ) );
    
end );

####################################
#
# methods for operations:
#
####################################

##
InstallMethod( MapHavingSubobjectAsItsImage,
        "for homalg subobjects",
        [ IsStaticFinitelyPresentedSubobjectRep ],
  function( M )
    
    if HasEmbeddingInSuperObject( M ) then
        return EmbeddingInSuperObject( M );
    fi;
    
    return M!.map_having_subobject_as_its_image;
    
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

####################################
#
# constructor functions and methods:
#
####################################

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

