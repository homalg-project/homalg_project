#############################################################################
##
##  HomalgMap.gi                homalg package               Mohamed Barakat
##
##  Copyright 2007-2008 Lehrstuhl B für Mathematik, RWTH Aachen
##
##  Implementation stuff for homalg maps ( = module homomorphisms ).
##
#############################################################################

####################################
#
# representations:
#
####################################

# a new representation for the GAP-category IsHomalgMap
# which is a subrepresentation of the representation IsMorphismOfFinitelyGeneratedModulesRep:
DeclareRepresentation( "IsMapOfFinitelyGeneratedModulesRep",
        IsHomalgMap and IsMorphismOfFinitelyGeneratedModulesRep,
        [ "source", "target", "matrices", "index_pairs_of_presentations" ] );

####################################
#
# families and types:
#
####################################

# a new family:
BindGlobal( "TheFamilyOfHomalgMaps",
        NewFamily( "TheFamilyOfHomalgMaps" ) );

# four new types:
BindGlobal( "TheTypeHomalgMapOfLeftModules",
        NewType( TheFamilyOfHomalgMaps,
                IsMapOfFinitelyGeneratedModulesRep and IsHomalgLeftObjectOrMorphismOfLeftObjects ) );

BindGlobal( "TheTypeHomalgMapOfRightModules",
        NewType( TheFamilyOfHomalgMaps,
                IsMapOfFinitelyGeneratedModulesRep and IsHomalgRightObjectOrMorphismOfRightObjects ) );

BindGlobal( "TheTypeHomalgSelfMapOfLeftModules",
        NewType( TheFamilyOfHomalgMaps,
                IsMapOfFinitelyGeneratedModulesRep and IsHomalgSelfMap and IsHomalgLeftObjectOrMorphismOfLeftObjects ) );

BindGlobal( "TheTypeHomalgSelfMapOfRightModules",
        NewType( TheFamilyOfHomalgMaps,
                IsMapOfFinitelyGeneratedModulesRep and IsHomalgSelfMap and IsHomalgRightObjectOrMorphismOfRightObjects ) );

####################################
#
# immediate methods for properties:
#
####################################

