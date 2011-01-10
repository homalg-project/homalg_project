#############################################################################
##
##  GradedModuleMap.gi               Graded Modules package
##
##  Copyright 2010,      Mohamed Barakat, University of Kaiserslautern
##                       Markus Lange-Hegermann, RWTH Aachen
##
##  Implementation stuff for graded maps ( = graded module homomorphisms ).
##
#############################################################################

####################################
#
# representations:
#
####################################

##  <#GAPDoc Label="IsMapOfGradedModulesRep">
##  <ManSection>
##    <Filt Type="Representation" Arg="phi" Name="IsMapOfFinitelyGeneratedModulesRep"/>
##    <Returns><C>true</C> or <C>false</C></Returns>
##    <Description>
##      The &GAP; representation of maps between graded &homalg; modules. <P/>
##      (It is a representation of the &GAP; categories <C>IsHomalgMap</C>,
##       and <C>IsStaticMorphismOfFinitelyGeneratedObjectsRep</C>.)
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareRepresentation( "IsMapOfGradedModulesRep",
        IsHomalgGradedMap and
        IsStaticMorphismOfFinitelyGeneratedObjectsRep,
        [ "UnderlyingMorphism" ] );

####################################
#
# global variables:
#
####################################

HOMALG_GRADED_MODULES.FunctorOn :=  [ IsHomalgGradedRingOrGradedModuleRep,
				      IsMapOfGradedModulesRep,
				      [ IsComplexOfFinitelyPresentedObjectsRep, IsCocomplexOfFinitelyPresentedObjectsRep ],
				      [ IsChainMapOfFinitelyPresentedObjectsRep, IsCochainMapOfFinitelyPresentedObjectsRep ] ];

####################################
#
# families and types:
#
####################################

# a new family:
BindGlobal( "TheFamilyOfHomalgGradedMaps",
        NewFamily( "TheFamilyOfHomalgGradedMaps" ) );

# four new types:
BindGlobal( "TheTypeHomalgMapOfGradedLeftModules",
        NewType( TheFamilyOfHomalgGradedMaps,
                IsMapOfGradedModulesRep and IsHomalgLeftObjectOrMorphismOfLeftObjects ) );

BindGlobal( "TheTypeHomalgMapOfGradedRightModules",
        NewType( TheFamilyOfHomalgGradedMaps,
                IsMapOfGradedModulesRep and IsHomalgRightObjectOrMorphismOfRightObjects ) );

BindGlobal( "TheTypeHomalgSelfMapOfGradedLeftModules",
        NewType( TheFamilyOfHomalgGradedMaps,
                IsMapOfGradedModulesRep and IsHomalgSelfMap and IsHomalgLeftObjectOrMorphismOfLeftObjects ) );

BindGlobal( "TheTypeHomalgSelfMapOfGradedRightModules",
        NewType( TheFamilyOfHomalgGradedMaps,
                IsMapOfGradedModulesRep and IsHomalgSelfMap and IsHomalgRightObjectOrMorphismOfRightObjects ) );

####################################
#
# methods for operations:
#
####################################

InstallMethod( UnderlyingMorphism,
        "for homalg graded module maps",
        [ IsMapOfGradedModulesRep ],
  function( M )
    
    return M!.UnderlyingMorphism;
    
end );

##
InstallMethod( \*,
        "for homalg maps",
        [ IsHomalgRing, IsMapOfGradedModulesRep ],
        
  function( R, phi )
    
    return BaseChange( R, phi );
    
end );

##
InstallMethod( \*,
        "for homalg maps",
        [ IsMapOfGradedModulesRep, IsHomalgRing ],
        
  function( phi, R )
    
    return R * phi;
    
end );

##
InstallMethod( PushPresentationByIsomorphism,
        "for homalg maps",
        [ IsMapOfGradedModulesRep and IsIsomorphism ],
        
  function( phi )
    
    SetIsIsomorphism( UnderlyingMorphism( phi ), true );
    
    PushPresentationByIsomorphism( UnderlyingMorphism( phi ) );
    
    return Range( phi );
    
end );

