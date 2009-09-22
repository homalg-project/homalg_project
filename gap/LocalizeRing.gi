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
##      The representation of elements of local &homalg; rings. <P/>
##      (It is a representation of the &GAP; category <C>IsHomalgRingElement</C>.)
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareRepresentation( "IsHomalgLocalRingElementRep",
        IsHomalgRingElement,
        [ "pointer" ] );

##  <#GAPDoc Label="IsHomalgLocalMatrixRep">
##  <ManSection>
##    <Filt Type="Representation" Arg="A" Name="IsHomalgLocalMatrixRep"/>
##    <Returns>true or false</Returns>
##    <Description>
##      The representation of &homalg; matrices with entries in a &homalg; local ring. <P/>
##      (It is a representation of the &GAP; category <C>IsHomalgMatrix</C>.)
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareRepresentation( "IsHomalgLocalMatrixRep",
        IsHomalgMatrix,
        [ ] );

## three new types:
BindGlobal( "TheTypeHomalgLocalRing",
        NewType( TheFamilyOfHomalgRings,
                IsHomalgLocalRingRep ) );

BindGlobal( "TheTypeHomalgLocalRingElement",
        NewType( TheFamilyOfHomalgRingElements,
                IsHomalgLocalRingElementRep ) );

BindGlobal( "TheTypeHomalgLocalMatrix",
        NewType( TheFamilyOfHomalgMatrices,
                IsHomalgLocalMatrixRep ) );

####################################
#
# methods for operations:
#
####################################

##  <#GAPDoc Label="HomalgRing:localringelement">
##  <ManSection>
##    <Oper Arg="r" Name="HomalgRing" Label="for homalg local ring elements"/>
##    <Returns>a &homalg; local ring</Returns>
##    <Description>
##      The &homalg; local ring from the &LocalizeRingForHomalg; package from a local ring element <A>r</A>.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
InstallMethod( HomalgRing,
        "for homalg local ring elements",
        [ IsHomalgLocalRingElementRep ],
        
  function( r )
    
    return r!.ring;
    
end );

##
InstallMethod( AssociatedComputationRing,
        "for homalg local rings",
        [ IsHomalgLocalRingRep ],
        
  function( R )
    
    if IsBound( R!.AssociatedComputationRing ) then
    
      return R!.AssociatedComputationRing;
    
    else
    
      return R!.ring;
    
    fi;
    
end );

##
InstallMethod( AssociatedComputationRing,
        "for homalg local ring elements",
        [ IsHomalgLocalRingElementRep ],
        
  function( r )
    
    return AssociatedComputationRing( HomalgRing( r ) );
    
end );

##
InstallMethod( AssociatedComputationRing,
        "for homalg local matrices",
        [ IsHomalgLocalMatrixRep ],
        
  function( A )
    
    return AssociatedComputationRing( HomalgRing(A) );
    
end );

##  <#GAPDoc Label="AssociatedGlobalRing:ring">
##  <ManSection>
##    <Oper Arg="R" Name="AssociatedGlobalRing" Label="for homalg local rings"/>
##    <Returns>a global &homalg; ring</Returns>
##    <Description>
##      The global &homalg; ring, from which the local ring <A>R</A> was created.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
InstallMethod( AssociatedGlobalRing,
        "for homalg local rings",
        [ IsHomalgLocalRingRep ],
        
  function( R )
    
    if IsBound( R!.AssociatedGlobalRing ) then
    
      return R!.AssociatedGlobalRing;
    
    else
    
      return R!.ring;
    
    fi;
    
end );

##  <#GAPDoc Label="AssociatedGlobalRing:element">
##  <ManSection>
##    <Oper Arg="r" Name="AssociatedGlobalRing" Label="for homalg local ring elements"/>
##    <Returns>a global &homalg; ring</Returns>
##    <Description>
##      The global &homalg; ring, from which the local ring element <A>r</A> was created.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
InstallMethod( AssociatedGlobalRing,
        "for homalg local ring elements",
        [ IsHomalgLocalRingElementRep ],
        
  function( r )
    
    return AssociatedGlobalRing( HomalgRing( r ) );
    
end );

##  <#GAPDoc Label="AssociatedGlobalRing:matrix">
##  <ManSection>
##    <Oper Arg="mat" Name="AssociatedGlobalRing" Label="for homalg local matrices"/>
##    <Returns>a global &homalg; ring</Returns>
##    <Description>
##      The global &homalg; ring, from which the local matrix <A>mat</A> was created.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
InstallMethod( AssociatedGlobalRing,
        "for homalg local matrices",
        [ IsHomalgLocalMatrixRep ],
        
  function( A )
    
    return AssociatedGlobalRing( HomalgRing(A) );
    
end );

