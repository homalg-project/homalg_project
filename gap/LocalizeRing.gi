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
InstallMethod( AssociatedGlobalRing,
        "for homalg local matrices",
        [ IsHomalgLocalMatrixRep ],
        
  function( A )
    
    return AssociatedGlobalRing( HomalgRing(A) );
    
end );

##
InstallMethod( Numerator,
        "for homalg local ring elements",
        [ IsHomalgLocalRingElementRep ],
        
  function( r )
    
    return r!.numer;
    
end );

##
InstallMethod( Denominator,
        "for homalg local ring elements",
        [ IsHomalgLocalRingElementRep ],
        
  function( r )
    
    return r!.denom;
    
end );

##
InstallMethod( Numerator,
        "for homalg local matrices",
        [ IsHomalgLocalMatrixRep ],
        
  function( M )
    
    return Eval( M )[1];
    
end );

##
InstallMethod( Denominator,
        "for homalg local matrices",
        [ IsHomalgLocalMatrixRep ],
        
  function( M )
    
    return Eval( M )[2];
    
end );

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

##
InstallMethod( GetEntryOfHomalgMatrixAsString,
        "for homalg local matrices",
        [ IsHomalgLocalMatrixRep, IsInt, IsInt, IsHomalgLocalRingRep ],
        
  function( M, r, c, R )
    local m;
    
    m := Eval( M );
    
    return Concatenation( [ "(", GetEntryOfHomalgMatrixAsString( m[1], r, c, AssociatedGlobalRing( R ) ), ")/(", Name( m[2] ), ")" ] );
    
end );

##
InstallMethod( GetEntryOfHomalgMatrix,
        "for homalg local matrices",
        [ IsHomalgLocalMatrixRep, IsInt, IsInt, IsHomalgLocalRingRep ],
        
  function( M, r, c, R )
    local m;
    
    m :=Eval( M );
    
    return HomalgLocalRingElement( GetEntryOfHomalgMatrix( m[1], r, c, AssociatedGlobalRing( R ) ), m[2], R );
    
end );

InstallMethod( Cancel,
  "for pairs of global ring elements",
  [ IsHomalgRingElement, IsHomalgRingElement ],
  function( a, b )
  local R, RP, result;
    
    R := HomalgRing( a );
    
    if R = fail then
        TryNextMethod( );
    elif not HasRingElementConstructor( R ) then
        Error( "no ring element constructor found in the ring\n" );
    fi;
    
    RP := homalgTable( R );
    
    if IsBound(RP!.CancelGcd) then
      
      result := RP!.CancelGcd( a , b );
      
      Assert( 4 , result[1] * b = result[2] * a );
      
      return result;
      
    else #fallback: no cancelation
    
      return [ a , b ];
    
    fi;
    
  end
);

####################################
#
# constructor functions and methods:
#
####################################

##
InstallMethod( LocalizeAt,
        "constructor for homalg localized rings",
        [ IsHomalgRing and IsFreePolynomialRing, IsList ],
        
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
    
    return localR;
    
end );

##
InstallMethod( LocalizeAt,
        "constructor for homalg localized rings",
        [ IsHomalgRing and IsFreePolynomialRing ],
        
  function( globalR )
    
    return LocalizeAt( globalR, IndeterminatesOfPolynomialRing( globalR ) );
    
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
        
    elif nargs = 2 then
        
        ## extract the properties of the global ring element
        if IsHomalgRing( arg[2] ) then
            ring := arg[2];
            ar := [ numer, ring ];
            properties := KnownTruePropertiesOfObject( numer );
            Append( ar, List( properties, ValueGlobal ) );	## at least an empty list is inserted; avoids infinite loops
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

##
InstallMethod( HomalgLocalMatrix,
        "constructor for matrices over localized rings",
        [ IsHomalgMatrix, IsRingElement, IsHomalgLocalRingRep ],
        
  function( A, r, R )
    local G, type, matrix;
    
    G := HomalgRing( A );
    
    if IsHomalgRingElement( r ) and not IsIdenticalObj( HomalgRing( r ), G ) then
        Error( "the ring of the element and the ring of the matrix are not identical\n" );
    fi;
    
    if not IsIdenticalObj( G, AssociatedGlobalRing( R ) ) then
        Error( "the ring the matrix and the global ring of the specified local ring are not identical\n" );
    fi;
    
    matrix := rec( ring := R );
    
    ObjectifyWithAttributes(
            matrix, TheTypeHomalgLocalMatrix,
            Eval, [ A, r ] );
    
    BlindlyCopyMatrixPropertiesToLocalMatrix( A, matrix );
    
    return matrix;
    
end );

##
InstallMethod( HomalgLocalMatrix,
        "constructor for matrices over localized rings",
        [ IsHomalgMatrix, IsHomalgLocalRingRep ],
        
  function( A, R )
    
    return HomalgLocalMatrix( A, One( AssociatedGlobalRing( R ) ), R );
    
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
