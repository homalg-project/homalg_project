#############################################################################
##
##  Koszul.gi                                          GradedModules package
##
##  Copyright 2007-2010, Mohamed Barakat, University of Kaiserslautern
##                       Markus Lange-Hegermann, RWTH Aachen
##
##  Implementations for functors L and R
##
#############################################################################

##  <#GAPDoc Label="RepresentationMatrixOfKoszulId">
##  <ManSection>
##    <Oper Arg="d, M" Name="RepresentationMatrixOfKoszulId"/>
##    <Returns>a &homalg; matrix</Returns>
##    <Description>
##      It is assumed that all indeterminates of the underlying &homalg; graded ring <M>S</M> are of degree <M>1</M>.
##      The output is the &homalg; matrix of the multiplication map
##      <Alt Only="LaTeX">$\mathrm{Hom}( A, M_d ) \to \mathrm{Hom}( A, M_{d+1} )$</Alt><Alt Not="LaTeX">
##      <M>Hom( A, M_{<A>d</A>} ) \to Hom( A, M_{<A>d</A>+1} )</M></Alt>, where <M>A</M> is the Koszul dual ring of <M>S</M>,
##      defined using the operation <C>KoszulDualRing</C>.
##      <#Include Label="RepresentationMatrixOfKoszulId:example">
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
InstallMethod( RepresentationMatrixOfKoszulId,
        "for homalg graded modules",
        [ IsInt, IsGradedModuleRep, IsHomalgGradedRing ],
        
  function( d, M, A )
    local pos_pres, S, vars, dual, weights, pos, reps, rep;
    
    pos_pres := PositionOfTheDefaultPresentation( M );
    
    if not IsBound( M!.RepresentationMatricesOfKoszulId ) then
        M!.RepresentationMatricesOfKoszulId := rec( );
    fi;
    if not IsBound( M!.RepresentationMatricesOfKoszulId!.(pos_pres) ) then
        M!.RepresentationMatricesOfKoszulId!.(pos_pres) := rec( );
    fi;
    if IsBound( M!.RepresentationMatricesOfKoszulId!.(pos_pres)!.(d) ) then
        return M!.RepresentationMatricesOfKoszulId!.(pos_pres)!.(d);
    fi;
    
    S := HomalgRing( M );
    
    vars := Indeterminates( S );
    dual := Indeterminates( A );
    
    weights := WeightsOfIndeterminates( S );
    
    if not Set( weights ) = [ 1 ] then
        
        pos := Filtered( [ 1 .. Length( weights ) ], p -> weights[p] = 1 );
        
        ## the variables of weight 1
        vars := vars{pos};
        dual := dual{pos};
        
    fi;
    
    ## this whole computation is over S = HomalgRing( M )
    reps := List( vars, v -> MatrixOfMap( RepresentationMapOfRingElement( v, M, d ) ) );
    
    ## convert the matrices with constant coefficients
    ## to matrices of the Koszul dual ring A
    reps := List( reps, mat -> A * mat );
    
    ## this is over the Koszul dual ring A
    reps := List( [ 1 .. Length( vars ) ], i -> dual[i] * reps[i] );
    
    rep := Sum( reps );
    
    M!.RepresentationMatricesOfKoszulId!.(pos_pres)!.(d) := rep;
    
    return rep;
    
end );

##
InstallMethod( RepresentationMatrixOfKoszulId,
        "for homalg graded modules",
        [ IsInt, IsGradedModuleRep ],
        
  function( d, M )
    local A;
    
    A := KoszulDualRing( HomalgRing( M ) );
    
    return RepresentationMatrixOfKoszulId( d, M, A );
    
end );

#
# RepresentationObjectOfKoszulId
#
InstallGlobalFunction( _Functor_RepresentationObjectOfKoszulId_OnGradedModules , ### defines: RepresentationObjectOfKoszulId (object part)
        [ IsInt, IsGradedModuleRep ],
        
  function( d, M )
    local S, A, n, omega_A, V, AM_d, socle, phi;
    
    S := HomalgRing( M );
    
    A := KoszulDualRing( S );
    
    n := Length( Indeterminates( A ) );
    
    omega_A := A^(-n);
    
    V := HomogeneousPartOverCoefficientsRing( d, M );
    
    AM_d := omega_A * ( A * V );
    
    socle := HomogeneousPartOverCoefficientsRing( d, AM_d );
    
    phi := GradedMap( HomalgIdentityMatrix( NrGenerators( V ), CoefficientsRing( S ) ), V, socle );
    Assert( 2, IsMorphism( phi ) );
    SetIsMorphism( phi, true );
    Assert( 2, IsMonomorphism( phi ) );
    SetIsMonomorphism( phi, true );
    Assert( 2, IsEpimorphism( phi ) );
    SetIsEpimorphism( phi, true );
    
    SetNaturalTransformation( 
        Functor_RepresentationObjectOfKoszulId_ForGradedModules,
        [ d, M ],
        "MapFromHomogeneousPartofModuleToHomogeneousPartOfKoszulRightAdjoint",
        phi
    );
    
    return AM_d;
    
end );