##  <#GAPDoc Label="Numerator:element">
##  <ManSection>
##    <Oper Arg="r" Name="Numerator" Label="for homalg local ring elements"/>
##    <Returns>a (global) &homalg; ring element</Returns>
##    <Description>
##      The numerator from a local ring element <A>r</A>, which is a global &homalg; ring element.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
InstallMethod( Numerator,
        "for homalg local ring elements",
        [ IsHomalgLocalRingElementRep ],
        
  function( r )
    
    return r!.numer;
    
end );

##  <#GAPDoc Label="Denominator:element">
##  <ManSection>
##    <Oper Arg="r" Name="Denominator" Label="for homalg local ring elements"/>
##    <Returns>a (global) &homalg; ring element</Returns>
##    <Description>
##      The denominator from a local ring element <A>r</A>, which is a global &homalg; ring element.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
InstallMethod( Denominator,
        "for homalg local ring elements",
        [ IsHomalgLocalRingElementRep ],
        
  function( r )
    
    return r!.denom;
    
end );

##  <#GAPDoc Label="Numerator:matrix">
##  <ManSection>
##    <Oper Arg="mat" Name="Numerator" Label="for homalg local matrices"/>
##    <Returns>a (global) &homalg; matrix</Returns>
##    <Description>
##      The numerator from a local matrix <A>mat</A>, which is a global &homalg; matrix.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
InstallMethod( Numerator,
        "for homalg local matrices",
        [ IsHomalgLocalMatrixRep ],
        
  function( M )
    
    return Eval( M )[1];
    
end );

##  <#GAPDoc Label="Denominator:matrix">
##  <ManSection>
##    <Oper Arg="mat" Name="Denominator" Label="for homalg local matrices"/>
##    <Returns>a (global) &homalg; ring element</Returns>
##    <Description>
##      The denominator from a local matrix <A>mat</A>, which is a global &homalg; ring element.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
InstallMethod( Denominator,
        "for homalg local matrices",
        [ IsHomalgLocalMatrixRep ],
        
  function( M )
    
    return Eval( M )[2];
    
end );

##  <#GAPDoc Label="Name:localmatrix">
##  <ManSection>
##    <Oper Arg="r" Name="Name" Label="for homalg local ring elements"/>
##    <Returns>a string</Returns>
##    <Description>
##      The name of the local ring element <A>r</A>.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
InstallMethod( Name,
        "for homalg local ring elements",
        [ IsHomalgLocalRingElementRep ],

  function( o )
    
    return Flat( [ Name( Numerator( o ) ), "/",  Name( Denominator( o ) ) ] );

end );

##
InstallMethod( BlindlyCopyMatrixPropertiesToLocalMatrix,	## under construction
        "for homalg matrices",
        [ IsHomalgMatrix, IsHomalgLocalMatrixRep ],
        
  function( S, T )
    
    if HasNrRows( S ) then
        SetNrRows( T, NrRows( S ) );
    fi;
    
    if HasNrColumns( S ) then
        SetNrColumns( T, NrColumns( S ) );
    fi;
    
    if HasIsZero( S ) then
        SetIsZero( T, IsZero( S ) );
    fi;
    
    if HasIsIdentityMatrix( S ) then
        SetIsIdentityMatrix( T, IsIdentityMatrix( S ) );
    fi;
    
end );

##  <#GAPDoc Label="SetEntryOfHomalgMatrix:localmatrix">
##  <ManSection>
##    <Oper Arg="mat, i, j, r, R" Name="SetEntryOfHomalgMatrix" Label="for homalg local matrices"/>
##    <Description>
##      Changes the entry (<A>i,j</A>) of the local matrix <A>mat</A> to the value <A>r</A>, where <A>R</A> is the corresponding global ring.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
InstallMethod( SetEntryOfHomalgMatrix,
        "for homalg local matrices",
        [ IsHomalgLocalMatrixRep and IsMutableMatrix, IsInt, IsInt, IsHomalgLocalRingElementRep, IsHomalgLocalRingRep ],
        
  function( M, r, c, s, R )
    local m, N, globalR, M2, e;
    
    m := Eval( M );
    
    globalR := AssociatedGlobalRing( R );
    
    N := HomalgInitialMatrix( NrRows( M ), NrColumns( M ), globalR );
    
    SetEntryOfHomalgMatrix( N, r, c, Numerator( s ) );
    
    ResetFilterObj( N, IsInitialMatrix );
    
    N := HomalgLocalMatrix( N, Denominator( s ), R );
    
    M2 := m[1];
    
    SetEntryOfHomalgMatrix( M2, r, c, Zero( globalR ) );
    
    e := Eval( HomalgLocalMatrix( M2, m[2], R ) + N );
    
    SetIsMutableMatrix( e[1], true );
    
    M!.Eval := e;
    
end );

