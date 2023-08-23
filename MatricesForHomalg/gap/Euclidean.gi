# SPDX-License-Identifier: GPL-2.0-or-later
# MatricesForHomalg: Matrices for the homalg project
#
# Implementations
#

## Efficiency is not among the two purposes served by the implementation below:
## 1. Prove that Euclidean rings are computable in the sense of Barakat and Lange-Hegermann.
##    A practical purpose of this proof is to make univariate polynomial rings over fields
##    computable in GAP (i.e., without relying on external oracles).
## 2. Demonstrate a unified implementation of the Row (Reduced) Echelon Form (REF, RREF)
##    and the (reduced) Hermite normal form algorithms.

##
InstallMethod( FullyDividePairTrafo,
        [ IsRingElement, IsRingElement, IsHomalgRing ],
        
  function( a, b, R )
    local U, q, r;
    
    U := HomalgIdentityMatrix( 2, R );
    
    while not IsZero( b ) do
        q := EuclideanQuotient( R, a, b );
        U := HomalgMatrix( [ 0, 1, 1, -q ], 2, 2, R ) * U;
        r := a - q * b;
        a := b;
        b := r;
    od;
    
    return U;
    
end );

##
InstallMethod( FullyDividePairTrafo,
        [ IsRingElement, IsRingElement, IsHomalgRing and IsFieldForHomalg ],
        
  function( a, b, R )
    local U, q, r;
    
    U := HomalgIdentityMatrix( 2, R );
    
    while not IsZero( b ) do
        q := EuclideanQuotient( R, a, b );
        U := HomalgMatrix( [ 0, 1, 1, -q ], 2, 2, R ) * U;
        r := a - q * b;
        a := b;
        b := r;
    od;
    
    return U;
    
end );

##
InstallMethod( FullyDividePairTrafoInflated,
        [ IsRingElement, IsRingElement, IsInt, IsInt, IsInt, IsHomalgRing ],
        
  function( a, b, i, j, n, R )
    local U, u;
    
    U := HomalgInitialIdentityMatrix( n, R );
    
    u := FullyDividePairTrafo( a, b, R );
    
    SetMatElm( U, i, i, MatElm( u, 1, 1 ) );
    SetMatElm( U, i, j, MatElm( u, 1, 2 ) );
    SetMatElm( U, j, i, MatElm( u, 2, 1 ) );
    SetMatElm( U, j, j, MatElm( u, 2, 2 ) );
    
    MakeImmutable( U );
    
    return U;
    
end );

##
InstallMethod( FullyDivideColumnTrafo,
        [ IsHomalgMatrix ],
        
  function( col )
    local R, m, U, nz, j, a, b, u;
    
    R := HomalgRing( col );
    
    m := NumberRows( col );
    
    U := HomalgIdentityMatrix( m, R );
    
    if IsZero( col ) then ## also takes care of 0x1 matrix
        return U;
    elif m = 1 then ## takes care of the 1x1 nonzero case
        if HasIsFieldForHomalg( R ) and IsFieldForHomalg( R ) then
            return HomalgMatrix( [ MatElm( col, 1, 1 )^-1 ], 1, 1, R );
        fi;
        return U;
    fi;
    
    ## now we know that col is not zero with at least two rows
    nz := NonZeroRows( col );
    nz := ShallowCopy( nz );
    
    ## remove 1 from NonZeroRows( col )
    if nz[1] = 1 then
        
        ## this would be enough for the ring case
        Remove( nz, 1 );
        
        ## ensure normalizing the first column entry in the field case
        if nz = [ ] and HasIsFieldForHomalg( R ) and IsFieldForHomalg( R ) then
            nz := [ 2 ];
        fi;
    fi;
    
    for j in nz do
        
        a := MatElm( col, 1, 1 );
        b := MatElm( col, j, 1 );
        
        u := FullyDividePairTrafoInflated( a, b, 1, j, m, R );
      
        col := u * col;
        
        U := u * U;
        
    od;
    
    return U;
    
end );

##
InstallMethod( FullyDivideMatrixTrafo,
        [ IsHomalgMatrix ],
        
  function( mat )
    local R, U, NZC, i, u;
    
    R := HomalgRing( mat );
    
    U := HomalgIdentityMatrix( NumberRows( mat ), R );
    
    NZC := NonZeroColumns( mat );
    
    i := 0;
    
    while not NZC = [ ] do
        
        u := FullyDivideColumnTrafo( CertainColumns( mat, [ NZC[1] ] ) );
        
        mat := u * mat;
        
        u := DiagMat( [ HomalgIdentityMatrix( i, R ), u ] );
        
        U := u * U;
        
        mat := CertainRows( mat, [ 2 .. NumberRows( mat ) ] );
        
        i := i + 1;
        
        NZC := NonZeroColumns( mat );
        
    od;
    
    return U;
    
end );

