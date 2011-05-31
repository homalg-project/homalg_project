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
            intrinsic_properties := LIOBJ.intrinsic_properties,
            intrinsic_attributes := LIOBJ.intrinsic_attributes,
            )
        );

Append( LIMOD.intrinsic_properties,
        [ 
          "IsFree",
          "IsStablyFree",
          "IsCyclic",
          "IsHolonomic",
          "HasConstantRank",
          ] );

Append( LIMOD.intrinsic_attributes,
        [ 
          "ElementaryDivisors",
          ] );

##
InstallValue( LogicalImplicationsForHomalgModules,
        [ 
          ## IsTorsionFree:
          
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
          
          ## IsTorsion:
          
          [ IsZero,
            "implies", IsHolonomic ],
          
          ## [ IsHolonomic,
          ##  "implies", IsTorsion ],	false for fields
          
          ## [ IsHolonomic,
          ##  "implies", IsArtinian ],	there is no clear definition of holonomic
          
          ] );

##
InstallValue( LogicalImplicationsForHomalgModulesOverSpecialRings,
        [ ## logical implications for modules over special rings
          
          ## Kaplansky's theorem [Lam06, Theorem II.2.2]
          [ [ IsTorsionFree ],
            HomalgRing,
            [ [ IsLeftHereditary, IsRightHereditary, IsHereditary ] ],
            "imply", IsProjective ],
          
          ## Serre's 1955 remark
          [ [ IsProjective ],
            HomalgRing,
            [ [ IsFiniteFreePresentationRing,
                IsLeftFiniteFreePresentationRing,
                IsRightFiniteFreePresentationRing ] ],
            "imply", IsStablyFree ],
          
          ## by definition [Lam06, Definition I.4.6]
          [ [ IsStablyFree ],
            HomalgRing,
            [ [ IsLeftHermite, IsRightHermite, IsHermite ] ],
            "imply", IsFree ],
          
          ] );

####################################
#
# logical implications methods:
#
####################################

InstallLogicalImplicationsForHomalgObjects( LogicalImplicationsForHomalgModules, IsHomalgModule );

InstallLogicalImplicationsForHomalgObjects( LogicalImplicationsForHomalgModulesOverSpecialRings, IsHomalgModule, IsHomalgRing );

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
        IsFinitelyPresentedModuleRep and HasGrade, 0,
        
  function( M )
    local R, global_dimension;
    
    R := HomalgRing( M );
    
    if IsHomalgLeftObjectOrMorphismOfLeftObjects( M ) then
        global_dimension := LeftGlobalDimension;
    else
        global_dimension := RightGlobalDimension;
    fi;
    
    if Tester( global_dimension )( R ) and
       ( ( HasIsFreePolynomialRing( R ) and IsFreePolynomialRing( R ) ) or
         ( HasIsWeylRing( R ) and IsWeylRing( R ) ) or
         ( HasIsLocalizedWeylRing( R ) and IsLocalizedWeylRing( R ) ) ) then
        
        return Grade( M ) = global_dimension( R );
        
    fi;
    
    TryNextMethod( );
    
end );

## a presentation must be on a single generator
InstallImmediateMethod( IsCyclic,
        IsFinitelyPresentedModuleRep, 0,
        
  function( M )
    local l, p, rel;
    
    l := ListOfPositionsOfKnownSetsOfRelations( M );
    
    for p in l do;
        
        rel := SetsOfRelations( M )!.(p);
        
        if IsHomalgRelations( rel ) then
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
    local l, p, rel;
    
    l := ListOfPositionsOfKnownSetsOfRelations( M );
    
    for p in l do;
        
        rel := SetsOfRelations( M )!.(p);
        
        if IsHomalgRelations( rel ) then
            if HasNrGenerators( rel ) and HasNrRelations( rel ) and
               NrGenerators( rel ) > NrRelations( rel ) then
                return false;
            fi;
        fi;
        
    od;
    
    TryNextMethod( );
    
end );

