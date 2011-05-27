#############################################################################
##
##  LIMOR.gi                    LIMOR subpackage             Mohamed Barakat
##
##         LIMOR = Logical Implications for homalg MORphisms
##
##  Copyright 2007-2008 Lehrstuhl B für Mathematik, RWTH Aachen
##
##  Implementation stuff for the LIMOR subpackage.
##
#############################################################################

####################################
#
# global variables:
#
####################################

# a central place for configuration variables:

InstallValue( LIMOR,
        rec(
            color := "\033[4;30;46m",
            intrinsic_properties :=
            [ "IsZero",
              "IsMorphism",
              "IsGeneralizedMorphism",
              "IsGeneralizedEpimorphism",
              "IsGeneralizedMonomorphism",
              "IsGeneralizedIsomorphism",
              "IsOne",
              "IsMonomorphism",
              "IsEpimorphism",
              "IsSplitMonomorphism",
              "IsSplitEpimorphism",
              "IsIsomorphism",
	      "IsAutomorphism" ],
            intrinsic_attributes :=
            [ "DegreeOfMorphism" ],
	    )
        );

##
InstallValue( LogicalImplicationsForHomalgMorphisms,
        [ 
          ## IsZero does not imply IsMorphism!!!
          [ IsZero,
            "implies", IsGeneralizedMorphism ],
          
          [ IsMorphism,
            "implies", IsGeneralizedMorphism ],
          
          [ IsMonomorphism,
            "implies", IsMorphism ],
          
          [ IsMonomorphism,
            "implies", IsGeneralizedMonomorphism ],
          
          [ IsGeneralizedMonomorphism,
            "implies", IsGeneralizedMorphism ],
          
          [ IsEpimorphism,
            "implies", IsMorphism ],
          
          [ IsEpimorphism,
            "implies", IsGeneralizedEpimorphism ],
          
          [ IsGeneralizedEpimorphism,
            "implies", IsGeneralizedMorphism ],
          
          [ IsAutomorphism,
            "implies", IsIsomorphism ],
          
          [ IsIsomorphism,
            "implies", IsGeneralizedIsomorphism ],
          
          [ IsIsomorphism,
            "implies", IsSplitMonomorphism ],
          
          [ IsIsomorphism,
            "implies", IsSplitEpimorphism ],
          
          [ IsSplitEpimorphism,
            "implies", IsEpimorphism ],
          
          [ IsSplitMonomorphism,
            "implies", IsMonomorphism ],
          
          [ IsEpimorphism, "and", IsMonomorphism,
            "imply", IsIsomorphism ],
          
          [ IsGeneralizedIsomorphism,
            "implies", IsGeneralizedMonomorphism ],
          
          [ IsGeneralizedIsomorphism,
            "implies", IsGeneralizedEpimorphism ],
          
          [ IsGeneralizedEpimorphism, "and", IsGeneralizedMonomorphism,
            "imply", IsGeneralizedIsomorphism ],
          
          ## this is wrong:
          ## [ IsGeneralizedEpimorphism, "and", IsMorphism,
          ##  "imply", IsEpimorphism ],
          
          [ IsGeneralizedMonomorphism, "and", IsMorphism,
            "imply", IsMonomorphism ],
          
          [ IsOne,
            "implies", IsAutomorphism ],
          
          ] );

##
InstallValue( LogicalImplicationsForHomalgEndomorphisms,
        [ 
          
          [ IsIsomorphism,
            "implies", IsAutomorphism ],
          
          ] );

####################################
#
# logical implications methods:
#
####################################

InstallLogicalImplicationsForHomalgObjects( LogicalImplicationsForHomalgMorphisms, IsHomalgMorphism );

InstallLogicalImplicationsForHomalgObjects( LogicalImplicationsForHomalgEndomorphisms, IsHomalgEndomorphism );

####################################
#
# immediate methods for properties:
#
####################################

##
InstallImmediateMethod( IsZero,
        IsHomalgMorphism, 0,
        
  function( phi )
    
    if ( HasIsZero( Source( phi ) ) and IsZero( Source( phi ) ) ) and	## to place "or" here we need to know that phi is a morphism;
       ( HasIsZero( Range( phi ) ) and IsZero( Range( phi ) ) ) then	## see the method below
        return true;
    fi;
    
    TryNextMethod( );
    
end );

##
InstallImmediateMethod( IsZero,
        IsHomalgMorphism and IsMorphism, 0,
        
  function( phi )
    
    if ( HasIsZero( Source( phi ) ) and IsZero( Source( phi ) ) ) or
       ( HasIsZero( Range( phi ) ) and IsZero( Range( phi ) ) ) then
        return true;
    fi;
    
    TryNextMethod( );
    
end );

##
InstallImmediateMethod( IsMorphism,
        IsHomalgMorphism and IsZero, 0,
        
  function( phi )
    
    if HasMorphismAid( phi ) then
        TryNextMethod( );
    fi;
    
    return true;
    
end );

