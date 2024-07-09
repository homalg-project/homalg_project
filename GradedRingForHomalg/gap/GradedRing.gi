# SPDX-License-Identifier: GPL-2.0-or-later
# GradedRingForHomalg: Endow Commutative Rings with an Abelian Grading
#
# Implementations
#

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
    local T, B;
    
    T := R!.ring;
    
    if not HasBaseRing( T ) and HasBaseRing( R ) then
        B := BaseRing( R );
        if not IsIdenticalObj( R, B ) then
            if IsHomalgGradedRingRep( B ) then
                SetBaseRing( T, UnderlyingNonGradedRing( B ) );
            else
                SetBaseRing( T, B );
            fi;
        fi;
    fi;
    
    return T;
    
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

##  <#GAPDoc Label="HomogeneousPartOfRingElement">
##  <ManSection>
##    <Oper Arg="r, degree" Name="HomogeneousPartOfRingElement"
##    Label="for homalg graded ring elements and elements in degree groups"/>
##    <Returns>a graded ring element</Returns>
##    <Description>
##      returns the summand of <A>r</A> whose monomials have the given degree <A>degree</A> and if 
##      <A>r</A> has no such monomials then it returns the zero element of the ring.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
InstallMethod( HomogeneousPartOfRingElement,
        "for homalg graded ring elements and elements in degree groups",
        [ IsHomalgGradedRingElement, IsHomalgModuleElement ],
  function( r, degree )
    local S, ev, list_of_coeff, monomials, positions_list;
      
    S := HomalgRing( r );
    
    ev := EvalRingElement( r );
    
    list_of_coeff := EntriesOfHomalgMatrix( Coefficients( ev ) );
    
    list_of_coeff := List( list_of_coeff, c -> String(c)/S );
    
    monomials := List( Coefficients( ev )!.monomials, m -> String( m )/S );
    
    positions_list := Positions( List( monomials, Degree ), degree );
    
    if positions_list = [ ] then
        
        return Zero( S );
    
    else
        
        return list_of_coeff{positions_list}*monomials{positions_list};
    
    fi;
    
end );

##  <#GAPDoc Label="IsHomogeneousRingElement">
##  <ManSection>
##    <Oper Arg="r" Name="IsHomogeneousRingElement"
##    Label="for homalg graded ring elements"/>
##    <Returns> <C>true</C> or <C>false</C> </Returns>
##    <Description>
##      returns whether the graded ring element <A>r</A> is homogeneous or not.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
InstallMethod( IsHomogeneousRingElement,
        "for homalg graded ring elements",
        [ IsHomalgGradedRingElement ],
  function( r )
    
    return HomogeneousPartOfRingElement( r, Degree( r ) ) = r;
    
end );

##
InstallMethod( Indeterminates,
        "for homalg graded rings",
        [ IsHomalgGradedRing ],
        
  function( R )
    
    return List( Indeterminates( UnderlyingNonGradedRing( R ) ), a -> a / R );
    
end );

