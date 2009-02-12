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
        "for homalg local matrix elements",
        [ IsHomalgLocalMatrixRep ],
        
  function( A )
    
    return AssociatedGlobalRing( HomalgRing(A) );
    
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
#   InstallMethod( SetEntryOfHomalgMatrix,
#           "for local matrices",
#           [ IsHomalgLocalMatrixRep and IsMutableMatrix, IsInt, IsInt, IsHomalgLocalRingRep, IsHomalgLocalRingRep ],
#        
#     function( M, r, c, s, R )
#   
#     local N, globalR;
#    
#       globalR := AssociatedGlobalRing( R );
#      
#       N := homalgTable(globalR)!.ZeroMatrix( Eval( M )[2] );
#      
#       N := SetEntryOfHomalgMatrix( N , r , c , NumeratorOfLocalElement( s ) , globalR );
#      
#       N := HomalgLocalMatrix( N , DenominatorOfLocalElement( s ) , R );
#    
#       M := HomalgLocalMatrix( SetEntryOfHomalgMatrix( Eval( M )[2] , r , c , "0" , globalR ) , Eval( M )[1] , R );
#      
#       M := M + N;
#      
#   end );

##
  InstallMethod( AddToEntryOfHomalgMatrix,
          "for local matrices",
#          [ IsHomalgLocalMatrixRep and IsMutableMatrix, IsInt, IsInt, IsHomalgLocalRingElementRep, IsHomalgLocalRingRep ],
          [ IsHomalgLocalMatrixRep , IsInt, IsInt, IsHomalgLocalRingElementRep, IsHomalgLocalRingRep ],
        
    function( M, r, c, s, R )
    
    local N, globalR;
  
      globalR := AssociatedGlobalRing( R );
     
      N := homalgTable(globalR)!.ZeroMatrix( Eval( M )[2] );
     
      N := SetEntryOfHomalgMatrix( N , r , c , NumeratorOfLocalElement( s ) , globalR );
     
      N := HomalgLocalMatrix( N , DenominatorOfLocalElement( s ) , R );
    
      M := M + N;
    
  end );

##
InstallMethod( GetEntryOfHomalgMatrixAsString,
        "for local matrices",
        [ IsHomalgLocalMatrixRep, IsInt, IsInt, IsHomalgLocalRingRep ],
        
  function( M, r, c, R )
    
    return Concatenation( [ "(", GetEntryOfHomalgMatrixAsString( Eval( M )[2] , r , c , AssociatedGlobalRing( R ) ) , ")/(" , Name( Eval( M )[1] ) , ")" ] );
    
end );

##
InstallMethod( GetEntryOfHomalgMatrix,
        "for local matrices",
        [ IsHomalgLocalMatrixRep, IsInt, IsInt, IsHomalgLocalRingRep ],
        
  function( M, r, c, R )
    
    return HomalgLocalRingElement( GetEntryOfHomalgMatrix( Eval( M )[2] , r , c , AssociatedGlobalRing( R ) ), Eval( M )[1] , R );
    
end );

####################################
#
# constructor functions and methods:
#
####################################

##
InstallMethod( LocalizeAt,
        "constructor for localized rings",
        [ IsHomalgExternalRingRep and IsFreePolynomialRing, IsList ],
        
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
        "constructor for localized rings",
        [ IsHomalgExternalRingRep and IsFreePolynomialRing ],
        
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

##
InstallMethod( HomalgLocalMatrix,
        "constructor for localized rings",
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
            Eval, [ r, A ] );
    
    BlindlyCopyMatrixPropertiesToLocalMatrix( A, matrix );
    
    return matrix;
    
end );

##
InstallMethod( HomalgLocalMatrix,
        "constructor for localized rings",
        [ IsHomalgMatrix, IsHomalgLocalRingRep ],
        
  function( A, R )
    
    return HomalgLocalMatrix( A, One( AssociatedGlobalRing( R ) ), R );
    
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
    
    Display(Eval(A)[2]);
    Print( Flat( [ "/ ", Name(Eval(A)[1]), "\n" ] ) );
    
end );
