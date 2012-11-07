#############################################################################
##
##  ToricDivisors.gi     ToricVarieties       Sebastian Gutsche
##
##  Copyright 2011 Lehrstuhl B für Mathematik, RWTH Aachen
##
##  The Category of the Divisors of a toric Variety
##
#############################################################################

#################################
##
## Representations
##
#################################

DeclareRepresentation( "IsToricDivisorRep",
                       IsToricDivisor and IsAttributeStoringRep,
                       [ AmbientToricVariety, UnderlyingGroupElement ]
                      );

BindGlobal( "TheFamilyOfToricDivisors",
        NewFamily( "TheFamilyOfToricDivisors" , IsToricDivisor ) );

BindGlobal( "TheTypeToricDivisor",
        NewType( TheFamilyOfToricDivisors,
                 IsToricDivisorRep ) );

#################################
##
## Properties
##
#################################

##
InstallMethod( IsPrincipal,
               "for toric divisors",
               [ IsToricDivisor ],
               
  function( divisor )
    
    return IsZero( ClassOfDivisor( divisor ) );
    
end );

##
InstallMethod( IsPrimedivisor,
               "for toric divisors",
               [ IsToricDivisor ],
               
  function( divisor )
    
    divisor := UnderlyingGroupElement( divisor );
    
    divisor := UnderlyingListOfRingElements( divisor );
    
    if ForAll( divisor, i -> i = 1 or i = 0 ) and Sum( divisor ) = 1 then
        
        return true;
        
    fi;
    
    return false;
    
end );

##
InstallMethod( IsCartier,
               "for toric divisors",
               [ IsToricDivisor ],
               
  function( divisor )
    local raysincones, rays, n, i, m, j, M, groupel, rayel, cartdata;
    
    rays := RayGenerators( FanOfVariety( AmbientToricVariety( divisor ) ) );
    
    raysincones := RaysInMaximalCones( FanOfVariety( AmbientToricVariety( divisor ) ) );
    
    n := Length( raysincones );
    
    m := Length( rays );
    
    cartdata := [ 1 .. n ];
    
    groupel := UnderlyingListOfRingElements( UnderlyingGroupElement( divisor ) );
    
    for i in [ 1 .. n ] do
        
        M := [ ];
        
        rayel := [ ];
        
        for j in [ 1 .. m ] do
            
            if raysincones[ i ][ j ] = 1 then
                
                Add( M, rays[ j ] );
                
                Add( rayel, - groupel[ j ] );
                
            fi;
            
        od;
        
        j := HomalgMatrix( rayel, Length( M ), 1, HOMALG_MATRICES.ZZ );
        
        M := HomalgMatrix( M, HOMALG_MATRICES.ZZ );
        
        j := LeftDivide( M, j );
        
        if j = fail then
            
            return false;
            
        fi;
        
        cartdata[ i ] := EntriesOfHomalgMatrix( j );
        
    od;
    
    SetCartierData( divisor, cartdata );
    
    return true;
    
end );

##
InstallMethod( IsAmple,
               " for toric divisors",
               [ IsToricDivisor ],
               
  function( divisor )
    local rays, raysincones, cartdata, groupel, l, i, multlist, j;
    
    rays := AmbientToricVariety( divisor );
    
    if not IsComplete( rays ) or not IsNormalVariety( rays ) then
        
        Error( "computation may be wrong up to unfulfilled preconditions\n" );
        
    fi;
    
    if not IsBasepointFree( divisor ) then
        
        return false;
        
    fi;
    
    groupel := UnderlyingListOfRingElements( UnderlyingGroupElement( divisor ) );
    
    l := Length( groupel );
    
    Apply( groupel, i -> -i );
    
    rays := RayGenerators( FanOfVariety( AmbientToricVariety( divisor ) ) );
    
    cartdata := CartierData( divisor );
    
    raysincones := RaysInMaximalCones( FanOfVariety( AmbientToricVariety( divisor ) ) );
    
    for i in [ 1 .. Length( cartdata ) ] do
        
        for j in [ 1 .. l ] do
            
            if raysincones[ i ][ j ] = 0 then
                
                multlist := Sum( List( [ 1 .. Length( cartdata[ i ] ) ], k -> rays[ j ][ k ] * cartdata[ i ][ k ] ) );
                
                if multlist <= groupel[ j ] then
                    
                    return false;
                    
                fi;
                
            fi;
            
        od;
        
    od;
    
    return true;
    
end );

