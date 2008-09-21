#############################################################################
##
##  Complexes.gi                homalg package               Mohamed Barakat
##
##  Copyright 2007-2008 Lehrstuhl B für Mathematik, RWTH Aachen
##
##  Implementations of homalg procedures for complexes.
##
#############################################################################

####################################
#
# methods for operations:
#
####################################

##
InstallMethod( DefectOfExactness,
        "for a homalg complexes",
        [ IsComplexOfFinitelyPresentedObjectsRep, IsInt ],
        
  function( C, i )
    local degrees, mor, def;
    
    degrees := ObjectDegreesOfComplex( C );
    
    if PositionSet( degrees, i ) = fail then
        Error( "the second argument ", i, " is outside the degree range of the complex\n" );
    elif HasIsGradedObject( C ) and IsGradedObject( C ) then
        return CertainObject( C, i );
    elif i = degrees[1] then
        mor := CertainMorphism( C, i + 1 );
        def := Cokernel( mor );
    elif i = degrees[Length( degrees )] then
        mor := CertainMorphism( C, i );
        def := Kernel( mor );
    else
        mor := CertainTwoMorphismsAsSubcomplex( C, i );
        mor := AsATwoSequence( mor );
        def := DefectOfExactness( mor );
    fi;
    
    return def;
    
end );

##
InstallMethod( DefectOfExactness,
        "for a homalg complexes",
        [ IsCocomplexOfFinitelyPresentedObjectsRep, IsInt ],
        
  function( C, i )
    local degrees, mor, def;
    
    degrees := ObjectDegreesOfComplex( C );
    
    if PositionSet( degrees, i ) = fail then
        Error( "the second argument ", i, " is outside the degree range of the complex\n" );
    elif HasIsGradedObject( C ) and IsGradedObject( C ) then
        return CertainObject( C, i );
    elif i = degrees[1] then
        mor := CertainMorphism( C, i );
        def := Kernel( mor );
    elif i = degrees[Length( degrees )] then
        mor := CertainMorphism( C, i - 1 );
        def := Cokernel( mor );
    else
        mor := CertainTwoMorphismsAsSubcomplex( C, i );
        mor := AsATwoSequence( mor );
        def := DefectOfExactness( mor );
    fi;
    
    return def;
    
end );

##
InstallMethod( Homology,
        "for a homalg complexes",
        [ IsHomalgComplex, IsInt ],
        
  function( C, i )
    
    if IsCocomplexOfFinitelyPresentedObjectsRep( C ) then
        Error( "this is a cocomplex: use \033[1mCohomology\033[0m instead\n" );
    fi;
    
    return DefectOfExactness( C, i );
    
end );

##
InstallMethod( Cohomology,
        "for a homalg complexes",
        [ IsHomalgComplex, IsInt ],
        
  function( C, i )
    
    if IsComplexOfFinitelyPresentedObjectsRep( C ) then
        Error( "this is a complex: use \033[1mHomology\033[0m instead\n" );
    fi;
    
    return DefectOfExactness( C, i );
    
end );

##
InstallMethod( DefectOfExactness,
        "for a homalg complexes",
        [ IsComplexOfFinitelyPresentedObjectsRep ],
        
  function( C )
    local display, display_string, on_less_generators, left, degrees, l,
          morphisms, T, H, i, S;
    
    if HasIsATwoSequence( C ) and IsATwoSequence( C ) then
        TryNextMethod( );
    fi;
    
    if IsBound( C!.DisplayHomology ) and C!.DisplayHomology = true then
        display := true;
    else
        display := false;
    fi;
    
    if IsBound( C!.StringBeforeDisplay ) and IsStringRep( C!.StringBeforeDisplay ) then
        display_string := C!.StringBeforeDisplay;
    else
        display_string := "";
    fi;
    
    if IsBound( C!.HomologyOnLessGenerators ) and C!.HomologyOnLessGenerators = true then
        on_less_generators := true;
    else
        on_less_generators := false;
    fi;
        
    if IsGradedObject( C ) then
        H := C;
    elif IsBound(C!.HomologyGradedObject) then
        H := C!.HomologyGradedObject;
    fi;
    
    if IsBound( H ) then
        if on_less_generators then
            OnLessGenerators( H );
        fi;
        
        if display then
            for i in ObjectsOfComplex( H ) do
                Print( display_string );
                Display( i );
            od;
        fi;
        
        return H;
    fi;
    
    if not IsComplex( C ) then
        Error( "the input is not a complex" );
    fi;
    
    left := IsHomalgLeftObjectOrMorphismOfLeftObjects( C );
    
    degrees := MorphismDegreesOfComplex( C );
    
    l := Length(degrees);
    
    morphisms := MorphismsOfComplex( C );
    
    if not IsBound( C!.SkipLowestDegreeHomology ) then
        T := Cokernel( morphisms[1] );
        H := HomalgComplex( T, degrees[1] - 1 );
    else
        if left then
            T := DefectOfExactness( morphisms[2], morphisms[1] );
        else
            T := DefectOfExactness( morphisms[1], morphisms[2] );
        fi;
        H := HomalgComplex( T, degrees[1] );
        morphisms := morphisms{[ 2 .. l ]};
        l := l - 1;
    fi;
    
    if on_less_generators then
        OnLessGenerators( T );
    fi;
    
    if display then
        Print( display_string );
        Display( T );
    fi;
    
    for i in [ 1 .. l - 1 ] do
        if left then
            S := DefectOfExactness( morphisms[i + 1], morphisms[i] );
        else
            S := DefectOfExactness( morphisms[i], morphisms[i + 1] );
        fi;
        Add( H, TheZeroMap( S, T ) );
        T := S;
        
        if on_less_generators then
            OnLessGenerators( T );
        fi;
        
        if display then
            Print( display_string );
            Display( T );
        fi;
    od;
    
    if not ( IsBound( C!.SkipHighestDegreeHomology ) and C!.SkipHighestDegreeHomology = true ) then
        S := Kernel( morphisms[l] );
        Add( H, TheZeroMap( S, T ) );
        
        if on_less_generators then
            OnLessGenerators( S );
        fi;
        
        if display then
            Print( display_string );
            Display( S );
        fi;
    fi;
    
    SetIsGradedObject( H, true );
    
    C!.HomologyGradedObject := H;
    
    return H;
    
end );