##
InstallImmediateMethod( IsZero,
        IsHomalgMap, 0,
        
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

####################################
#
# methods for properties:
#
####################################

##
InstallMethod( IsMorphism,
        "for homalg maps",
        [ IsMapOfFinitelyGeneratedModulesRep and IsHomalgLeftObjectOrMorphismOfLeftObjects ],
        
  function( phi )
    local mat;
    
    mat := MatrixOfRelations( Source( phi ) ) * MatrixOfMap( phi );
    
    return IsZero( DecideZero( mat , RelationsOfModule( Range( phi ) ) ) );
    
end );

##
InstallMethod( IsMorphism,
        "for homalg maps",
        [ IsMapOfFinitelyGeneratedModulesRep and IsHomalgRightObjectOrMorphismOfRightObjects ],
        
  function( phi )
    local mat;
    
    mat := MatrixOfMap( phi ) * MatrixOfRelations( Source( phi ) );
    
    return IsZero( DecideZero( mat , RelationsOfModule( Range( phi ) ) ) );
    
end );

##
InstallMethod( IsZero,
        "for homalg maps",
        [ IsMapOfFinitelyGeneratedModulesRep ],
        
  function( phi )
    
    return IsZero( DecideZero( phi ) );
    
end );

##
InstallMethod( IsEpimorphism,
        "for homalg maps",
        [ IsMapOfFinitelyGeneratedModulesRep ],
        
  function( phi )
    
    return IsMorphism( phi ) and IsZero( Cokernel( phi ) );
    
end );

##
InstallMethod( IsMonomorphism,
        "for homalg maps",
        [ IsMapOfFinitelyGeneratedModulesRep ],
        
  function( phi )
    
    return IsMorphism( phi ) and IsZero( Kernel( phi ) );
    
end );

##
InstallMethod( IsIsomorphism,
        "for homalg maps",
        [ IsMapOfFinitelyGeneratedModulesRep ],
        
  function( phi )
    
    return IsEpimorphism( phi ) and IsMonomorphism( phi );
    
end );

##
InstallMethod( IsAutomorphism,
        "for homalg maps",
        [ IsMapOfFinitelyGeneratedModulesRep ],
        
  function( phi )
    
    return IsHomalgSelfMap( phi ) and IsIsomorphism( phi );
    
end );

####################################
#
# methods for operations:
#
####################################

##
InstallMethod( HomalgRing,
        "for homalg maps",
        [ IsHomalgMap ],
        
  function( phi )
    
    return HomalgRing( Source( phi ) );
    
end );

##
InstallMethod( PositionOfTheDefaultSetOfRelations,
        "for homalg maps",
        [ IsMapOfFinitelyGeneratedModulesRep ],
        
  function( M )
    
    return fail;
    
end );

##
InstallMethod( PairOfPositionsOfTheDefaultSetOfRelations,
        "for homalg maps",
        [ IsMapOfFinitelyGeneratedModulesRep ],
        
  function( phi )
    local pos_s, pos_t;
    
    pos_s := PositionOfTheDefaultSetOfRelations( Source( phi ) );
    pos_t := PositionOfTheDefaultSetOfRelations( Range( phi ) );
    
    if IsHomalgLeftObjectOrMorphismOfLeftObjects( phi ) then
        return [ pos_s, pos_t ];
    else
        return [ pos_t, pos_s ];
    fi;
    
end );

##
InstallMethod( MatrixOfMap,		## FIXME: make this optimal by finding shortest ways
        "for homalg maps",
        [ IsMapOfFinitelyGeneratedModulesRep, IsPosInt, IsPosInt ],
        
  function( phi, pos_s, pos_t )
    local index_pair, l, dist, min, pos, matrix;
    
    if IsHomalgLeftObjectOrMorphismOfLeftObjects( phi ) then
        index_pair := [ pos_s, pos_t ];
    else
        index_pair := [ pos_t, pos_s ];
    fi;
    
    l := phi!.index_pairs_of_presentations;
    
    if not index_pair in l then
        
        dist := List( l, a -> AbsInt( index_pair[1] - a[1] ) + AbsInt( index_pair[2] - a[2] ) );
        
        min := Minimum( dist );
        
        pos := PositionProperty( dist, a -> a = min );
        
        if IsHomalgLeftObjectOrMorphismOfLeftObjects( phi ) then
            matrix :=
              TransitionMatrix( Source( phi ), pos_s, l[pos][1] )
              * phi!.matrices.( String( l[pos] ) )
              * TransitionMatrix( Range( phi ), l[pos][2], pos_t );
        else
            matrix :=
              TransitionMatrix( Range( phi ), pos_t, l[pos][1] )
              * phi!.matrices.( String( l[pos] ) )
              * TransitionMatrix( Source( phi ), l[pos][2], pos_s );
        fi;
        
        phi!.matrices.( String( index_pair ) ) := matrix;
        
        Add( l, index_pair );
        
    fi;
    
    if IsBound( phi!.reduced_matrices.( String( index_pair ) ) ) then
        return phi!.reduced_matrices.( String( index_pair ) );
    else
        return phi!.matrices.( String( index_pair ) );
    fi;
    
end );

##
InstallMethod( MatrixOfMap,
        "for homalg maps",
        [ IsMapOfFinitelyGeneratedModulesRep and IsHomalgSelfMap, IsPosInt ],
        
  function( phi, pos_s_t )
    
    return MatrixOfMap( phi, pos_s_t, pos_s_t );
    
end );

##
InstallMethod( MatrixOfMap,
        "for homalg maps",
        [ IsMapOfFinitelyGeneratedModulesRep ],
        
  function( phi )
    local pos_s, pos_t;
    
    pos_s := PositionOfTheDefaultSetOfRelations( Source( phi ) );
    pos_t := PositionOfTheDefaultSetOfRelations( Range( phi ) );
    
    return MatrixOfMap( phi, pos_s, pos_t );
    
end );

##
InstallMethod( AreComparableMorphisms,
        "for homalg maps",
        [ IsHomalgMap, IsHomalgMap ],
        
  function( phi1, phi2 )
    
    return IsIdenticalObj( Source( phi1 ), Source( phi2 ) ) and
           IsIdenticalObj( Range( phi1 ), Range( phi2 ) );
    
end );

##
InstallMethod( AreComposableMorphisms,
        "for homalg maps",
        [ IsHomalgMap and IsHomalgLeftObjectOrMorphismOfLeftObjects,
          IsHomalgMap and IsHomalgLeftObjectOrMorphismOfLeftObjects ],
        
  function( phi1, phi2 )
    
    return IsIdenticalObj( Range( phi1 ), Source( phi2 ) );
    
end );

##
InstallMethod( AreComposableMorphisms,
        "for homalg maps",
        [ IsHomalgMap and IsHomalgRightObjectOrMorphismOfRightObjects,
          IsHomalgMap and IsHomalgRightObjectOrMorphismOfRightObjects ],
        
  function( phi2, phi1 )
    
    return IsIdenticalObj( Range( phi1 ), Source( phi2 ) );
    
end );

##
InstallMethod( \=,
        "for two comparable homalg maps",
        [ IsMapOfFinitelyGeneratedModulesRep, IsMapOfFinitelyGeneratedModulesRep ],
        
  function( phi1, phi2 )
    
    if not AreComparableMorphisms( phi1, phi2 ) then
        return false;
    fi;
    
    return MatrixOfMap( phi1 ) = MatrixOfMap( phi2 ); ## FIXME: compare any already evaluated matrices
    
end );

##
InstallMethod( ZeroMutable,
        "for homalg maps",
        [ IsMapOfFinitelyGeneratedModulesRep ],
        
  function( phi )
    
    return HomalgMap( 0 * MatrixOfMap( phi ), Source( phi ), Range( phi ) );
    
end );

##
InstallMethod( \*,
        "of two homalg maps",
        [ IsRingElement, IsMapOfFinitelyGeneratedModulesRep ], 1001, ## it could otherwise run into the method ``PROD: negative integer * additive element with inverse'', value: 24
        
  function( a, phi )
    local a_phi;
    
    a_phi := HomalgMap( a * MatrixOfMap( phi ), Source( phi ), Range( phi ) );
    
    if HasIsMorphism( phi ) and IsMorphism( phi ) then
        SetIsMorphism( a_phi, true );
    fi;
    
    return a_phi;
    
end );

##
InstallMethod( \+,
        "of two homalg maps",
        [ IsMapOfFinitelyGeneratedModulesRep, IsMapOfFinitelyGeneratedModulesRep ],
        
  function( phi1, phi2 )
    local phi;
    
    if not AreComparableMorphisms( phi1, phi2 ) then
        return Error( "the two maps are not comparable" );
    fi;
    
    phi := HomalgMap( MatrixOfMap( phi1 ) + MatrixOfMap( phi2 ), Source( phi1 ), Range( phi1 ) );
    
    if HasIsMorphism( phi1 ) and IsMorphism( phi1 ) and
       HasIsMorphism( phi2 ) and IsMorphism( phi2 ) then
        SetIsMorphism( phi, true );
    fi;
    
    return phi;
    
end );

## a synonym of `-<elm>':
InstallMethod( AdditiveInverseMutable,
        "of homalg maps",
        [ IsMapOfFinitelyGeneratedModulesRep ],
        
  function( phi )
    
    return MinusOne( HomalgRing( phi ) ) * phi;
    
end );

## a synonym of `-<elm>':
InstallMethod( AdditiveInverseMutable,
        "of homalg maps",
        [ IsHomalgMap and IsZero ],
        
  function( phi )
    
    return phi;
    
end );

##
InstallMethod( \-,
        "of two homalg maps",
        [ IsMapOfFinitelyGeneratedModulesRep, IsMapOfFinitelyGeneratedModulesRep ],
        
  function( phi1, phi2 )
    local phi;
    
    if not AreComparableMorphisms( phi1, phi2 ) then
        return Error( "the two maps are not comparable" );
    fi;
    
    phi := HomalgMap( MatrixOfMap( phi1 ) - MatrixOfMap( phi2 ), Source( phi1 ), Range( phi1 ) );
    
    if HasIsMorphism( phi1 ) and IsMorphism( phi1 ) and
       HasIsMorphism( phi2 ) and IsMorphism( phi2 ) then
        SetIsMorphism( phi, true );
    fi;
    
    return phi;
    
end );

##
InstallMethod( \*,
        "of two homalg maps",
        [ IsMapOfFinitelyGeneratedModulesRep and IsHomalgLeftObjectOrMorphismOfLeftObjects,
          IsMapOfFinitelyGeneratedModulesRep and IsHomalgLeftObjectOrMorphismOfLeftObjects ], 1001,	## this must be ranked higher than multiplication with a ring element, which it could be an endomorphism
        
  function( phi1, phi2 )
    local phi;
    
    if not AreComposableMorphisms( phi1, phi2 ) then
        Error( "the two morphisms are not composable, since the target of the left one and the source of right one are not \033[01midentical\033[0m\n" );
    fi;
    
    phi := HomalgMap( MatrixOfMap( phi1 ) * MatrixOfMap( phi2 ), Source( phi1 ), Range( phi2 ) );
    
    if HasIsMonomorphism( phi1 ) and IsMonomorphism( phi1 ) and
       HasIsMonomorphism( phi2 ) and IsMonomorphism( phi2 ) then
        SetIsMonomorphism( phi, true );
    elif HasIsEpimorphism( phi1 ) and IsEpimorphism( phi1 ) and
      HasIsEpimorphism( phi2 ) and IsEpimorphism( phi2 ) then
        SetIsEpimorphism( phi, true );
    elif HasIsMorphism( phi1 ) and IsMorphism( phi1 ) and
      HasIsMorphism( phi2 ) and IsMorphism( phi2 ) then
        SetIsMorphism( phi, true );
    fi;
    
    return phi;
    
end );

##
InstallMethod( \*,
        "of two homalg maps",
        [ IsMapOfFinitelyGeneratedModulesRep and IsHomalgRightObjectOrMorphismOfRightObjects,
          IsMapOfFinitelyGeneratedModulesRep and IsHomalgRightObjectOrMorphismOfRightObjects ], 1001,	## this must be ranked higher than multiplication with a ring element, which it could be an endomorphism
        
  function( phi2, phi1 )
    local phi;
    
    if not AreComposableMorphisms( phi2, phi1 ) then
        Error( "the two morphisms are not composable, since the source of the left one and the target of the right one are not \033[01midentical\033[0m\n" );
    fi;
    
    phi := HomalgMap( MatrixOfMap( phi2 ) * MatrixOfMap( phi1 ), Source( phi1 ), Range( phi2 ) );
    
    if HasIsMonomorphism( phi1 ) and IsMonomorphism( phi1 ) and
       HasIsMonomorphism( phi2 ) and IsMonomorphism( phi2 ) then
        SetIsMonomorphism( phi, true );
    elif HasIsEpimorphism( phi1 ) and IsEpimorphism( phi1 ) and
      HasIsEpimorphism( phi2 ) and IsEpimorphism( phi2 ) then
        SetIsEpimorphism( phi, true );
    elif HasIsMorphism( phi1 ) and IsMorphism( phi1 ) and
      HasIsMorphism( phi2 ) and IsMorphism( phi2 ) then
        SetIsMorphism( phi, true );
    fi;
    
    return phi;
    
end );

##
InstallMethod( POW,
        "for homalg maps",
        [ IsMapOfFinitelyGeneratedModulesRep, IsInt ],
        
  function( phi, pow )
    local id, inv;
    
    if pow = -1 then
        
        id := HomalgIdentityMap( Range( phi ) );
        
        inv := PostDivide( id, phi );
        
        if HasIsIsomorphism( phi ) then
            SetIsIsomorphism( inv, IsIsomorphism( phi ) );
        fi;
        
        return inv;
        
    fi;
    
    TryNextMethod( );
    
end );

##
InstallMethod( OnLessGenerators,
        "for homalg maps",
        [ IsMapOfFinitelyGeneratedModulesRep ],
        
  function( phi )
    
    OnLessGenerators( Source( phi ) );
    OnLessGenerators( Range( phi ) );
    
    return phi;
    
end );

##
InstallMethod( BasisOfModule,
        "for homalg maps",
        [ IsMapOfFinitelyGeneratedModulesRep ],
        
  function( phi )
    
    BasisOfModule( Source( phi ) );
    BasisOfModule( Range( phi ) );
    
    return phi;
    
end );

##
InstallMethod( DecideZero,
        "for homalg maps",
        [ IsMapOfFinitelyGeneratedModulesRep, IsRelationsOfFinitelyPresentedModuleRep ],
        
  function( phi, rel )
    
    return DecideZero( MatrixOfMap( phi ) , rel );
    
end );

##
InstallMethod( DecideZero,
        "for homalg maps",
        [ IsMapOfFinitelyGeneratedModulesRep ],
        
  function( phi )
    local pos_t, rel, index_pair, matrix, reduced;
    
    pos_t := PositionOfTheDefaultSetOfRelations( Range( phi ) );
    
    rel := RelationsOfModule( Range( phi ), pos_t );
    
    index_pair := PairOfPositionsOfTheDefaultSetOfRelations( phi );
    
    matrix := MatrixOfMap( phi );
    
    reduced := DecideZero( matrix, rel );
    
    if reduced = matrix then
        reduced := matrix;
    fi;
    
    phi!.reduced_matrices.( String( index_pair ) ) := reduced;
    
    return reduced;
    
end );

##
InstallMethod( ByASmallerPresentation,
        "for homalg maps",
        [ IsMapOfFinitelyGeneratedModulesRep ],
        
  function( phi )
    
    ByASmallerPresentation( Source( phi ) );
    ByASmallerPresentation( Range( phi ) );
    DecideZero( phi );
    
    return phi;
    
end );

##
InstallMethod( UnionOfRelations,
        "for homalg maps",
        [ IsMapOfFinitelyGeneratedModulesRep ],
        
  function( phi )
    
    return UnionOfRelations( MatrixOfMap( phi ), Range( phi ) );
    
end );

##
InstallMethod( SyzygiesGenerators,
        "for homalg maps",
        [ IsMapOfFinitelyGeneratedModulesRep ],
        
  function( phi )
    
    return SyzygiesGenerators( MatrixOfMap( phi ), Range( phi ) );
    
end );

##
InstallMethod( StackMaps,
        "of two homalg maps",
        [ IsMapOfFinitelyGeneratedModulesRep and IsHomalgLeftObjectOrMorphismOfLeftObjects,
          IsMapOfFinitelyGeneratedModulesRep and IsHomalgLeftObjectOrMorphismOfLeftObjects ],
        
  function( phi, psi )
    local T, phi_psi, SpS, p;
    
    T := Range( phi );
    
    if not IsIdenticalObj( T, Range( psi ) ) then
        Error( "the two morphisms must have identical target modules\n" );
    fi;
    
    phi_psi := UnionOfRows( MatrixOfMap( phi ), MatrixOfMap( psi ) );
    
    SpS := Source( phi ) + Source( psi );
    
    ## get the position of the set of relations immediately after creating SpS;
    p := Genesis( SpS ).("PositionOfTheDefaultSetOfRelationsOfTheOutput");
    
    phi_psi := HomalgMap( phi_psi, [ SpS, p ], T );
    
    if HasIsEpimorphism( phi ) and IsEpimorphism( phi ) and
       HasIsMorphism( psi ) and IsMorphism( psi ) then
        SetIsEpimorphism( phi_psi, true );
    elif HasIsMorphism( phi ) and IsMorphism( phi ) and
       HasIsEpimorphism( psi ) and IsEpimorphism( psi ) then
        SetIsEpimorphism( phi_psi, true );
    elif HasIsMorphism( phi ) and IsMorphism( phi ) and
       HasIsMorphism( psi ) and IsMorphism( psi ) then
        SetIsMorphism( phi_psi, true );
    fi;
    
    return phi_psi;
    
end );

##
InstallMethod( StackMaps,
        "of two homalg maps",
        [ IsMapOfFinitelyGeneratedModulesRep and IsHomalgRightObjectOrMorphismOfRightObjects,
          IsMapOfFinitelyGeneratedModulesRep and IsHomalgRightObjectOrMorphismOfRightObjects ],
        
  function( phi, psi )
    local T, phi_psi, SpS, p;
    
    T := Range( phi );
    
    if not IsIdenticalObj( T, Range( psi ) ) then
        Error( "the two morphisms must have identical target modules\n" );
    fi;
    
    phi_psi := UnionOfColumns( MatrixOfMap( phi ), MatrixOfMap( psi ) );
    
    SpS := Source( phi ) + Source( psi );
    
    ## get the position of the set of relations immediately after creating SpS;
    p := Genesis( SpS ).("PositionOfTheDefaultSetOfRelationsOfTheOutput");
    
    T := Range( phi );
    
    phi_psi := HomalgMap( phi_psi, [ SpS, p ], T );
    
    if HasIsEpimorphism( phi ) and IsEpimorphism( phi ) and
       HasIsMorphism( psi ) and IsMorphism( psi ) then
        SetIsEpimorphism( phi_psi, true );
    elif HasIsMorphism( phi ) and IsMorphism( phi ) and
       HasIsEpimorphism( psi ) and IsEpimorphism( psi ) then
        SetIsEpimorphism( phi_psi, true );
    elif HasIsMorphism( phi ) and IsMorphism( phi ) and
       HasIsMorphism( psi ) and IsMorphism( psi ) then
        SetIsMorphism( phi_psi, true );
    fi;
    
    return phi_psi;
    
end );

##
InstallMethod( AugmentMaps,
        "of two homalg maps",
        [ IsMapOfFinitelyGeneratedModulesRep and IsHomalgLeftObjectOrMorphismOfLeftObjects,
          IsMapOfFinitelyGeneratedModulesRep and IsHomalgLeftObjectOrMorphismOfLeftObjects ],
        
  function( phi, psi )
    local S, phi_psi, TpT, p;
    
    S := Range( phi );
    
    if not IsIdenticalObj( S, Source( psi ) ) then
        Error( "the two morphisms must have identical source modules\n" );
    fi;
    
    phi_psi := UnionOfColumns( MatrixOfMap( phi ), MatrixOfMap( psi ) );
    
    TpT := Range( phi ) + Range( psi );
    
    ## get the position of the set of relations immediately after creating TpT;
    p := Genesis( TpT ).("PositionOfTheDefaultSetOfRelationsOfTheOutput");
    
    phi_psi := HomalgMap( phi_psi, S, [ TpT, p ] );
    
    if HasIsMonomorphism( phi ) and IsMonomorphism( phi ) and
       HasIsMorphism( psi ) and IsMorphism( psi ) then
        SetIsMonomorphism( phi_psi, true );
    elif HasIsMorphism( phi ) and IsMorphism( phi ) and
       HasIsMonomorphism( psi ) and IsMonomorphism( psi ) then
        SetIsMonomorphism( phi_psi, true );
    elif HasIsMorphism( phi ) and IsMorphism( phi ) and
       HasIsMorphism( psi ) and IsMorphism( psi ) then
        SetIsMorphism( phi_psi, true );
    fi;
    
    return phi_psi;
    
end );

##
InstallMethod( AugmentMaps,
        "of two homalg maps",
        [ IsMapOfFinitelyGeneratedModulesRep and IsHomalgRightObjectOrMorphismOfRightObjects,
          IsMapOfFinitelyGeneratedModulesRep and IsHomalgRightObjectOrMorphismOfRightObjects ],
        
  function( phi, psi )
    local S, phi_psi, TpT, p;
    
    S := Range( phi );
    
    if not IsIdenticalObj( S, Source( psi ) ) then
        Error( "the two morphisms must have identical source modules\n" );
    fi;
    
    phi_psi := UnionOfRows( MatrixOfMap( phi ), MatrixOfMap( psi ) );
    
    TpT := Range( phi ) + Range( psi );
    
    ## get the position of the set of relations immediately after creating TpT;
    p := Genesis( TpT ).("PositionOfTheDefaultSetOfRelationsOfTheOutput");
    
    phi_psi := HomalgMap( phi_psi, S, [ TpT, p ] );
    
    if HasIsMonomorphism( phi ) and IsMonomorphism( phi ) and
       HasIsMorphism( psi ) and IsMorphism( psi ) then
        SetIsMonomorphism( phi_psi, true );
    elif HasIsMorphism( phi ) and IsMorphism( phi ) and
       HasIsMonomorphism( psi ) and IsMonomorphism( psi ) then
        SetIsMonomorphism( phi_psi, true );
    elif HasIsMorphism( phi ) and IsMorphism( phi ) and
       HasIsMorphism( psi ) and IsMorphism( psi ) then
        SetIsMorphism( phi_psi, true );
    fi;
    
    return phi_psi;
    
end );

##
InstallMethod( PreCompose,
        "of two homalg maps",
        [ IsMapOfFinitelyGeneratedModulesRep and IsHomalgLeftObjectOrMorphismOfLeftObjects,
          IsMapOfFinitelyGeneratedModulesRep and IsHomalgLeftObjectOrMorphismOfLeftObjects ],
        
  function( phi1, phi2 )
    
    return phi1 * phi2;
    
end );

##
InstallMethod( PreCompose,
        "of two homalg maps",
        [ IsMapOfFinitelyGeneratedModulesRep and IsHomalgRightObjectOrMorphismOfRightObjects,
          IsMapOfFinitelyGeneratedModulesRep and IsHomalgRightObjectOrMorphismOfRightObjects ],
        
  function( phi1, phi2 )
    
    return phi2 * phi1;
    
end );

#=======================================================================
# PostDivide
#
# M_ is free or beta is injective ( cf. [BR, Subsection 3.1.1] )
#
#     M_
#     |   \
#  (psi=?)  \ (gamma)
#     |       \
#     v         v
#     N_ -(beta)-> N
#
#
# row convention (left modules): psi := gamma * beta^(-1)	( -> RightDivide )
# column convention (right modules): psi := beta^(-1) * gamma	( -> LeftDivide )
#_______________________________________________________________________

##
InstallMethod( PostDivide,			### defines: PostDivide (RightDivide (high-level))
        "for homalg maps",
        [ IsMapOfFinitelyGeneratedModulesRep and IsHomalgLeftObjectOrMorphismOfLeftObjects,
          IsMapOfFinitelyGeneratedModulesRep and IsHomalgLeftObjectOrMorphismOfLeftObjects ],
        
  function( gamma, beta )
    local N, psi, M_;
    
    N := Range( beta );
    
    if not IsIdenticalObj( N, Range( gamma ) ) then
        Error( "the two morphisms don't have have identically the same target module\n" );
    fi;
    
    ## one of the coolest parts of the code:
    if HasMonomorphismModuloImage( beta ) then
        N := UnionOfRelations( MonomorphismModuloImage( beta ) );	## this replaces [BR, Footnote 13]
    else
        N := RelationsOfModule( N );
    fi;
        
    psi := RightDivide( MatrixOfMap( gamma ), MatrixOfMap( beta ), N );
    
    if psi = fail then
        Error( "the second argument of RightDivide is not a right factor of the first modulo the third, i.e. the rows of the second and third argument are not a generating set!\n" );
    fi;
    
    M_ := Source( gamma );
    
    psi := HomalgMap( psi, M_, Source( beta ) );
    
    if ( HasNrRelations( M_ ) and NrRelations( M_ ) = 0 ) or		## [BR, Subsection 3.1.1,(1)]
       ( HasIsMonomorphism( beta ) and IsMonomorphism( beta ) ) or	## [BR, Subsection 3.1.1,(2)]
       HasMonomorphismModuloImage( beta ) then
        
        SetIsMorphism( psi, true );
        
    fi;
        
    return psi;
    
end );

##
InstallMethod( PostDivide,			### defines: PostDivide (LeftDivide (high-level))
        "for homalg maps",
        [ IsMapOfFinitelyGeneratedModulesRep and IsHomalgRightObjectOrMorphismOfRightObjects,
          IsMapOfFinitelyGeneratedModulesRep and IsHomalgRightObjectOrMorphismOfRightObjects ],
        
  function( gamma, beta )
    local N, psi, M_;
    
    N := Range( beta );
    
    if not IsIdenticalObj( N, Range( gamma ) ) then
        Error( "the two morphisms don't have have identically the same target module\n" );
    fi;
    
    ## one of the coolest parts of the code:
    if HasMonomorphismModuloImage( beta ) then
        N := UnionOfRelations( MonomorphismModuloImage( beta ) );	## this replaces [BR, Footnote 13]
    else
        N := RelationsOfModule( N );
    fi;
        
    psi := LeftDivide( MatrixOfMap( beta ), MatrixOfMap( gamma ), N );
    
    if psi = fail then
        Error( "the first argument of LeftDivide is not a left factor of the second modulo the third, i.e. the columns of the first and third arguments are not a generating set!\n" );
    fi;
    
    M_ := Source( gamma );
    
    psi := HomalgMap( psi, M_, Source( beta ) );
    
    if ( HasNrRelations( M_ ) and NrRelations( M_ ) = 0 ) or		## [BR, Subsection 3.1.1,(1)]
       ( HasIsMonomorphism( beta ) and IsMonomorphism( beta ) ) or	## [BR, Subsection 3.1.1,(2)]
       HasMonomorphismModuloImage( beta ) then
        
        SetIsMorphism( psi, true );
        
    fi;
    
    return psi;
    
end );

#=======================================================================
# Complete an image-square
#
#  A_ is a free or beta1 is injective ( cf. [BR, Subsection 3.1.2] )
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
        [ IsMapOfFinitelyGeneratedModulesRep and IsHomalgLeftObjectOrMorphismOfLeftObjects,
          IsMapOfFinitelyGeneratedModulesRep and IsHomalgLeftObjectOrMorphismOfLeftObjects,
          IsMapOfFinitelyGeneratedModulesRep and IsHomalgLeftObjectOrMorphismOfLeftObjects ],
        
  function( alpha1, phi, beta1 )
    
    return PostDivide( alpha1 * phi, beta1 );
    
end );

