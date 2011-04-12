#############################################################################
##
##  LIGrMOD.gi                    LIGrMOD subpackage
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
            intrinsic_properties := LIMOD.intrinsic_properties,
            intrinsic_attributes := LIMOD.intrinsic_attributes,
            )
        );

Append( LIGrMOD.intrinsic_properties,
        [ 
          ] );

Append( LIGrMOD.intrinsic_attributes,
        [ 
          "BettiDiagram",
          "CastelnuovoMumfordRegularity",
          ] );

####################################
#
# logical implications methods:
#
####################################

InstallLogicalImplicationsForHomalgSubobjects(
        List( LIGrMOD.intrinsic_properties, ValueGlobal ),
        IsGradedSubmoduleRep,
        HasEmbeddingInSuperObject,
        UnderlyingObject );

InstallLogicalImplicationsForHomalgSubobjects(
        List( LIGrMOD.intrinsic_attributes, ValueGlobal ),
        IsGradedSubmoduleRep,
        HasEmbeddingInSuperObject,
        UnderlyingObject );

####################################
#
# immediate methods for properties:
#
####################################

##
InstallMethodToPullPropertiesOrAttributes(
        IsHomalgGradedModule, IsHomalgGradedModule,
        [ "IsCyclic", "IsZero", "IsTorsionFree", "IsArtinian", "IsTorsion", "IsPure", "IsReflexive", "IsHolonomic" ],
        UnderlyingModule );

##
InstallImmediateMethodToTwitterPropertiesOrAttributes(
        Twitter, IsHomalgGradedModule, LIMOD.intrinsic_properties, UnderlyingModule );

####################################
#
# immediate methods for attributes:
#
####################################

##
InstallMethodToPullPropertiesOrAttributes(
        IsHomalgGradedModule, IsHomalgGradedModule,
        [ "ProjectiveDimension", "Grade", "DegreeOfTorsionFreeness", "RankOfObject" ],
        UnderlyingModule );

##
InstallImmediateMethodToTwitterPropertiesOrAttributes(
        Twitter, IsHomalgGradedModule, LIMOD.intrinsic_attributes, UnderlyingModule );

####################################
#
# methods for attributes:
#
####################################

##
InstallMethod( BettiDiagram,
        "LIMOD: for homalg graded modules",
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
        [ IsGradedModuleRep ],
        
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

InstallMethod( ZerothRegularity,
        "for homalg graded modules",
        [ IsGradedModuleRep ],
        
  function( M )
    local CM, j, i;
    
    if not TrivialArtinianSubmodule( M ) then
        TryNextMethod( );
    fi;
    
    CM := CastelnuovoMumfordRegularity( M );
    
    for j in [ 0 .. CM ] do
        i := CM - j;
        
        if NrGenerators( LowestDegreeObject( LinearStrandOfTateResolution( M, i, i+1 ) ) ) <> NrGenerators( HomogeneousPartOverCoefficientsRing( i, M ) ) then
            return i + 1;
        fi;
        
    od;
    
    return 0;
    
end );

InstallMethod( TrivialArtinianSubmodule,
        "for homalg graded modules",
        [ IsGradedModuleRep ],
        
  function( M )
    local S, k;
    
    S := HomalgRing( M );
    
    if IsHomalgLeftObjectOrMorphismOfLeftObjects( M ) then
        k := Cokernel( MaximalIdealAsLeftMorphism( S ) );
    else
        k := Cokernel( MaximalIdealAsRightMorphism( S ) );
    fi;
    
    return IsZero( GradedHom( k, M ) );
    
end );