##
InstallMethod( AssertGradedMorphism,
        "for homalg maps",
        [ IsMapOfGradedModulesRep ],
        
  function( map_phi )
    local degs, degt, deg, i, j;
    
    deg := DegreesOfEntries( MatrixOfMap( map_phi ) );
    degs := DegreesOfGenerators( Source( map_phi ) );
    degt := DegreesOfGenerators( Range( map_phi ) );
    
    for i in [ 1 .. Length( degs ) ] do
        for j in [ 1 .. Length( degt ) ] do
            if IsHomalgLeftObjectOrMorphismOfLeftObjects( map_phi ) then
                if deg[i][j] >= 0 and not ( degs[i] = deg[i][j] + degt[j] ) then
                    Error("2 ", degs[i], " ", deg[i][j], " ", degt[j]);
                    return false;
                fi;
            else
                if deg[j][i] >= 0 and not ( degs[i] = deg[j][i] + degt[j] ) then
                    Error("3 ", degs[i], " ", deg[j][i], " ", degt[j]);
                    return false;
                fi;
            fi;
        od;
    od;
    
    return true;
    
end );

##
InstallMethod( NormalizeGradedMorphism,
        "for homalg maps",
        [ IsMapOfGradedModulesRep ],
        
  function( phi )
    local M, N, S, degM, degN, K, m, T1, T2, Tl, Tr, rank, left,
          isoM, isoN, TM, TN, k, complement;
    
    M := Source( phi );
    N := Range( phi );
    S := HomalgRing( phi );
    
    degM := Set( DegreesOfGenerators( M ) );
    degN := Set( DegreesOfGenerators( N ) );
    
    if not Length( degM ) = 1 or not degM = degN then
        Error( "expected source and target to be generated in the same degree\n" );
    fi;
    
    K := CoefficientsRing( S );
    
    m := K * MatrixOfMap( phi );
    
    T1 := HomalgVoidMatrix( K );
    T2 := SyzygiesOfRows( m );
    m := BasisOfRowsCoeff( m, T1 );
    Tl := UnionOfRows( T1, T2 );
    
    T1 := HomalgVoidMatrix( K );
    T2 := SyzygiesOfColumns( m );
    m := BasisOfColumnsCoeff( m, T1 );
    Tr := UnionOfColumns( T1, T2 );
    
    rank := NrRows( m );
    
    Assert( 3, rank = NrColumns( m ) );
    
    left := IsHomalgLeftObjectOrMorphismOfLeftObjects( phi );
    
    if left then
        TM := Tl;
        TN := Tr;
    else
        TM := Tr;
        TN := Tl;
    fi;
    isoM := GradedMap( S * TM, M, M );
    # here we somehow cheat: the maps are not really isomorphisms, but it does not harm to assume they are
#     Assert( 1, IsEpimorphism( isoM ) );
#     SetIsEpimorphism( isoM, true );
#     AsEpimorphicImage( isoM );
    SetIsIsomorphism( isoM, true );
    PushPresentationByIsomorphism( isoM );
    isoN := GradedMap( S * LeftInverse( TN ), N, N );
    # here we somehow cheat: the maps are not really isomorphisms, but it does not harm to assume they are
#     Assert( 1, IsEpimorphism( isoN ) );
#     SetIsEpimorphism( isoN, true );
#     AsEpimorphicImage( isoN );
    SetIsIsomorphism( isoN, true );
    PushPresentationByIsomorphism( isoN );
    
    if left then
        Assert( 5, S * MatrixOfMap( phi ) = UnionOfRows( 
                UnionOfColumns( HomalgIdentityMatrix( rank, S ), HomalgZeroMatrix( rank, NrGenerators( N ) - rank, S ) ),
                UnionOfColumns( HomalgZeroMatrix( NrGenerators( M ) - rank, rank, S ), HomalgZeroMatrix( NrGenerators( M ) - rank, NrGenerators( N ) - rank, S ) ) 
            ) );
    else
        Assert( 5, S * MatrixOfMap( phi ) = UnionOfRows( 
                UnionOfColumns( HomalgIdentityMatrix( rank, S ), HomalgZeroMatrix( rank, NrGenerators( M ) - rank, S ) ),
                UnionOfColumns( HomalgZeroMatrix( NrGenerators( N ) - rank, rank, S ), HomalgZeroMatrix( NrGenerators( N ) - rank, NrGenerators( M ) - rank, S ) )
            ) );
    fi;
        
    k := NrGenerators( N ) - rank;
    
    if left then
        complement := UnionOfColumns( HomalgZeroMatrix( k, rank, S ), HomalgIdentityMatrix( k, S ) );
    else
        complement := UnionOfRows( HomalgZeroMatrix( rank, k, S ), HomalgIdentityMatrix( k, S ) );
    fi;
    
    complement := GradedMap( complement, "free", N );
    
    phi!.complement_of_image := complement;
    
    Assert( 3, IsEpimorphism( CoproductMorphism( complement, phi ) ) );
    
    return phi;
    
end );