##
InstallMethod( RelativeIndeterminatesOfPolynomialRing,
        "for homalg graded rings",
        [ IsHomalgGradedRing ], 10001,
        
  function( R )
    
    return List( RelativeIndeterminatesOfPolynomialRing( UnderlyingNonGradedRing( R ) ), a -> a / R );
    
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
InstallMethod( DegreeGroup,
        "for a graded ring",
        [ IsHomalgGradedRing and HasAmbientRing ],
        
  function( S )
    
    if not IsBound( AmbientRing( S )!.DegreeGroup ) then
    
        WeightsOfIndeterminates( S );
    
    fi;
    
    return AmbientRing( S )!.DegreeGroup;
    
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

    if HasAmbientRing( E ) then
        
        weights := WeightsOfIndeterminates( AmbientRing( E ) );
        
    elif HasBaseRing( E ) and HasIsExteriorRing( E ) and IsExteriorRing( E ) then
        
        old_weights := WeightsOfIndeterminates( BaseRing( E ) );
        
        BaseRingDegreeGroup := DegreeGroup( BaseRing( E ) );
        
        ## if A is a direct sum then MonoOfLeftSummand and MonoOfRightSummand are set
        A := 0 * HOMALG_MATRICES.ZZ + 1 * HOMALG_MATRICES.ZZ;
        
        gens := GeneratingElements( A ); #gens has precisely one entry which is 1
        
        B := BaseRingDegreeGroup + A;
        
        if not HasDegreeGroup( E ) then
            SetDegreeGroup( E, B );
        fi;
        
        iota := MonoOfLeftSummand( B );
        
        weights := List( old_weights, w -> ApplyMorphismToElement( iota, w ) );
        
        iota := MonoOfRightSummand( B );
        
        m := Length( old_weights );
        
        Append( weights, ListWithIdenticalEntries( n - m, ApplyMorphismToElement( iota, gens[1] ) ) );
        
        E!.WeightsCompatibleWithBaseRing := true;
        
    else
        
        ## if A is a direct sum then MonoOfLeftSummand and MonoOfRightSummand are set
        A := 0 * HOMALG_MATRICES.ZZ + 1 * HOMALG_MATRICES.ZZ;
        
        if not HasDegreeGroup( E ) then
            SetDegreeGroup( E, A );
        fi;
        
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
    local weights;
    
    weights := WeightsOfIndeterminates( AmbientRing( S ) );
    
    S!.WeightsOfIndeterminates := weights;
    
    return weights;
    
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
    A := 0 * HOMALG_MATRICES.ZZ + 1 * HOMALG_MATRICES.ZZ;
    
    SetDegreeGroup( S, A );
    
    gen_list := GeneratingElements( A );
    
    S!.WeightsOfIndeterminates := gen_list;
    
    return gen_list;
    
end );

##
InstallMethod( WeightsOfIndeterminates,
        "for homalg graded rings",
        [ IsIntegersForHomalg and IsHomalgGradedRing ],
        
  function( S )

    local A, gen_list;
    
    if IsBound( S!.WeightsOfIndeterminates ) then
        
        return S!.WeightsOfIndeterminates;
        
    fi;
    
    ## if A is a direct sum then MonoOfLeftSummand and MonoOfRightSummand are set
    A := 0 * HOMALG_MATRICES.ZZ + 1 * HOMALG_MATRICES.ZZ;
    
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
        
        return;
        
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
    
    weight_list := List( weights, i -> HomalgModuleElement( [ i ], A ) );
    
    weight_list := Flat( weight_list );
    
    S!.WeightsOfIndeterminates := weight_list;
    
    L := Indeterminates( S );
    
    for i in [ 1 .. Length( L ) ] do
        
        SetDegreeOfRingElement( L[ i ], weight_list[ i ] );
        
    od;
    
end );

InstallMethod( SetWeightsOfIndeterminates,
        "for homalg graded rings",
        [ IsHomalgGradedRing and HasAmbientRing, IsList ],
        
  function( S, weights )
    
    if not HasWeightsOfIndeterminates( AmbientRing( S ) ) then
        SetWeightsOfIndeterminates( AmbientRing( S ), weights );
    fi;
    
    WeightsOfIndeterminates( S );
    
end );

##
InstallMethod( HasDegreeGroup,
        "for homalg graded rings",
        [ IsHomalgGradedRing ],
        
  function( S )
    
    return IsBound( S!.DegreeGroup );
    
end );

##
InstallMethod( HasDegreeGroup,
        "for homalg graded rings",
        [ IsHomalgGradedRing and HasAmbientRing ],
        
  function( S )
    
    return IsBound( AmbientRing( S )!.DegreeGroup );
    
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
InstallMethod( SetDegreeGroup,
        "for homalg graded rings",
        [ IsHomalgGradedRing and HasAmbientRing, IsHomalgModule ],
        
  function( S, G )
    local ambient_ring;
    
    ambient_ring := AmbientRing( S );
    
    if IsBound( ambient_ring!.DegreeGroup ) then
        Error( " DegreeGroup already set, cannot reset an attribute.");
        return false;
    fi;
    
    ambient_ring!.DegreeGroup := G;
    
    return true;
    
end );

##
InstallMethod( MatrixOfWeightsOfIndeterminates,
        "Attribute for graded rings",
        [ IsHomalgGradedRing ],
  function( S )
    local A;
    
    A := DegreeGroup( S );
    
    if IsBound( S!.matrix_of_weights_of_indeterminates ) then
        
        if PositionOfTheDefaultPresentation( A ) = S!.position_of_weight_matrix then
            
            return S!.matrix_of_weights_of_indeterminates;
            
        fi;
        
    fi;
    
    S!.position_of_weight_matrix := PositionOfTheDefaultPresentation( A );
    
    S!.matrix_of_weights_of_indeterminates := MatrixOfWeightsOfIndeterminates( UnderlyingNonGradedRing( S ), WeightsOfIndeterminates( S ) );
    
    return S!.matrix_of_weights_of_indeterminates;
    
end );

##
InstallMethod( MatrixOfWeightsOfIndeterminates,
        "Attribute for graded rings",
        [ IsHomalgGradedRing and HasAmbientRing ],
  function( S )
    
    return MatrixOfWeightsOfIndeterminates( UnderlyingNonGradedRing( AmbientRing( S ) ), WeightsOfIndeterminates( S ) );
    
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
    local RP, S, rel, c;
    
    ## create ring RP with R as underlying global ring
    RP := CreateHomalgTableForGradedRings( R );
    
    ## create the graded ring
    S := CreateHomalgRing( R, [ TheTypeHomalgGradedRing, ValueGlobal( "TheTypeHomalgMatrixOverGradedRing" ) ], GradedRingElement, RP );
    
    SetRingFilter( S, IsHomalgGradedRingRep );
    SetRingElementFilter( S, IsHomalgGradedRingElementRep );
    
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
        if IsIdenticalObj( R, CoefficientsRing( R ) ) then
            SetCoefficientsRing( S, S );
        else
            SetCoefficientsRing( S, GradedRing( CoefficientsRing( R ) ) );
        fi;
    fi;
    
    if HasBaseRing( R ) then
        if IsIdenticalObj( R, BaseRing( R ) ) then
            SetBaseRing( S, S );
        else
            SetBaseRing( S, GradedRing( BaseRing( R ) ) );
        fi;
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
InstallMethod( GradedRing,
        "for homalg residue class rings",
        [ IsHomalgResidueClassRingRep ],
        
  function( R )
    local A, rel;
    
    if ValueOption( "pre_graded_ring" ) = true then
        TryNextMethod( );
    fi;
    
    A := AmbientRing( R );
    
    A := GradedRing( A );
    
    rel := A * RingRelations( R );
    
    return A / rel;
    
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
          if IsHomalgRingElement( el ) then
              properties := KnownTruePropertiesOfObject( el ); ## FIXME: a huge potential for problems
          else
              properties := [ ];
          fi;
          Add( ar, List( properties, ValueGlobal ) ); ## at least an empty list is inserted; avoids infinite loops
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
    local R, RR, result, A;
    
    R := UnderlyingNonGradedRing( S );
    
    RR := R / ( R * ring_rel );
    
    result := GradedRing( RR : pre_graded_ring := true );
    
    if HasContainsAField( S ) and ContainsAField( S ) then
        SetContainsAField( result, true );
        if HasCoefficientsRing( S ) then
            SetCoefficientsRing( result, CoefficientsRing( S ) );
        fi;
    fi;
    
    if HasAmbientRing( S ) then
        A := AmbientRing( S );
    elif HasAmbientRing( R ) then
        A := GradedRing( AmbientRing( R ) );
    else
        A := S;
    fi;
    
    SetAmbientRing( result, A );
    SetRingRelations( result, A * RingRelations( RR ) );
    
    return result;
    
end );

##
InstallMethod( AssociatedGradedRing,
        "for homalg Weyl rings",
        [ IsHomalgRing and IsWeylRing ],
        
  function( A )
    local der;
    
    der := IndeterminateDerivationsOfRingOfDerivations( A );
    
    der := List( der, String );
    
    return BaseRing( A ) * der;
    
end );

##
InstallMethod( \*,
       "for graded rings",
       [ IsHomalgGradedRing and IsFreePolynomialRing and HasCoefficientsRing,
         IsHomalgGradedRing and IsFreePolynomialRing and HasCoefficientsRing ],
       
    function( S, T )
    local S_degree_group, T_degree_group, ST, S_weights, T_weights, ST_degree_group, ST_weights, iota;
    
    S_degree_group := DegreeGroup( S );
    
    T_degree_group := DegreeGroup( T );
    
    S_weights := WeightsOfIndeterminates( S );
    
    T_weights := WeightsOfIndeterminates( T );
    
    ST := UnderlyingNonGradedRing( S ) * UnderlyingNonGradedRing( T );
    
    ST_degree_group := S_degree_group + T_degree_group;
    
    iota := MonoOfLeftSummand( ST_degree_group );
    
    S_weights := List( S_weights, i -> ApplyMorphismToElement( iota, i ) );
    
    iota := MonoOfRightSummand( ST_degree_group );
    
    T_weights := List( T_weights, i -> ApplyMorphismToElement( iota, i ) );
    
    ST := GradedRing( ST );
    
    SetDegreeGroup( ST, ST_degree_group );
    
    ST_weights := Concatenation( S_weights, T_weights );
    
    SetWeightsOfIndeterminates( ST, ST_weights );
    
    return ST;
    
end );

##
InstallMethod( RingOfDerivations,
        "for graded rings",
        [ IsHomalgGradedRingRep ],
        
  function( S )
    local R;
    
    R := UnderlyingNonGradedRing( S );
    
    return RingOfDerivations( R );
    
end );

##
InstallMethod( CanComputeMonomialsWithGivenDegreeForRing,
          [ IsHomalgGradedRing ],
          
  function( S )
    local weights, n, matrix, zero, equations, polyhedron, lattice_points;
    
    if not ( HasIsFreePolynomialRing( S ) and IsFreePolynomialRing( S ) ) and
          not ( HasIsExteriorRing( S ) and IsExteriorRing( S ) ) then
          
        return false;
        
    fi;
    
    if not IsFree( DegreeGroup( S ) ) then
        
        return false;
        
    fi;
    
    weights := WeightsOfIndeterminates( S );
    
    n := Length( weights );
    
    matrix := List( weights, w -> MatrixOfMap( UnderlyingMorphism( w ) ) );
    
    matrix := TransposedMatrix( UnionOfRows( matrix ) );
    
    matrix := EntriesOfHomalgMatrixAsListList( matrix );
    
    zero := Degree( One( S ) );
    
    zero := EntriesOfHomalgMatrix( MatrixOfMap( UnderlyingMorphism( zero ) ) );
    
    zero := List( zero, HomalgElementToInteger );
    
    if IsPackageMarkedForLoading( "NConvex", ">= 2020.01.01" ) then
      
      equations := ListN( zero, matrix, { c, d } -> Concatenation( [ -c ], d ) );
      
      equations := Concatenation( equations, -equations );
      
      equations := Concatenation( equations, IdentityMat( n + 1 ){ [ 2 .. n + 1 ] } );
      
      polyhedron := ValueGlobal( "PolyhedronByInequalities" )( equations );
      
      lattice_points := ValueGlobal( "LatticePointsGenerators" )( polyhedron );
      
    elif IsPackageMarkedForLoading( "4ti2Interface", ">= 2019.09.01" ) then
      
      lattice_points := ValueGlobal( "4ti2Interface_zsolve_equalities_and_inequalities_in_positive_orthant" )( matrix, zero, [], [] );
      
    else
      
      return false;
      
    fi;
    
    if IsEmpty( lattice_points[ 2 ] ) and IsEmpty( lattice_points[ 3 ] ) then
      
      return true;
      
    else
      
      return false;
      
    fi;
    
end );

##
InstallMethod( MonomialsWithGivenDegreeOp,
          "for graded rings and module elements",
          [ IsHomalgGradedRing, IsHomalgModuleElement ],
          
  function( S, degree )
    local indeterminates, weights, n, matrix, equations, polyhedron, solutions;
    
    if not degree in DegreeGroup( S ) then
        Error( "The given degree doesn't belong to the degree group of the ring" );
    fi;
    
    if not CanComputeMonomialsWithGivenDegreeForRing( S ) then
        TryNextMethod( );
    fi;
    
    if not IsPackageMarkedForLoading( "NConvex", ">= 2020.01.01" ) then
        TryNextMethod( );
    fi;
    
    indeterminates := Indeterminates( S );
    
    n := Length( indeterminates );
    
    weights := WeightsOfIndeterminates( S );
    
    matrix := List( weights, w -> MatrixOfMap( UnderlyingMorphism( w ) ) );
    
    matrix := TransposedMatrix( UnionOfRows( matrix ) );
    
    matrix := EntriesOfHomalgMatrixAsListList( matrix );
    
    degree := EntriesOfHomalgMatrix( MatrixOfMap( UnderlyingMorphism( degree ) ) );
    
    degree := List( degree, HomalgElementToInteger );
    
    equations := ListN( degree, matrix, { c, d } -> Concatenation( [ -c ], d ) );
    
    equations := Concatenation( equations, -equations );
    
    equations := Concatenation( equations, IdentityMat( n + 1 ){ [ 2 .. n + 1 ] } );
    
    polyhedron := ValueGlobal( "PolyhedronByInequalities" )( equations );
    
    solutions := ValueGlobal( "LatticePointsGenerators" )( polyhedron )[ 1 ];
    
    solutions := List( solutions, sol -> Product( ListN( indeterminates, sol, \^ )  ) );
    
    if HasIsExteriorRing( S ) and IsExteriorRing( S ) then
      
      return Filtered( solutions, sol -> not IsZero( sol ) );
      
    else
      
      return solutions;
      
    fi;
    
end );

##
InstallMethod( MonomialsWithGivenDegreeOp,
          "for graded rings and module elements",
          [ IsHomalgGradedRing, IsHomalgModuleElement ],
          
  function( S, degree )
    local indeterminates, weights, matrix, solutions;
    
    if not degree in DegreeGroup( S ) then
        Error( "The given degree doesn't belong to the degree group of the ring" );
    fi;
     
    if not CanComputeMonomialsWithGivenDegreeForRing( S ) then
        TryNextMethod( );
    fi;
    
    if not IsPackageMarkedForLoading( "4ti2Interface", ">= 2019.09.03" ) then
        TryNextMethod( );
    fi;
    
    indeterminates := Indeterminates( S );
    
    weights := WeightsOfIndeterminates( S );
    
    matrix := List( weights, w -> MatrixOfMap( UnderlyingMorphism( w ) ) );
    
    matrix := TransposedMatrix( UnionOfRows( matrix ) );
    
    matrix := EntriesOfHomalgMatrixAsListList( matrix );
    
    degree := EntriesOfHomalgMatrix( MatrixOfMap( UnderlyingMorphism( degree ) ) );
    
    degree := List( degree, HomalgElementToInteger );
    
    indeterminates := Indeterminates( S );
    
    solutions := ValueGlobal( "4ti2Interface_zsolve_equalities_and_inequalities_in_positive_orthant" )( matrix, degree, [], [] )[ 1 ];
    
    solutions := List( solutions, sol -> Product( ListN( indeterminates, sol, \^ )  ) );
    
    if HasIsExteriorRing( S ) and IsExteriorRing( S ) then
      
      return Filtered( solutions, sol -> not IsZero( sol ) );
      
    else
      
      return  solutions;
      
    fi;
    
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
        [ IsHomalgGradedRingRep ], 101,
        
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