## a non trivial set of relations for a single generator over a domain => IsTorsion
InstallImmediateMethod( IsTorsion,
        IsFinitelyPresentedModuleRep and IsCyclic, 0,
        
  function( M )
    local l, p, rel, R, torsion;
    
    l := ListOfPositionsOfKnownSetsOfRelations( M );
    for p in l do;
        
        rel := SetsOfRelations( M )!.(p);
        
        if IsHomalgRelations( rel ) and HasEvaluatedMatrixOfRelations( rel ) then
            if HasNrGenerators( rel ) and NrGenerators( rel ) = 1 and
               HasIsZero( MatrixOfRelations( rel ) ) then
                
                R := HomalgRing( rel );
                
                if HasIsIntegralDomain( R ) and IsIntegralDomain( R ) then
                    
                    torsion := not IsZero( MatrixOfRelations( rel ) );
                    
                    SetIsTorsion( rel, torsion );
                    
                    return torsion;
                    
                fi;
            fi;
        fi;
        
    od;
    
    TryNextMethod( );
    
end );

##
InstallImmediateMethod( IsTorsionFree,
        IsFinitelyPresentedModuleRep and HasIsProjective, 0,
        
  function( M )
    local R, global_dimension;
    
    R := HomalgRing( M );
    
    if IsHomalgLeftObjectOrMorphismOfLeftObjects( M ) then
        global_dimension := LeftGlobalDimension;
    else
        global_dimension := RightGlobalDimension;
    fi;
    
    if Tester( global_dimension )( R ) and global_dimension( R ) <= 1 and not IsProjective( M ) then
        return false;
    fi;			## the true case is taken care of elsewhere
    
    TryNextMethod( );
    
end );

##
InstallImmediateMethod( IsReflexive,
        IsFinitelyPresentedModuleRep and HasIsProjective, 0,
        
  function( M )
    local R, global_dimension;
    
    R := HomalgRing( M );
    
    if IsHomalgLeftObjectOrMorphismOfLeftObjects( M ) then
        global_dimension := LeftGlobalDimension;
    else
        global_dimension := RightGlobalDimension;
    fi;
    
    if Tester( global_dimension )( R ) and global_dimension( R ) <= 2 and not IsProjective( M ) then
        return false;
    fi;			## the true case is taken care of elsewhere
    
    TryNextMethod( );
    
end );

##
InstallImmediateMethod( IsProjective,
        IsFinitelyPresentedModuleRep and IsTorsionFree, 0,
        
  function( M )
    local R, global_dimension;
    
    R := HomalgRing( M );
    
    if IsHomalgLeftObjectOrMorphismOfLeftObjects( M ) then
        global_dimension := LeftGlobalDimension;
    else
        global_dimension := RightGlobalDimension;
    fi;
    
    if Tester( global_dimension )( R ) and global_dimension( R ) <= 1 then
        return true;
    fi;			## the false case is taken care of elsewhere
    
    TryNextMethod( );
    
end );

##
InstallImmediateMethod( IsProjective,
        IsFinitelyPresentedModuleRep and IsReflexive, 0,
        
  function( M )
    local R, global_dimension;
    
    R := HomalgRing( M );
    
    if IsHomalgLeftObjectOrMorphismOfLeftObjects( M ) then
        global_dimension := LeftGlobalDimension;
    else
        global_dimension := RightGlobalDimension;
    fi;
    
    if Tester( global_dimension )( R ) and global_dimension( R ) <= 2 then
        return true;
    fi;
    
    TryNextMethod( );
    
end );

##
InstallImmediateMethod( IsFree,
        IsFinitelyPresentedModuleRep, 0,
        
  function( M )
    
    ## NrRelations is not an attribute and HasNrRelations might return fail!
    if HasNrRelations( M ) = true and NrRelations( M ) = 0 then
        return true;
    fi;
    
    TryNextMethod( );
    
end );