##
InstallMethod( CompleteImageSquare,		### defines: CompleteImageSquare (CompleteImSq)
        "for homalg maps",
        [ IsMapOfFinitelyGeneratedModulesRep and IsHomalgRightObjectOrMorphismOfRightObjects,
          IsMapOfFinitelyGeneratedModulesRep and IsHomalgRightObjectOrMorphismOfRightObjects,
          IsMapOfFinitelyGeneratedModulesRep and IsHomalgRightObjectOrMorphismOfRightObjects ],
        
  function( alpha1, phi, beta1 )
    
    return PostDivide( phi * alpha1, beta1 );
    
end );

####################################
#
# constructor functions and methods:
#
####################################

InstallGlobalFunction( HomalgMap,
  function( arg )
    local nargs, source, pos_s, target, pos_t, R, type, matrix, left, matrices, reduced_matrices,
          nr_rows, nr_columns, index_pair, morphism, option;
    
    nargs := Length( arg );
    
    if nargs > 1 then
        if IsHomalgModule( arg[2] ) then
            source := arg[2];
            pos_s := PositionOfTheDefaultSetOfRelations( source );
        elif arg[2] = "free" and nargs > 2 and IsHomalgModule( arg[3] )
          and ( IsHomalgMatrix( arg[1] ) or IsHomalgRelations( arg[1] ) ) then
            if IsHomalgLeftObjectOrMorphismOfLeftObjects( arg[3] ) then
                if IsHomalgMatrix( arg[1] ) then
                    nr_rows := NrRows( arg[1] );
                elif IsHomalgRelations( arg[1] ) then
                    nr_rows := NrRows( MatrixOfRelations( arg[1] ) );
                fi;
                source := HomalgFreeLeftModule( nr_rows, HomalgRing( arg[1] ) );
            else
                if IsHomalgMatrix( arg[1] ) then
                    nr_columns := NrColumns( arg[1] );
                elif IsHomalgRelations( arg[1] ) then
                    nr_columns := NrColumns( MatrixOfRelations( arg[1] ) );
                fi;
                source := HomalgFreeRightModule( nr_columns, HomalgRing( arg[1] ) );
            fi;
            pos_s := PositionOfTheDefaultSetOfRelations( source );
        elif IsHomalgRing( arg[2] ) and not ( IsList( arg[1] ) and nargs = 2 ) then
            source := "ring";
        elif IsList( arg[2] ) and IsHomalgModule( arg[2][1] ) and IsPosInt( arg[2][2] ) then
            source := arg[2][1];
            pos_s := arg[2][2];
            if not IsBound( SetsOfRelations( source )!.( pos_s ) ) then
                Error( "the source module does not possess a ", arg[2][2], ". set of relations (this positive number is given as the second entry of the list provided as the second argument)\n" );
            fi;
        fi;
    fi;
    
    if not IsBound( source ) then
        
        if IsHomalgMatrix( arg[1] ) then
            matrix := arg[1];
        elif IsHomalgRelations( arg[1] ) then
            matrix := MatrixOfRelations( arg[1] );
            left := IsHomalgRelationsOfLeftModule( arg[1] );
        elif IsHomalgRing( arg[nargs] ) then
            matrix := HomalgMatrix( arg[1], arg[nargs] );
        else
            Error( "The second argument must be the source module or the last argument should be an IsHomalgRing\n" );
        fi;
        
        R := HomalgRing( matrix );
        
        if nargs > 1 and IsStringRep( arg[2] ) and Length( arg[2] ) > 0
           and  LowercaseString( arg[2]{[1..1]} ) = "r" then
            left := false;	## we explicitly asked for a morphism of right modules
        elif not IsBound( left ) then
            left := true;
        fi;
        
        if left then
            source := HomalgFreeLeftModule( NrRows( matrix ), R );
            target := HomalgFreeLeftModule( NrColumns( matrix ), R );
            type := TheTypeHomalgMapOfLeftModules;
        else
            source := HomalgFreeRightModule( NrColumns( matrix ), R );
            target := HomalgFreeRightModule( NrRows( matrix ), R );
            type := TheTypeHomalgMapOfRightModules;
        fi;
        
        matrices := rec( );
        
        morphism := rec( 
                         matrices := matrices,
                         reduced_matrices := rec( ),
                         free_resolutions := rec( ),
                         index_pairs_of_presentations := [ [ 1, 1 ] ]);
        
        matrices.( String( [ 1, 1 ] ) ) := matrix;
        
        ## Objectify:
        ObjectifyWithAttributes(
                morphism, type,
                Source, source,
                Range, target );
        
        if ( HasNrRelations( source ) and NrRelations( source ) = 0 ) then
            SetIsMorphism( morphism, true );
        fi;
        
        return morphism;
        
    fi;
    
    if nargs > 2 then
        if IsHomalgModule( arg[3] ) then
            target := arg[3];
            pos_t := PositionOfTheDefaultSetOfRelations( target );
        elif arg[3] = "free" and IsHomalgModule ( source )
          and ( IsHomalgMatrix( arg[1] ) or IsHomalgRelations( arg[1] ) ) then
            if IsHomalgLeftObjectOrMorphismOfLeftObjects( source ) then
                if IsHomalgMatrix( arg[1] ) then
                    nr_columns := NrColumns( arg[1] );
                elif IsHomalgRelations( arg[1] ) then
                    nr_columns := NrColumns( MatrixOfRelations( arg[1] ) );
                fi;
                target := HomalgFreeLeftModule( nr_columns, HomalgRing( arg[1] ) );
            else
                if IsHomalgMatrix( arg[1] ) then
                    nr_rows := NrRows( arg[1] );
                elif IsHomalgRelations( arg[1] ) then
                    nr_rows := NrRows( MatrixOfRelations( arg[1] ) );
                fi;
                target := HomalgFreeRightModule( nr_rows, HomalgRing( arg[1] ) );
            fi;
            pos_t := PositionOfTheDefaultSetOfRelations( target );
        elif IsHomalgRing( arg[3] ) then
            if source = "ring" then
                source := HomalgFreeLeftModule( 1, arg[2] );
                if not IsIdenticalObj( arg[2], arg[3] ) then
                    Error( "the source and target modules must be defined over the same ring\n" );
                fi;
                target := source;	## we get an endomorphism
                pos_s := PositionOfTheDefaultSetOfRelations( source );
                pos_t := pos_s;
            else
                target := HomalgFreeLeftModule( 1, arg[3] );
                pos_t := PositionOfTheDefaultSetOfRelations( target );
            fi;
        elif IsList( arg[3] ) and IsHomalgModule( arg[3][1] ) and IsPosInt( arg[3][2] ) then
            target := arg[3][1];
            pos_t := arg[3][2];
            if not IsBound( SetsOfRelations( target )!.( pos_t ) ) then
                Error( "the target module does not possess a ", arg[3][2], ". set of relations (this positive number is given as the second entry of the list provided as the third argument)\n" );
            fi;
        fi;
    elif source = "ring" then
        source := HomalgFreeLeftModule( 1, arg[2] );
        target := source;	## we get an endomorphism
        pos_s := PositionOfTheDefaultSetOfRelations( source );
        pos_t := pos_s;
    else
        pos_t := pos_s;
    fi;
    
    R := HomalgRing( source );
    
    if IsBound( target ) and not IsIdenticalObj( source, target ) then
        if not IsIdenticalObj( R, HomalgRing( target ) ) then
            Error( "the source and target modules must be defined over the same ring\n" );
        elif IsHomalgLeftObjectOrMorphismOfLeftObjects( source ) and IsHomalgLeftObjectOrMorphismOfLeftObjects( target ) then
            type := TheTypeHomalgMapOfLeftModules;
        elif IsHomalgRightObjectOrMorphismOfRightObjects( source ) and IsHomalgRightObjectOrMorphismOfRightObjects( target ) then
            type := TheTypeHomalgMapOfRightModules;
        else
            Error( "the source and target modules of a morphism must either both be left or both be right modules\n" );
        fi;
    else
        target := source;
        if IsHomalgLeftObjectOrMorphismOfLeftObjects( source ) then
            type := TheTypeHomalgSelfMapOfLeftModules;
        else
            type := TheTypeHomalgSelfMapOfRightModules;
        fi;
    fi;
    
    if IsHomalgLeftObjectOrMorphismOfLeftObjects( source ) then
        nr_rows := NrGenerators( source, pos_s );
        nr_columns := NrGenerators( target, pos_t );
        index_pair := [ pos_s, pos_t ];
    else
        nr_columns := NrGenerators( source, pos_s );
        nr_rows := NrGenerators( target, pos_t );
        index_pair := [ pos_t, pos_s ];
    fi;
    
    matrices := rec( );
    
    reduced_matrices := rec( );
    
    morphism := rec( 
                     matrices := matrices,
                     reduced_matrices := reduced_matrices,
                     free_resolutions := rec( ),
                     index_pairs_of_presentations := [ index_pair ]);
    
    if IsList( arg[1] ) and Length( arg[1] ) = 1 and IsString( arg[1][1] ) and Length( arg[1][1] ) > 0 then
        
        option := arg[1][1];
        
        if Length( option ) > 3 and LowercaseString( option{[1..4]} ) = "zero" then
            ## the zero morphism:
            
            matrix := HomalgZeroMatrix( nr_rows, nr_columns, R );
            
            matrices.( String( index_pair ) ) := matrix;
            
            reduced_matrices.( String( index_pair ) ) := matrix;
            
            ## Objectify:
            ObjectifyWithAttributes(
                    morphism, type,
                    Source, source,
                    Range, target,
                    IsZero, true );
            
            if HasIsZero( source ) and IsZero( source ) then
                SetIsSplitMonomorphism( morphism, true );
            fi;
            
            if HasIsZero( target ) and IsZero( target ) then
                SetIsSplitEpimorphism( morphism, true );
            fi;
            
        elif Length( option ) > 7 and  LowercaseString( option{[1..8]} ) = "identity" then
            ## the identity morphism:
            
            if nr_rows <> nr_columns then
                Error( "for a matrix of a morphism to be the identity matrix the number of generators of the source and target module must coincide\n" );
            fi;
            
            matrix := HomalgIdentityMatrix( nr_rows, R );
            
            matrices.( String( index_pair ) ) := matrix;
            
            if IsIdenticalObj( source, target ) then
                if pos_s = pos_t then
                    ## Objectify:
                    ObjectifyWithAttributes(
                            morphism, type,
                            Source, source,
                            Range, target,
                            IsIdentityMorphism, true );
                else
                    ## Objectify:
                    ObjectifyWithAttributes(
                            morphism, type,
                            Source, source,
                            Range, target,
                            IsAutomorphism, true );
                fi;
            else
                ## Objectify:
                ObjectifyWithAttributes(
                        morphism, type,
                        Source, source,
                        Range, target,
                        IsEpimorphism, true );
            fi;
            
        else
            Error( "wrong first argument: ", arg[1], "\n" );
        fi;
        
    else
        
        if IsHomalgMatrix( arg[1] ) then
            if not IsIdenticalObj( HomalgRing( arg[1] ), R ) then
                Error( "the matrix and the modules are not defined over identically the same ring\n" );
            fi;
            matrix := arg[1];
        elif IsHomalgRelations( arg[1] ) then
            if not IsIdenticalObj( HomalgRing( arg[1] ), R ) then
                Error( "the matrix and the modules are not defined over identically the same ring\n" );
            fi;
            matrix := MatrixOfRelations( arg[1] );
        elif IsList( arg[1] ) then
            matrix := HomalgMatrix( arg[1], R );
        else
            Error( "the first argument must be in { IsHomalgMatrix, IsHomalgRelations, IsMatrix, IsList } but received: ",  arg[1], "\n" );
        fi;
        
        if IsHomalgLeftObjectOrMorphismOfLeftObjects( source )
           and ( NrGenerators( source, pos_s ) <> NrRows( matrix )
                 or NrGenerators( target, pos_t ) <> NrColumns( matrix ) ) then
            Error( "the dimensions of the matrix do not match numbers of generators of the modules\n" );
        elif IsHomalgRightObjectOrMorphismOfRightObjects( source )
           and ( NrGenerators( source, pos_s ) <> NrColumns( matrix )
                 or NrGenerators( target, pos_t ) <> NrRows( matrix ) ) then
            Error( "the dimensions of the matrix do not match numbers of generators of the modules\n" );
        fi;
        
        matrices.( String( index_pair ) ) := matrix;
        
        ## Objectify:
        ObjectifyWithAttributes(
                morphism, type,
                Source, source,
                Range, target );
        
    fi;
    
    if ( HasNrRelations( source ) and NrRelations( source ) = 0 ) then
        SetIsMorphism( morphism, true );
    fi;
    
    return morphism;
    
end );
  
