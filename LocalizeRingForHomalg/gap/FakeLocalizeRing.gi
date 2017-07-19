#############################################################################
##
##  FakeLocalizeRing.gi                        LocalizeRingForHomalg package  
##
##  Copyright 2013, Mohamed Barakat, University of Kaiserslautern
##                  Vinay Wagh, Indian Institute of Technology Guwahati
##
##  Implementations of procedures for "fake" localized rings.
##
#############################################################################

DeclareRepresentation( "IsHomalgFakeLocalRingRep",
        IsHomalgRing
        and IsHomalgRingOrFinitelyPresentedModuleRep,
        [ "ring" ] );


DeclareRepresentation( "IsElementOfHomalgFakeLocalRingRep",
        IsHomalgRingElement,
        [ "pointer" ] );

DeclareRepresentation( "IsMatrixOverHomalgFakeLocalRingRep",
        IsHomalgMatrix,
        [ ] );

BindGlobal( "TheTypeHomalgFakeLocalRing",
        NewType( TheFamilyOfHomalgRings,
                IsHomalgFakeLocalRingRep ) );

BindGlobal( "TheTypeElementOfHomalgFakeLocalRing",
        NewType( TheFamilyOfHomalgRingElements,
                IsElementOfHomalgFakeLocalRingRep ) );

BindGlobal( "TheTypeMatrixOverHomalgFakeLocalRing",
        NewType( TheFamilyOfHomalgMatrices,
                IsMatrixOverHomalgFakeLocalRingRep ) );

InstallValue( CommonHomalgTableForLocalizedRingsAtPrimeIdeals,
        rec(
            RingName :=
              function( R )
                local globalR, baseR, name;
                
                globalR := AssociatedGlobalRing( R );
                if HasBaseRing( globalR ) then
                    baseR:= BaseRing( globalR );
                else
                    baseR := CoefficientsRing( globalR );
                fi;
                
                if HasName( R ) then
                    return Name( R );
                fi;
                
                name := Concatenation( RingName( baseR ), "_< ", JoinStringsWithSeparator( EntriesOfHomalgMatrix( GeneratorsOfPrimeIdeal( R ) ), ", " ), " >" );
                
                if HasIndeterminatesOfPolynomialRing( R ) then
                    name := Concatenation( "( ", name, " )", Concatenation( "[", JoinStringsWithSeparator( List( Indeterminates( R ), String ) ), "]" ) );
                fi;
                
                return name;
                
            end,
            
         )
);

####################################
#
# methods for operations:
#
####################################
            
##
InstallMethod( AssociatedComputationRing,
        "for homalg fake local rings",
        [ IsHomalgFakeLocalRingRep ],
        
  function( R )
    
    if not IsBound( R!.AssociatedComputationRing ) then
        return R!.ring;
    fi;
    
    return R!.AssociatedComputationRing;
    
end );

##
InstallMethod( AssociatedComputationRing,
        "for homalg fake local ring elements",
        [ IsElementOfHomalgFakeLocalRingRep ],
        
  function( r )
    
    return AssociatedComputationRing( HomalgRing( r ) );
    
end );

##
InstallMethod( AssociatedComputationRing,
        "for matrices over homalg fake local rings",
        [ IsMatrixOverHomalgFakeLocalRingRep ],
        
  function( A )
    
    return AssociatedComputationRing( HomalgRing(A) );
    
end );

##
InstallMethod( AssociatedResidueClassRing,
        "for homalg fake local rings",
        [ IsHomalgFakeLocalRingRep ],
        
  function( R )
    
    return R!.AssociatedResidueClassRing;
        
end );

##
InstallMethod( AssociatedResidueClassRing,
        "for homalg fake local rings",
        [ IsElementOfHomalgFakeLocalRingRep ],
        
  function( R )
    
    return R!.AssociatedResidueClassRing;
        
end );

##
InstallMethod( AssociatedResidueClassRing,
        "for homalg fake local rings",
        [ IsMatrixOverHomalgFakeLocalRingRep ],
        
  function( R )
    
    return R!.AssociatedResidueClassRing;
        
end );

# ##
# InstallMethod( BaseRing,
#         "for homalg fake local rings",
#         [ IsHomalgFakeLocalRingRep ],
        
#   function( R )
    
#     return R!.BaseRing;
        
# end );

