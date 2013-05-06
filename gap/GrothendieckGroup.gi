#############################################################################
##
##  GrothendieckGroup.gi                                     Modules package
##
##  Copyright 2011, Mohamed Barakat, University of Kaiserslautern
##
##  Implementations for elements of the Grothendieck group of a projective space.
##
#############################################################################

####################################
#
# representations:
#
####################################

##  <#GAPDoc Label="IsElementOfGrothendieckGroupOfProjectiveSpaceRep">
##  <ManSection>
##    <Filt Type="Representation" Arg="P" Name="IsElementOfGrothendieckGroupOfProjectiveSpaceRep"/>
##    <Returns><C>true</C> or <C>false</C></Returns>
##    <Description>
##      The representation of elements of the Grothendieck group of a projective space.
##    <Listing Type="Code"><![CDATA[
DeclareRepresentation( "IsElementOfGrothendieckGroupOfProjectiveSpaceRep",
        IsElementOfGrothendieckGroupOfProjectiveSpace,
        [ ] );
##  ]]></Listing>
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##

##  <#GAPDoc Label="IsPolynomialModuloSomePowerRep">
##  <ManSection>
##    <Filt Type="Representation" Arg="c" Name="IsPolynomialModuloSomePowerRep"/>
##    <Returns><C>true</C> or <C>false</C></Returns>
##    <Description>
##      The representation of polynomials modulo some power.
##    <Listing Type="Code"><![CDATA[
DeclareRepresentation( "IsPolynomialModuloSomePowerRep",
        IsPolynomialModuloSomePower,
        [ "polynomial", "indeterminate", "normalize" ] );
##  ]]></Listing>
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##

##  <#GAPDoc Label="IsChernPolynomialWithRankRep">
##  <ManSection>
##    <Filt Type="Representation" Arg="c" Name="IsChernPolynomialWithRankRep"/>
##    <Returns><C>true</C> or <C>false</C></Returns>
##    <Description>
##      The representation of Chern polynomials with rank.
##    <Listing Type="Code"><![CDATA[
DeclareRepresentation( "IsChernPolynomialWithRankRep",
        IsChernPolynomialWithRank,
        [ "indeterminate", "normalize" ] );
##  ]]></Listing>
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##

##  <#GAPDoc Label="IsChernCharacterRep">
##  <ManSection>
##    <Filt Type="Representation" Arg="c" Name="IsChernCharacterRep"/>
##    <Returns><C>true</C> or <C>false</C></Returns>
##    <Description>
##      The representation of Chern character.
##    <Listing Type="Code"><![CDATA[
DeclareRepresentation( "IsChernCharacterRep",
        IsChernCharacter,
        [ "indeterminate", "normalize" ] );
##  ]]></Listing>
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##

####################################
#
# families and types:
#
####################################

# a new family:
BindGlobal( "TheFamilyOfCombinatorialPolynomials",
        NewFamily( "TheFamilyOfCombinatorialPolynomials" ) );

# new types:
BindGlobal( "TheTypeElementOfGrothendieckGroupOfProjectiveSpace",
        NewType( TheFamilyOfCombinatorialPolynomials,
                IsElementOfGrothendieckGroupOfProjectiveSpaceRep ) );

BindGlobal( "TheTypePolynomialModuloSomePower",
        NewType( TheFamilyOfCombinatorialPolynomials,
                IsPolynomialModuloSomePowerRep ) );

BindGlobal( "TheTypeChernPolynomialWithRank",
        NewType( TheFamilyOfCombinatorialPolynomials,
                IsChernPolynomialWithRankRep ) );

BindGlobal( "TheTypeChernCharacter",
        NewType( TheFamilyOfCombinatorialPolynomials,
                IsChernCharacterRep ) );

####################################
#
# methods for properties:
#
####################################

##
InstallMethod( IsIntegral,
        "for an element of the Grothendieck group of a projective space",
        [ IsElementOfGrothendieckGroupOfProjectiveSpaceRep ],
        
  function( P )
    
    return ForAll( Coefficients( P ), IsInt );
    
end );

##
InstallMethod( IsNumerical,
        "for a univariate polynomial and an integer",
        [ IsUnivariatePolynomial ],
        
  function( chi )
    local P;
    
    if IsZero( chi ) then
        return true;
    fi;
    
    ## being numerical or not does not depend on the ambient dimension
    P := CreateElementOfGrothendieckGroupOfProjectiveSpace( chi, Degree( chi ) );
    
    return IsIntegral( P );
    
end );

##
InstallMethod( IsIntegral,
        "for a Chern characters",
        [ IsChernCharacterRep ],
        
  function( ch )
    local chi;
    
    chi := HilbertPolynomial( ch );
    
    return IsNumerical( chi );
    
end );

##
InstallMethod( IsIntegral,
        "for a Chern polynomial with rank",
        [ IsChernPolynomialWithRankRep ],
        
  function( c )
    local ch;
    
    ch := ChernCharacter( c );
    
    return IsIntegral( ch );
    
end );

####################################
#
# methods for attributes:
#
####################################

##
InstallMethod( ChernPolynomial,
        "for a univariate polynomial, an integer, and a ring element",
        [ IsUnivariatePolynomial, IsInt, IsRingElement ],
        
  function( chi, dim, h )
    local P;
    
    P := CreateElementOfGrothendieckGroupOfProjectiveSpace( chi, dim );
    
    return ChernPolynomial( P );
    
end );

