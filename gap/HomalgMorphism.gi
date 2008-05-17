#############################################################################
##
##  HomalgMorphism.gi           homalg package               Mohamed Barakat
##
##  Copyright 2007-2008 Lehrstuhl B für Mathematik, RWTH Aachen
##
##  Implementation stuff for homalg morphisms.
##
#############################################################################

####################################
#
# representations:
#
####################################

# a new representation for the category IsHomalgMorphism:
DeclareRepresentation( "IsMorphismOfFinitelyGeneratedModulesRep",
        IsHomalgMorphism,
        [ "source", "target", "matrices", "index_pairs_of_presentations" ] );

####################################
#
# families and types:
#
####################################

# a new family:
BindGlobal( "TheFamilyOfHomalgMorphisms",
        NewFamily( "TheFamilyOfHomalgMorphisms" ) );

# four new types:
BindGlobal( "TheTypeHomalgMorphismOfLeftModules",
        NewType( TheFamilyOfHomalgMorphisms,
                IsMorphismOfFinitelyGeneratedModulesRep and IsHomalgMorphismOfLeftModules ) );

BindGlobal( "TheTypeHomalgMorphismOfRightModules",
        NewType( TheFamilyOfHomalgMorphisms,
                IsMorphismOfFinitelyGeneratedModulesRep and IsHomalgMorphismOfRightModules ) );

BindGlobal( "TheTypeHomalgEndomorphismOfLeftModules",
        NewType( TheFamilyOfHomalgMorphisms,
                IsMorphismOfFinitelyGeneratedModulesRep and IsHomalgEndomorphism and IsHomalgMorphismOfLeftModules ) );

BindGlobal( "TheTypeHomalgEndomorphismOfRightModules",
        NewType( TheFamilyOfHomalgMorphisms,
                IsMorphismOfFinitelyGeneratedModulesRep and IsHomalgEndomorphism and IsHomalgMorphismOfRightModules ) );

####################################
#
# logical implications methods:
#
####################################

##
InstallTrueMethod( IsMorphism, IsHomalgMorphism and IsMonomorphism );

##
InstallTrueMethod( IsMorphism, IsHomalgMorphism and IsEpimorphism );

##
InstallTrueMethod( IsIsomorphism, IsHomalgMorphism and IsAutomorphism );

##
InstallTrueMethod( IsAutomorphism, IsHomalgEndomorphism and IsIsomorphism );

##
InstallTrueMethod( IsSplitMonomorphism, IsHomalgMorphism and IsIsomorphism );

##
InstallTrueMethod( IsSplitEpimorphism, IsHomalgMorphism and IsIsomorphism );

##
InstallTrueMethod( IsEpimorphism, IsHomalgMorphism and IsSplitEpimorphism );

##
InstallTrueMethod( IsMonomorphism, IsHomalgMorphism and IsSplitMonomorphism );

##
InstallTrueMethod( IsIsomorphism, IsHomalgMorphism and IsEpimorphism and IsMonomorphism );

####################################
#
# immediate methods for properties:
#
####################################

####################################
#
# logical implications methods:
#
####################################

##
InstallImmediateMethod( IsZero,
        IsHomalgMorphism, 0,
        
  function( phi )
    
    if IsZero( SourceOfMorphism( phi ) ) or IsZero( TargetOfMorphism( phi ) ) then
        return true;
    fi;
    
    TryNextMethod( );
    
end );

##
InstallImmediateMethod( IsZero,
        IsMorphismOfFinitelyGeneratedModulesRep, 0,
        
  function( phi )
    
    if HasIsZero( MatrixOfMorphism( phi ) ) and IsZero( MatrixOfMorphism( phi ) ) then
        return true;
    fi;
    
    TryNextMethod( );
    
end );