##
InstallGlobalFunction( HomalgZeroMap,
  function( arg )
    
    return CallFuncList( HomalgMap, Concatenation( [ [ "zero" ] ], arg ) );
    
end );

##
InstallGlobalFunction( HomalgIdentityMap,
  function( arg )
    
    return CallFuncList( HomalgMap, Concatenation( [ [ "identity" ] ], arg ) );
    
end );

####################################
#
# View, Print, and Display methods:
#
####################################

InstallMethod( ViewObj,
        "for homalg maps",
        [ IsHomalgMap ],
        
  function( o )
    
    Print( "<A" );
    
    if HasIsZero( o ) then ## if this method applies and HasIsZero is set we already know that o is a non-zero morphism of homalg modules
        Print( " non-zero" );
    fi;
    
    if HasIsMorphism( o ) then
        if IsMorphism( o ) then
            Print( " homomorphism of" );
        elif HasMonomorphismModuloImage( o ) then
            Print( " monomorphism (modulo a certain submodule) of" );
        else
            Print( " non-well-defined map between" );
        fi;
    else
        if HasMonomorphismModuloImage( o ) then
            Print( " monomorphism (modulo a certain submodule) of" );
        else
            Print( " \"homomorphism\" of" );
        fi;
    fi;
    
    if IsHomalgLeftObjectOrMorphismOfLeftObjects( o ) then
        Print( " left" );
    else
        Print( " right" );
    fi;
    
    Print( " modules>" );
    
end );

