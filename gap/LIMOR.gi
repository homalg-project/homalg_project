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
              "IsIdentityMorphism",
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
          
          [ IsGeneralizedEpimorphism, "and", IsMorphism,
            "imply", IsEpimorphism ],
          
          [ IsGeneralizedMonomorphism, "and", IsMorphism,
            "imply", IsMonomorphism ],
          
          [ IsIdentityMorphism,
            "implies", IsAutomorphism ],
          
          ] );

##
InstallValue( LogicalImplicationsForHomalgEndomorphisms,
        [ 
          
          [ IsIsomorphism,
            "implies", IsAutomorphism ],
          
          ] );

##
InstallValue( LogicalImplicationsForHomalgChainMaps,
        [ 
          
          [ IsGradedMorphism,
            "implies", IsMorphism ],
          
          [ IsIsomorphism,
            "implies", IsQuasiIsomorphism ],
          
          ] );

####################################
#
# logical implications methods:
#
####################################

InstallLogicalImplicationsForHomalgObjects( LogicalImplicationsForHomalgMorphisms, IsHomalgMorphism );

InstallLogicalImplicationsForHomalgObjects( LogicalImplicationsForHomalgEndomorphisms, IsHomalgEndomorphism );

InstallLogicalImplicationsForHomalgObjects( LogicalImplicationsForHomalgChainMaps, IsHomalgChainMap );

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
InstallImmediateMethod( IsZero,
        IsMapOfFinitelyGeneratedModulesRep, 0,
        
  function( phi )
    
    if HasIsZero( MatrixOfMap( phi ) ) and IsZero( MatrixOfMap( phi ) ) then
        return true;
    fi;
    
    TryNextMethod( );
    
end );