InstallValue( Functor_RepresentationObjectOfKoszulId_ForGradedModules,
        CreateHomalgFunctor(
                [ "name", "RepresentationObjectOfKoszulId" ],
                [ "category", HOMALG_GRADED_MODULES.category ],
                [ "operation", "RepresentationObjectOfKoszulId" ],
                [ "natural_transformations", [ [ "MapFromHomogeneousPartofModuleToHomogeneousPartOfKoszulRightAdjoint", 2 ] ] ],
                [ "number_of_arguments", 1 ],
                [ "0", [ IsInt ] ],
                [ "1", [ [ "covariant", "left adjoint", "distinguished" ], HOMALG_GRADED_MODULES.FunctorOn ] ],
                [ "OnObjects", _Functor_RepresentationObjectOfKoszulId_OnGradedModules ]
                )
        );

Functor_RepresentationObjectOfKoszulId_ForGradedModules!.ContainerForWeakPointersOnComputedBasicObjects :=
  ContainerForWeakPointers( TheTypeContainerForWeakPointersOnComputedValuesOfFunctor );

Functor_RepresentationObjectOfKoszulId_ForGradedModules!.ContainerForWeakPointersOnComputedBasicMorphisms :=
  ContainerForWeakPointers( TheTypeContainerForWeakPointersOnComputedValuesOfFunctor );

InstallFunctor( Functor_RepresentationObjectOfKoszulId_ForGradedModules );

##  <#GAPDoc Label="RepresentationMapOfKoszulId">
##  <ManSection>
##    <Oper Arg="d, M" Name="RepresentationMapOfKoszulId"/>
##    <Returns>a &homalg; map</Returns>
##    <Description>
##      It is assumed that all indeterminates of the underlying &homalg; graded ring <M>S</M> are of degree <M>1</M>.
##      The output is the the multiplication map
##      <Alt Only="LaTeX">$\mathrm{Hom}( A, M_d ) \to \mathrm{Hom}( A, M_{d+1} )$</Alt><Alt Not="LaTeX">
##      <M>Hom( A, M_{<A>d</A>} ) \to Hom( A, M_{<A>d</A>+1} )</M></Alt>, where <M>A</M> is the Koszul dual ring of
##      <M>S</M>, defined using the operation <C>KoszulDualRing</C>.
##      <#Include Label="RepresentationMapOfKoszulId:example">
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
InstallMethod( RepresentationMapOfKoszulId,
        "for homalg graded modules",
        [ IsInt, IsGradedModuleRep, IsHomalgGradedRing ],
        
  function( d, M, A )
    local rep, AM_d, AM_dp1, result;
    
    rep := RepresentationMatrixOfKoszulId( d, M, A );
    ## now determine the source and target modules
    AM_d := RepresentationObjectOfKoszulId( d, M );
    AM_dp1 := RepresentationObjectOfKoszulId( d+1, M );
    
    result := GradedMap( A * rep, AM_d, AM_dp1 );;
    
    Assert( 2, IsMorphism( result ) );
    SetIsMorphism( result, true );
    
    return result;
    
end );

##
InstallMethod( RepresentationMapOfKoszulId,
        "for homalg graded modules",
        [ IsInt, IsGradedModuleRep ],
        
  function( d, M )
    local A;
    
    A := KoszulDualRing( HomalgRing( M ) );
    
    return RepresentationMapOfKoszulId( d, M, A );
    
end );

