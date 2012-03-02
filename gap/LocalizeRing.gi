#############################################################################
##
##  LocalizeRing.gi                            LocalizeRingForHomalg package
##
##  Copyright 2009-2011, Mohamed Barakat, University of Kaiserslautern
##                       Markus Lange-Hegermann, RWTH-Aachen University
##
##  Implementations of procedures for localized rings.
##
#############################################################################

##  <#GAPDoc Label="IsHomalgLocalRingRep">
##  <ManSection>
##    <Filt Type="Representation" Arg="R" Name="IsHomalgLocalRingRep"/>
##    <Returns>true or false</Returns>
##    <Description>
##      The representation of &homalg; local rings. <P/>
##      (It is a subrepresentation of the &GAP; representation <Br/>
##      <C>IsHomalgRingOrFinitelyPresentedModuleRep</C>.)
##    <Listing Type="Code"><![CDATA[
DeclareRepresentation( "IsHomalgLocalRingRep",
        IsHomalgRing
        and IsHomalgRingOrFinitelyPresentedModuleRep,
        [ "ring" ] );
##  ]]></Listing>
##    </Description>
##  </ManSection>
##  <#/GAPDoc>


##  <#GAPDoc Label="IsHomalgLocalRingElementRep">
##  <ManSection>
##    <Filt Type="Representation" Arg="r" Name="IsHomalgLocalRingElementRep"/>
##    <Returns>true or false</Returns>
##    <Description>
##      The representation of elements of &homalg; local rings. <P/>
##      (It is a representation of the &GAP; category <C>IsHomalgRingElement</C>.)
##    <Listing Type="Code"><![CDATA[
DeclareRepresentation( "IsHomalgLocalRingElementRep",
        IsHomalgRingElement,
        [ "pointer" ] );
##  ]]></Listing>
##    </Description>
##  </ManSection>
##  <#/GAPDoc>

##  <#GAPDoc Label="IsHomalgLocalMatrixRep">
##  <ManSection>
##    <Filt Type="Representation" Arg="A" Name="IsHomalgLocalMatrixRep"/>
##    <Returns>true or false</Returns>
##    <Description>
##      The representation of &homalg; matrices with entries in a &homalg; local ring. <P/>
##      (It is a representation of the &GAP; category <C>IsHomalgMatrix</C>.)
##    <Listing Type="Code"><![CDATA[
DeclareRepresentation( "IsHomalgLocalMatrixRep",
        IsHomalgMatrix,
        [ ] );
##  ]]></Listing>
##    </Description>
##  </ManSection>
##  <#/GAPDoc>

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

##  <#GAPDoc Label="AssociatedComputationRing:ring">
##  <ManSection>
##    <Oper Arg="R" Name="AssociatedComputationRing" Label="for homalg local rings"/>
##    <Returns>a &homalg; ring</Returns>
##    <Description>
##      Internally there is a ring, in which computations take place. This is either the global ring or a (not fully working) external pre ring in &Singular; with Mora's algorithm.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
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
    
  end
  
);

##  <#GAPDoc Label="AssociatedComputationRing:element">
##  <ManSection>
##    <Oper Arg="r" Name="AssociatedComputationRing" Label="for homalg local ring elements"/>
##    <Returns>a &homalg; ring</Returns>
##    <Description>
##      Internally there is a ring, in which computations take place. This is either the global ring or a (not fully working) external pre ring in &Singular; with Mora's algorithm.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
InstallMethod( AssociatedComputationRing,
        "for homalg local ring elements",
        [ IsHomalgLocalRingElementRep ],
        
  function( r )
    
    return AssociatedComputationRing( HomalgRing( r ) );
    
  end
  
);

