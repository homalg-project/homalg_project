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
            color := "\033[4;30;46m",
            intrinsic_properties :=
            [ "IsZero",
              "IsFree",
              "IsStablyFree",
              "IsProjective",
              "IsReflexive",
              "IsTorsionFree",
              "IsArtinian",
              "IsCyclic",
              "IsTorsion",
              "IsHolonomic",
              "IsPure",
              "HasConstantRank" ],
            intrinsic_attributes :=
            [ "ElementaryDivisors",
              "RankOfModule",
              "ProjectiveDimension",
              "DegreeOfTorsionFreeness",
              "Codim",
              "PurityFiltration",
              "CodegreeOfPurity",
              "BettiDiagram",
              "CastelnuovoMumfordRegularity" ]
            )
        );

##
InstallValue( LogicalImplicationsForHomalgModules,
        [ ## IsTorsionFree:
          
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
          
          ## IsTorsion:
          
          [ IsZero,
            "implies", IsHolonomic ],
          
          ## [ IsHolonomic,
          ##  "implies", IsTorsion ],	false for fields
          
          ## [ IsHolonomic,
          ##  "implies", IsArtinian ],	there is no clear definition of holonomic
          
          [ IsZero,
            "implies", IsArtinian ],
          
          [ IsZero,
            "implies", IsTorsion ],
          
          ## IsCyclic:
          
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

InstallLogicalImplicationsForHomalgSubobjects(
        List( LIMOD.intrinsic_properties, ValueGlobal ),
        IsFinitelyPresentedSubmoduleRep,
        HasEmbeddingInSuperObject,
        UnderlyingObject );

InstallLogicalImplicationsForHomalgSubobjects(
        List( LIMOD.intrinsic_attributes, ValueGlobal ),
        IsFinitelyPresentedSubmoduleRep,
        HasEmbeddingInSuperObject,
        UnderlyingObject );

####################################
#
# immediate methods for properties:
#
####################################

##
InstallImmediateMethod( IsArtinian,
        IsFinitelyPresentedModuleRep and HasCodim and HasLeftActingDomain, 0,
        
  function( M )
    local R;
    
    R := HomalgRing( M );
    
    if HasLeftGlobalDimension( R ) and
       ( ( HasIsFreePolynomialRing( R ) and IsFreePolynomialRing( R ) ) or
         ( HasIsWeylRing( R ) and IsWeylRing( R ) ) )then
        
        return Codim( M ) = LeftGlobalDimension( R );
        
    fi;
    
    TryNextMethod( );
    
end );

##
InstallImmediateMethod( IsArtinian,
        IsFinitelyPresentedModuleRep and HasCodim and HasRightActingDomain, 0,
        
  function( M )
    local R;
    
    R := HomalgRing( M );
    
    if HasRightGlobalDimension( R ) and
       ( ( HasIsFreePolynomialRing( R ) and IsFreePolynomialRing( R ) ) or
         ( HasIsWeylRing( R ) and IsWeylRing( R ) ) )then
        
        return Codim( M ) = RightGlobalDimension( R );
        
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

## [Coutinho, A Primer of Algebraic D-modules, Thm. 10.25, p. 90]
InstallImmediateMethod( IsCyclic,
        IsFinitelyPresentedModuleRep and IsArtinian, 0,
        
  function( M )
    local R;
    
    R := HomalgRing( M );
    
    if not ( HasIsSimpleRing( R ) and IsSimpleRing( R ) ) then
        TryNextMethod( );
    fi;
    
    if IsHomalgLeftObjectOrMorphismOfLeftObjects( M ) then
        if HasIsLeftNoetherian( R ) and IsLeftNoetherian( R ) and
           HasIsLeftArtinian( R ) and not IsLeftArtinian( R ) then
            return true;
        fi;
    else
        if HasIsRightNoetherian( R ) and IsRightNoetherian( R ) and
           HasIsRightArtinian( R ) and not IsRightArtinian( R ) then
            return true;
        fi;
    fi;
    
    TryNextMethod( );
    
end );

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
InstallImmediateMethod( IsTorsion,
        IsFinitelyPresentedModuleRep and HasCodim, 0,
        
  function( M )
    
    if Codim( M ) > 0 then
        return true;
    elif HasIsZero( M ) and not IsZero( M ) then
        return false;
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
InstallImmediateMethod( IsTorsionFree,
        IsFinitelyPresentedModuleRep and HasCodim, 0,
        
  function( M )
    
    if IsPosInt( Codim( M ) ) then
        return false;
    fi;
    
    TryNextMethod( );
    
end );

##
InstallImmediateMethod( IsTorsionFree,
        IsFinitelyPresentedModuleRep and HasCodim and IsPure, 0,
        
  function( M )
    
    return Codim( M ) in [ 0, infinity ];
    
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
InstallImmediateMethod( IsReflexive,
        IsFinitelyPresentedModuleRep and IsTorsionFree and HasCodegreeOfPurity, 0,
        
  function( M )
    
    return CodegreeOfPurity( M ) = [ 0 ];
    
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
        IsFinitelyPresentedModuleRep and HasCodim and HasLeftActingDomain, 0,
        
  function( M )
    local R;
    
    R := HomalgRing( M );
    
    if HasLeftGlobalDimension( R ) and LeftGlobalDimension( R ) = Codim( M ) then
        return true;
    fi;
    
    TryNextMethod( );
    
end );

##
InstallImmediateMethod( IsPure,
        IsFinitelyPresentedModuleRep and HasCodim and HasRightActingDomain, 0,
        
  function( M )
    local R;
    
    R := HomalgRing( M );
    
    if HasRightGlobalDimension( R ) and RightGlobalDimension( R ) = Codim( M ) then
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
        IsFinitelyPresentedModuleRep and HasRightActingDomain, 0,
        
  function( M )
    local m;
    
    if HasNrGenerators( M ) and HasNrRelations( M ) = true then	## NrRelations is not an attribute and HasNrRelations might return fail!
        
        m := MatrixOfRelations( M );
        
        if HasIsRightRegularMatrix( m ) and IsRightRegularMatrix( m ) then
            return NrRows( m ) - NrColumns( m );
        fi;
        
    fi;
    
    TryNextMethod( );
    
end );

##
InstallImmediateMethod( RankOfModule,
        IsFinitelyPresentedModuleRep and HasLeftActingDomain, 0,
        
  function( M )
    local m;
    
    if HasNrGenerators( M ) and HasNrRelations( M ) = true then	## NrRelations is not an attribute and HasNrRelations might return fail!
        
        m := MatrixOfRelations( M );
        
        if HasIsLeftRegularMatrix( m ) and IsLeftRegularMatrix( m ) then
            return NrColumns( m ) - NrRows( m );
        fi;
        
    fi;
    
    TryNextMethod( );
    
end );

##
InstallImmediateMethod( RankOfModule,
        IsFinitelyPresentedModuleRep and HasPurityFiltration, 0,
        
  function( M )
    local M0;
    
    M0 := CertainObject( PurityFiltration( M ), 0 );
    
    if HasRankOfModule( M0 ) then
        return RankOfModule( M0 );
    fi;
    
    TryNextMethod( );
    
end );

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
InstallImmediateMethod( DegreeOfTorsionFreeness,
        IsFinitelyPresentedModuleRep and IsProjective, 0,
        
  function( M )
    
    return infinity;
    
end );

##
InstallImmediateMethod( Codim,
        IsFinitelyPresentedModuleRep and IsTorsionFree and HasIsZero, 0,
        
  function( M )
    
    if not IsZero( M ) then
        return 0;
    else
        return infinity;
    fi;
    
end );

##
InstallImmediateMethod( Codim,
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
InstallImmediateMethod( Codim,
        IsFinitelyPresentedModuleRep and IsTorsion and HasIsZero and HasRightActingDomain, 0,
        
  function( M )
    local R;
    
    R := HomalgRing( M );
    
    if not IsZero( M ) and HasRightGlobalDimension( R ) and RightGlobalDimension( R ) = 1 then
        return 1;
    fi;
    
    TryNextMethod( );
    
end );

##
InstallImmediateMethod( Codim,
        IsFinitelyPresentedModuleRep and IsZero, 10001,
        
  function( M )
    
    return infinity;
    
end );

##
InstallImmediateMethod( CodegreeOfPurity,
        IsFinitelyPresentedModuleRep and IsZero, 0,
        
  function( M )
    
    return [ 0 ];
    
end );

##
InstallImmediateMethod( CodegreeOfPurity,
        IsFinitelyPresentedModuleRep and HasIsPure, 0,
        
  function( M )
    
    if not IsPure( M ) then
        return infinity;
    fi;
    
    TryNextMethod( );
    
end );

##
InstallImmediateMethod( CodegreeOfPurity,
        IsFinitelyPresentedModuleRep and HasIsReflexive, 0,
        
  function( M )
    
    if IsReflexive( M ) then
        return [ 0 ];
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
        "LIMOD: for homalg modules",
        [ IsFinitelyPresentedModuleRep ],
        
  function( M )
    
    return NrGenerators( GetRidOfObsoleteGenerators( M ) ) = 0;
    
end );

##
InstallMethod( IsArtinian,
        "LIMOD: for homalg modules",
        [ IsFinitelyPresentedModuleRep ],
        
  function( M )
    local R;
    
    R := HomalgRing( M );
    
    if HasGlobalDimension( R ) and	## FIXME: declare an appropriate property for such rings
       ( ( HasIsIntegersForHomalg( R ) and IsIntegersForHomalg( R ) ) or
         ( HasIsFreePolynomialRing( R ) and IsFreePolynomialRing( R ) ) or
         ( HasIsWeylRing( R ) and IsWeylRing( R ) ) ) then
        
        return Codim( M ) >= GlobalDimension( R );
        
    fi;
    
    TryNextMethod( );
    
end );

##
InstallMethod( IsCyclic,
        "LIMOD: for homalg modules",
        [ IsFinitelyPresentedModuleRep ],
        
  function( M )
    
    ByASmallerPresentation( M );
    
    if HasIsCyclic( M ) then
        return IsCyclic( M );
    fi;
    
    TryNextMethod( );
    
end );

##
RedispatchOnCondition( IsCyclic, true, [ IsFinitelyPresentedModuleRep ], [ IsArtinian ], 0 );

##
InstallMethod( IsTorsion,
        "LIMOD: for homalg modules",
        [ IsFinitelyPresentedModuleRep ],
        
  function( M )
    
    return IsZero( TorsionFreeFactor( M ) );
    
end );

##
InstallMethod( IsTorsionFree,
        "LIMOD: for homalg modules",
        [ IsFinitelyPresentedModuleRep ],
        
  function( M )
    
    return IsZero( TorsionSubmodule( M ) );
    
end );

##
InstallMethod( IsReflexive,
        "LIMOD: for homalg modules",
        [ IsFinitelyPresentedModuleRep ],
        
  function( M )
    
    return IsTorsionFree( M ) and IsZero( Ext( 2, AuslanderDual( M ) ) );
    
end );

##
InstallMethod( IsReflexive,
        "LIMOD: for homalg modules",
        [ IsFinitelyPresentedModuleRep and HasCodegreeOfPurity ],
        
  function( M )
    
    return IsTorsionFree( M ) and CodegreeOfPurity( M ) = [ 0 ];
    
end );

##
InstallMethod( IsReflexive,
        "LIMOD: for homalg modules",
        [ IsFinitelyPresentedModuleRep and HasLeftActingDomain ],
        
  function( M )
    local R;
    
    R := HomalgRing( M );
    
    if HasLeftGlobalDimension( R ) and LeftGlobalDimension( R ) <= 1 then
        return IsTorsionFree( M );
    fi;
    
    TryNextMethod( );
    
end );

##
InstallMethod( IsReflexive,
        "LIMOD: for homalg modules",
        [ IsFinitelyPresentedModuleRep and HasRightActingDomain ],
        
  function( M )
    local R;
    
    R := HomalgRing( M );
    
    if HasRightGlobalDimension( R ) and RightGlobalDimension( R ) <= 1 then
        return IsTorsionFree( M );
    fi;
    
    TryNextMethod( );
    
end );

##
InstallMethod( IsProjective,
        "LIMOD: for homalg modules",
        [ IsFinitelyPresentedModuleRep ],
        
  function( M )
    local R, proj;
    
    R := HomalgRing( M );
    
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
        "LIMOD: for homalg modules",
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
        "LIMOD: for homalg modules",
        [ IsFinitelyPresentedModuleRep ],
        
  function( M )
    local R, proj;
    
    R := HomalgRing( M );
    
    if not ( HasIsFiniteFreePresentationRing( R ) and IsFiniteFreePresentationRing( R ) ) then
        TryNextMethod( );
    fi;
    
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
        "LIMOD: for homalg modules",
        [ IsFinitelyPresentedModuleRep and HasLeftActingDomain ],
        
  function( M )
    local R;
    
    R := HomalgRing( M );
    
    if HasLeftGlobalDimension( R ) and LeftGlobalDimension( R ) < infinity then
        return DegreeOfTorsionFreeness( M ) = infinity;
    fi;
    
    TryNextMethod( );
    
end );

##
InstallMethod( IsProjective,
        "LIMOD: for homalg modules",
        [ IsFinitelyPresentedModuleRep and HasRightActingDomain ],
        
  function( M )
    local R;
    
    R := HomalgRing( M );
    
    if HasRightGlobalDimension( R ) and RightGlobalDimension( R ) < infinity then
        return DegreeOfTorsionFreeness( M ) = infinity;
    fi;
    
    TryNextMethod( );
    
end );

##
InstallMethod( IsProjective,
        "LIMOD: for homalg modules",
        [ IsFinitelyPresentedModuleRep and HasLeftActingDomain ],
        
  function( M )
    local R;
    
    R := HomalgRing( M );
    
    if HasLeftGlobalDimension( R ) and LeftGlobalDimension( R ) <= 2 then
        return IsReflexive( M );
    fi;
    
    TryNextMethod( );
    
end );

##
InstallMethod( IsProjective,
        "LIMOD: for homalg modules",
        [ IsFinitelyPresentedModuleRep and HasRightActingDomain ],
        
  function( M )
    local R;
    
    R := HomalgRing( M );
    
    if HasRightGlobalDimension( R ) and RightGlobalDimension( R ) <= 2 then
        return IsReflexive( M );
    fi;
    
    TryNextMethod( );
    
end );

##
InstallMethod( IsProjective,
        "LIMOD: for homalg modules",
        [ IsFinitelyPresentedModuleRep ], 1001,
        
  function( M )
    
    if not IsReflexive( M ) then
        return false;
    fi;
    
    TryNextMethod( );
    
end );

##
InstallMethod( IsStablyFree,
        "LIMOD: for homalg modules",
        [ IsFinitelyPresentedModuleRep ],
        
  function( M )
    
    if not IsProjective( M ) then
        return false;
    fi;
    
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
        "LIMOD: for homalg modules",
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
            ## Plesken: a good notion of basis (involutive/groebner/...)
            ## should respect principal ideals and hence,
            ## due to the uniqueness of the basis,
            ## can be used to decide if an ideal is principal or not
            if IsHomalgLeftObjectOrMorphismOfLeftObjects( M ) then
                img := BasisOfRows( img );
                free := NrRows( img ) <= 1;
            else
                img := BasisOfColumns( img );
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
        "LIMOD: for homalg modules",
        [ IsFinitelyPresentedModuleRep ], 1001,
        
  function( M )
    local R;
    
    R := HomalgRing( M );
    
    if not IsStablyFree( M ) then
        return false;
    fi;
    
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
    
    if IsStablyFree( M ) then
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
    fi;
    
    TryNextMethod( );
    
end );

##
InstallMethod( IsPure,
        "LIMOD: for homalg modules",
        [ IsFinitelyPresentedModuleRep ],
        
  function( M )
    
    PurityFiltration( M );
    
    if HasIsPure( M ) then
        return IsPure( M );
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
        "LIMOD: for homalg modules",
        [ IsFinitelyPresentedModuleRep ],
        
  function( M )
    
    return HomalgZeroMap( M, 0*M );	## never set its Kernel to M, since a possibly existing NaturalGeneralizedEmbedding in M will be overwritten!
    
end );

##
InstallMethod( TheIdentityMorphism,
        "LIMOD: for homalg modules",
        [ IsFinitelyPresentedModuleRep ],
        
  function( M )
    
    return HomalgIdentityMap( M );
    
end );

##
InstallMethod( FullSubmodule,
        "LIMOD: for homalg modules",
        [ IsFinitelyPresentedModuleRep ],
        
  function( M )
    
    return Subobject( HomalgIdentityMatrix( NrGenerators( M ), HomalgRing( M ) ), M );
    
end );

##
InstallMethod( RankOfModule,
        "LIMOD: for homalg modules",
        [ IsFinitelyPresentedModuleRep ],
        
  function( M )
    
    Resolution( M );
    
    if HasRankOfModule( M ) then
        return RankOfModule( M );
    fi;
    
    TryNextMethod( );
    
end );

##
InstallMethod( Rank,
        "LIMOD: for homalg submodules",
        [ IsFinitelyPresentedSubmoduleRep ],
        
  function( M )
    
    return Rank( UnderlyingObject( M ) );
    
end );

##
InstallMethod( Rank,
        "LIMOD: for homalg modules",
        [ IsFinitelyPresentedModuleRep ],
        
  function( M )
    
    return RankOfModule( M );
    
end );

##
InstallMethod( DegreeOfTorsionFreeness,
        "LIMOD: for homalg modules",
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
        return infinity;
    fi;
    
    TryNextMethod( );
    
end );

##
InstallMethod( Codim,
        "LIMOD: for homalg modules",
        [ IsFinitelyPresentedModuleRep ],
        
  function( M )
    local k, R, left, gdim, bound;
    
    if IsZero( M ) then
        return infinity;
    elif IsTorsion( M ) then
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
        "LIMOD: for homalg modules",
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
        s := PostInverse( LowestDegreeMorphism( d ) );
        if not IsBool( s ) then
            pd := 0;
        fi;
    fi;
    
    return pd;
    
end );

##
InstallMethod( CodegreeOfPurity,
        "LIMOD: for homalg modules",
        [ IsFinitelyPresentedModuleRep ],
        
  function( M )
    
    PurityFiltration( M );
    
    if HasCodegreeOfPurity( M ) then
        return CodegreeOfPurity( M );
    fi;
    
    TryNextMethod( );
    
end );

##
InstallMethod( CodegreeOfPurity,
        "LIMOD: for homalg modules",
        [ IsFinitelyPresentedModuleRep ], 1001,
        
  function( M )
    
    if IsReflexive( M ) then
        return [ 0 ];
    fi;
    
    TryNextMethod( );
    
end );

##
InstallMethod( CodegreeOfPurity,
        "LIMOD: for homalg modules",
        [ IsFinitelyPresentedModuleRep ], 1001,
        
  function( M )
    
    if not IsTorsionFree( M ) and not IsTorsion( M ) then
        return infinity;
    fi;
    
    TryNextMethod( );
    
end );

##
InstallMethod( CastelnuovoMumfordRegularity,
        "LIMOD: for homalg modules",
        [ IsFinitelyPresentedModuleRep ],
        
  function( M )
    local betti, degrees;
    
    betti := BettiDiagram( Resolution( M ) );
    
    degrees := RowDegreesOfBettiDiagram( betti );
    
    return degrees[Length(degrees)];
    
end );

##
InstallMethod( BettiDiagram,
        "LIMOD: for homalg modules",
        [ IsFinitelyPresentedModuleRep ],
        
  function( M )
    local C, degrees, min, C_degrees, l, ll, r, beta;
    
    if not IsList( DegreesOfGenerators( M ) ) then
        Error( "the module was not created as a graded module\n" );
    fi;
    
    ## M = coker( F_0 <-- F_1 )
    C := Resolution( 1, M );
    
    ## [ F_0, F_1 ];
    C := ObjectsOfComplex( C ){[ 1 .. 2 ]};
    
    ## the list of generators degrees of F_0 and F_1
    degrees := List( C, DegreesOfGenerators );
    
    ## the homological degrees of the resolution complex C: F_0 <- F_1
    C_degrees := [ 0 .. 1 ];
    
    ## a counting list
    l := [ 1 .. Length( C_degrees ) ];
    
    ## the non-empty list
    ll := Filtered( l, j -> degrees[j] <> [ ] );
    
    ## the degree of the lowest row in the Betti diagram
    if ll <> [ ] then
        r := MaximumList( List( ll, j -> MaximumList( degrees[j] ) - ( j - 1 ) ) );
    else
        r := 0;
    fi;
    
    ## the lowest generator degree of F_0
    if degrees[1] <> [ ] then
        min := MinimumList( degrees[1] );
    else
        min := r;
    fi;
    
    ## the row range of the Betti diagram
    r := [ min .. r ];
    
    ## the Betti table
    beta := List( r, i -> List( l, j -> Length( Filtered( degrees[j], a -> a = i + ( j - 1 ) ) ) ) );
    
    return HomalgBettiDiagram( beta, r, C_degrees, M );
    
end );

##
InstallMethod( EmbeddingInSuperObject,
        "for homalg submodules",
        [ IsFinitelyPresentedSubmoduleRep ],
        
  function( M )
    
    return ImageModuleEmb( M!.map_having_subobject_as_its_image );
    
end );

##
InstallMethod( FactorObject,
        "for homalg submodules",
        [ IsFinitelyPresentedSubmoduleRep ],
        
  function( N )
    
    return FullSubmodule( SuperObject( N ) ) / N;
    
end );

##
InstallMethod( ResidueClassRing,
        "for homalg ideals",
        [ IsFinitelyPresentedSubmoduleRep and ConstructedAsAnIdeal ],
        
  function( J )
    local A, ring_rel, R;
    
    A := HomalgRing( J );
    
    Assert( 1, not J = A );
    
    ring_rel := MatrixOfGenerators( J );
    
    if IsHomalgLeftObjectOrMorphismOfLeftObjects( J ) then
        ring_rel := HomalgRelationsForLeftModule( ring_rel );
    else
        ring_rel := HomalgRelationsForRightModule( ring_rel );
    fi;
    
    R := A / ring_rel;
    
    if HasContainsAField( A ) and ContainsAField( A ) then
        SetContainsAField( R, true );
        if HasCoefficientsRing( A ) then
            SetCoefficientsRing( R, CoefficientsRing( A ) );
        fi;
    fi;
    
    SetDefiningIdeal( R, J );
    
    return R;
    
end );