##  <#GAPDoc Label="KoszulRightAdjoint">
##  <ManSection>
##    <Oper Arg="M, degree_lowest, degree_highest" Name="KoszulRightAdjoint"/>
##    <Returns>a &homalg; cocomplex</Returns>
##    <Description>
##      It is assumed that all indeterminates of the underlying &homalg; graded ring <M>S</M> are of degree <M>1</M>.
##      Compute the &homalg; <M>A</M>-cocomplex <M>C</M> of Koszul maps of the &homalg; <M>S</M>-module <A>M</A>
##      (&see; <Ref Oper="RepresentationMapOfKoszulId"/>) in the <M>[</M> <A>degree_lowest</A> .. <A>degree_highest</A> <M>]</M>.
##      The Castelnuovo-Mumford regularity of <A>M</A> is characterized as the highest degree <M>d</M>, such that
##      <M>C</M> is not exact at <M>d</M>. <M>A</M> is the Koszul dual ring of <M>S</M>,
##      defined using the operation <C>KoszulDualRing</C>.
##      <#Include Label="KoszulRightAdjoint:example">
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
InstallMethod( KoszulAdjoint,
        "for homalg graded modules",
        [ IsGradedModuleRep, IsHomalgGradedRing, IsInt, IsInt ],
        
  function( M, A, degree_lowest, degree_highest )
    local d, tate, C, i, source, target;
    
    if degree_lowest >= degree_highest then
        
        d := degree_lowest;
        
        tate := RepresentationMapOfKoszulId( d, M, A );
        
        C := HomalgCocomplex( tate, d );
        
        return C;
        
    fi;
    
    tate := RepresentationMapOfKoszulId( degree_lowest, M, A );
    
    C := HomalgCocomplex( tate, degree_lowest );
    
    for i in [ degree_lowest + 1 .. degree_highest - 1 ] do
        
        source := Range( tate );
        
        ## the Koszul map has linear entries by construction
        tate := RepresentationMapOfKoszulId( i, M, A );
        
        Add( C, tate );
    od;
    
    if HasCastelnuovoMumfordRegularity( M ) and CastelnuovoMumfordRegularity( M ) <= degree_lowest then
         
         ## check assertion
         Assert( 1, IsAcyclic( C ) );
         
         SetIsAcyclic( C, true );
         
    fi;
    
    ## check assertion
    Assert( 1, IsComplex( C ) );
    
    SetIsComplex( C, true );
    
    C!.display_twist := true;
    
    return C;
    
end );

##
InstallMethod( KoszulAdjoint,
        "for homalg graded modules",
        [ IsGradedModuleRep, IsInt, IsInt ],
        
  function( M, degree_lowest, degree_highest )
    local A;
    
    A := KoszulDualRing( HomalgRing( M ) );
    
    return KoszulAdjoint( M, A, degree_lowest, degree_highest );
    
end );

##
InstallMethod( KoszulAdjoint,
        "for homalg graded modules",
        [ IsStructureObject, IsHomalgRing and IsExteriorRing, IsInt, IsInt ],
        
  function( S, A, degree_lowest, degree_highest )
    
    return KoszulAdjoint( FreeRightModuleWithDegrees( 1, S ), A, degree_lowest, degree_highest );
    
end );

##
InstallMethod( KoszulAdjoint,
       "for homalg graded modules",
        [ IsStructureObject, IsInt, IsInt ],
        
  function( S, degree_lowest, degree_highest )
    
    return KoszulAdjoint( FreeRightModuleWithDegrees( 1, S ), degree_lowest, degree_highest );
    
end );

InstallMethod( KoszulRightAdjointOnMorphisms,
        "for homalg graded maps",
        [ IsMapOfGradedModulesRep, IsHomalgGradedRing, IsInt, IsInt ],
        
  function( phi, A, degree_lowest, degree_highest )
    local T_source, T_range;
    
    T_source := KoszulRightAdjoint( Source( phi ), A, degree_lowest, degree_highest );
    T_range := KoszulRightAdjoint( Range( phi ), A, degree_lowest, degree_highest );
    
    return KoszulAdjointOnMorphisms( phi, A, degree_lowest, degree_highest, T_source, T_range );
    
end );

InstallMethod( KoszulLeftAdjointOnMorphisms,
        "for homalg graded maps",
        [ IsMapOfGradedModulesRep, IsHomalgGradedRing, IsInt, IsInt ],
        
  function( phi, A, degree_lowest, degree_highest )
    local T_source, T_range;
    
    T_source := KoszulLeftAdjoint( Source( phi ), A, degree_lowest, degree_highest );
    T_range := KoszulLeftAdjoint( Range( phi ), A, degree_lowest, degree_highest );
    
    return KoszulAdjointOnMorphisms( phi, A, degree_lowest, degree_highest, T_source, T_range );
    
end );