# ##
# InstallMethod( BaseRing,
#         "for homalg fake local rings",
#         [ IsElementOfHomalgFakeLocalRingRep ],
        
#   function( R )
    
#     return R!.BaseRing;
        
# end );

# ##
# InstallMethod( BaseRing,
#         "for homalg fake local rings",
#         [ IsMatrixOverHomalgFakeLocalRingRep ],
        
#   function( R )
    
#     return R!.BaseRing;
        
# end );

##
InstallMethod( AssociatedGlobalRing,
        "for homalg fake local rings",
        [ IsHomalgFakeLocalRingRep ],
        
  function( R )
    
    if not IsBound( R!.AssociatedGlobalRing ) then
        return R!.ring;
    fi;
    
    return R!.AssociatedGlobalRing;
        
end );

##
InstallMethod( AssociatedGlobalRing,
        "for homalg fake local ring elements",
        [ IsElementOfHomalgFakeLocalRingRep ],
        
  function( r )
    
    return AssociatedGlobalRing( HomalgRing( r ) );
    
end );

##
InstallMethod( AssociatedGlobalRing,
        "for homalg fake local matrices",
        [ IsMatrixOverHomalgFakeLocalRingRep ],
        
  function( A )
    
    return AssociatedGlobalRing( HomalgRing( A ) );
    
end );

##
InstallMethod( Numerator,
        "for homalg fake local matrices",
        [ IsElementOfHomalgFakeLocalRingRep ],
        
  function( p )
    local R, r, coeffs;
    
    R := AssociatedGlobalRing( p );
    
    if IsZero( p ) then
        return Zero( R );
    fi;
    
    if not IsBound( p!.Numerator ) then
        
        if HasCoefficientsRing( R ) then
            r := CoefficientsRing( R );
            if HasIsIntegersForHomalg( r ) and IsIntegersForHomalg( r ) then
                return ( ( Denominator( p ) / HomalgRing( p ) ) * p ) / R;
            fi;
        fi;
        
        p!.Numerator := Numerator( EvalRingElement( p ) ) / R;
    fi;
    
    return p!.Numerator;
    
end );

##
InstallMethod( Denominator,
        "for homalg fake local matrices",
        [ IsElementOfHomalgFakeLocalRingRep ],
        
  function( p )
    local R, r, coeffs;
    
    R := AssociatedGlobalRing( p );
    
    if IsZero( p ) then
        return One( R );
    fi;
    
    if not IsBound( p!.Denominator ) then
        
        if HasCoefficientsRing( R ) then
            r := CoefficientsRing( R );
            if HasIsIntegersForHomalg( r ) and IsIntegersForHomalg( r ) then
                coeffs := EntriesOfHomalgMatrix( Coefficients( EvalRingElement( p ) ) );
                coeffs := List( List( List( coeffs, String ), EvalString ), DenominatorRat );
                return Lcm( coeffs ) / R;
            fi;
        fi;
        
        p!.Denominator := Denominator( EvalRingElement( p ) ) / R;
    fi;
    
    return p!.Denominator;
    
end );

##
InstallMethod( Numerator,
        "for homalg fake local matrices",
        [ IsMatrixOverHomalgFakeLocalRingRep ],
        
  function( M )
    local R, globalR, fracR, L, DenomList, lcmDenom;
    
    R := HomalgRing( M );
    
    globalR := AssociatedGlobalRing( R );
    fracR := AssociatedComputationRing( R );
    
    if not IsBound( M!.Numerator ) then
    
        L := EntriesOfHomalgMatrix( M );
        
        DenomList := List( L, Denominator );
        DenomList := Filtered( DenomList, a -> not IsZero( a ) );
        
        lcmDenom := Lcm_UsingCayleyDeterminant( DenomList );
        
        # M!.Numerator := globalR * ( ( fracR * lcmDenom ) * Eval( M ) );
        M!.Numerator := globalR * ( ( lcmDenom / fracR ) * Eval( M ) );
        
        M!.Denominator := lcmDenom;
        
    fi;
    
    return M!.Numerator;
    
end );

##
InstallMethod( Name,
        "for homalg fake local ring elements",
        [ IsElementOfHomalgFakeLocalRingRep ],

  function( o )
    local name;
    
    if IsHomalgInternalRingRep( AssociatedComputationRing( o ) ) then
      name := String;
    else
      name := Name;
    fi;

    return name( EvalRingElement( o ) );
    
end );