##
InstallMethod( IsBasepointFree,
               "for toric divisors",
               [ IsToricDivisor ],
               
  function( divisor )
    local rays, cartdata, groupel, l, i, multlist, j;
    
    if HasTorusfactor( AmbientToricVariety( divisor ) ) then
        
        Error( "variety has torusfactors, computation may be wrong\n" );
        
    fi;
    
# #     if not IsComplete( AmbientToricVariety( divisor ) ) then
# #         
# #         Error( "variety is not complete, computation may be wrong." );
# #         
# #     fi;
    
    if not IsCartier( divisor ) then
        
        return false;
        
    fi;
    
    groupel := UnderlyingListOfRingElements( UnderlyingGroupElement( divisor ) );
    
    l := Length( groupel );
    
    Apply( groupel, i -> -i );
    
    rays := RayGenerators( FanOfVariety( AmbientToricVariety( divisor ) ) );
    
    cartdata := CartierData( divisor );
    
    for i in cartdata do
        
        multlist := List( rays, k -> Sum( [ 1 .. Length( k ) ], j -> k[j]*i[j] ) );
        
        if not ForAll( [ 1..l ], j -> multlist[ j ] >= groupel[ j ] ) then
            
            return false;
            
        fi;
        
    od;
    
    return true;
    
end );

##
InstallMethod( IsVeryAmple,
               "for toric divisors",
               [ IsToricDivisor and IsAmple ],
               
  function( divisor )
    
    return IsVeryAmple( PolytopeOfDivisor( divisor ) );
    
end );

##
## RedispatchOnCondition( IsVeryAmple, true, [ IsToricDivisor and IsAmple ], [ PolytopeOfDivisor ], 1 );

##
RedispatchOnCondition( IsVeryAmple, true, [ IsToricDivisor ], [ IsAmple ], 0 );


#################################
##
## Attributes
##
#################################

##
InstallMethod( ClassOfDivisor,
               "for toric divisors",
               [ IsToricDivisor ],
               
  function( divisor )
    local groupelem, coker;
    
    coker := CokernelEpi( MapFromCharacterToPrincipalDivisor( AmbientToricVariety( divisor ) ) );
    
    groupelem := ApplyMorphismToElement( coker, UnderlyingGroupElement( divisor ) );
    
    return groupelem;
    
end );

##
InstallMethod( CartierData,
               "for toric divisors",
               [ IsToricDivisor and IsCartier ],
               
  function( divisor )
    local raysincones, rays, n, i, m, j, M, groupel, rayel, cartdata;
    
    rays := RayGenerators( FanOfVariety( AmbientToricVariety( divisor ) ) );
    
    raysincones := RaysInMaximalCones( FanOfVariety( AmbientToricVariety( divisor ) ) );
    
    n := Length( raysincones );
    
    m := Length( rays );
    
    cartdata := [ 1 .. n ];
    
    groupel := UnderlyingListOfRingElements( UnderlyingGroupElement( divisor ) );
    
    for i in [ 1 .. n ] do
        
        M := [ ];
        
        rayel := [ ];
        
        for j in [ 1 .. m ] do
            
            if raysincones[ i ][ j ] = 1 then
                
                Add( M, rays[ j ] );
                
                Add( rayel, - groupel[ j ] );
                
            fi;
            
        od;
        
        j := HomalgMatrix( rayel, Length( M ), 1, HOMALG_MATRICES.ZZ );
        
        M := HomalgMatrix( M, HOMALG_MATRICES.ZZ );
        
        j := LeftDivide( M, j );
        
        if j = fail then
            
            return false;
            
        fi;
        
        cartdata[ i ] := HomalgModuleElement( j, CharacterLattice( AmbientToricVariety( divisor ) ) );
        
    od;
    
    return cartdata;
    
end );

