# SPDX-License-Identifier: GPL-2.0-or-later
# GradedRingForHomalg: Endow Commutative Rings with an Abelian Grading
#
# Implementations
#

####################################
#
# methods for operations:
#
####################################

##
InstallMethod( DegreeOfRingElementFunction,
        "for homalg rings",
        [ IsHomalgRing, IsList ],
        
  function( R, weights )
    local RP, set_weights, weight;
    
    RP := homalgTable( R );
    
    set_weights := Set( weights );
    
    if set_weights = [ 1 ] then
        
        if IsBound(RP!.DegreeOfRingElement) then
            
            return r -> RP!.DegreeOfRingElement( r, R );
            
        fi;
        
    elif Length( set_weights ) = 1 and set_weights[1] in Rationals then
        
        weight := set_weights[1];
        
        if weight <> 0 and IsBound(RP!.DegreeOfRingElement) then
            
            return r -> weight * RP!.DegreeOfRingElement( r, R );
            
        elif weight = 0 then
            
            return
              function( r )
                if r = 0 then
                    return HOMALG_TOOLS.minus_infinity;
                fi;
                
                return 0;
            end;
            
        fi;
        
    elif Length( set_weights ) = 2 and 0 in set_weights and
      ForAll( set_weights, a -> a in Rationals ) and
      IsBound(RP!.WeightedDegreeOfRingElement) then
        
        weight := Filtered( set_weights, a -> a <> 0 )[1];
        
        weights := List( weights, a -> AbsInt( SignInt( a ) ) );
        
        return r -> weight * RP!.WeightedDegreeOfRingElement( r, weights, R );
        
    elif weights = [ ] then
        
        if IsBound(RP!.DegreeOfRingElement) and not IsHomalgExternalRingInMAGMARep( R ) then
            return r -> RP!.DegreeOfRingElement( r, R );
        fi;
        
        return function( r ) if IsZero( r ) then return -1; else return 0; fi; end;
        
    else
        
        if IsBound(RP!.WeightedDegreeOfRingElement) then
            
            return r -> RP!.MultiWeightedDegreeOfRingElement( r, weights, R );
            
        fi;
        
    fi;
    
    ## there is no fallback method
    
    TryNextMethod( );
    
end );

##
InstallMethod( DegreeOfRingElementFunction,
        "for a homalg ring and a homalg matrix (of weights)",
        [ IsHomalgRing, IsHomalgMatrix ],
        
  function( R, weights )
    local RP;
    
    RP := homalgTable( R );
    
    if not IsIdenticalObj( HomalgRing( weights ), HomalgRing( R ) ) then
        Error( "the matrix of weights is defined over a different ring\n" );
    fi;
    
    return r -> RP!.MultiWeightedDegreeOfRingElement( r, weights, R );
    
end );

##
InstallMethod( DegreeOfRingElementFunction,
        "for homalg residue class rings",
        [ IsHomalgResidueClassRingRep, IsList ],
        
  function( R, weights )
    local A, deg_func;
    
    A := AmbientRing( R );
    
    deg_func := DegreeOfRingElementFunction( A, weights );
    
    return
      function( r )
        if r = 0 then
            return deg_func( Zero( A ) );
        fi;
        
        return deg_func( EvalRingElement( r ) );
        
    end;
    
end );

