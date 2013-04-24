#############################################################################
##
##  Tools.gi                                                 Modules package
##
##  Copyright 2011, Mohamed Barakat, University of Kaiserslautern
##
##  Implementations of tool procedures.
##
#############################################################################

####################################
#
# methods for operations:
#
####################################

##
InstallMethod( LeadingModule,
        "for a homalg matrix",
        [ IsHomalgMatrix ],
        
  function( mat )
    local R, RP, lead;
    
    R := HomalgRing( mat );
    
    RP := homalgTable( R );
    
    if not IsBound(RP!.LeadingModule) then
        Error( "could not find a procedure called LeadingModule ",
               "in the homalgTable of the ring\n" );
    fi;
    
    lead := RP!.LeadingModule( mat );
    
    return HomalgMatrix( lead, NrRows( mat ), NrColumns( mat ), R );
    
end );

##
InstallGlobalFunction( VariableForHilbertPoincareSeries,
  function( arg )
    local s;
    
    if not IsBound( HOMALG_MODULES.variable_for_Hilbert_Poincare_series ) then
        
        if Length( arg ) > 0 and IsString( arg[1] ) then
            s := arg[1];
        else
            s := "s";
        fi;
        
        s := Indeterminate( Rationals, s );
        
        HOMALG_MODULES.variable_for_Hilbert_Poincare_series := s;
    fi;
    
    return HOMALG_MODULES.variable_for_Hilbert_Poincare_series;
    
end );

##
InstallGlobalFunction( VariableForHilbertPolynomial,
  function( arg )
    local t;
    
    if not IsBound( HOMALG_MODULES.variable_for_Hilbert_polynomial ) then
        
        if Length( arg ) > 0 and IsString( arg[1] ) then
            t := arg[1];
        else
            t := "t";
        fi;
        
        t := Indeterminate( Rationals, t );
        
        HOMALG_MODULES.variable_for_Hilbert_polynomial := t;
    fi;
    
    return HOMALG_MODULES.variable_for_Hilbert_polynomial;
    
end );

##
InstallGlobalFunction( CoefficientsOfLaurentPolynomialsWithRange,
  function( poly )
    local coeffs, ldeg;
    
    coeffs := CoefficientsOfLaurentPolynomial( poly );
    
    ldeg := coeffs[2];
    
    coeffs := coeffs[1];
    
    return [ coeffs, [ ldeg .. ldeg + Length( coeffs ) - 1 ] ];
    
end );

##
InstallGlobalFunction( SumCoefficientsOfLaurentPolynomials,
  function( arg )
    local s, sum;
    
    s := VariableForHilbertPolynomial( );
    
    sum := Sum( arg, a -> Sum( [ 1 .. Length( a[2] ) ], i -> a[1][i] * s^a[2][i] ) ) + 0 * s;
    
    return CoefficientsOfLaurentPolynomialsWithRange( sum );
    
end );

##
InstallMethod( CoefficientsOfUnreducedNumeratorOfHilbertPoincareSeries,
        "for a homalg matrix and two lists",
        [ IsHomalgMatrix, IsList, IsList ],
        
  function( M, weights, degrees )
    local c, save, R, RP, t, zero_cols, free, hilb_free, non_zero_cols, hilb, l, ldeg;
    
    c := String( [ weights, degrees ] );
    
    if IsBound( M!.CoefficientsOfUnreducedNumeratorOfWeightedHilbertPoincareSeries ) then
        save := M!.CoefficientsOfUnreducedNumeratorOfWeightedHilbertPoincareSeries;
        if IsBound( save.(c) ) then
            return save.(c);
        fi;
    else
        save := rec( );
        M!.CoefficientsOfUnreducedNumeratorOfWeightedHilbertPoincareSeries := save;
    fi;
    
    if NrColumns( M ) <> Length( degrees ) then
        Error( "the number of columns must coincide with the number of degrees\n" );
    fi;
    
    R := HomalgRing( M );
    
    if Length( Indeterminates( R ) ) <> Length( weights ) then
        Error( "the number of indeterminates must coincide with the number of weights\n" );
    fi;
    
    ## take care of n x 0 matrices
    if NrColumns( M ) = 0 then
        save.(c) := [ [ ], [ ] ];
        return save.(c);
    fi;
    
    RP := homalgTable( R );
    
    if IsBound( RP!.CoefficientsOfUnreducedNumeratorOfHilbertPoincareSeries ) and
       Set( weights ) = [ 1 ] and Length( Set( degrees ) ) = 1 then
        
        t := Set( degrees )[ 1 ];
        
        ## the coefficients of the unreduced untwisted numerator
        ## differ from the twisted ones below by a shift by t
        hilb := CoefficientsOfUnreducedNumeratorOfHilbertPoincareSeries( M );
        
        if hilb = [ ] then
            ## the degenerate case
            hilb := [ [ ], [ ] ];
        else
            hilb := [ hilb, [ t .. Length( hilb ) - 1 + t ] ];
        fi;
        
        save.(c) := hilb;
        
        return save.(c);
        
    elif IsBound( RP!.CoefficientsOfUnreducedNumeratorOfWeightedHilbertPoincareSeries ) then
        
        zero_cols := ZeroColumns( M );
        
        if zero_cols <> [ ] and
           not ( IsZero( M ) and NrRows( M ) = 1 and NrColumns( M ) = 1 ) then	## avoid infinite loops
            ## take care of matrices with zero columns, especially of 0 x n matrices
            
            free := HomalgZeroMatrix( 1, 1, R );
            
            hilb_free := CoefficientsOfUnreducedNumeratorOfHilbertPoincareSeries( free, weights, [ 0 * degrees[zero_cols[1]] ] );
            
            l := Length( hilb_free[1] );
            
            hilb_free := List( degrees{zero_cols}, d -> [ hilb_free[1], [ d .. d + l - 1 ] ] );
            
            hilb_free := CallFuncList( SumCoefficientsOfLaurentPolynomials, hilb_free );
            
            if IsZero( M ) then
                save.(c) := hilb_free;
                return save.(c);
            fi;
            
            non_zero_cols := NonZeroColumns( M );
            
            M := CertainColumns( M, non_zero_cols );
            
            degrees := degrees{non_zero_cols};
            
        else
            
            hilb_free := [ [ ], [ ] ];
            
        fi;
        
        hilb := RP!.CoefficientsOfUnreducedNumeratorOfWeightedHilbertPoincareSeries( M, weights, degrees );
        
        l := Length( hilb ) - 1;
        
        if l = 0 or l = -1 then
            ## the degenerate case
            hilb := [ [ ], [ ] ];
            
        else
            
            ldeg := hilb[l + 1];
            
            hilb := hilb{[ 1 .. l ]};
            
            t := PositionNonZero( hilb );
            
            hilb := hilb{[ t .. l ]};
            
            ldeg := ldeg + t - 1;
            
            hilb := [ hilb, [ ldeg .. l - t + ldeg ] ];
            
        fi;
        
        hilb := SumCoefficientsOfLaurentPolynomials( hilb, hilb_free );
        
        save.(c) := hilb;
        
        return save.(c);
        
    fi;
    
    if not IsHomalgInternalRingRep( R ) then
        Error( "could not find a procedure called CoefficientsOfUnreducedNumeratorOfWeightedHilbertPoincareSeries ",
               "in the homalgTable of the non-internal ring\n" );
    fi;
    
    TryNextMethod( );
    
end );