##
InstallMethod( String,
        "for homalg fake local ring elements",
        [ IsElementOfHomalgFakeLocalRingRep ],

  function( o )
    
    return Name( o );
    
end );


##
InstallMethod( BlindlyCopyMatrixPropertiesToFakeLocalMatrix,	## under construction
        "for homalg matrices",
        [ IsHomalgMatrix, IsMatrixOverHomalgFakeLocalRingRep ],
        
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
    
end );
  

##
InstallMethod( SetMatElm,
        "for homalg local matrices",
        [ IsMatrixOverHomalgFakeLocalRingRep and IsMutable, IsPosInt, IsPosInt, IsElementOfHomalgFakeLocalRingRep, IsHomalgFakeLocalRingRep ],
        
  function( M, r, c, s, R )
    local N, m, e;
    
    # cR := AssociatedComputationRing( R );
    
    m := Eval( M );
    
    SetMatElm( m, r, c, EvalRingElement( s ) );

    M!.Eval := m;
    
end );

##
InstallMethod( AddToMatElm,
        "for homalg local matrices",
        [ IsMatrixOverHomalgFakeLocalRingRep and IsMutable, IsPosInt, IsPosInt, IsElementOfHomalgFakeLocalRingRep, IsHomalgFakeLocalRingRep ],
        
  function( M, r, c, s, R )
    local N, e;
    
    #create a matrix with just one entry (i,j), which is s
    N := HomalgInitialMatrix( NrRows( M ), NrColumns( M ), AssociatedComputationRing( R ) );
    SetMatElm( N, r, c, EvalRingElement( s ) );
    ResetFilterObj( N, IsInitialIdentityMatrix );
    
    #and add this matrix to M
    e := Eval( M + N );
    SetIsMutableMatrix( e[1], true );
    M!.Eval := e;
    
end );

##
InstallMethod( MatElmAsString,
        "for homalg fake local matrices",
        [ IsMatrixOverHomalgFakeLocalRingRep, IsPosInt, IsPosInt, IsHomalgFakeLocalRingRep ],
        
  function( M, r, c, R )
    local m;
    
    m := Eval( M );
    return  MatElmAsString( m, r, c, AssociatedComputationRing( R ) );
    
end );

##
InstallMethod( MatElm,
        "for matrices over homalg fake local ring",
        [ IsMatrixOverHomalgFakeLocalRingRep, IsPosInt, IsPosInt, IsHomalgFakeLocalRingRep ],
        
  function( M, r, c, R )
    local m;
    
    m := Eval( M );
    return ElementOfHomalgFakeLocalRing( MatElm( m, r, c, AssociatedComputationRing( R ) ), R );
    
end );

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

##
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
        
        Assert( 6, result[1] * b = result[2] * a );
        
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
        "for fake local rings",
        [ IsString, IsHomalgMatrix, IsHomalgFakeLocalRingRep ],
        
  function( filename, M, R )
    local ComputationRing, MatStr;
    
    if LoadPackage( "HomalgToCAS" ) <> true then
       Error( "the package HomalgToCAS failed to load\n" );
    fi;
    
    MatStr := Concatenation( filename, "_matrix" );
    
    ComputationRing := AssociatedComputationRing( M );
    SaveHomalgMatrixToFile( MatStr, Eval( M ), ComputationRing );
    
    return MatStr;
    
end );

##
InstallMethod( LoadHomalgMatrixFromFile,
        "for fake local rings",
        [ IsString, IsInt, IsInt, IsHomalgFakeLocalRingRep ],
        
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
    
    return MatrixOverHomalgFakeLocalRing( numer, denom, R );
    
end );

##
InstallMethod( CreateHomalgMatrixFromString,
        "constructor for homalg matrices over fake local rings",
        [ IsString, IsInt, IsInt, IsHomalgFakeLocalRingRep ],
        
  function( s, r, c, R )
    local mat;
    
    mat := CreateHomalgMatrixFromString( s, r, c, AssociatedComputationRing( R ) );
    
    return R * mat;
    
end );