##
InstallMethod( DegreesOfEntriesFunction,
        "for homalg rings",
        [ IsHomalgRing, IsList ],
        
  function( R, weights )
    local RP, set_weights, weight, deg_func;
    
    RP := homalgTable( R );
    
    set_weights := Set( weights );
    
    if set_weights = [ 1 ] then
        
        if IsBound(RP!.DegreesOfEntries) then
            return C -> RP!.DegreesOfEntries( C );
        fi;
        
    elif Length( set_weights ) = 1 and set_weights[1] in Rationals
      and IsBound(RP!.DegreesOfEntries) then
        
        weight := set_weights[1];
        
        return C -> weight * RP!.DegreesOfEntries( C );
        
    elif Length( set_weights ) = 2 and 0 in set_weights and
      ForAll( set_weights, a -> a in Rationals ) and
      IsBound(RP!.WeightedDegreesOfEntries) then
        
        weight := Filtered( set_weights, a -> a <> 0 )[1];
        
        weights := List( weights, a -> AbsInt( SignInt( a ) ) );
        
        return C -> weight * RP!.WeightedDegreesOfEntries( C, weights );
        
    else
        
        if weights = [ ] then
            if IsBound(RP!.MultiWeightedDegreesOfEntries) then
                return C -> RP!.MultiWeightedDegreesOfEntries( C, [ 1 ] );
            fi;
        elif IsList( weights[1] ) then
            if IsBound(RP!.MultiWeightedDegreesOfEntries) then
                return C -> RP!.MultiWeightedDegreesOfEntries( C, weights );
            fi;
        elif IsBound(RP!.WeightedDegreesOfEntries) then
            return C -> RP!.WeightedDegreesOfEntries( C, weights );
        fi;
        
    fi;
    
    #=====# the fallback method #=====#
    
    deg_func := DegreeOfRingElementFunction( R, weights );
    
    return
      function( C )
        local e;
        
        e := EntriesOfHomalgMatrix( C );
        
        e := List( e, deg_func );
        
        return ListToListList( e, NumberRows( C ), NumberColumns( C ) );
        
    end;
    
end );


##
InstallMethod( DegreesOfEntriesFunction,
        "for homalg rings",
        [ IsHomalgRing, IsHomalgMatrix ],
        
  function( R, weights )
    local RP, degree_func;
    
    RP := homalgTable( R );
    
    if IsBound( RP!.MultiWeightedDegreesOfEntries ) then
        
        return r -> RP!.MultiWeightedDegreesOfEntries( r, weights, R );
        
    elif IsBound( RP!.MultiWeightedDegreeOfRingElement ) then
        
        degree_func := RP!.MultiWeightedDegreeOfRingElement;
        
        return function( M )
          local weight_list;
            
            weight_list := EntriesOfHomalgMatrixAsListList( M );
            
            Apply( weight_list, i -> List( i, j -> degree_func( j, weights, R ) ) );
            
            return weight_list;
            
        end;
        
    else
        
        Error( "not implemented" );
        
    fi;
    
end );


##
InstallMethod( NonTrivialDegreePerRowWithColPositionFunction,
        "for homalg rings",
        [ IsHomalgRing, IsList, IsObject, IsObject ],
        
  function( R, weights, deg0, deg1 )
    local RP, set_weights, weight, deg_func;
    
    RP := homalgTable( R );
    
    set_weights := Set( weights );

    if Length( set_weights ) = 1 and set_weights[1] in Rationals and
       IsBound( RP!.NonTrivialDegreePerRowWithColPosition ) then
        
        weight := set_weights[1];
        
        return
          function( C )
            local e;
            e := RP!.NonTrivialDegreePerRowWithColPosition( C );
            SetPositionOfFirstNonZeroEntryPerRow( C, e[2] );
            return weight * e[1]; ## e might be immutable
        end;
        
    elif Length( set_weights ) = 2 and 0 in set_weights and
      ForAll( set_weights, a -> a in Rationals ) and
      IsBound( RP!.NonTrivialWeightedDegreePerRowWithColPosition ) then
        
        weight := Filtered( set_weights, a -> a <> 0 )[1];
        
        weights := List( weights, a -> AbsInt( SignInt( a ) ) );
        
        return
          function( C )
            local e;
            e := RP!.NonTrivialWeightedDegreePerRowWithColPosition( C, weights );
            SetPositionOfFirstNonZeroEntryPerRow( C, e[2] );
            return weight * e[1]; ## e might be immutable
        end;
        
    elif weights = [ ] then
        
        return
          function( C )
            local e;
            
            e := PositionOfFirstNonZeroEntryPerRow( C );
            
            return List( e, function( c ) if c = 0 then return deg0; fi; return deg1; end );
        end;
        
    elif IsList( weights[1] ) then
        
        if IsBound(RP!.NonTrivialMultiWeightedDegreePerRowWithColPosition) then
            
            return
              function( C )
                local e;
                e := RP!.NonTrivialMultiWeightedDegreePerRowWithColPosition( C, weights );
                SetPositionOfFirstNonZeroEntryPerRow( C, e[2] );
                return e[1];
            end;
            
        fi;
        
    elif IsBound(RP!.NonTrivialWeightedDegreePerRowWithColPosition) then
        
        return
          function( C )
            local e;
            e := RP!.NonTrivialWeightedDegreePerRowWithColPosition( C, weights );
            SetPositionOfFirstNonZeroEntryPerRow( C, e[2] );
            return e[1];
        end;
        
    fi;
    
    #=====# the fallback method #=====#
    
    deg_func := DegreeOfRingElementFunction( R, weights );
    
    return
      function( C )
        local e;
        
        e := PositionOfFirstNonZeroEntryPerRow( C );
        
        return
          List( [ 1 .. NumberRows( C ) ],
                function( r )
                  if e[r] = 0 then
                      return deg0;
                  fi;
                  return deg_func(
                                 C[ r, e[r] ]
                                 );
                end );
                
      end;
    
end );