##
InstallMethod( CoefficientsOfUnreducedNumeratorOfHilbertPoincareSeries,
        "for a homalg matrix",
        [ IsHomalgMatrix ],
        
  function( M )
    local R, RP, free, r, hilb_free, hilb;
    
    ## take care of n x 0 matrices
    if NrColumns( M ) = 0 then
        return [ ];
    fi;
    
    R := HomalgRing( M );
    
    RP := homalgTable( R );
    
    if IsBound( RP!.CoefficientsOfUnreducedNumeratorOfHilbertPoincareSeries ) then
        
        free := ZeroColumns( M );
        
        if free <> [ ] and
           not ( IsZero( M ) and NrRows( M ) = 1 and NrColumns( M ) = 1 ) then	## avoid infinite loops
            ## take care of matrices with zero columns, especially of 0 x n matrices
            
            r := Length( free );
            
            free := HomalgZeroMatrix( 1, 1, R );
            
            hilb_free := CoefficientsOfUnreducedNumeratorOfHilbertPoincareSeries( free );
            
            hilb_free := r * hilb_free;
            
            if IsZero( M ) then
                return hilb_free;
            fi;
            
            M := CertainColumns( M, NonZeroColumns( M ) );
            
        else
            
            hilb_free := 0;
            
        fi;
        
        return hilb_free + RP!.CoefficientsOfUnreducedNumeratorOfHilbertPoincareSeries( M );
        
    fi;
    
    if not IsHomalgInternalRingRep( R ) then
        Error( "could not find a procedure called CoefficientsOfUnreducedNumeratorOfHilbertPoincareSeries ",
               "in the homalgTable of the non-internal ring\n" );
    fi;
    
    TryNextMethod( );
    
end );

##
InstallMethod( CoefficientsOfNumeratorOfHilbertPoincareSeries,
        "for a rational function",
        [ IsRationalFunction ],
        
  function( series )
    local denom, ldeg, lowest_coeff, s, numer;
    
    if IsZero( series ) then
        return [ [ ], [ ] ];
    fi;
    
    denom := DenominatorOfRationalFunction( series );
    
    denom := CoefficientsOfUnivariatePolynomial( denom );
    
    ldeg := PositionNonZero( denom ) - 1;
    
    lowest_coeff := denom[ldeg + 1];
    
    if not lowest_coeff in [ 1, -1 ] then
        Error( "expected the lowest coefficient of the denominator of the Hilbert-Poincare series to be 1 or -1 but received ", lowest_coeff, "\n" );
    fi;
    
    s := IndeterminateOfUnivariateRationalFunction( series );
    
    numer := NumeratorOfRationalFunction( series ) / ( lowest_coeff * s^ldeg );
    
    return CoefficientsOfLaurentPolynomialsWithRange( numer );
    
end );

##
InstallMethod( CoefficientsOfNumeratorOfHilbertPoincareSeries,
        "for a rational function and the integer 0",
        [ IsRationalFunction, IsInt and IsZero ],
        
  function( series, i )	## i = 0
    local coeffs;
    
    coeffs := CoefficientsOfNumeratorOfHilbertPoincareSeries( series );
    
    if coeffs[2] = [ ] then
        coeffs := coeffs[1];
    elif coeffs[2][1] = 0 then
        coeffs := coeffs[1];
    elif coeffs[2][1] > 0 then
        coeffs := Concatenation( ListWithIdenticalEntries( coeffs[2][1], 0 * coeffs[1][1] ), coeffs[1] );
    else
        Error( "expected CoefficientsOfNumeratorOfCoeffsertPoincareSeries to indicate a polynomial and not of a Laurent polynomial: ", coeffs );
    fi;
    
    return coeffs;
    
end );

##
InstallMethod( CoefficientsOfNumeratorOfHilbertPoincareSeries,
        "for a homalg matrix and two lists",
        [ IsHomalgMatrix, IsList, IsList ],
  ## the fallback method
  ReturnFail );

##
InstallMethod( CoefficientsOfNumeratorOfHilbertPoincareSeries,
        "for a homalg matrix and two lists",
        [ IsHomalgMatrix, IsList, IsList ],
        
  function( M, weights, degrees )
    local c, save, R, RP, t, free, s, hilb, d;
    
    c := String( [ weights, degrees ] );
    
    if IsBound( M!.CoefficientsOfNumeratorOfWeightedHilbertPoincareSeries ) then
        save := M!.CoefficientsOfNumeratorOfWeightedHilbertPoincareSeries;
        if IsBound( save.(c) ) then
            return save.(c);
        fi;
    else
        save := rec( );
        M!.CoefficientsOfNumeratorOfWeightedHilbertPoincareSeries := save;
    fi;
    
    if NrColumns( M ) <> Length( degrees ) then
        Error( "the number of columns must coincide with the number of degrees\n" );
    fi;
    
    R := HomalgRing( M );
    
    if Length( Indeterminates( R ) ) <> Length( weights ) then
        Error( "the number of indeterminates must coincide with the number of weights\n" );
    fi;
    
    ## take care of n x 0 matrices
    if NrColumns( M ) = 0 then
        save.(c) := [ [ ], [ ] ];
        return save.(c);
    fi;
    
    RP := homalgTable( R );
    
    if ( IsBound( RP!.CoefficientsOfUnreducedNumeratorOfHilbertPoincareSeries ) or
         IsBound( RP!.CoefficientsOfNumeratorOfHilbertPoincareSeries ) ) and
       Set( weights ) = [ 1 ] and Length( Set( degrees ) ) = 1 then
        
        t := Set( degrees )[ 1 ];
        
        ## the coefficients of the untwisted numerator
        ## differ from the twisted ones below by a shift by t
        hilb := CoefficientsOfNumeratorOfHilbertPoincareSeries( M );
        
        if hilb = [ ] then
            ## the degenerate case
            hilb := [ [ ], [ ] ];
        else
            hilb := [ hilb, [ t .. Length( hilb ) - 1 + t ] ];
        fi;
        
        save.(c) := hilb;
        
        return save.(c);
        
    elif IsBound( RP!.CoefficientsOfNumeratorOfWeightedHilbertPoincareSeries ) then
        
        if IsZero( M ) then
            ## take care of zero matrices, especially of 0 x n matrices
            free := HomalgZeroMatrix( 1, NrColumns( M ), R );
            hilb := RP!.CoefficientsOfNumeratorOfWeightedHilbertPoincareSeries( free, weights, degrees );
        else
            hilb := RP!.CoefficientsOfNumeratorOfWeightedHilbertPoincareSeries( M, weights, degrees );
        fi;
        
        save.(c) := hilb;
        
        return hilb;
        
    elif IsBound( RP!.CoefficientsOfUnreducedNumeratorOfWeightedHilbertPoincareSeries ) then
        
        s := VariableForHilbertPoincareSeries( );
        
        hilb := HilbertPoincareSeries( M, weights, degrees, s );
        
        save.(c) := CoefficientsOfNumeratorOfHilbertPoincareSeries( hilb );
        
        return save.(c);
        
    fi;
    
    TryNextMethod( );
    
end );