##
InstallImmediateMethod( IsFree,
        IsFinitelyPresentedModuleRep and IsTorsionFree and HasRankOfObject, 0,
        
  function( M )
    local R;
    
    ## HasNrGenerators is allowed to return fail
    if HasNrGenerators( M ) = true and
       RankOfObject( M ) = NrGenerators( M ) then
        return true;
    fi;
    
    TryNextMethod( );
    
end );

##
InstallImmediateMethod( IsFree,
        IsFinitelyPresentedModuleRep and IsStablyFree and HasRankOfObject, 0,
        
  function( M )
    local R;
    
    R := HomalgRing( M );
    
    if HasIsCommutative( R ) and IsCommutative( R ) and RankOfObject( M ) = 1 then
        ## [Lam06, Theorem I.4.11], this is in principle the Cauchy-Binet formula
        return true;
    elif HasGeneralLinearRank( R ) and GeneralLinearRank( R ) <= RankOfObject( M ) then
        ## [McCRob, Theorem 11.1.14]
        return true;
    elif HasElementaryRank( R ) and ElementaryRank( R ) <= RankOfObject( M ) then
        ## [McCRob, Theorem 11.1.14 and Proposition 11.3.11]
        return true;
    elif HasStableRank( R ) and StableRank( R ) <= RankOfObject( M ) then
        ## [McCRob, Theorem 11.1.14 and Proposition 11.3.11]
        return true;
    fi;
    
    TryNextMethod( );
    
end );

##
InstallImmediateMethod( IsPure,
        IsFinitelyPresentedModuleRep and IsTorsion, 0,
        
  function( M )
    local R, global_dimension;
    
    R := HomalgRing( M );
    
    if IsHomalgLeftObjectOrMorphismOfLeftObjects( M ) then
        global_dimension := LeftGlobalDimension;
    else
        global_dimension := RightGlobalDimension;
    fi;
    
    if Tester( global_dimension )( R ) and global_dimension( R ) <= 1 then
        return true;
    fi;
    
    TryNextMethod( );
    
end );

##
InstallImmediateMethod( IsPure,
        IsFinitelyPresentedModuleRep and HasGrade, 0,
        
  function( M )
    local R, global_dimension;
    
    R := HomalgRing( M );
    
    if IsHomalgLeftObjectOrMorphismOfLeftObjects( M ) then
        global_dimension := LeftGlobalDimension;
    else
        global_dimension := RightGlobalDimension;
    fi;
    
    if Tester( global_dimension )( R ) and global_dimension( R ) = Grade( M ) then
        return true;
    fi;
    
    TryNextMethod( );
    
end );

####################################
#
# immediate methods for attributes:
#
####################################

##
InstallImmediateMethod( RankOfObject,
        IsFinitelyPresentedModuleRep, 0,
        
  function( M )
    local m;
    
    ## NrRelations is not an attribute and HasNrRelations might return fail!
    if HasNrGenerators( M ) and HasNrRelations( M ) = true then
        
        m := MatrixOfRelations( M );
        
        if IsHomalgLeftObjectOrMorphismOfLeftObjects( M ) then
            if HasIsLeftRegular( m ) and IsLeftRegular( m ) then
                return NrColumns( m ) - NrRows( m );
            fi;
        else
            if HasIsRightRegular( m ) and IsRightRegular( m ) then
                return NrRows( m ) - NrColumns( m );
            fi;
        fi;
        
    fi;
    
    TryNextMethod( );
    
end );

##
InstallImmediateMethod( RankOfObject,
        IsFinitelyPresentedModuleRep and IsFree, 0,
        
  function( M )
    
    ## NrRelations is not an attribute and HasNrRelations might return fail!
    if HasNrRelations( M ) = true and NrRelations( M ) = 0 then
        return NrGenerators( M );
    fi;
    
    TryNextMethod( );
    
end );

