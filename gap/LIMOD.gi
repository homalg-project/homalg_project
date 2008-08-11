#############################################################################
##
##  LIMOD.gi                    LIMOD subpackage             Mohamed Barakat
##
##         LIMOD = Logical Implications for homalg MODules
##
##  Copyright 2007-2008 Lehrstuhl B für Mathematik, RWTH Aachen
##
##  Implementation stuff for the LIMOD subpackage.
##
#############################################################################

####################################
#
# global variables:
#
####################################

# a central place for configuration variables:

InstallValue( LIMOD,
        rec(
            color := "\033[4;30;46m" )
        );

##
InstallValue( LogicalImplicationsForHomalgModules,
        [ ## IsTorsionFreeModule:
          
          [ IsZero,
            "implies", IsFree ],
          
          [ IsFree,
            "implies", IsStablyFree ],
          
          [ IsStablyFree,
            "implies", IsProjective ],
          
          ## Serre's 1955 remark:
          ## for a module with a finite free resolution (FFR)
          ## "projective" and "stably free" are equivalent
          [ IsProjective, "and", FiniteFreeResolutionExists,
            "imply", IsStablyFree ],
          
          [ IsProjective,
            "implies", IsReflexive ],
          
          [ IsReflexive,
            "implies", IsTorsionFree ],
          
          [ IsTorsionFree,
            "implies", IsPure ],
          
          ## IsTorsionModule:
          
          [ IsZero,
            "implies", IsHolonomic ],
          
          [ IsHolonomic,
            "implies", IsTorsion ],
          
          [ IsHolonomic,
            "implies", IsArtinian ],
          
          ## IsCyclicModule:
          
          [ IsZero,
            "implies", IsCyclic ],
          
          ## IsZero:
          
          [ IsTorsion, "and", IsTorsionFree,
            "imply", IsZero ]
          
          ] );

##
InstallValue( LogicalImplicationsForHomalgModulesOverSpecialRings,
        [ ## logical implications for modules over special rings
          
          [ [ IsTorsionFree ], HomalgRing, [ [ IsLeftHereditary, IsRightHereditary, IsHereditary ] ],
            "imply", IsProjective ],									## Kaplansky's theorem [Lam06, Theorem II.2.2]
          
          [ [ IsProjective ], HomalgRing, [ [ IsFiniteFreePresentationRing, IsLeftFiniteFreePresentationRing, IsRightFiniteFreePresentationRing ] ],
            "imply", IsStablyFree ],									## Serre's 1955 remark
          
          [ [ IsStablyFree ], HomalgRing, [ [ IsLeftHermite, IsRightHermite, IsHermite ] ],
            "imply", IsFree ],										## by definition [Lam06, Definition I.4.6]
          
          ] );

####################################
#
# logical implications methods:
#
####################################

InstallLogicalImplicationsForHomalg( LogicalImplicationsForHomalgModules, IsHomalgModule );

InstallLogicalImplicationsForHomalg( LogicalImplicationsForHomalgModulesOverSpecialRings, IsHomalgModule, IsHomalgRing );

####################################
#
# immediate methods for properties:
#
####################################

## strictly less relations than generators => not IsTorsion
InstallImmediateMethod( IsTorsion,
        IsFinitelyPresentedModuleRep, 0,
        
  function( M )
    local l, b, i, rel;
    
    l := SetsOfRelations( M )!.ListOfPositionsOfKnownSetsOfRelations;
    
    b := false;
    
    for i in [ 1.. Length( l ) ] do;
        
        rel := SetsOfRelations( M )!.(i);
        
        if not IsString( rel ) then
            if HasNrGenerators( rel ) and HasNrRelations( rel ) and
               NrGenerators( rel ) > NrRelations( rel ) then
                b := true;
                break;
            fi;
        fi;
        
    od;
    
    if b then
        return false;
    fi;
    
    TryNextMethod( );
    
end );

## a presentation must be on a single generator
InstallImmediateMethod( IsCyclic,
        IsFinitelyPresentedModuleRep, 0,
        
  function( M )
    local l, b, i, rel;
    
    l := SetsOfRelations( M )!.ListOfPositionsOfKnownSetsOfRelations;
    
    b := false;
    
    for i in [ 1.. Length( l ) ] do;
        
        rel := SetsOfRelations( M )!.(i);
        
        if not IsString( rel ) then
            if HasNrGenerators( rel ) and NrGenerators( rel ) = 1 then
                return true;
            fi;
        fi;
        
    od;
    
    TryNextMethod( );
    
end );

