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
##    <Oper Arg="M" Name="UnderlyingObject" Label="for submodules"/>
##    <Returns>a &homalg; module</Returns>
##    <Description>
##      In case <A>M</A> was defined as a submodule of some module <M>L</M> the module underlying the submodule <M>M</M> is returned.
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

##  <#GAPDoc Label="SuperObject">
##  <ManSection>
##    <Oper Arg="M" Name="SuperObject" Label="for submodules"/>
##    <Returns>a &homalg; module</Returns>
##    <Description>
##      In case <A>M</A> was defined as a submodule of some module <M>L</M> the super module <M>L</M> is returned.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
InstallMethod( SuperObject,
        "for homalg subobjects",
        [ IsStaticFinitelyPresentedSubobjectRep ],
        
  function( M )
    
    return Range( MapHavingSubobjectAsItsImage( M ) );
    
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

##  <#GAPDoc Label="Subobject:map">
##  <ManSection>
##    <Oper Arg="phi" Name="Subobject" Label="constructor for submodules using maps"/>
##    <Returns>a &homalg; submodule</Returns>
##    <Description>
##      A synonym of <Ref Attr="ImageSubobject" Label="for maps"/>.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
InstallMethod( Subobject,
        "constructor for homalg subobjects",
        [ IsHomalgStaticMorphism ],
        
  ImageSubobject );