##
InstallMethod( PolytopeOfDivisor,
               "for toric divisors",
               [ IsToricDivisor ],
               
  function( divisor )
    local rays, divlist;
    
    rays := RayGenerators( FanOfVariety( AmbientToricVariety( divisor ) ) );
    
    divlist := UnderlyingListOfRingElements( UnderlyingGroupElement( divisor ) );
    
    divlist := List( [ 1 .. Length( rays ) ], i -> Concatenation( [ divlist[ i ] ], rays[ i ] ) );
    
    return PolytopeByInequalities( divlist );
    
end );

##
InstallMethod( BasisOfGlobalSections,
               "for toric divisors",
               [ IsToricDivisor ],
               
  function( divisor )
    local points, divisor_polytope;
    
    divisor_polytope := PolytopeOfDivisor( divisor );
    
    if not IsBounded( divisor_polytope ) then
        
        Error( "list is infinite, cannot compute characters\n" );
        
    fi;
    
    points := LatticePoints( divisor_polytope );
    
    return List( points, i -> CharacterToRationalFunction( i, AmbientToricVariety( divisor ) ) );
    
end );

##
InstallMethod( IntegerForWhichIsSureVeryAmple,
               "for toric divisors",
               [ IsToricDivisor and IsAmple ],
               
  function( divisor )
    local vari;
    
    vari := AmbientToricVariety( divisor );
    
    if IsSmooth( vari ) and IsComplete( vari ) then
        
        return 1;
        
    fi;
    
    if Dimension( vari ) >= 2 then
        
        return Dimension( vari ) - 1;
        
    fi;
    
    TryNextMethod();
    
end );

##
InstallMethod( UnderlyingToricVariety,
               "for prime divisors",
               [ IsToricDivisor and IsPrimedivisor ],
               
  function( divisor )
    local pos, vari, cones, i, neuvar, ray;
    
    pos := Position( UnderlyingListOfRingElements( UnderlyingGroupElement( divisor ) ), 1 );
    
    vari := AmbientToricVariety( divisor );
    
    vari := FanOfVariety( vari );
    
    cones := RaysInMaximalCones( vari );
    
    neuvar := [ ];
    
    for i in [ 1 .. Length( cones ) ] do
        
        if cones[ i ][ pos ] = 1 then
            
            neuvar := Concatenation( neuvar, [ i ] );
            
        fi;
        
    od;
    
    ray := Rays( vari )[ pos ];
    
    ray := ByASmallerPresentation( FactorGridMorphism( ray ) );
    
    cones := MaximalCones( vari ){ neuvar };
    
    cones := List( cones, HilbertBasis );
    
    cones := List( cones, i -> List( i, j -> HomalgMap( HomalgMatrix( [ j ], HOMALG_MATRICES.ZZ ), 1 * HOMALG_MATRICES.ZZ, ContainingGrid( vari ) ) ) );
    
    cones := List( cones, i -> List( i, j -> UnderlyingListOfRingElements( ApplyMorphismToElement( ray, HomalgElement( j ) ) ) ) );
    
    cones := Fan( cones );
    
    neuvar := ToricSubvariety( ToricVariety( cones ), AmbientToricVariety( divisor ) );
    
    SetIsClosedSubvariety( neuvar, true );
    
    SetIsOpen( neuvar, false );
    
    return neuvar;
    
end );

##
InstallMethod( DegreeOfDivisor,
               "for toric divisors",
               [ IsToricDivisor ],
               
  function( divisor )
    
    return Sum( UnderlyingListOfRingElements( UnderlyingGroupElement( divisor ) ) );
    
end );