##
InstallMethod( NonTrivialDegreePerColumnWithRowPositionFunction,
        "for homalg rings",
        [ IsHomalgRing, IsList, IsObject, IsObject ],
        
  function( R, weights, deg0, deg1 )
    local RP, set_weights, weight, deg_func;
    
    RP := homalgTable( R );
    
    set_weights := Set( weights );
    
    if Length( set_weights ) = 1 and set_weights[1] in Rationals
       and IsBound( RP!.NonTrivialDegreePerColumnWithRowPosition ) then
        
        weight := set_weights[1];
        
        return
          function( C )
            local e;
            e := RP!.NonTrivialDegreePerColumnWithRowPosition( C );
            SetPositionOfFirstNonZeroEntryPerColumn( C, e[2] );
            return weight * e[1]; ## e might be immutable
        end;
        
    elif Length( set_weights ) = 2 and 0 in set_weights and
      ForAll( set_weights, a -> a in Rationals ) and
      IsBound( RP!.NonTrivialWeightedDegreePerColumnWithRowPosition ) then
        
        weight := Filtered( set_weights, a -> a <> 0 )[1];
        
        weights := List( weights, a -> AbsInt( SignInt( a ) ) );
        
        return
          function( C )
            local e;
            e := RP!.NonTrivialWeightedDegreePerColumnWithRowPosition( C, weights );
            SetPositionOfFirstNonZeroEntryPerColumn( C, e[2] );
            return weight * e[1]; ## e might be immutable
        end;
            
    elif weights = [ ] then
        
        return
          function( C )
            local e;
            
            e := PositionOfFirstNonZeroEntryPerColumn( C );
            
            return List( e, function( r ) if r = 0 then return deg0; fi; return deg1; end );
        end;
        
    elif IsList( weights[1] ) then
        
        if IsBound(RP!.NonTrivialMultiWeightedDegreePerColumnWithRowPosition) then
            
            return
              function( C )
                local e;
                e := RP!.NonTrivialMultiWeightedDegreePerColumnWithRowPosition( C, weights );
                SetPositionOfFirstNonZeroEntryPerColumn( C, e[2] );
                return e[1];
            end;
            
        fi;
        
    elif IsBound(RP!.NonTrivialWeightedDegreePerColumnWithRowPosition) then
        
        return
          function( C )
            local e;
            e := RP!.NonTrivialWeightedDegreePerColumnWithRowPosition( C, weights );
            SetPositionOfFirstNonZeroEntryPerColumn( C, e[2] );
            return e[1];
        end;
        
    fi;
    
    #=====# the fallback method #=====#
    
    deg_func := DegreeOfRingElementFunction( R, weights );
    
    return
      function( C )
        local e;
        
        e := PositionOfFirstNonZeroEntryPerColumn( C );
        
        return
          List( [ 1 .. NumberColumns( C ) ],
                function( c )
                  if e[c] = 0 then
                      return deg0;
                  fi;
                  return deg_func(
                                 C[ e[c], c ]
                                 );
                end );
                
      end;
    
end );