##
InstallMethod( ChernPolynomial,
        "for a univariate polynomial and an integer",
        [ IsUnivariatePolynomial, IsInt ],
        
  function( chi, dim )
    local h;
    
    h := VariableForChernPolynomial( );
    
    return ChernPolynomial( chi, dim, h );
    
end );

##
InstallMethod( ZERO,
        "for an element of the Grothendieck group of a projective space",
        [ IsElementOfGrothendieckGroupOfProjectiveSpaceRep and AssociatedPolynomial ],
        
  function( P )
    local chi, K_0;
    
    chi := AssociatedPolynomial( P );
    
    K_0 := GrothendieckGroup( P );
    
    return CreateElementOfGrothendieckGroupOfProjectiveSpace( 0 * chi, K_0 );
    
end );

##
InstallMethod( Dimension,
        "for an element of the Grothendieck group of a projective space",
        [ IsElementOfGrothendieckGroupOfProjectiveSpaceRep ],
        
  function( P )
    local coeffs, l, h;
    
    coeffs := Coefficients( P );
    
    coeffs := Reversed( coeffs );
    
    l := Length( coeffs );
    
    h := PositionNonZero( coeffs );
    
    return l - h;
    
end );

##
InstallMethod( Dimension,
        "for an element of the Grothendieck group of a projective space",
        [ IsElementOfGrothendieckGroupOfProjectiveSpaceRep and HasAssociatedPolynomial ],
        
  function( P )
    
    return Degree( AssociatedPolynomial( P ) );
    
end );

##
InstallMethod( Dimension,
        "for an element of the Grothendieck group of a projective space",
        [ IsElementOfGrothendieckGroupOfProjectiveSpaceRep and IsZero ],
        
  function( P )
    
    return -1;
    
end );

##
InstallMethod( DegreeOfElementOfGrothendieckGroupOfProjectiveSpace,
        "for an element of the Grothendieck group of a projective space",
        [ IsElementOfGrothendieckGroupOfProjectiveSpaceRep ],
        
  function( P )
    local coeffs, l, h;
    
    coeffs := Coefficients( P );
    
    coeffs := Reversed( coeffs );
    
    l := Length( coeffs );
    
    h := PositionNonZero( coeffs );
    
    return coeffs[h];
    
end );

##
InstallMethod( DegreeOfElementOfGrothendieckGroupOfProjectiveSpace,
        "for an element of the Grothendieck group of a projective space",
        [ IsElementOfGrothendieckGroupOfProjectiveSpaceRep and HasAssociatedPolynomial ],
        
  function( P )
    local h;
    
    h := AssociatedPolynomial( P );
    
    return LeadingCoefficient( h ) * Factorial( Degree( h ) );
    
end );

##
InstallMethod( DegreeOfElementOfGrothendieckGroupOfProjectiveSpace,
        "for an element of the Grothendieck group of a projective space",
        [ IsElementOfGrothendieckGroupOfProjectiveSpaceRep and IsZero ],
        
  function( P )
    
    return 0;
    
end );

##
InstallMethod( Degree,
        "for an element of the Grothendieck group of a projective space",
        [ IsElementOfGrothendieckGroupOfProjectiveSpaceRep ],
        
  DegreeOfElementOfGrothendieckGroupOfProjectiveSpace );

##
InstallMethod( CoefficientsOfElementOfGrothendieckGroupOfProjectiveSpace,
        "for a univariate polynomial",
        [ IsUnivariatePolynomial ],
        
  function( h )
    local dim, deg, C, s;
    
    if IsZero( h ) then
        return [ ];
    fi;
    
    dim := Degree( h );
    deg := LeadingCoefficient( h ) * Factorial( dim );
    
    C := ListWithIdenticalEntries( dim + 1, 0 );
    
    C[dim + 1] := deg;
    
    s := IndeterminateOfUnivariateRationalFunction( h );
    
    h := h - deg * _Binomial( s + dim, dim );
    
    while not IsZero ( h ) do
        
        dim := Degree( h );
        deg := LeadingCoefficient( h ) * Factorial( dim );
        
        C[dim + 1] := deg;
        
        h := h - deg * _Binomial( s + dim, dim );
        
    od;
    
    return C;
    
end );

##
InstallMethod( AdditiveInverse,
        "for an element of the Grothendieck group of a projective space",
        [ IsElementOfGrothendieckGroupOfProjectiveSpaceRep ],
        
  function( P )
    local negP;
    
    negP := -UnderlyingModuleElement( P );
    
    negP := CreateElementOfGrothendieckGroupOfProjectiveSpace( -negP );
    
    if IsBound( P!.DisplayTwistedCoefficients ) and P!.DisplayTwistedCoefficients = true then
        negP!.DisplayTwistedCoefficients := true;
    fi;
    
    return negP;
    
end );
    
##
InstallMethod( AdditiveInverse,
        "for an element of the Grothendieck group of a projective space",
        [ IsElementOfGrothendieckGroupOfProjectiveSpaceRep and HasAssociatedPolynomial ],
        
  function( P )
    local chi, K_0, negP;
    
    chi := AssociatedPolynomial( P );
    
    K_0 := GrothendieckGroup( P );
    
    negP := CreateElementOfGrothendieckGroupOfProjectiveSpace( -chi, K_0 );
    
    if IsBound( P!.DisplayTwistedCoefficients ) and P!.DisplayTwistedCoefficients = true then
        negP!.DisplayTwistedCoefficients := true;
    fi;
    
    return negP;
    
end );
    