####################################
#
# constructors
#
####################################

InstallMethod( GradedMap,
        "For homalg matrices",
        [ IsHomalgMatrix, IsString, IsHomalgGradedRingRep ],
  function( A, s, R )
    return GradedMap( A, "free", "free", s, R );
end ); 

InstallMethod( GradedMap,
        "For homalg matrices",
        [ IsHomalgMatrix, IsObject, IsObject ],
  function( A, BB, CC )
    if IsHomalgGradedModule( BB ) then
      return GradedMap( A, BB, CC, HomalgRing( BB ) );
    elif IsHomalgGradedModule( CC ) then
      return GradedMap( A, BB, CC, HomalgRing( CC ) );
    else
      Error( "expected a graded ring or graded Modules in the arguments" );
    fi;
end ); 

InstallMethod( GradedMap,
        "For homalg matrices",
        [ IsHomalgMatrix, IsObject, IsObject, IsHomalgGradedRingRep ],
  function( A, BB, CC, R )
    if ( IsHomalgStaticObject( BB ) and IsHomalgLeftObjectOrMorphismOfLeftObjects( BB ) ) or
      ( IsHomalgStaticObject( CC ) and IsHomalgLeftObjectOrMorphismOfLeftObjects( CC ) ) then
      return GradedMap( A, BB, CC, "left", R );
    else
      return GradedMap( A, BB, CC, "right", R );
    fi;
end ); 

InstallMethod( GradedMap,
        "For homalg matrices",
        [ IsHomalgMatrix, IsObject, IsString ],
  function( A, B, s )
  local left;
    if IsHomalgGradedModule( B ) then
      return GradedMap( A, B, s, HomalgRing( B ) );
    else
      Error( "expected a graded ring or graded Modules in the arguments" );
    fi;
end ); 

InstallMethod( GradedMap,
        "For homalg matrices",
        [ IsHomalgMatrix, IsObject, IsString, IsHomalgGradedRingRep ],
  function( A, B, s, R )
  local left;
    if s = "free" then
      if  IsHomalgGradedModule( B ) then
        left := IsHomalgLeftObjectOrMorphismOfLeftObjects( B );
      elif IsList( B ) and IsHomalgGradedModule( B[1] ) then
        left := IsHomalgLeftObjectOrMorphismOfLeftObjects( B[1] );
      else
        Error( "No information whether to construct a morphism between left modules or a morphism between right modules" );
      fi;
      if left then
        return GradedMap( A, B, "free", "left", R );
      else
        return GradedMap( A, B, "free", "right", R );
      fi;
    else
      return GradedMap( A, B, "free", s, R );
    fi;
end ); 

InstallMethod( GradedMap,
        "for homalg matrices",
        [ IsHomalgMatrix, IsObject, IsObject, IsString ],
  function( matrix, source, target, s)
    if IsHomalgGradedModule( source ) then
      return GradedMap( matrix, source, target, s, HomalgRing( source ) );
    elif IsHomalgGradedModule( target ) then
      return GradedMap( matrix, source, target, s, HomalgRing( target ) );
    elif IsHomalgHomogeneousMatrixRep( matrix) then
      return GradedMap( matrix, source, target, s, HomalgRing( matrix ) );
    else
      Error( "expected a graded ring or graded Modules in the arguments" );
    fi;
end );