##
InstallMethod( LinearSyzygiesGeneratorsOfRows,
        "for matrices over graded rings",
        [ IsMatrixOverGradedRing ],
        
  function( M )
    local R, RP, t, C, degs, deg;
    
    if IsBound(M!.LinearSyzygiesGeneratorsOfRows) then
        return M!.LinearSyzygiesGeneratorsOfRows;
    fi;
    
    R := HomalgRing( M );
    
    RP := homalgTable( R );
    
    t := homalgTotalRuntimes( );
    
    ColoredInfoForService( "busy", "LinearSyzygiesGeneratorsOfRows", NumberRows( M ), " x ", NumberColumns( M ) );
    
    if IsBound(RP!.LinearSyzygiesGeneratorsOfRows) then
        
        C := RP!.LinearSyzygiesGeneratorsOfRows( M );
        
        if IsZero( C ) then
            
            C := HomalgZeroMatrix( 0, NumberRows( M ), R ); ## most of the computer algebra systems cannot handle degenerated matrices
            
        else
            
            SetNumberColumns( C, NumberRows( M ) );
            
        fi;
        
        M!.LinearSyzygiesGeneratorsOfRows := C;
        
        ColoredInfoForService( t, "LinearSyzygiesGeneratorsOfRows", NumberRows( C ) );
        
        IncreaseRingStatistics( R, "LinearSyzygiesGeneratorsOfRows" );
        
        return C;
        
    elif IsBound(RP!.LinearSyzygiesGeneratorsOfColumns) then
        
        C := Involution( RP!.LinearSyzygiesGeneratorsOfColumns( Involution( M ) ) );
        
        if IsZero( C ) then
            
            C := HomalgZeroMatrix( 0, NumberRows( M ), R ); ## most of the computer algebra systems cannot handle degenerated matrices
            
        else
            
            SetNumberColumns( C, NumberRows( M ) );
            
        fi;
        
        M!.LinearSyzygiesGeneratorsOfRows := C;
        
        ColoredInfoForService( t, "LinearSyzygiesGeneratorsOfRows", NumberRows( C ) );
        
        DecreaseRingStatistics( R, "LinearSyzygiesGeneratorsOfRows" );
        
        IncreaseRingStatistics( R, "LinearSyzygiesGeneratorsOfColumns" );
        
        return C;
        
    fi;
    
    #=====# begin of the core procedure #=====#
    
    C := SyzygiesGeneratorsOfRows( M );
    
    degs := NonTrivialDegreePerRow( C );
    
    deg := CommonNonTrivialWeightOfIndeterminates( R );
    
    C := CertainRows( C, Filtered( [ 1 .. Length( degs ) ], r -> degs[r] = deg ) );
    
    if IsZero( C ) then
        
        C := HomalgZeroMatrix( 0, NumberRows( M ), R );
        
    fi;
    
    M!.LinearSyzygiesGeneratorsOfRows := C;
    
    ColoredInfoForService( t, "LinearSyzygiesGeneratorsOfRows", NumberRows( C ) );
    
    IncreaseRingStatistics( R, "LinearSyzygiesGeneratorsOfRows" );
    
    return C;
    
end );

##
InstallMethod( LinearSyzygiesGeneratorsOfColumns,
        "for matrices over graded rings",
        [ IsMatrixOverGradedRing ],
        
  function( M )
    local R, RP, t, C, degs, deg;
    
    if IsBound(M!.LinearSyzygiesGeneratorsOfColumns) then
        return M!.LinearSyzygiesGeneratorsOfColumns;
    fi;
    
    R := HomalgRing( M );
    
    RP := homalgTable( R );
    
    t := homalgTotalRuntimes( );
    
    ColoredInfoForService( "busy", "LinearSyzygiesGeneratorsOfColumns", NumberRows( M ), " x ", NumberColumns( M ) );
    
    if IsBound(RP!.LinearSyzygiesGeneratorsOfColumns) then
        
        C := RP!.LinearSyzygiesGeneratorsOfColumns( M );
        
        if IsZero( C ) then
            
            C := HomalgZeroMatrix( NumberColumns( M ), 0, R );
            
        else
            
            SetNumberRows( C, NumberColumns( M ) );
            
        fi;
        
        M!.LinearSyzygiesGeneratorsOfColumns := C;
        
        ColoredInfoForService( t, "LinearSyzygiesGeneratorsOfColumns", NumberColumns( C ) );
        
        IncreaseRingStatistics( R, "LinearSyzygiesGeneratorsOfColumns" );
        
        return C;
        
    elif IsBound(RP!.LinearSyzygiesGeneratorsOfRows) then
        
        C := Involution( RP!.LinearSyzygiesGeneratorsOfRows( Involution( M ) ) );
        
        if IsZero( C ) then
            
            C := HomalgZeroMatrix( NumberColumns( M ), 0, R );
            
        else
            
            SetNumberRows( C, NumberColumns( M ) );
            
        fi;
        
        M!.LinearSyzygiesGeneratorsOfColumns := C;
        
        ColoredInfoForService( t, "LinearSyzygiesGeneratorsOfColumns", NumberColumns( C ) );
        
        DecreaseRingStatistics( R, "LinearSyzygiesGeneratorsOfColumns" );
        
        IncreaseRingStatistics( R, "LinearSyzygiesGeneratorsOfRows" );
        
        return C;
        
    fi;
    
    #=====# begin of the core procedure #=====#
    
    C := SyzygiesGeneratorsOfColumns( M );
    
    degs := NonTrivialDegreePerColumn( C );
    
    deg := CommonNonTrivialWeightOfIndeterminates( R );
    
    C := CertainColumns( C, Filtered( [ 1 .. Length( degs ) ], c -> degs[c] = deg ) );
    
    if IsZero( C ) then
        
        C := HomalgZeroMatrix( NumberColumns( M ), 0, R );
        
    fi;
    
    M!.LinearSyzygiesGeneratorsOfColumns := C;
    
    ColoredInfoForService( t, "LinearSyzygiesGeneratorsOfColumns", NumberColumns( C ) );
    
    IncreaseRingStatistics( R, "LinearSyzygiesGeneratorsOfColumns" );
    
    return C;
    
end );