##
InstallMethod( ChernPolynomial,
        "for an element of the Grothendieck group of a projective space and a ring element",
        [ IsElementOfGrothendieckGroupOfProjectiveSpaceRep, IsRingElement ],
        
  function( P, h )
    local dim, c, coeffs, C, C_O_i;
    
    Assert( 0, IsIntegral( P ) );
    
    dim := AmbientDimension( P );
    
    coeffs := Coefficients( P, "twisted" );
    
    c := 1 * h^0;
    
    ## it is ugly that we need this
    SetIndeterminateOfUnivariateRationalFunction( c, h );
    
    ## checking this property sets it
    Assert( 0, IsUnivariatePolynomial( c ) );
    
    C := CreateChernPolynomial( 0, c, dim );
    
    if IsZero( P ) then
        return C;
    fi;
    
    ## we could have used CreateChernPolynomial( 0, 1 - i * h, dim ) and
    ## defined C := CreateChernPolynomial( Rank( C ), c, dim ) above,
    ## but this is conceptually more appealing; see the assertion below
    C_O_i := List( [ 0 .. dim ], i -> CreateChernPolynomial( 1, 1 - i * h, dim ) );
    
    C := C * Product( [ 0 .. dim ], i -> C_O_i[i + 1]^coeffs[i + 1] );
    
    ## we know the rank a priori
    Assert( 0, Rank( C ) = Sum( coeffs ) );
    
    SetElementOfGrothendieckGroupOfProjectiveSpace( C, P );
    
    return C;
    
end );

##
InstallMethod( ChernPolynomial,
        "for an element of the Grothendieck group of a projective space",
        [ IsElementOfGrothendieckGroupOfProjectiveSpaceRep ],
        
  function( P )
    local h;
    
    h := VariableForChernPolynomial( );
    
    return ChernPolynomial( P, h );
    
end );

##
InstallMethod( OneMutable,
        "for a polynomial modulo some power",
        [ IsPolynomialModuloSomePowerRep ],
        
  function( p )
    local o;
    
    o := 1 + 0 * p!.indeterminate;
    
    ## checking this property sets it
    Assert( 0, IsUnivariatePolynomial( o ) );
    
    return CreatePolynomialModuloSomePower( o, AmbientDimension( p ) );
    
end );

##
InstallMethod( OneMutable,
        "for a Chern polynomial with rank",
        [ IsChernPolynomialWithRankRep ],
        
  function( C )
    local O;
    
    O := One( TotalChernClass( C ) );
    
    return CreateChernPolynomial( 0, O );
    
end );

##
InstallMethod( Dual,
        "for a Chern polynomial with rank",
        [ IsChernPolynomialWithRankRep ],
        
  function( C )
    local h, dual;
    
    h := VariableForChernPolynomial( );
    
    dual := Value( C, -h );
    
    SetDual( dual, C );
    
    return dual;
    
end );

##
InstallMethod( ChernCharacter,
        "for a Chern polynomial with rank",
        [ IsChernPolynomialWithRankRep ],
        
  function( c )
    local C, indets, dim, u, ch;
    
    C := Coefficients( c );
    
    indets := List( [ 1 .. Length( C ) ], i -> Indeterminate( Rationals, i ) );
    
    dim := AmbientDimension( c );
    
    u := VariableForChernCharacter( );
    
    ch := Sum( [ 1 .. dim ],
              i -> ExpressSymmetricPolynomialInElementarySymmetricPolynomials(
                      Sum( indets, x -> x^i ), indets, C ) * u^i / Factorial( i ) );
    
    ch := Rank( c ) + ch + 0 * u;
    
    ## checking this property sets it
    Assert( 0, IsUnivariatePolynomial( ch ) );
    
    return CreateChernCharacter( ch, dim );
    
end );

##
InstallMethod( HilbertPolynomial,
        "for a Chern polynomial with rank",
        [ IsChernPolynomialWithRankRep ],
        
  function( c )
    
    return HilbertPolynomial( ChernCharacter( c ) );
    
end );

##
InstallMethod( HilbertPolynomial,
        "for a Chern character",
        [ IsChernCharacterRep ],
        
  function( ch )
    local dim, u, t, chi, normalize, exp, todd;
    
    dim := AmbientDimension( ch );
    
    u := ch!.indeterminate;
    
    t := VariableForHilbertPolynomial( );
    
    chi := 0 * t;
    
    ## it is ugly that we need this
    SetIndeterminateOfUnivariateRationalFunction( chi, t );
    
    ## checking this property sets it
    Assert( 0, IsUnivariatePolynomial( chi ) );
    
    if IsZero( ch ) then
        return chi;
    fi;
    
    normalize := function( poly )
        
        return PolynomialReduction( poly, [ u^(dim + 1) ], MonomialLexOrdering( ) )[1];
        
    end;
    
    exp := Sum( [ 0 .. dim ], i -> ( t * u )^i / Factorial( i ) );
    
    todd := Sum( [ 0 .. dim ], i -> (-1)^i * u^i / Factorial( i + 1 ) );
    
    todd := CreatePolynomialModuloSomePower( todd, dim );
    
    todd := todd^-(dim + 1);
    
    todd := todd!.polynomial;
    
    ch := ChernCharacterPolynomial( ch );
    
    ch := ch!.polynomial;
    
    ## Hirzebruch-Riemann-Roch
    ch := normalize( normalize( exp * ch ) * todd );
    
    if DegreeIndeterminate( ch, u ) < dim then
        return chi;
    fi;
    
    chi := PolynomialCoefficientsOfPolynomial( ch, u )[dim + 1];
    
    ## it is ugly that we need this
    SetIndeterminateOfUnivariateRationalFunction( chi, t );
    
    ## checking this property sets it
    Assert( 0, IsUnivariatePolynomial( chi ) );
    
    return chi;
    
end );