##
InstallMethod( SetRingProperties,
        "for homalg fake local rings",
        [ IsHomalgRing ],
        
  function( S )
    local R, fracR;
    
    R := AssociatedGlobalRing( S );
    fracR := AssociatedComputationRing( S );
    
    if HasIsCommutative( R ) and IsCommutative( R ) then
        SetIsCommutative( S, true );
    fi;
    
    if HasCoefficientsRing( R ) then
        SetCoefficientsRing( S, CoefficientsRing( R ) );
    fi;
    
    if HasIsFreePolynomialRing( R ) and IsFreePolynomialRing( R ) then
        SetIsIntegralDomain( S, true );
        SetIsFreePolynomialRing( S, true );
    fi;
    
    if HasIndeterminatesOfPolynomialRing( fracR ) then
        SetIndeterminatesOfPolynomialRing( S, List( Indeterminates( fracR ), a -> a / S ) );
    fi;
    
end );

####################################
#
# constructor functions and methods:
#
####################################

## 
InstallMethod( LocalizeBaseRingAtPrime,
        "constructor for homalg localized rings",
#        [ IsHomalgRing and IsCommutative, IsList, IsFinitelyPresentedSubmoduleRep and ConstructedAsAnIdeal and IsPrimeIdeal ],
        [ IsHomalgRing and IsCommutative, IsList, IsList ],
        
  function( globalR, X, p )
    local indets, Y, k, Q, fracR, RP, localR, baseR, n_gens, gens;
    
    indets := Indeterminates( globalR );
    
    if not IsSubset( indets, X ) then
        Error( "the second argument should be a subset of the list of indeterminates of the ring\n" );
    fi;
    
    Y := Filtered( indets, a -> not a in X );
    
    k := CoefficientsRing( globalR );
    
    if IsBound( globalR!.PartialQuotientRing ) then
        fracR := globalR!.PartialQuotientRing;
    else
        if HasIsIntegersForHomalg( k ) and IsIntegersForHomalg( k ) then
            Q := FieldOfFractions( k );
        else
            Q := k;
        fi;
        if not X = [ ] then
            Q := AddRationalParameters( Q, X );
        fi;
        
        fracR := Q * Y;
    fi;
    
    RP := CreateHomalgTableForLocalizedRingsAtPrimeIdeals( fracR );
    
    if not LoadPackage( "RingsForHomalg" ) = true then
        Error( "the package RingsForHomalg failed to load\n" );
    fi;
    
    if ValueGlobal( "IsHomalgExternalRingInSingularRep" )( globalR ) then
        
        UpdateMacrosOfLaunchedCAS( FakeLocalizeRingMacrosForSingular, homalgStream( globalR ) );
        AppendToAhomalgTable( RP, CommonHomalgTableForHomalgFakeLocalRing );
        
        if HasBaseRing( globalR ) then
            baseR := BaseRing( globalR );
        else
            baseR := CoefficientsRing( globalR );
        fi;
        
        if HasIsIntegersForHomalg( k ) and IsIntegersForHomalg( k ) then
            Unbind( homalgTable( fracR )!.CopyMatrix );
            Unbind( homalgTable( fracR )!.CopyElement );
            Unbind( homalgTable( globalR )!.CopyMatrix );
            Unbind( homalgTable( globalR )!.CopyElement );
            Unbind( homalgTable( baseR )!.CopyMatrix );
            Unbind( homalgTable( baseR )!.CopyElement );
        fi;
        
    fi;
    
    ## create the local ring
    localR := CreateHomalgRing( globalR, [ TheTypeHomalgFakeLocalRing, TheTypeMatrixOverHomalgFakeLocalRing ], ElementOfHomalgFakeLocalRing, RP );
    
    if not IsString( p ) then
        p := List( p,
                   function( x )
                       if not IsString( x ) then
                           return String( x );
                       fi;
                       return x;
                   end );
                          
        p := JoinStringsWithSeparator( p );
    fi;
    
    p := ParseListOfIndeterminates( SplitString( p, "," ) );
    
    if ForAny( p, IsString ) then
        p :=
          List( p,
                function( x )
                  if IsString( x ) then
                      return x / globalR;
                  fi;
                  return x;
              end );
              
    fi;
    
    SetConstructorForHomalgMatrices( localR,
            function( arg )
              local R, r, ar, M;
              
              R := arg[Length( arg )];
              
              #at least be able to construct 1x1-matrices from lists of ring elements for the fallback IsUnit
              if IsList( arg[1] ) and Length( arg[1] ) = 1 and IsElementOfHomalgFakeLocalRingRep( arg[1][1] ) then
              
                r := arg[1][1];
                
#                return MatrixOverHomalgFakeLocalRing( HomalgMatrix( [ Numerator( r ) ], 1, 1, AssociatedComputationRing( R ) ), Denominator( r ), R );
                return MatrixOverHomalgFakeLocalRing( HomalgMatrix( [ r ], 1, 1, AssociatedComputationRing( R ) ), R );
              fi;
              
              ar := List( arg,
                          function( i )
                            if IsHomalgFakeLocalRingRep( i ) then
                                return AssociatedComputationRing( i );
                            else
                                return i;
                            fi;
                          end );
              
              M := CallFuncList( HomalgMatrix, ar );
              
              return MatrixOverHomalgFakeLocalRing( M, R );
              
            end );
    
    ## for the display/view methods:
    ## <A homalg fake local ring>
    ## <A matrix over a fake local ring>
    localR!.description := " (fake) local";
    
    baseR := CoefficientsRing( globalR ) * X;
    SetBaseRing(localR, baseR);
    
    #Set the ideal, at which we localize
    n_gens := Length( p );
    gens := HomalgMatrix( p, n_gens, 1, globalR );
    SetGeneratorsOfPrimeIdeal( localR, gens );
    
    localR!.AssociatedGlobalRing := globalR;
    localR!.AssociatedComputationRing := fracR;
    localR!.AssociatedResidueClassRing := globalR / LeftSubmodule( p );
    
    SetRingProperties( localR );
    
    Perform( X, function( u ) u!.IsUnit := true; end );
    
    return localR;
    
end );