##  <#GAPDoc Label="Diff">
##  <ManSection>
##    <Oper Arg="D, N" Name="Diff"/>
##    <Returns>a &homalg; matrix</Returns>
##    <Description>
##      If <A>D</A> is a <M>f \times p</M>-matrix and <A>N</A> is a <M>g \times q</M>-matrix then
##      <M>H=Diff(</M><A>D</A>,<A>N</A><M>)</M> is an <M>fg \times pq</M>-matrix whose entry
##      <M>H[g*(i-1)+j,q*(k-1)+l]</M> is the result of differentiating <A>N</A><M>[j,l]</M>
##      by the differential operator corresponding to <A>D</A><M>[i,k]</M>. (Here we follow
##      the Macaulay2 convention.)
##      <Example><![CDATA[
##  gap> S := HomalgFieldOfRationalsInDefaultCAS( ) * "a,b,c" * "x,y,z";;
##  gap> D := HomalgMatrix( "[ \
##  > x,2*y,   \
##  > y,a-b^2, \
##  > z,y-b    \
##  > ]", 3, 2, S );
##  <A 3 x 2 matrix over an external ring>
##  gap> N := HomalgMatrix( "[ \
##  > x^2-a*y^3,x^3-z^2*y,x*y-b,x*z-c, \
##  > x,        x*y,      a-b,  x*a*b  \
##  > ]", 2, 4, S );
##  <A 2 x 4 matrix over an external ring>
##  gap> H := Diff( D, N );
##  <A 6 x 8 matrix over an external ring>
##  gap> Display( H );
##  2*x,     3*x^2, y,z,  -6*a*y^2,-2*z^2,2*x,0,  
##  1,       y,     0,a*b,0,       2*x,   0,  0,  
##  -3*a*y^2,-z^2,  x,0,  -y^3,    0,     0,  0,  
##  0,       x,     0,0,  0,       0,     1,  b*x,
##  0,       -2*y*z,0,x,  -3*a*y^2,-z^2,  x+1,0,  
##  0,       0,     0,0,  0,       x,     1,  -a*x
##  ]]></Example>
##    </Description>
##  </ManSection>
##  <#/GAPDoc>

##
InstallMethod( PolynomialsWithoutRelativeIndeterminates,
        "for a homalg matrix",
        [ IsHomalgMatrix ],
        
  function( M )
    local R, B, base, var, S, weights, M_sub;
    
    if not NumberColumns( M ) = 1 then
        Error( "the number of columns must be one\n" );
    fi;
    
    ## k[b][x1,x2]
    R := HomalgRing( M );
    
    ## k[b]
    B := BaseRing( R );
    
    if IsIdenticalObj( R, B ) then
        return M;
    fi;
    
    ## [b]
    base := Indeterminates( B );
    
    ## [x1,x2]
    var := RelativeIndeterminatesOfPolynomialRing( R );
    
    ## k[b][x1,x2]
    S := GradedRing( R );
    
    ## [ 0, 1, 1 ]
    weights := Concatenation( ListWithIdenticalEntries( Length( base ), 0 ), ListWithIdenticalEntries( Length( var ), 1 ) );
    SetWeightsOfIndeterminates( S, weights );
    
    M := S * M;
    
    ## only the rows with degree 0
    M_sub := CertainRows( M, Positions( DegreesOfEntries( M ), [ 0 ] ) );
    
    return B * M_sub;
    
end );

