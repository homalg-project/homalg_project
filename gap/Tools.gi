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
InstallMethod( CoefficientsOfUnreducedNumeratorOfHilbertPoincareSeries,
        "for a homalg matrix and two lists",
        [ IsHomalgMatrix, IsList, IsList ],
        
  function( M, weights, degrees )
    local c, save, R, RP, t, free, hilb, l, ldeg;
    
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
        
        if IsZero( M ) then
            ## take care of zero matrices, especially of 0 x n matrices
            free := HomalgZeroMatrix( 1, NrColumns( M ), R );
            hilb := RP!.CoefficientsOfUnreducedNumeratorOfWeightedHilbertPoincareSeries( free, weights, degrees );
        else
            hilb := RP!.CoefficientsOfUnreducedNumeratorOfWeightedHilbertPoincareSeries( M, weights, degrees );
        fi;
        
        l := Length( hilb ) - 1;
        
        ldeg := hilb[l + 1];
        
        hilb := hilb{[ 1 .. l ]};
        
        save.(c) := [ hilb, [ ldeg .. l + ldeg - 1 ] ];
        
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
        
        s := HOMALG_MODULES.variable_for_Hilbert_polynomial;
        
        hilb := HilbertPoincareSeries( M, weights, degrees, s );
        
        ## for CASs which do not support Hilbert* for non-graded modules
        d := AffineDimension( M, weights, degrees );
        
        hilb := CoefficientsOfLaurentPolynomial( ( 1 - s )^d * hilb );
        
        save.(c) := [ hilb[1], [ hilb[2] .. Length( hilb[1] ) + hilb[2] - 1 ] ];
        
        return save.(c);
        
    fi;
    
    if not IsHomalgInternalRingRep( R ) then
        Error( "could not find a procedure called CoefficientsOfNumeratorOfWeightedHilbertPoincareSeries ",
               "in the homalgTable of the non-internal ring\n" );
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
        
        lowest_coeff := function( f );
            return First( CoefficientsOfUnivariatePolynomial( f ), a -> not IsZero( a ) );
        end;
        
        lowest_coeff := lowest_coeff( DenominatorOfRationalFunction( hilb ) );
        
        if not lowest_coeff in [ 1, -1 ] then
            Error( "expected the lowest coefficient of the denominator of the Hilbert-Poincare series to be 1 or -1 but received ", lowest_coeff, "\n" );
        fi;
        
        hilb := NumeratorOfRationalFunction( hilb ) / lowest_coeff;
        
        return CoefficientsOfUnivariatePolynomial( hilb );
        
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
    
    return UnreducedNumeratorOfHilbertPoincareSeries( M, weights, degrees, HOMALG_MODULES.variable_for_Hilbert_polynomial );
    
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
    
    return UnreducedNumeratorOfHilbertPoincareSeries( M, HOMALG_MODULES.variable_for_Hilbert_polynomial );
    
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
    
    return NumeratorOfHilbertPoincareSeries( M, weights, degrees, HOMALG_MODULES.variable_for_Hilbert_polynomial );
    
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
    
    return NumeratorOfHilbertPoincareSeries( M, HOMALG_MODULES.variable_for_Hilbert_polynomial );
    
end );

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
    
    return HilbertPoincareSeries( M, weights, degrees, HOMALG_MODULES.variable_for_Hilbert_polynomial );
    
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
    
    return HilbertPoincareSeries( M, HOMALG_MODULES.variable_for_Hilbert_polynomial );
    
end );

##
InstallMethod( HilbertPolynomial,
        "for a homalg matrix, two lists, and a ring element",
        [ IsHomalgMatrix, IsList, IsList, IsRingElement ],
        
  function( M, weights, degrees, lambda )
    local R, RP, t, d, binomial, hilb, range;
    
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
        
        ## for CASs which do not support Hilbert* for non-graded modules
        d := AffineDimension( M, weights, degrees );
        
        if d <= 0 then
            return 0 * lambda;
        fi;
        
        binomial :=
          function( a, b )
            
            if b = 0 then
                return 1;
            elif b = 1 then
                return a;
            fi;
            
            return Product( [ 0 .. b - 1 ], i -> a - i ) / Factorial( b );
            
        end;
        
        hilb := CoefficientsOfNumeratorOfHilbertPoincareSeries( M, weights, degrees );
        
        range := hilb[2];
        hilb := hilb[1];
        
        hilb := Sum( [ 1 .. Length( range ) ], i -> hilb[i] * binomial( d - 1 + lambda - range[i], d - 1 ) );
        
        return hilb + 0 * lambda;
        
    fi;
    
    if not IsHomalgInternalRingRep( R ) then
        Error( "could not find a procedure called CoefficientsOfHilbertPolynomial ",
               "in the homalgTable of the non-internal ring\n" );
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
    
    return HilbertPolynomial( M, weights, degrees, HOMALG_MODULES.variable_for_Hilbert_polynomial );
    
end );

##
InstallMethod( HilbertPolynomial,
        "for a homalg matrix and a ring element",
        [ IsHomalgMatrix, IsRingElement ],
        
  function( M, lambda )
    local R, RP, free, hilb, d, binomial;
    
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
        
        d := AffineDimension( M );
        
        if d <= 0 then
            return 0 * lambda;
        fi;
        
        binomial :=
          function( a, b )
            
            if b = 0 then
                return 1;
            elif b = 1 then
                return a;
            fi;
            
            return Product( [ 0 .. b - 1 ], i -> a - i ) / Factorial( b );
            
        end;
        
        hilb := CoefficientsOfNumeratorOfHilbertPoincareSeries( M );
        
        hilb := Sum( [ 0 .. Length( hilb ) - 1 ], k -> hilb[k+1] * binomial( d - 1 + lambda - k, d - 1 ) );
        
        return hilb + 0 * lambda;
        
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
    
    return HilbertPolynomial( M, HOMALG_MODULES.variable_for_Hilbert_polynomial );
    
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
        
        if IsZero( hilb ) then
            SetAffineDimension( M, HOMALG_MODULES.DimensionOfZeroModules );
            return AffineDimension( M );
        fi;
        
        d := Degree( DenominatorOfRationalFunction( hilb ) );
        
        ## we compute this to figure out the lower-degree
        ## of the unreduced numerator of the Hilbert-Poincaré series
        hilb := CoefficientsOfUnreducedNumeratorOfHilbertPoincareSeries( M, weights, degrees );
        
        d := d + hilb[2][1];
        
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