##
InstallMethod( RankOfObject,
        "for grothendieck group elements of projective space",
        [ IsElementOfGrothendieckGroupOfProjectiveSpaceRep ],
               
  function( element )
    local module_element;
    
    module_element := UnderlyingModuleElement( element );
    
    module_element := UnderlyingListOfRingElementsInCurrentPresentation( module_element );
    
    return module_element[ Length( module_element ) ];
    
end );

##
InstallMethod( ChernPolynomial,
        "for a Chern character",
         [ IsChernCharacterRep ],
    
  function( ch )
    local HP, d;
    
    HP := HilbertPolynomial( ch );
    
    d := AmbientDimension( ch );
    
    return ChernPolynomial( CreateElementOfGrothendieckGroupOfProjectiveSpace( HP, d ) );
    
end );

####################################
#
# methods for operations:
#
####################################

##
InstallGlobalFunction( VariableForChernPolynomial,
  function( arg )
    local h;
    
    if not IsBound( HOMALG_MODULES.variable_for_Chern_polynomial ) then
        
        if Length( arg ) > 0 and IsString( arg[1] ) then
            h := arg[1];
        else
            h := "h";
        fi;
        
        h := Indeterminate( Rationals, h );
        
        HOMALG_MODULES.variable_for_Chern_polynomial := h;
    fi;
    
    return HOMALG_MODULES.variable_for_Chern_polynomial;
    
end );

##
InstallGlobalFunction( VariableForChernCharacter,
  function( arg )
    local u;
    
    if not IsBound( HOMALG_MODULES.variable_for_Chern_character ) then
        
        if Length( arg ) > 0 and IsString( arg[1] ) then
            u := arg[1];
        else
            u := "u";
        fi;
        
        u := Indeterminate( Rationals, u );
        
        HOMALG_MODULES.variable_for_Chern_character := u;
    fi;
    
    return HOMALG_MODULES.variable_for_Chern_character;
    
end );

##
InstallMethod( ElementarySymmetricPolynomial,
        "for an integer and a list (of indeterminates/ring elemets)",
        [ IsInt, IsList ],
        
  function( deg, indets )
    local l, zero, sym;
    
    l := Length( indets );
    
    if l = 0 then
        Error( "the list of indeterminates (resp. ring elements) is empty\n" );
    fi;
    
    zero := 0 * Sum( indets );
    
    IsPolynomial( zero );
    
    if deg = 0 then
        return zero + 1;
    elif deg < 0 or deg > l then
        return zero;
    fi;
    
    sym := Combinations( indets, deg );
    
    sym := Sum( List( sym, Product ) );
    
    IsPolynomial( sym );
    
    return sym;
    
end );

##
InstallGlobalFunction( ExpressSymmetricPolynomialInElementarySymmetricPolynomials,
  function( poly, indets, elmsym )
    local symm, one, elementary_symmetric_polynomials,
          elementary_symmetric_polynomial, transposed_exponents, expo, l, coeff;
    
    if Length( indets ) <> Length( elmsym ) then
        Error( "the number of indeterminates and the number of placeholders",
               "of elementary symmetric polynomials must coincide\n" );
    fi;
    
    symm := 0 * Sum( indets );
    
    IsPolynomial( symm );
    
    if IsZero( poly ) then
        return symm;
    fi;
    
    one := Sum( indets )^0;
    
    IsPolynomial( one );
    
    ## list to cache the elementary symmetric polynomials
    elementary_symmetric_polynomials := [ ];
    
    elementary_symmetric_polynomial := function( c, i )
        
        if c = 0 then
            return one;
        fi;
        
        if not IsBound( elementary_symmetric_polynomials[i + 1] ) then
            elementary_symmetric_polynomials[i + 1] :=
              ElementarySymmetricPolynomial( i, indets );
            
        fi;
        
        return elementary_symmetric_polynomials[i + 1];
        
    end;
    
    transposed_exponents := function( expo )
        local l, i, j;
        
        expo := Filtered( expo, i -> i <> 0 );
        
        Sort( expo );
        
        l := Length( expo );
        
        for i in [ 1 .. l ] do
            
            for j in [ i + 1 .. l ] do
                
                expo[j] := expo[j] - expo[i];
                
            od;
            
        od;
        
        return Reversed( expo );
        
    end;
    
    expo := LeadingMonomial( poly );
    
    expo := expo{List( [ 1 .. Length( expo ) / 2 ], i -> 2 * i )};
    
    expo := transposed_exponents( expo );
    
    l := Length( expo );
    
    while not IsZero( poly ) do
        
        coeff := LeadingCoefficient( poly );
        
        poly := poly - coeff * Product( [ 1 .. l ],
                        i -> elementary_symmetric_polynomial( expo[i], i )^expo[i] );
        
        symm := symm + coeff * Product( [ 1 .. l ],
                        i -> elmsym[i]^expo[i] );
        
        expo := LeadingMonomial( poly );
        
        expo := expo{List( [ 1 .. Length( expo ) / 2 ], i -> 2 * i )};
        
        expo := transposed_exponents( expo );
        
        l := Length( expo );
        
    od;
    
    return symm;
    
end );