##
InstallImmediateMethod( IsTorsion,
        IsFinitelyPresentedModuleRep and HasRankOfModule, 0,
        
  function( M )
    
    return RankOfModule( M ) = 0;
    
end );

##
InstallImmediateMethod( IsTorsion,
        IsFinitelyPresentedModuleRep and HasTorsionFreeFactorEpi and HasIsZero, 0,
        
  function( M )
    local F;
    
    F := Range( TorsionFreeFactorEpi( M ) );
    
    if not IsZero( M ) and HasIsZero( F ) then
        if IsZero( F ) then
            return true;
        else
            return false;
        fi;
    fi;
    
    TryNextMethod( );
    
end );

##
InstallImmediateMethod( IsTorsionFree,
        IsFinitelyPresentedModuleRep and HasTorsionSubmoduleEmb and HasIsZero, 0,
        
  function( M )
    local T;
    
    T := Source( TorsionSubmoduleEmb( M ) );
    
    if not IsZero( M ) and HasIsZero( T ) then
        if IsZero( T ) then
            return true;
        else
            return false;
        fi;
    fi;
    
    TryNextMethod( );
    
end );

##
InstallImmediateMethod( IsTorsionFree,
        IsFinitelyPresentedModuleRep and HasIsProjective and HasLeftActingDomain, 0,
        
  function( M )
    local R;
    
    R := HomalgRing( M );
    
    if HasLeftGlobalDimension( R ) and LeftGlobalDimension( R ) <= 1 and not IsProjective( M ) then
        return false;
    fi;			## the true case is taken care of elsewhere
    
    TryNextMethod( );
    
end );

##
InstallImmediateMethod( IsTorsionFree,
        IsFinitelyPresentedModuleRep and HasIsProjective and HasRightActingDomain, 0,
        
  function( M )
    local R;
    
    R := HomalgRing( M );
    
    if HasRightGlobalDimension( R ) and RightGlobalDimension( R ) <= 1 and not IsProjective( M ) then
        return false;
    fi;			## the true case is taken care of elsewhere
    
    TryNextMethod( );
    
end );

##
InstallImmediateMethod( IsReflexive,
        IsFinitelyPresentedModuleRep and HasIsProjective and HasLeftActingDomain, 0,
        
  function( M )
    local R;
    
    R := HomalgRing( M );
    
    if HasLeftGlobalDimension( R ) and LeftGlobalDimension( R ) <= 2 and not IsProjective( M ) then
        return false;
    fi;			## the true case is taken care of elsewhere
    
    TryNextMethod( );
    
end );

##
InstallImmediateMethod( IsReflexive,
        IsFinitelyPresentedModuleRep and HasIsProjective and HasRightActingDomain, 0,
        
  function( M )
    local R;
    
    R := HomalgRing( M );
    
    if HasRightGlobalDimension( R ) and RightGlobalDimension( R ) <= 2 and not IsProjective( M ) then
        return false;
    fi;			## the true case is taken care of elsewhere
    
    TryNextMethod( );
    
end );

##
InstallImmediateMethod( IsProjective,
        IsFinitelyPresentedModuleRep and IsTorsionFree and HasLeftActingDomain, 0,
        
  function( M )
    local R;
    
    R := HomalgRing( M );
    
    if HasLeftGlobalDimension( R ) and LeftGlobalDimension( R ) <= 1 then
        return true;
    fi;			## the false case is taken care of elsewhere
    
    TryNextMethod( );
    
end );

##
InstallImmediateMethod( IsProjective,
        IsFinitelyPresentedModuleRep and IsTorsionFree and HasRightActingDomain, 0,
        
  function( M )
    local R;
    
    R := HomalgRing( M );
    
    if HasRightGlobalDimension( R ) and RightGlobalDimension( R ) <= 1 then
        return true;
    fi;			## the false case is taken care of elsewhere
    
    TryNextMethod( );
    
end );