##
InstallMethod( ViewObj,
        "for homalg maps",
        [ IsHomalgMap and IsMonomorphism ], 996,
        
  function( o )
    
    Print( "<A monomorphism of" );
    
    if IsHomalgLeftObjectOrMorphismOfLeftObjects( o ) then
        Print( " left" );
    else
        Print( " right" );
    fi;
    
    Print( " modules>" );
    
end );    

##
InstallMethod( ViewObj,
        "for homalg maps",
        [ IsHomalgMap and IsEpimorphism ], 997,
        
  function( o )
    
    Print( "<An epimorphism of" );
    
    if IsHomalgLeftObjectOrMorphismOfLeftObjects( o ) then
        Print( " left" );
    else
        Print( " right" );
    fi;
    
    Print( " modules>" );
    
end );    

##
InstallMethod( ViewObj,
        "for homalg maps",
        [ IsHomalgMap and IsSplitMonomorphism ], 998,
        
  function( o )
    
    Print( "<A split monomorphism of" );
    
    if IsHomalgLeftObjectOrMorphismOfLeftObjects( o ) then
        Print( " left" );
    else
        Print( " right" );
    fi;
    
    Print( " modules>" );
    
end );    

##
InstallMethod( ViewObj,
        "for homalg maps",
        [ IsHomalgMap and IsSplitEpimorphism ], 999,
        
  function( o )
    
    Print( "<A split epimorphism of" );
    
    if IsHomalgLeftObjectOrMorphismOfLeftObjects( o ) then
        Print( " left" );
    else
        Print( " right" );
    fi;
    
    Print( " modules>" );
    
end );    