##
InstallMethod( CoefficientsOfNumeratorOfHilbertPoincareSeries,
        "for a homalg matrix",
        [ IsHomalgMatrix ],
        
  function( M )
    local R, RP, free, hilb, lowest_coeff;
    
    ## take care of n x 0 matrices
    if NrColumns( M ) = 0 then
        return [ ];
    fi;
    
    R := HomalgRing( M );
    
    RP := homalgTable( R );
    
    if IsBound( RP!.CoefficientsOfNumeratorOfHilbertPoincareSeries ) then
        
        if IsZero( M ) then
            ## take care of zero matrices, especially of 0 x n matrices
            free := HomalgZeroMatrix( 1, 1, R );
            hilb := RP!.CoefficientsOfNumeratorOfHilbertPoincareSeries( free );
            return NrColumns( M ) * hilb;
        else
            return RP!.CoefficientsOfNumeratorOfHilbertPoincareSeries( M );
        fi;
        
    elif IsBound( RP!.CoefficientsOfUnreducedNumeratorOfHilbertPoincareSeries ) then
        
        hilb := HilbertPoincareSeries( M );
        
        return CoefficientsOfNumeratorOfHilbertPoincareSeries( hilb, 0 );
        
    fi;
    
    if not IsHomalgInternalRingRep( R ) then
        Error( "could not find a procedure called CoefficientsOfNumeratorOfHilbertPoincareSeries ",
               "in the homalgTable of the non-internal ring\n" );
    fi;
    
end );

##
InstallMethod( UnreducedNumeratorOfHilbertPoincareSeries,
        "for a homalg matrix, two lists, and a ring element",
        [ IsHomalgMatrix, IsList, IsList, IsRingElement ],
        
  function( M, weights, degrees, lambda )
    local R, RP, t, hilb, range;
    
    ## take care of n x 0 matrices
    if NrColumns( M ) = 0 then
        return 0 * lambda;
    fi;
    
    R := HomalgRing( M );
    
    RP := homalgTable( R );
    
    if IsBound( RP!.CoefficientsOfUnreducedNumeratorOfHilbertPoincareSeries ) and
       Set( weights ) = [ 1 ] and Length( Set( degrees ) ) = 1 then
        
        t := Set( degrees )[ 1 ];
        
        ## the unreduced numerator of the untwisted Hilbert-Poincaré series
        ## differs from the twisted one by the factor lambda^t
        hilb := UnreducedNumeratorOfHilbertPoincareSeries( M );
        
        return lambda^t * hilb;
        
    elif IsBound( RP!.CoefficientsOfUnreducedNumeratorOfWeightedHilbertPoincareSeries ) then
        
        hilb := CoefficientsOfUnreducedNumeratorOfHilbertPoincareSeries( M, weights, degrees );
        
        range := hilb[2];
        hilb := hilb[1];
        
        hilb := Sum( [ 1 .. Length( range ) ], i -> hilb[i] * lambda^range[i] );
        
        return hilb + 0 * lambda;
        
    fi;
    
    if not IsHomalgInternalRingRep( R ) then
        Error( "could not find a procedure called CoefficientsOfUnreducedNumeratorOfWeightedHilbertPoincareSeries ",
               "in the homalgTable of the non-internal ring\n" );
    fi;
    
    TryNextMethod( );
    
end );

##
InstallMethod( UnreducedNumeratorOfHilbertPoincareSeries,
        "for a homalg matrix and two lists",
        [ IsHomalgMatrix, IsList, IsList ],
        
  function( M, weights, degrees )
    
    return UnreducedNumeratorOfHilbertPoincareSeries( M, weights, degrees, VariableForHilbertPoincareSeries( ) );
    
end );

##
InstallMethod( UnreducedNumeratorOfHilbertPoincareSeries,
        "for a homalg matrix and a ring element",
        [ IsHomalgMatrix, IsRingElement ],
        
  function( M, lambda )
    local R, RP, hilb;
    
    ## take care of n x 0 matrices
    if NrColumns( M ) = 0 then
        return 0 * lambda;
    fi;
    
    R := HomalgRing( M );
    
    RP := homalgTable( R );
    
    if IsBound( RP!.CoefficientsOfUnreducedNumeratorOfHilbertPoincareSeries ) then
        
        hilb := CoefficientsOfUnreducedNumeratorOfHilbertPoincareSeries( M );
        
        hilb := Sum( [ 0 .. Length( hilb ) - 1 ], k -> hilb[k+1] * lambda^k );
        
        return hilb + 0 * lambda;
        
    fi;
    
    if not IsHomalgInternalRingRep( R ) then
        Error( "could not find a procedure called CoefficientsOfUnreducedNumeratorOfHilbertPoincareSeries ",
               "in the homalgTable of the non-internal ring\n" );
    fi;
    
    TryNextMethod( );
    
end );

##
InstallMethod( UnreducedNumeratorOfHilbertPoincareSeries,
        "for a homalg matrix",
        [ IsHomalgMatrix ],
        
  function( M )
    
    return UnreducedNumeratorOfHilbertPoincareSeries( M, VariableForHilbertPoincareSeries( ) );
    
end );

##
InstallMethod( NumeratorOfHilbertPoincareSeries,
        "for a homalg matrix, two lists, and a ring element",
        [ IsHomalgMatrix, IsList, IsList, IsRingElement ],
        
  function( M, weights, degrees, lambda )
    local R, RP, t, hilb, range;
    
    ## take care of n x 0 matrices
    if NrColumns( M ) = 0 then
        return 0 * lambda;
    fi;
    
    R := HomalgRing( M );
    
    RP := homalgTable( R );
    
    if ( IsBound( RP!.CoefficientsOfUnreducedNumeratorOfHilbertPoincareSeries ) or
         IsBound( RP!.CoefficientsOfNumeratorOfHilbertPoincareSeries ) ) and
       Set( weights ) = [ 1 ] and Length( Set( degrees ) ) = 1 then
        
        t := Set( degrees )[ 1 ];
        
        ## the numerator of the untwisted Hilbert-Poincaré series
        ## differs from the twisted one by the factor lambda^t
        hilb := NumeratorOfHilbertPoincareSeries( M );
        
        return lambda^t * hilb;
        
    elif IsBound( RP!.CoefficientsOfNumeratorOfWeightedHilbertPoincareSeries ) or
      IsBound( RP!.CoefficientsOfUnreducedNumeratorOfWeightedHilbertPoincareSeries ) then
        
        hilb := CoefficientsOfNumeratorOfHilbertPoincareSeries( M, weights, degrees );
        
        if hilb = [ [ ], [ ] ] then
            return 0 * lambda;
        fi;
        
        range := hilb[2];
        hilb := hilb[1];
        
        hilb := Sum( [ 1 .. Length( range ) ], i -> hilb[i] * lambda^range[i] );
        
        return hilb + 0 * lambda;
        
    fi;
    
    if not IsHomalgInternalRingRep( R ) then
        Error( "could not find a procedure called CoefficientsOfNumeratorOfWeightedHilbertPoincareSeries ",
               "in the homalgTable of the non-internal ring\n" );
    fi;
    
    TryNextMethod( );
    
end );