##
InstallImmediateMethod( IsProjective,
        IsFinitelyPresentedModuleRep and IsReflexive and HasLeftActingDomain, 0,
        
  function( M )
    local R;
    
    R := HomalgRing( M );
    
    if HasLeftGlobalDimension( R ) and LeftGlobalDimension( R ) <= 2 then
        return true;
    fi;
    
    TryNextMethod( );
    
end );

##
InstallImmediateMethod( IsProjective,
        IsFinitelyPresentedModuleRep and IsReflexive and HasRightActingDomain, 0,
        
  function( M )
    local R;
    
    R := HomalgRing( M );
    
    if HasRightGlobalDimension( R ) and RightGlobalDimension( R ) <= 2 then
        return true;
    fi;
    
    TryNextMethod( );
    
end );

##
InstallImmediateMethod( IsProjective,
        IsFinitelyPresentedModuleRep and HasProjectiveDimension, 0,
        
  function( M )
    
    return ProjectiveDimension( M ) = 0;
    
end );

##
InstallImmediateMethod( IsFree,
        IsFinitelyPresentedModuleRep, 0,
        
  function( M )
    
    if HasNrRelations( M ) = true and NrRelations( M ) = 0 then	## NrRelations is not an attribute and HasNrRelations might return fail!
        return true;
    fi;
    
    TryNextMethod( );
    
end );

##
InstallImmediateMethod( IsFree,
        IsFinitelyPresentedModuleRep and IsStablyFree and HasRankOfModule and HasLeftActingDomain, 0,
        
  function( M )
    local R;
    
    R := HomalgRing( M );
    
    if HasIsCommutative( R ) and IsCommutative( R ) and RankOfModule( M ) = 1 then
        return true;			## [Lam06, Theorem I.4.11], this is in principle the Cauchy-Binet formula
    elif HasGeneralLinearRank( R ) and GeneralLinearRank( R ) <= RankOfModule( M ) then
        return true;			## [McCRob, Theorem 11.1.14]
    elif HasElementaryRank( R ) and ElementaryRank( R ) <= RankOfModule( M ) then
        return true;			## [McCRob, Theorem 11.1.14 and Proposition 11.3.11]
    elif HasStableRank( R ) and StableRank( R ) <= RankOfModule( M ) then
        return true;			## [McCRob, Theorem 11.1.14 and Proposition 11.3.11]
    fi;
    
    TryNextMethod( );
    
end );

##
InstallImmediateMethod( IsFree,
        IsFinitelyPresentedModuleRep and IsStablyFree and HasRankOfModule and HasRightActingDomain, 0,
        
  function( M )
    local R;
    
    R := HomalgRing( M );
    
    if HasIsCommutative( R ) and IsCommutative( R ) and RankOfModule( M ) = 1 then
        return true;			## [Lam06, Theorem I.4.11], this is in principle the Cauchy-Binet formula
    elif HasGeneralLinearRank( R ) and GeneralLinearRank( R ) <= RankOfModule( M ) then
        return true;			## [McCRob, Theorem 11.1.14]
    elif HasElementaryRank( R ) and ElementaryRank( R ) <= RankOfModule( M ) then
        return true;			## [McCRob, Theorem 11.1.14 and Proposition 11.3.11]
    elif HasStableRank( R ) and StableRank( R ) <= RankOfModule( M ) then
        return true;			## [McCRob, Theorem 11.1.14 and Proposition 11.3.11]
    fi;
    
    TryNextMethod( );
    
end );

##
InstallImmediateMethod( IsPure,
        IsFinitelyPresentedModuleRep and IsTorsion and HasLeftActingDomain, 0,
        
  function( M )
    local R;
    
    R := HomalgRing( M );
    
    if HasLeftGlobalDimension( R ) and LeftGlobalDimension( R ) <= 1 then
        return true;
    fi;
    
    TryNextMethod( );
    
end );

##
InstallImmediateMethod( IsPure,
        IsFinitelyPresentedModuleRep and IsTorsion and HasRightActingDomain, 0,
        
  function( M )
    local R;
    
    R := HomalgRing( M );
    
    if HasRightGlobalDimension( R ) and RightGlobalDimension( R ) <= 1 then
        return true;
    fi;
    
    TryNextMethod( );
    
end );