##
InstallMethod( ViewObj,
        "for homalg maps",
        [ IsHomalgMap and IsIsomorphism ], 1000,
        
  function( o )
    
    Print( "<An isomorphism of" );
    
    if IsHomalgLeftObjectOrMorphismOfLeftObjects( o ) then
        Print( " left" );
    else
        Print( " right" );
    fi;
    
    Print( " modules>" );
    
end );    

##
InstallMethod( ViewObj,
        "for homalg maps",
        [ IsHomalgMap and IsZero ], 1001,
        
  function( o )
    
    Print( "<The zero morphism of" );
    
    if IsHomalgLeftObjectOrMorphismOfLeftObjects( o ) then
        Print( " left" );
    else
        Print( " right" );
    fi;
    
    Print( " modules>" );
    
end );    

InstallMethod( ViewObj,
        "for homalg maps",
        [ IsHomalgSelfMap ],
        
  function( o )
    
    Print( "<A" );
    
    if HasIsZero( o ) then ## if this method applies and HasIsZero is set we already know that o is a non-zero morphism of homalg modules
        Print( " non-zero" );
    elif not ( HasIsMorphism( o ) and not IsMorphism( o ) ) then
        Print( "n" );
    fi;
    
    if HasIsMorphism( o ) then
        if IsMorphism( o ) then
            Print( " endomorphism of" );
        else
            Print( " non-well-defined self-map of" );
        fi;
    else
        Print( " \"endomorphism\" of" );
    fi;
    
    if IsHomalgLeftObjectOrMorphismOfLeftObjects( o ) then
        Print( " a left" );
    else
        Print( " a right" );
    fi;
    
    Print( " module>" );
    
end );