##
InstallMethod( Coefficients,
        "for an element of the Grothendieck group of a projective space",
        [ IsElementOfGrothendieckGroupOfProjectiveSpaceRep ],
        
  function( P )
    
    P := UnderlyingModuleElement( P );
    P := UnderlyingMorphism( P );
    P := MatrixOfMap( P, 1, 1 );
    P := Eval( P );
    
    return P!.matrix[1];
    
end );

##
InstallMethod( Coefficients,
        "for an element of the Grothendieck group of a projective space",
        [ IsElementOfGrothendieckGroupOfProjectiveSpaceRep, IsString ],
        
  function( P, twisted )
    local dim, coeffs;
    
    if IsBound( P!.TwistedCoefficients ) then
        return P!.TwistedCoefficients;
    fi;
    
    dim := AmbientDimension( P );
    
    coeffs := Coefficients( P );
    
    coeffs := List( [ 0 .. dim ], i -> Sum( [ 0 .. dim ], d -> (-1)^i * _Binomial( dim - d, i ) * coeffs[d + 1] ) );
    
    P!.TwistedCoefficients := coeffs;
    
    return coeffs;
    
end );

##
InstallMethod( \+,
        "for two elements of the Grothendieck group of a projective space",
        [ IsElementOfGrothendieckGroupOfProjectiveSpaceRep,
          IsElementOfGrothendieckGroupOfProjectiveSpaceRep ],
        
  function( P1, P2 )
    local P;
    
    if not IsIdenticalObj( GrothendieckGroup( P1 ), GrothendieckGroup( P2 ) ) then
        Error( "the Grothendieck groups of the two elements are not identical\n" );
    fi;
    
    P := UnderlyingModuleElement( P1 ) + UnderlyingModuleElement( P2 );
    
    P := CreateElementOfGrothendieckGroupOfProjectiveSpace( P );
    
    if IsBound( P1!.DisplayTwistedCoefficients ) and P1!.DisplayTwistedCoefficients = true and
       IsBound( P2!.DisplayTwistedCoefficients ) and P2!.DisplayTwistedCoefficients = true then
        P!.DisplayTwistedCoefficients := true;
    fi;
    
    return P;
    
end );
    
##
InstallMethod( \+,
        "for two elements of the Grothendieck group of a projective space",
        [ IsElementOfGrothendieckGroupOfProjectiveSpaceRep and HasAssociatedPolynomial,
          IsElementOfGrothendieckGroupOfProjectiveSpaceRep and HasAssociatedPolynomial ],
        
  function( P1, P2 )
    local K_0, chi, P;
    
    K_0 := GrothendieckGroup( P1 );
    
    if not IsIdenticalObj( K_0, GrothendieckGroup( P2 ) ) then
        Error( "the Grothendieck groups of the two elements are not identical\n" );
    fi;
    
    chi := AssociatedPolynomial( P1 ) + AssociatedPolynomial( P2 );
    
    P := CreateElementOfGrothendieckGroupOfProjectiveSpace( chi, K_0 );
    
    if IsBound( P1!.DisplayTwistedCoefficients ) and P1!.DisplayTwistedCoefficients = true and
       IsBound( P2!.DisplayTwistedCoefficients ) and P2!.DisplayTwistedCoefficients = true then
        P!.DisplayTwistedCoefficients := true;
    fi;
    
    return P;
    
end );
    
##
InstallMethod( Value,
        "for an element of the Grothendieck group of a projective space",
        [ IsElementOfGrothendieckGroupOfProjectiveSpaceRep, IsRat ],
        
  function( P, x )
    
    return Value( AssociatedPolynomial( P ), x );
    
end );

##
InstallMethod( Value,
        "for an element of the Grothendieck group of a projective space",
        [ IsPolynomialModuloSomePowerRep, IsRingElement ],
        
  function( poly, x )
    local dim;
    
    dim := AmbientDimension( poly );
    
    poly := Value( poly!.polynomial, x );
    
    return CreatePolynomialModuloSomePower( poly, dim );
    
end );

##
InstallMethod( Rank,
        "for a Chern polynomial with rank",
        [ IsChernPolynomialWithRankRep ],
        
  RankOfObject );

##
InstallMethod( Value,
        "for an element of the Grothendieck group of a projective space",
        [ IsChernPolynomialWithRankRep, IsRingElement ],
        
  function( c, x )
    local r, poly;
    
    r := Rank( c );
    
    poly := Value( TotalChernClass( c ), x );
    
    return CreateChernPolynomial( r, poly );
    
end );

##
InstallMethod( \*,
        "for two polynomials modulo some power",
        [ IsPolynomialModuloSomePowerRep, IsPolynomialModuloSomePowerRep ],
        
  function( poly1, poly2 )
    local dim, p1, p2, p;
    
    dim := AmbientDimension( poly1 );
    
    if dim <> AmbientDimension( poly2 ) then
        Error( "polynomials are defined modulo different powers\n" );
    fi;
    
    if poly1!.indeterminate <> poly2!.indeterminate then
        Error( "indeterminates of polynomials differ\n" );
    fi;
    
    p1 := poly1!.polynomial;
    p2 := poly2!.polynomial;
    
    p := poly1!.normalize( p1 * p2 );
    
    ## checking this property sets it
    Assert( 0, IsUnivariatePolynomial( p ) );
    
    return CreatePolynomialModuloSomePower( p, dim );
    
end );
    