##
InstallImmediateMethod( IsPure,
        IsFinitelyPresentedModuleRep and HasIsTorsion and HasIsTorsionFree, 0,
        
  function( M )
    
    if not IsTorsion( M ) and not IsTorsionFree( M ) then
        return false;
    fi;
    
    TryNextMethod( );
    
end );

####################################
#
# immediate methods for attributes:
#
####################################

##
InstallImmediateMethod( RankOfModule,
        IsFinitelyPresentedModuleRep and IsFree, 0,
        
  function( M )
    
    if HasNrRelations( M ) = true and NrRelations( M ) = 0 then	## NrRelations is not an attribute and HasNrRelations might return fail!
        return NrGenerators( M );
    fi;
    
    TryNextMethod( );
    
end );

##
InstallImmediateMethod( RankOfModule,
        IsFinitelyPresentedModuleRep and IsTorsion, 0,
        
  function( M )
    
    return 0;
    
end );

##
InstallImmediateMethod( DegreeOfTorsionFreeness,
        IsFinitelyPresentedModuleRep and HasIsTorsionFree, 0,
        
  function( M )
    local R;
    
    if not IsTorsionFree( M ) then
        return 0;
    fi;
    
    TryNextMethod( );
    
end );

##
InstallImmediateMethod( CodimOfModule,
        IsFinitelyPresentedModuleRep and IsTorsionFree, 0,
        
  function( M )
    
    return 0;
    
end );

##
InstallImmediateMethod( CodimOfModule,
        IsFinitelyPresentedModuleRep and IsTorsion and HasIsZero and HasLeftActingDomain, 0,
        
  function( M )
    local R;
    
    R := HomalgRing( M );
    
    if not IsZero( M ) and HasLeftGlobalDimension( R ) and LeftGlobalDimension( R ) = 1 then
        return 1;
    fi;
    
    TryNextMethod( );
    
end );

##
InstallImmediateMethod( CodimOfModule,
        IsFinitelyPresentedModuleRep and IsTorsion and HasIsZero and HasRightActingDomain, 0,
        
  function( M )
    local R;
    
    R := HomalgRing( M );
    
    if not IsZero( M ) and HasRightGlobalDimension( R ) and RightGlobalDimension( R ) = 1 then
        return 1;
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
        "for homalg modules",
        [ IsFinitelyPresentedModuleRep ],
        
  function( M )
    
    return NrGenerators( GetRidOfObsoleteGenerators( M ) ) = 0;
    
end );

##
InstallMethod( IsTorsionFree,
        "for homalg modules",
        [ IsFinitelyPresentedModuleRep ],
        
  function( M )
    
    return IsZero( TorsionSubmodule( M ) );
    
end );

##
InstallMethod( IsTorsion,
        "for homalg modules",
        [ IsFinitelyPresentedModuleRep ],
        
  function( M )
    
    return IsZero( TorsionFreeFactor( M ) );
    
end );

##
InstallMethod( IsReflexive,
        "for homalg modules",
        [ IsFinitelyPresentedModuleRep ],
        
  function( M )
    
    return IsTorsionFree( M ) and IsZero( Ext( 2, AuslanderDual( M ) ) );
    
end );

##
InstallMethod( IsProjective,
        "for homalg modules",
        [ IsFinitelyPresentedModuleRep ],
        
  function( M )
    local R, K, proj;
    
    R := HomalgRing( M );
    
    if not ( HasIsCommutative( R ) and IsCommutative( R ) ) then
        TryNextMethod( );
    fi;
    
    K := SyzygiesModule( M );
    
    proj := IsZero( Ext( 1, M, K ) );
    
    if proj then
        M!.UpperBoundForProjectiveDimension := 0;
    fi;
    
    return proj;
    
end );

##
InstallMethod( IsProjective,
        "for homalg modules",
        [ IsFinitelyPresentedModuleRep ],
        
  function( M )
    local proj;
    
    if FiniteFreeResolution( M ) = fail then
        TryNextMethod( );
    fi;
    
    proj := ProjectiveDimension( M ) = 0;
    
    if proj then
        M!.UpperBoundForProjectiveDimension := 0;
    fi;
    
    return proj;
    
end );