##  <#GAPDoc Label="AddToEntryOfHomalgMatrix:localmatrix">
##  <ManSection>
##    <Oper Arg="mat, i, j, r, R" Name="AddToEntryOfHomalgMatrix" Label="for homalg local matrices"/>
##    <Description>
##      Changes the entry (<A>i,j</A>) of the local matrix <A>mat</A> by adding the value <A>r</A> to it, where <A>R</A> is the corresponding global ring.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
InstallMethod( AddToEntryOfHomalgMatrix,
        "for homalg local matrices",
        [ IsHomalgLocalMatrixRep and IsMutableMatrix, IsInt, IsInt, IsHomalgLocalRingElementRep, IsHomalgLocalRingRep ],
        
  function( M, r, c, s, R )
    local globalR, N, e;
    
    globalR := AssociatedGlobalRing( R );
    
    N := HomalgInitialMatrix( NrRows( M ), NrColumns( M ), globalR );
    
    SetEntryOfHomalgMatrix( N, r, c, Numerator( s ) );
    
    ResetFilterObj( N, IsInitialIdentityMatrix );
    
    N := HomalgLocalMatrix( N, Denominator( s ), R );
    
    e := Eval( M + N );
    
    SetIsMutableMatrix( e[1], true );
    
    M!.Eval := e;
    
end );

##  <#GAPDoc Label="GetEntryOfHomalgMatrixAsString:localmatrix">
##  <ManSection>
##    <Oper Arg="mat, i, j, R" Name="GetEntryOfHomalgMatrixAsString" Label="for homalg local matrices"/>
##    <Returns>a string</Returns>
##    <Description>
##      Returns the entry (<A>i,j</A>) of the local matrix <A>mat</A> as a string, where <A>R</A> is the corresponding global ring.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
InstallMethod( GetEntryOfHomalgMatrixAsString,
        "for homalg local matrices",
        [ IsHomalgLocalMatrixRep, IsInt, IsInt, IsHomalgLocalRingRep ],
        
  function( M, r, c, R )
    local m;
    
    m := Eval( M );
    
    return Concatenation( [ "(", GetEntryOfHomalgMatrixAsString( m[1], r, c, AssociatedGlobalRing( R ) ), ")/(", Name( m[2] ), ")" ] );
    
end );

##  <#GAPDoc Label="GetEntryOfHomalgMatrix:localmatrix">
##  <ManSection>
##    <Oper Arg="mat, i, j, R" Name="GetEntryOfHomalgMatrix" Label="for homalg local matrices"/>
##    <Returns>a local ring element</Returns>
##    <Description>
##      Returns the entry (<A>i,j</A>) of the local matrix <A>mat</A>, where <A>R</A> is the corresponding global ring.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
InstallMethod( GetEntryOfHomalgMatrix,
        "for homalg local matrices",
        [ IsHomalgLocalMatrixRep, IsInt, IsInt, IsHomalgLocalRingRep ],
        
  function( M, r, c, R )
    local m;
    
    m :=Eval( M );
    
    return HomalgLocalRingElement( GetEntryOfHomalgMatrix( m[1], r, c, AssociatedGlobalRing( R ) ), m[2], R );
    
end );

##  <#GAPDoc Label="Cancel">
##  <ManSection>
##    <Oper Arg="a, b" Name="Cancel" Label="for pairs of global ring elements"/>
##    <Returns>two local ring elements</Returns>
##    <Description>
##      For <M>a=a'*c</M> and <M>b=b'*c</M> return <M>a'</M> and <M>b'</M>. Finding <M>c</M> depends on whether a gcd is included in the ring package .
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
InstallMethod( Cancel,
        "for pairs of global ring elements",
        [ IsHomalgRingElement, IsHomalgRingElement ],
        
  function( a, b )
    local R, za, zb, z, ma, mb, o, RP, result;
    
    R := HomalgRing( a );
    
    if R = fail then
        TryNextMethod( );
    elif not HasRingElementConstructor( R ) then
        Error( "no ring element constructor found in the ring\n" );
    fi;
    
    za := IsZero( a );
    zb := IsZero( b );
    
    if za and zb then
        
        z := Zero( R );
        
        return [ z, z ];
        
    elif za then
        
        return [ Zero( R ), One( R ) ];
        
    elif zb then
        
        return [ One( R ), Zero( R ) ];
        
    fi;
    
    if IsOne( a ) then
        
        return [ One( R ), b ];
        
    elif IsOne( b ) then
        
        return [ a, One( R ) ];
        
    fi;
    
    ma := IsMinusOne( a );
    mb := IsMinusOne( b );
    
    if ma and mb then
        
        o := One( R );
        
        return [ o, o ];
        
    elif ma then
        
        return [ One( R ), -b ];
        
    elif mb then
        
        return [ -a, One( R ) ];
        
    fi;
    
    RP := homalgTable( R );
    
    if IsBound(RP!.CancelGcd) then
        
        result := RP!.CancelGcd( a, b );
        
        Assert( 4, result[1] * b = result[2] * a );
        
        return result;
        
    else	#fallback: no cancelation
        
        return [ a, b ];
        
    fi;
    
end );