InstallMethod( KoszulAdjointOnMorphisms,
        "for homalg graded maps",
        [ IsMapOfGradedModulesRep, IsHomalgGradedRing, IsInt, IsInt, IsHomalgComplex, IsHomalgComplex ],
        
  function( phi, A, degree_lowest, degree_highest, T_source, T_range )
    local ii, i, phi_i, T_i, T;
    
    # create the map in each step by converting its homogeneous part to the dual ring.
    for ii in [ degree_lowest .. degree_highest ] do
        i := ( degree_highest ) + degree_lowest - ii;
        
        phi_i := HomogeneousPartOverCoefficientsRing( i, phi );
        
        T_i := A * phi_i;
        
        if IsBound( T ) then
            Add( T_i, T );
        else
            T := HomalgChainMorphism( T_i, T_source, T_range, i );
        fi;
        
    od;
    
    ## check assertion
    Assert( 1, IsMorphism( T ) );
    
    SetIsMorphism( T, true );
    
    T!.display_twist := true;

    return T;
    
end );

##
InstallMethod( KoszulAdjointOnMorphisms,
        "for graded maps",
        [ IsMapOfGradedModulesRep, IsInt, IsInt ],
        
  function( phi, degree_lowest, degree_highest )
    local A;
    
    A := KoszulDualRing( HomalgRing( phi ) );
    
    return KoszulAdjointOnMorphisms( phi, A, degree_lowest, degree_highest );
    
end );

##
## KoszulRightAdjoint
##

InstallGlobalFunction( _Functor_KoszulRightAdjoint_OnGradedModules , ### defines: KoszulRightAdjoint (object part)
        [ IsList, IsGradedModuleRep ],
        
  function( l, M )
    local A, degree_lowest, degree_highest;
    
    if not Length( l ) = 3 then
        Error( "wrong type of parameters" );
    else
        A := l[1];
        degree_lowest := l[2];
        degree_highest := l[3];
        if not IsHomalgGradedRing( A ) and IsFreePolynomialRing( A ) and IsInt( degree_lowest ) and IsInt( degree_highest ) then
            Error( "wrong type of parameters" );
        fi;
    fi;
    
    if not IsIdenticalObj( A, KoszulDualRing( HomalgRing( M ) ) ) then
        Error( "entered wrong rings, expected the dual ring of the module as first parameter" );
    fi;
    
    return KoszulAdjoint( M, A, degree_lowest, degree_highest );
    
end );


##
InstallGlobalFunction( _Functor_KoszulRightAdjoint_OnGradedMaps, ### defines: KoszulRightAdjoint (morphism part)
        [ IsList, IsMapOfGradedModulesRep ],
  function( l, phi )
    local A, degree_lowest, degree_highest;
    
    if not Length( l ) = 3 then
        Error( "wrong type of parameters" );
    else
        A := l[1];
        degree_lowest := l[2];
        degree_highest := l[3];
        if not IsHomalgGradedRing( A ) and IsFreePolynomialRing( A ) and IsInt( degree_lowest ) and IsInt( degree_highest ) then
            Error( "wrong type of parameters" );
        fi;
    fi;
    
    if not IsIdenticalObj( A, KoszulDualRing( HomalgRing( phi ) ) ) then
        Error( "entered wrong rings, expected the dual ring of the morphism as first parameter" );
    fi;
    
    return KoszulRightAdjointOnMorphisms( phi, A, degree_lowest, degree_highest );
    
end );

InstallValue( Functor_KoszulRightAdjoint_ForGradedModules,
        CreateHomalgFunctor(
                [ "name", "KoszulRightAdjoint" ],
                [ "category", HOMALG_GRADED_MODULES.category ],
                [ "operation", "KoszulRightAdjoint" ],
                [ "number_of_arguments", 1 ],
                [ "0", [ IsList ] ],
                [ "1", [ [ "covariant", "left adjoint", "distinguished" ], HOMALG_GRADED_MODULES.FunctorOn ] ],
                [ "OnObjects", _Functor_KoszulRightAdjoint_OnGradedModules ],
                [ "OnMorphisms", _Functor_KoszulRightAdjoint_OnGradedMaps ],
                [ "IsIdentityOnObjects", true ]
                )
        );

Functor_KoszulRightAdjoint_ForGradedModules!.ContainerForWeakPointersOnComputedBasicObjects :=
  ContainerForWeakPointers( TheTypeContainerForWeakPointersOnComputedValuesOfFunctor );

Functor_KoszulRightAdjoint_ForGradedModules!.ContainerForWeakPointersOnComputedBasicMorphisms :=
  ContainerForWeakPointers( TheTypeContainerForWeakPointersOnComputedValuesOfFunctor );

