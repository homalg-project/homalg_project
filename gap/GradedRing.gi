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
InstallMethod( Degree,
        "for homalg graded ring elements",
        [ IsHomalgGradedRingElementRep ],
        
  DegreeOfRingElement );

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
##      Internally there is a ring, in which computations take place.
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
##      Internally there is a ring, in which computations take place.
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
        
  function( r )
    
    return String( EvalRingElement( r ) );
    
end );

##
InstallMethod( Indeterminates,
        "for homalg graded rings",
        [ IsHomalgGradedRing ],
        
  function( R )
    
    return List( Indeterminates( UnderlyingNonGradedRing( R ) ), a -> a / R );
    
end );

##
InstallMethod( DegreeGroup,
        "for a graded ring",
        [ IsHomalgGradedRing ],
        
  function( S )
    
    if not IsBound( S!.DegreeGroup ) then
    
        WeightsOfIndeterminates( S );
    
    fi;
    
    return S!.DegreeGroup;
    
end );

##
InstallMethod( WeightsOfIndeterminates,
        "for homalg free polynomial rings",
        [ IsHomalgGradedRing and IsFreePolynomialRing ],
        
  function( S )
    local indets, n, BaseRingDegreeGroup, old_weights, A, gens, B, iota, m, weights;
    
    if IsBound( S!.WeightsOfIndeterminates ) then
        
        return S!.WeightsOfIndeterminates;
        
    fi;
    
    indets := IndeterminatesOfPolynomialRing( S );
    
    n := Length( indets );
    
    if HasBaseRing( S ) and HasIsFreePolynomialRing( S ) and IsFreePolynomialRing( S ) then
        
        BaseRingDegreeGroup := DegreeGroup( BaseRing( S ) );
        
        old_weights := WeightsOfIndeterminates( BaseRing( S ) );
        
        A := 1 * HOMALG_MATRICES.ZZ;
        
        ## gens has precisely one entry which is 1
        gens := GeneratingElements( A );
        
        B := BaseRingDegreeGroup + A;
        
        SetDegreeGroup( S, B );
        
        iota := MonoOfLeftSummand( B );
        
        weights := List( old_weights, w -> ApplyMorphismToElement( iota, w ) );
        
        iota := MonoOfRightSummand( B );
        
        m := Length( old_weights );
        
        Append( weights, ListWithIdenticalEntries( n - m, ApplyMorphismToElement( iota, gens[1] ) ) );
        
        S!.WeightsCompatibleWithBaseRing := true;
        
    else
        
        ## if A is a direct sum then MonoOfLeftSummand and MonoOfRightSummand are set
        A := 0 * HOMALG_MATRICES.ZZ + 1 * HOMALG_MATRICES.ZZ;
        
        SetDegreeGroup( S, A );
        
        gens := GeneratingElements( A );
        
        weights := ListWithIdenticalEntries( n, gens[1] );
        
    fi;
    
    Perform( [ 1 .. n ], function( i ) SetDegreeOfRingElement( indets[i], weights[i] ); end );
    
    S!.WeightsOfIndeterminates := weights;
    
    return weights;
    
end );

