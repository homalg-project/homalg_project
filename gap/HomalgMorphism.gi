#############################################################################
##
##  HomalgMap.gi                homalg package               Mohamed Barakat
##
##  Copyright 2007-2010, Mohamed Barakat, University of Kaiserslautern
##
##  Implementation for homalg morphisms of Abelian categories.
##
#############################################################################

####################################
#
# methods for operations:
#
####################################

##
InstallMethod( AreComparableMorphisms,
        "for homalg maps",
        [ IsHomalgMorphism, IsHomalgMorphism ],
        
  function( phi1, phi2 )
    
    return IsIdenticalObj( Source( phi1 ), Source( phi2 ) ) and
           IsIdenticalObj( Range( phi1 ), Range( phi2 ) );
    
end );

##
InstallMethod( AreComposableMorphisms,
        "for homalg maps",
        [ IsHomalgMorphism and IsHomalgRightObjectOrMorphismOfRightObjects,
          IsHomalgMorphism and IsHomalgRightObjectOrMorphismOfRightObjects ],
        
  function( phi2, phi1 )
    
    return IsIdenticalObj( Range( phi1 ), Source( phi2 ) );
    
end );

##
InstallMethod( AreComposableMorphisms,
        "for homalg maps",
        [ IsHomalgMorphism and IsHomalgLeftObjectOrMorphismOfLeftObjects,
          IsHomalgMorphism and IsHomalgLeftObjectOrMorphismOfLeftObjects ],
        
  function( phi1, phi2 )
    
    return IsIdenticalObj( Range( phi1 ), Source( phi2 ) );
    
end );

## a synonym of `-<elm>':
InstallMethod( AdditiveInverseMutable,
        "of homalg maps",
        [ IsHomalgMorphism and IsZero ],
        
  function( phi )
    
    return phi;
    
end );

##
## composition is a bifunctor to profit from the caching mechanisms for functors (cf. ToolFunctors.gi)
##

##
InstallMethod( POW,
        "for homalg maps",
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
        "of two homalg maps",
        [ IsHomalgMorphism and IsHomalgRightObjectOrMorphismOfRightObjects,
          IsHomalgMorphism and IsHomalgRightObjectOrMorphismOfRightObjects ],
        
  function( phi1, phi2 )
    
    return phi2 * phi1;
    
end );

##
InstallMethod( PreCompose,
        "of two homalg maps",
        [ IsHomalgMorphism and IsHomalgLeftObjectOrMorphismOfLeftObjects,
          IsHomalgMorphism and IsHomalgLeftObjectOrMorphismOfLeftObjects ],
        
  function( phi1, phi2 )
    
    return phi1 * phi2;
    
end );

## this should be the lowest rank method
InstallMethod( PreInverse,
        "for homalg maps",
        [ IsHomalgMorphism ],
        
  function( phi )
    
    return fail;
    
end );

## this should be the lowest rank method
InstallMethod( PostInverse,
        "for homalg maps",
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
        "for homalg maps",
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
        "for homalg maps",
        [ IsHomalgMorphism,
          IsHomalgMorphism,
          IsHomalgMorphism ],
        
  function( alpha2, phi, beta2 )
    
    return PreDivide( alpha2, PreCompose( phi, beta2 ) );	## colift
    
end );

## this should be the lowest rank method
InstallMethod( UpdateObjectsByMorphism,
        "for homalg maps",
        [ IsHomalgMorphism ],
        
  function( phi )
    
    ## do nothing :)
    
end );