##
InstallImmediateMethod( IsZero,
        IsMapOfFinitelyGeneratedModulesRep, 0,
        
  function( phi )
    local index_pair, matrix;
    
    index_pair := PairOfPositionsOfTheDefaultSetOfRelations( phi );
    
    if IsBound( phi!.reduced_matrices.( String( index_pair ) ) ) then
        
        matrix := phi!.reduced_matrices.( String( index_pair ) );
        
        if HasIsZero( matrix ) then
            return IsZero( matrix );
        fi;
        
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
        IsMapOfFinitelyGeneratedModulesRep and IsEpimorphism, 0,
        
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
        IsMapOfFinitelyGeneratedModulesRep and IsMorphism, 0,
        
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

##
InstallImmediateMethod( IsGradedMorphism,
        IsHomalgChainMap, 0,
        
  function( phi )
    local S, T;
    
    S := Source( phi );
    T := Range( phi );
    
    if HasIsGradedObject( S ) and HasIsGradedObject( T ) then
        return IsGradedObject( S ) and IsGradedObject( T );
    fi;
    
    TryNextMethod( );
    
end );

####################################
#
# methods for properties:
#
####################################

##
InstallMethod( IsZero,
        "LIMOR: for homalg maps",
        [ IsMapOfFinitelyGeneratedModulesRep ],
        
  function( phi )
    
    return IsZero( MatrixOfMap( DecideZero( phi ) ) );
    
end );

##
InstallMethod( IsZero,
        "LIMOR: for homalg chain maps",
        [ IsHomalgChainMap ],
        
  function( cm )
    local morphisms;
    
    morphisms := MorphismsOfChainMap( cm );
    
    return ForAll( morphisms, IsZero );
    
end );

##
InstallMethod( IsMorphism,
        "LIMOR: for homalg maps",
        [ IsMapOfFinitelyGeneratedModulesRep and IsHomalgLeftObjectOrMorphismOfLeftObjects ],
        
  function( phi )
    local mat;
    
    mat := MatrixOfRelations( Source( phi ) ) * MatrixOfMap( phi );
    
    return IsZero( DecideZero( mat, Range( phi ) ) );
    
end );

##
InstallMethod( IsMorphism,
        "LIMOR: for homalg maps",
        [ IsMapOfFinitelyGeneratedModulesRep and IsHomalgRightObjectOrMorphismOfRightObjects ],
        
  function( phi )
    local mat;
    
    mat := MatrixOfMap( phi ) * MatrixOfRelations( Source( phi ) );
    
    return IsZero( DecideZero( mat, Range( phi ) ) );
    
end );

##
InstallMethod( IsMorphism,
        "LIMOR: for homalg maps",
        [ IsHomalgStaticMorphism and HasMorphismAid ], 10001,
        
  function( phi )
    
    if not IsZero( MorphismAid( phi ) ) then
        return false;
    fi;
    
    TryNextMethod( );
    
end );

##
InstallMethod( IsMorphism,
        "LIMOR: for homalg chain maps",
        [ IsHomalgChainMap ],
        
  function( cm )
    local degrees, l, S, T;
    
    if not IsComplex( Source( cm ) ) then
        return false;
    elif not IsComplex( Range( cm ) ) then
        return false;
    fi;
    
    degrees := DegreesOfChainMap( cm );
    
    l := Length( degrees );
    
    degrees := degrees{[ 1 .. l - 1 ]};
    
    S := Source( cm );
    T := Range( cm );
    
    if l = 1 then
        if Length( ObjectDegreesOfComplex( S ) ) = 1 then
            return true;
        else
            Error( "not implemented for chain maps containing as single morphism\n" );
        fi;
    elif IsChainMapOfFinitelyPresentedObjectsRep( cm ) and IsHomalgLeftObjectOrMorphismOfLeftObjects( cm ) then
        return ForAll( degrees, i -> CertainMorphism( cm, i + 1 ) * CertainMorphism( T, i + 1 ) = CertainMorphism( S, i + 1 ) * CertainMorphism( cm, i ) );
    elif IsCochainMapOfFinitelyPresentedObjectsRep( cm ) and IsHomalgRightObjectOrMorphismOfRightObjects( cm ) then
        return ForAll( degrees, i -> CertainMorphism( T, i ) * CertainMorphism( cm, i ) = CertainMorphism( cm, i + 1 ) * CertainMorphism( S, i ) );
    elif IsChainMapOfFinitelyPresentedObjectsRep( cm ) and IsHomalgRightObjectOrMorphismOfRightObjects( cm ) then
        return ForAll( degrees, i -> CertainMorphism( T, i + 1 ) * CertainMorphism( cm, i + 1 ) = CertainMorphism( cm, i ) * CertainMorphism( S, i + 1 ) );
    else
        return ForAll( degrees, i -> CertainMorphism( cm, i ) * CertainMorphism( T, i ) = CertainMorphism( S, i ) * CertainMorphism( cm, i + 1 ) );
    fi;
    
end );

##
InstallMethod( IsGeneralizedMorphism,
        "LIMOR: for homalg maps",
        [ IsHomalgStaticMorphism ],
        
  function( phi )
    
    if HasMorphismAid( phi ) then
        TryNextMethod( );
    fi;
    
    return IsMorphism( phi );
    
end );

##
InstallMethod( IsGeneralizedMorphism,
        "LIMOR: for homalg maps",
        [ IsMapOfFinitelyGeneratedModulesRep and HasMorphismAid ],
        
  function( phi )
    
    return IsMorphism( AssociatedMorphism( phi ) );
    
end );

##
InstallMethod( IsEpimorphism,
        "LIMOR: for homalg maps",
        [ IsMapOfFinitelyGeneratedModulesRep ],
        
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
        "LIMOR: for homalg maps",
        [ IsMapOfFinitelyGeneratedModulesRep ],
        
  function( phi )
    
    return IsEpimorphism( phi );	## this is just the fall back method
    
end );

##
InstallMethod( IsGeneralizedEpimorphism,
        "LIMOR: for homalg maps",
        [ IsMapOfFinitelyGeneratedModulesRep and HasMorphismAid ],
        
  function( phi )
    local mu;
    
    mu := AssociatedMorphism( phi );
    
    SetIsGeneralizedMorphism( phi, IsMorphism( mu ) );
    
    return IsEpimorphism( mu );
    
end );

##
InstallMethod( IsSplitEpimorphism,
        "LIMOR: for homalg chain maps",
        [ IsMapOfFinitelyGeneratedModulesRep ],
        
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
InstallMethod( IsEpimorphism,
        "LIMOR: for homalg chain maps",
        [ IsHomalgChainMap ],
        
  function( cm )
    
    return IsMorphism( cm ) and ForAll( MorphismsOfChainMap( cm ), IsEpimorphism );	## not true for split epimorphisms
    
end );

##
InstallMethod( IsMonomorphism,
        "LIMOR: for homalg maps",
        [ IsMapOfFinitelyGeneratedModulesRep ],
        
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
        "LIMOR: for homalg maps",
        [ IsMapOfFinitelyGeneratedModulesRep ],
        
  function( phi )
    
    return IsMonomorphism( phi );	## this is just the fall back method
    
end );

##
InstallMethod( IsGeneralizedMonomorphism,
        "LIMOR: for homalg maps",
        [ IsMapOfFinitelyGeneratedModulesRep and HasMorphismAid ],
        
  function( phi )
    local mu;
    
    mu := AssociatedMorphism( phi );
    
    SetIsGeneralizedMorphism( phi, IsMorphism( mu ) );
    
    return IsMonomorphism( mu );
    
end );

##
InstallMethod( IsMonomorphism,
        "LIMOR: for homalg chain maps",
        [ IsHomalgChainMap ],
        
  function( cm )
    
    return IsMorphism( cm ) and ForAll( MorphismsOfChainMap( cm ), IsMonomorphism );	## not true for split monomorphisms
    
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
        "LIMOR: for homalg maps",
        [ IsMapOfFinitelyGeneratedModulesRep ],
        
  function( phi )
    
    return IsIsomorphism( phi );	## this is just the fall back method
    
end );

##
InstallMethod( IsGeneralizedIsomorphism,
        "LIMOR: for homalg maps",
        [ IsMapOfFinitelyGeneratedModulesRep and HasMorphismAid ],
        
  function( phi )
    local mu;
    
    mu := AssociatedMorphism( phi );
    
    SetIsGeneralizedMorphism( phi, IsMorphism( mu ) );
    
    SetIsGeneralizedMonomorphism( phi, IsMonomorphism( mu ) );
    
    return IsIsomorphism( mu );
    
end );

##
InstallMethod( IsAutomorphism,
        "LIMOR: for homalg maps",
        [ IsMapOfFinitelyGeneratedModulesRep ],
        
  function( phi )
    
    return IsHomalgSelfMap( phi ) and IsIsomorphism( phi );
    
end );

##
InstallMethod( IsGradedMorphism,
        "LIMOR: for homalg chain maps",
        [ IsHomalgChainMap ],
        
  function( phi )
    
    return IsGradedObject( Source( phi ) ) and IsGradedObject( Range( phi ) );
    
end );

##
InstallMethod( IsQuasiIsomorphism,
        "LIMOR: for homalg chain maps",
        [ IsHomalgChainMap ],
        
  function( phi )
    
    return IsIsomorphism( DefectOfExactness( phi ) );
    
end );

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
    
    if HasIsIsomorphism( phi ) and IsIsomorphism( phi ) then
        SetIsGeneralizedIsomorphism( psi, true );
    elif HasIsEpimorphism( phi ) and IsEpimorphism( phi ) then
        SetIsGeneralizedEpimorphism( psi, true );
    elif HasIsMorphism( phi ) and IsMorphism( phi ) then
        SetIsGeneralizedMorphism( psi, true );
    fi;
    
    return psi;
    
end );

####################################
#
# methods for attributes:
#
####################################

##
InstallMethod( ImageSubobject,
        "LIMOR: submodule constructor",
        [ IsHomalgMap ],
        
  function( phi )
    local T, R, ideal, N;
    
    T := Range( phi );
    
    R := HomalgRing( T );
    
    ideal := IsBound( T!.distinguished ) and T!.distinguished = true and
             IsBound( T!.not_twisted ) and T!.not_twisted = true;
    
    N := rec( map_having_subobject_as_its_image := phi );
    
    if IsHomalgLeftObjectOrMorphismOfLeftObjects( phi ) then
        ## Objectify:
        ObjectifyWithAttributes(
                N, TheTypeHomalgLeftFinitelyGeneratedSubmodule,
                ConstructedAsAnIdeal, ideal,
                LeftActingDomain, R );
    else
        ## Objectify:
        ObjectifyWithAttributes(
                N, TheTypeHomalgRightFinitelyGeneratedSubmodule,
                ConstructedAsAnIdeal, ideal,
                RightActingDomain, R );
    fi;
    
    ## immediate methods will check if they can set
    ## SetIsTorsionFree( N, true ); and SetIsTorsion( N, true );
    ## by checking if the corresponding property for T is true
    
    return N;
    
end );

##
InstallMethod( KernelSubobject,
        "LIMOR: for homalg maps",
        [ IsHomalgMap ],
        
  function( psi )
    local S, ker, T;
    
    S := Source( psi );
    
    if HasIsMonomorphism( psi ) and IsMonomorphism( psi ) then
        ker := ZeroSubobject( S );
    else
        ker := Subobject( ReducedSyzygiesGenerators( psi ), S );
    fi;
    
    T := Range( psi );
    
    if HasRankOfModule( S ) and HasRankOfModule( T ) then
        if RankOfModule( T ) = 0 then
            SetRankOfModule( ker, RankOfModule( S ) );
        fi;
    fi;
    
    return ker;
    
end );

## Cf. [Bar, Cor. 4.8]
InstallMethod( GeneralizedInverse,
        "LIMOR: for homalg maps",
        [ IsHomalgMap and IsEpimorphism ],
        
  function( epsilon )
    local gen_iso, aid;
    
    ## the generalized inverse of the epimorphism
    gen_iso := epsilon^-1;
    
    ## the morphism aid map of the generalized inverse
    aid := MapHavingSubobjectAsItsImage( KernelSubobject( epsilon ) );
    
    ## set the morphism aid map
    SetMorphismAid( gen_iso, aid );
    
    ## check assertion
    Assert( 3, IsGeneralizedIsomorphism( gen_iso ) );
    
    SetIsGeneralizedIsomorphism( gen_iso, true );
    
    ## TODO: use PreDivide instead of the above stuff
    
    return gen_iso;
    
end );