## 
InstallMethod( LocalizeBaseRingAtPrime,
        "constructor for homalg localized rings",
#        [ IsHomalgRing and IsCommutative, IsList, IsFinitelyPresentedSubmoduleRep and ConstructedAsAnIdeal and IsPrimeIdeal ],
        [ IsHomalgRing and IsCommutative, IsList ],
        
  function( R, p )
    local indets, X, Rp;
    
    if HasBaseRing( R ) then
        indets := RelativeIndeterminatesOfPolynomialRing( R );
        X := Filtered( Indeterminates( R ), a -> not a in indets );
    else
        X := [ ];
    fi;
    
    Rp := LocalizeBaseRingAtPrime( R, X, p );
    
    if not IsBound( R!.PartialQuotientRing ) then
        R!.PartialQuotientRing := AssociatedComputationRing( Rp );
    fi;
    
    return Rp;
    
end );


##
InstallGlobalFunction( ElementOfHomalgFakeLocalRing,
  function( arg )
    local nargs, elm, ring, ar, properties, denom, computationring, r;
    
    nargs := Length( arg );
    
    if nargs = 0 then
        Error( "empty input\n" );
    fi;
    
    elm := arg[1];
    
    if IsElementOfHomalgFakeLocalRingRep( elm ) then
        
        ##a local ring element as first argument will just be returned
        return elm;
        
    fi;
    
    properties := [ ];
    
    for ar in arg{[ 2 .. nargs ]} do
        if not IsBound( ring ) and IsHomalgRing( ar ) then
            ring := ar;
        elif IsList( ar ) and ForAll( ar, IsFilter ) then
            Append( properties, ar );
        else
            Error( "this argument (now assigned to ar) should be in { IsHomalgRing, IsList( IsFilter ), IsString }\n" );
        fi;
    od;
    
    computationring := AssociatedComputationRing( ring );
    
    if not IsHomalgRingElement( elm ) then
        elm := HomalgRingElement( elm, computationring );
    fi;
    
    if IsBound( ring ) then
        r := rec( ring := ring );
        ## Objectify:
        ObjectifyWithAttributes( r, TheTypeElementOfHomalgFakeLocalRing, EvalRingElement, elm );
#        ObjectifyWithAttributes( r, TheTypeElementOfHomalgFakeLocalRing, ring, ring );
#        Objectify( TheTypeElementOfHomalgFakeLocalRing, elm );
    fi;
    
    if properties <> [ ] then
        for ar in properties do
            Setter( ar )( r, true );
        od;
    fi;
    
    return r;
    
end );