##
InstallMethod( DefectOfExactness,
        "for a homalg complexes",
        [ IsCocomplexOfFinitelyPresentedObjectsRep ],
        
  function( C )
    local display, display_string, on_less_generators, left, degrees, l,
          morphisms, S, H, i, T;
    
    if IsBound( C!.DisplayCohomology ) and C!.DisplayCohomology = true then
        display := true;
    else
        display := false;
    fi;
    
    if IsBound( C!.CohomologyOnLessGenerators ) and C!.CohomologyOnLessGenerators = true then
        on_less_generators := true;
    else
        on_less_generators := false;
    fi;
        
    if IsBound( C!.StringBeforeDisplay ) and IsStringRep( C!.StringBeforeDisplay ) then
        display_string := C!.StringBeforeDisplay;
    else
        display_string := "";
    fi;
    
    if IsGradedObject( C ) then
        H := C;
    elif IsBound(C!.CohomologyGradedObject) then
        H := C!.CohomologyGradedObject;
    fi;
    
    if IsBound( H ) then
        if on_less_generators then
            OnLessGenerators( H );
        fi;
        
        if display then
            for i in ObjectsOfComplex( H ) do
                Print( display_string );
                Display( i );
            od;
        fi;
        
        return H;
    fi;
    
    if not IsComplex( C ) then
        Error( "the input is not a cocomplex" );
    fi;
    
    left := IsHomalgLeftObjectOrMorphismOfLeftObjects( C );
    
    degrees := MorphismDegreesOfComplex( C );
    
    l := Length(degrees);
    
    morphisms := MorphismsOfComplex( C );
    
    if not IsBound( C!.SkipLowestDegreeCohomology ) then
        S := Kernel( morphisms[1] );
        H := HomalgCocomplex( S, degrees[1] );
    else
        if left then
            S := DefectOfExactness( morphisms[1], morphisms[2] );
        else
            S := DefectOfExactness( morphisms[2], morphisms[1] );
        fi;
        H := HomalgCocomplex( S, degrees[1] + 1 );
        morphisms := morphisms{[ 2 .. l ]};
        l := l - 1;
    fi;
    
    if on_less_generators then
        OnLessGenerators( S );
    fi;
    
    if display then
        Print( display_string );
        Display( S );
    fi;
    
    for i in [ 1 .. l - 1 ] do
        if left then
            T := DefectOfExactness( morphisms[i], morphisms[i + 1] );
        else
            T := DefectOfExactness( morphisms[i + 1], morphisms[i] );
        fi;
        Add( H, TheZeroMap( S, T ) );
        S := T;
        
        if on_less_generators then
            OnLessGenerators( S );
        fi;
        
        if display then
            Print( display_string );
            Display( S );
        fi;
    od;
    
    if not ( IsBound( C!.SkipHighestDegreeCohomology ) and C!.SkipHighestDegreeCohomology = true ) then
        T := Cokernel( morphisms[l] );
        Add( H, TheZeroMap( S, T ) );
        
        if on_less_generators then
            OnLessGenerators( T );
        fi;
        
        if display then
            Print( display_string );
            Display( T );
        fi;
    fi;
    
    SetIsGradedObject( H, true );
    
    C!.CohomologyGradedObject := H;
    
    return H;
    
end );

##
InstallMethod( Homology,			### defines: Homology (HomologyModules)
        "for a homalg complexes",
        [ IsHomalgComplex ],
        
  function( C )
    
    if IsCocomplexOfFinitelyPresentedObjectsRep( C ) then
        Error( "this is a cocomplex: use \033[1mCohomology\033[0m instead\n" );
    fi;
    
    return DefectOfExactness( C );
    
end );

##
InstallMethod( Cohomology,			### defines: Cohomology (CohomologyModules)
        "for a homalg complexes",
        [ IsHomalgComplex ],
        
  function( C )
    
    if IsComplexOfFinitelyPresentedObjectsRep( C ) then
        Error( "this is a complex: use \033[1mHomology\033[0m instead\n" );
    fi;
    
    return DefectOfExactness( C );
    
end );