##
InstallImmediateMethod( Grade,
        IsFinitelyPresentedModuleRep and IsTorsion and HasIsZero, 0,
        
  function( M )
    local R, global_dimension;
    
    R := HomalgRing( M );
    
    if IsHomalgLeftObjectOrMorphismOfLeftObjects( M ) then
        global_dimension := LeftGlobalDimension;
    else
        global_dimension := RightGlobalDimension;
    fi;
    
    if not IsZero( M ) and Tester( global_dimension )( R ) and global_dimension( R ) = 1 then
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
        "LIMOD: for homalg submodules",
        [ IsFinitelyPresentedSubmoduleRep ],
        
  function( M )
    
    return IsZero( DecideZero( MatrixOfSubobjectGenerators( M ), SuperObject( M ) ) );
    
end );

##
InstallMethod( IsZero,
        "LIMOD: for homalg modules",
        [ IsFinitelyPresentedModuleRep ],
        
  function( M )
    
    return NrGenerators( GetRidOfObsoleteGenerators( M ) ) = 0;
    
end );

##
InstallMethod( IsZero,
        "LIMOD: for homalg modules",
        [ IsFinitelyPresentedModuleRep and HasUnderlyingSubobject ],
        
  function( M )
    local N;
    
    N := UnderlyingSubobject( M );
    
    if HasNrRelations( M ) and
       NrGenerators( M ) <= NrGenerators( SuperObject( N ) ) then
        TryNextMethod( );
    fi;
    
    ## avoids computing syzygies
    return IsZero( N );
    
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
         ( HasIsWeylRing( R ) and IsWeylRing( R ) ) or
         ( HasIsLocalizedWeylRing( R ) and IsLocalizedWeylRing( R ) ) ) then
        
        return Grade( M ) >= GlobalDimension( R );
        
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
InstallMethod( IsHolonomic,
        "LIMOD: for homalg modules",
        [ IsFinitelyPresentedModuleRep ],
        
  function( M )
    local R;
    
    R := HomalgRing( M );
    
    if HasGlobalDimension( R ) and	## FIXME: declare an appropriate property for such rings
       ( ( HasIsIntegersForHomalg( R ) and IsIntegersForHomalg( R ) ) or
         ( HasIsFreePolynomialRing( R ) and IsFreePolynomialRing( R ) ) or
         ( HasIsWeylRing( R ) and IsWeylRing( R ) ) or
         ( HasIsLocalizedWeylRing( R ) and IsLocalizedWeylRing( R ) ) ) then
        
        return IsArtinian( M );
        
    fi;
    
    TryNextMethod( );
    
end );

##
InstallMethod( IsReflexive,
        "LIMOD: for homalg modules",
        [ IsFinitelyPresentedModuleRep ],
        
  function( M )
    local R, global_dimension;
    
    R := HomalgRing( M );
    
    if IsHomalgLeftObjectOrMorphismOfLeftObjects( M ) then
        global_dimension := LeftGlobalDimension;
    else
        global_dimension := RightGlobalDimension;
    fi;
    
    if Tester( global_dimension )( R ) and global_dimension( R ) <= 1 then
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
    
    K := SyzygiesObject( M );
    
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
        [ IsFinitelyPresentedModuleRep ],
        
  function( M )
    local R, global_dimension;
    
    R := HomalgRing( M );
    
    if IsHomalgLeftObjectOrMorphismOfLeftObjects( M ) then
        global_dimension := LeftGlobalDimension;
    else
        global_dimension := RightGlobalDimension;
    fi;
    
    if Tester( global_dimension )( R ) and global_dimension( R ) < infinity then
        return DegreeOfTorsionFreeness( M ) = infinity;
    fi;
    
    TryNextMethod( );
    
end );