##
InstallImmediateMethod( IsSplitEpimorphism,
        IsHomalgStaticMorphism and IsEpimorphism, 0,
        
  function( phi )
    local T;
    
    T := Range( phi );
    
    if HasIsProjective( T ) and IsProjective( T ) then
        return true;
    fi;
    
    TryNextMethod( );
    
end );

##
## this immediate method together with the above ture-method
## IsZero => IsMorphism
## are essential to avoid infinite loops that
## Assert( 3, IsMonomorphism( emb ) );
## in _Functor_ImageObject_OnObjects may cause
##
InstallImmediateMethod( IsSplitMonomorphism,
        IsHomalgMorphism and IsMorphism, 0,
        
  function( phi )
    local S;
    
    S := Source( phi );
    
    if HasIsZero( S ) and IsZero( S ) then
        return true;
    fi;
    
    TryNextMethod( );
    
end );

##
InstallImmediateMethod( IsAutomorphism,
        IsHomalgMorphism, 0,
        
  function( phi )
    
    if not IsIdenticalObj( Source( phi ), Range( phi ) ) then
        return false;
    fi;
    
    TryNextMethod( );
    
end );

####################################
#
# methods for properties:
#
####################################

##
InstallMethod( IsMorphism,
        "LIMOR: for morphisms of homalg static objects",
        [ IsHomalgStaticMorphism and HasMorphismAid ], 10001,
        
  function( phi )
    
    if not IsZero( MorphismAid( phi ) ) then
        return false;
    fi;
    
    TryNextMethod( );
    
end );

##
InstallMethod( IsGeneralizedMorphism,
        "LIMOR: for morphisms of homalg static objects",
        [ IsHomalgStaticMorphism ],
        
  function( phi )
    
    if HasMorphismAid( phi ) then
        TryNextMethod( );
    fi;
    
    return IsMorphism( phi );
    
end );

##
InstallMethod( IsGeneralizedMorphism,
        "LIMOR: for morphisms of homalg static objects",
        [ IsHomalgStaticMorphism and HasMorphismAid ],
        
  function( phi )
    
    return IsMorphism( AssociatedMorphism( phi ) );
    
end );

##
InstallMethod( IsEpimorphism,
        "LIMOR: for morphisms of homalg static objects",
        [ IsHomalgStaticMorphism ],
        
  function( phi )
    local b, S, T;
    
    b := IsMorphism( phi ) and IsZero( Cokernel( phi ) );
    
    if b then
        S := Source( phi );
        T := Range( phi );
        
        if HasIsTorsion( T ) and not IsTorsion( T ) then
            SetIsTorsion( S, false );
        elif HasIsTorsion( S ) and IsTorsion( S ) then
            SetIsTorsion( T, true );
        fi;
    fi;
    
    return b;
    
end );

##
InstallMethod( IsGeneralizedEpimorphism,
        "LIMOR: for morphisms of homalg static objects",
        [ IsHomalgStaticMorphism ],
        
  function( phi )
    
    ## this is just the fall back method
    return IsEpimorphism( phi );
    
end );

##
InstallMethod( IsGeneralizedEpimorphism,
        "LIMOR: for morphisms of homalg static objects",
        [ IsHomalgStaticMorphism and HasMorphismAid ],
        
  function( phi )
    local mu;
    
    mu := AssociatedMorphism( phi );
    
    SetIsGeneralizedMorphism( phi, IsMorphism( mu ) );
    
    return IsEpimorphism( mu );
    
end );

##
InstallMethod( IsSplitEpimorphism,
        "LIMOR: for morphisms of homalg static objects",
        [ IsHomalgStaticMorphism ],
        
  function( phi )
    local split;
    
    if not IsEpimorphism( phi ) then
        return false;
    fi;
    
    split := PreInverse( phi );
    
    if split = fail then
        TryNextMethod( );
    fi;
    
    return split <> false;
    
end );

##
InstallMethod( IsMonomorphism,
        "LIMOR: for morphisms of homalg static objects",
        [ IsHomalgStaticMorphism ],
        
  function( phi )
    local b, S, T;
    
    b := IsMorphism( phi ) and IsZero( Kernel( phi ) );
    
    if b then
        S := Source( phi );
        T := Range( phi );
        
        if HasIsTorsionFree( T ) and IsTorsionFree( T ) then
            SetIsTorsionFree( S, true );
        elif HasIsTorsionFree( S ) and not IsTorsionFree( S ) then
            SetIsTorsionFree( T, false );
        fi;
        
        if HasIsTorsion( T ) and IsTorsion( T ) then
            SetIsTorsion( S, true );
        elif HasIsTorsion( S ) and not IsTorsion( S ) then
            SetIsTorsion( T, false );
        fi;
    fi;
    
    return b;
    
end );