## 0 <-- M <-(psi)- E <-(phi)- N <-- 0
InstallMethod( Resolution,	### defines: Resolution (generalizes ResolveShortExactSeq)
        "for homalg complexes",
        [ IsInt, IsComplexOfFinitelyPresentedObjectsRep and IsShortExactSequence ],
        
  function( _q, C )
    local q, degrees, psi, phi, M, E, N, dM, dN, j,
          index_pair_psi, index_pair_phi, epsilonN, epsilonM, epsilon,
          dj, Pj, dE, d_psi, d_phi, horse_shoe, mu, epsilon_j;
    
    q := _q;
    
    degrees := ObjectDegreesOfComplex( C );
    
    psi := CertainMorphism( C, degrees[2] );
    phi := CertainMorphism( C, degrees[3] );
    
    M := Range( psi );
    E := Source( psi );
    N := Source( phi );
    
    dM := Resolution( q, M );
    dN := Resolution( q, N );
    
    if q < 0 then
        q := Maximum( List( [ M, N ], LengthOfResolution ) );
        dM := Resolution( q, M );
        dN := Resolution( q, N );
    fi;
    
    index_pair_psi := PairOfPositionsOfTheDefaultSetOfRelations( psi );
    index_pair_phi := PairOfPositionsOfTheDefaultSetOfRelations( phi );
    
    if IsBound( C!.free_resolutions ) and
       IsBound( C!.free_resolutions.(String( [ index_pair_psi, index_pair_phi ] )) ) then
        
        horse_shoe := C!.free_resolutions.(String( [ index_pair_psi, index_pair_phi ] ));
        
        d_psi := CertainMorphism( horse_shoe, degrees[2] );
        d_phi := CertainMorphism( horse_shoe, degrees[3] );
        
        j := HighestDegree( d_psi );
        
        if j <> HighestDegree( d_phi ) then
            Error( "the highest degrees of the two chain maps in the horse shoe do not coincide\n" );
        fi;
        
        psi := CertainMorphism( d_psi, j );
        phi := CertainMorphism( d_phi, j );
        
        dE := Source( d_psi );
        
        dj := CertainMorphism( dE, j );
        
    else
        
        j := 0;
        
        epsilonM := FreeHullEpi( M );
        epsilonN := FreeHullEpi( N );
        
        epsilonM := epsilonM / psi;
        epsilonN := PreCompose( epsilonN, phi );
        
        epsilon := StackMaps( epsilonN, epsilonM );
        
        ## check assertion
        Assert( 2, IsEpimorphism( epsilon ) );
        
        SetIsEpimorphism( epsilon, true );
        
        dj := epsilon;
        
        Pj := Source( dj );
        
        dE := HomalgComplex( Pj );
        
        psi := EpiOnRightFactor( Pj );
        phi := MonoOfLeftSummand( Pj );
        
        d_psi := HomalgChainMap( psi, dE, dM );
        d_phi := HomalgChainMap( phi, dN, dE );
        
        horse_shoe := HomalgComplex( d_psi, degrees[2] );
        Add( horse_shoe, d_phi );
        
        C!.free_resolutions := rec( );
        C!.free_resolutions.(String( [ index_pair_psi, index_pair_phi ] )) := horse_shoe;
        
    fi;
    
    while j < q do
        
        j := j + 1;
        
        mu := KernelEmb( dj );
        
        psi := CompleteImageSquare( mu, psi, SyzygiesModuleEmb( j, M ) );
        phi := CompleteImageSquare( SyzygiesModuleEmb( j, N ), phi, mu );
        
        epsilonM := SyzygiesModuleEpi( j, M );
        epsilonN := SyzygiesModuleEpi( j, N );
        
        epsilonM := epsilonM / psi;
        epsilonN := PreCompose( epsilonN, phi );
        
        epsilon_j := StackMaps( epsilonN, epsilonM );
        
        Pj := Source( epsilon_j );
        
        dj := PreCompose( epsilon_j, mu );
        
        if j = 1 then
            SetCokernelEpi( dj, epsilon );
        fi;
        
        Add( dE, dj );
        
        psi := EpiOnRightFactor( Pj );
        phi := MonoOfLeftSummand( Pj );
        
        Add( d_psi, psi );
        Add( d_phi, phi );
        
    od;
    
    ## check assertions
    Assert( 2, IsMorphism( d_psi ) );
    Assert( 2, IsMorphism( d_phi ) );
    
    SetIsEpimorphism( d_psi, true );
    SetIsMonomorphism( d_phi, true );
    SetIsAcyclic( dE, true );
    SetIsShortExactSequence( horse_shoe, true );
    
    return horse_shoe;
    
end );