##
InstallMethod( DivideColumnTrafo,
        [ IsHomalgMatrix, IsInt ],
        
  function( col, r )
    local R, m, U, nz, b, i, a, u, q;
    
    R := HomalgRing( col );
    
    m := NumberRows( col );
    
    U := HomalgIdentityMatrix( m, R );
    
    if m <= 1 then
        return U;
    fi;
    
    ## now we know that col is not zero with at least two rows
    nz := NonZeroRows( col );
    nz := Intersection( nz, [ 1 .. r - 1 ] );
    
    b := MatElm( col, r, 1 );
    
    for i in nz do
        
        a := MatElm( col, i, 1 );
        
        q := EuclideanQuotient( R, a, b );
        
        u := HomalgInitialIdentityMatrix( m, R );
        
        SetMatElm( u, i, r, -q );
        
        col := u * col;
        
        U := u * U;
        
    od;
    
    return U;
    
end );

##
InstallMethod( StrictlyFullyDivideMatrixTrafo,
        [ IsHomalgMatrix ],
        
  function( mat )
    local R, U, steps, r, u;
    
    R := HomalgRing( mat );
    
    U := FullyDivideMatrixTrafo( mat );
    
    mat := U * mat;
    
    steps := PositionOfFirstNonZeroEntryPerRow( CertainRows( mat, NonZeroRows( mat ) ) );
    
    mat := CertainColumns( mat, steps );
    
    for r in [ 1 .. Length( steps ) ] do
        
        u := DivideColumnTrafo( CertainColumns( mat, [ r ] ), r );
        
        mat := u * mat;
        
        U := u * U;
        
    od;
    
    return U;
    
end );

##
InstallMethod( CreateHomalgTable,
        "for Euclidean rings",
        [ IsEuclideanRing ],
        
  function( ring )
    local RP_General, RP, component;
    
    if IsField( ring ) or ( HasIsFinite( ring ) and IsFinite( ring ) ) then ## leave for Gauss/GaussForHomalg
        TryNextMethod( );
    fi;
    
    RP_General := ShallowCopy( CommonHomalgTableForRings );
    
    RP := rec( 
               ## Can optionally be provided by the RingPackage
               ## (homalg functions check if these functions are defined or not)
               ## (homalgTable gives no default value)
               
               RowRankOfMatrix :=
                 function( M )
                   
                   return Rank( Eval( M )!.matrix );
                   
                 end,
               
               ElementaryDivisors :=
                 function( arg )
                   local M;
                   
                   M := arg[1];
                   
                   return ElementaryDivisorsMat( ring, Eval( M )!.matrix );
                   
                 end,
               
               Gcd :=
                 function( a, b )
                   
                   return Gcd( ring, [ a, b ] );
                   
                 end,
               
               CancelGcd :=
                 function( a, b )
                   local gcd;
                   
                   gcd := Gcd( ring, [ a, b ] );
                   
                   return [ a / gcd, b / gcd ];
                   
                 end,
               
               ## Must be defined if other functions are not defined
               
               ReducedRowEchelonForm :=
                 function( arg )
                   local M, nargs, U, H;
                   
                   M := arg[1];
                   
                   nargs := Length( arg );
                   
                   U := StrictlyFullyDivideMatrixTrafo( M );
                   
                   H := U * M;
                   
                   SetIsUpperStairCaseMatrix( H, true );
                   
                   if nargs > 1 and IsHomalgMatrix( arg[2] ) then ## not ReducedRowEchelonForm( M, "" )
                       ## compute H and U
                       
                       # assign U:
                       SetPreEval( arg[2], U );

                       U := arg[2];
                       
                       ResetFilterObj( U, IsVoidMatrix );
                       SetNumberRows( U, NumberRows( M ) );
                       SetNumberColumns( U, NumberRows( M ) );
                       SetIsInvertibleMatrix( U, true );
                   fi;
                   
                   return H;
                   
                 end
                 
          );
    
    for component in NamesOfComponents( RP_General ) do
        RP.(component) := RP_General.(component);
    od;
    
    Objectify( TheTypeHomalgTable, RP );
    
    return RP;
    
end );
