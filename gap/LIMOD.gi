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
            
            ## used in a InstallLogicalImplicationsForHomalgSubobjects call below
            intrinsic_properties_specific_shared_with_subobjects_and_ideals :=
            [ 
              "IsFree",
              "IsStablyFree",
              "IsCyclic",
              "HasConstantRank",
              ],
            
            ## used in a InstallLogicalImplicationsForHomalgSubobjects call below
            intrinsic_properties_specific_shared_with_factors_modulo_ideals :=
            [ 
              "AffineDimension",
              "AffineDegree",
              "ProjectiveDegree",
              "IsHolonomic",
              ],
            
            intrinsic_properties_specific_not_shared_with_subobjects :=
            [ 
              ],
            
            ## used in a InstallLogicalImplicationsForHomalgSubobjects call below
            intrinsic_properties_specific_shared_with_subobjects_which_are_not_ideals :=
            Concatenation(
                    ~.intrinsic_properties_specific_shared_with_subobjects_and_ideals,
                    ~.intrinsic_properties_specific_shared_with_factors_modulo_ideals ),
            
            ## needed to define intrinsic_properties below
            intrinsic_properties_specific :=
            Concatenation(
                    ~.intrinsic_properties_specific_not_shared_with_subobjects,
                    ~.intrinsic_properties_specific_shared_with_subobjects_which_are_not_ideals ),
            
            ## needed for MatchPropertiesAndAttributes in HomalgSubmodule.gi
            intrinsic_properties_shared_with_subobjects_and_ideals :=
            Concatenation(
                    LIOBJ.intrinsic_properties_shared_with_subobjects_and_ideals,
                    ~.intrinsic_properties_specific_shared_with_subobjects_and_ideals ),
            
            ##
            intrinsic_properties_shared_with_factors_modulo_ideals :=
            Concatenation(
                    LIOBJ.intrinsic_properties_shared_with_factors_modulo_ideals,
                    ~.intrinsic_properties_specific_shared_with_factors_modulo_ideals ),
            
            ## needed for MatchPropertiesAndAttributes in HomalgSubmodule.gi
            intrinsic_properties_shared_with_subobjects_which_are_not_ideals :=
            Concatenation(
                    LIOBJ.intrinsic_properties_shared_with_subobjects_which_are_not_ideals,
                    ~.intrinsic_properties_specific_shared_with_subobjects_which_are_not_ideals ),
            
            ## needed for UpdateObjectsByMorphism
            intrinsic_properties :=
            Concatenation(
                    LIOBJ.intrinsic_properties,
                    ~.intrinsic_properties_specific ),
            
            ## used in a InstallLogicalImplicationsForHomalgSubobjects call below
            intrinsic_attributes_specific_shared_with_subobjects_and_ideals :=
            [ 
              ],
            
            ## used in a InstallLogicalImplicationsForHomalgSubobjects call below
            intrinsic_attributes_specific_shared_with_factors_modulo_ideals :=
            [ 
              "ElementaryDivisors",
              "FittingIdeal",
              "NonFlatLocus",
              "LargestMinimalNumberOfLocalGenerators",
              ],
            
            intrinsic_attributes_specific_not_shared_with_subobjects :=
            [ 
              ],
            
            ## used in a InstallLogicalImplicationsForHomalgSubobjects call below
            intrinsic_attributes_specific_shared_with_subobjects_which_are_not_ideals :=
            Concatenation(
                    ~.intrinsic_attributes_specific_shared_with_subobjects_and_ideals,
                    ~.intrinsic_attributes_specific_shared_with_factors_modulo_ideals ),
            
            ## needed to define intrinsic_attributes below
            intrinsic_attributes_specific :=
            Concatenation(
                    ~.intrinsic_attributes_specific_not_shared_with_subobjects,
                    ~.intrinsic_attributes_specific_shared_with_subobjects_which_are_not_ideals ),
            
            ## needed for MatchPropertiesAndAttributes in HomalgSubmodule.gi
            intrinsic_attributes_shared_with_subobjects_and_ideals :=
            Concatenation(
                    LIOBJ.intrinsic_attributes_shared_with_subobjects_and_ideals,
                    ~.intrinsic_attributes_specific_shared_with_subobjects_and_ideals ),
            
            ##
            intrinsic_attributes_shared_with_factors_modulo_ideals :=
            Concatenation(
                    LIOBJ.intrinsic_attributes_shared_with_factors_modulo_ideals,
                    ~.intrinsic_attributes_specific_shared_with_factors_modulo_ideals ),
            
            ## needed for MatchPropertiesAndAttributes in HomalgSubmodule.gi
            intrinsic_attributes_shared_with_subobjects_which_are_not_ideals :=
            Concatenation(
                    LIOBJ.intrinsic_attributes_shared_with_subobjects_which_are_not_ideals,
                    ~.intrinsic_attributes_specific_shared_with_subobjects_which_are_not_ideals ),
            
            ## needed for UpdateObjectsByMorphism
            intrinsic_attributes :=
            Concatenation(
                    LIOBJ.intrinsic_attributes,
                    ~.intrinsic_attributes_specific ),
            
            )
        );

