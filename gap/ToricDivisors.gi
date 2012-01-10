#############################################################################
##
##  ToricDivisors.gi     ToricVarietiesForHomalg package       Sebastian Gutsche
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
               " for toric divisors",
               [ IsToricDivisor ],
               
  function( divi )
    
    return IsZero( ClassOfDivisor( divi ) );
    
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

#################################
##
## Methods
##
#################################

##
InstallMethod( AmbientToricVariety,
               " for toric divisors",
               [ IsToricDivisorRep ],
               
  function( divi )
    
    return divi!.AmbientToricVariety;
    
end );

##
InstallMethod( UnderlyingGroupElement,
               " for toric divisors",
               [ IsToricDivisorRep ],
               
  function( divi )
    
    return divi!.UnderlyingGroupElement;
    
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
    
    divi := rec( AmbientToricVariety := vari,
                 UnderlyingGroupElement := charac
            );
    
    ObjectifyWithAttributes(
                            divi, TheTypeToricDivisor
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
    
    elem := HomalgMap( elem, "free", DivisorGroup( vari ) );
    
    elem := HomalgElement( elem );
    
    return Divisor( elem, vari );
    
end );

##
InstallMethod( DivisorOfCharacter,
               " for toric varieties",
               [ IsHomalgElement, IsToricVariety ],
               
  function( charac, vari )
    local divi;
    
    divi := ApplyMorphismToElement( MapFromCharacterToPrincipalDivisor( vari ), charac );
    
    divi := rec( AmbientToricVariety := vari,
                 UnderlyingGroupElement := divi
            );
    
    ObjectifyWithAttributes(
                              divi, TheTypeToricDivisor
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
    
    elem := HomalgMap( elem, "free", CharacterGrid( vari ) );
    
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
    
    Print( " divisor of a toric variety" );
    
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
