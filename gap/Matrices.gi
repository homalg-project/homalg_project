############################################################################
##
##  Matrices.gi                SCO package                   Simon Goertzen
##
##  Copyright 2007-2008 Lehrstuhl B für Mathematik, RWTH Aachen
##
##  Implementation stuff for matrix creation.
##
#############################################################################

## this computes the boundary, which is a bit complicated because "mu" has to be taken into account.
InstallGlobalFunction( BoundaryOperator, "Arguments: i, L, mu. Calculate i-th boundary of L with the help of mu",
  function( i, L, mu)
    local n, tau, rho, j, boundary;
    boundary := ShallowCopy( L );
    n := ( Length( L ) - 1 ) / 2;
    if i < 0 or i > n then
        Error( "BoundaryOperator index i is out of bounds ([0..", n, "])! i = ", i );
    fi;
    tau := Intersection( Filtered( L, x->IsList( x ) ) );
    if i = 0 then
        boundary := L{[3..Length( L )]};
        rho := Intersection( Filtered( boundary, x->IsList( x ) ) );
    elif i = n then
        boundary := L{[1..Length( L ) - 2]};
        rho := Intersection( Filtered( boundary, x->IsList( x ) ) );
    fi;
    if i = 0 or i = n then
        for j in [2,4..Length( boundary ) - 1] do
            boundary[j] := mu( [ tau, rho, boundary[j-1], boundary[j+1] ] )( boundary[j] );
        od;
        return boundary;
    fi;
    boundary := boundary{Difference( [1..Length( boundary )],[2*i+1,2*i+2] )};
    rho := Intersection( Filtered( boundary, x->IsList( x ) ) );
    for j in [2,4..Length( boundary ) - 1] do
        if j = 2*i then
            boundary[j] := mu( [ tau, rho, L[j-1], L[j+3] ] )( L[j] * L[j+2] );
        else
            boundary[j] := mu( [ tau, rho, boundary[j-1], boundary[j+1] ] )( boundary[j] );
        fi;
    od;
    return boundary;
  end
);

##
InstallMethod( AddEntry,
        [ IsMatrix and IsMutable, IsInt, IsInt, IsObject ],
  function( M, r, c, e )
    M[r][c] := M[r][c] + e;
    return true;
  end
);

## create cohomology matrices (as a list)
InstallMethod( CreateCohomologyMatrix, "for an internal ring",
        [ IsSimplicialSet, IsInt, IsHomalgInternalRingRep ],
  function( ss, d, R )
    local S, x, matrices, RP, k, m, p, i, ind, pos, res;
    
    S := x -> SimplicialSet( ss, x );
    matrices := [];
    RP := homalgTable( R );
    
    for k in [ 1 .. d + 1 ] do
        if Length( S(k) ) = 0 then
            m := Eval( HomalgZeroMatrix( Length( S(k-1) ), 1, R ) );
            if IsMatrix( m ) then
                m := MutableCopyMat( m );
            fi;
            matrices[k] := m;
        else
            m := Eval( HomalgZeroMatrix( Length( S(k-1) ), Length( S(k) ), R ) );
            if IsMatrix( m ) then
                m := MutableCopyMat( m );
            fi;
            matrices[k] := m;
            for p in [ 1 .. Length( S(k) ) ] do #column iterator
                for i in [ 0 .. k ] do #row iterator
                    ind := PositionSet( S(k-1), BoundaryOperator( i, S(k)[p], ss!.orbifold_triangulation!.mu ) );
                    if not ind = fail then
                        AddEntry( matrices[k], ind, p, MinusOne( R )^i );
                    fi;
                od;
            od;
        fi;
    od;
    
    # wrap the matrices into HomalgMatrices
    return List( matrices,
      function( m )
        local s;
        s := HomalgVoidMatrix( R );
        SetEval( s, m );
        ResetFilterObj( s, IsVoidMatrix);
        return s;
      end );

  end
);

## homology matrices are the transpose of cohomology matrices
InstallMethod( CreateHomologyMatrix, "for any ring",
        [ IsSimplicialSet, IsInt, IsHomalgRing ],
  function( s, d, R )
    return List( CreateCohomologyMatrix( s, d, R ), Involution );
  end
);

## create the matrices interally, then push them via file transfer
InstallMethod( CreateCohomologyMatrix, "for an external ring",
        [ IsSimplicialSet, IsInt, IsHomalgExternalRingRep ],
  function( s, d, R )
    local internal_ring;
    internal_ring := HomalgRingOfIntegers();
    return List( CreateCohomologyMatrix( s, d, internal_ring ),
      function(m)
        SetExtractHomalgMatrixToFile( m, true );
        return HomalgMatrix( m, R );
      end );
  end
);