##  <#GAPDoc Label="AssociatedComputationRing:matrix">
##  <ManSection>
##    <Oper Arg="mat" Name="AssociatedComputationRing" Label="for homalg local matrices"/>
##    <Returns>a &homalg; ring</Returns>
##    <Description>
##      Internally there is a ring, in which computations take place. This is either the global ring or a (not fully working) external pre ring in &Singular; with Mora's algorithm.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
InstallMethod( AssociatedComputationRing,
        "for homalg local matrices",
        [ IsHomalgLocalMatrixRep ],
        
  function( A )
    
    return AssociatedComputationRing( HomalgRing(A) );
    
  end

);

##  <#GAPDoc Label="AssociatedGlobalRing:ring">
##  <ManSection>
##    <Oper Arg="R" Name="AssociatedGlobalRing" Label="for homalg local rings"/>
##    <Returns>a (global) &homalg; ring</Returns>
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
    
  end

);

##  <#GAPDoc Label="AssociatedGlobalRing:element">
##  <ManSection>
##    <Oper Arg="r" Name="AssociatedGlobalRing" Label="for homalg local ring elements"/>
##    <Returns>a (global) &homalg; ring</Returns>
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
    
  end

);

##  <#GAPDoc Label="AssociatedGlobalRing:matrix">
##  <ManSection>
##    <Oper Arg="mat" Name="AssociatedGlobalRing" Label="for homalg local matrices"/>
##    <Returns>a (global) &homalg; ring</Returns>
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
    
  end

);

##  <#GAPDoc Label="Numerator:element">
##  <ManSection>
##    <Oper Arg="r" Name="Numerator" Label="for homalg local ring elements"/>
##    <Returns>a (global) &homalg; ring element</Returns>
##    <Description>
##      The numerator from a local ring element <A>r</A>, which is a &homalg; ring element from the computation ring.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
InstallMethod( Numerator,
        "for homalg local ring elements",
        [ IsHomalgLocalRingElementRep ],
        
  function( r )
    
    return r!.numer;
    
  end

);

##  <#GAPDoc Label="Denominator:element">
##  <ManSection>
##    <Oper Arg="r" Name="Denominator" Label="for homalg local ring elements"/>
##    <Returns>a (global) &homalg; ring element</Returns>
##    <Description>
##      The denominator from a local ring element <A>r</A>, which is a &homalg; ring element from the computation ring.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
InstallMethod( Denominator,
        "for homalg local ring elements",
        [ IsHomalgLocalRingElementRep ],
        
  function( r )
    
    return r!.denom;
    
  end

);

##  <#GAPDoc Label="Numerator:matrix">
##  <ManSection>
##    <Oper Arg="mat" Name="Numerator" Label="for homalg local matrices"/>
##    <Returns>a (global) &homalg; matrix</Returns>
##    <Description>
##      The numerator from a local matrix <A>mat</A>, which is a &homalg; matrix from the computation ring.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
InstallMethod( Numerator,
        "for homalg local matrices",
        [ IsHomalgLocalMatrixRep ],
        
  function( M )
    
    return Eval( M )[1];
    
  end

);

##  <#GAPDoc Label="Denominator:matrix">
##  <ManSection>
##    <Oper Arg="mat" Name="Denominator" Label="for homalg local matrices"/>
##    <Returns>a (global) &homalg; ring element</Returns>
##    <Description>
##      The denominator from a local matrix <A>mat</A>, which is a &homalg; matrix from the computation ring.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
InstallMethod( Denominator,
        "for homalg local matrices",
        [ IsHomalgLocalMatrixRep ],
        
  function( M )
    
    return Eval( M )[2];
    
  end

);

##  <#GAPDoc Label="Name">
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
    local name, nnumer, ndenom, s1, s2, s3, s4;
    
    if IsHomalgInternalRingRep( AssociatedComputationRing( o ) ) then
      name := String;
    else
      name := Name;
    fi;

    nnumer := name( Numerator( o ) );
    ndenom := name( Denominator( o ) );

    if Length( nnumer ) <= 2 or not ( '+' in nnumer or '-' in nnumer ) then 
      s1 := "";
      s2 := "";
    else
      s1 := "(";
      s2 := ")";
    fi;
    if Length( ndenom ) <= 2 or not ( '+' in ndenom or '-' in ndenom ) then 
      s3 := "";
      s4 := "";
    else
      s3 := "(";
      s4 := ")";
    fi;
    return Flat( [ s1, nnumer, s2, "/", s3, ndenom, s4 ] );
    
  end

);