##
InstallMethod( WeightsOfIndeterminates,
        "for homalg exterior rings",
        [ IsHomalgGradedRing and IsExteriorRing ],
        
  function( E )
    local indets, n, old_weights, BaseRingDegreeGroup, A, gens, B, iota, m, weights;
    
    if IsBound( E!.WeightsOfIndeterminates ) then
        
        return E!.WeightsOfIndeterminates;
        
    fi;
    
    indets := IndeterminatesOfExteriorRing( E );
    
    n := Length( indets );
    
    if HasBaseRing( E ) and HasIsExteriorRing( E ) and IsExteriorRing( E ) then
        
        old_weights := WeightsOfIndeterminates( BaseRing( E ) );
        
        BaseRingDegreeGroup := DegreeGroup( BaseRing( E ) );
        
        ## if A is a direct sum then MonoOfLeftSummand and MonoOfRightSummand are set
        A := 0 * HOMALG_MATRICES.ZZ + 1 * HOMALG_MATRICES.ZZ;
        
        gens := GeneratingElements( A ); #gens has precisely one entry which is 1
        
        B := BaseRingDegreeGroup + A;
        
        SetDegreeGroup( E, B );
        
        iota := MonoOfLeftSummand( B );
        
        weights := List( old_weights, w -> ApplyMorphismToElement( iota, w ) );
        
        iota := MonoOfRightSummand( B );
        
        m := Length( old_weights );
        
        Append( weights, ListWithIdenticalEntries( n - m, ApplyMorphismToElement( iota, gens[1] ) ) );
        
        E!.WeightsCompatibleWithBaseRing := true;
        
    else
        
        ## if A is a direct sum then MonoOfLeftSummand and MonoOfRightSummand are set
        A := 0 * HOMALG_MATRICES.ZZ + 1 * HOMALG_MATRICES.ZZ;
        
        SetDegreeGroup( E, A );
        
        gens := GeneratingElements( A );
        
        weights := ListWithIdenticalEntries( n, gens[1] );
        
    fi;
    
    Perform( [ 1 .. n ], function( i ) SetDegreeOfRingElement( indets[i], weights[i] ); end );
    
    E!.WeightsOfIndeterminates := weights;
    
    return weights;
    
end );

##
InstallMethod( WeightsOfIndeterminates,
        "for graded rings over residue class rings",
        [ IsHomalgGradedRing and HasAmbientRing ],
        
  function( S )
    
    return WeightsOfIndeterminates( AmbientRing( S ) );
    
end );

##
InstallMethod( WeightsOfIndeterminates,
        "for homalg graded rings",
        [ IsFieldForHomalg and IsHomalgGradedRing ],
        
  function( S )

    local A, gen_list;
    
    if IsBound( S!.WeightsOfIndeterminates ) then
        
        return S!.WeightsOfIndeterminates;
        
    fi;
    
    ## if A is a direct sum then MonoOfLeftSummand and MonoOfRightSummand are set
    A := 0 * HOMALG_MATRICES.ZZ + 0 * HOMALG_MATRICES.ZZ;
    
    SetDegreeGroup( S, A );
    
    gen_list := GeneratingElements( A );
    
    S!.WeightsOfIndeterminates := gen_list;
    
    return gen_list;
    
end );

##
InstallMethod( HasWeightsOfIndeterminates,
        "for homalg graded rings",
        [ IsHomalgGradedRing ],
        
  function( S )
    
    return IsBound( S!.WeightsOfIndeterminates );
    
end );

##
## There should be a warning: If you really want to use this method,
## make shure to use it right. It will not check if you have your weights
## right.
InstallMethod( SetWeightsOfIndeterminates,
        "for homalg graded rings",
        [ IsHomalgGradedRing, IsList ],
        
  function( S, weights )
    
    local L, i, l, A, gens, weight_list;
    
    if HasWeightsOfIndeterminates( S ) then
        Error( " WeightsOfIndeterminates already set, cannot reset an attribute.");
        return false;
    fi;
    
    if IsHomalgElement( weights[ 1 ] ) then
        
        if not HasDegreeGroup( S ) then
            
            SetDegreeGroup( S, SuperObject( weights[ 1 ] ) );
        fi;
        
        S!.WeightsOfIndeterminates := weights;
        
        L := Indeterminates( S );
        
        for i in [ 1 .. Length( L ) ] do
            
             SetDegreeOfRingElement( L[ i ], weights[ i ] );
            
        od;
        
        return true;
        
    fi;
    
    if not HasDegreeGroup( S ) then
        
        if IsInt( weights[ 1 ] ) then
            
            l := 1;
            
        elif IsList( weights[ 1 ] ) then
            
            l := Length( weights[ 1 ] );
            
        else
            
            Error(" the weights seem not to be valid in any sense.");
            
        fi;
        
        A := 0 * HOMALG_MATRICES.ZZ;
        
        for i in [1..l] do
            
            A := A + 1 * HOMALG_MATRICES.ZZ;
            
        od;
        
        SetDegreeGroup( S, A );
        
    else
        
        A := DegreeGroup( S );
        
    fi;
    
    gens := GeneratingElements( A );
    
    weight_list := List( weights, i -> i * gens );
    
    weight_list := Flat( weight_list );
    
    S!.WeightsOfIndeterminates := weight_list;
    
    L := Indeterminates( S );
    
    for i in [ 1 .. Length( L ) ] do
        
        SetDegreeOfRingElement( L[ i ], weight_list[ i ] );
        
    od;
    
    return weight_list;
    
end );