##
InstallMethod( IsGeneralizedMonomorphism,
        "LIMOR: for morphisms of homalg static objects",
        [ IsHomalgStaticMorphism ],
        
  function( phi )
    
    ## this is just the fall back method
    return IsMonomorphism( phi );
    
end );

##
InstallMethod( IsGeneralizedMonomorphism,
        "LIMOR: for morphisms of homalg static objects",
        [ IsHomalgStaticMorphism and HasMorphismAid ],
        
  function( phi )
    local mu;
    
    mu := AssociatedMorphism( phi );
    
    SetIsGeneralizedMorphism( phi, IsMorphism( mu ) );
    
    return IsMonomorphism( mu );
    
end );

##
InstallMethod( IsIsomorphism,
        "LIMOR: for homalg morphisms",
        [ IsHomalgMorphism ],
        
  function( phi )
    local iso;
    
    iso := IsEpimorphism( phi ) and IsMonomorphism( phi );
    
    if iso then
        SetIsIsomorphism( phi, true );	## needed for UpdateObjectsByMorphism
        UpdateObjectsByMorphism( phi );
    fi;
    
    return iso;
    
end );

##
InstallMethod( IsGeneralizedIsomorphism,
        "LIMOR: for morphisms of homalg static objects",
        [ IsHomalgStaticMorphism ],
        
  function( phi )
    
    ## this is just the fall back method
    return IsIsomorphism( phi );
    
end );

##
InstallMethod( IsGeneralizedIsomorphism,
        "LIMOR: for morphisms of homalg static objects",
        [ IsHomalgStaticMorphism and HasMorphismAid ],
        
  function( phi )
    local mu;
    
    mu := AssociatedMorphism( phi );
    
    SetIsGeneralizedMorphism( phi, IsMorphism( mu ) );
    
    SetIsGeneralizedMonomorphism( phi, IsMonomorphism( mu ) );
    
    return IsIsomorphism( mu );
    
end );

##
InstallMethod( IsAutomorphism,
        "LIMOR: for morphisms of homalg static objects",
        [ IsHomalgStaticMorphism ],
        
  function( phi )
    
    return IsHomalgEndomorphism( phi ) and IsIsomorphism( phi );
    
end );

####################################
#
# methods for attributes:
#
####################################

## Cf. [Bar, Cor. 4.8]
InstallMethod( GeneralizedInverse,
        "LIMOR: for morphisms of homalg static objects",
        [ IsHomalgStaticMorphism and IsEpimorphism ],
        
  function( epsilon )
    local gen_iso, aid;
    
    ## the generalized inverse of the epimorphism
    gen_iso := epsilon^-1;
    
    ## the morphism aid map of the generalized inverse
    aid := MorphismHavingSubobjectAsItsImage( KernelSubobject( epsilon ) );
    
    ## set the morphism aid map
    gen_iso := AddToMorphismAid( gen_iso, aid );
    
    ## check assertion
    Assert( 3, IsGeneralizedIsomorphism( gen_iso ) );
    
    SetIsGeneralizedIsomorphism( gen_iso, true );
    
    return gen_iso;
    
end );

####################################
#
# methods for operations:
#
####################################

##
InstallMethod( SetPropertiesOfGeneralizedMorphism,
        "for two homalg morphisms",
        [ IsHomalgMorphism,
          IsHomalgMorphism ],
        
  function( psi, phi )
    
    homalgResetFilters( psi );
    
    if HasIsZero( phi ) and IsZero( phi ) then
        SetIsZero( psi, true );
    fi;
    
    ## this is wrong:
    ## if HasIsIsomorphism( phi ) and IsIsomorphism( phi ) then
    ##     SetIsGeneralizedIsomorphism( psi, true );
    ## fi;
    
    if HasIsGeneralizedEpimorphism( phi ) and IsGeneralizedEpimorphism( phi ) then
        SetIsGeneralizedEpimorphism( psi, true );
    elif HasIsGeneralizedMorphism( phi ) and IsGeneralizedMorphism( phi ) then
        SetIsGeneralizedMorphism( psi, true );
    fi;
    
    return psi;
    
end );

##
InstallMethod( SetPropertiesOfAdditiveInverse,
        "for two homalg morphisms",
        [ IsHomalgMorphism,
          IsHomalgMorphism ],
        
  function( psi, phi )
    
    if HasIsMorphism( phi ) then
        SetIsMorphism( psi, IsMorphism( phi ) );
    fi;
    if HasMorphismAid( phi ) then
        psi := AddToMorphismAid( psi, MorphismAid( phi ) );
    fi;
    if HasIsGeneralizedMorphism( phi ) then
        SetIsGeneralizedMorphism( psi, IsGeneralizedMorphism( phi ) );
    fi;
    if HasIsEpimorphism( phi )  then
        SetIsEpimorphism( psi, IsEpimorphism( phi ) );
    fi;
    if HasIsMonomorphism( phi )  then
        SetIsMonomorphism( psi, IsMonomorphism( phi ) );
    fi;
    
    return psi;
    
end );