InstallMethod( String,
        "for homalg local ring elements",
        [ IsHomalgLocalRingElementRep ],

  function( o )
    
    return Name( o );
    
  end

);

##
InstallMethod( String,
        "for homalg local ring elements",
        [ IsHomalgLocalRingElementRep ],
        
  function( r )
    
    if IsOne( Denominator( r ) ) then
        return String( Numerator( r ) );
    fi;
    
    TryNextMethod( );
    
end );

##
InstallMethod( BlindlyCopyMatrixPropertiesToLocalMatrix,	## under construction
        "for homalg matrices",
        [ IsHomalgMatrix, IsHomalgLocalMatrixRep ],
        
  function( S, T )
    local c;
    
    for c in [ NrRows, NrColumns ] do
        if Tester( c )( S ) then
            Setter( c )( T, c( S ) );
        fi;
    od;
    
    for c in [ IsZero, IsOne, IsDiagonalMatrix ] do
        if Tester( c )( S ) and c( S ) then
            Setter( c )( T, c( S ) );
        fi;
    od;
    
  end

);

##  <#GAPDoc Label="SetMatElm">
##  <ManSection>
##    <Oper Arg="mat, i, j, r, R" Name="SetMatElm" Label="for homalg local matrices"/>
##    <Description>
##      Changes the entry (<A>i,j</A>) of the local matrix <A>mat</A> to the value <A>r</A>. Here <A>R</A> is the (local) &homalg; ring involved in these computations.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
InstallMethod( SetMatElm,
        "for homalg local matrices",
        [ IsHomalgLocalMatrixRep and IsMutable, IsPosInt, IsPosInt, IsHomalgLocalRingElementRep, IsHomalgLocalRingRep ],
        
  function( M, r, c, s, R )
    local m, cR, N, M2, e;
    
    cR := AssociatedComputationRing( R );
    
    #Create a new matrix with only the one entry
    N := HomalgInitialMatrix( NrRows( M ), NrColumns( M ), cR );
    SetMatElm( N, r, c, Numerator( s ) );
    ResetFilterObj( N, IsInitialMatrix );
    N := HomalgLocalMatrix( N, Denominator( s ), R );
    
    #set the corresponding entry to zero in the other matrix
    m := Eval( M );
    M2 := m[1];
    SetMatElm( M2, r, c, Zero( cR ) );
    
    #add these matrices
    e := Eval( HomalgLocalMatrix( M2, m[2], R ) + N );
    SetIsMutableMatrix( e[1], true );
    M!.Eval := e;
    
  end

);

##  <#GAPDoc Label="AddToMatElm">
##  <ManSection>
##    <Oper Arg="mat, i, j, r, R" Name="AddToMatElm" Label="for homalg local matrices"/>
##    <Description>
##      Changes the entry (<A>i,j</A>) of the local matrix <A>mat</A> by adding the value <A>r</A> to it. Here <A>R</A> is the (local) &homalg; ring involved in these computations.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
InstallMethod( AddToMatElm,
        "for homalg local matrices",
        [ IsHomalgLocalMatrixRep and IsMutable, IsPosInt, IsPosInt, IsHomalgLocalRingElementRep, IsHomalgLocalRingRep ],
        
  function( M, r, c, s, R )
    local N, e;
    
    #create a matrix with just one entry (i,j), which is s
    N := HomalgInitialMatrix( NrRows( M ), NrColumns( M ), AssociatedComputationRing( R ) );
    SetMatElm( N, r, c, Numerator( s ) );
    ResetFilterObj( N, IsInitialIdentityMatrix );
    N := HomalgLocalMatrix( N, Denominator( s ), R );
    
    #and add this matrix to M
    e := Eval( M + N );
    SetIsMutableMatrix( e[1], true );
    M!.Eval := e;
    
  end

);