##
InstallMethod( \*,
        "for two Chern polynomials with rank",
        [ IsChernPolynomialWithRankRep, IsChernPolynomialWithRankRep ],
        
  function( C1, C2 )
    local r, c;
    
    r := Rank( C1 ) + Rank( C2 );
    
    c := TotalChernClass( C1 ) * TotalChernClass( C2 );
    
    return CreateChernPolynomial( r, c );
    
end );
    
##
InstallMethod( InverseOp,
        "for a polynomial modulo some power",
        [ IsPolynomialModuloSomePowerRep ],
        
  function( poly )
    local dim, h, normalize, const, y, p, p_i, ldeg, i;
    
    dim := AmbientDimension( poly );
    
    h := poly!.indeterminate;
    
    normalize := poly!.normalize;
    
    poly := poly!.polynomial;
    
    if IsZero( poly ) then
        Error( "division by the zero polynomial\n" );
    fi;
    
    const := CoefficientsOfUnivariatePolynomial( poly )[1];
    
    if IsZero( const ) then
        Error( "the polynomial is not invertible\n" );
    fi;
    
    poly := poly / const;
    
    ## y might be zero
    y := 1 - poly;
    
    p := y^0;	## retain the type of y
    
    ## it is ugly that we need this
    SetIndeterminateOfUnivariateRationalFunction( p, h );
    
    p_i := p;
    
    if IsZero( y ) then
        
        p := p / const;
        
        ## it is ugly that we need this
        SetIndeterminateOfUnivariateRationalFunction( p, h );
        
        ## checking this property sets it
        Assert( 0, IsUnivariatePolynomial( p ) );
        
        return CreatePolynomialModuloSomePower( p, dim );
        
    fi;
    
    ldeg := PositionNonZero( CoefficientsOfUnivariatePolynomial( y ) ) - 1;
    
    for i in [ 1 .. dim + 1 - ldeg ] do
        
        p_i := normalize( p_i * y );
        
        p := p + p_i;
        
    od;
    
    p := p / const;
    
    ## it is ugly that we need this
    SetIndeterminateOfUnivariateRationalFunction( p, h );
    
    ## checking this property sets it
    Assert( 0, IsUnivariatePolynomial( p ) );
    
    return CreatePolynomialModuloSomePower( p, dim );
    
end );

##
InstallMethod( InverseOp,
        "for a Chern polynomial with rank",
        [ IsChernPolynomialWithRankRep ],
        
  function( C )
    local dim, c;
    
    dim := AmbientDimension( C );
    
    c := TotalChernClass( C )^-1;
    
    return CreateChernPolynomial( - Rank( C ), c );
    
end );

##
InstallMethod( Coefficients,
        "for a polynomial modulo some power",
        [ IsPolynomialModuloSomePowerRep ],
        
  function( poly )
    
    return CoefficientsOfUnivariatePolynomial( poly!.polynomial );
    
end );

##
InstallMethod( Coefficients,
        "for a Chern polynomial with rank",
        [ IsChernPolynomialWithRankRep ],
        
  function( c )
    local C;
    
    C := Coefficients( TotalChernClass( c ) );
    
    return C{[ 2 .. Length( C ) ]};
    
end );

##
InstallMethod( InverseOp,
        "for a Chern polynomial with rank",
        [ IsChernPolynomialWithRankRep and IsOne ],
        
  IdFunc );

##
InstallMethod( Rank,
        "for a Chern character",
        [ IsChernCharacterRep ],
        
  RankOfObject );

####################################
#
# constructor functions and methods:
#
####################################

##
InstallMethod( CreateElementOfGrothendieckGroupOfProjectiveSpace,
        "constructor for an element of the Grothendieck group of a projective space",
        [ IsHomalgModuleElement ],
        
  function( elm )
    local K_0, rank, P;
    
    K_0 := Range( UnderlyingMorphism( elm ) );
    
    if not IsHomalgLeftObjectOrMorphismOfLeftObjects( K_0 ) then
        Error( "the Grothendieck group must be defined as a left module\n" );
    elif not ( HasIsFree( K_0 ) and IsFree( K_0 ) ) then
        Error( "the Grothendieck group is either not free or not known to be free\n" );
    fi;
    
    rank := Rank( K_0 );
    
    if rank < 1 then
        Error( "the rank of the Grothendieck group must be greater than 0\n" );
    fi;
    
    P := rec( );
    
    ObjectifyWithAttributes(
            P, TheTypeElementOfGrothendieckGroupOfProjectiveSpace,
            UnderlyingModuleElement, elm,
            GrothendieckGroup, K_0,
            AmbientDimension, rank - 1,
            IsZero, IsZero( elm ) );
    
    return P;
    
end );

##
InstallMethod( CreateElementOfGrothendieckGroupOfProjectiveSpace,
        "constructor for an element of the Grothendieck group of a projective space",
        [ IsList, IsHomalgModule ],
        
  function( coeffs, K_0 )
    local rank, l;
    
    if not IsHomalgLeftObjectOrMorphismOfLeftObjects( K_0 ) then
        Error( "the Grothendieck group must be defined as a left module\n" );
    fi;
    
    rank := Rank( K_0 );
    
    l := Length( coeffs );
    
    if rank < l then
        coeffs := coeffs{[ 1 .. rank ]};
    elif rank > l then
        coeffs := Concatenation( coeffs, ListWithIdenticalEntries( rank - l, 0 ) );
    fi;
    
    coeffs := HomalgMatrix( coeffs, 1, rank, HomalgRing( K_0 ) );
    
    coeffs := HomalgModuleElement( coeffs, K_0 );
    
    return CreateElementOfGrothendieckGroupOfProjectiveSpace( coeffs );
    
end );

