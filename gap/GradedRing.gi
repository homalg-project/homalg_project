#############################################################################
##
##  GradedRing.gi           GradedRingForHomalg package      Mohamed Barakat
##                                                    Markus Lange-Hegermann
##
##  Copyright 2010, Mohamed Barakat, University of Kaiserslautern
##           Markus Lange-Hegermann, RWTH-Aachen University
##
##  Implementations of procedures for graded rings.
##
#############################################################################

####################################
#
# representations:
#
####################################

DeclareRepresentation( "IsHomalgGradedRingOrGradedModuleRep",
        IsHomalgRingOrFinitelyPresentedObjectRep,
        [ ] );

##  <#GAPDoc Label="IsHomalgGradedRingRep">
##  <ManSection>
##    <Filt Type="Representation" Arg="R" Name="IsHomalgGradedRingRep"/>
##    <Returns>true or false</Returns>
##    <Description>
##      The representation of &homalg; graded rings. <P/>
##      (It is a subrepresentation of the &GAP; representation <Br/>
##      <C>IsHomalgRingOrFinitelyPresentedModuleRep</C>.)
##    <Listing Type="Code"><![CDATA[
DeclareRepresentation( "IsHomalgGradedRingRep",
        IsHomalgGradedRing and
        IsHomalgGradedRingOrGradedModuleRep,
        [ "ring" ] );
##  ]]></Listing>
##    </Description>
##  </ManSection>
##  <#/GAPDoc>

##  <#GAPDoc Label="IsHomalgGradedRingElementRep">
##  <ManSection>
##    <Filt Type="Representation" Arg="r" Name="IsHomalgGradedRingElementRep"/>
##    <Returns>true or false</Returns>
##    <Description>
##      The representation of elements of &homalg; graded rings. <P/>
##      (It is a representation of the &GAP; category <C>IsHomalgRingElement</C>.)
##    <Listing Type="Code"><![CDATA[
DeclareRepresentation( "IsHomalgGradedRingElementRep",
        IsHomalgGradedRingElement,
        [ ] );
##  ]]></Listing>
##    </Description>
##  </ManSection>
##  <#/GAPDoc>

####################################
#
# families and types:
#
####################################

# a new family:
BindGlobal( "TheFamilyOfHomalgGradedRings",
        NewFamily( "TheFamilyOfHomalgGradedRings" ) );

# two new type:
BindGlobal( "TheTypeHomalgGradedRing",
        NewType( TheFamilyOfHomalgGradedRings,
                IsHomalgGradedRingRep ) );

BindGlobal( "TheTypeHomalgGradedRingElement",
        NewType( TheFamilyOfHomalgRingElements,
                IsHomalgGradedRingElementRep ) );

####################################
#
# methods for operations:
#
####################################

InstallMethod( UnderlyingNonGradedRingElement,
        "for homalg graded ring elements",
        [ IsHomalgGradedRingElementRep ],
        
  EvalRingElement );

##  <#GAPDoc Label="UnderlyingNonGradedRing:ring">
##  <ManSection>
##    <Oper Arg="R" Name="UnderlyingNonGradedRing" Label="for homalg graded rings"/>
##    <Returns>a &homalg; ring</Returns>
##    <Description>
##      Internally there is a ring, in which computations take place. This is either the global ring or a (not fully working) external ring in &Singular; with Mora's algorithm.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
InstallMethod( UnderlyingNonGradedRing,
        "for homalg graded rings",
        [ IsHomalgGradedRingRep ],
        
  function( R )
    
    return R!.ring;
    
end );

##  <#GAPDoc Label="UnderlyingNonGradedRing:element">
##  <ManSection>
##    <Oper Arg="r" Name="UnderlyingNonGradedRing" Label="for homalg graded ring elements"/>
##    <Returns>a &homalg; ring</Returns>
##    <Description>
##      Internally there is a ring, in which computations take place. This is either the global ring or a (not fully working) external ring in &Singular; with Mora's algorithm.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
InstallMethod( UnderlyingNonGradedRing,
        "for homalg graded ring elements",
        [ IsHomalgGradedRingElementRep ],
        
  function( r )
    
    return UnderlyingNonGradedRing( HomalgRing( r ) );
    
end );

##  <#GAPDoc Label="Name">
##  <ManSection>
##    <Oper Arg="r" Name="Name" Label="for homalg graded ring elements"/>
##    <Returns>a string</Returns>
##    <Description>
##      The name of the graded ring element <A>r</A>.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
InstallMethod( Name,
        "for homalg graded ring elements",
        [ IsHomalgGradedRingElementRep ],
        
  function( o )
    
    return Name( UnderlyingNonGradedRingElement( o ) );
    
end );