##
InstallMethod( NumeratorOfHilbertPoincareSeries,
        "for a homalg matrix and two lists",
        [ IsHomalgMatrix, IsList, IsList ],
        
  function( M, weights, degrees )
    
    return NumeratorOfHilbertPoincareSeries( M, weights, degrees, VariableForHilbertPoincareSeries( ) );
    
end );

##
InstallMethod( NumeratorOfHilbertPoincareSeries,
        "for a homalg matrix and a ring element",
        [ IsHomalgMatrix, IsRingElement ],
        
  function( M, lambda )
    local R, RP, hilb, lowest_coeff;
    
    ## take care of n x 0 matrices
    if NrColumns( M ) = 0 then
        return 0 * lambda;
    fi;
    
    R := HomalgRing( M );
    
    RP := homalgTable( R );
    
    if IsBound( RP!.CoefficientsOfNumeratorOfHilbertPoincareSeries ) then
        
        hilb := CoefficientsOfNumeratorOfHilbertPoincareSeries( M );
        
        hilb := Sum( [ 0 .. Length( hilb ) - 1 ], k -> hilb[k+1] * lambda^k );
        
        return hilb + 0 * lambda;
        
    elif IsBound( RP!.CoefficientsOfUnreducedNumeratorOfHilbertPoincareSeries ) then
        
        hilb := HilbertPoincareSeries( M );
        
        lowest_coeff := function( f );
            return First( CoefficientsOfUnivariatePolynomial( f ), a -> not IsZero( a ) );
        end;
        
        lowest_coeff := lowest_coeff( DenominatorOfRationalFunction( hilb ) );
        
        if not lowest_coeff in [ 1, -1 ] then
            Error( "expected the lowest coefficient of the denominator of the Hilbert-Poincare series to be 1 or -1 but received ", lowest_coeff, "\n" );
        fi;
        
        return NumeratorOfRationalFunction( hilb ) / lowest_coeff;
        
    fi;
    
    if not IsHomalgInternalRingRep( R ) then
        Error( "could not find a procedure called CoefficientsOfNumeratorOfHilbertPoincareSeries ",
               "in the homalgTable of the non-internal ring\n" );
    fi;
    
    TryNextMethod( );
    
end );

##
InstallMethod( NumeratorOfHilbertPoincareSeries,
        "for a homalg matrix",
        [ IsHomalgMatrix ],
        
  function( M )
    
    return NumeratorOfHilbertPoincareSeries( M, VariableForHilbertPoincareSeries( ) );
    
end );

##
InstallMethod( HilbertPoincareSeries,
        "for a homalg matrix, two lists, and a ring element",
        [ IsHomalgMatrix, IsList, IsList, IsRingElement ],
  ## the fallback method
  ReturnFail );

##
InstallMethod( HilbertPoincareSeries,
        "for a homalg matrix, two lists, and a ring element",
        [ IsHomalgMatrix, IsList, IsList, IsRingElement ],
        
  function( M, weights, degrees, lambda )
    local R, RP, t, hilb, denom, n, d;
    
    R := HomalgRing( M );
    
    RP := homalgTable( R );
    
    if ( IsBound( RP!.CoefficientsOfUnreducedNumeratorOfHilbertPoincareSeries ) or
         IsBound( RP!.CoefficientsOfNumeratorOfHilbertPoincareSeries ) ) and
       Set( weights ) = [ 1 ] and Length( Set( degrees ) ) = 1 then
        
        t := Set( degrees )[ 1 ];
        
        ## the untwisted Hilbert-Poincaré series
        ## differs from the twisted one by the factor lambda^t
        hilb := HilbertPoincareSeries( M, lambda );
        
        return lambda^t * hilb;
        
    elif IsBound( RP!.CoefficientsOfUnreducedNumeratorOfWeightedHilbertPoincareSeries ) then
        
        hilb := UnreducedNumeratorOfHilbertPoincareSeries( M, weights, degrees, lambda );
        
        denom := Product( weights, i -> ( 1 - lambda^i ) );
        
        return hilb / denom;
        
    elif IsBound( RP!.CoefficientsOfNumeratorOfWeightedHilbertPoincareSeries ) then
        
        hilb := NumeratorOfHilbertPoincareSeries( M, weights, degrees, lambda );
        
        ## for CASs which do not support Hilbert* for non-graded modules
        d := AffineDimension( M, weights, degrees );
        
        return hilb / ( 1 - lambda )^d;
        
    fi;
    
    TryNextMethod( );
    
end );

##
InstallMethod( HilbertPoincareSeries,
        "for a homalg matrix, two lists, and a string",
        [ IsHomalgMatrix, IsList, IsList, IsString ],
        
  function( M, weights, degrees, lambda )
    
    return HilbertPoincareSeries( M, weights, degrees, Indeterminate( Rationals, lambda ) );
    
end );

##
InstallMethod( HilbertPoincareSeries,
        "for a homalg matrix and two lists",
        [ IsHomalgMatrix, IsList, IsList ],
        
  function( M, weights, degrees )
    
    return HilbertPoincareSeries( M, weights, degrees, VariableForHilbertPoincareSeries( ) );
    
end );

##
InstallMethod( HilbertPoincareSeries,
        "for a homalg matrix and a ring element",
        [ IsHomalgMatrix, IsRingElement ],
        
  function( M, lambda )
    local R, RP, hilb, n, d;
    
    R := HomalgRing( M );
    
    RP := homalgTable( R );
    
    if IsBound( RP!.CoefficientsOfUnreducedNumeratorOfHilbertPoincareSeries ) then
        
        hilb := UnreducedNumeratorOfHilbertPoincareSeries( M, lambda );
        
        n := Length( Indeterminates( R ) );
        
        return  hilb / ( 1 - lambda )^n;
        
    elif IsBound( RP!.CoefficientsOfNumeratorOfHilbertPoincareSeries ) then
        
        hilb := NumeratorOfHilbertPoincareSeries( M, lambda );
        
        d := AffineDimension( M );
        
        return hilb / ( 1 - lambda )^d;
        
    fi;
    
    TryNextMethod( );
    
end );

##
InstallMethod( HilbertPoincareSeries,
        "for a homalg matrix and a string",
        [ IsHomalgMatrix, IsString ],
        
  function( M, lambda )
    
    return HilbertPoincareSeries( M, Indeterminate( Rationals, lambda ) );
    
end );