##
InstallMethod( PolynomialRing,
        "for homalg ring elements",
        [ IsHomalgFakeLocalRingRep, IsList ],
  function( R, indets )
    local globalR, baseR, base_indets, p, list, newGlobalR, XX, newLocalR;
    
    #if indets = ""  then
    #    return R;
    #fi;
    
    globalR := AssociatedGlobalRing( R );
    if HasBaseRing( globalR ) then
        baseR := BaseRing ( globalR );
        base_indets := List( Indeterminates( baseR ), String );
    else
        baseR := CoefficientsRing( globalR );
        base_indets := [ ];
    fi;
    
    p := EntriesOfHomalgMatrix( GeneratorsOfPrimeIdeal( R ) );
    
    list := Concatenation( Filtered( List( Indeterminates( globalR ), String ), a ->  not a in base_indets ), indets );
    
    newGlobalR := PolynomialRing( baseR, list );
    XX := List( base_indets, x -> x / newGlobalR );
    
    newLocalR := LocalizeBaseRingAtPrime( newGlobalR, XX, p );
    SetBaseRing( newLocalR, R );
    
    return newLocalR;
    
end);

##
InstallMethod( PolynomialRing,
        "for homalg ring elements",
        [ IsHomalgLocalRingRep, IsList ],
  function( R, indets )
    local globalR, baseR, p, list, newGlobalR, XX, newLocalR;
    
    globalR := AssociatedGlobalRing( R );
    if HasBaseRing( globalR ) then
        baseR := BaseRing ( globalR );
    else
        baseR := globalR;
    fi;
    
    p := EntriesOfHomalgMatrix( GeneratorsOfMaximalLeftIdeal( R ) );
    
    list := Concatenation( Filtered( List( Indeterminates( globalR ), x -> String( x ) ), a ->  not a in List( Indeterminates( baseR ), x -> String( x ) ) ),  indets );
    
    newGlobalR := PolynomialRing( baseR, list );
    XX := List( Indeterminates( baseR ), x -> x / newGlobalR );
    
    
    
    newLocalR := LocalizeBaseRingAtPrime( newGlobalR, XX, p );
    SetBaseRing( newLocalR, R );
    
    return newLocalR;
    
end);

InstallMethod( IsRightInvertibleMatrix,
        "for homalg ring elements",
        [ IsMatrixOverHomalgFakeLocalRingRep ],
        
  function( M )
    local R;
    
    if IsRightInvertibleMatrix( Numerator( M ) ) then
        return true;
    fi;
    
    TryNextMethod( );
    
end );

##
InstallMethod( \/,
        "for homalg ring elements",
        [ IsRingElement, IsElementOfHomalgFakeLocalRingRep ],
        
  function( a, u )
    local R, RP, au;
    
    R := HomalgRing( u );
    
    if not IsHomalgRingElement( a ) then
        a := a / R;
    fi;
    
    if not HasRingElementConstructor( R ) then
        Error( "no ring element constructor found in the ring\n" );
    fi;
    
    RP := homalgTable( R );
    
    if IsBound(RP!.DivideByUnit) then
        if not IsUnit( u ) then
            return fail;
        fi;
        au := RP!.DivideByUnit( a, u );
        if au = fail then
            return fail;
        fi;
        return RingElementConstructor( R )( au, R );
    fi;
    
    TryNextMethod( );
    
end );

##
InstallMethod( \/,
        "for homalg ring elements",
        [ IsElementOfHomalgFakeLocalRingRep, IsElementOfHomalgFakeLocalRingRep ],
        
  function( a, u )
    local R, RP, au;
    
    R := HomalgRing( u );
    
    if not HasRingElementConstructor( R ) then
        Error( "no ring element constructor found in the ring\n" );
    fi;
    
    RP := homalgTable( R );
    
    if IsBound(RP!.DivideByUnit) then
        if not IsUnit( u ) then
            return fail;
        fi;
        au := RP!.DivideByUnit( a, u );
        if au = fail then
            return fail;
        fi;
        return RingElementConstructor( R )( au, R );
    fi;
    
    TryNextMethod( );
    
end );