##
InstallMethod( String,
        "for homalg graded ring elements",
        [ IsHomalgGradedRingElementRep ],
        
  Name );

##
InstallMethod( BlindlyCopyRingPropertiesToGradedRing,	## under construction
        "for homalg rings",
        [ IsHomalgRing, IsHomalgGradedRingRep ],
        
  function( R, S )
    local c;
    
    if HasZero( R ) then
      SetZero( S, GradedRingElement( Zero( R ), S ) );
    fi;    
    if HasOne( R ) then
      SetOne( S, GradedRingElement( One( R ), S ) );
    fi;
    if HasMinusOne( R ) then
      SetMinusOne( S, GradedRingElement( MinusOne( R ), S ) );
    fi;     
    
    for c in [ RationalParameters, 
               IndeterminateCoordinatesOfRingOfDerivations, 
               IndeterminateDerivationsOfRingOfDerivations,
               IndeterminateAntiCommutingVariablesOfExteriorRing,
               IndeterminateAntiCommutingVariablesOfExteriorRing,
               IndeterminatesOfExteriorRing,
               CoefficientsRing,
               BaseRing
              ] do
        if Tester( c )( R ) then
            Setter( c )( S, c( R ) );
        fi;
    od;
    
end );

##
InstallMethod( WeightsOfIndeterminates,
        "for homalg free polynomial rings",
        [ IsHomalgRing and IsFreePolynomialRing ],
  function( S )
    local n, old_weights, m, ow1, l, weights;
    
    n := Length( IndeterminatesOfPolynomialRing( S ) );
    
    if HasBaseRing( S ) and HasIsFreePolynomialRing( S ) and IsFreePolynomialRing( S ) then
        
        old_weights := WeightsOfIndeterminates( BaseRing( S ) );
        
        m := Length( old_weights );
        
        ow1 := old_weights[1];
        
        if IsInt( ow1 ) then
            
            l := 1;
            
            weights := List( old_weights, w -> [ w, 0 ] );
            
        elif IsList( ow1 ) then
            
            l := Length( ow1 );
            
            weights := List( old_weights, w -> Concatenation( w, [ 0 ] ) );
            
        else
            Error( "the base ring has invalid first weight\n" );
        fi;
        
        Append( weights, List( [ 1 .. n - m ], i -> Concatenation( List( [ 1 .. l ], j -> 0 ), [ 1 ] ) ) );
        
        S!.WeightsCompatibleWithBaseRing := true;
        
        return weights;
    else
        return ListWithIdenticalEntries( n, 1 );
    fi;
    
end );

##
InstallMethod( WeightsOfIndeterminates,
        "for homalg exterior rings",
        [ IsHomalgRing and IsExteriorRing ],
        
  function( E )
    local n, old_weights, m, ow1, l, weights;
    
    n := Length( IndeterminatesOfExteriorRing( E ) );
    
    if HasBaseRing( E ) and HasIsExteriorRing( E ) and IsExteriorRing( E ) then
        
        old_weights := WeightsOfIndeterminates( BaseRing( E ) );
        
        m := Length( old_weights );
        
        ow1 := old_weights[1];
        
        if IsInt( ow1 ) then
            
            l := 1;
            
            weights := List( old_weights, w -> [ w, 0 ] );
            
        elif IsList( ow1 ) then
            
            l := Length( ow1 );
            
            weights := List( old_weights, w -> Concatenation( w, [ 0 ] ) );
            
        else
            Error( "the base ring has invalid first weight\n" );
        fi;
        
        Append( weights, List( [ 1 .. n - m ], i -> Concatenation( List( [ 1 .. l ], j -> 0 ), [ 1 ] ) ) );
        
        E!.WeightsCompatibleWithBaseRing := true;
        
        return weights;
    else
        return ListWithIdenticalEntries( n, 1 );
    fi;
    
end );