## 0 --> N -(phi)-> E -(psi)-> M --> 0
InstallMethod( Resolution,	### defines: Resolution (generalizes ResolveShortExactSeq)
        "for homalg complexes",
        [ IsInt, IsCocomplexOfFinitelyPresentedObjectsRep and IsShortExactSequence ],
        
  function( _q, C )
    local q, degrees, phi, psi, N, E, M, dM, dN, j,
          index_pair_psi, index_pair_phi, epsilonN, epsilonM, epsilon,
          dj, Pj, dE, d_phi, d_psi, horse_shoe, mu, epsilon_j;
    
    q := _q;
    
    degrees := ObjectDegreesOfComplex( C );
    
    phi := CertainMorphism( C, degrees[1] );
    psi := CertainMorphism( C, degrees[2] );
    
    N := Source( phi );
    E := Range( phi );
    M := Range( psi );
    
    dM := Resolution( q, M );
    dN := Resolution( q, N );
    
    if q < 0 then
        q := Maximum( List( [ M, N ], LengthOfResolution ) );
        dM := Resolution( q, M );
        dN := Resolution( q, N );
    fi;
    
    index_pair_psi := PairOfPositionsOfTheDefaultSetOfRelations( psi );
    index_pair_phi := PairOfPositionsOfTheDefaultSetOfRelations( phi );
    
    if IsBound( C!.free_resolutions ) and
       IsBound( C!.free_resolutions.(String( [ index_pair_psi, index_pair_phi ] )) ) then
        
        horse_shoe := C!.free_resolutions.(String( [ index_pair_psi, index_pair_phi ] ));
        
        d_phi := CertainMorphism( horse_shoe, degrees[1] );
        d_psi := CertainMorphism( horse_shoe, degrees[2] );
        
        j := HighestDegree( d_psi );
        
        if j <> HighestDegree( d_phi ) then
            Error( "the highest degrees of the two chain maps in the horse shoe do not coincide\n" );
        fi;
        
        psi := CertainMorphism( d_psi, j );
        phi := CertainMorphism( d_phi, j );
        
        dE := Source( d_psi );
        
        dj := CertainMorphism( dE, j );
        
    else
        
        j := 0;
        
        epsilonM := FreeHullEpi( M );
        epsilonN := FreeHullEpi( N );
        
        epsilonM := epsilonM / psi;
        epsilonN := PreCompose( epsilonN, phi );
        
        epsilon := StackMaps( epsilonN, epsilonM );
        
        ## check assertion
        Assert( 2, IsEpimorphism( epsilon ) );
        
        SetIsEpimorphism( epsilon, true );
        
        dj := epsilon;
        
        Pj := Source( dj );
        
        dE := HomalgComplex( Pj );
        
        psi := EpiOnRightFactor( Pj );
        phi := MonoOfLeftSummand( Pj );
        
        d_psi := HomalgChainMap( psi, dE, dM );
        d_phi := HomalgChainMap( phi, dN, dE );
        
        horse_shoe := HomalgCocomplex( d_phi, degrees[1] );
        Add( horse_shoe, d_psi );
        
        C!.free_resolutions := rec( );
        C!.free_resolutions.(String( [ index_pair_psi, index_pair_phi ] )) := horse_shoe;
        
    fi;
    
    while j < q do
        
        j := j + 1;
        
        mu := KernelEmb( dj );
        
        psi := CompleteImageSquare( mu, psi, SyzygiesModuleEmb( j, M ) );
        phi := CompleteImageSquare( SyzygiesModuleEmb( j, N ), phi, mu );
        
        epsilonM := SyzygiesModuleEpi( j, M );
        epsilonN := SyzygiesModuleEpi( j, N );
        
        epsilonM := epsilonM / psi;
        epsilonN := PreCompose( epsilonN, phi );
        
        epsilon_j := StackMaps( epsilonN, epsilonM );
        
        Pj := Source( epsilon_j );
        
        dj := PreCompose( epsilon_j, mu );
        
        if j = 1 then
            SetCokernelEpi( dj, epsilon );
        fi;
        
        Add( dE, dj );
        
        psi := EpiOnRightFactor( Pj );
        phi := MonoOfLeftSummand( Pj );
        
        Add( d_psi, psi );
        Add( d_phi, phi );
        
    od;
    
    ## check assertion
    Assert( 2, IsMorphism( d_psi ) );
    Assert( 2, IsMorphism( d_phi ) );
    
    SetIsEpimorphism( d_psi, true );
    SetIsMonomorphism( d_phi, true );
    SetIsAcyclic( dE, true );
    SetIsShortExactSequence( horse_shoe, true );
    
    return horse_shoe;
    
end );

##
InstallMethod( Resolution,
        "for homalg complexes",
        [ IsHomalgComplex ],
        
  function( C )
    
    return Resolution( -1, C );
    
end );

#=======================================================================
# Connecting homomorphism
#
#                         0
#                         |
#                         |
#                         |
#                         v
#  0 <--- Hs[n-1] <--- Zs[n-1] <--(bs[n])-- Cs[n]/Bs[n] <--- Hs[n] <--- 0
#            |            |                      |             |
#            |         (i[n-1])                (i[n])          |
#            |            |                      |             |
#            v            v                      v             v
#  0 <--- H[n-1]  <--- Z[n-1]  <--(b[n])---  C[n]/B[n]  <--- H[n]  <--- 0
#            |            |                      |             |
#            |         (j[n-1])                (j[n])          |
#            |            |                      |             |
#            v            v                      v             v
#  0 <--- Hq[n-1] <--- Zq[n-1] <--(bq[n])-- Cq[n]/Bq[n] <--- Hq[n] <--- 0
#                                                |
#                                                |
#                                                |
#                                                v
#                                                0
#
#_______________________________________________________________________
InstallMethod( ConnectingHomomorphism,
        "for homalg complexes",
        [ IsFinitelyPresentedModuleRep,
          IsMapOfFinitelyGeneratedModulesRep,
          IsMapOfFinitelyGeneratedModulesRep,
          IsMapOfFinitelyGeneratedModulesRep,
          IsFinitelyPresentedModuleRep ],
        
  function( Hqn, jn, bn, in_1, Hsn_1 )
    local iota_Hqn, iota_Hsn_1, snake;
    
    iota_Hqn := NaturalGeneralizedEmbedding( Hqn );
    iota_Hsn_1 := NaturalGeneralizedEmbedding( Hsn_1 );
    
    snake := iota_Hqn;
    snake := snake / jn;
    snake := PreCompose( snake, bn );	## the connecting homomorphism is what b[n] induces between certain subquotients of C[n] and C[n-1]
    snake := snake / in_1;
    snake := snake / iota_Hsn_1;
    
    ## check assertion
    Assert( 1, IsMorphism( snake ) );
    
    SetIsMorphism( snake, true );
    
    return snake;
    
end );

