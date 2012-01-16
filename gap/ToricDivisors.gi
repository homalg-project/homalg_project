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
                       [ "AmbientToricVariety", "UnderlyingGroupElement" ]
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
InstallTrueMethod( IsPrincipal, IsCartier );

##
InstallTrueMethod( IsAmple, IsBasepointFree );

##
InstallTrueMethod( IsAmple, IsCartier );

##
InstallMethod( IsPrincipal,
               " for toric divisors",
               [ IsToricDivisor ],
               
  function( divi )
    
    return IsZero( ClassOfDivisor( divi ) );
    
end );

##
InstallMethod( IsCartier,
               " for toric divisors",
               [ IsToricDivisor ],
               
  function( divi )
    local raysincones, rays, n, i, m, j, M, groupel, rayel, cartdata;
    
    if IsFanRep( AmbientToricVariety( divi ) ) then
        
        rays := RayGenerators( UnderlyingConvexObject( AmbientToricVariety( divi ) ) );
        
        raysincones := RaysInMaximalCones( UnderlyingConvexObject( AmbientToricVariety( divi ) ) );
        
        n := Length( raysincones );
        
        m := Length( rays );
        
        cartdata := [ 1 .. n ];
        
        groupel := UnderlyingListOfRingElements( UnderlyingGroupElement( divi ) );
        
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
        
        SetCartierData( divi, cartdata );
        
        return true;
        
    fi;
    
    TryNextMethod();
    
end );

##
InstallMethod( IsAmple,
               " for toric divisors",
               [ IsToricDivisor ],
               
  function( divi )
    local rays, raysincones, cartdata, groupel, l, i, multlist, j;
    
    rays := AmbientToricVariety( divi );
    
    if not IsComplete( rays ) or not IsNormalVariety( rays ) then
        
        Error( " computation may be wrong up to unfulfilled preconditions." );
        
    fi;
    
    if not IsBasepointFree( divi ) then
        
        return false;
        
    fi;
    
    if IsFanRep( AmbientToricVariety( divi ) ) then
        
        groupel := UnderlyingListOfRingElements( UnderlyingGroupElement( divi ) );
        
        l := Length( groupel );
        
        Apply( groupel, i -> -i );
        
        rays := RayGenerators( UnderlyingConvexObject( AmbientToricVariety( divi ) ) );
        
        cartdata := CartierData( divi );
        
        raysincones := RaysInMaximalCones( UnderlyingConvexObject( AmbientToricVariety( divi ) ) );
        
        for i in [ 1 .. Length( cartdata ) ] do
            
            for j in [ 1 .. l ] do
                
                if raysincones[ i ][ j ] = 0 then
                    
                    multlist := rays[ j ] * cartdata[ i ];
                    
                    if multlist <= groupel[ j ] then
                        
                        return false;
                        
                    fi;
                    
                fi;
                
            od;
            
        od;
        
        return true;
        
    fi;
    
    TryNextMethod();
    
end );

##
InstallMethod( IsBasepointFree,
               " for toric divisors",
               [ IsToricDivisor ],
               
  function( divi )
    local rays, cartdata, groupel, l, i, multlist, j;
    
    if HasTorusfactor( AmbientToricVariety( divi ) ) then
        
        Error( " variety has torusfactors, computation may be wrong." );
        
    fi;
    
    if not IsCartier( divi ) then
        
        return false;
        
    fi;
    
    if IsFanRep( AmbientToricVariety( divi ) ) then
        
        groupel := UnderlyingListOfRingElements( UnderlyingGroupElement( divi ) );
        
        l := Length( groupel );
        
        Apply( groupel, i -> -i );
        
        rays := RayGenerators( UnderlyingConvexObject( AmbientToricVariety( divi ) ) );
        
        cartdata := CartierData( divi );
        
        for i in cartdata do
            
            multlist := rays * i;
            
            if not ForAll( [ 1..l ], j -> multlist[ j ] >= groupel[ j ] ) then
                
                return false;
                
            fi;
            
        od;
        
        return true;
        
    fi;
    
    TryNextMethod();
    
end );