##
InstallMethod( CreateElementOfGrothendieckGroupOfProjectiveSpace,
        "constructor for an element of the Grothendieck group of a projective space",
        [ IsList, IsInt ],
        
  function( C, dim )
    local ZZ, K_0;
    
    if dim < 0 then
        dim := Length( C ) - 1;
    fi;
    
    ZZ := HOMALG_MATRICES.ZZ;
    
    K_0 := ( dim + 1 ) * ZZ;
    
    LockObjectOnCertainPresentation( K_0 );
    
    return CreateElementOfGrothendieckGroupOfProjectiveSpace( C, K_0 );
    
end );

##
InstallMethod( CreateElementOfGrothendieckGroupOfProjectiveSpace,
        "constructor for an element of the Grothendieck group of a projective space",
        [ IsList ],
        
  function( C )
    
    return CreateElementOfGrothendieckGroupOfProjectiveSpace( C, -1 );
    
end );

##
InstallMethod( CreateElementOfGrothendieckGroupOfProjectiveSpace,
        "constructor for an element of the Grothendieck group of a projective space",
        [ IsUnivariatePolynomial, IsHomalgModule ],
        
  function( chi, K_0 )
    local C, P;
    
    C := CoefficientsOfElementOfGrothendieckGroupOfProjectiveSpace( chi );
    
    P := CreateElementOfGrothendieckGroupOfProjectiveSpace( C, K_0 );
    
    SetAssociatedPolynomial( P, chi );
    SetIsZero( P, IsZero( chi ) );
    
    return P;
    
end );

##
InstallMethod( CreateElementOfGrothendieckGroupOfProjectiveSpace,
        "constructor for an element of the Grothendieck group of a projective space",
        [ IsUnivariatePolynomial, IsInt ],
        
  function( chi, dim )
    local C, P;
    
    C := CoefficientsOfElementOfGrothendieckGroupOfProjectiveSpace( chi );
    
    P := CreateElementOfGrothendieckGroupOfProjectiveSpace( C, dim );
    
    SetAssociatedPolynomial( P, chi );
    SetIsZero( P, IsZero( chi ) );
    
    return P;
    
end );

##
InstallMethod( CreateElementOfGrothendieckGroupOfProjectiveSpace,
        "constructor for an element of the Grothendieck group of a projective space",
        [ IsUnivariatePolynomial ],
        
  function( chi )
    
    return CreateElementOfGrothendieckGroupOfProjectiveSpace( chi, -1 );
    
end );

##
InstallMethod( CreatePolynomialModuloSomePower,
        "constructor polynomials modulo some power",
        [ IsUnivariatePolynomial, IsInt ],
        
  function( poly, dim )
    local h, normalize, p;
    
    h := IndeterminateOfUnivariateRationalFunction( poly );
    
    normalize := function( poly )
        local p;
        
        p := PolynomialReduction( poly, [ h^(dim + 1) ], MonomialLexOrdering( ) )[1];
        
        ## it is ugly that we need this
        SetIndeterminateOfUnivariateRationalFunction( p, h );
        
        ## checking this property sets it
        Assert( 0, IsUnivariatePolynomial( p ) );
        
        return p;
    end;
    
    p := rec( polynomial := normalize( poly ),
              indeterminate := h,
              normalize := normalize );
    
    ObjectifyWithAttributes(
            p, TheTypePolynomialModuloSomePower,
            AmbientDimension, dim,
            IsOne, IsOne( poly ) );
    
    return p;
    
end );

##
InstallMethod( CreateChernPolynomial,
        "constructor of Chern polynomials with rank",
        [ IsInt, IsPolynomialModuloSomePowerRep ],
        
  function( rank, p )
    local h, C;
    
    h := p!.indeterminate;
    
    C := rec( indeterminate := h );
    
    ObjectifyWithAttributes(
            C, TheTypeChernPolynomialWithRank,
            RankOfObject, rank,
            TotalChernClass, p,
            AmbientDimension, AmbientDimension( p ),
            IsOne, IsOne( p ) and IsZero( rank ) );
    
    return C;
    
end );

##
InstallMethod( CreateChernPolynomial,
        "constructor of Chern polynomials with rank",
        [ IsInt, IsUnivariatePolynomial, IsInt ],
        
  function( rank, poly, dim )
    local p;
    
    p := CreatePolynomialModuloSomePower( poly, dim );
    
    return CreateChernPolynomial( rank, p );
    
end );

##
InstallMethod( CreateChernCharacter,
        "constructor of Chern characters",
        [ IsUnivariatePolynomial, IsInt ],
        
  function( poly, dim )
    local t, c, ch;
    
    t := IndeterminateOfUnivariateRationalFunction( poly );
    
    c := CreatePolynomialModuloSomePower( poly, dim );
    
    ch := rec( indeterminate := t );
    
    ObjectifyWithAttributes(
            ch, TheTypeChernCharacter,
            RankOfObject, Value( poly, 0 ),
            ChernCharacterPolynomial, c,
            AmbientDimension, dim,
            IsZero, IsZero( poly ) );
    
    return ch;
    
end );