##
InstallMethod( ConnectingHomomorphism,
        "for short exact sequences of complexes",
        [ IsComplexOfFinitelyPresentedObjectsRep and IsShortExactSequence, IsInt ],
        
  function( E, n )
    local j, i, Cq, C, Cs, Hqn, jn, bn, in_1, Hsn_1;
    
    j := LowestDegreeMorphism( E );
    i := HighestDegreeMorphism( E );
    
    Cq := Range( j );
    C := Source( j );
    Cs := Source( i );
    
    Hqn := DefectOfExactness( Cq, n );
    jn := CertainMorphism( j, n );
    bn := CertainMorphism( C, n );
    in_1 := CertainMorphism( i, n - 1 );
    Hsn_1 := DefectOfExactness( Cs, n - 1 );
    
    return ConnectingHomomorphism( Hqn, jn, bn, in_1, Hsn_1 );
    
end );

##
InstallMethod( ConnectingHomomorphism,
        "for short exact sequences of complexes",
        [ IsCocomplexOfFinitelyPresentedObjectsRep and IsShortExactSequence, IsInt ],
        
  function( E, n )
    local i, j, Cs, C, Cq, Hqn, jn, bn, inp1, Hsnp1;
    
    i := LowestDegreeMorphism( E );
    j := HighestDegreeMorphism( E );
    
    Cs := Source( i );
    C := Range( i );
    Cq := Range( j );
    
    Hqn := DefectOfExactness( Cq, n );
    jn := CertainMorphism( j, n );
    bn := CertainMorphism( C, n );
    inp1 := CertainMorphism( i, n + 1 );
    Hsnp1 := DefectOfExactness( Cs, n + 1 );
    
    return ConnectingHomomorphism( Hqn, jn, bn, inp1, Hsnp1 );
    
end );

##
InstallMethod( ConnectingHomomorphism,
        "for short exact sequences of complexes",
        [ IsComplexOfFinitelyPresentedObjectsRep and IsShortExactSequence ],
        
  function( E )
    local degrees, l, S, T, con, n;
    
    degrees := DegreesOfChainMap( LowestDegreeMorphism( E ) );
    
    l := Length( degrees );
    
    if l < 2 then
        Error( "complex too small\n" );
    fi;
    
    S := DefectOfExactness( LowestDegreeObject( E ) );
    T := DefectOfExactness( HighestDegreeObject( E ) );
    
    n := degrees[2];
    
    con := HomalgChainMap( ConnectingHomomorphism( E, n ), S, T, [ n, -1 ] );
    
    for n in degrees{[ 3 .. l ]} do
        Add( con, ConnectingHomomorphism( E, n ) );
    od;
    
    SetIsGradedMorphism( con, true );
    
    return con;
    
end );

##
InstallMethod( ConnectingHomomorphism,
        "for short exact sequences of complexes",
        [ IsCocomplexOfFinitelyPresentedObjectsRep and IsShortExactSequence ],
        
  function( E )
    local degrees, l, S, T, con, n;
    
    degrees := DegreesOfChainMap( HighestDegreeMorphism( E ) );
    
    l := Length( degrees );
    
    if l < 2 then
        Error( "cocomplex too small\n" );
    fi;
    
    S := DefectOfExactness( HighestDegreeObject( E ) );
    T := DefectOfExactness( LowestDegreeObject( E ) );
    
    n := degrees[1];
    
    con := HomalgChainMap( ConnectingHomomorphism( E, n ), S, T, [ n, 1 ] );
    
    for n in degrees{[ 2 .. l - 1 ]} do
        Add( con, ConnectingHomomorphism( E, n ) );
    od;
    
    SetIsGradedMorphism( con, true );
    
    return con;
    
end );

##
InstallMethod( ExactTriangle,
        "for short exact sequences of complexes",
        [ IsComplexOfFinitelyPresentedObjectsRep and IsShortExactSequence ],
        
  function( E )
    local deg, j, i, con, triangle;
    
    deg := LowestDegree( E ) + 1;
    
    j := DefectOfExactness( LowestDegreeMorphism( E ) );
    i := DefectOfExactness( HighestDegreeMorphism( E ) );
    con := ConnectingHomomorphism( E );
    
    triangle := HomalgComplex( j, deg );
    Add( triangle, i );
    Add( triangle, con );
    
    SetIsExactTriangle( triangle, true );
    
    return triangle;
    
end );

##
InstallMethod( ExactTriangle,
        "for short exact sequences of complexes",
        [ IsCocomplexOfFinitelyPresentedObjectsRep and IsShortExactSequence ],
        
  function( E )
    local deg, j, i, con, triangle;
    
    deg := LowestDegree( E );
    
    i := DefectOfExactness( LowestDegreeMorphism( E ) );
    j := DefectOfExactness( HighestDegreeMorphism( E ) );
    con := ConnectingHomomorphism( E );
    
    triangle := HomalgCocomplex( i, deg );
    Add( triangle, j );
    Add( triangle, con );
    
    SetIsExactTriangle( triangle, true );
    
    return triangle;
    
end );