##
InstallMethod( MonomsOfCoxRingOfDegree,
               " for toric divisorsors",
               [ IsToricDivisor ],
               
  function( divisor )
    local cox_ring, ring, points, rays, n, i, j, mons, mon;
    
    if not HasCoxRing( AmbientToricVariety( divisor )  ) then
        
        Error( "specify cox ring first\n" );
        
    fi;
    
    cox_ring := CoxRing( AmbientToricVariety( divisor ) );
    
    ring := ListOfVariablesOfCoxRing( AmbientToricVariety( divisor ) );
    
    if not IsBounded( PolytopeOfDivisor( divisor ) ) then
        
        Error( "list is infinite, cannot compute basis because it is not finite\n" );
        
    fi;
    
    points := LatticePoints( PolytopeOfDivisor( divisor ) );
    
    rays := RayGenerators( FanOfVariety( AmbientToricVariety( divisor ) ) );
    
    divisor := UnderlyingListOfRingElements( UnderlyingGroupElement( divisor ) );
    
    n := Length( rays );
    
    mons := [ ];
    
    for i in points do
        
        mon := List( [ 1 .. n ], j -> JoinStringsWithSeparator( [ ring[ j ], String( ( Sum( List( [ 1 .. Length( i ) ], m -> rays[ j ][ m ] * i[ m ] ) ) ) + divisor[ j ] ) ], "^" ) );
        
        mon := JoinStringsWithSeparator( mon, "*" );
        
        Add( mons, HomalgRingElement( mon, cox_ring ) );
        
    od;
    
    return mons;
    
end );

##
InstallMethod( CoxRingOfTargetOfDivisorMorphism,
               "for basepoint free divisors",
               [ IsToricDivisor ],
               
  function( divisor )
    
    return CoxRingOfTargetOfDivisorMorphism( divisor, TORIC_VARIETIES.CoxRingIndet );
    
end );

##
InstallMethod( RingMorphismOfDivisor,
               "for basepoint free divisors",
               [ IsToricDivisor ],
               
  function( divisor )
    local coxring, images, var_coxring;
    
    coxring := CoxRingOfTargetOfDivisorMorphism( divisor );
    
    var_coxring := CoxRing( AmbientToricVariety( divisor ) );
    
    images := MonomsOfCoxRingOfDegree( divisor );
    
    return RingMap( images, coxring, var_coxring );
    
end );
    

#################################
##
## Methods
##
#################################

##
InstallMethod( CharactersForClosedEmbedding,
               "for toric varieties.",
               [ IsToricDivisor and IsVeryAmple ],
               
  function( divisor )
    
    return BasisOfGlobalSections( divisor );
    
end );

##
RedispatchOnCondition( CharactersForClosedEmbedding, true, [ IsToricDivisor ], [ IsVeryAmple ], 0 );

##
InstallMethod( VeryAmpleMultiple,
               " for ample toric divisorsors.",
               [ IsToricDivisor and IsAmple ],
               
  function( divisor )
    
    return IntegerForWhichIsSureVeryAmple( divisor ) * divisor;
    
end );

##
RedispatchOnCondition( VeryAmpleMultiple, true, [ IsToricDivisor ], [ IsAmple ], 0 );

##
InstallMethod( VarietyOfDivisorpolytope,
               " for ample divisorsors",
               [ IsToricDivisor and IsBasepointFree ],
               
  function( divisor )
    
    return ToricVariety( PolytopeOfDivisor( divisor ) );
    
end );

##
InstallMethod( MonomsOfCoxRingOfDegree,
               " for homalg elements",
               [ IsToricVariety, IsHomalgElement ],
               
  function( vari, elem )
    local pos;
    
    if not IsIdenticalObj( Range( UnderlyingMorphism( elem ) ), ClassGroup( vari ) ) then
        
        Error( "wrong element\n" );
        
    fi;
    
    pos := UnderlyingListOfRingElements( elem );
    
    pos := Divisor( pos, vari );
    
    return MonomsOfCoxRingOfDegree( pos );
    
end );

##
InstallMethod( MonomsOfCoxRingOfDegree,
               " for lists",
               [ IsToricVariety, IsList ],
               
  function( vari, lis )
    local pos, elem, mor;
    
    elem := HomalgMatrix( lis, 1, Length( lis ), HOMALG_MATRICES.ZZ );
    
    elem := HomalgMap( elem, 1 * HOMALG_MATRICES.ZZ, TorusInvariantDivisorGroup( vari ) );
    
    elem := HomalgElement( elem );
    
    mor := CokernelEpi( MapFromCharacterToPrincipalDivisor( vari ) );
    
    elem := ApplyMorphismToElement( mor, elem );
    
    return MonomsOfCoxRingOfDegree( vari, elem );
    
end );