##
InstallMethod( HilbertPoincareSeries,
        "for a homalg matrix",
        [ IsHomalgMatrix ],
        
  function( M )
    
    return HilbertPoincareSeries( M, VariableForHilbertPoincareSeries( ) );
    
end );

##
InstallGlobalFunction( _Binomial,
  function( a, b )
    local factorial;
    
    if b = 0 then
        ## ensure that the result has the type of a
        return 1 + 0 * a;
    elif b = 1 then
        return a;
    fi;
    
    factorial := Product( [ 0 .. b - 1 ], i -> a - i ) / Factorial( b );
    
    return factorial;
    
end );

##
InstallMethod( HilbertPolynomial,
        "for a list, an integer, and a ring element",
        [ IsList, IsInt, IsRingElement ],
        
  function( coeffs, d, s )
    local range, hilb;
    
    if d <= 0 then
        return 0 * s;
    fi;
    
    if ForAll( coeffs, IsList ) and Length( coeffs ) = 2 then
        ## the case: coeffs = CoefficientsOfNumeratorOfHilbertPoincareSeries( M, weights, degrees );
        
        range := coeffs[2];
        coeffs := coeffs[1];
        
        hilb := Sum( [ 1 .. Length( range ) ], i -> coeffs[i] * _Binomial( d - 1 + s - range[i], d - 1 ) );
        
    else
        ## the case: coeffs = CoefficientsOfNumeratorOfHilbertPoincareSeries( M );
        
        hilb := Sum( [ 0 .. Length( coeffs ) - 1 ], k -> coeffs[k+1] * _Binomial( d - 1 + s - k, d - 1 ) );
        
    fi;
    
    return hilb + 0 * s;
    
end );

##
InstallMethod( DimensionOfHilbertPoincareSeries,
        "for a rational function",
        [ IsRationalFunction ],
        
  function( series )
    local denom, hdeg, ldeg;
    
    if IsZero( series ) then
        return HOMALG_MODULES.DimensionOfZeroModules;
    fi;
    
    denom := DenominatorOfRationalFunction( series );
    
    hdeg := Degree( denom );
    
    denom := CoefficientsOfUnivariatePolynomial( denom );
    
    ldeg := PositionNonZero( denom ) - 1;
    
    return hdeg - ldeg;
    
end );

##
InstallMethod( HilbertPolynomial,
        "for a list and an integer",
        [ IsList, IsInt ],
        
  function( coeffs, d )
    local s;
    
    s := VariableForHilbertPolynomial( );
    
    return HilbertPolynomial( coeffs, d, s );
    
end );

##
InstallMethod( HilbertPolynomialOfHilbertPoincareSeries,
        "for a rational function",
        [ IsRationalFunction ],
        
  function( series )
    local coeffs, d;
    
    coeffs := CoefficientsOfNumeratorOfHilbertPoincareSeries( series );
    
    d := DimensionOfHilbertPoincareSeries( series );
    
    return HilbertPolynomial( coeffs, d );
    
end );

##
InstallMethod( HilbertPolynomial,
        "for a homalg matrix, two lists, and a ring element",
        [ IsHomalgMatrix, IsList, IsList, IsRingElement ],
  ## the fallback method
  ReturnFail );

##
InstallMethod( HilbertPolynomial,
        "for a homalg matrix, two lists, and a ring element",
        [ IsHomalgMatrix, IsList, IsList, IsRingElement ],
        
  function( M, weights, degrees, lambda )
    local R, RP, t, hilb;
    
    ## take care of n x 0 matrices
    if NrColumns( M ) = 0 then
        return 0 * lambda;
    fi;
    
    R := HomalgRing( M );
    
    RP := homalgTable( R );
    
    if ( IsBound( RP!.CoefficientsOfUnreducedNumeratorOfHilbertPoincareSeries ) or
         IsBound( RP!.CoefficientsOfNumeratorOfHilbertPoincareSeries ) ) and
       Set( weights ) = [ 1 ] and Length( Set( degrees ) ) = 1 then
        
        t := Set( degrees )[ 1 ];
        
        ## the untwisted Hilbert polynomial
        ## differs from the twisted one by a shift by t
        hilb := HilbertPolynomial( M, lambda );
        
        return Value( hilb, lambda - t );
        
    elif IsBound( RP!.CoefficientsOfUnreducedNumeratorOfWeightedHilbertPoincareSeries ) or
      IsBound( RP!.CoefficientsOfNumeratorOfWeightedHilbertPoincareSeries ) then
        
        hilb := HilbertPoincareSeries( M, weights, degrees, lambda );
        
        return HilbertPolynomialOfHilbertPoincareSeries( hilb );
        
    fi;
    
    TryNextMethod( );
    
end );

##
InstallMethod( HilbertPolynomial,
        "for a homalg matrix, two lists, and a string",
        [ IsHomalgMatrix, IsList, IsList, IsString ],
        
  function( M, weights, degrees, lambda )
    
    return HilbertPolynomial( M, weights, degrees, Indeterminate( Rationals, lambda ) );
    
end );

##
InstallMethod( HilbertPolynomial,
        "for a homalg matrix and two lists",
        [ IsHomalgMatrix, IsList, IsList ],
        
  function( M, weights, degrees )
    
    return HilbertPolynomial( M, weights, degrees, VariableForHilbertPolynomial( ) );
    
end );

##
InstallMethod( HilbertPolynomial,
        "for a homalg matrix and a ring element",
        [ IsHomalgMatrix, IsRingElement ],
        
  function( M, lambda )
    local R, RP, free, hilb;
    
    ## take care of n x 0 matrices
    if NrColumns( M ) = 0 then
        return 0 * lambda;
    fi;
    
    R := HomalgRing( M );
    
    RP := homalgTable( R );
    
    if IsBound( RP!.CoefficientsOfHilbertPolynomial ) then
        
        if IsZero( M ) then
            ## take care of zero matrices, especially of 0 x n matrices
            free := HomalgZeroMatrix( 1, 1, R );
            hilb := RP!.CoefficientsOfHilbertPolynomial( free );
            hilb := NrColumns( M ) * hilb;
        else
            hilb := RP!.CoefficientsOfHilbertPolynomial( M );
        fi;
        
        hilb := Sum( [ 0 .. Length( hilb ) - 1 ], k -> hilb[k+1] * lambda^k );
        
        return hilb + 0 * lambda;
        
    elif IsBound( RP!.CoefficientsOfUnreducedNumeratorOfHilbertPoincareSeries ) or
      IsBound( RP!.CoefficientsOfNumeratorOfHilbertPoincareSeries ) then
        
        hilb := HilbertPoincareSeries( M, lambda );
        
        return HilbertPolynomialOfHilbertPoincareSeries( hilb );
        
    fi;
    
    if not IsHomalgInternalRingRep( R ) then
        Error( "could not find a procedure called CoefficientsOfHilbertPolynomial ",
               "in the homalgTable of the non-internal ring\n" );
    fi;
    
    TryNextMethod( );
    
end );