InstallMethod( GradedMap,
        "for homalg matrices",
        [ IsHomalgMatrix, IsObject, IsObject, IsHomalgGradedRingRep ],
  function( matrix, source, target, S)
  local left;
    if  IsHomalgModule( source ) then
      left := IsHomalgLeftObjectOrMorphismOfLeftObjects( source );
    elif IsList( source ) and IsHomalgModule( source[1] ) then
      left := IsHomalgLeftObjectOrMorphismOfLeftObjects( source[1] );
    elif IsHomalgModule( target ) then
      left := IsHomalgLeftObjectOrMorphismOfLeftObjects( target );
    elif IsList( target ) and IsHomalgModule( target[1] ) then
      left := IsHomalgLeftObjectOrMorphismOfLeftObjects( target[1] );
    fi;
    if not IsBound( left ) then
      Error( "No information whether to construct a morphism between left modules or a morphism between right modules" );
    fi;
    if left then
      left := "left";
    else
      left := "right";
    fi;
    return GradedMap( matrix, source, target, left, S );
end );

InstallMethod( GradedMap,
        "for homalg matrices",
        [ IsHomalgMatrix, IsObject, IsObject, IsString, IsHomalgGradedRingRep ],
  function( matrix, source, target, s, S )
  local left, nr_gen_s, nr_gen_t, source2, pos_s, degrees_s, target2, pos_t, degrees_t, underlying_morphism, type, morphism, i;

    #check for information about left or right modules
    if IsStringRep( s ) and Length( s ) > 0 then
      if LowercaseString( s{[1..1]} ) = "r" then
        left := false;  ## we explicitly asked for a morphism of right modules
      else
        left := true;
      fi;
    fi;
    if not IsBound( left ) then
      if  IsHomalgModule( source ) then
        left := IsHomalgLeftObjectOrMorphismOfLeftObjects( source );
      elif IsList( source ) and IsHomalgModule( source[1] ) then
        left := IsHomalgLeftObjectOrMorphismOfLeftObjects( source[1] );
      elif IsHomalgModule( target ) then
        left := IsHomalgLeftObjectOrMorphismOfLeftObjects( target );
      elif IsList( target ) and IsHomalgModule( target[1] ) then
        left := IsHomalgLeftObjectOrMorphismOfLeftObjects( target[1] );
      fi;
    fi;
    if not IsBound( left ) then
      Error( "No information whether to construct a morphism between left modules or a morphism between right modules" );
    fi;
    
    #set nr of generators of both modules
    if left then
      nr_gen_s := NrRows( matrix );
      nr_gen_t := NrColumns( matrix );
    else
      nr_gen_t := NrRows( matrix );
      nr_gen_s := NrColumns( matrix );
    fi;

    #source from input
    if source = "free" then
      if left then
        source2 := FreeLeftModuleWithDegrees( nr_gen_s, S );
      else
        source2 := FreeRightModuleWithDegrees( nr_gen_s, S );
      fi;
    elif ( IsList( source ) and not( IsString( source ) ) ) then
      if Length( source ) = 2 and IsHomalgGradedModule( source[1] ) and IsPosInt( source[2] ) then
        source2 := source[1];
        pos_s := source[2];
        if not IsBound( SetsOfRelations( source2 )!.( pos_s ) ) then
          Error( "the source module does not possess a ", source[2], ". set of relations (this positive number is given as the second entry of the list provided as the second argument)\n" );
        fi;
        degrees_s := DegreesOfGenerators( source2 );
      elif Length( source ) = 2 and IsHomalgModule( source[1] ) and IsPosInt( source[2] ) then
        source2 := GradedModule( source[1], S );
        pos_s := source[2];
        if not IsBound( SetsOfRelations( source2 )!.( pos_s ) ) then
          Error( "the source module does not possess a ", source[2], ". set of relations (this positive number is given as the second entry of the list provided as the second argument)\n" );
        fi;
      elif IsHomogeneousList( source ) and ( source = [] or IsInt( source[1] ) ) then
        degrees_s := source;
        if left then
          source2 := FreeLeftModuleWithDegrees( degrees_s, S );
        else
          source2 := FreeRightModuleWithDegrees( degrees_s, S );
        fi;
      else
      	Error( "Unknow configuration of the second parameter: expected a list of a homalg graded module and an integer (indicating the position of the presentation) or a list of degrees" );
      fi;
    elif IsInt( source ) then
      if left then
        degrees_s := ListWithIdenticalEntries( NrRows( matrix ), source );
        source2 := FreeLeftModuleWithDegrees( degrees_s, S );
      else
        degrees_s := ListWithIdenticalEntries( NrColumns( matrix ), source );
        source2 := FreeRightModuleWithDegrees( degrees_s, S );
      fi;
    elif IsHomalgGradedModule( source ) then
      source2 := source;
      degrees_s := DegreesOfGenerators( source2 );
    else
      Error( "unknown type of second parameter" );
    fi;
    if not IsBound( pos_s ) then
      pos_s := PositionOfTheDefaultPresentation( source2 );
    fi;
    
    #target from input
    if target = "free" then
      if source <> "free" then
        Error( "not yet implemented" );
      fi;
      if left then
        target2 := FreeLeftModuleWithDegrees( nr_gen_t, S );
      else
        target2 := FreeRightModuleWithDegrees( nr_gen_t, S );
      fi;
    elif IsList( target ) then
      if Length( target ) = 2 and IsHomalgGradedModule( target[1] ) and IsPosInt( target[2] ) then
        target2 := target[1];
        pos_t := target[2];
        if not IsBound( SetsOfRelations( target2 )!.( pos_t ) ) then
          Error( "the target module does not possess a ", target[2], ". set of relations (this positive number is given as the second entry of the list provided as the third argument)\n" );
        fi;
      elif IsHomogeneousList( target ) and ( target = [] or IsInt( target[1] ) ) then
        degrees_t := target;
        if left then
          target2 := FreeLeftModuleWithDegrees( degrees_t, S );
        else
          target2 := FreeRightModuleWithDegrees( degrees_t, S );
        fi;
      else
        Error( "Unknow configuration of the third parameter: expected a list of a homalg graded module and an integer (indicating the position of the presentation) or a list of degrees" );
      fi;
    elif IsInt( target ) then
      if left then
        degrees_t := ListWithIdenticalEntries( NrColumns( matrix ), target );
        target2 := FreeLeftModuleWithDegrees( degrees_s, S );
      else
        degrees_t := ListWithIdenticalEntries( NrRows( matrix ), target );
        target2 := FreeRightModuleWithDegrees( degrees_s, S );
      fi;
    elif IsHomalgGradedModule( target ) then
      target2 := target;
    else
      Error( "unknown type of third parameter" );
    fi;
    if not IsBound( pos_t) then
      pos_t := PositionOfTheDefaultPresentation( target2 );
    fi;
    if not IsBound( degrees_t) then
      degrees_t := DegreesOfGenerators( target2 );
    fi;
    
    #construct degrees source according to degrees of target and with the help of generators
    if not IsBound( degrees_s ) then
      if left then
        if IsHomalgHomogeneousMatrixRep( matrix ) then
          degrees_s := NonTrivialDegreePerRow( matrix, degrees_t );
        else
          degrees_s := NonTrivialDegreePerRowWeighted( matrix, WeightsOfIndeterminates( S ), degrees_t );
        fi;
      else
        if IsHomalgHomogeneousMatrixRep( matrix ) then
          degrees_s := NonTrivialDegreePerColumn( matrix, degrees_t );
        else
          degrees_s := NonTrivialDegreePerColumnWeighted( matrix, WeightsOfIndeterminates( S ), degrees_t );
        fi;
      fi;
      source2!.SetOfDegreesOfGenerators!.(pos_s) := degrees_s ;
    fi;
    
    #sanity check on input
    if not( IsIdenticalObj( HomalgRing( source2 ), S ) and IsIdenticalObj( HomalgRing( target2 ), S ) ) then
      Error( "Contradictory information about the ring over which to create a graded morphism" );
    fi;
    
    if not IsHomalgLeftObjectOrMorphismOfLeftObjects( source2 ) = IsHomalgLeftObjectOrMorphismOfLeftObjects( target2 ) then
      Error( "source and target are expected to be both left or right modules" );
    fi;
    
    if not IsHomalgLeftObjectOrMorphismOfLeftObjects( UnderlyingModule( source2 ) ) = IsHomalgLeftObjectOrMorphismOfLeftObjects( UnderlyingModule( target2 ) ) then
      Error( "underlying modules of source and target are expected to be both left or right modules" );
    fi;

    if left then
      if IsIdenticalObj( source2, target2 ) then
        type := TheTypeHomalgSelfMapOfGradedLeftModules;
      else
        type := TheTypeHomalgMapOfGradedLeftModules;
      fi;
    else
      if IsIdenticalObj( source2, target2 ) then
        type := TheTypeHomalgSelfMapOfGradedRightModules;
      else
        type := TheTypeHomalgMapOfGradedRightModules;
      fi;
    fi;
    
    if IsHomalgHomogeneousMatrixRep( matrix ) then
      underlying_morphism := HomalgMap( UnderlyingNonHomogeneousMatrix( matrix ), UnderlyingModule( source2 ), UnderlyingModule( target2 ) );
    else
      underlying_morphism := HomalgMap( matrix, UnderlyingModule( source2 ), UnderlyingModule( target2 ) );
    fi;
    
    morphism := rec(
      UnderlyingMorphism := underlying_morphism,
      free_resolutions := rec( ),
    );

    ## Objectify:
    ObjectifyWithAttributes(
      morphism, type,
      Source, source2,
      Range, target2
    );

    SetDegreeOfMorphism( morphism, 0 );

    MatchPropertiesAndAttributes( morphism, underlying_morphism, LIGrHOM.match_properties, LIGrHOM.match_attributes );
    
    Assert( 3, AssertGradedMorphism( morphism ) );
        
    if AssertionLevel() >= 10 then
        for i in [ 1 .. Length( HOMALG_GRADED_MODULES.MorphismsSave ) ] do
            Assert( 10, 
              not IsIdenticalObj( UnderlyingMorphism( HOMALG_GRADED_MODULES.MorphismsSave[i] ), UnderlyingMorphism( morphism ) ) 
              or IsIdenticalObj( HOMALG_GRADED_MODULES.MorphismsSave[i], morphism ),
            "a map is about to be graded (at least) twice. This might be intentionally. Set AssertionLevel to 11 to get an error message" );
            Assert( 11, 
              not IsIdenticalObj( UnderlyingMorphism( HOMALG_GRADED_MODULES.MorphismsSave[i] ), UnderlyingMorphism( morphism ) ) 
              or IsIdenticalObj( HOMALG_GRADED_MODULES.MorphismsSave[i], morphism ) );
        od;
        Add( HOMALG_GRADED_MODULES.MorphismsSave, morphism );
        if Length( HOMALG_GRADED_MODULES.MorphismsSave ) = 16 then Error( "test" ); fi;
    fi;
    
    underlying_morphism!.GradedVersions := [ morphism ];
    
    return morphism;
end ); 