##  <#GAPDoc Label="MatElmAsString">
##  <ManSection>
##    <Oper Arg="mat, i, j, R" Name="MatElmAsString" Label="for homalg local matrices"/>
##    <Returns>a string</Returns>
##    <Description>
##      Returns the entry (<A>i,j</A>) of the local matrix <A>mat</A> as a string. Here <A>R</A> is the (local) &homalg; ring involved in these computations.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
InstallMethod( MatElmAsString,
        "for homalg local matrices",
        [ IsHomalgLocalMatrixRep, IsPosInt, IsPosInt, IsHomalgLocalRingRep ],
        
  function( M, r, c, R )
    local m;
    
    m := Eval( M );
    return Concatenation( [ "(", MatElmAsString( m[1], r, c, AssociatedComputationRing( R ) ), ")/(", Name( m[2] ), ")" ] );
    
  end

);

##  <#GAPDoc Label="MatElm">
##  <ManSection>
##    <Oper Arg="mat, i, j, R" Name="MatElm" Label="for homalg local matrices"/>
##    <Returns>a local ring element</Returns>
##    <Description>
##      Returns the entry (<A>i,j</A>) of the local matrix <A>mat</A>. Here <A>R</A> is the (local) &homalg; ring involved in these computations.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
InstallMethod( MatElm,
        "for homalg local matrices",
        [ IsHomalgLocalMatrixRep, IsPosInt, IsPosInt, IsHomalgLocalRingRep ],
        
  function( M, r, c, R )
    local m;
    
    m :=Eval( M );
    return HomalgLocalRingElement( MatElm( m[1], r, c, AssociatedComputationRing( R ) ), m[2], R );
    
  end

);

##  <#GAPDoc Label="Cancel">
##  <ManSection>
##    <Oper Arg="a, b" Name="Cancel" Label="for pairs of ring elements"/>
##    <Returns>two ring elements</Returns>
##    <Description>
##      For <M><A>a</A>=a'*c</M> and <M><A>b</A>=b'*c</M> return <M>a'</M> and <M>b'</M>. The exact form of <M>c</M> depends on whether a procedure for gcd computation is included in the ring package.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
InstallMethod( Cancel,
        "for pairs of ring elements from the computation ring",
        [ IsRingElement, IsRingElement ],
        
  function( a, b )
    local za, zb, z, ma, mb, o, g;
    
    za := IsZero( a );
    zb := IsZero( b );
    
    if za and zb then
        
        z := Zero( a );
        
        return [ z, z ];
        
    elif za then
        
        return [ Zero( a ), One( a ) ];
        
    elif zb then
        
        return [ One( a ), Zero( a ) ];
        
    fi;
    
    if IsOne( a ) then
        
        return [ One( a ), b ];
        
    elif IsOne( b ) then
        
        return [ a, One( a ) ];
        
    fi;
    
    ma := a = -One( a );
    mb := b = -One( b );
    
    if ma and mb then
        
        o := One( a );
        
        return [ o, o ];
        
    elif ma then
        
        return [ One( a ), -b ];
        
    elif mb then
        
        return [ -a, One( b ) ];
        
    fi;
    
    g := Gcd( a, b );
    
    return [ a / g, b / g ];
    
end );

