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
              ],
            
            ## used in a InstallLogicalImplicationsForHomalgSubobjects call below
            intrinsic_properties_specific_shared_with_factors_modulo_ideals :=
            [ 
              "AffineDimension",
              "AffineDegree",
              "ProjectiveDegree",
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
              "BettiDiagram",
              "CastelnuovoMumfordRegularity",
              ],
            
            ## used in a InstallLogicalImplicationsForHomalgSubobjects call below
            intrinsic_attributes_specific_shared_with_factors_modulo_ideals :=
            [ 
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

##
InstallImmediateMethod( IsModuleOfGlobalSectionsTruncatedAtCertainDegree,
        IsHomalgGradedModule, 0,
        
  function( M )
    local UM;
    
    UM := UnderlyingModule( M );
    
    if DegreesOfGenerators( M ) <> [] and HasIsFree( UM ) and IsFree( UM ) then
        return Minimum( DegreesOfGenerators( M ) );
    fi;
    
    TryNextMethod( );
    
end );

##
InstallImmediateMethod( IsModuleOfGlobalSectionsTruncatedAtCertainDegree,
        IsHomalgGradedModule and HasCastelnuovoMumfordRegularity, 0,
        
  function( M )
    local UM;
    
    if DegreesOfGenerators( M ) <> [] and CastelnuovoMumfordRegularity( M ) <= Minimum( DegreesOfGenerators( M ) ) then
        return Minimum( DegreesOfGenerators( M ) );
    fi;
    
    TryNextMethod( );
    
end );

##
InstallImmediateMethod( IsModuleOfGlobalSectionsTruncatedAtCertainDegree,
        IsHomalgGradedModule and HasIsZero and IsZero, 0,
        
  function( M )
    local UM;
    
    return -999999;
    
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
    
    return IsEmptyMatrix( BasisOfHomogeneousPart( CastelnuovoMumfordRegularity( M ) + 1, M ) );
    
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
InstallMethod( BettiDiagram,
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
    
    return HomalgBettiDiagram( beta, r, C_degrees, M );
    
end );

##
InstallMethod( CastelnuovoMumfordRegularity,
        "LIGrMOD: for homalg graded modules",
        [ IsGradedModuleRep ],
        
  function( M )
    local betti, degrees;
    
    betti := BettiDiagram( Resolution( M ) );
    
    degrees := RowDegreesOfBettiDiagram( betti );
    
    return degrees[Length(degrees)];
    
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
        if IsList( deg ) and IsInt( deg[1] ) then
            return Maximum( deg );
        fi;
    fi;
    
    TryNextMethod( );
    
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
    local S, result;
    
    S := HomalgRing( J );
    
    Assert( 1, not J = S );
    
    result := GradedRing( ResidueClassRing( UnderlyingModule( J ) ) );
    
    if HasContainsAField( S ) and ContainsAField( S ) then
        SetContainsAField( result, true );
        if HasCoefficientsRing( S ) then
            SetCoefficientsRing( result, CoefficientsRing( S ) );
        fi;
    fi;
    
    SetDefiningIdeal( result, J );
    
    if HasAmbientRing( S ) then
      SetAmbientRing( result, AmbientRing( S ) );
    else
      SetAmbientRing( result, S );
    fi;
    
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
    
    B := BettiDiagram( Resolution( M ) );
    
    r_min := RowDegreesOfBettiDiagram( B )[ 1 ];
    r_max := RowDegreesOfBettiDiagram( B )[ Length( RowDegreesOfBettiDiagram( B ) ) ];
    c := Length( ColumnDegreesOfBettiDiagram( B ) );
    
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
    
    degrees := DegreesOfGenerators( M );
    
    return CoefficientsOfUnreducedNumeratorOfHilbertPoincareSeries( UnderlyingModule( M ), weights, degrees );
    
end );

##
InstallMethod( CoefficientsOfNumeratorOfHilbertPoincareSeries,
        "for a homalg graded module",
        [ IsGradedModuleRep ],
        
  function( M )
    local R, weights, degrees;
    
    R := HomalgRing( M );
    
    weights := WeightsOfIndeterminates( R );
    
    degrees := DegreesOfGenerators( M );
    
    return CoefficientsOfNumeratorOfHilbertPoincareSeries( UnderlyingModule( M ), weights, degrees );
    
end );

##
InstallMethod( UnreducedNumeratorOfHilbertPoincareSeries,
        "for a homalg graded module and a ring element",
        [ IsGradedModuleRep, IsRingElement ],
        
  function( M, lambda )
    local R, weights, degrees;
    
    R := HomalgRing( M );
    
    weights := WeightsOfIndeterminates( R );
    
    degrees := DegreesOfGenerators( M );
    
    return UnreducedNumeratorOfHilbertPoincareSeries( UnderlyingModule( M ), weights, degrees, lambda );
    
end );

##
InstallMethod( UnreducedNumeratorOfHilbertPoincareSeries,
        "for a homalg graded module",
        [ IsGradedModuleRep ],
        
  function( M )
    
    return UnreducedNumeratorOfHilbertPoincareSeries( M, VariableForHilbertPolynomial( ) );
    
end );

##
InstallMethod( NumeratorOfHilbertPoincareSeries,
        "for a homalg graded module and a ring element",
        [ IsGradedModuleRep, IsRingElement ],
        
  function( M, lambda )
    local R, weights, degrees;
    
    R := HomalgRing( M );
    
    weights := WeightsOfIndeterminates( R );
    
    degrees := DegreesOfGenerators( M );
    
    return NumeratorOfHilbertPoincareSeries( UnderlyingModule( M ), weights, degrees, lambda );
    
end );

##
InstallMethod( NumeratorOfHilbertPoincareSeries,
        "for a homalg graded module",
        [ IsGradedModuleRep ],
        
  function( M )
    
    return NumeratorOfHilbertPoincareSeries( M, VariableForHilbertPolynomial( ) );
    
end );

##
InstallMethod( HilbertPoincareSeries,
        "for a homalg graded module",
        [ IsGradedModuleRep, IsRingElement ],
        
  function( M, lambda )
    local R, weights, degrees;
    
    R := HomalgRing( M );
    
    weights := WeightsOfIndeterminates( R );
    
    degrees := DegreesOfGenerators( M );
    
    return HilbertPoincareSeries( UnderlyingModule( M ), weights, degrees, lambda );
    
end );

##
InstallMethod( HilbertPoincareSeries,
        "for a homalg graded module",
        [ IsGradedModuleRep ],
        
  function( M )
    
    return HilbertPoincareSeries( M, VariableForHilbertPolynomial( ) );
    
end );

##
InstallMethod( HilbertPoincareSeries,
        "for a Betti diagram, an integer, and a ring element",
        [ IsBettiDiagram, IsInt, IsRingElement ],
        
  function( betti, n, s )
    local row_range, col_range, r, hilb;
    
    row_range := RowDegreesOfBettiDiagram( betti );
    col_range := ColumnDegreesOfBettiDiagram( betti );
    
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
        "for a Betti diagram and an integer",
        [ IsBettiDiagram, IsInt ],
        
  function( betti, n )
    local s;
    
    s := VariableForHilbertPolynomial( );
    
    return HilbertPoincareSeries( betti, n, s );
    
end );

##
InstallMethod( HilbertPolynomial,
        "for a homalg graded module",
        [ IsGradedModuleRep, IsRingElement ],
        
  function( M, lambda )
    local R, weights, degrees;
    
    R := HomalgRing( M );
    
    weights := WeightsOfIndeterminates( R );
    
    degrees := DegreesOfGenerators( M );
    
    return HilbertPolynomial( UnderlyingModule( M ), weights, degrees, lambda );
    
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
        [ IsBettiDiagram, IsInt, IsRingElement ],
        
  function( betti, n, s )
    local series;
    
    series := HilbertPoincareSeries( betti, n, s );
    
    return HilbertPolynomialOfHilbertPoincareSeries( series );
    
end );

##
InstallMethod( HilbertPolynomial,
        "for a Betti diagram and an integer",
        [ IsBettiDiagram, IsInt ],
        
  function( betti, n )
    local s;
    
    s := VariableForHilbertPolynomial( );
    
    return HilbertPolynomial( betti, n, s );
    
end );

## for CASs which do not support Hilbert* for non-graded modules
InstallMethod( AffineDimension,
        "for a homalg graded module",
        [ IsGradedModuleRep ],
        
  function( M )
    local R, weights, degrees;
    
    R := HomalgRing( M );
    
    weights := WeightsOfIndeterminates( R );
    
    degrees := DegreesOfGenerators( M );
    
    return AffineDimension( UnderlyingModule( M ), weights, degrees );
    
end );

##
InstallMethod( AffineDegree,
        "for a homalg graded module",
        [ IsGradedModuleRep ],
        
  function( M )
    local R, weights, degrees;
    
    R := HomalgRing( M );
    
    weights := WeightsOfIndeterminates( R );
    
    degrees := DegreesOfGenerators( M );
    
    return AffineDegree( UnderlyingModule( M ), weights, degrees );
    
end );

##
InstallMethod( ProjectiveDegree,
        "for a homalg graded module",
        [ IsGradedModuleRep ],
        
  function( M )
    local R, weights, degrees;
    
    R := HomalgRing( M );
    
    weights := WeightsOfIndeterminates( R );
    
    degrees := DegreesOfGenerators( M );
    
    return ProjectiveDegree( UnderlyingModule( M ), weights, degrees );
    
end );

##
InstallMethod( ConstantTermOfHilbertPolynomial,
        "for a homalg graded module",
        [ IsGradedModuleRep ],
        
  function( M )
    local R, weights, degrees;
    
    R := HomalgRing( M );
    
    weights := WeightsOfIndeterminates( R );
    
    degrees := DegreesOfGenerators( M );
    
    return ConstantTermOfHilbertPolynomial( UnderlyingModule( M ), weights, degrees );
    
end );

##
InstallGlobalFunction( HilbertPoincareSeries_ViaBettiDiagramOfMinimalFreeResolution,
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
        s := VariableForHilbertPolynomial( );
    fi;
    
    if IsZero( M ) then
        return 0 * s;
    fi;
    
    betti := BettiDiagram( Resolution( M ) );
    
    n := Length( IndeterminatesOfPolynomialRing( HomalgRing( M ) ) );
    
    return HilbertPoincareSeries( betti, n, s );
    
end );

##
InstallGlobalFunction( CoefficientsOfNumeratorOfHilbertPoincareSeries_ViaBettiDiagramOfMinimalFreeResolution,
  function( M )
    local series;
    
    series := HilbertPoincareSeries_ViaBettiDiagramOfMinimalFreeResolution( M );
    
    return CoefficientsOfNumeratorOfHilbertPoincareSeries( series );
    
end );

##
InstallGlobalFunction( HilbertPolynomial_ViaBettiDiagramOfMinimalFreeResolution,
  function( arg )
    local series;
    
    series := CallFuncList( HilbertPoincareSeries_ViaBettiDiagramOfMinimalFreeResolution, arg );
    
    return HilbertPolynomialOfHilbertPoincareSeries( series );
    
end );

##
InstallMethod( PrimaryDecomposition,
        "for homalg graded modules",
        [ IsGradedModuleRep ],
        
  function( M )
    local degrees, graded, tr, subobject, mat, primary_decomposition;
    
    primary_decomposition := PrimaryDecomposition( UnderlyingModule( M ) );
    
    primary_decomposition :=
      List( primary_decomposition,
            function( pp )
              local primary, prime;
              
              ##FIXME: fix the degrees
              primary := ImageSubobject( GradedMap( pp[1]!.map_having_subobject_as_its_image, "create", "create", HomalgRing( M ) ) );
              prime := ImageSubobject( GradedMap( pp[2]!.map_having_subobject_as_its_image, "create", "create", HomalgRing( M ) ) );
              
              return [ primary, prime ];
              
            end
          );
    
    return primary_decomposition;
    
end );