##
## take care that we distinguish between objects and subobjects:
## some properties of a subobject might be those of the factor
## and not of the underlying object
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
          
          [ IsZero, "and", IsFinitelyPresentedModuleRep,
            "imply", IsHolonomic ],
          
          [ IsZero, "and", IsFinitelyPresentedSubmoduleRep, "and", NotConstructedAsAnIdeal,
            "imply", IsHolonomic ],
          
          ## [ IsHolonomic,
          ##  "implies", IsTorsion ],	false for fields
          
          ## [ IsHolonomic,
          ##  "implies", IsArtinian ],	there is no clear definition of holonomic
          
          ## see homalg/LIOBJ.gi for more implications
          
          ] );

##
InstallValue( LogicalImplicationsForHomalgModulesOverSpecialRings,
        [ ## logical implications for modules over special rings
          
          ## Kaplansky's theorem [Lam06, Theorem II.2.2]
          [ [ IsTorsionFree ],
            HomalgRing,
            [ [ IsLeftHereditary ],
              [ IsRightHereditary ],
              [ IsHereditary ]
              ],
            "imply", IsProjective,
            0 ],
          
          ## Serre's 1955 remark
          [ [ IsProjective ],
            HomalgRing,
            [ [ IsLeftFiniteFreePresentationRing ],
              [ IsRightFiniteFreePresentationRing ],
              [ IsFiniteFreePresentationRing ],
              ],
            "imply", IsStablyFree,
            0 ],
          
          ## by definition [Lam06, Definition I.4.6]
          [ [ IsStablyFree ],
            HomalgRing,
            [ [ IsLeftHermite ],
              [ IsRightHermite ],
              [ IsHermite ]
              ],
            "imply", IsFree,
            0 ],
          
          ## projective modules over local domains are free
          [ [ IsProjective ],
            HomalgRing,
            [ [ IsLocal, IsIntegralDomain ]
              ],
            "imply", IsFree,
            1001 ],
          
          ] );

####################################
#
# logical implications methods:
#
####################################

InstallLogicalImplicationsForHomalgSubobjects(
        List( LIMOD.intrinsic_properties_specific_shared_with_subobjects_which_are_not_ideals, ValueGlobal ),
        IsFinitelyPresentedSubmoduleRep and NotConstructedAsAnIdeal,
        HasEmbeddingInSuperObject,
        UnderlyingObject );

InstallLogicalImplicationsForHomalgSubobjects(
        List( LIMOD.intrinsic_properties_specific_shared_with_subobjects_and_ideals, ValueGlobal ),
        IsFinitelyPresentedSubmoduleRep and ConstructedAsAnIdeal,
        HasEmbeddingInSuperObject,
        UnderlyingObject );

