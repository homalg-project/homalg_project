#############################################################################
##
##  LIGrMOD.gi                                            LIGrMOD subpackage
##
##         LIGrMOD = Logical Implications for Graded MODules
##
##  Copyright 2010,      Mohamed Barakat, University of Kaiserslautern
##                       Markus Lange-Hegermann, RWTH Aachen
##
##  Implementations for the LIGrMOD subpackage.
##
#############################################################################

####################################
#
# global variables:
#
####################################

# a central place for configuration variables:

InstallValue( LIGrMOD,
        rec(
            color := "\033[4;30;46m",
            
            ## used in a InstallLogicalImplicationsForHomalgSubobjects call below
            intrinsic_properties_specific_shared_with_subobjects_and_ideals :=
            [ 
              "IsCohenMacaulay",
              ],
            
            ## used in a InstallLogicalImplicationsForHomalgSubobjects call below
            intrinsic_properties_specific_shared_with_factors_modulo_ideals :=
            [ 
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
            
            ## needed for MatchPropertiesAndAttributes in GradedSubmodule.gi
            intrinsic_properties_shared_with_subobjects_and_ideals :=
            Concatenation(
                    LIMOD.intrinsic_properties_shared_with_subobjects_and_ideals,
                    ~.intrinsic_properties_specific_shared_with_subobjects_and_ideals ),
            
            ##
            intrinsic_properties_shared_with_factors_modulo_ideals :=
            Concatenation(
                    LIMOD.intrinsic_properties_shared_with_factors_modulo_ideals,
                    ~.intrinsic_properties_specific_shared_with_factors_modulo_ideals ),
            
            ## needed for MatchPropertiesAndAttributes in GradedSubmodule.gi
            intrinsic_properties_shared_with_subobjects_which_are_not_ideals :=
            Concatenation(
                    LIMOD.intrinsic_properties_shared_with_subobjects_which_are_not_ideals,
                    ~.intrinsic_properties_specific_shared_with_subobjects_which_are_not_ideals ),
            
            ## needed for UpdateObjectsByMorphism
            intrinsic_properties :=
            Concatenation(
                    LIMOD.intrinsic_properties,
                    ~.intrinsic_properties_specific ),
            
            ## used in a InstallLogicalImplicationsForHomalgSubobjects call below
            intrinsic_attributes_specific_shared_with_subobjects_and_ideals :=
            [ 
              "BettiTable",
              "LinearRegularity",
              "CastelnuovoMumfordRegularity",
              "CastelnuovoMumfordRegularityOfSheafification",
              ],
            
            ## used in a InstallLogicalImplicationsForHomalgSubobjects call below
            intrinsic_attributes_specific_shared_with_factors_modulo_ideals :=
            [ 
              "AffineDimension",
              "AffineDegree",
              "ProjectiveDegree",
              "PrimaryDecomposition",	## wrong, we need the preimages of this
              "RadicalDecomposition",	## wrong, we need the preimages of this
              "RadicalSubobject",	## wrong, we need the preimages of this
              "HilbertPolynomial",
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
            
            ## needed for MatchPropertiesAndAttributes in GradedSubmodule.gi
            intrinsic_attributes_shared_with_subobjects_and_ideals :=
            Concatenation(
                    LIMOD.intrinsic_attributes_shared_with_subobjects_and_ideals,
                    ~.intrinsic_attributes_specific_shared_with_subobjects_and_ideals ),
            
            ##
            intrinsic_attributes_shared_with_factors_modulo_ideals :=
            Concatenation(
                    LIMOD.intrinsic_attributes_shared_with_factors_modulo_ideals,
                    ~.intrinsic_attributes_specific_shared_with_factors_modulo_ideals ),
            
            ## needed for MatchPropertiesAndAttributes in GradedSubmodule.gi
            intrinsic_attributes_shared_with_subobjects_which_are_not_ideals :=
            Concatenation(
                    LIMOD.intrinsic_attributes_shared_with_subobjects_which_are_not_ideals,
                    ~.intrinsic_attributes_specific_shared_with_subobjects_which_are_not_ideals ),
            
            ## needed for UpdateObjectsByMorphism
            intrinsic_attributes :=
            Concatenation(
                    LIMOD.intrinsic_attributes,
                    ~.intrinsic_attributes_specific ),
            
            exchangeable_properties :=
            [ 
              "IsZero",
              "IsProjective",
              "IsProjectiveOfConstantRank",
              "IsReflexive",
              "IsTorsionFree",
              "IsTorsion",
              "IsArtinian",
              "IsPure",
              "IsFree",
              "IsStablyFree",
              "IsCyclic",
              "HasConstantRank",
              "IsHolonomic",
              ],
            
            exchangeable_attributes :=
            [ 
              "RankOfObject",
              "ProjectiveDimension",
              "DegreeOfTorsionFreeness",
              "CodegreeOfPurity",
              "Grade",
              ],
            
            )
        );

####################################
#
# logical implications methods:
#
####################################

InstallLogicalImplicationsForHomalgSubobjects(
        List( LIGrMOD.intrinsic_properties_specific_shared_with_subobjects_which_are_not_ideals, ValueGlobal ),
        IsGradedSubmoduleRep and NotConstructedAsAnIdeal,
        HasEmbeddingInSuperObject,
        UnderlyingObject );

InstallLogicalImplicationsForHomalgSubobjects(
        List( LIGrMOD.intrinsic_properties_specific_shared_with_subobjects_and_ideals, ValueGlobal ),
        IsGradedSubmoduleRep and ConstructedAsAnIdeal,
        HasEmbeddingInSuperObject,
        UnderlyingObject );

InstallLogicalImplicationsForHomalgSubobjects(
        List( LIGrMOD.intrinsic_properties_specific_shared_with_factors_modulo_ideals, ValueGlobal ),
        IsGradedSubmoduleRep and ConstructedAsAnIdeal,
        HasFactorObject,
        FactorObject );

InstallLogicalImplicationsForHomalgSubobjects(
        List( LIGrMOD.intrinsic_attributes_specific_shared_with_subobjects_which_are_not_ideals, ValueGlobal ),
        IsGradedSubmoduleRep and NotConstructedAsAnIdeal,
        HasEmbeddingInSuperObject,
        UnderlyingObject );

InstallLogicalImplicationsForHomalgSubobjects(
        List( LIGrMOD.intrinsic_attributes_specific_shared_with_subobjects_and_ideals, ValueGlobal ),
        IsGradedSubmoduleRep and ConstructedAsAnIdeal,
        HasEmbeddingInSuperObject,
        UnderlyingObject );

InstallLogicalImplicationsForHomalgSubobjects(
        List( LIGrMOD.intrinsic_attributes_specific_shared_with_factors_modulo_ideals, ValueGlobal ),
        IsGradedSubmoduleRep and ConstructedAsAnIdeal,
        HasFactorObject,
        FactorObject );

####################################
#
# immediate methods for properties:
#
####################################

##
InstallImmediateMethod( IsZero,
        IsGradedModuleRep and HasAffineDimension, 0,
        
  function( M )
    
    return AffineDimension( M ) <= HOMALG_MODULES.DimensionOfZeroModules;
    
end );

##
InstallImmediateMethodToPullPropertiesOrAttributes(
        IsHomalgGradedModule,
        IsHomalgGradedModule,
        LIGrMOD.exchangeable_properties,
        Concatenation( LIGrMOD.intrinsic_properties, LIGrMOD.intrinsic_attributes ),
        UnderlyingModule );

##
InstallImmediateMethodToPushPropertiesOrAttributes( Twitter,
        IsHomalgGradedModule,
        LIGrMOD.exchangeable_properties,
        UnderlyingModule );

####################################
#
# immediate methods for attributes:
#
####################################

##
InstallImmediateMethodToPullPropertiesOrAttributes(
        IsHomalgGradedModule,
        IsHomalgGradedModule,
        LIGrMOD.exchangeable_attributes,
        Concatenation( LIGrMOD.intrinsic_properties, LIGrMOD.intrinsic_attributes ),
        UnderlyingModule );

##
InstallImmediateMethodToPushPropertiesOrAttributes( Twitter,
        IsHomalgGradedModule,
        LIGrMOD.exchangeable_attributes,
        UnderlyingModule );

# ##
# InstallImmediateMethod( IsModuleOfGlobalSectionsTruncatedAtCertainDegree,
#         IsHomalgGradedModule, 0,
#         
#   function( M )
#     local UM;
#     
#     UM := UnderlyingModule( M );
#     
#     if DegreesOfGenerators( M ) <> [] and HasIsFree( UM ) and IsFree( UM ) then
#         return Minimum( DegreesOfGenerators( M ) );
#     fi;
#     
#     TryNextMethod( );
#     
# end );

# ##
# InstallImmediateMethod( IsModuleOfGlobalSectionsTruncatedAtCertainDegree,
#         IsHomalgGradedModule and HasCastelnuovoMumfordRegularity, 0,
#         
#   function( M )
#     local UM;
#     
#     if DegreesOfGenerators( M ) <> [] and CastelnuovoMumfordRegularity( M ) <= Minimum( DegreesOfGenerators( M ) ) then
#         return Minimum( DegreesOfGenerators( M ) );
#     fi;
#     
#     TryNextMethod( );
#     
# end );

##
InstallImmediateMethod( IsModuleOfGlobalSectionsTruncatedAtCertainDegree,
        IsHomalgGradedModule and HasIsZero and IsZero, 0,
        
  function( M )
    local UM;
    
    return true;
    
end );

####################################
#
# methods for properties:
#
####################################

##
InstallMethod( IsZero,
        "LIGrMOD: for homalg graded modules",
        [ IsGradedModuleRep ],
        
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
    
    RP := homalgTable( UnderlyingNonGradedRing( R ) );
    
    if IsBound( RP!.AffineDimension ) or
       IsBound( RP!.CoefficientsOfUnreducedNumeratorOfHilbertPoincareSeries ) or
       IsBound( RP!.CoefficientsOfNumeratorOfHilbertPoincareSeries ) then
        
        ## hand over to UnderlyingModule;
        ## this avoids the unnecessary degree calls triggered by AffineDimension( M ) below
        TryNextMethod( );
        
    fi;
    
    if not ( IsBound( RP!.CoefficientsOfUnreducedNumeratorOfWeightedHilbertPoincareSeries ) or
             IsBound( RP!.CoefficientsOfNumeratorOfWeightedHilbertPoincareSeries ) ) then
        TryNextMethod( );
    fi;
    
    return AffineDimension( M ) <= HOMALG_MODULES.DimensionOfZeroModules;
    
end );

##
# Fallback, works in general
InstallMethod( IsArtinian,
        "LIGrMOD: for homalg graded modules",
        [ IsGradedModuleRep ], -10,
        
  function( M )
    
    return IsEmptyMatrix( GeneratorsOfHomogeneousPart( HomalgElementToInteger( CastelnuovoMumfordRegularity( M ) ) + 1, M ) );
    
end );

##
# faster, needs a field as CoefficientsRing and a medthod AffineDimension
InstallMethod( IsArtinian,
        "LIGrMOD: for homalg graded modules",
        [ IsGradedModuleRep ],

  function( M )
    local S, R, K, RP;
    
    if IsZero( M ) then
        return true;
    fi;
    
    S := HomalgRing( M );
    R := UnderlyingNonGradedRing( S );
    K := CoefficientsRing( R );
    
    if not ( HasIsFieldForHomalg( K ) and IsFieldForHomalg( K ) ) then
        TryNextMethod( );
    fi;
    
    RP := homalgTable( R );
    
    if not IsBound( RP!.AffineDimension ) then
        TryNextMethod( );
    fi;
    
    return AffineDimension( M ) <= 0;
    
end );

##
InstallMethod( IsCohenMacaulay,
        "LIGrMOD: for homalg graded modules",
        [ IsGradedModuleRep ],
        
  function( M )
    local S, m;
    
    S := HomalgRing( M );
    
    if IsHomalgLeftObjectOrMorphismOfLeftObjects( M ) then
        m := MaximalGradedLeftIdeal( S );
    else
        m := MaximalGradedRightIdeal( S );
    fi;
    
    return AffineDimension( M ) = Grade( m, M );
    
end );

####################################
#
# methods for attributes:
#
####################################

##
InstallMethod( Annihilator,
        "for homalg graded modules",
        [ IsGradedModuleRep ],
        
  function( M )
    
    return GradedModule( Annihilator( UnderlyingModule( M ) ), HomalgRing( M ) );
    
end );

##
InstallMethod( BettiTable,
        "LIGrMOD: for homalg graded modules",
        [ IsHomalgGradedModule ],
        
  function( M )
    local C, degrees, min, C_degrees, l, ll, r, beta;
    
    ## M = coker( F_0 <-- F_1 )
    C := Resolution( 1, M );
    
    ## [ F_0, F_1 ];
    C := ObjectsOfComplex( C ){[ 1 .. 2 ]};
    
    ## the list of generators degrees of F_0 and F_1
    degrees := List( C, DegreesOfGenerators );
    degrees := List( degrees, i -> List( i, HomalgElementToInteger ) );
    
    ## the homological degrees of the resolution complex C: F_0 <- F_1
    C_degrees := [ 0 .. 1 ];
    
    ## a counting list
    l := [ 1 .. Length( C_degrees ) ];
    
    ## the non-empty list
    ll := Filtered( l, j -> degrees[j] <> [ ] );
    
    ## the degree of the lowest row in the Betti diagram
    if ll <> [ ] then
        r := MaximumList( List( ll, j -> MaximumList( degrees[j] ) - ( j - 1 ) ) );
    else
        r := 0;
    fi;
    
    ## the lowest generator degree of F_0
    if degrees[1] <> [ ] then
        min := MinimumList( degrees[1] );
    else
        min := r;
    fi;
    
    ## the row range of the Betti diagram
    r := [ min .. r ];
    
    ## the Betti table
    beta := List( r, i -> List( l, j -> Length( Filtered( degrees[j], a -> a = i + ( j - 1 ) ) ) ) );
    
    return HomalgBettiTable( beta, r, C_degrees, M );
    
end );

##
InstallMethod( CastelnuovoMumfordRegularity,
        "LIGrMOD: for homalg graded modules",
        [ IsGradedModuleRep ],
        
  function( M )
    local S, betti, degrees, B, nS, nB, max, B_S, B2, l;
    
    S := HomalgRing( M );
    
    ## TODO: Every ring should have a base ring
    if not HasBaseRing( S ) or IsIdenticalObj( BaseRing( S ), CoefficientsRing( S ) ) then
        
        if IsZero( M ) then
            return -999999;
        ## do not use IsQuasiZero unless it does not fall back to CastelnuovoMumfordRegularity
        elif AffineDimension( M ) = 0 then
            return Degree( HilbertPoincareSeries( M ) );
        fi;
        
        betti := BettiTable( Resolution( M ) );
        
        degrees := RowDegreesOfBettiTable( betti );
        
        return degrees[Length(degrees)];
        
    fi;
    
    B := BaseRing( S );
    
    nS := Length( Indeterminates( S ) );
    nB := Length( Indeterminates( B ) );
    
    if IsHomalgLeftObjectOrMorphismOfLeftObjects( M ) then
        max := CertainRows( MaximalIdealAsColumnMatrix( S ), [ nB+1 .. nS ] );
        B_S := LeftPresentationWithDegrees( max );
    else
        max := CertainColumns( MaximalIdealAsRowMatrix( S ), [ nB+1 .. nS ] );
        B_S := RightPresentationWithDegrees( max );
    fi;
    
    # Computations with the residue class rings are inefficient
    # a method working more fast and in general should be implemented after the graduations module is a module and not a list
    B2 := S / max;
    SetWeightsOfIndeterminates( B2, WeightsOfIndeterminates( B ) );
    
    l := List( [ 0 .. nS ], i-> HomalgElementToInteger( CastelnuovoMumfordRegularity( B2 * Tor( i, B_S, M ) ) ) - i );
    
    return Maximum( l );
    
end );

##
InstallMethod( CastelnuovoMumfordRegularity,
        "LIGrMOD: for homalg graded free modules",
        [ IsGradedModuleRep ],10,
        
  function( M )
    local UM, deg;
    
    UM := UnderlyingModule( M );
    
    if HasIsFree( UM ) and IsFree( UM ) then
        if HasIsZero( M ) and IsZero( M ) then
            # todo: -infinity
            return -999999;
        fi;
        deg := DegreesOfGenerators( M );
        if IsList( deg ) and ( IsInt( deg[1] ) or IsHomalgElement( deg[ 1 ] ) ) then
            return Maximum( deg );
        fi;
    fi;
    
    TryNextMethod( );
    
end );

##
InstallMethod( CastelnuovoMumfordRegularityOfSheafification,
        "LIGrMOD: for homalg graded modules",
        [ IsGradedModuleRep ],
        
  function( M )
    local min_deg, CMreg;
    
    ## we cannot expect this to be less or equal to the
    ## Castelnuovo-Mumford regularity of the sheafification
    min_deg := Minimum( DegreesOfGenerators( M ) );
    
    CMreg := CastelnuovoMumfordRegularity( M );
    
    TateResolution( M, min_deg, CMreg );
    
    if HasCastelnuovoMumfordRegularityOfSheafification( M ) then
        return CastelnuovoMumfordRegularityOfSheafification( M );
    fi;
    
    TryNextMethod( );
    
end );

##
InstallMethod( LinearRegularity,
        "LIGrMOD: for homalg graded modules",
        [ IsGradedModuleRep ],
        
  function( M )
    local S, dim, betti, cols, degrees, col0, col1, mat, rows, d0, d1;
    
    S := HomalgRing( M );
    
    ## TODO: Every ring should have a base ring
    if HasBaseRing( S ) and not IsIdenticalObj( BaseRing( S ), CoefficientsRing( S ) ) then
        TryNextMethod( );
    fi;
    
    if IsZero( M ) then
        return -999999;
        ## do not use IsQuasiZero unless it does not fall back to CastelnuovoMumfordRegularity
    elif AffineDimension( M ) = 0 then
        return Degree( HilbertPoincareSeries( M ) );
    fi;
    
    if HasRelativeIndeterminatesOfPolynomialRing( S ) then
        dim := Length( RelativeIndeterminatesOfPolynomialRing( S ) );
    else
        dim := Length( IndeterminatesOfPolynomialRing( S ) );
    fi;
    
    betti := BettiTable( Resolution( M ) );
    
    cols := ColumnDegreesOfBettiTable( betti );
    cols := Intersection2( cols, [ dim - 1, dim ] );
    
    if IsEmpty( cols ) then
        return -999999;
    fi;
    
    degrees := RowDegreesOfBettiTable( betti );
    
    ## 0 stands for Ext^0
    col0 := Intersection2( cols, [ dim ] );
    col0 := col0 + 1;
    
    if not IsEmpty( col0 ) then
        
        mat := List( betti!.matrix, b -> b{col0} );
        
        rows := Filtered( [ 1 .. Length( mat ) ], a -> not IsZero( mat[a] ) );
        
        if not IsEmpty( rows ) then
            
            degrees := degrees{rows};
            
            d0 := degrees[Length( degrees )];
            
        fi;
        
    fi;
    
    ## 1 stand for Ext^1
    col1 := Intersection2( cols, [ dim - 1 ] );
    col1 := col1 + 1;
    
    if not IsEmpty( col1 ) then
        
        mat := List( betti!.matrix, b -> b{col1} );
        
        rows := Filtered( [ 1 .. Length( mat ) ], a -> not IsZero( mat[a] ) );
        
        if not IsEmpty( rows ) then
            
            degrees := degrees{rows};
            
            d1 := degrees[Length( degrees )] - 1;
            
        fi;
        
    fi;
    
    if not IsBound( d0 ) then
        return d1;
    elif not IsBound( d1 ) then
        return d0;
    fi;
    
    return Maximum( d0, d1 );
    
end );

##
InstallMethod( Depth,
        "LIMOD: for two homalg modules",
        [ IsGradedModuleRep, IsGradedModuleRep ],
        
  function( M, N )
    
    return Depth( UnderlyingModule( M ), UnderlyingModule( N ) );
    
end );

##
InstallMethod( ResidueClassRing,
        "for homalg ideals",
        [ IsGradedSubmoduleRep and ConstructedAsAnIdeal ],
        
  function( J )
    local S, R, RR, result, A;
    
    S := HomalgRing( J );
    
    R := UnderlyingNonGradedRing( S );
    
    Assert( 3, not J = S );
    
    RR := ResidueClassRing( UnderlyingModule( J ) );
    
    ## do not do this, use the given J
    #J := GradedModule( DefiningIdeal( RR ), S );
    
    result := GradedRing( RR );
    
    if HasContainsAField( S ) and ContainsAField( S ) then
        SetContainsAField( result, true );
        if HasCoefficientsRing( S ) then
            SetCoefficientsRing( result, CoefficientsRing( S ) );
        fi;
    fi;
    
    SetDefiningIdeal( result, J );
    
    if HasAmbientRing( S ) then
        A := AmbientRing( S );
    elif HasAmbientRing( R ) then
        A := GradedRing( AmbientRing( R ) );
    else
        A := S;
    fi;
    
    SetAmbientRing( result, A );
    SetRingRelations( result, A * RingRelations( RR ) );
    
    return result;
    
end );

##
InstallMethod( FullSubobject,
        "for homalg graded modules",
        [ IsGradedModuleRep ],
        
  function( M )
    local subobject;
    
    if HasIsFree( UnderlyingModule( M ) ) and IsFree( UnderlyingModule( M ) ) then
        subobject := ImageSubobject( TheIdentityMorphism( M ) );
    else
        subobject := ImageSubobject( GradedMap( FullSubobject( UnderlyingModule( M ) )!.map_having_subobject_as_its_image, "create", M ) );
    fi;
    
    SetEmbeddingInSuperObject( subobject, TheIdentityMorphism( M ) );
    
    return subobject;
    
end );

##
InstallMethod( ZeroSubobject,
        "for homalg graded modules",
        [ IsGradedModuleRep ],
        
  function( M )
    local alpha;
    
    alpha := ZeroSubobject( UnderlyingModule( M ) )!.map_having_subobject_as_its_image;
    
    return UnderlyingSubobject( ImageObject( GradedMap( alpha, "create", M ) ) );
    
end );

##
InstallMethod( ZerothRegularity,
        "for homalg graded modules",
        [ IsGradedModuleRep ],
        
  function( M )
    local B, r_min, r_max, c, last_column, reg, i, j;
    
    B := BettiTable( Resolution( M ) );
    
    r_min := HomalgElementToInteger( RowDegreesOfBettiTable( B )[ 1 ] );
    r_max := HomalgElementToInteger( RowDegreesOfBettiTable( B )[ Length( RowDegreesOfBettiTable( B ) ) ] );
    c := Length( ColumnDegreesOfBettiTable( B ) );
    
    last_column := List( MatrixOfDiagram( B ), function( a ) return a[c]; end );
    
    reg := r_min;
    for i in [ r_min + 1 .. r_max ] do
        j := i - r_min + 1;
        if not IsZero( last_column[j] ) then
            reg := i;
        fi;
    od;
    
    return reg;
    
end );

##
InstallMethod( TrivialArtinianSubmodule,
        "for homalg graded modules",
        [ IsGradedModuleRep ],
        
  function( M )
    local S, k;
    
    S := HomalgRing( M );
    
    if IsHomalgLeftObjectOrMorphismOfLeftObjects( M ) then
        k := ResidueClassRingAsGradedLeftModule( S );
    else
        k := ResidueClassRingAsGradedRightModule( S );
    fi;
    
    return IsZero( GradedHom( k, M ) );
    
end );

##
InstallMethod( CoefficientsOfUnreducedNumeratorOfHilbertPoincareSeries,
        "for a homalg graded module",
        [ IsGradedModuleRep ],
        
  function( M )
    local R, weights, degrees;
    
    R := HomalgRing( M );
    
    weights := WeightsOfIndeterminates( R );
    
    weights := List( weights, HomalgElementToInteger );
    
    degrees := DegreesOfGenerators( M );
    
    degrees := List( degrees, HomalgElementToInteger );
    
    return CoefficientsOfUnreducedNumeratorOfHilbertPoincareSeries( UnderlyingModule( M ), weights, degrees );
    
end );

##
InstallMethod( CoefficientsOfNumeratorOfHilbertPoincareSeries,
        "for a homalg graded module",
        [ IsGradedModuleRep ],
        
  CoefficientsOfNumeratorOfHilbertPoincareSeries_ViaBettiTableOfMinimalFreeResolution );

##
InstallMethod( CoefficientsOfNumeratorOfHilbertPoincareSeries,
        "for a homalg graded module",
        [ IsGradedModuleRep ],
        
  function( M )
    local R, weights, degrees, coeffs;
    
    R := HomalgRing( M );
    
    weights := List( WeightsOfIndeterminates( R ), HomalgElementToInteger );
    
    degrees := List( DegreesOfGenerators( M ), HomalgElementToInteger );
    
    coeffs := CoefficientsOfNumeratorOfHilbertPoincareSeries( UnderlyingModule( M ), weights, degrees );
    
    if coeffs = fail then
        TryNextMethod( );
    fi;
    
    return coeffs;
    
end );

##
InstallMethod( UnreducedNumeratorOfHilbertPoincareSeries,
        "for a homalg graded module and a ring element",
        [ IsGradedModuleRep, IsRingElement ],
        
  function( M, lambda )
    local R, weights, degrees;
    
    R := HomalgRing( M );
    
    weights := WeightsOfIndeterminates( R );
    
    weights := List( weights, HomalgElementToInteger );
    
    degrees := DegreesOfGenerators( M );
    
    degrees := List( degrees, HomalgElementToInteger );
    
    return UnreducedNumeratorOfHilbertPoincareSeries( UnderlyingModule( M ), weights, degrees, lambda );
    
end );

##
InstallMethod( UnreducedNumeratorOfHilbertPoincareSeries,
        "for a homalg graded module",
        [ IsGradedModuleRep ],
        
  function( M )
    
    return UnreducedNumeratorOfHilbertPoincareSeries( M, VariableForHilbertPoincareSeries( ) );
    
end );

##
InstallMethod( NumeratorOfHilbertPoincareSeries,
        "for a homalg graded module and a ring element",
        [ IsGradedModuleRep, IsRingElement ],
        
  function( M, lambda )
    local R, weights, degrees;
    
    R := HomalgRing( M );
    
    weights := List( WeightsOfIndeterminates( R ), HomalgElementToInteger );
    
    degrees := List( DegreesOfGenerators( M ), HomalgElementToInteger );
    
    return NumeratorOfHilbertPoincareSeries( UnderlyingModule( M ), weights, degrees, lambda );
    
end );

##
InstallMethod( NumeratorOfHilbertPoincareSeries,
        "for a homalg graded module",
        [ IsGradedModuleRep ],
        
  function( M )
    
    return NumeratorOfHilbertPoincareSeries( M, VariableForHilbertPoincareSeries( ) );
    
end );

##
InstallMethod( HilbertPoincareSeries,
        "for a homalg graded module",
        [ IsGradedModuleRep, IsRingElement ],
        
  HilbertPoincareSeries_ViaBettiTableOfMinimalFreeResolution );

##
InstallMethod( HilbertPoincareSeries,
        "for a homalg graded module",
        [ IsGradedModuleRep, IsRingElement ],
        
  function( M, lambda )
    local R, weights, degrees, series;
    
    R := HomalgRing( M );
    
    weights := List( WeightsOfIndeterminates( R ), HomalgElementToInteger );
    
    degrees := List( DegreesOfGenerators( M ), HomalgElementToInteger );
    
    series := HilbertPoincareSeries( UnderlyingModule( M ), weights, degrees, lambda );
    
    if series = fail then
        TryNextMethod( );
    fi;
    
    return series;
    
end );

##
InstallMethod( HilbertPoincareSeries,
        "for a homalg graded module",
        [ IsGradedModuleRep ],
        
  function( M )
    
    return HilbertPoincareSeries( M, VariableForHilbertPoincareSeries( ) );
    
end );

##
InstallMethod( HilbertPoincareSeries,
        "for a Betti diagram, an integer, and a ring element",
        [ IsBettiTable, IsInt, IsRingElement ],
        
  function( betti, n, s )
    local row_range, col_range, r, hilb;
    
    row_range := RowDegreesOfBettiTable( betti );
    col_range := ColumnDegreesOfBettiTable( betti );
    
    r := Length( row_range );
    
    betti := MatrixOfDiagram( betti );
    
    hilb := 1 / ( 1 - s )^n *
            Sum( col_range, i ->
                 (-1)^i *
                 Sum( [ 1 .. r ], k ->
                      betti[k][i + 1] * s^(i + row_range[k])
                      )
                 );
    
    return hilb;
    
end );

##
InstallMethod( HilbertPoincareSeries,
               [ IsBettiTable, IsHomalgElement, IsRingElement ],
               
  function( betti, n, s )
    
    return HilbertPoincareSeries( betti, HomalgElementToInteger( n ), s );
    
end );

##
InstallMethod( HilbertPoincareSeries,
        "for a Betti diagram and an integer",
        [ IsBettiTable, IsInt ],
        
  function( betti, n )
    local s;
    
    s := VariableForHilbertPoincareSeries( );
    
    return HilbertPoincareSeries( betti, n, s );
    
end );

##
InstallMethod( HilbertPoincareSeries,
               [ IsBettiTable, IsHomalgElement ],
               
  function( betti, n )
    
    return HilbertPoincareSeries( betti, HomalgElementToInteger( n ) );
    
end );

##
InstallMethod( HilbertPolynomial,
        "for a homalg graded module",
        [ IsGradedModuleRep, IsRingElement ],
        
  HilbertPolynomial_ViaBettiTableOfMinimalFreeResolution );

##
InstallMethod( HilbertPolynomial,
        "for a homalg graded module",
        [ IsGradedModuleRep, IsRingElement ],
        
  function( M, lambda )
    local R, weights, degrees, hilb;
    
    R := HomalgRing( M );
    
    weights := List( WeightsOfIndeterminates( R ), HomalgElementToInteger );
    
    degrees := List( DegreesOfGenerators( M ), HomalgElementToInteger );
    
    hilb := HilbertPolynomial( UnderlyingModule( M ), weights, degrees, lambda );
    
    if hilb = fail then
        TryNextMethod( );
    fi;
    
    return hilb;
    
end );

##
InstallMethod( HilbertPolynomial,
        "for a homalg graded module",
        [ IsGradedModuleRep ],
        
  function( M )
    
    return HilbertPolynomial( M, VariableForHilbertPolynomial( ) );
    
end );

##
InstallMethod( HilbertPolynomial,
        "for a Betti diagram, an integer, and a ring element",
        [ IsBettiTable, IsInt, IsRingElement ],
        
  function( betti, n, s )
    local series;
    
    series := HilbertPoincareSeries( betti, n, s );
    
    return HilbertPolynomialOfHilbertPoincareSeries( series );
    
end );

##
InstallMethod( HilbertPolynomial,
        "for a Betti diagram and an integer",
        [ IsBettiTable, IsInt ],
        
  function( betti, n )
    local t;
    
    t := VariableForHilbertPolynomial( );
    
    return HilbertPolynomial( betti, n, t );
    
end );

##
InstallMethod( HilbertPolynomial,
               [ IsBettiTable, IsHomalgElement, IsRingElement ],
               
  function( betti, n, s )
    
    return HilbertPolynomial( betti, HomalgElementToInteger( n ), s );
    
end );

##
InstallMethod( HilbertPolynomial,
               [ IsBettiTable, IsHomalgElement ],
               
  function( betti, n )
    
    return HilbertPolynomial( betti, HomalgElementToInteger( n ) );
    
end );

## for CASs which do not support Hilbert* for non-graded modules
InstallMethod( AffineDimension,
        "for a homalg graded module",
        [ IsGradedModuleRep ],
        
  function( M )
    local R, weights, degrees;
    
    R := HomalgRing( M );
    
    weights := List( WeightsOfIndeterminates( R ), HomalgElementToInteger );
    
    degrees := List( DegreesOfGenerators( M ), HomalgElementToInteger );
    
    return AffineDimension( UnderlyingModule( M ), weights, degrees );
    
end );

##
InstallMethod( AffineDegree,
        "for a homalg graded module",
        [ IsGradedModuleRep ],
        
  function( M )
    local R, weights, degrees;
    
    R := HomalgRing( M );
    
    weights := List( WeightsOfIndeterminates( R ), HomalgElementToInteger );
    
    degrees := List( DegreesOfGenerators( M ), HomalgElementToInteger );
    
    return AffineDegree( UnderlyingModule( M ), weights, degrees );
    
end );

##
InstallMethod( ProjectiveDegree,
        "for a homalg graded module",
        [ IsGradedModuleRep ],
        
  function( M )
    local R, weights, degrees;
    
    R := HomalgRing( M );
    
    weights := List( WeightsOfIndeterminates( R ), HomalgElementToInteger );
    
    degrees := List( DegreesOfGenerators( M ), HomalgElementToInteger );
    
    return ProjectiveDegree( UnderlyingModule( M ), weights, degrees );
    
end );

##
InstallMethod( ConstantTermOfHilbertPolynomial,
        "for a homalg graded module",
        [ IsGradedModuleRep ],
        
  function( M )
    local R, weights, degrees;
    
    R := HomalgRing( M );
    
    weights := List( WeightsOfIndeterminates( R ), HomalgElementToInteger );
    
    degrees := List( DegreesOfGenerators( M ), HomalgElementToInteger );
    
    return ConstantTermOfHilbertPolynomial( UnderlyingModule( M ), weights, degrees );
    
end );

##
InstallGlobalFunction( HilbertPoincareSeries_ViaBettiTableOfMinimalFreeResolution,
  function( arg )
    local M, s, betti, n;
    
    if Length( arg ) > 0 then
        M := arg[1];
    else
        Error( "empty arguments\n" );
    fi;
    
    if Length( arg ) > 1 and IsRingElement( arg[2] ) then
        s := arg[2];
    else
        s := VariableForHilbertPoincareSeries( );
    fi;
    
    if IsZero( M ) then
        return 0 * s;
    fi;
    
    betti := BettiTable( Resolution( M ) );
    
    n := Length( IndeterminatesOfPolynomialRing( HomalgRing( M ) ) );
    
    return HilbertPoincareSeries( betti, n, s );
    
end );

##
InstallGlobalFunction( CoefficientsOfNumeratorOfHilbertPoincareSeries_ViaBettiTableOfMinimalFreeResolution,
  function( M )
    local series;
    
    series := HilbertPoincareSeries_ViaBettiTableOfMinimalFreeResolution( M );
    
    return CoefficientsOfNumeratorOfHilbertPoincareSeries( series );
    
end );

##
InstallGlobalFunction( HilbertPolynomial_ViaBettiTableOfMinimalFreeResolution,
  function( arg )
    local series;
    
    series := CallFuncList( HilbertPoincareSeries_ViaBettiTableOfMinimalFreeResolution, arg );
    
    return HilbertPolynomialOfHilbertPoincareSeries( series );
    
end );

##
InstallMethod( PrimaryDecomposition,
        "for homalg graded modules",
        [ IsGradedModuleRep ],
        
  function( M )
    
    return
      List( PrimaryDecomposition( UnderlyingModule( M ) ),
            function( pp )
              local primary, prime;
              
              ##FIXME: fix the degrees
              primary := ImageSubobject( GradedMap( pp[1]!.map_having_subobject_as_its_image, "create", "create", HomalgRing( M ) ) );
              prime := ImageSubobject( GradedMap( pp[2]!.map_having_subobject_as_its_image, "create", "create", HomalgRing( M ) ) );
              
              return [ primary, prime ];
              
            end
          );
    
end );

##
InstallMethod( RadicalDecomposition,
        "for homalg graded modules",
        [ IsGradedModuleRep ],
        
  function( M )
    
    return
      List( RadicalDecomposition( UnderlyingModule( M ) ),
            function( pp )
              
              ##FIXME: fix the degrees
              return ImageSubobject( GradedMap( pp!.map_having_subobject_as_its_image, "create", "create", HomalgRing( M ) ) );
              
            end
          );
    
end );

##
InstallMethod( ModuleOfKaehlerDifferentials,
        "for homalg rings",
        [ IsHomalgRing and HasRingRelations ],
        
  function( R )
    local A, var, I, jac;
    
    A := AmbientRing( R );
    
    if not ( HasIsFreePolynomialRing( A ) and IsFreePolynomialRing( A ) ) then
        TryNextMethod( );
    fi;
    
    var := Indeterminates( A );
    
    var := HomalgMatrix( var, 1, Length( var ), A );
    
    I := MatrixOfRelations( R );
    
    jac := R * Diff( var, I );
    
    return LeftPresentation( jac );
    
end );

##
InstallMethod( ModuleOfKaehlerDifferentials,
        "for homalg rings",
        [ IsHomalgGradedRingRep and HasRingRelations ],
        
  function( S )
    local R, K;
    
    R := UnderlyingNonGradedRing( S );
    
    K := ModuleOfKaehlerDifferentials( R );
    
    return GradedModule( K, S );
    
end );

##
InstallMethod( SymmetricAlgebra,
        "for a homalg matrix",
        [ IsHomalgMatrixOverGradedRingRep, IsList ],
        
  function( M, gvar )
    local n, R, Sym, weights, rel;
    
    n := NrColumns( M );
    
    if not n = Length( gvar ) then
        Error( "the length of the list of variables is ",
               "not equal to the number of columns of the matrix\n" );
    fi;
    
    R := HomalgRing( M );
    Sym := R * gvar;
    
    weights := Concatenation(
                       ListWithIdenticalEntries( Length( Indeterminates( R ) ), 0 ),
                       ListWithIdenticalEntries( Length( gvar ), 1 ) );
    
    SetWeightsOfIndeterminates( Sym, weights );
    
    gvar := RelativeIndeterminatesOfPolynomialRing( Sym );
    gvar := HomalgMatrix( gvar, Length( gvar ), 1, Sym );
    
    rel := GradedLeftSubmodule( ( Sym * M ) * gvar );
    
    Sym := Sym / rel;
    
    SetDefiningIdeal( Sym, rel );
    
    return Sym;
    
end );

##
InstallMethod( ExteriorAlgebra,
        "for a homalg matrix",
        [ IsHomalgMatrixOverGradedRingRep, IsList ],
        
  function( M, gvar )
    local n, R, S, weights, A, rel;
    
    n := NrColumns( M );
    
    if not n = Length( gvar ) then
        Error( "the length of the list of variables is ",
               "not equal to the number of columns of the matrix\n" );
    fi;
    
    R := HomalgRing( M );
    S := R * List( gvar, v -> Concatenation( "XX", v ) );
    
    weights := Concatenation(
                       ListWithIdenticalEntries( Length( Indeterminates( R ) ), 0 ),
                       ListWithIdenticalEntries( Length( gvar ), -1 ) );
    
    SetWeightsOfIndeterminates( S, weights );
    
    A := KoszulDualRing( S, gvar );
    
    gvar := IndeterminateAntiCommutingVariablesOfExteriorRing( A );
    gvar := HomalgMatrix( gvar, Length( gvar ), 1, A );
    
    rel := GradedLeftSubmodule( ( A * M ) * gvar );
    
    A := A / rel;
    
    SetDefiningIdeal( A, rel );
    
    return A;
    
end );

##
InstallMethod( SymmetricPower,
        "for free modules",
        [ IsInt, IsGradedModuleRep and IsFree ],
        
  function( k, M )
    local R, r, degrees, l, P, powers;
    
    if HasSymmetricPowers( M ) then
        powers := SymmetricPowers( M );
    else
        powers := rec( );
    fi;
    
    if IsBound( powers!.( k ) ) then
        return powers!.( k );
    fi;
    
    R := HomalgRing( M );
    r := Rank( M );
    
    degrees := DegreesOfGenerators( M );
    
    l := Length( degrees );
    
    if k in [ 0 .. l ] then
        degrees := List( UnorderedTuples( [ 1 .. l ], k ),
                     i -> Sum( degrees{i} ) );
    else
        degrees := [ ];
    fi;
    
    if IsHomalgLeftObjectOrMorphismOfLeftObjects( M ) then
        P := FreeLeftModuleWithDegrees( R, degrees );
    else
        P := FreeRightModuleWithDegrees( R, degrees );
    fi;
    
    SetIsSymmetricPower( P, true );
    SetSymmetricPowerExponent( P, k );
    SetSymmetricPowerBaseModule( P, M );
    
    powers!.( k ) := P;
    SetSymmetricPowers( M, powers );
    
    return P;
end );

##
InstallMethod( SymmetricPower,
        "for graded modules",
        [ IsInt, IsGradedModuleRep ],
        
  function( k, M )
    local phi, T;
    
    if k = 0 then
        return One( M );
    elif k = 1 then
        return M;
    elif not k in [ 2 .. NrGenerators( M ) ] then
        return Zero( M );
    fi;
    
    phi := PresentationMorphism( M );
    
    T := SymmetricPower( k, Range( phi ) );
    
    phi := SymmetricPowerOfPresentationMorphism( k, phi );
    
    phi := GradedMap( phi, "free", T );
    
    return Cokernel( phi );
    
end );

##
InstallMethod( ExteriorPower,
        "for free modules",
        [ IsInt, IsGradedModuleRep and IsFree ],
        
  function( k, M )
    local R, r, degrees, l, P, powers;
    
    if HasExteriorPowers( M ) then
        powers := ExteriorPowers( M );
    else
        powers := rec( );
    fi;
    
    if IsBound( powers!.( k ) ) then
        return powers!.( k );
    fi;
    
    R := HomalgRing( M );
    r := Rank( M );
    
    degrees := DegreesOfGenerators( M );
    
    l := Length( degrees );
    
    if k in [ 0 .. l ] then
        degrees := List( Combinations( [ 1 .. l ], k ),
                     i -> Sum( degrees{i} ) );
    else
        degrees := [ ];
    fi;
    
    if IsHomalgLeftObjectOrMorphismOfLeftObjects( M ) then
        P := FreeLeftModuleWithDegrees( R, degrees );
    else
        P := FreeRightModuleWithDegrees( R, degrees );
    fi;
    
    SetIsExteriorPower( P, true );
    SetExteriorPowerExponent( P, k );
    SetExteriorPowerBaseModule( P, M );
    
    powers!.( k ) := P;
    SetExteriorPowers( M, powers );
    
    return P;
end );

##
InstallMethod( ExteriorPower,
        "for a graded map",
        [ IsInt, IsMapOfGradedModulesRep ],
        
  function( k, phi )
    local S, T, mat;
    
    S := Source( phi );
    T := Range( phi );
    
    mat := MatrixOfMap( phi );
    
    S := ExteriorPower( k, S );
    T := ExteriorPower( k, T );
    
    mat := ExteriorPower( k, mat );
    
    return GradedMap( mat, S, T );
    
end );

##
InstallMethod( ExteriorPower,
        "for graded modules",
        [ IsInt, IsGradedModuleRep ],
        
  function( k, M )
    local phi, T;
    
    if k = 0 then
        return One( M );
    elif k = 1 then
        return M;
    elif not k in [ 2 .. NrGenerators( M ) ] then
        return Zero( M );
    fi;
    
    phi := PresentationMorphism( M );
    
    T := ExteriorPower( k, Range( phi ) );
    
    phi := ExteriorPowerOfPresentationMorphism( k, phi );
    
    phi := GradedMap( phi, "free", T );
    
    return Cokernel( phi );
    
end );