##
InstallMethod( ViewObj,
        "for homalg maps",
        [ IsHomalgSelfMap and IsMonomorphism ],
        
  function( o )
    
    Print( "<A monic endomorphism of" );
    
    if IsHomalgLeftObjectOrMorphismOfLeftObjects( o ) then
        Print( " a left" );
    else
        Print( " a right" );
    fi;
    
    Print( " module>" );
    
end );    

##
InstallMethod( ViewObj,
        "for homalg maps",
        [ IsHomalgSelfMap and IsEpimorphism ], 996,
        
  function( o )
    
    Print( "<An epic endomorphism of" );
    
    if IsHomalgLeftObjectOrMorphismOfLeftObjects( o ) then
        Print( " a left" );
    else
        Print( " a right" );
    fi;
    
    Print( " module>" );
    
end );    

##
InstallMethod( ViewObj,
        "for homalg maps",
        [ IsHomalgSelfMap and IsSplitMonomorphism ], 997,
        
  function( o )
    
    Print( "<A split monic endomorphism of" );
    
    if IsHomalgLeftObjectOrMorphismOfLeftObjects( o ) then
        Print( " a left" );
    else
        Print( " a right" );
    fi;
    
    Print( " module>" );
    
end );    

##
InstallMethod( ViewObj,
        "for homalg maps",
        [ IsHomalgSelfMap and IsSplitEpimorphism ], 998,
        
  function( o )
    
    Print( "<A split epic endomorphism of" );
    
    if IsHomalgLeftObjectOrMorphismOfLeftObjects( o ) then
        Print( " a left" );
    else
        Print( " a right" );
    fi;
    
    Print( " module>" );
    
end );    