##
InstallMethod( Cancel,
        "for pairs of global ring elements",
        [ IsRingElement and IsMinusOne, IsRingElement ],
        
  function( a, b )
    
    return [ One( b ), -b ];
    
end );

##
InstallMethod( Cancel,
        "for pairs of global ring elements",
        [ IsRingElement, IsRingElement and IsMinusOne ],
        
  function( a, b )
    
    return [ -a, One( a ) ];
    
end );

##
InstallMethod( Cancel,
        "for pairs of global ring elements",
        [ IsRingElement and IsMinusOne, IsRingElement and IsMinusOne ],
        
  function( a, b )
    local o;
    
    o := One( a );
    
    return [ o, o ];
    
end );

##
InstallMethod( Cancel,
        "for pairs of global ring elements",
        [ IsRingElement and IsOne, IsRingElement ],
        
  function( a, b )
    
    return [ One( a ), b ];
    
end );

##
InstallMethod( Cancel,
        "for pairs of global ring elements",
        [ IsRingElement, IsRingElement and IsOne ],
        
  function( a, b )
    
    return [ a, One( b ) ];
    
end );

##
InstallMethod( Cancel,
        "for pairs of global ring elements",
        [ IsRingElement and IsZero, IsRingElement ],
        
  function( a, b )
    
    return [ Zero( a ), One( a ) ];
    
end );

##
InstallMethod( Cancel,
        "for pairs of global ring elements",
        [ IsRingElement, IsRingElement and IsZero ],
        
  function( a, b )
    
    return [ One( b ), Zero( b ) ];
    
end );

##
InstallMethod( Cancel,
        "for pairs of global ring elements",
        [ IsRingElement and IsZero, IsRingElement and IsZero ],
        
  function( a, b )
    local z;
    
    z := Zero( a );
    
    return [ z, z ];
    
end );

####################################
#
# constructor functions and methods:
#
####################################

##  <#GAPDoc Label="LocalizeAt">
##  <ManSection>
##    <Oper Arg="R, l" Name="LocalizeAt" Label= "constructor for homalg localized rings"/>
##    <Returns>a local ring</Returns>
##    <Description>
##      If <A>l</A> is a list of elements of the global ring <A>R</A> generating a maximal ideal, the method creates the corresponding localization of <A>R</A> at the complement of the maximal ideal.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
InstallMethod( LocalizeAt,
        "constructor for homalg localized rings",
        [ IsHomalgRing and IsCommutative, IsList ],
        
  function( globalR, ideal_gens )
    local RP, localR, n_gens, gens;
    
    ## create ring RP with R as underlying global ring
    RP := CreateHomalgTableForLocalizedRings( globalR );
    
    ## create the local ring
    localR := CreateHomalgRing( globalR, [ TheTypeHomalgLocalRing, TheTypeHomalgLocalMatrix ], HomalgLocalRingElement, RP );
    
    ## for the view method: <A homalg local matrix>
    localR!.description := "local";
    
    SetIsLocalRing( localR, true );
    
    n_gens := Length( ideal_gens );
    
    gens := HomalgMatrix( ideal_gens, n_gens, 1, globalR );
    
    SetGeneratorsOfMaximalLeftIdeal( localR, gens );
    
    gens := HomalgMatrix( ideal_gens, 1, n_gens, globalR );
    
    SetGeneratorsOfMaximalRightIdeal( localR, gens );
    
    localR!.AssociatedGlobalRing := globalR;
    
    localR!.AssociatedComputationRing := globalR;
    
    return localR;
    
end );

