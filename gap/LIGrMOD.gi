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
          ] );

##
InstallGlobalFunction( InstallGradedModulesPropertiesMethods, 
  function( prop );

  InstallImmediateMethod( prop,
          IsGradedModuleRep, 0,
          
    function( M )
    local U;
    
      U := UnderlyingModule( M );
      if Tester( prop )( U ) then
        return prop( U );
      else
        TryNextMethod();
      fi;
      
  end );
  
  InstallMethod( prop,
          "for homalg graded module maps",
          [ IsGradedModuleRep ],
          
    function( M )
      
      return prop( UnderlyingModule( M ) );
      
  end );

end );

             
for GRADEDMODULE_prop in [ 
     IsCyclic, IsZero, IsTorsionFree, IsArtinian, IsTorsion, IsPure, IsReflexive, IsHolonomic, ProjectiveDimension, Grade, DegreeOfTorsionFreeness, RankOfObject
   ] do
  InstallGradedModulesPropertiesMethods( GRADEDMODULE_prop );
od;
Unbind( GRADEDMODULE_prop );

####################################
#
# methods for attributes:
#
####################################

##
InstallMethod( BettiDiagram,
        "LIMOD: for homalg modules",
        [ IsHomalgModule ],
        
  function( M )
    local C, degrees, min, C_degrees, l, ll, r, beta;
    
    if not IsList( DegreesOfGenerators( M ) ) then
        Error( "the module was not created as a graded module\n" );
    fi;
    
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
        "LIMOD: for homalg modules",
        [ IsHomalgModule ],
        
  function( M )
    local betti, degrees;
    
    betti := BettiDiagram( Resolution( M ) );
    
    degrees := RowDegreesOfBettiDiagram( betti );
    
    return degrees[Length(degrees)];
    
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
    local S, R;
    
    S := HomalgRing( J );
    
    Assert( 1, not J = S );
    
    R := GradedRing( ResidueClassRing( UnderlyingModule( J ) ) );
    
    if HasContainsAField( S ) and ContainsAField( S ) then
        SetContainsAField( R, true );
        if HasCoefficientsRing( S ) then
            SetCoefficientsRing( R, CoefficientsRing( S ) );
        fi;
    fi;
    
    SetDefiningIdeal( R, J );
    
    return R;
    
end );

##
InstallMethod( FullSubobject,
        "for homalg graded modules",
        [ IsGradedModuleRep ],
        
  function( M )
    
    return ImageSubobject( GradedMap( FullSubobject( UnderlyingModule( M ) )!.map_having_subobject_as_its_image, "create", M ) );
    
end );