##
InstallMethod( ListOfDegreesOfMultiGradedRing,
        "for homalg rings",
        [ IsInt, IsHomalgRing, IsHomogeneousList ],	## FIXME: is IsHomogeneousList too expensive?
        
  function( l, R, weights )
    local indets, n, B, j, w, wlist, i, k;
    
    if l < 1 then
        Error( "the first argument must be a positiv integer\n" );
    fi;
    
    indets := Indeterminates( R );
    
    if not Length( weights ) = Length( indets ) then
        Error( "there must be as many weights as indeterminates\n" );
    fi;
    
    if IsList( weights[1] ) and Length( weights[1] ) = l then
        return List( [ 1 .. l ], i -> List( weights, w -> w[i] ) );
    fi;
    
    ## the rest handles the (improbable?) case of successive extensions
    ## without multiple weights
    
    if l = 1 then
        return [ weights ];
    fi;
    
    n := Length( weights );
    
    if not HasBaseRing( R ) then
        Error( "no 1. base ring found\n" );
    fi;
    
    B := BaseRing( R );
    j := Length( Indeterminates( B ) );
    
    w := Concatenation(
                 ListWithIdenticalEntries( j, 0 ),
                 ListWithIdenticalEntries( n - j, 1 )
                 );
    
    wlist := [ ListN( w, weights, \* ) ];
    
    for i in [ 2 .. l - 1 ] do
        
        if not HasBaseRing( B ) then
            Error( "no ", i, ". base ring found\n" );
        fi;
        
        B := BaseRing( B );
        k := Length( Indeterminates( B ) );
        
        w := Concatenation(
                     ListWithIdenticalEntries( k, 0 ),
                     ListWithIdenticalEntries( j - k, 1 ),
                     ListWithIdenticalEntries( n - j, 0 )
                     );
        
        Add( wlist, ListN( w, weights, \* ) );
        
        j := k;
        
    od;
    
    w := Concatenation(
                 ListWithIdenticalEntries( j, 1 ),
                 ListWithIdenticalEntries( n - j, 0 )
                 );
    
    Add( wlist, ListN( w, weights, \* ) );
    
    return wlist;
    
end );

##
InstallMethod( HasDegreeMultivariatePolynomial,
        "for homalg graded rings",
        [ IsHomalgGradedRingElementRep ],
        
  function( r )
    
    return IsBound( r!.DegreeMultivariatePolynomial );
    
end );

##
InstallMethod( DegreeMultivariatePolynomial,
        "for homalg graded rings",
        [ IsHomalgGradedRingElementRep ],
        
  function( r )
    
    if not HasDegreeMultivariatePolynomial( r ) then
      r!.DegreeMultivariatePolynomial := DegreeMultivariatePolynomial( UnderlyingNonGradedRingElement( r ) );
    fi;
    
    return r!.DegreeMultivariatePolynomial;
    
end );

##
InstallMethod( homalgStream,
        "for homalg graded rings",
        [ IsHomalgGradedRingRep ],
        
  function( S )
  
    return homalgStream( UnderlyingNonGradedRing( S ) );
  
end );

####################################
#
# constructor functions and methods:
#
####################################

InstallMethod( GradedRing,
        "For graded homalg rings",
        [ IsHomalgGradedRingRep ],
  function( R )
    return R;
end );

InstallMethod( GradedRing,
        "For homalg rings",
        [ IsHomalgRing ],
  function( R )
  local RP, component, S;
    
    ## create ring RP with R as underlying global ring
    RP := CreateHomalgTableForGradedRings( R );
    
    S := CreateHomalgRing( R, [ TheTypeHomalgGradedRing, ValueGlobal( "TheTypeHomalgHomogeneousMatrix" ) ], GradedRingElement, RP );
    SetConstructorForHomalgMatrices( S, 
      function( arg )
      local R, mat, l;
        R := arg[Length( arg )];
        l := Concatenation( arg{ [ 1 .. Length( arg ) - 1 ] }, [ UnderlyingNonGradedRing( arg[ Length( arg ) ] ) ] );
        mat := CallFuncList( HomalgMatrix, l );
        return HomogeneousMatrix( mat, R );
      end
    );
    
    BlindlyCopyRingPropertiesToGradedRing( R, S );
    
    S!.description := "graded";
    
    SetWeightsOfIndeterminates( S, WeightsOfIndeterminates( R ) );
    
    if HasKrullDimension( R ) then
      SetKrullDimension( S, KrullDimension( R ) );
    fi;
    
#     MatchPropertiesAndAttributes( R, S, LIRNG.intrinsic_properties, LIRNG.intrinsic_attributes );

    return S;

end );

InstallMethod( ExteriorRing,
        "For homalg rings",
        [ IsHomalgGradedRingRep and IsFreePolynomialRing, IsHomalgRing, IsList ],
  function( S, R, anti )
    return ExteriorRing( UnderlyingNonGradedRing( S ), R, anti );
end );

