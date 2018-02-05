#############################################################################
##
##  OtherFunctors.gi            Modules package              Mohamed Barakat
##
##  Copyright 2007-2010 Mohamed Barakat, RWTH Aachen
##
##  Implementation stuff for some other functors.
##
#############################################################################

####################################
#
# install global functions/variables:
#
####################################

##
## DirectSum
##

InstallGlobalFunction( _Functor_DirectSum_OnModules,	### defines: DirectSum
  function( M, N )
    local matM, matN, sum, R, idM, idN, F, zeroMN, zeroNM, iotaM, iotaN, piM, piN;
    
    CheckIfTheyLieInTheSameCategory( M, N );
    
    matM := MatrixOfRelations( M );
    matN := MatrixOfRelations( N );
    
    sum := DiagMat( [ matM, matN ] );
    
    R := HomalgRing( M );
    
    idM := HomalgIdentityMatrix( NrGenerators( M ), R );
    idN := HomalgIdentityMatrix( NrGenerators( N ), R );
    
    if IsHomalgLeftObjectOrMorphismOfLeftObjects( M ) then
        F := HomalgFreeLeftModule( NrGenerators( M ) + NrGenerators( N ), R );
        zeroMN := HomalgZeroMatrix( NrGenerators( M ), NrGenerators( N ), R );
        zeroNM := HomalgZeroMatrix( NrGenerators( N ), NrGenerators( M ), R );
        iotaM := UnionOfColumnsOp( idM, zeroMN );
        iotaN := UnionOfColumnsOp( zeroNM, idN );
        piM := UnionOfRowsOp( idM, zeroNM );
        piN := UnionOfRowsOp( zeroMN, idN );
    else
        F := HomalgFreeRightModule( NrGenerators( M ) + NrGenerators( N ), R );
        zeroMN := HomalgZeroMatrix( NrGenerators( N ), NrGenerators( M ), R );
        zeroNM := HomalgZeroMatrix( NrGenerators( M ), NrGenerators( N ), R );
        iotaM := UnionOfRowsOp( idM, zeroMN );
        iotaN := UnionOfRowsOp( zeroNM, idN );
        piM := UnionOfColumnsOp( idM, zeroNM );
        piN := UnionOfColumnsOp( zeroMN, idN );
    fi;
    
    sum := HomalgMap( sum, "free", F );
    
    sum := Cokernel( sum );
    
    iotaM := HomalgMap( iotaM, M, sum );
    iotaN := HomalgMap( iotaN, N, sum );
    piM := HomalgMap( piM, sum, M );
    piN := HomalgMap( piN, sum, N );
    
    return SetPropertiesOfDirectSum( [ M, N ], sum, iotaM, iotaN, piM, piN );
    
end );

InstallGlobalFunction( _Functor_DirectSum_OnMaps,	### defines: DirectSum (morphism part)
  function( F_source, F_target, arg_before_pos, phi, arg_behind_pos )
    local R, L, idL, hull_phi, emb_source, emb_target, mor;
    
    R := HomalgRing( phi );
    
    if arg_before_pos = [ ] and Length( arg_behind_pos ) = 1 then
        ## phi + L
        
        L := arg_behind_pos[1];
        
        idL := HomalgIdentityMatrix( NrGenerators( L ), R );
        
        hull_phi := DiagMat( [ MatrixOfMap( phi ), idL ] );
        
    elif Length( arg_before_pos ) = 1 and arg_behind_pos = [ ] then
        ## L + phi
        
        L := arg_before_pos[1];
        
        idL := HomalgIdentityMatrix( NrGenerators( L ), R );
        
        hull_phi := DiagMat( [ idL, MatrixOfMap( phi ) ] );
        
    else
        Error( "wrong input\n" );
    fi;
    
    emb_source := NaturalGeneralizedEmbedding( F_source );
    emb_target := NaturalGeneralizedEmbedding( F_target );
    
    hull_phi := HomalgMap( hull_phi, Range( emb_source ), Range( emb_target ) );
    
    SetIsMorphism( hull_phi, true );
    
    mor := CompleteImageSquare( emb_source, hull_phi, emb_target );
    
    ## HasIsIsomorphism( phi ) and IsIsomorphism( phi ), resp.
    ## HasIsMorphism( phi ) and IsMorphism( phi ), and
    ## UpdateObjectsByMorphism( mor )
    ## will be taken care of in FunctorMap
    
    if HasIsMonomorphism( phi ) and IsMonomorphism( phi ) then
        
        ## check assertion
        Assert( 3, IsMonomorphism( mor ) );
        
        SetIsMonomorphism( mor, true );
        
    elif HasIsEpimorphism( phi ) and IsEpimorphism( phi ) then
        
        ## check assertion
        Assert( 3, IsEpimorphism( mor ) );
        
        SetIsEpimorphism( mor, true );
        
    fi;
    
    return mor;
    
end );

InstallValue( Functor_DirectSum_for_fp_modules,
        CreateHomalgFunctor(
                [ "name", "DirectSum" ],
                [ "category", HOMALG_MODULES.category ],
                [ "operation", "DirectSumOp" ],
                [ "natural_transformation1", "EpiOnLeftFactor" ],
                [ "natural_transformation2", "EpiOnRightFactor" ],
                [ "natural_transformation3", "MonoOfLeftSummand" ],
                [ "natural_transformation4", "MonoOfRightSummand" ],
                [ "number_of_arguments", 2 ],
                [ "1", [ [ "covariant" ] ] ],
                [ "2", [ [ "covariant" ] ] ],
                [ "OnObjects", _Functor_DirectSum_OnModules ],
                [ "OnMorphisms", _Functor_DirectSum_OnMaps ]
                )
        );

Functor_DirectSum_for_fp_modules!.ContainerForWeakPointersOnComputedBasicObjects := true;

Functor_DirectSum_for_fp_modules!.ContainerForWeakPointersOnComputedBasicMorphisms := true;

####################################
#
# methods for operations & attributes:
#
####################################

##
InstallMethod( SetPropertiesOfDirectSum,
        "for a list, a homalg module, and four homalg module homomorphisms",
        [ IsList, IsHomalgModule,
          IsMapOfFinitelyGeneratedModulesRep,
          IsMapOfFinitelyGeneratedModulesRep,
          IsMapOfFinitelyGeneratedModulesRep,
          IsMapOfFinitelyGeneratedModulesRep ],
        
  function( M_N, sum, iotaM, iotaN, piM, piN )
    local M, N;
    
    M := M_N[1];
    N := M_N[2];
    
    ## properties of the direct sum module
    
    ## IsFree
    if HasIsFree( M ) and HasIsFree( N ) then
        if IsFree( M ) and IsFree( N ) then
            SetIsFree( sum, true );
        fi;
    fi;
    
    ## pass over to the method of Abelian categories
    TryNextMethod( );
    
end );

##
## DirectSum( M, N )		( M + N )
##

InstallFunctor( Functor_DirectSum_for_fp_modules );

####################################
#
# temporary
#
####################################

## works only for principal ideal domains
InstallGlobalFunction( _UCT_Homology,
  function( H, G )
    local HG;
    
    HG := H * G + Tor( 1, Shift( H, -1 ), G );
    
    return ByASmallerPresentation( HG );
    
end );

## works only for principal ideal domains
InstallGlobalFunction( _UCT_Cohomology,
  function( H, G )
    local HG;
    
    HG := Hom( H, G ) + Ext( 1, Shift( H, -1 ), G );
    
    return ByASmallerPresentation( HG );
    
end );