InstallFunctor( Functor_KoszulRightAdjoint_ForGradedModules );

##
InstallMethod( KoszulRightAdjoint,
        "for homalg graded modules",
        [ IsGradedModuleRep, IsHomalgGradedRing, IsInt, IsInt ],
        
  function( M, A, degree_lowest, degree_highest )
    local S, d, tate, C, i, source, target;
    
    S := HomalgRing( M );
    
    if not IsFreePolynomialRing( S ) and IsHomalgGradedRingRep( S ) then
        TryNextMethod();
    fi;
    
    A := KoszulDualRing( S );
    
    return KoszulRightAdjoint( [ A, degree_lowest, degree_highest ], M );
    
end );

##
InstallMethod( KoszulRightAdjoint,
        "for homalg graded modules",
        [ IsGradedModuleRep, IsInt, IsInt ],
        
  function( M, degree_lowest, degree_highest )
    local S, A;
    
    S := HomalgRing( M );
    
    if not IsFreePolynomialRing( S ) and IsHomalgGradedRingRep( S ) then
        TryNextMethod();
    fi;
    
    A := KoszulDualRing( S );
    
    return KoszulRightAdjoint( M, A, degree_lowest, degree_highest );
    
end );

##
InstallMethod( KoszulRightAdjoint,
        "for homalg graded modules",
        [ IsFreePolynomialRing and IsHomalgGradedRingRep, IsHomalgGradedRingRep and IsExteriorRing, IsInt, IsInt ],
        
  function( S, A, degree_lowest, degree_highest )
    
    return KoszulRightAdjoint( FreeRightModuleWithDegrees( 1, S ), A, degree_lowest, degree_highest );
    
end );

##
InstallMethod( KoszulRightAdjoint,
        "for homalg graded modules",
        [ IsFreePolynomialRing and IsHomalgGradedRingRep, IsInt, IsInt ],
        
  function( S, degree_lowest, degree_highest )
    
    return KoszulRightAdjoint( FreeRightModuleWithDegrees( 1, S ), degree_lowest, degree_highest );
    
end );

##
InstallMethod( KoszulRightAdjoint,
        "for homalg graded maps",
        [ IsMapOfGradedModulesRep, IsHomalgGradedRing, IsInt, IsInt ],
        
  function( phi, A, degree_lowest, degree_highest )
    
    return KoszulRightAdjoint( [ A, degree_lowest, degree_highest ], phi );
    
end );

##
InstallMethod( KoszulRightAdjoint,
        "for homalg graded maps",
        [ IsMapOfGradedModulesRep, IsInt, IsInt ],
        
  function( phi, degree_lowest, degree_highest )
    local A;
    
    A := KoszulDualRing( HomalgRing( phi ) );
    
    return KoszulRightAdjoint( [ A, degree_lowest, degree_highest ], phi );
    
end );

##
## KoszulLeftAdjoint
##

InstallGlobalFunction( _Functor_KoszulLeftAdjoint_OnGradedModules , ### defines: KoszulLeftAdjoint (object part)
        [ IsList, IsGradedModuleRep ],
        
  function( l, M )
    local A, degree_lowest, degree_highest;
    
    if not Length( l ) = 3 then
        Error( "wrong type of parameters" );
    else
        A := l[1];
        degree_lowest := l[2];
        degree_highest := l[3];
        if not IsHomalgGradedRing( A ) and IsFreePolynomialRing( A ) and IsInt( degree_lowest ) and IsInt( degree_highest ) then
            Error( "wrong type of parameters" );
        fi;
    fi;
    
    if not IsIdenticalObj( A, KoszulDualRing( HomalgRing( M ) ) ) then
        Error( "entered wrong rings, expected the dual ring of the module as first parameter" );
    fi;
    
    return KoszulAdjoint( M, A, degree_lowest, degree_highest );
    
end );


##
InstallGlobalFunction( _Functor_KoszulLeftAdjoint_OnGradedMaps, ### defines: KoszulLeftAdjoint (morphism part)
        [ IsList, IsMapOfGradedModulesRep ],
  function( l, phi )
    local A, degree_lowest, degree_highest;
    
    if not Length( l ) = 3 then
        Error( "wrong type of parameters" );
    else
        A := l[1];
        degree_lowest := l[2];
        degree_highest := l[3];
        if not IsHomalgGradedRing( A ) and IsFreePolynomialRing( A ) and IsInt( degree_lowest ) and IsInt( degree_highest ) then
            Error( "wrong type of parameters" );
        fi;
    fi;
    
    if not IsIdenticalObj( A, KoszulDualRing( HomalgRing( phi ) ) ) then
        Error( "entered wrong rings, expected the dual ring of the module as first parameter" );
    fi;
    
    return KoszulLeftAdjointOnMorphisms( phi, A, degree_lowest, degree_highest );
    
end );