InstallMethod( GradedMap,
        "For homalg morphisms",
        [ IsHomalgMap, IsHomalgGradedRingRep ],
  function( A ,S )
    return GradedMap( A, GradedModule( Source( A ), S ), GradedModule( Range( A ), S ) );
end ); 

InstallMethod( GradedMap,
        "For homalg morphisms",
        [ IsHomalgMap, IsObject, IsHomalgGradedRingRep ],
  function( A, B, S )
    return GradedMap( A, B, GradedModule( Range( A ), S ) );
end ); 

InstallMethod( GradedMap,
        "For homalg morphisms",
        [ IsHomalgMap, IsGradedModuleRep, IsString ],
  function( A, B, s )
    if s = "create" then
      return GradedMap( A, B, HomalgRing( B ) );
    else
      TryNextMethod( );
    fi;
end ); 


# 
InstallMethod( GradedMap,
        "For homalg morphisms",
        [ IsHomalgMap, IsList, IsObject, IsHomalgGradedRingRep ],
  function( A, B, C, S )
    local b;
    
    if IsHomogeneousList( B ) and ( B = [] or IsInt( B[1] ) ) then
      if IsHomalgLeftObjectOrMorphismOfLeftObjects( A ) then
        b := GradedModule( Source( A ), B, S );
      else
        b := GradedModule( Source( A ), B, S );
      fi;
    else
      TryNextMethod();
    fi;
    
    return GradedMap( A, b, C, S );
end );