## [HS. Proof of Lemma. VIII.9.4]
InstallMethod( DefectOfExactnessSequence,
        "for homalg maps",
        [ IsHomalgComplex and IsATwoSequence ],
        
  function( cpx_post_pre )
    local pre, post, F_Z, F_B, Z_B, H, F_H, H_Z, C;
    
    pre := HighestDegreeMorphism( cpx_post_pre );
    post := LowestDegreeMorphism( cpx_post_pre );
    
    ## read: F <- Z
    F_Z := KernelEmb( post );
    
    ## read: F <- B
    F_B := ImageSubmoduleEmb( pre );
    
    ## read: Z <- B
    Z_B := F_B / F_Z;
    
    H := DefectOfExactness( cpx_post_pre );
    
    ## read: F <- H
    F_H := NaturalGeneralizedEmbedding( H );
    
    ## read: H <- Z
    H_Z := F_Z / F_H;
    
    C := HomalgComplex( H_Z );
    
    Add( C, Z_B );
    
    SetIsShortExactSequence( C, true );
    
    ## read: H <- Z <- B, (H := Z/B)
    return C;
    
end );

## for convenience
InstallMethod( DefectOfExactnessSequence,
        "for homalg composable maps",
        [ IsMapOfFinitelyGeneratedModulesRep, IsMapOfFinitelyGeneratedModulesRep ],
        
  function( phi, psi )
    
    return DefectOfExactnessSequence( AsATwoSequence( phi, psi ) );
    
end );

## [HS. Proof of Lemma. VIII.9.4]
InstallMethod( DefectOfExactnessCosequence,
        "for homalg maps",
        [ IsHomalgComplex and IsATwoSequence ],
        
  function( cpx_post_pre )
    local pre, post, Z_F, B_F, B_Z, H, H_F, Z_H, C;
    
    pre := HighestDegreeMorphism( cpx_post_pre );
    post := LowestDegreeMorphism( cpx_post_pre );
    
    ## read: Z -> F
    Z_F := KernelEmb( post );
    
    ## read: B -> F
    B_F := ImageSubmoduleEmb( pre );
    
    ## read: B -> Z
    B_Z := B_F / Z_F;
    
    H := DefectOfExactness( cpx_post_pre );
    
    ## read: H -> F
    H_F := NaturalGeneralizedEmbedding( H );
    
    ## read: Z -> H
    Z_H := Z_F / H_F;
    
    C := HomalgCocomplex( B_Z );
    
    Add( C, Z_H );
    
    SetIsShortExactSequence( C, true );
    
    ## read: B -> Z -> H, (H := Z/B)
    return C;
    
end );

## for convenience
InstallMethod( DefectOfExactnessCosequence,
        "for homalg composable maps",
        [ IsMapOfFinitelyGeneratedModulesRep, IsMapOfFinitelyGeneratedModulesRep ],
        
  function( phi, psi )
    
    return DefectOfExactnessCosequence( AsATwoSequence( phi, psi ) );
    
end );