##
InstallMethod( MatrixOverHomalgFakeLocalRing,
        "constructor for matrices over fake local rings",
        [ IsHomalgMatrix, IsHomalgFakeLocalRingRep ],
        
  function( A, R )
    local G, type, matrix, HookDenom, ComputationRing, rr, AA;
    
    G := HomalgRing( A );
    
    ComputationRing := AssociatedComputationRing( R );
    
    if not IsIdenticalObj( ComputationRing , HomalgRing( A ) ) then
      AA := ComputationRing * A;
    else
      AA := A;
    fi;
    
    matrix := rec( ring := R );
    
    ObjectifyWithAttributes(
        matrix, TheTypeMatrixOverHomalgFakeLocalRing,
        Eval, AA
    );
    
    BlindlyCopyMatrixPropertiesToFakeLocalMatrix( A, matrix );
    
    return matrix;
    
end );

##
InstallMethod( \*,
        "for homalg matrices",
        [ IsHomalgFakeLocalRingRep, IsHomalgMatrix ],
        
  function( R, m )
    
    if IsMatrixOverHomalgFakeLocalRingRep( m ) then
        TryNextMethod( );
    fi;
    
    return MatrixOverHomalgFakeLocalRing( AssociatedComputationRing( R ) * m, R );
    
end );

##
InstallMethod( \*,
        "for matrices over fake local rings",
        [ IsHomalgRing, IsMatrixOverHomalgFakeLocalRingRep ],
        
  function( R, m )
    
    return R * Eval( m );
    
end );

##
InstallMethod( PostMakeImmutable,
        "for matrices over homalg fake local rings ",
        [ IsMatrixOverHomalgFakeLocalRingRep and HasEval ],
        
  function( A )
    
    MakeImmutable( Eval( A ) );
    
end );

##
InstallMethod( SetIsMutableMatrix,
        "for matrices over homalg fake local rings ",
        [ IsMatrixOverHomalgFakeLocalRingRep, IsBool ],
        
  function( A, b )
    
    if b = true then
      SetFilterObj( A, IsMutable );
    else
      ResetFilterObj( A, IsMutable );
    fi;
    
    SetIsMutableMatrix( Eval( A ), b );
    
end );

##
InstallMethod( RingOfDerivations,
        "for fake local rings",
        [ IsHomalgFakeLocalRingRep ],
        
  function( Rm )
    local R;
    
    R := AssociatedGlobalRing( Rm );
    
    return RingOfDerivations( R );
    
end );

##
InstallMethod( Coefficients,
        "for homalg ring elements",
        [ IsElementOfHomalgFakeLocalRingRep ],
        
  function( pol )
    local coeffs, monom, S;
    
    coeffs := Coefficients( EvalRingElement( pol ) );
    monom := coeffs!.monomials;
    
    S := HomalgRing( pol );
    
    coeffs := S * coeffs;
    coeffs!.monomials := List( monom, a -> a / S );
    
    return coeffs;
    
end );

##
InstallMethod( Random,
        "for homalg ring elements",
        [ IsHomalgFakeLocalRingRep, IsList ],
        
  function( R, L )
    local globalR, baseR, f, g;
    
    globalR := AssociatedGlobalRing( R );
    
    if not HasBaseRing( globalR ) then
        Error( );
    fi;
    
    baseR := BaseRing( AssociatedGlobalRing( R ) );
    
    f := Random( globalR, L );
    
    f := f / R;
    
    repeat
        g := Random( baseR ) + Random( baseR, 0 );
        g := g / R;
    until IsUnit( g );
    
    return f / g;
    
end );

##
InstallMethod( Value,
        "for a homalg matrix over a fake local ring and two lists",
        [ IsMatrixOverHomalgFakeLocalRingRep, IsList, IsList ],
        
  function( M, V, O )
    local R, fracR;
    
    R := HomalgRing( M );
    
    fracR := AssociatedComputationRing( R );
    
    V := List( V, i -> i / fracR );
    O := List( O, i -> i / fracR );
    
    return R * Value( Eval( M ), V, O );
    
end );

####################################
#
# View, Print, and Display methods:
#
####################################

##
InstallMethod( Display,
        "for homalg fake local ring elements",
        [ IsElementOfHomalgFakeLocalRingRep ],
        
  function( r )
    
    Print( Name( r ), "\n" );
    
end );

##
InstallMethod( Display,
        "for homalg matrices over a homalg fake local ring",
        [ IsMatrixOverHomalgFakeLocalRingRep ],
        
  function( A )
    
    Display( Eval( A ) );
    
end );