##
InstallMethod( IsProjective,
        "for homalg modules",
        [ IsFinitelyPresentedModuleRep ], 1001,
        
  function( M )
    
    if not IsReflexive( M ) then
        return false;
    fi;
    
    TryNextMethod( );
    
end );

##
InstallMethod( IsStablyFree,
        "for homalg modules",
        [ IsFinitelyPresentedModuleRep ],
        
  function( M )
    
    if FiniteFreeResolution( M ) = fail then
        TryNextMethod( );
    fi;
    
    ## Serre's 1955 remark:
    ## for a module with a finite free resolution (FFR)
    ## "projective" and "stably free" are equivalent
    return IsProjective( M );
    
end );

##
InstallMethod( IsFree,
        "for homalg modules",
        [ IsFinitelyPresentedModuleRep ],
        
  function( M )
    local R, good_basis_algorithm, par, img, free;
    
    R := HomalgRing( M );
    
    if HasBasisAlgorithmRespectsPrincipalIdeals( R ) and BasisAlgorithmRespectsPrincipalIdeals( R ) then
        good_basis_algorithm := true;
    else
        good_basis_algorithm := false;
    fi;
    
    if not HasRankOfModule( M ) then
        Resolution( M );			## automatically sets the rank if it succeeds to compute a complete free resolution
    fi;
    
    if HasRankOfModule( M ) and RankOfModule( M ) = 1 then
        par := ParametrizeModule( M );		## this returns a minimal parametrization of M (minimal = cokernel is torsion); I learned this from Alban Quadrat
        if IsMonomorphism( par ) then
            img := MatrixOfMap( par );
            if IsHomalgLeftObjectOrMorphismOfLeftObjects( M ) then
                img := BasisOfRowModule( img );
                free := NrRows( img ) <= 1;	## Plesken: a good notion of basis (involutive/groebner/...) should keep and hence prove a principal (left/right) ideal principal
            else
                img := BasisOfColumnModule( img );
                free := NrColumns( img ) <= 1;
            fi;
            if free then
                return true;
            elif good_basis_algorithm then
                return false;
            fi;
        else
            return false;
        fi;
    fi;
    
    TryNextMethod( );
    
end );

##
InstallMethod( IsFree,
        "for homalg modules",
        [ IsFinitelyPresentedModuleRep ], 501,
        
  function( M )
    
    if FiniteFreeResolution( M ) = fail then
        TryNextMethod( );
    fi;
    
    if not IsStablyFree( M ) then
        return false;
    fi;
    
    TryNextMethod( );
    
end );

##
InstallMethod( IsFree,
        "for homalg modules",
        [ IsFinitelyPresentedModuleRep ], 1001,
        
  function( M )
    local R;
    
    R := HomalgRing( M );
    
    if not HasRankOfModule( M ) then
        ## this should set the rank if it doesn't fail
        if FiniteFreeResolution( M ) = fail then
            TryNextMethod( );
        fi;
    fi;
    
    ## by now RankOfModule will exist and this
    ## should trigger immediate methods to check IsFree
    if  HasIsFree( M ) then
        return IsFree( M );
    fi;
    
    ## FIXME: sometimes the immediate methods are not triggered and do not set IsFree
    if HasIsCommutative( R ) and IsCommutative( R ) and RankOfModule( M ) = 1 then
        return true;			## [Lam06, Theorem I.4.11], this is in principle the Cauchy-Binet formula
    elif HasGeneralLinearRank( R ) and GeneralLinearRank( R ) <= RankOfModule( M ) then
        return true;			## [McCRob, Theorem 11.1.14]
    elif HasElementaryRank( R ) and ElementaryRank( R ) <= RankOfModule( M ) then
        return true;			## [McCRob, Theorem 11.1.14 and Proposition 11.3.11]
    elif HasStableRank( R ) and StableRank( R ) <= RankOfModule( M ) then
        return true;			## [McCRob, Theorem 11.1.14 and Proposition 11.3.11]
    fi;
    
    TryNextMethod( );
    
end );

####################################
#
# methods for attributes:
#
####################################

##
InstallMethod( TheZeroMorphism,
        "for homalg modules",
        [ IsFinitelyPresentedModuleRep ],
        
  function( M )
    
    return HomalgZeroMap( M, 0*M );	## never set its Kernel to M, since a possibly existing NaturalEmbedding in M will be overwritten!
    
end );