## the Cartan-Eilenberg resolution [HS. Lemma VIII.9.4]
InstallMethod( Resolution,	### defines: Resolution
        "for homalg complexes",
        [ IsInt, IsComplexOfFinitelyPresentedObjectsRep ],
        
  function( _q, C )
    local q, degrees, l, def, d, mor, index_pairs, QFB, FB, CE, natural_epis,
          HZB, Z, ZB, PZ, relZ, BFZ, BF, i, FZ;
    
    if not IsComplex( C ) then
        Error( "the second argument is not a complex\n" );
    fi;
    
    q := _q;
    
    degrees := ObjectDegreesOfComplex( C );
    
    l := Length( degrees ) - 1;
    
    def := ObjectsOfComplex( DefectOfExactness( C ) );
    
    if l = 0 then
        return HomalgComplex( Resolution( q, def[1] ), degrees[1] );
    fi;
    
    d := List( def, M -> Resolution( q, M ) );
    
    if q < 0 then
        q := Maximum( List( def, LengthOfResolution ) );
        d := List( def, M -> Resolution( q, M ) );
    fi;
    
    mor := MorphismsOfComplex( C );
    
    index_pairs := List( mor, PairOfPositionsOfTheDefaultSetOfRelations );
    
    ## F/B = Q <- F <- B (horse shoe)
    QFB := Resolution( q, CokernelSequence( mor[1] ) );
    
    ## F <- B
    FB := HighestDegreeMorphism( QFB );
    
    ## F
    CE := HomalgComplex( Range( FB ), degrees[1] );
    
    ## enrich CE with the natrual epis
    natural_epis := rec( );
    
    CE!.NaturalEpis := natural_epis;
    
    natural_epis.(String( [ 0, 0 ] )) := CokernelEpi( LowestDegreeMorphism( Range( FB ) ) );
    
    if l > 1 then
        if IsHomalgLeftObjectOrMorphismOfLeftObjects( C ) then
            ## Z/B =: H <- Z <- B
            HZB := DefectOfExactnessSequence( mor[2], mor[1] );
            
            ## Z <- B
            ZB := HighestDegreeMorphism( HZB );
            
            Z := Range( ZB );
            
            ## horse shoe
            HZB := Resolution( q, HZB );
            
            ## Z <- B
            ZB := HighestDegreeMorphism( HZB );
            
            ## the horse shoe resolution of Z
            PZ := Range( ZB );
            
            ## make this horse shoe resolution of Z the standard one
            relZ := RelationsOfModule( Z );
            if HasFreeResolution( relZ ) then
                ResetFilterObj( relZ, FreeResolution );
            fi;
            SetFreeResolution( relZ, PZ );
            
            ## B <- F <- Z (horse shoe)
            BFZ := Resolution( q, KernelSequence( mor[1] ) );
            
            ## B <- F
            BF := LowestDegreeMorphism( BFZ );
            
            ## enrich CE with the natrual epi
            natural_epis.(String( [ 1, 0 ] )) := CokernelEpi( LowestDegreeMorphism( Source( BF ) ) );
            
            ## F[i] <- F[i+1]
            Add( CE, BF * FB );
            
            ## F <- Z
            FZ := HighestDegreeMorphism( BFZ );
        else
            ## Z/B =: H <- Z <- B
            HZB := DefectOfExactnessSequence( mor[1], mor[2] );
            
            ## Z <- B
            ZB := HighestDegreeMorphism( HZB );
            
            Z := Range( ZB );
            
            ## horse shoe
            HZB := Resolution( q, HZB );
            
            ## Z <- B
            ZB := HighestDegreeMorphism( HZB );
            
            ## the horse shoe resolution of Z
            PZ := Range( ZB );
            
            ## make this horse shoe resolution of Z the standard one
            relZ := RelationsOfModule( Z );
            if HasFreeResolution( relZ ) then
                ResetFilterObj( relZ, FreeResolution );
            fi;
            SetFreeResolution( relZ, PZ );
            
            ## B <- F <- Z (horse shoe)
            BFZ := Resolution( q, KernelSequence( mor[1] ) );
            
            ## B <- F
            BF := LowestDegreeMorphism( BFZ );
            
            ## enrich CE with the natrual epi
            natural_epis.(String( [ 1, 0 ] )) := CokernelEpi( LowestDegreeMorphism( Source( BF ) ) );
            
            ## F[i] <- F[i+1]
            Add( CE, FB * BF );
            
            ## F <- Z
            FZ := HighestDegreeMorphism( BFZ );
        fi;
    fi;
    
    if IsHomalgLeftObjectOrMorphismOfLeftObjects( C ) then
        for i in [ 3 .. l ] do
            ## Z/B =: H <- Z <- B
            HZB := DefectOfExactnessSequence( mor[i], mor[i-1] );
            
            Z := Range( HighestDegreeMorphism( HZB ) );
            
            ## horse shoe
            HZB := Resolution( q, HZB );
            
            ## the horse shoe resolution of Z
            PZ := Range( HighestDegreeMorphism( HZB ) );
            
            ## make this horse shoe resolution of Z the standard one
            relZ := RelationsOfModule( Z );
            if HasFreeResolution( relZ ) then
                ResetFilterObj( relZ, FreeResolution );
            fi;
            SetFreeResolution( relZ, PZ );
            
            ## B <- F <- Z (horse shoe)
            BFZ := Resolution( q, KernelSequence( mor[i-1] ) );
            
            ## B <- F
            BF := LowestDegreeMorphism( BFZ );
            
            ## enrich CE with the natrual epi
            natural_epis.(String( [ i - 1, 0 ] )) := CokernelEpi( LowestDegreeMorphism( Source( BF ) ) );
            
            ## F[i] <- F[i+1]
            Add( CE, BF * ZB * FZ );
            
            ## Z <- B
            ZB := HighestDegreeMorphism( HZB );
            
            ## F <- Z
            FZ := HighestDegreeMorphism( BFZ );
        od;
    else
        for i in [ 3 .. l ] do
            ## Z/B =: H <- Z <- B
            HZB := DefectOfExactnessSequence( mor[i-1], mor[i] );
            
            Z := Range( HighestDegreeMorphism( HZB ) );
            
            ## horse shoe
            HZB := Resolution( q, HZB );
            
            ## the horse shoe resolution of Z
            PZ := Range( HighestDegreeMorphism( HZB ) );
            
            ## make this horse shoe resolution of Z the standard one
            relZ := RelationsOfModule( Z );
            if HasFreeResolution( relZ ) then
                ResetFilterObj( relZ, FreeResolution );
            fi;
            SetFreeResolution( relZ, PZ );
            
            ## B <- F <- Z (horse shoe)
            BFZ := Resolution( q, KernelSequence( mor[i-1] ) );
            
            ## B <- F
            BF := LowestDegreeMorphism( BFZ );
            
            ## enrich CE with the natrual epi
            natural_epis.(String( [ i - 1, 0 ] )) := CokernelEpi( LowestDegreeMorphism( Source( BF ) ) );
            
            ## F[i] <- F[i+1]
            Add( CE, FZ * ZB * BF );
            
            ## Z <- B
            ZB := HighestDegreeMorphism( HZB );
            
            ## F <- Z
            FZ := HighestDegreeMorphism( BFZ );
        od;
    fi;
    
    ## B <- F <- Z
    BFZ := Resolution( q, KernelSequence( mor[l] ) );
    
    BF := LowestDegreeMorphism( BFZ );
    
    ## enrich CE with the natrual epi
    natural_epis.(String( [ l, 0 ] )) := CokernelEpi( LowestDegreeMorphism( Source( BF ) ) );
    
    if l > 1 then
        if IsHomalgLeftObjectOrMorphismOfLeftObjects( C ) then
            Add( CE, BF * ZB * FZ );
        else
            Add( CE, FZ * ZB * BF );
        fi;
    else
        if IsHomalgLeftObjectOrMorphismOfLeftObjects( C ) then
            Add( CE, BF * FB );
        else
            Add( CE, FB * BF );
        fi;
    fi;
    
    if HasIsExactSequence( C ) and IsExactSequence( C ) then
        SetIsExactSequence( CE, true );
    elif HasIsAcyclic( C ) and IsAcyclic( C ) then
        SetIsAcyclic( CE, true );
    else
        SetIsComplex( CE, true );
    fi;
    
    ## the Cartan-Eilenberg resolution:
    return CE;
    
end );

