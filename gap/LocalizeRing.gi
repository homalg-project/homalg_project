#############################################################################
##
##  LocalRing.gi    LocalizeRingForHomalg package            Mohamed Barakat
##                                                    Markus Lange-Hegermann
##
##  Copyright 2009, Mohamed Barakat, Universität des Saarlandes
##           Markus Lange-Hegermann, RWTH-Aachen University
##
##  Implementations of procedures for localized rings.
##
#############################################################################

# a new representation for the GAP-category IsHomalgRing
# which are subrepresentations of IsHomalgRingOrFinitelyPresentedModuleRep:

##  <#GAPDoc Label="IsHomalgLocalRingRep">
##  <ManSection>
##    <Filt Type="Representation" Arg="R" Name="IsHomalgLocalRingRep"/>
##    <Returns>true or false</Returns>
##    <Description>
##      The representation of &homalg; local rings. <Br/><Br/>
##      (It is a subrepresentation of the &GAP; representation <Br/>
##      <C>IsHomalgRingOrFinitelyPresentedModuleRep</C>.)
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareRepresentation( "IsHomalgLocalRingRep",
        IsHomalgRing and IsHomalgRingOrFinitelyPresentedModuleRep,
        [ "ring", "homalgTable" ] );

##  <#GAPDoc Label="IsHomalgLocalRingElementRep">
##  <ManSection>
##    <Filt Type="Representation" Arg="r" Name="IsHomalgLocalRingElementRep"/>
##    <Returns>true or false</Returns>
##    <Description>
##      The representation of elements of external &homalg; rings. <P/>
##      (It is a representation of the &GAP; category <Ref Filt="IsHomalgNonBuiltInRingElement"/>.)
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareRepresentation( "IsHomalgLocalRingElementRep",
        IsHomalgNonBuiltInRingElement,
        [ "pointer" ] );

## a new type:
BindGlobal( "TheTypeHomalgLocalRing",
        NewType( TheFamilyOfHomalgRings,
                IsHomalgLocalRingRep ) );

## a new family:
BindGlobal( "TheFamilyOfHomalgLocalRingElements",
        NewFamily( "TheFamilyOfHomalgLocalRingElements" ) );

## a new type:
BindGlobal( "TheTypeHomalgLocalRingElement",
        NewType( TheFamilyOfHomalgLocalRingElements,
                IsHomalgLocalRingElementRep ) );

####################################
#
# methods for operations:
#
####################################

##
InstallMethod( HomalgRing,
        "for homalg local ring elements",
        [ IsHomalgLocalRingElementRep ],
        
  function( r )
    
    return r!.ring;
    
end );

##
InstallMethod( AssociatedGlobalRing,
        "for homalg local rings",
        [ IsHomalgLocalRingRep ],
        
  function( R )
    
    return R!.ring;
    
end );

##
InstallMethod( AssociatedGlobalRing,
        "for homalg local ring elements",
        [ IsHomalgLocalRingElementRep ],
        
  function( r )
    
    return AssociatedGlobalRing( HomalgRing( r ) );
    
end );

##
InstallMethod( NumeratorOfLocalElement,
        "for homalg local ring elements",
        [ IsHomalgLocalRingElementRep ],
        
  function( r )
    
    return r!.numer;
    
end );

##
InstallMethod( DenominatorOfLocalElement,
        "for homalg local ring elements",
        [ IsHomalgLocalRingElementRep ],
        
  function( r )
    
    return r!.denom;
    
end );

##
InstallMethod( Name,
        "for homalg external ring elements",
        [ IsHomalgLocalRingElementRep ],

  function( o )
    
    return Flat( [ Name( NumeratorOfLocalElement( o ) ), "/",  Name( DenominatorOfLocalElement( o ) ) ] );

end );

####################################
#
# constructor functions and methods:
#
####################################

##
InstallMethod( LocalizeAt,
        "constructor for localized rings",
        [ IsHomalgExternalRingRep and IsFreePolynomialRing ],
	
  function( globalR )
    local RP, localR;
    
    ## create ring RP with R as underlying global ring
    RP := CreateHomalgTableForLocalizedRings( globalR );
    
    ## create the local ring
    localR := CreateHomalgRing( globalR, TheTypeHomalgLocalRing, HomalgLocalRingElement, RP );
    
    SetIsLocalRing( localR, true );
    
    return localR;
    
end );

##
InstallGlobalFunction( HomalgLocalRingElement,
  function( arg )
    local nargs, numer, ring, ar, properties, denom, r;
    
    nargs := Length( arg );
    
    if nargs = 0 then
        Error( "empty input\n" );
    fi;
    
    numer := arg[1];
    
    if IsHomalgLocalRingElementRep( numer ) then
        
        ## otherwise simply return it
        return numer;
        
    elif IsHomalgExternalRingElementRep( numer ) and nargs = 2 then
        
        ## rebuild an external ring element if a ring is provided as a second argument
        if IsHomalgRing( arg[2] ) then
            ring := arg[2];
            ar := [ numer, ring ];
            properties := KnownTruePropertiesOfObject( numer );
            Append( ar, List( properties, ValueGlobal ) );
            return CallFuncList( HomalgLocalRingElement, ar );
        fi;
        
    fi;
    
    properties := [ ];
    
    for ar in arg{[ 2 .. nargs ]} do
        if not IsBound( ring ) and IsHomalgRing( ar ) then
            ring := ar;
        elif IsFilter( ar ) then
            Add( properties, ar );
        elif not IsBound( denom ) and IsRingElement( ar ) then
            denom := ar;
        else
            Error( "this argument (now assigned to ar) should be in { IsHomalgRing, IsRingElement, IsFilter }\n" );
        fi;
    od;
    
    if not IsBound( denom ) then
        denom := One( numer );
    fi;
    
    if IsBound( ring ) then
        
        r := rec( numer := numer, denom := denom, ring := ring );
        
        ## Objectify:
        Objectify( TheTypeHomalgLocalRingElement, r );
    fi;
    
    if properties <> [ ] then
        for ar in properties do
            Setter( ar )( r, true );
        od;
    fi;
    
    return r;
    
end );

####################################
#
# View, Print, and Display methods:
#
####################################

##
InstallMethod( ViewObj,
        "for homalg rings",
        [ IsHomalgLocalRingRep ],
        
  function( o )
    
    Print( "<A homalg local ring>" );
    
end );