##
InstallMethod( TheIdentityMorphism,
        "for homalg modules",
        [ IsFinitelyPresentedModuleRep ],
        
  function( M )
    
    return HomalgIdentityMap( M );
    
end );

##
InstallMethod( RankOfModule,
        "for homalg modules",
        [ IsFinitelyPresentedModuleRep ],
        
  function( M )
    
    Resolution( M );
    
    if HasRankOfModule( M ) then
        return RankOfModule( M );
    fi;
    
    TryNextMethod( );
    
end );

##
InstallMethod( DegreeOfTorsionFreeness,
        "for homalg modules",
        [ IsFinitelyPresentedModuleRep ],
        
  function( M )
    local DM, k, R, left, gdim, bound;
    
    DM := AuslanderDual( M );
    
    if IsTorsionFree( M ) then
        k := 2;
    else
        return 0;
    fi;
    
    if IsReflexive( M ) then
        k := 3;
    fi;	## do not return 1 in case the ring has global dimension 0
    
    R := HomalgRing( M );
    
    left := IsHomalgLeftObjectOrMorphismOfLeftObjects( M );
    
    if left then
        if not HasLeftGlobalDimension( R ) then
            TryNextMethod( );
        fi;
        gdim := LeftGlobalDimension( R );
    else
        if not HasRightGlobalDimension( R ) then
            TryNextMethod( );
        fi;
        gdim := RightGlobalDimension( R );
    fi;
    
    if gdim = infinity then
        bound := BoundForResolution( M );
    else
        bound := gdim;
    fi;
    
    while k <= bound do
        if not IsZero( Ext( k, DM ) ) then
            return k - 1;
        fi;
        k := k + 1;
    od;
    
    if gdim < infinity then
        return gdim;
    fi;
    
    TryNextMethod( );
    
end );

##
InstallMethod( CodimOfModule,
        "for homalg modules",
        [ IsFinitelyPresentedModuleRep ],
        
  function( M )
    local k, R, left, gdim, bound;
    
    if IsTorsion( M ) then
        k := 1;
    else
        return 0;
    fi;
    
    R := HomalgRing( M );
    
    left := IsHomalgLeftObjectOrMorphismOfLeftObjects( M );
    
    if left then
        if not HasLeftGlobalDimension( R ) then
            TryNextMethod( );
        fi;
        gdim := LeftGlobalDimension( R );
    else
        if not HasRightGlobalDimension( R ) then
            TryNextMethod( );
        fi;
        gdim := RightGlobalDimension( R );
    fi;
    
    if gdim = infinity then
        bound := BoundForResolution( M );
    else
        bound := gdim;
    fi;
    
    while k <= bound do
        if not IsZero( Ext( k, M ) ) then
            return k;
        fi;
        k := k + 1;
    od;
    
    if gdim < infinity then
        return gdim;
    fi;
    
    TryNextMethod( );
    
end );

##
InstallMethod( ProjectiveDimension,
        "for homalg modules",
        [ IsFinitelyPresentedModuleRep ],
        
  function( M )
    local d, ld, pd, s;
    
    ## in future Resolution( M ) might compute a free resolution only up to
    ## an a priori known upper bound of the projective dimension (+1), which
    ## would mean that such an "incomplete" resolution is not acyclic in general
    ## and ShortenResolution will not apply. Therefore:
    d := FiniteFreeResolution( M );
    
    if d = fail then
        TryNextMethod( );
    fi;
    
    ld := Length( MorphismDegreesOfComplex( d ) );
    
    d := ShortenResolution( d );
    
    pd := Length( MorphismDegreesOfComplex( d ) );
    
    if pd < ld then
        ResetFilterObj( M, AFiniteFreeResolution );
        SetAFiniteFreeResolution( M, d );
    fi;
    
    ## Serre's 1955 remark:
    ## for a module with a finite free resolution (FFR)
    ## "projective" and "stably free" are equivalent
    ## (so now we check stably freeness)
    if pd = 1 then
        s := PostInverse( LowestDegreeMorphismInComplex( d ) );
        if s <> fail then
            pd := 0;
        fi;
    fi;
    
    return pd;
    
end );

