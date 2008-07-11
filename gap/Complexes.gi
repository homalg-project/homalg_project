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
        Add( H, HomalgZeroMap( S, T ) );
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
        Add( H, HomalgZeroMap( S, T ) );
        
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
        Add( H, HomalgZeroMap( S, T ) );
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
        Add( H, HomalgZeroMap( S, T ) );
        
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
        
        j := HighestDegreeInChainMap( d_psi );
        
        if j <> HighestDegreeInChainMap( d_phi ) then
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
        
        SetIsEpimorphism( epsilon, true );
        
        dj := epsilon;
        
        Pj := Source( dj );
        
        dE := HomalgComplex( Pj );
        
        psi := DirectSumEpis( Pj )[2];
        phi := DirectSumEmbs( Pj )[1];
        
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
        
        psi := DirectSumEpis( Pj )[2];
        phi := DirectSumEmbs( Pj )[1];
        
        Add( d_psi, psi );
        Add( d_phi, phi );
        
    od;
    
    SetIsEpimorphism( d_psi, true );
    SetIsMonomorphism( d_phi, true );
    SetIsAcyclic( dE, true );
    SetIsExactSequence( horse_shoe, true );
    
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
        
        j := HighestDegreeInChainMap( d_psi );
        
        if j <> HighestDegreeInChainMap( d_phi ) then
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
        
        SetIsEpimorphism( epsilon, true );
        
        dj := epsilon;
        
        Pj := Source( dj );
        
        dE := HomalgComplex( Pj );
        
        psi := DirectSumEpis( Pj )[2];
        phi := DirectSumEmbs( Pj )[1];
        
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
        
        psi := DirectSumEpis( Pj )[2];
        phi := DirectSumEmbs( Pj )[1];
        
        Add( d_psi, psi );
        Add( d_phi, phi );
        
    od;
    
    SetIsEpimorphism( d_psi, true );
    SetIsMonomorphism( d_phi, true );
    SetIsAcyclic( dE, true );
    SetIsExactSequence( horse_shoe, true );
    
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
    
    iota_Hqn := NaturalEmbedding( Hqn );
    iota_Hsn_1 := NaturalEmbedding( Hsn_1 );
    
    snake := iota_Hqn;
    snake := snake / jn;
    snake := PreCompose( snake, bn );
    snake := snake / in_1;
    snake := snake / iota_Hsn_1;
    
    return snake;
    
end );

## [HS. Proof of Lemma. VIII.9.4]
InstallMethod( DefectOfExactnessSequence,
        "for homalg maps",
        [ IsHomalgComplex and IsATwoSequence ],
        
  function( cpx_post_pre )
    local pre, post, Z_F, B_F, B_Z, H, H_F, Z_H, C;
    
    pre := HighestDegreeMorphismInComplex( cpx_post_pre );
    post := LowestDegreeMorphismInComplex( cpx_post_pre );
    
    ## read: Z -> F
    Z_F := KernelEmb( post );
    
    ## read: B -> F
    B_F := ImageSubmoduleEmb( pre );
    
    ## read: B -> Z
    B_Z := B_F / Z_F;
    
    H := DefectOfExactness( cpx_post_pre );
    
    ## read: H -> F
    H_F := H!.NaturalEmbedding;
    
    ## read: Z -> H
    Z_H := Z_F / H_F;
    
    C := HomalgComplex( Z_H );
    
    Add( C, B_Z );
    
    SetIsShortExactSequence( C, true );
    
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
    
    pre := HighestDegreeMorphismInComplex( cpx_post_pre );
    post := LowestDegreeMorphismInComplex( cpx_post_pre );
    
    ## read: Z -> F
    Z_F := KernelEmb( post );
    
    ## read: B -> F
    B_F := ImageSubmoduleEmb( pre );
    
    ## read: B -> Z
    B_Z := B_F / Z_F;
    
    H := DefectOfExactness( cpx_post_pre );
    
    ## read: H -> F
    H_F := H!.NaturalEmbedding;
    
    ## read: Z -> H
    Z_H := Z_F / H_F;
    
    C := HomalgCocomplex( B_Z );
    
    Add( C, Z_H );
    
    SetIsShortExactSequence( C, true );
    
    return C;
    
end );

## for convenience
InstallMethod( DefectOfExactnessCosequence,
        "for homalg composable maps",
        [ IsMapOfFinitelyGeneratedModulesRep, IsMapOfFinitelyGeneratedModulesRep ],
        
  function( phi, psi )
    
    return DefectOfExactnessCosequence( AsATwoSequence( phi, psi ) );
    
end );

