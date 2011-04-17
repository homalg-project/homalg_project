#############################################################################
##
##  GradedRing.gi                                GradedRingForHomalg package
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
        IsStructureObjectOrFinitelyPresentedObjectRep,
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

##
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
InstallMethod( WeightsOfIndeterminates,
        "for homalg free polynomial rings",
        [ IsHomalgGradedRing and IsFreePolynomialRing ],
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
        [ IsHomalgGradedRing and IsExteriorRing ],
        
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
InstallMethod( WeightsOfIndeterminates,
        "for homalg graded rings",
        [ IsFieldForHomalg ],
        
  function( S )
    
    return [ ];
    
end );

##
InstallMethod( ListOfDegreesOfMultiGradedRing,
        "for homalg rings",
        [ IsInt, IsHomalgGradedRing, IsHomogeneousList ],	## FIXME: is IsHomogeneousList too expensive?
        
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

##
InstallMethod( GradedRing,
        "for graded homalg rings",
        [ IsHomalgGradedRingRep ],
        
  IdFunc );

##
InstallMethod( GradedRing,
        "for homalg rings",
        [ IsHomalgRing ],
        
  function( R )
    local RP, component, S, A, rel, c;
    
    ## create ring RP with R as underlying global ring
    RP := CreateHomalgTableForGradedRings( R );
    
    ## create the graded ring
    S := CreateHomalgRing( R, [ TheTypeHomalgGradedRing, ValueGlobal( "TheTypeHomalgHomogeneousMatrix" ) ], GradedRingElement, RP );
    SetConstructorForHomalgMatrices( S,
      function( arg )
        local nargs, R, mat, l;
        nargs := Length( arg );
        R := arg[nargs];
        l := Concatenation( arg{[ 1 .. nargs - 1 ]}, [ UnderlyingNonGradedRing( R ) ] );
        mat := CallFuncList( HomalgMatrix, l );
        return HomogeneousMatrix( mat, R );
      end
    );
    
    ## for the view methods:
    ## <An graded ring>
    ## <A matrix over an graded ring>
    S!.description := " graded";
    
    if HasZero( R ) then
        SetZero( S, GradedRingElement( Zero( R ), S ) );
    fi;
    
    if HasOne( R ) then
        SetOne( S, GradedRingElement( One( R ), S ) );
    fi;
    
    if HasMinusOne( R ) then
        SetMinusOne( S, GradedRingElement( MinusOne( R ), S ) );
    fi;
    
    if HasCoefficientsRing( R ) then
        SetCoefficientsRing( S, GradedRing( CoefficientsRing( R ) ) );
    fi;
    
    if HasRingRelations( R ) then
        A := GradedRing( AmbientRing( R ) );
        rel := RingRelations( R );
        if IsHomalgRingRelationsAsGeneratorsOfLeftIdeal( rel ) then
            rel := HomogeneousMatrix( MatrixOfRelations( rel ), A );
            rel := HomalgRingRelationsAsGeneratorsOfLeftIdeal( rel );
        else
            rel := HomogeneousMatrix( MatrixOfRelations( rel ), A );
            rel := HomalgRingRelationsAsGeneratorsOfRightIdeal( rel );
        fi;
        SetRingRelations( S, rel );
    fi;
    
    for c in LIGrRNG.ringelement_attributes do
        if Tester( c )( R ) then
            Setter( c )( S, List( c( UnderlyingNonGradedRing( S ) ), x -> GradedRingElement( x, S ) ) );
        fi;
    od;
    
    MatchPropertiesAndAttributes( R, S, LIRNG.intrinsic_properties, LIGrRNG.intrinsic_attributes );
    
    return S;
    
end );

##
InstallMethod( ExteriorRing,
        "for homalg rings",
        [ IsHomalgGradedRingRep and IsFreePolynomialRing, IsHomalgRing, IsList ],
        
  function( S, R, anti )
    local A;
    
    A := ExteriorRing( UnderlyingNonGradedRing( S ), R, anti );
    
    A := GradedRing( A );
    
    SetWeightsOfIndeterminates( A, -WeightsOfIndeterminates( S ) );
    
    return A;
    
end );

##
InstallMethod( ExteriorRing,
        "for homalg rings",
        [ IsHomalgGradedRingRep and IsFreePolynomialRing, IsHomalgGradedRingRep, IsList ],
        
  function( S, R, anti )
    local A;
    
    A := ExteriorRing( S, UnderlyingNonGradedRing( R ), anti );
    
    ResetFilterObj( A, CoefficientsRing );
    SetCoefficientsRing( A, R );
    
    return A;
    
end );

##
InstallMethod( PolynomialRing,
        "for homalg rings",
        [ IsHomalgGradedRingRep, IsList ],
        
  function( S, l )
    local R;
    
    R := GradedRing( PolynomialRing( UnderlyingNonGradedRing( S ), l ) );
    
    ResetFilterObj( R, CoefficientsRing );
    if HasCoefficientsRing( S ) then
        SetCoefficientsRing( R, CoefficientsRing( S ) );
    else
        SetCoefficientsRing( R, S ); 
    fi;
    
    return R;
    
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
            SetDegreeOfRingElement( r, degree );
        fi;
        
        return r;
    else
    
        Error( "No graded ring found in parameters" );
    
    fi;
    
end );

##
InstallMethod( \/,  ## this operation is declared in the file HomalgRelations.gd
        "constructor for homalg rings",
        [ IsHomalgGradedRingRep, IsHomalgRingRelations ],
        
  function( S, ring_rel )
    local left, result, mat, rel, rel_old, mat_old, left_old, c;
    
    left := IsHomalgRingRelationsAsGeneratorsOfLeftIdeal( ring_rel );
    
    mat := UnderlyingNonHomogeneousMatrix( MatrixOfRelations( ring_rel ) );
    
    if left then
      rel := HomalgRingRelationsAsGeneratorsOfLeftIdeal( mat );
    else
      rel := HomalgRingRelationsAsGeneratorsOfRightIdeal( mat );
    fi;
    
    result := GradedRing( UnderlyingNonGradedRing( S ) / rel );
    
    if HasContainsAField( S ) and ContainsAField( S ) then
        SetContainsAField( result, true );
        if HasCoefficientsRing( S ) then
            SetCoefficientsRing( result, CoefficientsRing( S ) );
        fi;
    fi;
    
    if HasAmbientRing( S ) then
      SetAmbientRing( result, AmbientRing( S ) );
    else
      SetAmbientRing( result, S );
    fi;
    
    return result;
    
end );


####################################
#
# View, Print, and Display methods:
#
####################################

##
InstallMethod( ViewObj,
        "for homalg graded ring elements",
        [ IsHomalgGradedRingElementRep ],
        
  function( o )
    
    ViewObj( UnderlyingNonGradedRingElement( o ) );
    
end );

##
InstallMethod( Display,
        "for graded homalg rings",
        [ IsHomalgGradedRingRep ],
        
  function( o )
    
    Display( UnderlyingNonGradedRing( o ) );
    
    Print( "(weights: ", WeightsOfIndeterminates( o ), ")\n" );
    
end );

##
InstallMethod( Display,
        "for homalg graded ring elements",
        [ IsHomalgGradedRingElementRep ],
        
  function( r )
    
    Display( UnderlyingNonGradedRingElement( r ) );
    
end );