##
InstallMethod( CoxRingOfTargetOfDivisorMorphism,
               "for toric divisors",
               [ IsToricDivisor, IsString ],
               
  function( divisor, variable )
    local nrpoints, classgroup, degrees, coxring;
    
    if not IsBasepointFree( divisor ) then
        
        Error( "no embedding in projective variety defined\n" );
        
    fi;
    
    nrpoints := Length( LatticePoints( Polytope( divisor ) ) );
    
    classgroup := 1 * HOMALG_MATRICES.ZZ;
    
    coxring := DefaultFieldForToricVarieties() * JoinStringsWithSeparator( [ variable, JoinStringsWithSeparator( [ "1", String( nrpoints ) ], ".." ) ], "_" );
    
    coxring := GradedRing( coxring );
    
    SetDegreeGroup( coxring, classgroup );
    
    degrees := List( [ 1 .. nrpoints ], i -> GeneratingElements( classgroup )[ 1 ] );
    
    SetWeightsOfIndeterminates( coxring, degrees );
    
    return coxring;
    
end );

##
InstallMethod( \+,
               "for toric divisors",
               [ IsToricDivisor, IsToricDivisor ],
               
  function( divisor1, divisor2 )
    local sum_of_divisors;
    
    if not IsIdenticalObj( AmbientToricVariety( divisor1 ), AmbientToricVariety( divisor2 ) ) then
        
        Error( "cannot add these divisors\n" );
        
        return 0;
        
    fi;
    
    sum_of_divisors := Divisor( UnderlyingGroupElement( divisor1 ) + UnderlyingGroupElement( divisor2 ), AmbientToricVariety( divisor1 ) );
    
    SetClassOfDivisor( sum_of_divisors, ClassOfDivisor( divisor1 ) + ClassOfDivisor( divisor2 ) );
    
    return sum_of_divisors;
    
end );

##
InstallMethod( \-,
               "for toric divisor",
               [ IsToricDivisor , IsToricDivisor ],
               
  function( divisor1, divisor2 )
    
    return divisor1 + ( -1 ) * divisor2;
    
end );

##
InstallMethod( \*,
               "for toric divisorsors",
               [ IsInt, IsToricDivisor ],
               
  function( a, divisor )
    local divisor1;
    
    divisor1 := Divisor( a * UnderlyingGroupElement( divisor ), AmbientToricVariety( divisor ) );
    
    SetClassOfDivisor( divisor1, a * ClassOfDivisor( divisor ) );
    
    return divisor1;
    
end );

##
InstallMethod( AddDivisorToItsAmbientVariety,
               "for toric divisors",
               [ IsToricDivisor ],
               
  function( divisor )
    local ambient_variety;
    
    ambient_variety := AmbientToricVariety( divisor );
    
    Add( ambient_variety!.WeilDivisors, divisor );
    
end );

##
InstallMethod( Polytope,
               "for toric divisors",
               [ IsToricDivisor ],
               
  function( divisor )
    
    return PolytopeOfDivisor( divisor );
    
end );

##
InstallMethod( \=,
               "for toric divisors",
               [ IsToricDivisor, IsToricDivisor ],
               
  function( divi1, divi2 )
    
    return UnderlyingGroupElement( divi1 ) = UnderlyingGroupElement( divi2 );
    
end );

##################################
##
## Constructors
##
##################################

##
InstallMethod( Divisor,
               " for toric varieties",
               [ IsHomalgElement, IsToricVariety ],
               
  function( group_element, variety )
    local divisor;
    
    divisor := rec( );
    
    ObjectifyWithAttributes(
                            divisor, TheTypeToricDivisor,
                            AmbientToricVariety, variety,
                            UnderlyingGroupElement, group_element
    );
    
    AddDivisorToItsAmbientVariety( divisor );
    
    return divisor;
    
end );

##
InstallMethod( Divisor,
               "for toric varieties",
               [ IsList, IsToricVariety ],
               
  function( group_element, variety )
    local elem;
    
    group_element := HomalgMatrix( [ group_element ], HOMALG_MATRICES.ZZ );
    
    group_element := HomalgMap( group_element, 1 * HOMALG_MATRICES.ZZ, TorusInvariantDivisorGroup( variety ) );
    
    group_element := HomalgElement( group_element );
    
    return Divisor( group_element, variety );
    
end );