##
InstallMethod( PolynomialsWithoutRelativeIndeterminates,
        "for a homalg matrix over a graded ring",
        [ IsMatrixOverGradedRing ],
        
  function( M )
    local S, B;
    
    if not NumberColumns( M ) = 1 then
        Error( "the number of columns must be one\n" );
    fi;
    
    S := HomalgRing( M );
    
    B := BaseRing( UnderlyingNonGradedRing( S ) );
    
    ## only the rows with degree 0
    M := CertainRows( M, Positions( DegreesOfEntries( M ), [ 0 ] ) );
    
    return B * M;
    
end );

##
InstallMethod( Coefficients,
        "for a graded ring element",
        [ IsHomalgGradedRingElement ],

  function( r )
    local S, coeffs, monoms;
    
    S := HomalgRing( r );
    
    coeffs := Coefficients( EvalRingElement( r ) );
    
    monoms := List( coeffs!.monomials, a -> a / S );
    
    coeffs := S * coeffs;
    
    coeffs!.monomials := monoms;
    
    return coeffs;
    
end );

##
InstallMethod( LaTeXOutput,
        "for homalg graded ring elements",
        [ IsHomalgGradedRingElement ],
        
  r -> LaTeXOutput( EvalRingElement( r ) )
);

##
InstallMethod( ExponentsOfGeneratorsOfToricIdeal,
        "for a list",
        [ IsList ],
        
  function( generators_of_semigroup )
    local indet_string, relations, s, R, indeterminates,
          i, left_side, right_side, j, I, J, degree;
    
    if generators_of_semigroup = [ ] then
        return [ ];
    fi;
    
    generators_of_semigroup := HomalgMatrix( generators_of_semigroup, HOMALG_MATRICES.ZZ );
    
    relations := SyzygiesOfRows( generators_of_semigroup );
    
    if NumberRows( relations ) = 0 then
        return [ ];
    fi;
    
    relations := EntriesOfHomalgMatrixAsListList( relations );
    
    if not IsBound( HOMALG_RINGS.DefaultCAS_GF2 ) then
        HOMALG_RINGS.DefaultCAS_GF2 := HomalgRingOfIntegersInDefaultCAS( 2 );
    fi;
    
    s := NumberRows( generators_of_semigroup );
    
    R := HOMALG_RINGS.DefaultCAS_GF2 * Concatenation( "t1..", String( s ) );
    
    indeterminates := Indeterminates( R );
    
    for i in [ 1 .. Length( relations ) ] do
        
        left_side := One( R );
        right_side := One( R );
        
        for j in [ 1 .. Length( indeterminates ) ] do
            
            if relations[ i ][ j ] > 0 then
                left_side := left_side * indeterminates[ j ]^relations[ i ][ j ];
            elif relations[ i ][ j ] < 0 then
                right_side := right_side * indeterminates[ j ]^( - relations[ i ][ j ] );
            fi;
            
        od;
        
        relations[ i ] := left_side - right_side;
        
    od;
    
    I := LeftSubmodule( relations );
    J := LeftSubmodule( Product( indeterminates ) );
    
    I := Saturate( I, J );
    
    OnBasisOfPresentation( I );
    
    I := MatrixOfSubobjectGenerators( I );
    
    if NumberRows( I ) = 0 then
        return [ ];
    fi;
    
    I := EntriesOfHomalgMatrix( I );
    
    I := List( I, r -> Coefficients( r )!.monomials );
    
    degree := DegreeOfRingElementFunction( R, IdentityMat( s ) );
    
    I := List( I, b -> degree( b[1] ) - degree( b[2] ) );
    
    Sort( I );
    
    return I;
    
end );