# 
InstallMethod( GradedMap,
        "For homalg morphisms",
        [ IsHomalgMap, IsObject, IsObject, IsHomalgGradedRingRep ],
  function( A, B, C, S )
  local c, e, deg0, l;
  
    #create target as a free module from input
    if C = "free" then
      if IsHomalgLeftObjectOrMorphismOfLeftObjects( A ) then
        c := FreeLeftModuleWithDegrees( NrColumns( A ), S );
      else
        c := FreeRightModuleWithDegrees( NrRows( A ), S );
      fi;
    #create target from the target of the non-graded map by computing degrees
    elif C = "create" then
      if IsGradedModuleRep( B ) then
        e := DegreesOfEntries( MatrixOfMap( A ) );
        deg0 := DegreeMultivariatePolynomial( Zero( S ) );
        if IsHomalgLeftObjectOrMorphismOfLeftObjects( A ) then 
          l := List( TransposedMat( e ),
                    function( degA_jp ) 
                      local i;
                      i := PositionProperty( degA_jp, a -> not a = deg0 );
                      if i = fail then
                        #this only happens for a zero column in the matrix
                        #then the image of the map projects to zero on that component
                        #we just set this components degree to zero
                        Error("Unexpected zero column in Matrix when computing degrees");
                        return 0;
                      else
                        return DegreesOfGenerators( B )[i] - degA_jp[i];
                      fi;
                    end 
                  );
        else
          l := List( e,
                    function( degA_pj ) 
                      local i;
                      i := PositionProperty( degA_pj, a -> not a = deg0 );
                      if i = fail then
                        #this only happens for a zero row in the matrix
                        #then the image of the map projects to zero on that component
                        #we just set this components degree to zero
                        Error("Unexpected zero row in Matrix when computing degrees");
                        return 0;
                      else
                        return DegreesOfGenerators( B )[i] - degA_pj[i];
                      fi;
                    end 
                  );
        fi;
        if IsHomalgSelfMap( A ) and l = DegreesOfGenerators( B ) then
          c := B;
        else
          c := GradedModule( Range( A ), l, S );
        fi;
      else
        c := GradedModule( Range( A ), S );
      fi;
    #create target from the target of the non-graded map by given degrees
    elif IsHomogeneousList( C ) and ( C = [] or IsInt( C[1] ) ) then
      if IsHomalgLeftObjectOrMorphismOfLeftObjects( A ) then
        c := GradedModule( Range( A ), C, S );
      else
        c := GradedModule( Range( A ), C, S );
      fi;
    elif IsHomalgGradedModule( C ) then
      c := C;
    else
      Error( "unknown type of third parameter" );
    fi;
  
    return GradedMap( A, B, c );
end );

