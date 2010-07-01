#############################################################################
##
##  HomalgMap.gi                homalg package               Mohamed Barakat
##
##  Copyright 2007-2010, Mohamed Barakat, University of Kaiserslautern
##
##  Implementation for morphisms of (Abelian) categories.
##
#############################################################################

####################################
#
# representations:
#
####################################

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
# methods for operations:
#
####################################

##
InstallMethod( AreComparableMorphisms,
        "for homalg morphisms",
        [ IsHomalgMorphism, IsHomalgMorphism ],
        
  function( phi1, phi2 )
    
    return IsIdenticalObj( Source( phi1 ), Source( phi2 ) ) and
           IsIdenticalObj( Range( phi1 ), Range( phi2 ) );
    
end );

##
InstallMethod( AreComposableMorphisms,
        "for homalg morphisms",
        [ IsHomalgMorphism and IsHomalgRightObjectOrMorphismOfRightObjects,
          IsHomalgMorphism and IsHomalgRightObjectOrMorphismOfRightObjects ],
        
  function( phi2, phi1 )
    
    return IsIdenticalObj( Range( phi1 ), Source( phi2 ) );
    
end );

##
InstallMethod( AreComposableMorphisms,
        "for homalg morphisms",
        [ IsHomalgMorphism and IsHomalgLeftObjectOrMorphismOfLeftObjects,
          IsHomalgMorphism and IsHomalgLeftObjectOrMorphismOfLeftObjects ],
        
  function( phi1, phi2 )
    
    return IsIdenticalObj( Range( phi1 ), Source( phi2 ) );
    
end );

## a synonym of `-<elm>':
InstallMethod( AdditiveInverseMutable,
        "of homalg morphisms",
        [ IsHomalgMorphism and IsZero ],
        
  function( phi )
    
    return phi;
    
end );

##
## composition is a bifunctor to profit from the caching mechanisms for functors (cf. ToolFunctors.gi)
##

##
InstallMethod( POW,
        "for homalg morphisms",
        [ IsHomalgMorphism, IsInt ],
        
  function( phi, pow )
    local id, inv;
    
    if pow = -1 then
        
        id := TheIdentityMorphism( Range( phi ) );
        
        inv := id / phi;	## mimic lift
        
        if HasIsIsomorphism( phi ) then
            SetIsIsomorphism( inv, IsIsomorphism( phi ) );
        fi;
        
        ## CAUTION: inv might very well be non-well-defined
        return inv;
        
    fi;
    
    TryNextMethod( );
    
end );

##
InstallMethod( PreCompose,
        "of two homalg morphisms",
        [ IsHomalgMorphism and IsHomalgRightObjectOrMorphismOfRightObjects,
          IsHomalgMorphism and IsHomalgRightObjectOrMorphismOfRightObjects ],
        
  function( phi1, phi2 )
    
    return phi2 * phi1;
    
end );

##
InstallMethod( PreCompose,
        "of two homalg morphisms",
        [ IsHomalgMorphism and IsHomalgLeftObjectOrMorphismOfLeftObjects,
          IsHomalgMorphism and IsHomalgLeftObjectOrMorphismOfLeftObjects ],
        
  function( phi1, phi2 )
    
    return phi1 * phi2;
    
end );

## this should be the lowest rank method
InstallMethod( PreInverse,
        "for homalg morphisms",
        [ IsHomalgMorphism ],
        
  function( phi )
    
    return fail;
    
end );

## this should be the lowest rank method
InstallMethod( PostInverse,
        "for homalg morphisms",
        [ IsHomalgMorphism ],
        
  function( phi )
    
    return fail;
    
end );

#=======================================================================
# Complete an image-square
#
#  A_ is a free or beta1 is injective ( cf. [HS, Lemma III.3.1]
#                                       and [BR08, Subsection 3.1.2] )
#
#     A_ --(alpha1)--> A
#     |                |
#  (psi=?)    Sq1    (phi)
#     |                |
#     v                v
#     B_ --(beta1)---> B
#
#_______________________________________________________________________

##
InstallMethod( CompleteImageSquare,		### defines: CompleteImageSquare (CompleteImSq)
        "for homalg morphisms",
        [ IsHomalgMorphism,
          IsHomalgMorphism,
          IsHomalgMorphism ],
        
  function( alpha1, phi, beta1 )
    
    return PreCompose( alpha1, phi ) / beta1;	## lift or projective lift
    
end );

#=======================================================================
# Complete a kernel-square
#
#  alpha2 is surjective ( cf. [HS, Lemma III.3.1] )
#
#     A --(alpha2)->> _A
#     |                |
#   (phi)   Sq2   (theta=?)
#     |                |
#     v                v
#     B --(beta2)---> _B
#
#_______________________________________________________________________

##
InstallMethod( CompleteKernelSquare,		### defines: CompleteKernelSquare
        "for homalg morphisms",
        [ IsHomalgMorphism,
          IsHomalgMorphism,
          IsHomalgMorphism ],
        
  function( alpha2, phi, beta2 )
    
    return PreDivide( alpha2, PreCompose( phi, beta2 ) );	## colift
    
end );

## this should be the lowest rank method
InstallMethod( UpdateObjectsByMorphism,
        "for homalg morphisms",
        [ IsHomalgMorphism ],
        
  function( phi )
    
    ## do nothing :)
    
end );