##
InstallImmediateMethod( IsZero,
        IsMorphismOfFinitelyGeneratedModulesRep, 0,
        
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
# immediate methods for attributes:
#
####################################

####################################
#
# methods for properties:
#
####################################

##
InstallMethod( IsMorphism,
        "for homalg morphisms",
        [ IsMorphismOfFinitelyGeneratedModulesRep and IsHomalgMorphismOfLeftModules ],
        
  function( phi )
    local mat;
    
    mat := MatrixOfRelations( SourceOfMorphism( phi ) ) * MatrixOfMorphism( phi );
    
    return IsZero( DecideZero( mat , RelationsOfModule( TargetOfMorphism( phi ) ) ) );
    
end );

##
InstallMethod( IsMorphism,
        "for homalg morphisms",
        [ IsMorphismOfFinitelyGeneratedModulesRep and IsHomalgMorphismOfRightModules ],
        
  function( phi )
    local mat;
    
    mat := MatrixOfMorphism( phi ) * MatrixOfRelations( SourceOfMorphism( phi ) );
    
    return IsZero( DecideZero( mat , RelationsOfModule( TargetOfMorphism( phi ) ) ) );
    
end );

##
InstallMethod( IsZero,
        "for homalg morphisms",
        [ IsMorphismOfFinitelyGeneratedModulesRep ],
        
  function( phi )
    
    return IsZero( DecideZero( phi ) );
    
end );

##
InstallMethod( IsEpimorphism,
        "for homalg morphisms",
        [ IsMorphismOfFinitelyGeneratedModulesRep ],
        
  function( phi )
    
    return IsMorphism( phi ) and IsZero( Cokernel( phi ) );
    
end );

##
InstallMethod( IsMonomorphism,
        "for homalg morphisms",
        [ IsMorphismOfFinitelyGeneratedModulesRep ],
        
  function( phi )
    
    return IsMorphism( phi ) and IsZero( Kernel( phi ) );
    
end );

##
InstallMethod( IsIsomorphism,
        "for homalg morphisms",
        [ IsMorphismOfFinitelyGeneratedModulesRep ],
        
  function( phi )
    
    return IsEpimorphism( phi ) and IsMonomorphism( phi );
    
end );

##
InstallMethod( IsAutomorphism,
        "for homalg morphisms",
        [ IsMorphismOfFinitelyGeneratedModulesRep ],
        
  function( phi )
    
    return IsHomalgEndomorphism( phi ) and IsIsomorphism( phi );
    
end );

####################################
#
# methods for operations:
#
####################################

##
InstallMethod( HomalgRing,
        "for homalg morphisms",
        [ IsHomalgMorphism ],
        
  function( phi )
    
    return HomalgRing( SourceOfMorphism( phi ) );
    
end );

##
InstallMethod( IsLeft,
        "for homalg morphisms",
        [ IsHomalgMorphism ],
        
  function( phi )
    
    return IsHomalgMorphismOfLeftModules( phi );
    
end );

##
InstallMethod( SourceOfMorphism,
        "for homalg morphisms",
        [ IsHomalgMorphism ],
        
  function( phi )
    
    return phi!.source;
    
end );

##
InstallMethod( TargetOfMorphism,
        "for homalg morphisms",
        [ IsHomalgMorphism ],
        
  function( phi )
    
    return phi!.target;
    
end );

##
InstallMethod( PairOfPositionsOfTheDefaultSetOfRelations,
        "for homalg morphisms",
        [ IsMorphismOfFinitelyGeneratedModulesRep ],
        
  function( phi )
    local pos_s, pos_t;
    
    pos_s := PositionOfTheDefaultSetOfRelations( SourceOfMorphism( phi ) );
    pos_t := PositionOfTheDefaultSetOfRelations( TargetOfMorphism( phi ) );
    
    if IsHomalgMorphismOfLeftModules( phi ) then
        return [ pos_s, pos_t ];
    else
        return [ pos_t, pos_s ];
    fi;
    
end );

##
InstallMethod( MatrixOfMorphism,		## FIXME: make this optimal by finding shortest ways
        "for homalg morphisms",
        [ IsMorphismOfFinitelyGeneratedModulesRep, IsPosInt, IsPosInt ],
        
  function( phi, pos_s, pos_t )
    local index_pair, l, dist, min, pos, matrix;
    
    if IsHomalgMorphismOfLeftModules( phi ) then
        index_pair := [ pos_s, pos_t ];
    else
        index_pair := [ pos_t, pos_s ];
    fi;
    
    l := phi!.index_pairs_of_presentations;
    
    if not index_pair in l then
        
        dist := List( l, a -> AbsInt( index_pair[1] - a[1] ) + AbsInt( index_pair[2] - a[2] ) );
        
        min := Minimum( dist );
        
        pos := PositionProperty( dist, a -> a = min );
        
        if IsHomalgMorphismOfLeftModules( phi ) then
            matrix :=
              TransitionMatrix( SourceOfMorphism( phi ), pos_s, l[pos][1] )
              * phi!.matrices.( String( l[pos] ) )
              * TransitionMatrix( TargetOfMorphism( phi ), l[pos][2], pos_t );
        else
            matrix :=
              TransitionMatrix( TargetOfMorphism( phi ), pos_t, l[pos][1] )
              * phi!.matrices.( String( l[pos] ) )
              * TransitionMatrix( SourceOfMorphism( phi ), l[pos][2], pos_s );
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
InstallMethod( MatrixOfMorphism,
        "for homalg morphisms",
        [ IsMorphismOfFinitelyGeneratedModulesRep and IsHomalgEndomorphism, IsPosInt ],
        
  function( phi, pos_s_t )
    
    return MatrixOfMorphism( phi, pos_s_t, pos_s_t );
    
end );

##
InstallMethod( MatrixOfMorphism,
        "for homalg morphisms",
        [ IsMorphismOfFinitelyGeneratedModulesRep ],
        
  function( phi )
    local pos_s, pos_t;
    
    pos_s := PositionOfTheDefaultSetOfRelations( SourceOfMorphism( phi ) );
    pos_t := PositionOfTheDefaultSetOfRelations( TargetOfMorphism( phi ) );
    
    return MatrixOfMorphism( phi, pos_s, pos_t );
    
end );

##
InstallMethod( AreComparableMorphisms,
        "for homalg morphisms",
        [ IsHomalgMorphism, IsHomalgMorphism ],
        
  function( phi1, phi2 )
    
    return IsIdenticalObj( SourceOfMorphism( phi1 ), SourceOfMorphism( phi2 ) )
           and IsIdenticalObj( TargetOfMorphism( phi1 ), TargetOfMorphism( phi2 ) );
    
end );

##
InstallMethod( AreComposableMorphisms,
        "for homalg morphisms",
        [ IsHomalgMorphismOfLeftModules, IsHomalgMorphismOfLeftModules ],
        
  function( phi1, phi2 )
    
    return IsIdenticalObj( TargetOfMorphism( phi1 ), SourceOfMorphism( phi2 ) );
    
end );

##
InstallMethod( AreComposableMorphisms,
        "for homalg morphisms",
        [ IsHomalgMorphismOfRightModules, IsHomalgMorphismOfRightModules ],
        
  function( phi2, phi1 )
    
    return IsIdenticalObj( TargetOfMorphism( phi1 ), SourceOfMorphism( phi2 ) );
    
end );

##
InstallMethod( \=,
        "for homalg comparable morphisms",
        [ IsMorphismOfFinitelyGeneratedModulesRep, IsMorphismOfFinitelyGeneratedModulesRep ],
        
  function( phi1, phi2 )
    
    if not AreComparableMorphisms( phi1, phi2 ) then
        return false;
    fi;
    
    return MatrixOfMorphism( phi1 ) = MatrixOfMorphism( phi2 ); ## FIXME: compare any already evaluated matrices
    
end );

##
InstallMethod( ZeroMutable,
        "for homalg morphisms",
        [ IsMorphismOfFinitelyGeneratedModulesRep ],
        
  function( phi )
    
    return HomalgMorphism( 0 * MatrixOfMorphism( phi ), SourceOfMorphism( phi ), TargetOfMorphism( phi ) );
    
end );

##
InstallMethod( \*,
        "of two homalg morphisms",
        [ IsRingElement, IsMorphismOfFinitelyGeneratedModulesRep ], 1001, ## it could otherwise run into the method ``PROD: negative integer * additive element with inverse'', value: 24
        
  function( a, phi )
    
    return HomalgMorphism( a * MatrixOfMorphism( phi ), SourceOfMorphism( phi ), TargetOfMorphism( phi ) );
    
end );

##
InstallMethod( \+,
        "of two homalg morphisms",
        [ IsMorphismOfFinitelyGeneratedModulesRep, IsMorphismOfFinitelyGeneratedModulesRep ],
        
  function( phi1, phi2 )
    
    if not AreComparableMorphisms( phi1, phi2 ) then
        return false;
    fi;
    
    return HomalgMorphism( MatrixOfMorphism( phi1 ) + MatrixOfMorphism( phi2 ), SourceOfMorphism( phi1 ), TargetOfMorphism( phi1 ) );
    
end );

## a synonym of `-<elm>':
InstallMethod( AdditiveInverseMutable,
        "of homalg morphisms",
        [ IsMorphismOfFinitelyGeneratedModulesRep ],
        
  function( phi )
    
    return MinusOne( HomalgRing( phi ) ) * phi;
    
end );

## a synonym of `-<elm>':
InstallMethod( AdditiveInverseMutable,
        "of homalg morphisms",
        [ IsHomalgMorphism and IsZero ],
        
  function( phi )
    
    return phi;
    
end );

##
InstallMethod( \-,
        "of two homalg morphisms",
        [ IsMorphismOfFinitelyGeneratedModulesRep, IsMorphismOfFinitelyGeneratedModulesRep ],
        
  function( phi1, phi2 )
    
    if not AreComparableMorphisms( phi1, phi2 ) then
        return false;
    fi;
    
    return HomalgMorphism( MatrixOfMorphism( phi1 ) - MatrixOfMorphism( phi2 ), SourceOfMorphism( phi1 ), TargetOfMorphism( phi1 ) );
    
end );

##
InstallMethod( \*,
        "of two homalg morphisms",
        [ IsMorphismOfFinitelyGeneratedModulesRep and IsHomalgMorphismOfLeftModules,
          IsMorphismOfFinitelyGeneratedModulesRep and IsHomalgMorphismOfLeftModules ],
        
  function( phi1, phi2 )
    
    if not AreComposableMorphisms( phi1, phi2 ) then
        Error( "the two morphisms are not composable, since the target of the left one and the source of right one are not \033[01midentical\033[0m\n" );
    fi;
    
    return HomalgMorphism( MatrixOfMorphism( phi1 ) * MatrixOfMorphism( phi2 ), SourceOfMorphism( phi1 ), TargetOfMorphism( phi2 ) );
    
end );

##
InstallMethod( \*,
        "of two homalg morphisms",
        [ IsMorphismOfFinitelyGeneratedModulesRep and IsHomalgMorphismOfRightModules,
          IsMorphismOfFinitelyGeneratedModulesRep and IsHomalgMorphismOfRightModules ],
        
  function( phi2, phi1 )
    
    if not AreComposableMorphisms( phi2, phi1 ) then
        Error( "the two morphisms are not composable, since the target of the right one and the target of the left one are not \033[01midentical\033[0m\n" );
    fi;
    
    return HomalgMorphism( MatrixOfMorphism( phi2 ) * MatrixOfMorphism( phi1 ), SourceOfMorphism( phi1 ), TargetOfMorphism( phi2 ) );
    
end );

##
InstallMethod( POW,
        "for homalg morphisms",
        [ IsMorphismOfFinitelyGeneratedModulesRep, IsInt ],
        
  function( phi, pow )
    local id, inv;
    
    if pow = -1 then
        
        id := HomalgIdentityMorphism( TargetOfMorphism( phi ) );
        
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
        "for homalg morphisms",
        [ IsMorphismOfFinitelyGeneratedModulesRep ],
        
  function( phi )
    
    OnLessGenerators( SourceOfMorphism( phi ) );
    OnLessGenerators( TargetOfMorphism( phi ) );
    
    return phi;
    
end );

##
InstallMethod( BasisOfModule,
        "for homalg morphisms",
        [ IsMorphismOfFinitelyGeneratedModulesRep ],
        
  function( phi )
    
    OnLessGenerators( SourceOfMorphism( phi ) );
    OnLessGenerators( TargetOfMorphism( phi ) );
    
    return phi;
    
end );

##
InstallMethod( DecideZero,
        "for homalg morphisms",
        [ IsMorphismOfFinitelyGeneratedModulesRep, IsHomalgRelationsOfFinitelyPresentedModuleRep ],
        
  function( phi, rel )
    
    return DecideZero( MatrixOfMorphism( phi ) , rel );
    
end );

##
InstallMethod( DecideZero,
        "for homalg morphisms",
        [ IsMorphismOfFinitelyGeneratedModulesRep ],
        
  function( phi )
    local pos_t, rel, index_pair, matrix, reduced;
    
    pos_t := PositionOfTheDefaultSetOfRelations( TargetOfMorphism( phi ) );
    
    rel := RelationsOfModule( TargetOfMorphism( phi ), pos_t );
    
    index_pair := PairOfPositionsOfTheDefaultSetOfRelations( phi );
    
    matrix := MatrixOfMorphism( phi );
    
    reduced := DecideZero( matrix, rel );
    
    if reduced = matrix then
        reduced := matrix;
    fi;
    
    phi!.reduced_matrices.( String( index_pair ) ) := reduced;
    
    return reduced;
    
end );

##
InstallMethod( UnionOfRelations,
        "for homalg morphisms",
        [ IsMorphismOfFinitelyGeneratedModulesRep ],
        
  function( phi )
    
    return UnionOfRelations( MatrixOfMorphism( phi ), TargetOfMorphism( phi ) );
    
end );

##
InstallMethod( SyzygiesGenerators,
        "for homalg morphisms",
        [ IsMorphismOfFinitelyGeneratedModulesRep ],
        
  function( phi )
    
    return SyzygiesGenerators( MatrixOfMorphism( phi ), TargetOfMorphism( phi ) );
    
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
InstallMethod( PostDivide,			## defines: PostDivide (RightDivide (high-level))
        "for homalg morphisms",
        [ IsMorphismOfFinitelyGeneratedModulesRep and IsHomalgMorphismOfLeftModules,
          IsMorphismOfFinitelyGeneratedModulesRep and IsHomalgMorphismOfLeftModules ],
        
  function( gamma, beta )
    local N, psi;
    
    N := TargetOfMorphism( beta );
    
    if not IsIdenticalObj( N, TargetOfMorphism( gamma ) ) then
        Error( "the two morphisms don't have have identically the same target module\n" );
    fi;
    
    N := RelationsOfModule( N );
    
    psi := RightDivide( MatrixOfMorphism( gamma ), MatrixOfMorphism( beta ), N );
    
    if psi = fail then
        Error( "the second argument of RightDivide is not a right factor of the first modulo the third, i.e. the rows of the second and third argument are not a generating set!\n" );
    fi;
    
    return HomalgMorphism( psi, SourceOfMorphism( gamma ), SourceOfMorphism( beta ) );
    
end );

##
InstallMethod( PostDivide,			## defines: PostDivide (LeftDivide (high-level))
        "for homalg morphisms",
        [ IsMorphismOfFinitelyGeneratedModulesRep and IsHomalgMorphismOfRightModules,
          IsMorphismOfFinitelyGeneratedModulesRep and IsHomalgMorphismOfRightModules ],
        
  function( gamma, beta )
    local N, psi;
    
    N := TargetOfMorphism( beta );
    
    if not IsIdenticalObj( N, TargetOfMorphism( gamma ) ) then
        Error( "the two morphisms don't have have identically the same target module\n" );
    fi;
    
    N := RelationsOfModule( N );
    
    psi := LeftDivide( MatrixOfMorphism( beta ), MatrixOfMorphism( gamma ), N );
    
    if psi = fail then
        Error( "the first argument of LeftDivide is not a left factor of the second modulo the third, i.e. the columns of the first and third arguments are not a generating set!\n" );
    fi;
    
    return HomalgMorphism( psi, SourceOfMorphism( gamma ), SourceOfMorphism( beta ) );
    
end );

#=======================================================================
# Complete an image-square
#
#  A_ is a free or beta1 is injective
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
InstallMethod( CompleteImSq,
        "for homalg morphisms",
        [ IsMorphismOfFinitelyGeneratedModulesRep and IsHomalgMorphismOfLeftModules,
          IsMorphismOfFinitelyGeneratedModulesRep and IsHomalgMorphismOfLeftModules,
          IsMorphismOfFinitelyGeneratedModulesRep and IsHomalgMorphismOfLeftModules ],
        
  function( alpha1, phi, beta1 )
    
    return PostDivide( alpha1 * phi, beta1 );
    
end );

##
InstallMethod( CompleteImSq,
        "for homalg morphisms",
        [ IsMorphismOfFinitelyGeneratedModulesRep and IsHomalgMorphismOfRightModules,
          IsMorphismOfFinitelyGeneratedModulesRep and IsHomalgMorphismOfRightModules,
          IsMorphismOfFinitelyGeneratedModulesRep and IsHomalgMorphismOfRightModules ],
        
  function( alpha1, phi, beta1 )
    
    return PostDivide( phi * alpha1, beta1 );
    
end );

####################################
#
# constructor functions and methods:
#
####################################

InstallGlobalFunction( HomalgMorphism,
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
            if IsHomalgMatrix( arg[1] ) then
                nr_rows := NrRows( arg[1] );
                nr_columns := NrColumns( arg[1] );
            elif IsHomalgRelations( arg[1] ) then
                nr_rows := NrRows( MatrixOfRelations( arg[1] ) );
                nr_columns := NrColumns( MatrixOfRelations( arg[1] ) );
            fi;
            if IsLeftModule( arg[3] ) then
                source := HomalgFreeLeftModule( nr_rows, HomalgRing( arg[1] ) );
            else
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
            if IsHomalgRelationsOfLeftModule( arg[1] ) then
                left := true;
            else
                left := false;
            fi;
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
            type := TheTypeHomalgMorphismOfLeftModules;
        else
            source := HomalgFreeRightModule( NrColumns( matrix ), R );
            target := HomalgFreeRightModule( NrRows( matrix ), R );
            type := TheTypeHomalgMorphismOfRightModules;
        fi;
        
        matrices := rec( );
        
        reduced_matrices := rec( );
        
        morphism := rec( 
                         source := source,
                         target := target,
                         matrices := matrices,
                         reduced_matrices := reduced_matrices,
                         index_pairs_of_presentations := [ [ 1, 1 ] ]);
    
        matrices.( String( [ 1, 1 ] ) ) := matrix;
        
        ## Objectify:
        ObjectifyWithAttributes(
                morphism, type );
        
        return morphism;
        
    fi;
    
    if nargs > 2 then
        if IsHomalgModule( arg[3] ) then
            target := arg[3];
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
        elif IsLeftModule( source ) and IsLeftModule( target ) then
            type := TheTypeHomalgMorphismOfLeftModules;
        elif IsRightModule( source ) and IsRightModule( target ) then
            type := TheTypeHomalgMorphismOfRightModules;
        else
            Error( "the source and target modules of a morphism must either both be left or both be right modules\n" );
        fi;
    else
        target := source;
        if IsLeftModule( source ) then
            type := TheTypeHomalgEndomorphismOfLeftModules;
        else
            type := TheTypeHomalgEndomorphismOfRightModules;
        fi;
    fi;
    
    if IsLeftModule( source ) then
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
                     source := source,
                     target := target,
                     matrices := matrices,
                     reduced_matrices := reduced_matrices,
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
                    IsZero, true );
            
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
                            IsIdentityMorphism, true );
                else
                    ## Objectify:
                    ObjectifyWithAttributes(
                            morphism, type,
                            IsAutomorphism, true );
                fi;
            else
                ## Objectify:
                ObjectifyWithAttributes(
                        morphism, type,
                        IsIsomorphism, true );
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
        
        if IsLeftModule( source )
           and ( NrGenerators( source, pos_s ) <> NrRows( matrix )
                 or NrGenerators( target, pos_t ) <> NrColumns( matrix ) ) then
            Error( "the dimensions of the matrix do not match numbers of generators of the modules\n" );
        elif IsRightModule( source )
           and ( NrGenerators( source, pos_s ) <> NrColumns( matrix )
                 or NrGenerators( target, pos_t ) <> NrRows( matrix ) ) then
            Error( "the dimensions of the matrix do not match numbers of generators of the modules\n" );
        fi;
        
        matrices.( String( index_pair ) ) := matrix;
    
        ## Objectify:
        ObjectifyWithAttributes(
                morphism, type );
        
    fi;
    
    return morphism;
    
end );
  
##
InstallGlobalFunction( HomalgZeroMorphism,
  function( arg )
    
    return CallFuncList( HomalgMorphism, Concatenation( [ [ "zero" ] ], arg ) );
    
end );

##
InstallGlobalFunction( HomalgIdentityMorphism,
  function( arg )
    
    return CallFuncList( HomalgMorphism, Concatenation( [ [ "identity" ] ], arg ) );
    
end );

####################################
#
# View, Print, and Display methods:
#
####################################

InstallMethod( ViewObj,
        "for homalg morphisms",
        [ IsHomalgMorphism ],
        
  function( o )
    
    Print( "<A" );
    
    if HasIsZero( o ) then ## if this method applies and HasIsZero is set we already know that o is a non-zero morphism of homalg modules
        Print( " non-zero" );
    fi;
    
    if HasIsMorphism( o ) then
        if IsMorphism( o ) then
            Print( " morphism of" );
        else
            Print( " non-well-defined map between" );
        fi;
    else
        Print( " \"morphism\" of" );
    fi;
    
    if IsHomalgMorphismOfLeftModules( o ) then
        Print( " left" );
    else
        Print( " right" );
    fi;
    
    Print( " modules>" );
    
end );

##
InstallMethod( ViewObj,
        "for homalg morphisms",
        [ IsHomalgMorphism and IsMonomorphism ],
        
  function( o )
    
    Print( "<A monomorphism of" );
    
    if IsHomalgMorphismOfLeftModules( o ) then
        Print( " left" );
    else
        Print( " right" );
    fi;
    
    Print( " modules>" );
    
end );    

##
InstallMethod( ViewObj,
        "for homalg morphisms",
        [ IsHomalgMorphism and IsEpimorphism ],
        
  function( o )
    
    Print( "<An epimorphism of" );
    
    if IsHomalgMorphismOfLeftModules( o ) then
        Print( " left" );
    else
        Print( " right" );
    fi;
    
    Print( " modules>" );
    
end );    

##
InstallMethod( ViewObj,
        "for homalg morphisms",
        [ IsHomalgMorphism and IsSplitMonomorphism ],
        
  function( o )
    
    Print( "<A split monomorphism of" );
    
    if IsHomalgMorphismOfLeftModules( o ) then
        Print( " left" );
    else
        Print( " right" );
    fi;
    
    Print( " modules>" );
    
end );    

##
InstallMethod( ViewObj,
        "for homalg morphisms",
        [ IsHomalgMorphism and IsSplitEpimorphism ],
        
  function( o )
    
    Print( "<A split epimorphism of" );
    
    if IsHomalgMorphismOfLeftModules( o ) then
        Print( " left" );
    else
        Print( " right" );
    fi;
    
    Print( " modules>" );
    
end );    

##
InstallMethod( ViewObj,
        "for homalg morphisms",
        [ IsHomalgMorphism and IsIsomorphism ],
        
  function( o )
    
    Print( "<An isomorphism of" );
    
    if IsHomalgMorphismOfLeftModules( o ) then
        Print( " left" );
    else
        Print( " right" );
    fi;
    
    Print( " modules>" );
    
end );    

##
InstallMethod( ViewObj,
        "for homalg morphisms",
        [ IsHomalgMorphism and IsZero ],
        
  function( o )
    
    Print( "<The zero morphism of" );
    
    if IsHomalgMorphismOfLeftModules( o ) then
        Print( " left" );
    else
        Print( " right" );
    fi;
    
    Print( " modules>" );
    
end );    

InstallMethod( ViewObj,
        "for homalg morphisms",
        [ IsHomalgEndomorphism ],
        
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
        Print( " \"morphism\" of" );
    fi;
    
    if IsHomalgMorphismOfLeftModules( o ) then
        Print( " a left" );
    else
        Print( " a right" );
    fi;
    
    Print( " module>" );
    
end );

##
InstallMethod( ViewObj,
        "for homalg morphisms",
        [ IsHomalgEndomorphism and IsMonomorphism ],
        
  function( o )
    
    Print( "<A monic endomorphism of" );
    
    if IsHomalgMorphismOfLeftModules( o ) then
        Print( " a left" );
    else
        Print( " a right" );
    fi;
    
    Print( " module>" );
    
end );    

##
InstallMethod( ViewObj,
        "for homalg morphisms",
        [ IsHomalgEndomorphism and IsEpimorphism ],
        
  function( o )
    
    Print( "<An epic endomorphism of" );
    
    if IsHomalgMorphismOfLeftModules( o ) then
        Print( " a left" );
    else
        Print( " a right" );
    fi;
    
    Print( " module>" );
    
end );    

##
InstallMethod( ViewObj,
        "for homalg morphisms",
        [ IsHomalgEndomorphism and IsSplitMonomorphism ],
        
  function( o )
    
    Print( "<A split monic endomorphism of" );
    
    if IsHomalgMorphismOfLeftModules( o ) then
        Print( " a left" );
    else
        Print( " a right" );
    fi;
    
    Print( " module>" );
    
end );    

##
InstallMethod( ViewObj,
        "for homalg morphisms",
        [ IsHomalgEndomorphism and IsSplitEpimorphism ],
        
  function( o )
    
    Print( "<A split epic endomorphism of" );
    
    if IsHomalgMorphismOfLeftModules( o ) then
        Print( " a left" );
    else
        Print( " a right" );
    fi;
    
    Print( " module>" );
    
end );    

##
InstallMethod( ViewObj,
        "for homalg morphisms",
        [ IsHomalgEndomorphism and IsAutomorphism ],
        
  function( o )
    
    Print( "<An automorphism of" );
    
    if IsHomalgMorphismOfLeftModules( o ) then
        Print( " a left" );
    else
        Print( " a right" );
    fi;
    
    Print( " module>" );
    
end );    

##
InstallMethod( ViewObj,
        "for homalg morphisms",
        [ IsHomalgEndomorphism and IsIdentityMorphism ],
        
  function( o )
    
    Print( "<The identity morphism of" );
    
    if IsHomalgMorphismOfLeftModules( o ) then
        Print( " a left" );
    else
        Print( " a right" );
    fi;
    
    Print( " module>" );
    
end );    

##
InstallMethod( ViewObj,
        "for homalg morphisms",
        [ IsHomalgEndomorphism and IsZero ],
        
  function( o )
    
    Print( "<The zero endomorphism of" );
    
    if IsHomalgMorphismOfLeftModules( o ) then
        Print( " a left" );
    else
        Print( " a right" );
    fi;
    
    Print( " module>" );
    
end );    

InstallMethod( Display,
        "for homalg morphisms",
        [ IsMorphismOfFinitelyGeneratedModulesRep ],
        
  function( o )
    
    Display( MatrixOfMorphism( o ) );
    
end );