InstallMethod( GradedMap,
        "For homalg morphisms",
        [ IsHomalgMap, IsObject, IsGradedModuleRep ],
  function( A, BB, CC )
  local S, b, degree;
    
    S := HomalgRing( CC );
    
    #target from input
    if BB = "free" then
      if IsHomalgLeftObjectOrMorphismOfLeftObjects( A ) then
        b := FreeLeftModuleWithDegrees( NonTrivialDegreePerRowWeighted( MatrixOfMap( A ), WeightsOfIndeterminates( S ), DegreesOfGenerators( CC ) ), S );
      else
        b := FreeRightModuleWithDegrees( NonTrivialDegreePerColumnWeighted( MatrixOfMap( A ), WeightsOfIndeterminates( S ),DegreesOfGenerators( CC ) ), S );
      fi;
    elif BB = "create" then
      if IsHomalgLeftObjectOrMorphismOfLeftObjects( A ) then
        degree := NonTrivialDegreePerRowWeighted( MatrixOfMap( A ), WeightsOfIndeterminates( S ), DegreesOfGenerators( CC ) );
      else
        degree := NonTrivialDegreePerColumnWeighted( MatrixOfMap( A ), WeightsOfIndeterminates( S ), DegreesOfGenerators( CC ) );
      fi;
      if IsHomalgSelfMap( A ) and degree = DegreesOfGenerators( CC ) then
        b :=  CC;
      else
        b := GradedModule( Source( A ), degree, S );
      fi;
    elif IsHomogeneousList( BB ) and ( BB = [] or IsInt( BB[1] ) ) then
      b := GradedModule( Source( A ), BB, S );
    elif IsHomalgGradedModule( BB ) then
      b := BB;
    elif IsHomalgModule( BB ) and IsIdenticalObj( BB, Source( A ) ) then
      if IsHomalgLeftObjectOrMorphismOfLeftObjects( A ) then
        b := GradedModule( BB, NonTrivialDegreePerRowWeighted( MatrixOfMap( A ), WeightsOfIndeterminates( S ), DegreesOfGenerators( CC ) ) );
      else
        b := GradedModule( BB, NonTrivialDegreePerColumnWeighted( MatrixOfMap( A ), WeightsOfIndeterminates( S ), DegreesOfGenerators( CC ) ) );
      fi;
    else
      Error( "unknown type of second parameter" );
    fi;
  
    return GradedMap( A, b, CC );
end ); 

