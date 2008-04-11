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
InstallImmediateMethod( IsZeroMorphism,
        IsHomalgMorphism, 0,
        
  function( phi )
    
    if IsZeroModule( SourceOfMorphism( phi ) ) or IsZeroModule( TargetOfMorphism( phi ) ) then
        return true;
    fi;
    
    TryNextMethod( );
    
end );

##
InstallImmediateMethod( IsZeroMorphism,
        IsMorphismOfFinitelyGeneratedModulesRep, 0,
        
  function( phi )
    
    if HasIsZeroMatrix( MatrixOfMorphism( phi ) ) and IsZeroMatrix( MatrixOfMorphism( phi ) ) then
        return true;
    fi;
    
    TryNextMethod( );
    
end );

## FIXME: when do immediate methods apply? immediately after objectifying?
InstallImmediateMethod( IsZeroMorphism,
        IsMorphismOfFinitelyGeneratedModulesRep, 0,
        
  function( phi )
    local index_pair, matrix;
    
    index_pair := PairOfPositionsOfTheDefaultSetOfRelations( phi );
    
    if IsBound( phi!.reduced_matrices.( String( index_pair ) ) ) then
        
        matrix := phi!.reduced_matrices.( String( index_pair ) );
        
        if HasIsZeroMatrix( matrix ) then
            return IsZeroMatrix( matrix );
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
InstallMethod( IsZeroMorphism,
        "for homalg morphisms",
        [ IsMorphismOfFinitelyGeneratedModulesRep ],
        
  function( phi )
    
    IsZeroMatrix( DecideZero( phi ) );
    
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
        [ IsMorphismOfFinitelyGeneratedModulesRep ],
        
  function( phi )
    local pos_s, pos_t, index_pair, l, dist, min, pos, matrix;
    
    pos_s := PositionOfTheDefaultSetOfRelations( SourceOfMorphism( phi ) );
    pos_t := PositionOfTheDefaultSetOfRelations( TargetOfMorphism( phi ) );
    
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
              TransitionMatrix( TargetOfMorphism( phi ), pos_t, l[pos][2] )
              * phi!.matrices.( String( l[pos] ) )
              * TransitionMatrix( SourceOfMorphism( phi ), l[pos][1], pos_s );
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
        [ IsHomalgMorphism and IsZeroMorphism ],
        
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
        Error( "the two morphisms are not composable, since the target of the left one is not \033[1midentical\033[0m to the source of right one\n" );
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
        Error( "the two morphisms are not composable, since the target of the right one is not \033[1midentical\033[0m to the target of the left one\n" );
    fi;
    
    return HomalgMorphism( MatrixOfMorphism( phi2 ) * MatrixOfMorphism( phi1 ), SourceOfMorphism( phi1 ), TargetOfMorphism( phi2 ) );
    
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

####################################
#
# constructor functions and methods:
#
####################################

InstallGlobalFunction( HomalgMorphism,
  function( arg )
    local nargs, source, pos_s, target, pos_t, R, type, matrix, matrices, reduced_matrices,
          nr_rows, nr_columns, index_pair, morphism;
    
    nargs := Length( arg );
    
    if Length( arg ) > 1 then
        if IsHomalgModule( arg[2] ) then
            source := arg[2];
            pos_s := source!.PositionOfTheDefaultSetOfRelations;
        elif IsList( arg[2] ) and IsHomalgModule( arg[2][1] ) and IsPosInt( arg[2][2] ) then
            source := arg[2][1];
            pos_s := arg[2][2];
            if not IsBound( source!.SetsOfRelations!.( pos_s ) ) then
                Error( "the source module does not possess a ", arg[2][2], ". set of relations (this positive number is given as the second entry of the list provided as the second argument)\n" );
            fi;
        fi;
    fi;
    
    if not IsBound( source ) then
        
        if IsHomalgMatrix( arg[1] ) then
            matrix := arg[1];
            R := HomalgRing( matrix );
        elif IsHomalgRing( arg[nargs] ) then
            matrix := HomalgMatrix( arg[1], arg[nargs] );
        else
            Error( "The second argument must be the source module or the last argument should be an IsHomalgRing\n" );
        fi;
        
        if nargs > 1 and IsString( arg[2] ) and Length( arg[2] ) > 0 and  LowercaseString( arg[2]{[1..1]} ) = "r" then
            source := HomalgFreeRightModule( NrColumns( matrix ), R );
            target := HomalgFreeRightModule( NrRows( matrix ), R );
            type := TheTypeHomalgMorphismOfRightModules;
        else
            source := HomalgFreeLeftModule( NrRows( matrix ), R );
            target := HomalgFreeLeftModule( NrColumns( matrix ), R );
            type := TheTypeHomalgMorphismOfLeftModules;
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
    
    if Length( arg ) > 2 then
        if IsHomalgModule( arg[3] ) then
            target := arg[3];
            pos_t := target!.PositionOfTheDefaultSetOfRelations;
        elif IsList( arg[3] ) and IsHomalgModule( arg[3][1] ) and IsPosInt( arg[3][2] ) then
            target := arg[3][1];
            pos_t := arg[3][2];
            if not IsBound( target!.SetsOfRelations!.( pos_t ) ) then
                Error( "the target module does not possess a ", arg[3][2], ". set of relations (this positive number is given as the second entry of the list provided as the third argument)\n" );
            fi;
        fi;
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
        nr_rows := NrGenerators( source!.SetsOfRelations!.( pos_s ) );
        nr_columns := NrGenerators( target!.SetsOfRelations!.( pos_t ) );
        index_pair := [ pos_s, pos_t ];
    else
        nr_columns := NrGenerators( source!.SetsOfRelations!.( pos_s ) );
        nr_rows := NrGenerators( target!.SetsOfRelations!.( pos_t ) );
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
    
    if IsString( arg[1] ) and Length( arg[1] ) > 3 and LowercaseString( arg[1]{[1..4]} ) = "zero" then
    ## the zero morphism:
        
        matrix := HomalgZeroMatrix( nr_rows, nr_columns, R );
        
        matrices.( String( index_pair ) ) := matrix;
        
        reduced_matrices.( String( index_pair ) ) := matrix;
        
        ## Objectify:
        ObjectifyWithAttributes(
                morphism, type,
                IsZeroMorphism, true );
        
    elif IsString( arg[1] ) and Length( arg[1] ) > 1 and  LowercaseString( arg[1]{[1..2]} ) = "id" then
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
        
        if IsHomalgMatrix( arg[1] ) then
            matrix := arg[1];
        elif IsList( arg[1] ) then
            matrix := HomalgMatrix( arg[1], R );
        else
            Error( "the first argument must be in { IsHomalgMatrix, IsMatrix, IsList } but received: ",  arg[1], "\n" );
        fi;
        
        matrices.( String( index_pair ) ) := matrix;
    
        ## Objectify:
        ObjectifyWithAttributes(
                morphism, type );
        
    fi;
    
    return morphism;
    
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
    
    if HasIsZeroMorphism( o ) then ## if this method applies and HasIsZeroMorphism is set we already know that o is a non-zero morphism of homalg modules
        Print( " non-zero" );
    fi;
    
    Print( " morphism of" );
    
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
    
    Print( "<A epimorphism of" );
    
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
        [ IsHomalgMorphism and IsZeroMorphism ],
        
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
    
    if HasIsZeroMorphism( o ) then ## if this method applies and HasIsZeroMorphism is set we already know that o is a non-zero morphism of homalg modules
        Print( " non-zero" );
    else
        Print( "n" );
    fi;
    
    Print( " endomorphism of" );
    
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
        [ IsHomalgEndomorphism and IsZeroMorphism ],
        
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
    
end);

