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

##################################
##
## Constructors
##
##################################


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
    
    SetClassOfDivisor( divi, Zero( ClassGroup( vari ) ) );
    
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
