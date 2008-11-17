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
InstallMethod( homalgResetFilters,
        "for homalg chain maps",
        [ IsHomalgMap ],
        
  function( cm )
    local property;
    
    if not IsBound( HOMALG.PropertiesOfChainMaps ) then
        HOMALG.PropertiesOfChainMaps :=
          [ IsZero,
            IsMorphism,
            IsGeneralizedMorphism,
            IsSplitMonomorphism,
            IsMonomorphism,
            IsGeneralizedMonomorphism,
            IsSplitEpimorphism,
            IsEpimorphism,
            IsGeneralizedEpimorphism,
            IsIsomorphism,
            IsGeneralizedIsomorphism ];
    fi;
    
    for property in HOMALG.PropertiesOfChainMaps do
        ResetFilterObj( cm, property );
    od;
    
end );

##
InstallMethod( DegreeOfMorphism,
        "for homalg maps",
        [ IsHomalgMap ],
        
  function( phi )
    
    return 0;
    
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
    local phi;
    
    if not AreComparableMorphisms( phi1, phi2 ) then
        return false;
    fi;
    
    if HasMorphismAidMap( phi1 ) then
        if not HasMorphismAidMap( phi2 ) or
           MorphismAidMap( phi1 ) <> MorphismAidMap( phi2 ) then
            return false;
        fi;
    elif HasMorphismAidMap( phi2 ) then
        if not HasMorphismAidMap( phi1 ) or
           MorphismAidMap( phi1 ) <> MorphismAidMap( phi2 ) then
            return false;
        fi;
    fi;
    
    ## don't use phi1 - phi2 since FunctorObj will then cause an infinite loop
    phi := HomalgMap( MatrixOfMap( phi1 ) - MatrixOfMap( phi2 ), Source( phi1 ), Range( phi1 ) );
    
    ## this takes care of the relations of the target module
    return IsZero( phi );
    
end );