##
InstallMethod( HasDegreeGroup,
        "for homalg graded rings",
        [ IsHomalgGradedRing ],
        
  function( S )
    
    return IsBound( S!.DegreeGroup );
    
end );

##
InstallMethod( SetDegreeGroup,
        "for homalg graded rings",
        [ IsHomalgGradedRing, IsHomalgModule ],
        
  function( S, G )
    
    if IsBound( S!.DegreeGroup ) then
        Error( " DegreeGroup already set, cannot reset an attribute.");
        return false;
    fi;
    
    S!.DegreeGroup := G;
    
    return true;
    
end );


##
InstallMethod( MatrixOfWeightsOfIndeterminates,
        "Attribute for graded rings",
        [ IsHomalgGradedRing],
  function( S )
    
    return MatrixOfWeightsOfIndeterminates( UnderlyingNonGradedRing( S ), WeightsOfIndeterminates( S ) );
    
end );

##
InstallMethod( CommonNonTrivialWeightOfIndeterminates,
        "for homalg graded rings",
        [ IsHomalgGradedRing ],
        
  function( S )
    local weights, deg1;
    
    weights := WeightsOfIndeterminates( S );
    
    weights := Set( weights );
    
    deg1 := DegreeOfRingElement( One( S ) );
    
    weights := Filtered( weights, w -> w <> deg1 );
    
    if Length( weights ) <> 1 then
        Error( "the list of common nontrivial weights should be a singleton but computed ", weights );
    fi;
    
    return weights[1];
    
end );

##
InstallMethod( ListOfDegreesOfMultiGradedRing,
        "for homalg rings",
        [ IsInt, IsHomalgRing, IsHomogeneousList ],	## FIXME: is IsHomogeneousList too expensive? ## FIXME2: Why was there a graded ring expected?
        
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

## the fallback method; the CAS-specific methods are installed in the respective files
InstallMethod( AreLinearSyzygiesAvailable,
        "for homalg rings",
        [ IsHomalgRing ],
        
  ReturnFalse );

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
    local RP, S, A, rel, c;
    
    ## create ring RP with R as underlying global ring
    RP := CreateHomalgTableForGradedRings( R );
    
    ## create the graded ring
    S := CreateHomalgRing( R, [ TheTypeHomalgGradedRing, ValueGlobal( "TheTypeHomalgMatrixOverGradedRing" ) ], GradedRingElement, RP );
    SetConstructorForHomalgMatrices( S,
      function( arg )
        local nargs, mat, R, l;
        nargs := Length( arg );
        mat := arg[1];
        if IsList( mat ) and ForAll( mat, IsHomalgGradedRingElementRep ) then
            mat := List( mat, EvalRingElement );
        fi;
        R := arg[nargs];
        l := Concatenation( [ mat ], arg{[ 2 .. nargs - 1 ]}, [ UnderlyingNonGradedRing( R ) ] );
        mat := CallFuncList( HomalgMatrix, l );
        return MatrixOverGradedRing( mat, R );
      end
    );
    
    ## for the view methods:
    ## <A graded ring>
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
    
    if HasBaseRing( R ) then
        SetBaseRing( S, GradedRing( BaseRing( R ) ) );
    fi;
    
    if HasRingRelations( R ) then
        A := GradedRing( AmbientRing( R ) );
        rel := RingRelations( R );
        if IsHomalgRingRelationsAsGeneratorsOfLeftIdeal( rel ) then
            rel := MatrixOverGradedRing( MatrixOfRelations( rel ), A );
            rel := HomalgRingRelationsAsGeneratorsOfLeftIdeal( rel );
        else
            rel := MatrixOverGradedRing( MatrixOfRelations( rel ), A );
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
    
    S!.statistics.LinearSyzygiesGeneratorsOfRows := 0;
    S!.statistics.LinearSyzygiesGeneratorsOfColumns := 0;
    
    return S;
    
end );