####################################
#
# View, Print, and Display methods:
#
####################################

##
InstallMethod( ViewObj,
        "for an element of the Grothendieck group of a projective space",
        [ IsElementOfGrothendieckGroupOfProjectiveSpaceRep ],
        
  function( P )
    local twisted, coeffs, l, h, i, c;
    
    Print( "( " );
    
    if IsBound( P!.DisplayTwistedCoefficients ) and P!.DisplayTwistedCoefficients = true then
        twisted := true;
        coeffs := Coefficients( P, "twisted" );
    else
        twisted := false;
        coeffs := Coefficients( P );
    fi;
    
    l := Length( coeffs );
    
    coeffs := Reversed( coeffs );
    
    h := PositionNonZero( coeffs );
    
    coeffs := coeffs{[ h .. l ]};
    
    c := coeffs[1];
    
    if twisted then
        Print( c, "*O(", -(l - h), ")" );
    else
        Print( c, "*O_{P^", l - h, "}" );
    fi;
    
    for i in [ 2 .. l - h + 1 ] do
        c := coeffs[i];
        if not IsZero( c ) then
            if c > 0 then
                Print( " + " );
            else
                c := -c ;
                Print( " - " );
            fi;
            if twisted then
                Print( c, "*O(", -(l - h + 1 - i), ")" );
            else
                Print( c, "*O_{P^", l - h + 1 - i, "}" );
            fi;
        fi;
    od;
    
    Print( " ) -> P^", AmbientDimension( P ) );
    
end );

##
InstallMethod( ViewObj,
        "for an element of the Grothendieck group of a projective space",
        [ IsElementOfGrothendieckGroupOfProjectiveSpaceRep and IsZero ],
        
  function( P )
    
    Print( "0 -> P^", AmbientDimension( P ) );
    
end );

##
InstallMethod( ViewObj,
        "for a polynomial modulo some power",
        [ IsPolynomialModuloSomePowerRep ],
        
  function( p )
    
    ViewObj( p!.polynomial );
    
end );

##
InstallMethod( ViewObj,
        "for a Chern polynomial with rank",
        [ IsChernPolynomialWithRankRep ],
        
  function( C )
    local c, h, coeffs, l, i;
    
    Print( "( ", RankOfObject( C ), " | " );
    
    c := TotalChernClass( C );
    
    h := C!.indeterminate;
    
    coeffs := Coefficients( c );
    
    Print( coeffs[1] );
    
    l := Length( coeffs );
    
    if l > 1 and not IsZero( coeffs[2] ) then
        
        if coeffs[2] = 1 then
            Print( "+" );
        elif coeffs[2] > 0 then
            Print( "+", coeffs[2], "*" );
        elif coeffs[2] = -1 then
            Print( "-" );
        elif coeffs[2] < 0 then
            Print( coeffs[2], "*" );
        fi;
        
        Print( h );
        
    fi;
    
    for i in [ 3 .. l ] do
        
        if not IsZero( coeffs[i] ) then
            
            if coeffs[i] = 1 then
                Print( "+" );
            elif coeffs[i] > 0 then
                Print( "+", coeffs[i], "*" );
            elif coeffs[i] = -1 then
                Print( "-" );
            elif coeffs[i] < 0 then
                Print( coeffs[i], "*" );
            fi;
            
            Print( h, "^", i - 1 );
            
        fi;
        
    od;
    
    Print( " ) -> P^", AmbientDimension( C ) );
    
end );

##
InstallMethod( ViewObj,
        "for a Chern character",
        [ IsChernCharacterRep ],
        
  function( ch )
    local c, t, coeffs, l, i;
    
    Print( "[ " );
    
    c := ChernCharacterPolynomial( ch );
    
    t := ch!.indeterminate;
    
    coeffs := Coefficients( c );
    
    l := Length( coeffs );
    
    coeffs := List( [ 0 .. l - 1 ], i -> coeffs[i + 1] * Factorial( i ) );
    
    Print( coeffs[1] );
    
    if l > 1 and not IsZero( coeffs[2] ) then
        
        if coeffs[2] = 1 then
            Print( "+" );
        elif coeffs[2] > 0 then
            Print( "+", coeffs[2], "*" );
        elif coeffs[2] = -1 then
            Print( "-" );
        elif coeffs[2] < 0 then
            Print( coeffs[2], "*" );
        fi;
        
        Print( t );
        
    fi;
    
    for i in [ 3 .. l ] do
        
        if not IsZero( coeffs[i] ) then
            
            if coeffs[i] = 1 then
                Print( "+" );
            elif coeffs[i] > 0 then
                Print( "+", coeffs[i], "*" );
            elif coeffs[i] = -1 then
                Print( "-" );
            elif coeffs[i] < 0 then
                Print( coeffs[i], "*" );
            fi;
            
            Print( t, "^", i - 1, "/", i - 1, "!" );
            
        fi;
        
    od;
    
    Print( " ] -> P^", AmbientDimension( ch ) );
    
end );

##
InstallMethod( ViewObj,
        "for a Chern character",
        [ IsChernCharacterRep and IsZero ],
        
  function( ch )
    
    Print( "0 -> P^", AmbientDimension( ch ) );
    
end );

##
InstallMethod( Display,
        "for an element of the Grothendieck group of a projective space",
        [ IsElementOfGrothendieckGroupOfProjectiveSpaceRep ],
        
  function( P )
    
    ViewObj( P ); Print( "\n" );
    
end );