##
InstallMethod( DivisorOfCharacter,
               " for toric varieties",
               [ IsHomalgElement, IsToricVariety ],
               
  function( character, variety )
    local group_element, divisor;
    
    group_element := ApplyMorphismToElement( MapFromCharacterToPrincipalDivisor( variety ), character );
    
    divisor := Divisor( group_element, variety );
    
    SetIsPrincipal( divisor, true );
    
    SetCharacterOfPrincipalDivisor( divisor, character );
    
    SetIsCartier( divisor, true );
    
    SetCartierData( divisor, List( MaximalCones( FanOfVariety( variety ) ), i -> ( -1 )* UnderlyingListOfRingElements( character ) ) );
    
    SetClassOfDivisor( divisor, TheZeroElement( ClassGroup( variety ) ) );
    
    AddDivisorToItsAmbientVariety( divisor );
    
    return divisor;
    
end );

##
InstallMethod( DivisorOfCharacter,
               " for toric varieties.",
               [ IsList, IsToricVariety ],
               
  function( character, variety )
    
    character := HomalgMatrix( [ character ], HOMALG_MATRICES.ZZ );
    
    character := HomalgMap( character, 1 * HOMALG_MATRICES.ZZ, CharacterLattice( variety ) );
    
    character := HomalgElement( character );
    
    return DivisorOfCharacter( character, variety );
    
end );

#################################
##
## View
##
#################################

##
InstallMethod( ViewObj,
               "for toric divisors",
               [ IsToricDivisor ],
               
  function( divisor )
    local prin;
    
    prin := false;
    
    Print( "<A" );
    
    if HasIsAmple( divisor ) then
        
        if HasIsVeryAmple( divisor ) then
            
            if IsVeryAmple( divisor ) then
                
                Print( " very ample" );
                
            elif IsAmple( divisor ) then
                
                Print( "n ample" );
                
            fi;
            
        elif IsAmple( divisor ) then
            
            Print( "n ample" );
            
        fi;
        
    fi;
    
    if HasIsBasepointFree( divisor ) then
        
        if IsBasepointFree( divisor ) then
            
            Print( " basepoint free" );
            
        fi;
        
    fi;
    
    if HasIsPrincipal( divisor ) then
        
        if IsPrincipal( divisor ) then
            
            Print( " principal" );
            
            prin := true;
            
        fi;
        
    fi;
    
    if HasIsCartier( divisor ) then
        
        if IsCartier( divisor ) and not prin then
            
            Print( " Cartier" );
            
        fi;
        
    fi;
    
    if HasIsPrimedivisor( divisor ) then
        
        if IsPrimedivisor( divisor ) then
            
            Print( " prime" );
            
        fi;
        
    fi;
    
    Print( " divisor of a toric variety with coordinates " );
    
    ViewObj( UnderlyingGroupElement( divisor ) );
    
    Print( ">" );
    
end );

##
InstallMethod( Display,
               "for toric divisors",
               [ IsToricDivisor ],
               
  function( divisor )
    local prin;
    
    prin := false;
    
    Print( "A" );
    
    if HasIsAmple( divisor ) then
        
        if HasIsVeryAmple( divisor ) then
            
            if IsVeryAmple( divisor ) then
                
                Print( " very ample" );
                
            elif IsAmple( divisor ) then
                
                Print( "n ample" );
                
            fi;
            
        elif IsAmple( divisor ) then
            
            Print( "n ample" );
            
        fi;
        
    fi;
    
    if HasIsBasepointFree( divisor ) then
        
        if IsBasepointFree( divisor ) then
            
            Print( " basepoint free" );
            
        fi;
        
    fi;
    
    if HasIsPrincipal( divisor ) then
        
        if IsPrincipal( divisor ) then
            
            Print( " principal" );
            
            prin := true;
            
        fi;
        
    fi;
    
    if HasIsCartier( divisor ) then
        
        if IsCartier( divisor ) and not prin then
            
            Print( " Cartier" );
            
        fi;
        
    fi;
    
    Print( " divisor of a toric variety" );
    
    Print( ".\n" );
    
end );