##
InstallMethod( ExteriorRing,
        "for homalg rings",
        [ IsHomalgGradedRingRep and IsFreePolynomialRing, IsHomalgRing, IsHomalgRing, IsList ],
        
  function( S, Coeff, Base, anti )
    local A, weights, indets, n, RP;
    
    A := ExteriorRing( UnderlyingNonGradedRing( S ), Coeff, Base, anti );
    
    A := GradedRing( A );
    
    # correct the next line!
    weights := -WeightsOfIndeterminates( S );
    
    SetWeightsOfIndeterminates( A, weights );
    
    indets := IndeterminatesOfExteriorRing( A );
    
    n := Length( indets );
    
    Perform( [ 1 .. n ], function( i ) SetDegreeOfRingElement( indets[i], weights[i] ); end );
    
    if AreLinearSyzygiesAvailable( UnderlyingNonGradedRing( A ) ) then
        
        RP := homalgTable( A );
        
        ## RP_Basic_Linear
        AppendToAhomalgTable( RP, HomalgTableLinearSyzygiesForGradedRingsBasic );
    fi;
    
    return A;
    
end );

##
InstallMethod( ExteriorRing,
        "for homalg rings",
        [ IsHomalgGradedRingRep and IsFreePolynomialRing, IsHomalgGradedRingRep, IsHomalgRing, IsList ],
        
  function( S, Coeff, Base, anti )
    local A;
    
    A := ExteriorRing( S, UnderlyingNonGradedRing( Coeff ), Base, anti );
    
    ResetFilterObj( A, CoefficientsRing );
    SetCoefficientsRing( A, Coeff );
    
    return A;
    
end );

##
InstallMethod( ExteriorRing,
        "for homalg rings",
        [ IsHomalgGradedRingRep and IsFreePolynomialRing, IsHomalgRing, IsHomalgGradedRingRep, IsList ],
        
  function( S, Coeff, Base, anti )
    local A;
    
    A := ExteriorRing( S, Coeff, UnderlyingNonGradedRing( Base ), anti );
    
    ResetFilterObj( A, BaseRing );
    SetBaseRing( A, Base );
    
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
    
    ResetFilterObj( R, BaseRing );
    if HasIndeterminatesOfPolynomialRing( S ) then
        SetBaseRing( R, S );
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
        elif not IsBound( degree ) and ( IsHomalgElement( ar ) ) then
            degree := ar;
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
    
    mat := UnderlyingMatrixOverNonGradedRing( MatrixOfRelations( ring_rel ) );
    
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
InstallMethod( ViewObj,
        "for graded homalg rings",
        [ IsHomalgGradedRingRep ],
        
  function( o )
    
    ViewObj( UnderlyingNonGradedRing( o ) );
    
    Print( "\n", "(weights: " );
    if HasWeightsOfIndeterminates( o ) then
        ViewObj( WeightsOfIndeterminates( o ) );
    else
        Print( "yet unset" );
    fi;
    Print( ")" );
    
end );

##
InstallMethod( Display,
        "for homalg graded ring elements",
        [ IsHomalgGradedRingElementRep ],
        
  function( r )
    
    Display( UnderlyingNonGradedRingElement( r ) );
    
end );