InstallMethod( ExteriorRing,
        "For homalg rings",
        [ IsHomalgGradedRingRep and IsFreePolynomialRing, IsHomalgGradedRingRep, IsList ],
  function( S, R, anti )
    return ExteriorRing( S, UnderlyingNonGradedRing( R ), anti );
end );

##  <#GAPDoc Label="HomalgGradedRingElement">
##  <ManSection>
##    <Func Arg="numer, denom, R" Name="HomalgGradedRingElement" Label="constructor for graded ring elements using numerator and denominator"/>
##    <Func Arg="numer, R" Name="HomalgGradedRingElement" Label="constructor for graded ring elements using a given numerator and one as denominator"/>
##    <Returns>a graded ring element</Returns>
##    <Description>
##      Creates the graded ring element <M><A>numer</A>/<A>denom</A></M> or in the second case <M><A>numer</A>/1</M> for the graded ring <A>R</A>. Both <A>numer</A> and <A>denom</A> may either be a string describing a valid global ring element or from the global ring or computation ring.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
InstallGlobalFunction( GradedRingElement,
  function( arg )
    local nargs, el, S, ar, properties, R, degree, c, r;
    
    nargs := Length( arg );
    
    if nargs = 0 then
        Error( "empty input\n" );
    fi;
    
    el := arg[1];
    
    if IsHomalgGradedRingElementRep( el ) then
      
      return el;
    
    elif nargs = 2 then
        
        ## extract the properties of the global ring element
        if IsHomalgGradedRing( arg[2] ) then
          S := arg[2];
          ar := [ el, S ];
          properties := KnownTruePropertiesOfObject( el );	## FIXME: a huge potential for problems
          Add( ar, List( properties, ValueGlobal ) );  ## at least an empty list is inserted; avoids infinite loops
          return CallFuncList( GradedRingElement, ar );
        else
          Error( "Expected a ring element and a ring" );
        fi;
        
    fi;
    
    properties := [ ];
    
    for ar in arg{[ 2 .. nargs ]} do
        if not IsBound( S ) and IsHomalgGradedRing( ar ) then
            S := ar;
        elif IsList( ar ) and ForAll( ar, IsFilter ) then
            Append( properties, ar );
        elif not IsBound( degree ) and ( ( IsHomogeneousList( ar ) and ForAll( ar, IsInt ) ) or IsInt( ar ) ) then
            Append( properties, ar );
        else
            Error( "this argument (now assigned to ar) should be in { IsHomalgRing, IsList( IsFilter )}\n" );
        fi;
    od;
    
    R := UnderlyingNonGradedRing( S );
    
    if not IsHomalgRingElement( el ) or not IsIdenticalObj( R, HomalgRing( el ) ) then
      el := HomalgRingElement( el, R );
    fi;
    
    if IsBound( S ) then
        r := rec( 
          ring := S
        );
        ## Objectify:
        ObjectifyWithAttributes( 
          r, TheTypeHomalgGradedRingElement,
          EvalRingElement, el
        );
    
        if properties <> [ ] then
            for ar in properties do
                Setter( ar )( r, true );
            od;
        fi;
        
        if IsBound( degree ) then
          r!.DegreeMultivariatePolynomial := degree;
        fi;
        
        return r;
    else
    
        Error( "No graded ring found in parameters" );
    
    fi;
    
end );

####################################
#
# View, Print, and Display methods:
#
####################################

##
InstallMethod( ViewObj,
        "for homalg graded rings",
        [ IsHomalgGradedRingRep ],
        
  function( o )
    
    Print( "<A graded ring>" );
    
end );

##
InstallMethod( ViewObj,
        "for homalg graded ring elements",
        [ IsHomalgGradedRingElementRep ],
        
  function( o )
    
    ViewObj( UnderlyingNonGradedRingElement( o ) );
    
    Print( "\n" );
    
end );

##
InstallMethod( Display,
        "for graded homalg rings",
        [ IsHomalgGradedRingRep ],
        
  function( o )
    
    Display( UnderlyingNonGradedRing( o ) );
    
    Print( "(weights: ", WeightsOfIndeterminates( Indeterminates( o ) ), ")\n" );
    
end );

##
InstallMethod( Display,
        "for homalg graded ring elements",
        [ IsHomalgGradedRingElementRep ],
        
  function( r )
    
    Display( UnderlyingNonGradedRingElement( r ) );
    
end );