##
InstallMethod( HilbertPolynomial,
        "for a homalg matrix and a string",
        [ IsHomalgMatrix, IsString ],
        
  function( M, lambda )
    
    return HilbertPolynomial( M, Indeterminate( Rationals, lambda ) );
    
end );

##
InstallMethod( HilbertPolynomial,
        "for a homalg matrix",
        [ IsHomalgMatrix ],
        
  function( M )
    
    return HilbertPolynomial( M, VariableForHilbertPolynomial( ) );
    
end );

## for CASs which do not support Hilbert* for non-graded modules
InstallMethod( AffineDimension,
        "for a homalg matrix and two lists",
        [ IsHomalgMatrix, IsList, IsList ],
        
  function( M, weights, degrees )
    local R, RP, free, hilb, d;
    
    if HasAffineDimension( M ) then
        return AffineDimension( M );
    fi;
    
    R := HomalgRing( M );
    
    if NrColumns( M ) = 0 then
        ## take care of n x 0 matrices
        return HOMALG_MODULES.DimensionOfZeroModules;
    elif ZeroColumns( M ) <> [ ] then
        ## take care of matrices with zero columns, especially of 0 x n matrices
        if HasKrullDimension( R ) then
            return KrullDimension( R );	## this is not a mistake
        elif not ( IsZero( M ) and NrRows( M ) = 1 and NrColumns( M ) = 1 ) then	## avoid infinite loops
            free := HomalgZeroMatrix( 1, 1, R );
            return AffineDimension( free, weights, degrees );
        fi;
    fi;
    
    RP := homalgTable( R );
    
    if IsBound( RP!.AffineDimension ) then
        
        return AffineDimension( M );
        
    elif IsBound( RP!.CoefficientsOfUnreducedNumeratorOfWeightedHilbertPoincareSeries ) then
        
        ## the Hilbert polynomial, as a projective invariant,
        ## cannot distinguish between empty and zero dimensional *affine* sets;
        ## they are both empty as projective sets
        hilb := HilbertPoincareSeries( M, weights, degrees );
        
        d := DimensionOfHilbertPoincareSeries( hilb );
        
        SetAffineDimension( M, d );
        
        return d;
        
    fi;
    
    ## before giving up
    return AffineDimension( M );
    
end );

##
InstallMethod( AffineDimension,
        "for a homalg matrix",
        [ IsHomalgMatrix ],
        
  function( M )
    local R, RP, free, hilb, d;
    
    R := HomalgRing( M );
    
    if NrColumns( M ) = 0 then
        ## take care of n x 0 matrices
        return HOMALG_MODULES.DimensionOfZeroModules;
    elif ZeroColumns( M ) <> [ ] then
        ## take care of matrices with zero columns, especially of 0 x n matrices
        if HasKrullDimension( R ) then
            return KrullDimension( R );	## this is not a mistake
        elif not ( IsZero( M ) and NrRows( M ) = 1 and NrColumns( M ) = 1 ) then	## avoid infinite loops
            free := HomalgZeroMatrix( 1, 1, R );
            return AffineDimension( free );
        fi;
    fi;
    
    RP := homalgTable( R );
    
    if IsBound( RP!.AffineDimension ) then
        
        d := RP!.AffineDimension( M );
        
        if d < 0 then
            d := HOMALG_MODULES.DimensionOfZeroModules;
        fi;
        
        return d;
        
    elif IsBound( RP!.CoefficientsOfUnreducedNumeratorOfHilbertPoincareSeries ) then
        
        ## the Hilbert polynomial, as a projective invariant,
        ## cannot distinguish between empty and zero dimensional *affine* sets;
        ## they are both empty as projective sets
        hilb := HilbertPoincareSeries( M );
        
        if IsZero( hilb ) then
            d := HOMALG_MODULES.DimensionOfZeroModules;
        else
            d := Degree( DenominatorOfRationalFunction( hilb ) );
        fi;
        
        return d;
        
    elif IsBound( RP!.AffineDimensionOfIdeal ) and NrColumns( M ) = 1 then
        
        d := RP!.AffineDimensionOfIdeal( M );
        
        if d < 0 then
            d := HOMALG_MODULES.DimensionOfZeroModules;
        fi;
        
        return d;
        
    fi;
    
    if not IsHomalgInternalRingRep( R ) then
        Error( "could not find a procedure called AffineDimension ",
               "in the homalgTable of the non-internal ring\n" );
    fi;
    
    TryNextMethod( );
    
end );

##
InstallMethod( AffineDegree,
        "for a homalg matrix and two lists",
        [ IsHomalgMatrix, IsList, IsList ],
        
  function( M, weights, degrees )
    local R, RP, hilb;
    
    R := HomalgRing( M );
    
    RP := homalgTable( R );
    
    if ( IsBound( RP!.CoefficientsOfUnreducedNumeratorOfHilbertPoincareSeries ) or
         IsBound( RP!.CoefficientsOfNumeratorOfHilbertPoincareSeries ) ) and
       Set( weights ) = [ 1 ] and Length( Set( degrees ) ) = 1 then
        
        ## the coefficients of the untwisted numerator
        ## differ from the twisted ones below by a shift
        hilb := CoefficientsOfNumeratorOfHilbertPoincareSeries( M );
        
        return Sum( hilb );
        
    elif IsBound( RP!.CoefficientsOfUnreducedNumeratorOfWeightedHilbertPoincareSeries ) or
      IsBound( RP!.CoefficientsOfNumeratorOfWeightedHilbertPoincareSeries ) then
        
        hilb := CoefficientsOfNumeratorOfHilbertPoincareSeries( M, weights, degrees );
        
        return Sum( hilb[1] );
        
    fi;
    
    if not IsHomalgInternalRingRep( R ) then
        Error( "could not find a procedure called CoefficientsOfNumeratorOfWeightedHilbertPoincareSeries ",
               "in the homalgTable of the non-internal ring\n" );
    fi;
    
    TryNextMethod( );
    
end );

##
InstallMethod( AffineDegree,
        "for a homalg matrix",
        [ IsHomalgMatrix ],
        
  function( M )
    local R, RP, hilb;
    
    ## take care of n x 0 matrices
    if NrColumns( M ) = 0 then
        return 0;
    fi;
    
    R := HomalgRing( M );
    
    RP := homalgTable( R );
    
    if IsBound( RP!.CoefficientsOfUnreducedNumeratorOfHilbertPoincareSeries ) or
       IsBound( RP!.CoefficientsOfNumeratorOfHilbertPoincareSeries )  then
        
        hilb := CoefficientsOfNumeratorOfHilbertPoincareSeries( M );
        
        return Sum( hilb );
        
    fi;
    
    if not IsHomalgInternalRingRep( R ) then
        Error( "could not find a procedure called CoefficientsOfNumeratorOfHilbertPoincareSeries ",
               "in the homalgTable of the non-internal ring\n" );
    fi;
    
    TryNextMethod( );
    
end );