InstallMethod( Cancel,
        "for pairs of ring elements from the computation ring",
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
        
        result := List( result, x -> HomalgRingElement( x, R ) );
        
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

##
InstallMethod( SaveHomalgMatrixToFile,
        "for local rings",
        [ IsString, IsHomalgMatrix, IsHomalgLocalRingRep ],
        
  function( filename, M, R )
  local ComputationRing, NumerString, DenomString;
    
    if LoadPackage( "HomalgToCAS" ) <> true then
       Error( "the package HomalgToCAS failed to load\n" );
    fi;
    
    NumerString := Concatenation( filename, "_numerator" );
    DenomString := Concatenation( filename, "_denominator" );
    
    ComputationRing := AssociatedComputationRing( M );
    SaveHomalgMatrixToFile( NumerString, Numerator( M ), ComputationRing );
    SaveHomalgMatrixToFile( DenomString, HomalgMatrix( [ Denominator( M ) ], 1, 1, ComputationRing ), ComputationRing );
    
    return [ NumerString, DenomString ];
    
end );

##
InstallMethod( LoadHomalgMatrixFromFile,
        "for local rings",
        [ IsString, IsInt, IsInt, IsHomalgLocalRingRep ],
        
  function( filename, r, c, R )
    local ComputationRing, numer, denom, homalgIO;
    
    ComputationRing := AssociatedComputationRing( R );
    
    if IsExistingFile( Concatenation( filename, "_numerator" ) ) and IsExistingFile( Concatenation( filename, "_denominator" ) ) then
    
      numer := LoadHomalgMatrixFromFile( Concatenation( filename, "_numerator" ), r, c, ComputationRing );
      denom := LoadHomalgMatrixFromFile( Concatenation( filename, "_denominator" ), r, c, ComputationRing );
      denom := MatElm( denom, 1, 1 );
    
    elif IsExistingFile( filename ) then
    
      numer := LoadHomalgMatrixFromFile( filename, r, c, ComputationRing );
      denom := One( ComputationRing );
    
    else
    
      Error( "file does not exist" );
    
    fi;
    
    return HomalgLocalMatrix( numer, denom, R );
    
end );

##
InstallMethod( CreateHomalgMatrixFromString,
        "constructor for homalg matrices over local rings",
        [ IsString, IsInt, IsInt, IsHomalgLocalRingRep ],
        
  function( s, r, c, R )
    local mat;
    
    mat := CreateHomalgMatrixFromString( s, r, c, AssociatedComputationRing( R ) );
    
    return R * mat;
    
end );

##
InstallMethod( SetRingProperties,
        "for homalg local rings",
        [ IsHomalgRing and IsLocalRing ],
        
  function( S )
    local R;
    
    R := S!.AssociatedGlobalRing;
    
#    SetCoefficientsRing( S, R );
#    SetCharacteristic( S, Characteristic( R ) );
    
    if HasIsCommutative( R ) and IsCommutative( R ) then
        SetIsCommutative( S, true );
    fi;
    
#    if HasGlobalDimension( R ) then
#        SetGlobalDimension( S, GlobalDimension( R ) );	## would be wrong
#    fi;
#    if HasKrullDimension( R ) then
#        SetKrullDimension( S, KrullDimension( R ) ); ## would be wrong
#    fi;
#    
#    SetIsIntegralDomain( S, true ); ## would be wrong, see Hartshorne
#    
#    SetBasisAlgorithmRespectsPrincipalIdeals( S, true ); ## ???
    
end );

####################################
#
# constructor functions and methods:
#
####################################

##  <#GAPDoc Label="LocalizeAt">
##  <ManSection>
##    <Oper Arg="R, l" Name="LocalizeAt" Label= "for a commutative ring and a maximal ideal"/>
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
    
    RP := CreateHomalgTableForLocalizedRings( globalR );
    
    if LoadPackage( "RingsForHomalg" ) <> true then
        Error( "the package RingsForHomalg failed to load\n" );
    fi;
    
    if ValueGlobal( "IsHomalgExternalRingInSingularRep" )( globalR ) then
        
        UpdateMacrosOfLaunchedCAS( LocalizeRingMacrosForSingular, homalgStream( globalR ) );
        
        AppendToAhomalgTable( RP, HomalgTableForLocalizedRingsForSingularTools );
        
    fi;
    
    ## create the local ring
    localR := CreateHomalgRing( globalR, [ TheTypeHomalgLocalRing, TheTypeHomalgLocalMatrix ], HomalgLocalRingElement, RP );
    
    SetConstructorForHomalgMatrices( localR,
            function( arg )
              local R, r, ar, M;
              
              R := arg[Length( arg )];
              
              #at least be able to construct 1x1-matrices from lists of ring elements for the fallback IsUnit
              if IsList( arg[1] ) and Length( arg[1] ) = 1 and IsHomalgLocalRingElementRep( arg[1][1] ) then
              
                r := arg[1][1];
              
                return HomalgLocalMatrix( HomalgMatrix( [ Numerator( r ) ], 1, 1, AssociatedComputationRing( R ) ), Denominator( r ), R );
              
              fi;
              
              ar := List( arg,
                          function( i )
                            if IsHomalgLocalRingRep( i ) then
                                return AssociatedComputationRing( i );
                            else
                                return i;
                            fi;
                          end );
              
              M := CallFuncList( HomalgMatrix, ar );
              
              return HomalgLocalMatrix( M, R );
              
            end );
    
    ## for the view methods:
    ## <A homalg local ring>
    ## <A matrix over a local ring>
    localR!.description := " local";
    
    SetIsLocalRing( localR, true );
    
    #Set the ideal, at which we localize
    n_gens := Length( ideal_gens );
    gens := HomalgMatrix( ideal_gens, n_gens, 1, globalR );
    SetGeneratorsOfMaximalLeftIdeal( localR, gens );
    gens := HomalgMatrix( ideal_gens, 1, n_gens, globalR );
    SetGeneratorsOfMaximalRightIdeal( localR, gens );
    
    localR!.AssociatedGlobalRing := globalR;
    localR!.AssociatedComputationRing := globalR;
    
    SetRingProperties( localR );
    
    return localR;
    
end );