InstallMethod( GradedMap,
        "For homalg morphisms",
        [ IsHomalgMap, IsGradedModuleRep, IsGradedModuleRep ],
  function( A, B, C )
  local S, i, type, morphism;
    
    S := HomalgRing( A );
    
    if IsMapOfGradedModulesRep( A ) then
      return A;
    fi;
    
    if IsBound( A!.GradedVersions ) then
        for i in A!.GradedVersions do
            if IsIdenticalObj( HomalgRing( i ), S ) then
                return i;
            fi;
        od;
    fi;

    if not IsIdenticalObj( UnderlyingModule( B ), Source( A ) ) then
      Error( "the underlying non-graded modules for the source and second parameter do not match" );
    fi;
    if not IsIdenticalObj( UnderlyingModule( C ), Range( A ) ) then
      Error( "the underlying non-graded modules for the range and third parameter do not match" );
    fi;

    if IsHomalgLeftObjectOrMorphismOfLeftObjects( A ) then
      if IsIdenticalObj( B, C ) then
        type := TheTypeHomalgSelfMapOfGradedLeftModules;
      else
        type := TheTypeHomalgMapOfGradedLeftModules;
      fi;
    else
      if IsIdenticalObj( B, C ) then
        type := TheTypeHomalgSelfMapOfGradedRightModules;
      else
        type := TheTypeHomalgMapOfGradedRightModules;
      fi;
    fi;
    
    morphism := rec(
      UnderlyingMorphism := A,
      free_resolutions := rec( ),
    );

    ## Objectify:
    ObjectifyWithAttributes(
      morphism, type,
      Source, B,
      Range, C );

    SetDegreeOfMorphism( morphism, 0 );

    MatchPropertiesAndAttributes( morphism, A, LIGrHOM.match_properties, LIGrHOM.match_attributes );
    
    Assert( 3, AssertGradedMorphism( morphism ) );
        
    if AssertionLevel() >= 10 then
        for i in [ 1 .. Length( HOMALG_GRADED_MODULES.MorphismsSave ) ] do
            Assert( 10, 
              not IsIdenticalObj( UnderlyingMorphism( HOMALG_GRADED_MODULES.MorphismsSave[i] ), UnderlyingMorphism( morphism ) ) 
              or IsIdenticalObj( HOMALG_GRADED_MODULES.MorphismsSave[i], morphism ),
            "a map is about to be graded (at least) twice. This might be intentionally. Set AssertionLevel to 11 to get an error message" );
            Assert( 11, 
              not IsIdenticalObj( UnderlyingMorphism( HOMALG_GRADED_MODULES.MorphismsSave[i] ), UnderlyingMorphism( morphism ) ) 
              or IsIdenticalObj( HOMALG_GRADED_MODULES.MorphismsSave[i], morphism ) );
        od;
        Add( HOMALG_GRADED_MODULES.MorphismsSave, morphism );
    fi;
    
    if not IsBound( A!.GradedVersions ) then
        A!.GradedVersions := [ morphism ];
    else
        Add( A!.GradedVersions, morphism );
    fi;
    
    return morphism;
end );

InstallMethod( GradedZeroMap,
        "For graded modules",
        [ IsGradedModuleRep, IsGradedModuleRep ],
  function( M, N )
  
    return GradedMap( HomalgZeroMap( UnderlyingModule( M ), UnderlyingModule( N ) ), M, N );
  
end );

####################################
#
# View, Print, and Display methods:
#
####################################

##
InstallMethod( Display,
        "for homalg graded module maps",
        [ IsMapOfGradedModulesRep ], ## since we don't use the filter IsHomalgLeftObjectOrMorphismOfLeftObjects we need to set the ranks high
        
  function( o )
    local target;
    
    target := Range( o );
    
    Display( UnderlyingMorphism( o ), "graded" );
    
    if NrGenerators( target ) = 1 then
        Print( "\n(degree of generator of target: ", DegreesOfGenerators( target )[1], ")\n" );
    else
        Print( "\n(degrees of generators of target: ", DegreesOfGenerators( target ), ")\n" );
    fi;
    
end );
