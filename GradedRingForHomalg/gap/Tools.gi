#############################################################################
##
##  Tools.gi                                     GradedRingForHomalg package
##
##  Copyright 2009-2011, Mohamed Barakat, University of Kaiserslautern
##                       Markus Lange-Hegermann, RWTH-Aachen University
##
##  Implementations for tools for matrices over graded rings.
##
#############################################################################

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
            
        fi;
        
    elif Length( set_weights ) = 2 and 0 in set_weights and
      ForAll( set_weights, a -> a in Rationals ) then
        
        weight := Filtered( set_weights, a -> a <> 0 )[1];
        
        weights := List( weights, a -> AbsInt( SignInt( a ) ) );
        
        if IsBound(RP!.WeightedDegreeOfRingElement) then
            return r -> weight * RP!.WeightedDegreeOfRingElement( r, weights, R );
        fi;
        
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
        
    elif Length( set_weights ) = 1 and set_weights[1] in Rationals then
        
        weight := set_weights[1];
        
        if IsBound(RP!.DegreesOfEntries) then
            return C -> weight * RP!.DegreesOfEntries( C );
        fi;
        
    elif Length( set_weights ) = 2 and 0 in set_weights and
      ForAll( set_weights, a -> a in Rationals ) then
        
        weight := Filtered( set_weights, a -> a <> 0 )[1];
        
        weights := List( weights, a -> AbsInt( SignInt( a ) ) );
        
        if IsBound(RP!.WeightedDegreesOfEntries) then
            return C -> weight * RP!.WeightedDegreesOfEntries( C, weights );
        fi;
        
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
        
        return ListToListList( e, NrRows( C ), NrColumns( C ) );
        
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
    
    if Length( set_weights ) = 1 and set_weights[1] in Rationals then
        
        weight := set_weights[1];
        
        if IsBound( RP!.NonTrivialDegreePerRowWithColPosition ) then
            
            return
              function( C )
                local e;
                e := RP!.NonTrivialDegreePerRowWithColPosition( C );
                SetPositionOfFirstNonZeroEntryPerRow( C, e[2] );
                return weight * e[1];	## e might be immutable
            end;
            
        fi;
        
    elif Length( set_weights ) = 2 and 0 in set_weights and
      ForAll( set_weights, a -> a in Rationals ) then
        
        weight := Filtered( set_weights, a -> a <> 0 )[1];
        
        weights := List( weights, a -> AbsInt( SignInt( a ) ) );
        
        if IsBound( RP!.NonTrivialWeightedDegreePerRowWithColPosition ) then
            
            return
              function( C )
                local e;
                e := RP!.NonTrivialWeightedDegreePerRowWithColPosition( C, weights );
                SetPositionOfFirstNonZeroEntryPerRow( C, e[2] );
                return weight * e[1];	## e might be immutable
            end;
            
        fi;
        
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
          List( [ 1 .. NrRows( C ) ],
                function( r )
                  if e[r] = 0 then
                      return deg0;
                  fi;
                  return deg_func(
                                 MatElm( C, r, e[r] )
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
    
    if Length( set_weights ) = 1 and set_weights[1] in Rationals then
        
        weight := set_weights[1];
        
        if IsBound( RP!.NonTrivialDegreePerColumnWithRowPosition ) then
            
            return
              function( C )
                local e;
                e := RP!.NonTrivialDegreePerColumnWithRowPosition( C );
                SetPositionOfFirstNonZeroEntryPerColumn( C, e[2] );
                return weight * e[1];	## e might be immutable
            end;
            
        fi;
        
    elif Length( set_weights ) = 2 and 0 in set_weights and
      ForAll( set_weights, a -> a in Rationals ) then
        
        weight := Filtered( set_weights, a -> a <> 0 )[1];
        
        weights := List( weights, a -> AbsInt( SignInt( a ) ) );
        
        if IsBound( RP!.NonTrivialWeightedDegreePerColumnWithRowPosition ) then
            
            return
              function( C )
                local e;
                e := RP!.NonTrivialWeightedDegreePerColumnWithRowPosition( C, weights );
                SetPositionOfFirstNonZeroEntryPerColumn( C, e[2] );
                return weight * e[1];	## e might be immutable
            end;
            
        fi;
        
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
          List( [ 1 .. NrColumns( C ) ],
                function( c )
                  if e[c] = 0 then
                      return deg0;
                  fi;
                  return deg_func(
                                 MatElm( C, e[c], c )
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
    
    ColoredInfoForService( "busy", "LinearSyzygiesGeneratorsOfRows", NrRows( M ), " x ", NrColumns( M ) );
    
    if IsBound(RP!.LinearSyzygiesGeneratorsOfRows) then
        
        C := RP!.LinearSyzygiesGeneratorsOfRows( M );
        
        if IsZero( C ) then
            
            C := HomalgZeroMatrix( 0, NrRows( M ), R );	## most of the computer algebra systems cannot handle degenerated matrices
            
        else
            
            SetNrColumns( C, NrRows( M ) );
            
        fi;
        
        M!.LinearSyzygiesGeneratorsOfRows := C;
        
        ColoredInfoForService( t, "LinearSyzygiesGeneratorsOfRows", NrRows( C ) );
        
        IncreaseRingStatistics( R, "LinearSyzygiesGeneratorsOfRows" );
        
        return C;
        
    elif IsBound(RP!.LinearSyzygiesGeneratorsOfColumns) then
        
        C := Involution( RP!.LinearSyzygiesGeneratorsOfColumns( Involution( M ) ) );
        
        if IsZero( C ) then
            
            C := HomalgZeroMatrix( 0, NrRows( M ), R );	## most of the computer algebra systems cannot handle degenerated matrices
            
        else
            
            SetNrColumns( C, NrRows( M ) );
            
        fi;
        
        M!.LinearSyzygiesGeneratorsOfRows := C;
        
        ColoredInfoForService( t, "LinearSyzygiesGeneratorsOfRows", NrRows( C ) );
        
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
        
        C := HomalgZeroMatrix( 0, NrRows( M ), R );
        
    fi;
    
    M!.LinearSyzygiesGeneratorsOfRows := C;
    
    ColoredInfoForService( t, "LinearSyzygiesGeneratorsOfRows", NrRows( C ) );
    
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
    
    ColoredInfoForService( "busy", "LinearSyzygiesGeneratorsOfColumns", NrRows( M ), " x ", NrColumns( M ) );
    
    if IsBound(RP!.LinearSyzygiesGeneratorsOfColumns) then
        
        C := RP!.LinearSyzygiesGeneratorsOfColumns( M );
        
        if IsZero( C ) then
            
            C := HomalgZeroMatrix( NrColumns( M ), 0, R );
            
        else
            
            SetNrRows( C, NrColumns( M ) );
            
        fi;
        
        M!.LinearSyzygiesGeneratorsOfColumns := C;
        
        ColoredInfoForService( t, "LinearSyzygiesGeneratorsOfColumns", NrColumns( C ) );
        
        IncreaseRingStatistics( R, "LinearSyzygiesGeneratorsOfColumns" );
        
        return C;
        
    elif IsBound(RP!.LinearSyzygiesGeneratorsOfRows) then
        
        C := Involution( RP!.LinearSyzygiesGeneratorsOfRows( Involution( M ) ) );
        
        if IsZero( C ) then
            
            C := HomalgZeroMatrix( NrColumns( M ), 0, R );
            
        else
            
            SetNrRows( C, NrColumns( M ) );
            
        fi;
        
        M!.LinearSyzygiesGeneratorsOfColumns := C;
        
        ColoredInfoForService( t, "LinearSyzygiesGeneratorsOfColumns", NrColumns( C ) );
        
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
        
        C := HomalgZeroMatrix( NrColumns( M ), 0, R );
        
    fi;
    
    M!.LinearSyzygiesGeneratorsOfColumns := C;
    
    ColoredInfoForService( t, "LinearSyzygiesGeneratorsOfColumns", NrColumns( C ) );
    
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
    
    if not NrColumns( M ) = 1 then
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
    
    if not NrColumns( M ) = 1 then
        Error( "the number of columns must be one\n" );
    fi;
    
    S := HomalgRing( M );
    
    B := BaseRing( UnderlyingNonGradedRing( S ) );
    
    ## only the rows with degree 0
    M := CertainRows( M, Positions( DegreesOfEntries( M ), [ 0 ] ) );
    
    return B * M;
    
end );