##
InstallMethod( IsProjective,
        "LIMOD: for homalg modules",
        [ IsFinitelyPresentedModuleRep ],
        
  function( M )
    local R, global_dimension;
    
    R := HomalgRing( M );
    
    if IsHomalgLeftObjectOrMorphismOfLeftObjects( M ) then
        global_dimension := LeftGlobalDimension;
    else
        global_dimension := RightGlobalDimension;
    fi;
    
    if Tester( global_dimension )( R ) and global_dimension( R ) <= 2 then
        return IsReflexive( M );
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
    local R, par, img, free;
    
    R := HomalgRing( M );
    
    if not HasRankOfObject( M ) then
        ## automatically sets the rank if it succeeds
        ## to compute a complete free resolution:
        Resolution( M );
    fi;
    
    if HasRankOfObject( M ) and RankOfObject( M ) = 1 then
        
        ## this returns a minimal parametrization of M
        ## (minimal = cokernel is torsion);
        ## I learned this from Alban Quadrat
        par := MinimalParametrization( M );
        
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
            elif HasBasisAlgorithmRespectsPrincipalIdeals( R ) and
              BasisAlgorithmRespectsPrincipalIdeals( R ) then
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
    
    if not HasRankOfObject( M ) then
        ## this should set the rank if it doesn't fail
        if FiniteFreeResolution( M ) = fail then
            TryNextMethod( );
        fi;
    fi;
    
    ## by now RankOfObject will exist and this
    ## should trigger immediate methods to check IsFree
    if  HasIsFree( M ) then
        return IsFree( M );
    fi;
    
    if IsStablyFree( M ) then
        ## FIXME: sometimes the immediate methods are not triggered and do not set IsFree
        if HasIsCommutative( R ) and IsCommutative( R ) and RankOfObject( M ) = 1 then
            ## [Lam06, Theorem I.4.11], this is in principle the Cauchy-Binet formula
            return true;
        elif HasGeneralLinearRank( R ) and GeneralLinearRank( R ) <= RankOfObject( M ) then
            ## [McCRob, Theorem 11.1.14]
            return true;
        elif HasElementaryRank( R ) and ElementaryRank( R ) <= RankOfObject( M ) then
            ## [McCRob, Theorem 11.1.14 and Proposition 11.3.11]
            return true;
        elif HasStableRank( R ) and StableRank( R ) <= RankOfObject( M ) then
            ## [McCRob, Theorem 11.1.14 and Proposition 11.3.11]
            return true;
        fi;
    fi;
    
    TryNextMethod( );
    
end );

####################################
#
# methods for attributes:
#
####################################

##
InstallMethod( TorsionSubobject,
        "LIMOD: for homalg modules",
        [ IsHomalgModule ],
        
  function( M )
    local par, emb, tor;
    
    if HasIsTorsion( M ) and IsTorsion( M ) then
        return FullSubobject( M );
    fi;
    
    ## compute any parametrization since computing
    ## a "minimal" parametrization requires the
    ## rank which if unknown would probably trigger Resolution
    par := AnyParametrization( M );
    
    tor := KernelSubobject( par );
    
    SetIsTorsion( tor, true );
    
    return tor;
    
end );

##
InstallMethod( TheMorphismToZero,
        "LIMOD: for homalg modules",
        [ IsFinitelyPresentedModuleRep ],
        
  function( M )
    
    return HomalgZeroMap( M, 0*M );	## never set its Kernel to M, since a possibly existing NaturalGeneralizedEmbedding in M will be overwritten!
    
end );

##
InstallMethod( TheIdentityMorphism,
        "LIMOD: for homalg modules",
        [ IsHomalgModule ],
        
  function( M )
    
    return HomalgIdentityMap( M );
    
end );

##
InstallMethod( FullSubobject,
        "LIMOD: for homalg modules",
        [ IsFinitelyPresentedModuleRep ],
        
  function( M )
    local subobject;
    
    if HasIsFree( M ) and IsFree( M ) then
        subobject := ImageSubobject( TheIdentityMorphism( M ) );
    else
        subobject := Subobject( HomalgIdentityMatrix( NrGenerators( M ), HomalgRing( M ) ), M );
    fi;
    
    SetEmbeddingInSuperObject( subobject, TheIdentityMorphism( M ) );
    
    return subobject;
    
end );