##
InstallMethod( ZeroMutable,
        "for homalg maps",
        [ IsMapOfFinitelyGeneratedModulesRep ],
        
  function( phi )
    
    return HomalgMap( 0 * MatrixOfMap( phi ), Source( phi ), Range( phi ) );
    
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
## composition is a bifunctor to profit from the caching mechanisms for functors (cf. ToolFunctors.gi)
##

##
InstallMethod( POW,
        "for homalg maps",
        [ IsMapOfFinitelyGeneratedModulesRep, IsInt ],
        
  function( phi, pow )
    local id, inv;
    
    if pow = -1 then
        
        id := TheIdentityMorphism( Range( phi ) );
        
        inv := id / phi;
        
        if HasIsIsomorphism( phi ) then
            SetIsIsomorphism( inv, IsIsomorphism( phi ) );
        fi;
        
        return inv;
        
    fi;
    
    TryNextMethod( );
    
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
    
    return DecideZero( MatrixOfMap( phi ), rel );
    
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
    
    phi!.reduced_matrices.(String( index_pair )) := reduced;
    
    return reduced;
    
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
InstallMethod( ReducedSyzygiesGenerators,
        "for homalg maps",
        [ IsMapOfFinitelyGeneratedModulesRep ],
        
  function( phi )
    
    return ReducedSyzygiesGenerators( MatrixOfMap( phi ), Range( phi ) );
    
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

##
InstallMethod( PreInverse,
        "for homalg maps",
        [ IsMapOfFinitelyGeneratedModulesRep ],
        
  function( phi )
    
    return fail;
    
end );

##
InstallMethod( PreInverse,
        "for homalg maps",
        [ IsMapOfFinitelyGeneratedModulesRep ],
        
  function( phi )
    local R, S, T, M, p, Ib, Ic, b, c, P, d, Id, PI, B, A, L, sigma;
    
    R := HomalgRing( phi );
    
    if not( HasIsCommutative( R ) and IsCommutative( R ) ) then
        TryNextMethod( );
    fi;
    
    S := Source( phi );
    T := Range( phi );
    
    M := MatrixOfRelations( ReducedBasisOfModule( S ) );
    
    p := MatrixOfMap( phi );
    
    #=====# begin of the core procedure #=====#
    
    Ib := MatrixOfMap( TheIdentityMorphism( S ) );
    Ic := MatrixOfMap( TheIdentityMorphism( T ) );
    
    b := NrRows( Ib );
    c := NrRows( Ic );
    
    P := ReducedBasisOfModule( T );
    
    d := NrRelations( P );
    Id := HomalgIdentityMatrix( d, R );
    
    P := MatrixOfRelations( P );
    
    PI := Involution( P );
    
    B := EntriesOfHomalgMatrix( Ic );
    
    B := Concatenation( ListWithIdenticalEntries( b * d, Zero( R ) ), B );
    
    if IsHomalgLeftObjectOrMorphismOfLeftObjects( phi ) then
        B := HomalgMatrix( B, 1, b * d + c * c, R );
        A := UnionOfColumns( KroneckerMat( PI, Ib ), KroneckerMat( Ic, p ) );
        L := DiagMat( [ KroneckerMat( Id, M ), KroneckerMat( Ic, P ) ] );
        sigma := RightDivide( B, A, L );
    else
        B := HomalgMatrix( B, b * d + c * c, 1, R );
        A := UnionOfRows( KroneckerMat( Ib, PI ), KroneckerMat( p, Ic ) );
        L := DiagMat( [ KroneckerMat( M, Id ), KroneckerMat( P, Ic ) ] );
        sigma := LeftDivide( A, B, L );
    fi;
    
    if IsBool( sigma ) then
        return false;
    fi;
    
    ## we already have every thing to build the (matrix of the) split sigma
    
    sigma := EntriesOfHomalgMatrix( sigma );
    
    if IsHomalgLeftObjectOrMorphismOfLeftObjects( phi ) then
        sigma := HomalgMatrix( sigma, c, b, R );
    else
        sigma := HomalgMatrix( sigma, b, c, R );
    fi;
    
    sigma := HomalgMap( sigma, T, S );
    
    
    Assert( 1, IsMonomorphism( sigma ) );
    SetIsMonomorphism( sigma, true );
    
    DecideZero( sigma );
    
    return sigma;
    
end );

##
InstallMethod( PreInverse,
        "for homalg maps",
        [ IsMapOfFinitelyGeneratedModulesRep ],
        
  function( phi )
    local inv;
    
    if not IsEpimorphism( phi ) then
        return false;
    elif IsIsomorphism( phi ) then
	return phi ^ -1;
    fi;
    
    DecideZero( phi );
    
    if IsHomalgLeftObjectOrMorphismOfLeftObjects( phi ) then
        inv := LeftInverse( MatrixOfMap( phi ) );
    else
        inv := RightInverse( MatrixOfMap( phi ) );
    fi;
    
    ## this must come before any Eval:
    if HasIsZero( inv ) and IsZero( inv ) then
        return TheZeroMap( Range( phi ), Source( phi ) );
    fi;
    
    if IsBool( Eval( inv ) ) then
        return false;
    fi;
    
    inv := HomalgMap( inv, Range( phi ), Source( phi ) );
    
    if IsMorphism( inv ) then
        
        Assert( 1, IsMonomorphism( inv ) );
        SetIsMonomorphism( inv, true );
        
        DecideZero( inv );
        return inv;
    fi;
    
    TryNextMethod( );
    
end );

##
InstallMethod( PostInverse,
        "for homalg maps",
        [ IsMapOfFinitelyGeneratedModulesRep ],
        
  function( phi )
    
    return fail;
    
end );

##
InstallMethod( PostInverse,
        "for homalg maps",
        [ IsMapOfFinitelyGeneratedModulesRep ],
        
  function( phi )
    local inv;
    
    if not IsMonomorphism( phi ) then
        return false;
    elif IsIsomorphism( phi ) then
	return phi ^ -1;
    fi;
    
    DecideZero( phi );
    
    if IsHomalgLeftObjectOrMorphismOfLeftObjects( phi ) then
        inv := RightInverse( MatrixOfMap( phi ) );
    else
        inv := LeftInverse( MatrixOfMap( phi ) );
    fi;
    
    ## this must come before any Eval:
    if HasIsZero( inv ) and IsZero( inv ) then
        return TheZeroMap( Range( phi ), Source( phi ) );
    fi;
    
    if IsBool( Eval( inv ) ) then
        return false;
    fi;
    
    inv := HomalgMap( inv, Range( phi ), Source( phi ) );
    
    if IsMorphism( inv ) then
        
        Assert( 1, IsEpimorphism( inv ) );
        SetIsEpimorphism( inv, true );
        
        DecideZero( inv );
        return inv;
    fi;
    
    TryNextMethod( );
    
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
    
    return alpha1 * phi / beta1;
    
end );

##
InstallMethod( CompleteImageSquare,		### defines: CompleteImageSquare (CompleteImSq)
        "for homalg maps",
        [ IsMapOfFinitelyGeneratedModulesRep and IsHomalgRightObjectOrMorphismOfRightObjects,
          IsMapOfFinitelyGeneratedModulesRep and IsHomalgRightObjectOrMorphismOfRightObjects,
          IsMapOfFinitelyGeneratedModulesRep and IsHomalgRightObjectOrMorphismOfRightObjects ],
        
  function( alpha1, phi, beta1 )
    
    return phi * alpha1 / beta1;
    
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
                source := HomalgFreeLeftModule( nr_rows, HomalgRing( arg[3] ) );
            else
                if IsHomalgMatrix( arg[1] ) then
                    nr_columns := NrColumns( arg[1] );
                elif IsHomalgRelations( arg[1] ) then
                    nr_columns := NrColumns( MatrixOfRelations( arg[1] ) );
                fi;
                source := HomalgFreeRightModule( nr_columns, HomalgRing( arg[3] ) );
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
            ResetFilterObj( arg[1], IsMutableMatrix );
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
            ## the zero map:
            
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
            ## the identity map:
            
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
            ResetFilterObj( arg[1], IsMutableMatrix );
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

##
InstallMethod( OnAFreeSource,
        "for homalg maps",
        [ IsMapOfFinitelyGeneratedModulesRep ],
        
  function( phi )
    
    return HomalgMap( MatrixOfMap( phi ), "free", Range( phi ) );
    
end );

##
InstallMethod( RemoveMorphismAidMap,
        "for homalg maps",
        [ IsMapOfFinitelyGeneratedModulesRep ],
        
  function( phi )
    
    return HomalgMap( MatrixOfMap( phi ), Source( phi ), Range( phi ) );
    
end );

##
InstallMethod( GeneralizedMap,
        "for homalg maps",
        [ IsMapOfFinitelyGeneratedModulesRep, IsObject ],
        
  function( phi, morphism_aid_map )
    local morphism_aid_map1, psi;
    
    if not IsHomalgMap( morphism_aid_map ) then
        return phi;
    fi;
    
    if not IsIdenticalObj( Range( phi ), Range( morphism_aid_map ) ) then
        Error( "the targets of the two morphisms must coincide\n" );
    fi;
    
    ## we don't need the source of the morphism aid map
    morphism_aid_map1 := OnAFreeSource( morphism_aid_map );
    
    ## prepare a copy of phi
    psi := HomalgMap( MatrixOfMap( phi ), Source( phi ), Range( phi ) );
    
    SetMorphismAidMap( psi, morphism_aid_map1 );
    
    return psi;
    
end );

##
InstallMethod( AddToMorphismAidMap,
        "for homalg maps",
        [ IsMapOfFinitelyGeneratedModulesRep, IsObject ],
        
  function( phi, morphism_aid_map )
    local morphism_aid_map1, morphism_aid_map0;
    
    if not IsHomalgMap( morphism_aid_map ) then
        return phi;
    fi;
    
    if not IsIdenticalObj( Range( phi ), Range( morphism_aid_map ) ) then
        Error( "the targets of the two morphisms must coincide\n" );
    fi;
    
    ## we don't need the source of the new morphism aid map
    morphism_aid_map1 := OnAFreeSource( morphism_aid_map );
    
    if HasMorphismAidMap( phi ) then
        ## we don't need the source of the old morphism aid map
        morphism_aid_map0 := OnAFreeSource( MorphismAidMap( phi ) );
        morphism_aid_map1 := StackMaps( morphism_aid_map0, morphism_aid_map1 );
    fi;
    
    return GeneralizedMap( phi, morphism_aid_map1 );
    
end );

##
InstallMethod( UpdateModulesByMap,
        "for homalg maps",
        [ IsHomalgMap and IsIsomorphism ],
        
  function( phi )
    local S, T, propertiesS, propertiesT, attributesS, attributesT, p, a;
    
    S := Source( phi );
    T := Range( phi );
    
    propertiesS := KnownPropertiesOfObject( S );
    propertiesT := KnownPropertiesOfObject( T );
    
    attributesS := Intersection2( KnownAttributesOfObject( S ), LIMOD.intrinsic_attributes );
    attributesT := Intersection2( KnownAttributesOfObject( T ), LIMOD.intrinsic_attributes );
    
    ## for properties:
    for p in propertiesS do	## also check if properties already set for both modules coincide
        Setter( ValueGlobal( p ) )( T, ValueGlobal( p )( S ) );
    od;
    
    ## now backwards
    for p in Difference( propertiesT, propertiesS ) do
        Setter( ValueGlobal( p ) )( S, ValueGlobal( p )( T ) );
    od;
    
    ## for attributes:
    for a in Difference( attributesS, attributesT ) do
        Setter( ValueGlobal( a ) )( T, ValueGlobal( a )( S ) );
    od;
    
    ## now backwards
    for a in Difference( attributesT, attributesS ) do
        Setter( ValueGlobal( a ) )( S, ValueGlobal( a )( T ) );
    od;
    
    ## also check if properties already set for both modules coincide
    
    ## by now, more attributes than the union might be konwn
    attributesS := Intersection2( KnownAttributesOfObject( S ), LIMOD.intrinsic_attributes );
    attributesT := Intersection2( KnownAttributesOfObject( T ), LIMOD.intrinsic_attributes );
    
    for a in Intersection2( attributesS, attributesT ) do
        if ValueGlobal( a )( S ) <> ValueGlobal( a )( T ) then
            Error( "the attribute ", a, " has different values for source and target modules\n" );
        fi;
    od;
    
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
    
    if HasIsZero( o ) then ## if this method applies and HasIsZero is set we already know that o is a non-zero map of homalg modules
        Print( " non-zero" );
    fi;
    
    if HasIsMorphism( o ) then
        if IsMorphism( o ) then
            Print( " homomorphism of" );
        elif HasMorphismAidMap( o ) then	## otherwise the notion of generalized morphism is meaningless
            if HasIsGeneralizedMorphism( o ) then
                if HasIsGeneralizedIsomorphism( o ) and IsGeneralizedIsomorphism( o ) then
                    Print( " generalized isomorphism of" );
                elif HasIsGeneralizedMonomorphism( o ) and IsGeneralizedMonomorphism( o ) then
                    Print( " generalized embedding of" );
                elif HasIsGeneralizedEpimorphism( o ) and IsGeneralizedEpimorphism( o ) then
                    Print( " generalized epimorphism of" );
                elif IsGeneralizedMorphism( o ) then
                    Print( " generalized homomorphism of" );
                else
                    Print( " non-well defined (generalized) map of" );
                fi;
            else
                Print( " \"generalized homomorphism\" of" );
            fi;
        else
            Print( " non-well-defined map between" );
        fi;
    else
        if HasMorphismAidMap( o ) then	## otherwise the notion of generalized morphism is meaningless
            if HasIsGeneralizedMorphism( o ) then
                if HasIsGeneralizedIsomorphism( o ) and IsGeneralizedIsomorphism( o ) then
                    Print( " generalized isomorphism of" );
                elif HasIsGeneralizedMonomorphism( o ) and IsGeneralizedMonomorphism( o ) then
                    Print( " generalized embedding of" );
                elif HasIsGeneralizedEpimorphism( o ) and IsGeneralizedEpimorphism( o ) then
                    Print( " generalized epimorphism of" );
                elif IsGeneralizedMorphism( o ) then
                    Print( " generalized homomorphism of" );
                else
                    Print( " non-well defined (generalized) map of" );
                fi;
            else
                Print( " \"generalized homomorphism\" of" );
            fi;
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
    
    if HasIsZero( o ) then ## if this method applies and HasIsZero is set we already know that o is a non-zero map of homalg modules
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