## the Cartan-Eilenberg resolution [HS. Lemma VIII.9.4]
InstallMethod( Resolution,	### defines: Resolution
        "for homalg complexes",
        [ IsInt, IsCocomplexOfFinitelyPresentedObjectsRep ],
        
  function( _q, C )
    local q, degrees, l, def, d, mor, index_pairs, ZFB, FB, CE, natural_epis,
          i, BZH, Z, PZ, relZ, BZ, ZF, BFQ, BF;
    
    if not IsComplex( C ) then
        Error( "the second argument is not a cocomplex\n" );
    fi;
    
    q := _q;
    
    degrees := ObjectDegreesOfComplex( C );
    
    l := Length( degrees ) - 1;
    
    def := ObjectsOfComplex( DefectOfExactness( C ) );
    
    if l = 0 then
        return HomalgCocomplex( Resolution( q, def[1] ), degrees[1] );
    fi;
    
    d := List( def, M -> Resolution( q, M ) );
    
    if q < 0 then
        q := Maximum( List( def, LengthOfResolution ) );
        d := List( def, M -> Resolution( q, M ) );
    fi;
    
    mor := MorphismsOfComplex( C );
    
    index_pairs := List( mor, PairOfPositionsOfTheDefaultSetOfRelations );
    
    ## Z -> F -> B (horse shoe)
    ZFB := Resolution( q, KernelCosequence( mor[1] ) );
    
    ## F -> B
    FB := HighestDegreeMorphism( ZFB );
    
    ## F
    CE := HomalgCocomplex( Source( FB ), degrees[1] );
    
    ## enrich CE with the natrual epis
    natural_epis := rec( );
    
    CE!.NaturalEpis := natural_epis;
    
    natural_epis.(String( [ 0, 0 ] )) := CokernelEpi( LowestDegreeMorphism( Source( FB ) ) );
    
    if IsHomalgLeftObjectOrMorphismOfLeftObjects( C ) then
        for i in [ 2 .. l ] do
            ## B -> Z -> H := Z/B
            BZH := DefectOfExactnessCosequence( mor[i-1], mor[i] );
            
            ## B -> Z
            BZ := LowestDegreeMorphism( BZH );
            
            Z := Range( BZ );
            
            ## horse shoe
            BZH := Resolution( q, BZH );
            
            ## B -> Z
            BZ := LowestDegreeMorphism( BZH );
            
            ## the horse shoe resolution of Z
            PZ := Range( BZ );
            
            ## make this horse shoe resolution of Z the standard one
            relZ := RelationsOfModule( Z );
            if HasFreeResolution( relZ ) then
                ResetFilterObj( relZ, FreeResolution );
            fi;
            SetFreeResolution( relZ, PZ );
            
            ## Z -> F -> B (horse shoe)
            ZFB := Resolution( q, KernelCosequence( mor[i] ) );
            
            ## Z -> F
            ZF := LowestDegreeMorphism( ZFB );
            
            ## enrich CE with the natrual epi
            natural_epis.(String( [ i - 1, 0 ] )) := CokernelEpi( LowestDegreeMorphism( Range( ZF ) ) );
            
            ## F[i-1] -> F[i]
            Add( CE, FB * BZ * ZF );
            
            ## F -> B
            FB := HighestDegreeMorphism( ZFB );
        od;
    else
        for i in [ 2 .. l ] do
            ## B -> Z -> H := Z/B
            BZH := DefectOfExactnessCosequence( mor[i], mor[i-1] );
            
            ## B -> Z
            BZ := LowestDegreeMorphism( BZH );
            
            Z := Range( BZ );
            
            ## horse shoe
            BZH := Resolution( q, BZH );
            
            ## B -> Z
            BZ := LowestDegreeMorphism( BZH );
            
            ## the horse shoe resolution of Z
            PZ := Range( BZ );
            
            ## make this horse shoe resolution of Z the standard one
            relZ := RelationsOfModule( Z );
            if HasFreeResolution( relZ ) then
                ResetFilterObj( relZ, FreeResolution );
            fi;
            SetFreeResolution( relZ, PZ );
            
            ## Z -> F -> B (horse shoe)
            ZFB := Resolution( q, KernelCosequence( mor[i] ) );
            
            ## Z -> F
            ZF := LowestDegreeMorphism( ZFB );
            
            ## enrich CE with the natrual epi
            natural_epis.(String( [ i - 1, 0 ] )) := CokernelEpi( LowestDegreeMorphism( Range( ZF ) ) );
            
            ## F[i-1] -> F[i]
            Add( CE, ZF * BZ * FB );
            
            ## F -> B
            FB := HighestDegreeMorphism( ZFB );
        od;
    fi;
    
    ## B -> F -> Q = F/B
    BFQ := Resolution( q, CokernelCosequence( mor[l] ) );
    
    BF := LowestDegreeMorphism( BFQ );
    
    ## enrich CE with the natrual epi
    natural_epis.(String( [ l, 0 ] )) := CokernelEpi( LowestDegreeMorphism( Range( BF ) ) );
            
    if IsHomalgLeftObjectOrMorphismOfLeftObjects( C ) then
        Add( CE, FB * BF );
    else
        Add( CE, BF * FB );
    fi;
    
    if HasIsExactSequence( C ) and IsExactSequence( C ) then
        SetIsExactSequence( CE, true );
    elif HasIsAcyclic( C ) and IsAcyclic( C ) then
        SetIsAcyclic( CE, true );
    else
        SetIsComplex( CE, true );
    fi;
    
    ## the Cartan-Eilenberg resolution:
    return CE;
    
end );