##  <#GAPDoc Label="LocalizeAtZero">
##  <ManSection>
##    <Oper Arg="R" Name="LocalizeAtZero" Label= "for a free polynomial ring"/>
##    <Returns>a local ring</Returns>
##    <Description>
##      This method creates the corresponding localization of <A>R</A> at the complement of the maximal ideal generated by the indeterminates ("at zero").
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
InstallMethod( LocalizeAtZero,
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
##      Creates the local ring element <M><A>numer</A>/<A>denom</A></M> or in the second case <M><A>numer</A>/1</M> for the local ring <A>R</A>. Both <A>numer</A> and <A>denom</A> may either be a string describing a valid global ring element or from the global ring or computation ring.
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
        
        ##a local ring element as first argument will just be returned
        return numer;
        
    elif nargs = 2 then
        
        ## extract the properties of the global ring element
        if IsHomalgRing( arg[2] ) then
            ring := arg[2];
            ar := [ numer, One( AssociatedComputationRing( ring ) ), ring ];
            properties := KnownTruePropertiesOfObject( numer );	## FIXME: a huge potential for problems
            Add( ar, List( properties, ValueGlobal ) );  ## at least an empty list is inserted; avoids infinite loops
            return CallFuncList( HomalgLocalRingElement, ar );
        fi;
        
    fi;
    
    properties := [ ];
    
    for ar in arg{[ 2 .. nargs ]} do
        if not IsBound( ring ) and IsHomalgRing( ar ) then
            ring := ar;
        elif IsList( ar ) and ForAll( ar, IsFilter ) then
            Append( properties, ar );
        elif not IsBound( denom ) and ( IsRingElement( ar ) or IsString( ar ) ) then
            denom := ar;
        else
            Error( "this argument (now assigned to ar) should be in { IsHomalgRing, IsList( IsFilter ), IsRingElement, IsString }\n" );
        fi;
    od;
    
    computationring := AssociatedComputationRing( ring );
    
    if not IsBound( denom ) then
       denom := One( numer );
    fi;
    
    if not IsHomalgRingElement( numer ) then
      numer := HomalgRingElement( numer, computationring );
    fi;
    
    if not IsHomalgRingElement( denom ) then
      denom := HomalgRingElement( denom, computationring );
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
##    <Func Arg="numer, R" Name="HomalgLocalMatrix" Label="constructor for local matrices using a given numerator and one as denominator"/>
##    <Returns>a local matrix</Returns>
##    <Description>
##      Creates the local matrix <M><A>numer</A>/<A>denom</A></M> or in the second case <M><A>numer</A>/1</M> for the local ring <A>R</A>. Both <A>numer</A> and <A>denom</A> may either be from the global ring or the computation ring.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
InstallMethod( HomalgLocalMatrix,
        "constructor for matrices over localized rings",
        [ IsHomalgMatrix, IsRingElement, IsHomalgLocalRingRep ],
        
  function( A, r, R )
    local G, type, matrix, HookDenom, ComputationRing, rr, AA;
    
    G := HomalgRing( A );
    
    ComputationRing := AssociatedComputationRing( R );
    
    if IsBound( A!.Denominator ) then
      HookDenom := A!.Denominator;
      Unbind( A!.Denominator );
    else
      HookDenom := One( ComputationRing );
    fi;
    
    if not ( IsHomalgRingElement( r ) and IsIdenticalObj( ComputationRing , HomalgRing( r ) ) ) then
      rr := r / ComputationRing;
    else
      rr := r;
    fi;
    if not IsIdenticalObj( ComputationRing , HomalgRing( A ) ) then
      AA := ComputationRing * A;
    else
      AA := A;
    fi;
    
    matrix := rec( ring := R );
    
    ObjectifyWithAttributes(
        matrix, TheTypeHomalgLocalMatrix,
        Eval, [ AA, rr * HookDenom ]
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
InstallMethod( \*,
        "for homalg matrices",
        [ IsHomalgLocalRingRep, IsHomalgMatrix ],
        
  function( R, m )
    
    if IsHomalgLocalMatrixRep( m ) then
        TryNextMethod( );
    fi;
    
    return HomalgLocalMatrix( AssociatedComputationRing( R ) * m, R );
    
end );

##
InstallMethod( \*,
        "for matrices over local rings",
        [ IsHomalgRing, IsHomalgLocalMatrixRep ],
        
  function( R, m )
    
    if not IsOne( Denominator( m ) ) then
        TryNextMethod( );
    fi;
    
    return R * Numerator( m );
    
end );

##
InstallMethod( PostMakeImmutable,
        "for homalg local matrices",
        [ IsHomalgLocalMatrixRep and HasEval ],
        
  function( A )
    
    MakeImmutable( Numerator( A ) );
    
end );

##
InstallMethod( SetIsMutableMatrix,
        "for homalg local matrices",
        [ IsHomalgLocalMatrixRep, IsBool ],
        
  function( A, b )
    
    if b = true then
      SetFilterObj( A, IsMutable );
    else
      ResetFilterObj( A, IsMutable );
    fi;
    
    SetIsMutableMatrix( Numerator( A ), b );
    
end );

####################################
#
# View, Print, and Display methods:
#
####################################

##
InstallMethod( Display,
        "for homalg local ring elements",
        [ IsHomalgLocalRingElementRep ],
        
  function( r )
    
    Print( Name( r ), "\n" );
    
end );

##
InstallMethod( Display,
        "for homalg matrices over a homalg local ring",
        [ IsHomalgLocalMatrixRep ],
        
  function( A )
    local a;
    
    a := Eval( A );
    
    Display( a[1] );
    
    if IsHomalgInternalRingRep( AssociatedComputationRing( A ) ) then
      Print( "/ ", a[2], "\n" );
    else
      if IsOne( a[2] ) or IsMinusOne( a[2] ) then
        Print( "/ ", Name( a[2] ), "\n" );
      else
        Print( "/(", Name( a[2] ), ")\n" );
      fi;
    fi;
    
end );