##
InstallMethod( ZeroSubobject,
        "LIMOD: for homalg modules",
        [ IsFinitelyPresentedModuleRep ],
        
  function( M )
    local n, R, zero;
    
    n := NrGenerators( M );
    
    R := HomalgRing( M );
    
    if IsHomalgLeftObjectOrMorphismOfLeftObjects( M ) then
        zero := HomalgZeroMatrix( 0, n, R );
    else
        zero := HomalgZeroMatrix( n, 0, R );
    fi;
    
    return Subobject( zero, M );
    
end );

##
InstallMethod( RankOfObject,
        "LIMOD: for homalg modules",
        [ IsFinitelyPresentedModuleRep ],
        
  function( M )
    local l, p, m;
    
    l := ListOfPositionsOfKnownSetsOfRelations( M );
    
    for p in l do
        
        m := MatrixOfRelations( M, p );
        
        if IsHomalgMatrix( m ) then
            if IsHomalgLeftObjectOrMorphismOfLeftObjects( M ) then
                if IsLeftRegular( m ) then
                    return NrColumns( m ) - NrRows( m );
                fi;
            else
                if IsRightRegular( m ) then
                    return NrRows( m ) - NrColumns( m );
                fi;
            fi;
        fi;
    od;
    
    TryNextMethod( );
    
end );

##
InstallMethod( DegreeOfTorsionFreeness,
        "LIMOD: for homalg modules",
        [ IsFinitelyPresentedModuleRep ],
        
  function( M )
    local DM, k, R, gdim, bound;
    
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
    
    if IsHomalgLeftObjectOrMorphismOfLeftObjects( M ) then
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
InstallMethod( Grade,
        "LIMOD: for homalg modules",
        [ IsFinitelyPresentedModuleRep ],
        
  function( M )
    local k, R, gdim, bound;
    
    if IsZero( M ) then
        return infinity;
    elif IsTorsion( M ) then
        k := 1;
    else
        return 0;
    fi;
    
    R := HomalgRing( M );
    
    if IsHomalgLeftObjectOrMorphismOfLeftObjects( M ) then
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
InstallMethod( Depth,
        "LIMOD: for two homalg modules",
        [ IsFinitelyPresentedModuleRep, IsFinitelyPresentedModuleRep ],
        
  function( M, N )
    local R, gdim, bound, k;
    
    if IsZero( M ) or IsZero( N ) then
        return infinity;
    fi;
    
    CheckIfTheyLieInTheSameCategory( M, N );
    
    R := HomalgRing( M );
    
    if IsHomalgLeftObjectOrMorphismOfLeftObjects( M ) then
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
    
    k := 0;
    
    while k <= bound do
        if not IsZero( Ext( k, M, N ) ) then
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
InstallMethod( PrimaryDecomposition,
        "for homalg graded modules",
        [ IsFinitelyPresentedModuleRep ],
        
  function( M )
    local tr, subobject, mat, primary_decomposition;
    
    if IsHomalgLeftObjectOrMorphismOfLeftObjects( M ) then
        tr := a -> a;
        subobject := LeftSubmodule;
    else
        tr := Involution;
        subobject := RightSubmodule;
    fi;
    
    mat := MatrixOfRelations( M );
    
    primary_decomposition := PrimaryDecompositionOp( tr( mat ) );
    
    primary_decomposition :=
      List( primary_decomposition,
            function( pp )
              local primary, prime;
              
              primary := subobject( tr( pp[1] ) );
              prime := subobject( tr( pp[2] ) );
              
              return [ primary, prime ];
              
            end
          );
    
    return primary_decomposition;
    
end );

##
InstallMethod( PrimaryDecomposition,
        "for homalg submodules",
        [ IsFinitelyPresentedSubmoduleRep ],
        
  function( N )
    
    return PrimaryDecomposition( FactorObject( N ) );
    
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
        ring_rel := HomalgRingRelationsAsGeneratorsOfLeftIdeal( ring_rel );
    else
        ring_rel := HomalgRingRelationsAsGeneratorsOfRightIdeal( ring_rel );
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