InstallValue( Functor_KoszulLeftAdjoint_ForGradedModules,
        CreateHomalgFunctor(
                [ "name", "KoszulLeftAdjoint" ],
                [ "category", HOMALG_GRADED_MODULES.category ],
                [ "operation", "KoszulLeftAdjoint" ],
                [ "number_of_arguments", 1 ],
                [ "0", [ IsList ] ],
                [ "1", [ [ "covariant", "left adjoint", "distinguished" ], HOMALG_GRADED_MODULES.FunctorOn ] ],
                [ "OnObjects", _Functor_KoszulLeftAdjoint_OnGradedModules ],
                [ "OnMorphisms", _Functor_KoszulLeftAdjoint_OnGradedMaps ],
                [ "IsIdentityOnObjects", true ]
                )
        );

Functor_KoszulLeftAdjoint_ForGradedModules!.ContainerForWeakPointersOnComputedBasicObjects :=
  ContainerForWeakPointers( TheTypeContainerForWeakPointersOnComputedValuesOfFunctor );

Functor_KoszulLeftAdjoint_ForGradedModules!.ContainerForWeakPointersOnComputedBasicMorphisms :=
  ContainerForWeakPointers( TheTypeContainerForWeakPointersOnComputedValuesOfFunctor );

InstallFunctor( Functor_KoszulLeftAdjoint_ForGradedModules );

##
InstallMethod( KoszulLeftAdjoint,
        "for homalg graded modules",
        [ IsGradedModuleRep, IsHomalgGradedRing, IsInt, IsInt ],
        
  function( M, A, degree_lowest, degree_highest )
    local S, d, tate, C, i, source, target;
    
    S := HomalgRing( M );
    
    if not IsExteriorRing( S ) and IsHomalgGradedRingRep( S ) then
        TryNextMethod();
    fi;
    
    A := KoszulDualRing( S );
    
    return KoszulLeftAdjoint( [ A, degree_lowest, degree_highest ], M );
    
end );

##
InstallMethod( KoszulLeftAdjoint,
        "for homalg graded modules",
        [ IsGradedModuleRep, IsInt, IsInt ],
        
  function( M, degree_lowest, degree_highest )
    local S, A;
    
    S := HomalgRing( M );
    
    if not IsExteriorRing( S ) and IsHomalgGradedRingRep( S ) then
        TryNextMethod();
    fi;
    
    A := KoszulDualRing( S );
    
    return KoszulLeftAdjoint( M, A, degree_lowest, degree_highest );
    
end );

##
InstallMethod( KoszulLeftAdjoint,
        "for homalg graded modules",
        [ IsFreePolynomialRing and IsHomalgGradedRingRep, IsHomalgGradedRingRep and IsExteriorRing, IsInt, IsInt ],
        
  function( S, A, degree_lowest, degree_highest )
    
    return KoszulLeftAdjoint( FreeLeftModuleWithDegrees( 1, S ), A, degree_lowest, degree_highest );
    
end );

##
InstallMethod( KoszulLeftAdjoint,
        "for homalg graded modules",
        [ IsFreePolynomialRing and IsHomalgGradedRingRep, IsInt, IsInt ],
        
  function( S, degree_lowest, degree_highest )
    
    return KoszulLeftAdjoint( FreeLeftModuleWithDegrees( 1, S ), degree_lowest, degree_highest );
    
end );

##
InstallMethod( KoszulLeftAdjoint,
        "for homalg graded maps",
        [ IsMapOfGradedModulesRep, IsHomalgGradedRing, IsInt, IsInt ],
        
  function( phi, A, degree_lowest, degree_highest )
    
    return KoszulLeftAdjoint( [ A, degree_lowest, degree_highest ], phi );
    
end );

##
InstallMethod( KoszulLeftAdjoint,
        "for homalg graded maps",
        [ IsMapOfGradedModulesRep, IsInt, IsInt ],
        
  function( phi, degree_lowest, degree_highest )
    local A;
    
    A := KoszulDualRing( HomalgRing( phi ) );
    
    return KoszulLeftAdjoint( [ A, degree_lowest, degree_highest ], phi );
    
end );