#################################
##
## Attributes
##
#################################

##
InstallMethod( ClassOfDivisor,
               " for toric divisors",
               [ IsToricDivisor ],
               
  function( divi )
    local groupelem, coker;
    
    coker := CokernelEpi( MapFromCharacterToPrincipalDivisor( AmbientToricVariety( divi ) ) );
    
    groupelem := ApplyMorphismToElement( coker, UnderlyingGroupElement( divi ) );
    
    return groupelem;
    
end );

##
InstallMethod( PolytopeOfDivisor,
               " for toric divisors",
               [ IsToricDivisor ],
               
  function( divi )
    local rays, divlist;
    
    rays := RayGenerators( UnderlyingConvexObject( AmbientToricVariety( divi ) ) );
    
    divlist := UnderlyingListOfRingElements( UnderlyingGroupElement( divi ) );
    
    divlist := List( [ 1 .. Length( rays ) ], i -> Concatenation( [ divlist[ i ] ], rays[ i ] ) );
    
    return HomalgPolytopeByInequalities( divlist );
    
end );

##
InstallMethod( BasisOfGlobalSectionsOfDivisorSheaf,
               " for toric divisor",
               [ IsToricDivisor ],
               
  function( divi )
    local points;
    
    points := LatticePoints( PolytopeOfDivisor( divi ) );
    
    return List( points, i -> CharacterToRationalFunction( i, AmbientToricVariety( divi ) ) );
    
end );

##
InstallMethod( IntegerForWhichIsSureVeryAmple,
               " for toric divisors.",
               [ IsToricDivisor and IsAmple ],
               
  function( divi )
    local vari;
    
    vari := AmbientToricVariety( divi );
    
    if IsSmooth( vari ) and IsComplete( vari ) then
        
        return 1;
        
    fi;
    
    if Dimension( vari ) >= 2 then
        
        return Dimension( vari ) - 1;
        
    fi;
    
    TryNextMethod();
    
end );

#################################
##
## Methods
##
#################################

# # ##
# # InstallMethod( AmbientToricVariety,
# #                " for toric divisors",
# #                [ IsToricDivisorRep ],
# #                
# #   function( divi )
# #     
# #     return divi!.AmbientToricVariety;
# #     
# # end );
# # 
# # ##
# # InstallMethod( UnderlyingGroupElement,
# #                " for toric divisors",
# #                [ IsToricDivisorRep ],
# #                
# #   function( divi )
# #     
# #     return divi!.UnderlyingGroupElement;
# #     
# # end );

##
InstallMethod( CharactersForClosedEmbedding,
               " for toric varieties.",
               [ IsToricDivisor ],
               
  function( divi )
    
    if IsVeryAmple( divi ) then
        
        return BasisOfGlobalSectionsOfDivisorSheaf( divi );
        
    fi;
    
    Error( " divisor is not very ample" );
    
    TryNextMethod();
    
end );

##
InstallMethod( VeryAmpleMultiple,
               " for ample toric divisors.",
               [ IsToricDivisor ],
               
  function( divi )
    
    if not IsAmple( divi ) then
        
        Error( " a non ample divisor has no very ample multiple" );
        
    fi;
    
    return IntegerForWhichIsSureVeryAmple( divi ) * divi;
    
end );

##
InstallMethod( \+,
               " for toric divisors",
               [ IsToricDivisor, IsToricDivisor ],
               
  function( div1, div2 )
    local div;
    
    if not IsIdenticalObj( AmbientToricVariety( div1 ), AmbientToricVariety( div2 ) ) then
        
        Error( "cannot add these divisors." );
        
        return 0;
        
    fi;
    
    div := Divisor( UnderlyingGroupElement( div1 ) + UnderlyingGroupElement( div2 ), AmbientToricVariety( div1 ) );
    
    SetClassOfDivisor( div, ClassOfDivisor( div1 ) + ClassOfDivisor( div2 ) );
    
    return div;
    
end );