##
InstallMethod( ProjectiveDegree,
        "for a homalg matrix and two lists",
        [ IsHomalgMatrix, IsList, IsList ],
        
  function( M, weights, degrees )
    local R, RP, hilb;
    
    R := HomalgRing( M );
    
    RP := homalgTable( R );
    
    if ( IsBound( RP!.CoefficientsOfUnreducedNumeratorOfHilbertPoincareSeries ) or
         IsBound( RP!.CoefficientsOfNumeratorOfHilbertPoincareSeries ) ) and
       Set( weights ) = [ 1 ] and Length( Set( degrees ) ) = 1 then
        
        hilb := HilbertPolynomial( M );
        
        if IsZero( hilb ) then
            return 0;
        fi;
        
        return LeadingCoefficient( hilb ) * Factorial( Degree( hilb ) );
        
    elif IsBound( RP!.CoefficientsOfUnreducedNumeratorOfWeightedHilbertPoincareSeries ) or
      IsBound( RP!.CoefficientsOfNumeratorOfWeightedHilbertPoincareSeries ) then
        
        hilb := HilbertPolynomial( M, weights, degrees );
        
        if IsZero( hilb ) then
            return 0;
        fi;
        
        return LeadingCoefficient( hilb ) * Factorial( Degree( hilb ) );
        
    fi;
    
    if not IsHomalgInternalRingRep( R ) then
        Error( "could not find a procedure called CoefficientsOfNumeratorOfWeightedHilbertPoincareSeries ",
               "in the homalgTable of the non-internal ring\n" );
    fi;
    
    TryNextMethod( );
    
end );

##
InstallMethod( ProjectiveDegree,
        "for a homalg matrix",
        [ IsHomalgMatrix ],
        
  function( M )
    local R, RP, hilb;
    
    ## take care of n x 0 matrices
    if NrColumns( M ) = 0 then
        return 0;
    fi;
    
    R := HomalgRing( M );
    
    RP := homalgTable( R );
    
    if IsBound( RP!.CoefficientsOfUnreducedNumeratorOfHilbertPoincareSeries ) or
      IsBound( RP!.CoefficientsOfNumeratorOfHilbertPoincareSeries )  then
        
        hilb := HilbertPolynomial( M );
        
        if IsZero( hilb ) then
            hilb := 0;
        else
            hilb := LeadingCoefficient( hilb ) * Factorial( Degree( hilb ) );
        fi;
        
        return hilb;
        
    fi;
    
    if not IsHomalgInternalRingRep( R ) then
        Error( "could not find a procedure called CoefficientsOfNumeratorOfHilbertPoincareSeries ",
               "in the homalgTable of the non-internal ring\n" );
    fi;
    
    TryNextMethod( );
    
end );

##
InstallMethod( ConstantTermOfHilbertPolynomial,
        "for a homalg matrix and two lists",
        [ IsHomalgMatrix, IsList, IsList ],
        
  function( M, weights, degrees )
    local d, R, RP, t, hilb, range;
    
    ## take care of n x 0 matrices
    if NrColumns( M ) = 0 then
        return 0;
    fi;
    
    ## for CASs which do not support Hilbert* for non-graded modules
    d := AffineDimension( M, weights, degrees );
    
    if d <= 0 then
        return 0;
    fi;
    
    R := HomalgRing( M );
    
    RP := homalgTable( R );
    
    if ( IsBound( RP!.CoefficientsOfUnreducedNumeratorOfHilbertPoincareSeries ) or
         IsBound( RP!.CoefficientsOfNumeratorOfHilbertPoincareSeries ) ) and
       Set( weights ) = [ 1 ] and Length( Set( degrees ) ) = 1 then
        
        t := Set( degrees )[ 1 ];
        
        ## the coefficients of the untwisted numerator
        ## differ from the twisted ones below by a shift by t
        hilb := CoefficientsOfNumeratorOfHilbertPoincareSeries( M );
        
        return Sum( [ 0 .. Length( hilb ) - 1 ], k -> hilb[k+1] * Binomial( d - 1 -t - k, d - 1 ) );
        
    elif IsBound( RP!.CoefficientsOfUnreducedNumeratorOfWeightedHilbertPoincareSeries ) or
      IsBound( RP!.CoefficientsOfNumeratorOfWeightedHilbertPoincareSeries ) then
        
        hilb := CoefficientsOfNumeratorOfHilbertPoincareSeries( M, weights, degrees );
        
        range := hilb[2];
        hilb := hilb[1];
        
        return Sum( [ 1 .. Length( range ) ], i -> hilb[i] * Binomial( d - 1 - range[i], d - 1 ) );
        
    fi;
    
    if not IsHomalgInternalRingRep( R ) then
        Error( "could not find a procedure called CoefficientsOfUnreducedNumeratorOfWeightedHilbertPoincareSeries ",
               "in the homalgTable of the non-internal ring\n" );
    fi;
    
    TryNextMethod( );
    
end );

##
InstallMethod( ConstantTermOfHilbertPolynomial,
        "for a homalg matrix",
        [ IsHomalgMatrix ],
        
  function( M )
    local R, RP, d, hilb;
    
    if NrColumns( M ) = 0 then
        ## take care of n x 0 matrices
        return 0;
    elif IsZero( M ) then
        ## take care of zero matrices, especially of 0 x n matrices
        return NrColumns( M );
    fi;
    
    d := AffineDimension( M );
    
    if d <= 0 then
        return 0;
    fi;
    
    R := HomalgRing( M );
    
    RP := homalgTable( R );
    
    if IsBound( RP!.ConstantTermOfHilbertPolynomial ) then
        
        return RP!.ConstantTermOfHilbertPolynomial( M );
        
    elif IsBound( RP!.CoefficientsOfUnreducedNumeratorOfHilbertPoincareSeries ) or
      IsBound( RP!.CoefficientsOfNumeratorOfHilbertPoincareSeries ) then
        
        hilb := CoefficientsOfNumeratorOfHilbertPoincareSeries( M );
        
        return Sum( [ 0 .. Length( hilb ) - 1 ], k -> hilb[k+1] * Binomial( d - 1 - k, d - 1 ) );
        
    fi;
    
    if not IsHomalgInternalRingRep( R ) then
        Error( "could not find a procedure called ConstantTermOfHilbertPolynomial ",
               "in the homalgTable of the non-internal ring\n" );
    fi;
    
    TryNextMethod( );
    
end );