InstallLogicalImplicationsForHomalgSubobjects(
        List( LIMOD.intrinsic_properties_specific_shared_with_factors_modulo_ideals, ValueGlobal ),
        IsFinitelyPresentedSubmoduleRep and ConstructedAsAnIdeal,
        HasFactorObject,
        FactorObject );

InstallLogicalImplicationsForHomalgSubobjects(
        List( LIMOD.intrinsic_attributes_specific_shared_with_subobjects_which_are_not_ideals, ValueGlobal ),
        IsFinitelyPresentedSubmoduleRep and NotConstructedAsAnIdeal,
        HasEmbeddingInSuperObject,
        UnderlyingObject );

InstallLogicalImplicationsForHomalgSubobjects(
        List( LIMOD.intrinsic_attributes_specific_shared_with_subobjects_and_ideals, ValueGlobal ),
        IsFinitelyPresentedSubmoduleRep and ConstructedAsAnIdeal,
        HasEmbeddingInSuperObject,
        UnderlyingObject );

InstallLogicalImplicationsForHomalgSubobjects(
        List( LIMOD.intrinsic_attributes_specific_shared_with_factors_modulo_ideals, ValueGlobal ),
        IsFinitelyPresentedSubmoduleRep and ConstructedAsAnIdeal,
        HasFactorObject,
        FactorObject );

####################################
#
# immediate methods for properties:
#
####################################

##
InstallImmediateMethod( IsZero,
        IsFinitelyPresentedModuleRep and HasAffineDimension, 0,
        
  function( M )
    
    return AffineDimension( M ) <= HOMALG_MODULES.DimensionOfZeroModules;
    
end );

##
InstallImmediateMethod( IsTorsion,
        IsElementOfAnObjectGivenByAMorphismRep, 0,
        
  function( m )
    local M;
    
    M := SuperObject( m );
    
    if HasIsTorsionFree( M ) and IsTorsionFree( M ) then
        ## in a torsion-free module only zero is torsion
        if HasIsZero( m ) and not IsZero( m ) then
            return false;
        fi;
    elif HasIsTorsion( M ) and IsTorsion( M ) then
        ## every element in a torsion module is torsion
        return true;
    fi;
    
    TryNextMethod( );
    
end );

##
InstallImmediateMethod( IsTorsion,
        IsElementOfAnObjectGivenByAMorphismRep and HasAnnihilator, 0,
        
  function( m )
    local Ann, M, R;
    
    Ann := Annihilator( m );
    
    if HasIsZero( Ann ) then
        
        M := SuperObject( m );
        
        ## we assume that the ring R ≠ 0
        if IsZero( Ann ) then
            
            ## 0 ≠ R = R / Ann( m ) ≅ R m ≤ M
            SetIsTorsion( M, false );
            
            return false;
            
        elif not HasIsZero( m ) then
            
            TryNextMethod( );
            
        elif IsZero( m ) then
            
            return true;
            
        fi;
        
        ## we now know that m ≠ 0 and Ann( m ) ≠ 0
        
        R := HomalgRing( m );
        
        ## Z/2 is torsion-free over Z/6 with annihilator <3>
        if HasIsIntegralDomain( R ) and IsIntegralDomain( R ) then
            
            SetIsTorsionFree( M, false );
            
            return true;
        fi;
        
    fi;
    
    TryNextMethod( );
    
end );