##  <#GAPDoc Label="LocalizeAt:poly">
##  <ManSection>
##    <Oper Arg="R" Name="LocalizeAt" Label= "constructor for homalg localized rings for polynomial rings at zero"/>
##    <Returns>a local ring</Returns>
##    <Description>
##      If <A>R</A> is a free polynomial ring, this method creates the corresponding localization of <A>R</A> at the complement of the maximal ideal generated by the indeterminates.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
InstallMethod( LocalizeAt,
        "constructor for homalg localized rings",
        [ IsHomalgRing and IsFreePolynomialRing ],
        
  function( globalR )
    
    return LocalizeAt( globalR, IndeterminatesOfPolynomialRing( globalR ) );
    
end );

##  <#GAPDoc Label="HomalgLocalRingElement">
##  <ManSection>
##    <Func Arg="numer, denom, R" Name="HomalgLocalRingElement" Label="constructor for local ring elements using numerator and denominator"/>
##    <Func Arg="numer, R" Name="HomalgLocalRingElement" Label="constructor for local ring elements using a given numerator and one as denominator"/>
##    <Returns>a local ring element</Returns>
##    <Description>
##      Creates the local ring element <A>numer</A><M>/</M><A>denom</A> or in the second case <M>numer/1</M> for the local ring <A>R</A>.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
InstallGlobalFunction( HomalgLocalRingElement,
  function( arg )
    local nargs, numer, ring, ar, properties, denom, computationring, c, r;
    
    nargs := Length( arg );
    
    if nargs = 0 then
         Error( "empty input\n" );
    fi;
    
    numer := arg[1];
    
    if IsHomalgLocalRingElementRep( numer ) then
        
        ## otherwise simply return it
        return numer;
        
    elif nargs = 2 then
        
        ## extract the properties of the global ring element
        if IsHomalgRing( arg[2] ) then
            ring := arg[2];
            ar := [ numer, ring ];
            properties := KnownTruePropertiesOfObject( numer );
            Append( ar, List( properties, ValueGlobal ) );  ## at least an empty list is inserted; avoids infinite loops
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
    
    computationring := AssociatedComputationRing( ring );
    
    if not IsBound( denom ) then
        denom := One( numer );
    fi;
    
    c := Cancel( numer, denom );
    numer := c[1] / computationring;
    denom := c[2] / computationring;
    
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

##  <#GAPDoc Label="HomalgLocalMatrix">
##  <ManSection>
##    <Func Arg="numer, denom, R" Name="HomalgLocalMatrix" Label="constructor for local matrices using numerator and denominator"/>
##    <Func Arg="numer, R" Name="HomalgLocalRingElement" Label="constructor for local matrices using a given numerator and one as denominator"/>
##    <Returns>a local matrix</Returns>
##    <Description>
##      Creates the local matrix <A>numer</A><M>/</M><A>denom</A> or in the second case <M>numer/1</M> for the local ring <A>R</A>. Here <A>numer</A> is a global matrix and denom a global ring element.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
InstallMethod( HomalgLocalMatrix,
        "constructor for matrices over localized rings",
        [ IsHomalgMatrix, IsRingElement, IsHomalgLocalRingRep ],
        
  function( A, r, R )
    local G, type, matrix, computationring, AA;
    
    G := HomalgRing( A );
    
    computationring := AssociatedComputationRing( R );
    
    matrix := rec( ring := R );
    
    ObjectifyWithAttributes(
        matrix, TheTypeHomalgLocalMatrix,
        Eval, [ A, r ]
    );
    
    BlindlyCopyMatrixPropertiesToLocalMatrix( A, matrix );
    
    return matrix;
    
end );

##
InstallMethod( HomalgLocalMatrix,
        "constructor for matrices over localized rings",
        [ IsHomalgMatrix, IsHomalgLocalRingRep ],
        
  function( A, R )
    
    return HomalgLocalMatrix( A, One( AssociatedComputationRing( R ) ), R );
    
end );

##
InstallMethod( SetIsMutableMatrix,
        "for homalg local matrices",
        [ IsHomalgLocalMatrixRep, IsBool ],
        
  function( A, b )
    
    if b = true then
      SetFilterObj( A, IsMutableMatrix );
    else
      ResetFilterObj( A, IsMutableMatrix );
    fi;
    
    SetIsMutableMatrix( Numerator( A ), b );
    
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

##
InstallMethod( Display,
        "for homalg local ring elements",
        [ IsHomalgLocalRingElementRep ],
        
  function( r )
    
    Print( Flat( [ Name(r), "\n" ] ) );
    
end );

##
InstallMethod( Display,
        "for homalg matrices over a homalg local ring",
        [ IsHomalgLocalMatrixRep ],
        
  function( A )
    local a;
    
    a := Eval( A );
    
    Display( a[1] );
    Print( Flat( [ "/ ", Name( a[2] ), "\n" ] ) );
    
end );