##
InstallMethod( DataOfHilbertFunction,
        "for a rational function",
        [ IsRationalFunction ],
        
  function( HP )
    local t, H, numer, denom, range, ldeg, hdeg, s, power, F, l, i;
    
    t := VariableForHilbertPolynomial( );
    
    if IsZero( HP ) then
        
        H := 0 * t;
        
        ## it is ugly that we need this
        SetIndeterminateOfUnivariateRationalFunction( H, t );
        
        ## checking this property sets it
        Assert( 0, IsUnivariatePolynomial( H ) );
        
        return [ [ [ ], [ ] ], H ];
        
    fi;
    
    numer := NumeratorOfRationalFunction( HP );
    denom := DenominatorOfRationalFunction( HP );
    
    denom!.IndeterminateNumberOfUnivariateRationalFunction := IndeterminateNumberOfUnivariateRationalFunction( numer );
    
    range := CoefficientsOfNumeratorOfHilbertPoincareSeries( HP )[2];
    
    ldeg := range[1];
    
    hdeg := range[Length( range )];
    
    s := IndeterminateOfUnivariateRationalFunction( HP );
    
    power := Minimum( 0, ldeg );
    
    denom := denom * s^power;
    
    ## set the property IsUnivariatePolynomial by testing it
    Assert( 0, IsUnivariatePolynomial( numer ) );
    Assert( 0, IsUnivariatePolynomial( denom ) );
    
    numer := CreatePolynomialModuloSomePower( numer, hdeg - power );
    denom := CreatePolynomialModuloSomePower( denom, hdeg - power );
    
    F := numer * denom^-1;
    
    F := F!.polynomial * s^power;
    
    F := CoefficientsOfLaurentPolynomialsWithRange( F );
    
    Assert( 0, IsSubset( range, F[2] ) );
    
    range := F[2];
    
    l := Length( range );
    
    H := HilbertPolynomialOfHilbertPoincareSeries( HP );
    
    while l > 0 do
        
        if Value( H, range[l] ) <> F[1][l] then
            break;
        fi;
        
        l := l - 1;
        
        range := F[2]{[ 1 .. l ]};
        
        F := [ F[1]{[ 1 .. l ]}, range ];
        
    od;
    
    if l = 0 then
        return [ [ [ 0 ], [ ldeg - 1 ] ], H ];
    fi;
    
    return [ F, H ];
    
end );

##
InstallMethod( HilbertFunction,
        "for a rational function",
        [ IsRationalFunction ],
        
  function( HP )
    local data, H, l, ldeg, indeg;
    
    data := DataOfHilbertFunction( HP );
    
    H := data[2];
    
    data := data[1];
    
    l := Length( data[2] );
    
    if l = 0 then
        
        Assert( 0, IsZero( H ) );
        
        return t -> 0;
        
    fi;
    
    ldeg := data[2][1];
    indeg := data[2][l];
    
    data := data[1];
    
    return
      function( t )
        
        if t < ldeg then
            return 0;
        elif t <= indeg then
            if not IsInt( t ) then
                Error( "only able to evaluate integers in the interval [ ldeg, indeg ], but received ", t, "\n" );
            fi;
            return data[t - ldeg + 1];
        fi;
        
        return Value( H, t );
        
    end;
    
end );

##
InstallMethod( IndexOfRegularity,
        "for a rational function",
        [ IsRationalFunction ],
        
  function( HP )
    local range;
    
    if IsZero( HP ) then
        Error( "GAP does not support -infinity yet\n" );
    fi;
    
    range := DataOfHilbertFunction( HP )[1][2];
    
    return range[Length( range )] + 1;
    
end );

##
InstallMethod( PrimaryDecompositionOp,
        "for a homalg matrix",
        [ IsHomalgMatrix ],
        
  function( M )
    local R, RP, one;
    
    if IsBound( M!.PrimaryDecomposition ) then
        return M!.PrimaryDecomposition;
    fi;
    
    R := HomalgRing( M );
    
    if IsZero( M ) then
        one := HomalgIdentityMatrix( 1, 1, R );
        M!.PrimaryDecomposition := [ [ one, one ] ];
        return M!.PrimaryDecomposition;
    fi;
    
    RP := homalgTable( R );
    
    if IsBound( RP!.PrimaryDecomposition ) then
        M!.PrimaryDecomposition := RP!.PrimaryDecomposition( M );
        return M!.PrimaryDecomposition;
    fi;
    
    if not IsHomalgInternalRingRep( R ) then
        Error( "could not find a procedure called PrimaryDecomposition ",
               "in the homalgTable of the non-internal ring\n" );
    fi;
    
    TryNextMethod( );
    
end );

##
InstallMethod( PrimaryDecompositionOp,
        "for a homalg matrix over a residue class ring",
        [ IsHomalgResidueClassMatrixRep ],
        
  function( M )
    local R;
    
    R := HomalgRing( M );
    
    return List( PrimaryDecompositionOp( Eval( M ) ), a -> List( a, b -> R * b ) );
    
end );

##
InstallMethod( RadicalDecompositionOp,
        "for a homalg matrix",
        [ IsHomalgMatrix ],
        
  function( M )
    local R, RP, one;
    
    if IsBound( M!.RadicalDecomposition ) then
        return M!.RadicalDecomposition;
    fi;
    
    R := HomalgRing( M );
    
    if IsZero( M ) then
        one := HomalgIdentityMatrix( 1, 1, R );
        M!.RadicalDecomposition := [ one ];
        return M!.RadicalDecomposition;
    fi;
    
    RP := homalgTable( R );
    
    if IsBound( RP!.RadicalDecomposition ) then
        M!.RadicalDecomposition := RP!.RadicalDecomposition( M );
        return M!.RadicalDecomposition;
    fi;
    
    if not IsHomalgInternalRingRep( R ) then
        Error( "could not find a procedure called RadicalDecomposition ",
               "in the homalgTable of the non-internal ring\n" );
    fi;
    
    TryNextMethod( );
    
end );

##
InstallMethod( RadicalDecompositionOp,
        "for a homalg matrix over a residue class ring",
        [ IsHomalgResidueClassMatrixRep ],
        
  function( M )
    local R;
    
    R := HomalgRing( M );
    
    return List( RadicalDecompositionOp( Eval( M ) ), a -> R * a );
    
end );

##
InstallMethod( IntersectWithSubalgebra,
        "for ideals",
        [ IsFinitelyPresentedSubmoduleRep and ConstructedAsAnIdeal, IsList ],
        
  function( I, var )
    local R, indets, J, S;
    
    R := HomalgRing( I );
    
    if not ( HasIsFreePolynomialRing( R ) and IsFreePolynomialRing( R ) ) then
        TryNextMethod( );
    fi;
    
    indets := Indeterminates( R );
    
    if not IsSubset( indets, var ) then
        Error( "expecting the second argument ", var,
               " to be a subset of the set of indeterminates ", indets, "\n" );
    fi;
    
    J := Eliminate( I, Difference( indets, var ) );
    
    S := CoefficientsRing( R ) * var;
    
    return S * J;
    
end );

##
InstallMethod( MaximalIndependentSet,
        "for ideals",
        [ IsFinitelyPresentedSubmoduleRep and ConstructedAsAnIdeal ],
        
  function( I )
    local R, indets, d, combinations, u;
    
    R := HomalgRing( I );
    
    indets := Indeterminates( R );
    
    if IsZero( I ) then
        return indets;
    fi;
    
    d := AffineDimension( I );
    
    if d = 0 then
        return [ ];
    fi;
    
    combinations := Combinations( indets, d );
    
    for u in combinations do
        if IsZero( IntersectWithSubalgebra( I, u ) ) then
            return u;
        fi;
    od;
    
    Error( "oh, no maximal independent set found, this is a bug!\n" );
    
end );