##
InstallImmediateMethod( IsTorsion,
        IsElementOfAnObjectGivenByAMorphismRep and IsZero, 0,
        
  function( m )
    
    return true;
    
end );

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
InstallImmediateMethod( IsTorsion,
        IsFinitelyPresentedModuleOrSubmoduleRep and HasRankOfObject, 0,
        
  function( M )
    local R;
    
    R := HomalgRing( M );
    
    ## Z/2 is torsion-free over Z/6 with annihilator <3>
    if HasIsIntegralDomain( R ) and IsIntegralDomain( R ) then
        return RankOfObject( M ) = 0;
    fi;
    
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
        IsFinitelyPresentedModuleRep, 0,
        
  function( M )
    local R;
    
    R := HomalgRing( M );
    
    ## modules over divison rings are free
    if HasIsDivisionRingForHomalg( R ) and IsDivisionRingForHomalg( R ) then
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

## A module element over a commutative ring is torsion,
## if it is annihilated by a regular element of the ring.
InstallMethod( IsTorsion,
        "LIOBJ: for homalg object elements",
        [ IsElementOfAnObjectGivenByAMorphismRep ],
        
  function( m )
    local M, Ann, R, gens;
    
    if IsZero( m ) then
        return true;
    fi;
    
    ## M ≠ 0 since m ≠ 0
    M := SuperObject( m );
    
    if HasIsTorsionFree( M ) and IsTorsionFree( M ) then
        ## in a torsion-free module only zero is torsion
        ## and we already know that m ≠ 0
        return false;
    elif HasIsTorsion( M ) and IsTorsion( M ) then
        ## every element in a torsion module is torsion
        return true;
    fi;
    
    Ann := Annihilator( m );
    
    if IsZero( Ann ) then
        
        ## we assume that the ring R ≠ 0, so
        ## 0 ≠ R = R / Ann( m ) ≅ R m ≤ M
        SetIsTorsion( M, false );
        
        return false;
        
    fi;
    
    ## we now know that m ≠ 0 and Ann( m ) ≠ 0
    
    R := HomalgRing( m );
    
    ## Z/2 is torsion-free over Z/6 with annihilator <3>
    if HasIsIntegralDomain( R ) and IsIntegralDomain( R ) then
        
        SetIsTorsionFree( M, false );
        
        return true;
        
    fi;
    
    ## I am not sure about the appropriate definition in the
    ## noncommutative setting
    if not ( HasIsCommutative( R ) and IsCommutative( R ) ) then
        TryNextMethod( );
    fi;
    
    ## now that the annihilator is nontrivial
    ## check if any of its generators is regular (i.e., a nonzerodivisor)
    gens := GeneratingElements( Ann );
    
    if ForAny( gens, a -> IsZero( Annihilator( a ) ) ) then
        return true;
    fi;
    
    TryNextMethod( );
    
end );

##
InstallMethod( IsZero,
        "LIMOD: for homalg submodules",
        [ IsFinitelyPresentedSubmoduleRep ],
        
  function( M )
    local is_zero;
    
    is_zero := IsZero( DecideZero( MatrixOfSubobjectGenerators( M ), SuperObject( M ) ) );
    
    if HasEmbeddingInSuperObject( M ) then
        SetIsZero( UnderlyingObject( M ), is_zero );
    fi;
    
    return is_zero;
    
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
InstallMethod( IsZero,
        "LIMOD: for homalg modules",
        [ IsFinitelyPresentedModuleRep ],
        
  function( M )
    local R, K, RP;
    
    R := HomalgRing( M );
    
    if not ( HasIsCommutative( R ) and IsCommutative( R ) ) or
       not HasCoefficientsRing( R ) then
        TryNextMethod( );
    fi;
    
    K := CoefficientsRing( R );
    
    if not ( HasIsFieldForHomalg( K ) and IsFieldForHomalg( K ) ) then
        TryNextMethod( );
    fi;
    
    RP := homalgTable( R );
    
    if not ( IsBound( RP!.AffineDimension ) or
             IsBound( RP!.CoefficientsOfUnreducedNumeratorOfHilbertPoincareSeries ) or
             IsBound( RP!.CoefficientsOfNumeratorOfHilbertPoincareSeries ) ) then
        TryNextMethod( );
    fi;
    
    return AffineDimension( M ) <= HOMALG_MODULES.DimensionOfZeroModules;
    
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
InstallGlobalFunction( IsProjectiveByCheckingIfExt1WithValuesInFirstSyzygiesModuleIsZero,
  function( M )
    local R, K, proj;
    
    R := HomalgRing( M );
    
    if not ( HasIsCommutative( R ) and IsCommutative( R ) ) then
        return fail;
    fi;
    
    K := SyzygiesObject( M );
    
    proj := IsZero( Ext( 1, M, K ) );
    
    if proj then
        M!.UpperBoundForProjectiveDimension := 0;
    fi;
    
    SetIsProjective( M, proj );
    
    return proj;
    
end );

##
InstallMethod( IsProjective,
        "LIMOD: for homalg modules",
        [ IsFinitelyPresentedModuleRep ],
        
  function( M )
    local b;
    
    b := IsProjectiveByCheckingForASplit( M );
    
    if b = fail then
        TryNextMethod( );
    fi;
    
    return b;
    
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
InstallGlobalFunction( IsProjectiveOfConstantRankByCheckingFittingsCondition,
  function( M )
    local R, b;
    
    R := HomalgRing( M );
    
    if not ( HasIsCommutative( R ) and IsCommutative( R ) ) then
        return fail;
    fi;
    
    b := ( FittingIdeal( M ) = R );
    
    SetIsProjectiveOfConstantRank( M, b );
    
    return b;
    
end );

##
InstallMethod( IsProjectiveOfConstantRank,
        "LIMOD: for homalg modules",
        [ IsFinitelyPresentedModuleRep ],
        
  function( M )
    local b;
    
    b := IsProjectiveOfConstantRankByCheckingFittingsCondition( M );
    
    if b = fail then
        TryNextMethod( );
    fi;
    
    return b;
    
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
        [ IsFinitelyPresentedModuleRep ],
        
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
InstallMethod( Annihilator,
        "for homalg module elements",
        [ IsElementOfAModuleGivenByAMorphismRep ],
        
  function( e )
    local mat, rel;
    
    mat := MatrixOfMap( UnderlyingMorphism( e ) );
    rel := RelationsOfModule( SuperObject( e ) );
    
    return Annihilator( mat, rel );
    
end );

##
InstallMethod( Annihilator,
        "for homalg modules",
        [ IsFinitelyPresentedModuleRep ],
        
  function( M )
    local R, gens, Ann, i;
    
    if IsZero( M ) then
        
        return FullSubobject( One( M ) );
        
    elif HasIsTorsion( M ) and not IsTorsion( M ) then
        
        R := HomalgRing( M );
      
        ## Z/2 is torsion-free over Z/6 with annihilator <3>
        if HasIsIntegralDomain( R ) and IsIntegralDomain( R ) then
            return ZeroSubobject( One( M ) );
        fi;
        
    fi;
    
    gens := GeneratingElements( M );
    
    ## since M is nontrivial gens is nonempty
    Ann := Annihilator( gens[1] );
    
    for i in [ 2 .. Length( gens ) ] do
        
        if IsZero( Ann ) then
            ## return the standard zero ideal
            return ZeroSubobject( One( M ) );
        fi;
        
        Ann := Intersect2( Ann, Annihilator( gens[i] ) );
        
    od;
    
    if IsZero( Ann ) then
        ## return the standard zero ideal
        return ZeroSubobject( One( M ) );
    fi;
    
    return Ann;
    
end );

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
    
    MatchPropertiesAndAttributesOfSubobjectAndUnderlyingObject( subobject, M );
    
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
    local R;
    
    R := HomalgRing( M );
    
    if not ( HasIsCommutative( R ) and IsCommutative( R ) ) then
        ## cannot use the Fitting ideal criterion below
        TryNextMethod( );
    elif HasGlobalDimension( R ) and GlobalDimension( R ) < infinity then
        ## try computing the rank via a free resolution
        ## which is hopefully cheaper
        TryNextMethod( );
    fi;
    
    return NumberOfFirstNonZeroFittingIdeal( M );
    
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
InstallMethod( RankOfObject,
        "LIMOD: for homalg modules",
        [ IsFinitelyPresentedModuleRep ],
        
  function( M )
    local R, K, RP, d, dim;
    
    R := HomalgRing( M );
    
    if not ( HasIsCommutative( R ) and IsCommutative( R ) and
       HasCoefficientsRing( R ) and HasKrullDimension( R ) ) then
        TryNextMethod( );
    fi;
    
    K := CoefficientsRing( R );
    
    if not ( HasIsFieldForHomalg( K ) and IsFieldForHomalg( K ) ) then
        TryNextMethod( );
    fi;
    
    RP := homalgTable( R );
    
    if not ( IsBound( RP!.CoefficientsOfUnreducedNumeratorOfHilbertPoincareSeries ) or
             IsBound( RP!.CoefficientsOfNumeratorOfHilbertPoincareSeries ) ) then
        TryNextMethod( );
    fi;
    
    d := KrullDimension( R );
    
    dim := AffineDimension( M );
    
    if dim >  d then
        Error( "the dimension of the module is greater than the Krull dimension of the ring\n" );
    fi;
    
    if dim < d then
        return 0;
    fi;
    
    return AffineDegree( M );
    
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
InstallMethod( CoefficientsOfUnreducedNumeratorOfHilbertPoincareSeries,
        "for a homalg module",
        [ IsFinitelyPresentedModuleRep ],
        
  function( M )
    local mat;
    
    mat := MatrixOfRelations( M );
    
    if IsHomalgRightObjectOrMorphismOfRightObjects( M ) then
        mat := Involution( mat );
    fi;
    
    mat := BasisOfRows( mat );
    
    return CoefficientsOfUnreducedNumeratorOfHilbertPoincareSeries( mat );
    
end );

##
InstallMethod( CoefficientsOfNumeratorOfHilbertPoincareSeries,
        "for a homalg module",
        [ IsFinitelyPresentedModuleRep ],
        
  function( M )
    local mat;
    
    mat := MatrixOfRelations( M );
    
    if IsHomalgRightObjectOrMorphismOfRightObjects( M ) then
        mat := Involution( mat );
    fi;
    
    mat := BasisOfRows( mat );
    
    return CoefficientsOfNumeratorOfHilbertPoincareSeries( mat );
    
end );

##
InstallMethod( UnreducedNumeratorOfHilbertPoincareSeries,
        "for a homalg module",
        [ IsFinitelyPresentedModuleRep ],
        
  function( M )
    local mat;
    
    mat := MatrixOfRelations( M );
    
    if IsHomalgRightObjectOrMorphismOfRightObjects( M ) then
        mat := Involution( mat );
    fi;
    
    mat := BasisOfRows( mat );
    
    return UnreducedNumeratorOfHilbertPoincareSeries( mat );
    
end );

##
InstallMethod( NumeratorOfHilbertPoincareSeries,
        "for a homalg module",
        [ IsFinitelyPresentedModuleRep ],
        
  function( M )
    local mat;
    
    mat := MatrixOfRelations( M );
    
    if IsHomalgRightObjectOrMorphismOfRightObjects( M ) then
        mat := Involution( mat );
    fi;
    
    mat := BasisOfRows( mat );
    
    return NumeratorOfHilbertPoincareSeries( mat );
    
end );

##
InstallMethod( HilbertPoincareSeries,
        "for a homalg module",
        [ IsHomalgModule ],
        
  function( M )
    
    return HilbertPoincareSeries( M, VariableForHilbertPoincareSeries( ) );
    
end );

##
InstallMethod( HilbertPolynomial,
        "for a homalg module",
        [ IsHomalgModule ],
        
  function( M )
    
    return HilbertPolynomial( M, VariableForHilbertPolynomial( ) );
    
end );

##
InstallMethod( DataOfHilbertFunction,
        "for a homalg module",
        [ IsHomalgModule and IsFinitelyPresentedObjectRep ],
        
  function( M )
    local HP;
    
    HP := HilbertPoincareSeries( M );
    
    return DataOfHilbertFunction( HP );
    
end );

##
InstallMethod( HilbertFunction,
        "for a homalg module",
        [ IsHomalgModule and IsFinitelyPresentedObjectRep ],
        
  function( M )
    local HP;
    
    HP := HilbertPoincareSeries( M );
    
    return HilbertFunction( HP );
    
end );

##
InstallMethod( IndexOfRegularity,
        "for a homalg module",
        [ IsHomalgModule and IsFinitelyPresentedObjectRep ],
        
  function( M )
    local range;
    
    if IsZero( M ) then
        Error( "GAP does not support -infinity yet\n" );
    fi;
    
    range := DataOfHilbertFunction( M )[1][2];
    
    return range[Length( range )] + 1;
    
end );

##
InstallMethod( ElementOfGrothendieckGroup,
        "for a homalg module",
        [ IsHomalgModule and IsFinitelyPresentedObjectRep ],
        
  function( M )
    local chi, dim;
    
    chi := HilbertPolynomial( M );
    
    dim := Length( Indeterminates( HomalgRing( M ) ) ) - 1;
    
    return CreateElementOfGrothendieckGroupOfProjectiveSpace( chi, dim );
    
end );

##
InstallMethod( ChernPolynomial,
        "for a homalg module",
        [ IsHomalgModule and IsFinitelyPresentedObjectRep ],
        
  function( M )
    local P;
    
    P := ElementOfGrothendieckGroup( M );
    
    return ChernPolynomial( P );
    
end );

##
InstallMethod( ChernCharacter,
        "for a homalg module",
        [ IsHomalgModule and IsFinitelyPresentedObjectRep ],
        
  function( M )
    local c;
    
    c := ChernPolynomial( M );
    
    return ChernCharacter( c );
    
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

##
InstallMethod( FittingIdeal,
        "for homalg modules",
        [ IsFinitelyPresentedModuleRep ],
        
  function( M )
    local r, Fitt, R;
    
    r := RankOfObject( M );
    
    Fitt := FittingIdeal( r, M );
    
    R := HomalgRing( M );
    
    SetIsZero( Fitt, IsZero( R ) );
    
    if Fitt = R then
        ## if Fitt < R, then M might still be projective
        ## but with non-constant rank
        SetIsProjective( M, true );
        SetHasConstantRank( M, true );
    elif HasIsProjective( M ) and IsProjective( M ) then
        SetHasConstantRank( M, false );
    elif HasHasConstantRank( M ) and HasConstantRank( M ) then
        SetIsProjective( M, false );
    fi;
    
    return Fitt;
    
end );

##
InstallMethod( NonFlatLocus,
        "for homalg modules",
        [ IsFinitelyPresentedModuleRep ],
        
  function( M )
    local R, i, Fitt;
    
    R := HomalgRing( M );
    
    if not ( HasIsCommutative( R ) and IsCommutative( R ) ) then
        TryNextMethod( );
    fi;
    
    return FactorObject( FittingIdeal( M ) );
    
end );


##
InstallMethod( LargestMinimalNumberOfLocalGenerators,
        "for homalg modules",
        [ IsFinitelyPresentedModuleRep ],
        
  function( M )
    local R, i, Fitt_i;
    
    if IsZero( M ) then
        return 0;
    fi;
    
    R := HomalgRing( M );
    
    if not ( HasIsCommutative( R ) and IsCommutative( R ) ) then
        TryNextMethod( );
    fi;
    
    for i in Reversed( [ 0 .. NrGenerators( M ) - 1 ] ) do
        
        Fitt_i := FittingIdeal( i, M );
        
        if not Fitt_i = R then
            return i + 1;
        fi;
        
    od;
    
    ## should never be reached
    Error( "something went wrong\n" );
    
end );

####################################
#
# logical implications methods:
#
####################################

InstallLogicalImplicationsForHomalgObjects( LogicalImplicationsForHomalgModules, IsHomalgModule );

InstallLogicalImplicationsForHomalgObjects( LogicalImplicationsForHomalgModulesOverSpecialRings, IsHomalgModule, IsHomalgRing );