##
InstallMethod( ViewObj,
        "for homalg maps",
        [ IsHomalgSelfMap and IsAutomorphism ], 999,
        
  function( o )
    
    Print( "<An automorphism of" );
    
    if IsHomalgLeftObjectOrMorphismOfLeftObjects( o ) then
        Print( " a left" );
    else
        Print( " a right" );
    fi;
    
    Print( " module>" );
    
end );    

##
InstallMethod( ViewObj,
        "for homalg maps",
        [ IsHomalgSelfMap and IsIdentityMorphism ], 1000,
        
  function( o )
    
    Print( "<The identity morphism of" );
    
    if IsHomalgLeftObjectOrMorphismOfLeftObjects( o ) then
        Print( " a left" );
    else
        Print( " a right" );
    fi;
    
    Print( " module>" );
    
end );    

##
InstallMethod( ViewObj,
        "for homalg maps",
        [ IsHomalgSelfMap and IsZero ], 1001,
        
  function( o )
    
    Print( "<The zero endomorphism of" );
    
    if IsHomalgLeftObjectOrMorphismOfLeftObjects( o ) then
        Print( " a left" );
    else
        Print( " a right" );
    fi;
    
    Print( " module>" );
    
end );    

InstallMethod( Display,
        "for homalg maps",
        [ IsMapOfFinitelyGeneratedModulesRep ],
        
  function( o )
    
    Display( MatrixOfMap( o ) );
    
end );