##
InstallMethod( \*,
               " for toric divisors",
               [ IsInt, IsToricDivisor ],
               
  function( a, div )
    local div1;
    
    div1 := Divisor( a * UnderlyingGroupElement( div ), AmbientToricVariety( div ) );
    
    SetClassOfDivisor( div1, a * ClassOfDivisor( div ) );
    
    return div1;
    
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
               
  function( charac, vari )
    local divi;
    
    divi := rec( );
    
    ObjectifyWithAttributes(
                            divi, TheTypeToricDivisor,
                            AmbientToricVariety, vari,
                            UnderlyingGroupElement, charac
    );
    
    return divi;
    
end );

##
InstallMethod( Divisor,
               " for toric varieties",
               [ IsList, IsToricVariety ],
               
  function( charac, vari )
    local elem;
    
    elem := HomalgMatrix( [ charac ], HOMALG_MATRICES.ZZ );
    
    elem := HomalgMap( elem, 1 * HOMALG_MATRICES.ZZ, DivisorGroup( vari ) );
    
    elem := HomalgElement( elem );
    
    return Divisor( elem, vari );
    
end );

##
InstallMethod( DivisorOfCharacter,
               " for toric varieties",
               [ IsHomalgElement, IsToricVariety ],
               
  function( charac, vari )
    local divi;
    
    charac := ApplyMorphismToElement( MapFromCharacterToPrincipalDivisor( vari ), charac );
    
    divi := rec( );
    
    ObjectifyWithAttributes(
                            divi, TheTypeToricDivisor,
                            AmbientToricVariety, vari,
                            UnderlyingGroupElement, charac
    );
    
    
    SetIsPrincipal( divi, true );
    
    SetCharacterOfPrincipalDivisor( divi, charac );
    
    SetIsCartier( divi, true );
    
    SetCartierData( divi, [ charac ] );
    
    SetClassOfDivisor( divi, TheZeroElement( ClassGroup( vari ) ) );
    
    return divi;
    
end );

##
InstallMethod( DivisorOfCharacter,
               " for toric varieties.",
               [ IsList, IsToricVariety ],
               
  function( charac, vari )
    local elem;
    
    elem := HomalgMatrix( [ charac ], HOMALG_MATRICES.ZZ );
    
    elem := HomalgMap( elem, 1 * HOMALG_MATRICES.ZZ, CharacterGrid( vari ) );
    
    elem := HomalgElement( elem );
    
    return DivisorOfCharacter( elem, vari );
    
end );

#################################
##
## View
##
#################################

##
InstallMethod( ViewObj,
               " for toric divisors",
               [ IsToricDivisor ],
               
  function( divi )
    
    Print( "<A" );
    
    if HasIsPrincipal( divi ) then
        
        if IsPrincipal( divi ) then
            
            Print( " principal" );
            
        fi;
        
    fi;
    
    if HasIsCartier( divi ) then
        
        if IsCartier( divi ) then
            
            Print( " Cartier" );
            
        fi;
        
    fi;
    
    if HasIsPrimedivisor( divi ) then
        
        if IsPrimedivisor( divi ) then
            
            Print( " prime" );
            
        fi;
        
    fi;
    
    Print( " divisor of a toric variety with group element " );
    
    ViewObj( UnderlyingGroupElement( divi ) );
    
    Print( ">" );
    
end );

##
InstallMethod( Display,
               " for toric divisors",
               [ IsToricDivisor ],
               
  function( divi )
    
    Print( "A " );
    
    if HasIsPrincipal( divi ) then
        
        if IsPrincipal( divi ) then
            
            Print( " principal" );
            
        fi;
        
    fi;
    
    if HasIsCartier( divi ) then
        
        if IsCartier( divi ) then
            
            Print( " Cartier" );
            
        fi;
        
    fi;
    
    Print( " divisor of a toric variety" );
    
    Print( "." );
    
end );
