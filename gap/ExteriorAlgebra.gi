#############################################################################
##
##  ExteriorAlgebra.gi          Modules package              Florian Diebold
##
##  Copyright 2011, Florian Diebold, University of Kaiserslautern
##
##  Some stuff for calculating with exterior powers of free modules.
##
#############################################################################

####################################
#
# methods for operations:
#
####################################

InstallMethod( ExteriorPower,
        "for free modules",
        [ IsInt, IsHomalgModule and IsFree ],
        
  function( k, M )
    local R, r, P, powers;
    
    if HasExteriorPowers( M ) then
        powers := ExteriorPowers( M );
    else
        powers := rec( );
    fi;
    
    if IsBound( powers!.( k ) ) then
        return powers!.( k );
    fi;
    
    R := HomalgRing( M );
    r := Rank( M );
    
    if IsHomalgLeftObjectOrMorphismOfLeftObjects( M ) then
        P := HomalgFreeLeftModule( Binomial( r, k ), R );
    else
        P := HomalgFreeRightModule( Binomial( r, k ), R );
    fi;
    
    SetIsExteriorPower( P, true );
    SetExteriorPowerExponent( P, k );
    SetExteriorPowerBaseModule( P, M );
    
    powers!.( k ) := P;
    SetExteriorPowers( M, powers );
    
    return P;
end );


InstallImmediateMethod( IsExteriorPowerElement,
        IsHomalgModuleElement,
        0,
        
  function( elem )
    local M;
    
    M := Range( UnderlyingMorphism( elem ) );
    
    if HasIsExteriorPower( M ) and IsExteriorPower( M ) then
        return true;
    else
        TryNextMethod( );
    fi;
    
end );


# A few helper functions
InstallGlobalFunction( "_Homalg_CombinationIndex",
  function( n, s )
    local ind, i, j, k, last;
    
    ind := 1;
    last := 0;
    
    for i in [ 1 .. Length( s ) ] do
        k := s[ i ];
        for j in [ last + 1 .. k - 1 ] do
            ind := ind + Binomial( n - j, Length( s ) - i );
        od;
        last := k;
    od;
    
    return ind;
end );

InstallGlobalFunction( "_Homalg_IndexCombination",
  function( n, k, ind )
    local s, i, c;
    
    s := [ ];
    i := 1;
    
    while ind > 0 and Length( s ) < k and i <= n do
        c := Binomial( n - i, k - Length( s ) - 1 );
        if ind <= c then
            Append( s, [ i ] );
        else
            ind := ind - c;
        fi;
        i := i + 1;
    od;
    
    return s;
end );


InstallGlobalFunction( "_Homalg_FreeModuleElementFromList",
  function( a, M )
    if IsHomalgLeftObjectOrMorphismOfLeftObjects( M ) then
        return HomalgElement( HomalgMap( HomalgMatrix( a, 1, Size( a ), HomalgRing( M ) ),
                       "free", M ) );
    else
        return HomalgElement( HomalgMap( HomalgMatrix( a, Size( a ), 1, HomalgRing( M ) ),
                       "free", M ) );
    fi;
end );


InstallMethod( WedgeExteriorPowerElements,
        "for elements of exterior powers of free modules",
        [ IsExteriorPowerElement, IsExteriorPowerElement ],
        
  function( x, y )
    local M, M1, M2, BasisVectorWedgeSign, i, j, result,
          zero, a, b, c, I, J, sign, k, a1, a2, k1, k2, n;
    
    BasisVectorWedgeSign := function( I, J )
        local i, j, sign;
        
        sign := 1;
        
        for i in I do
            for j in J do
                if i = j then
                    return 0;
                elif i > j then
                    sign := -sign;
                fi;
            od;
        od;
        
        return sign;
    end;
    
    M1 := Range( UnderlyingMorphism( x ) );
    k1 := ExteriorPowerExponent( M1 );
    a1 := EntriesOfHomalgMatrix( MatrixOfMap( UnderlyingMorphism( x ) ) );
    
    M2 := Range( UnderlyingMorphism( y ) );
    k2 := ExteriorPowerExponent( M2 );
    a2 := EntriesOfHomalgMatrix( MatrixOfMap( UnderlyingMorphism( y ) ) );
    
    M := ExteriorPowerBaseModule( M1 );
    n := Rank( M );
    
    zero := Zero( HomalgRing( M1 ) );
    
    result := List( [ 1 .. Binomial( n, k1 + k2 ) ], x -> zero );
    
    for i in [ 1 .. Length( a1 ) ] do
        a := a1[ i ];
        
        if a = zero then continue; fi;
        
        for j in [ 1 .. Length( a2 ) ] do
            b := a2[ j ];
            
            if b = zero then continue; fi;
            
            I := _Homalg_IndexCombination( n, k1, i );
            J := _Homalg_IndexCombination( n, k2, j );
            
            sign := BasisVectorWedgeSign( I, J );
            
            if sign = 0 then continue; fi;
            
            k := _Homalg_CombinationIndex( n, Union( I, J ) );
            c := a * b;
            
            if sign < 0 then c := -c; fi;
            
            result[ k ] := result[ k ] + c;
        od;
    od;
    
    return _Homalg_FreeModuleElementFromList( result, ExteriorPower( k1 + k2, M ) );
end );

InstallMethod( SingleValueOfExteriorPowerElement,
        "for elements of exterior powers of free modules",
        [ IsExteriorPowerElement ],
        
  function( a )
    local elems;
    
    elems := EntriesOfHomalgMatrix( MatrixOfMap( UnderlyingMorphism( a ) ) );
    
    if Length( elems ) <> 1 then
        Error( "Expected an element from the highest exterior power!\n" );
    fi;
    
    return elems[ 1 ];
end );

InstallMethod( ExteriorPowerElementDual,
        "for elements of exterior powers of free modules",
        [ IsExteriorPowerElement ],
        
  function( a )
    local result, P, M, M2;
    
    P := Range( UnderlyingMorphism( a ) );
    M := ExteriorPowerBaseModule( P );
    M2 := ExteriorPower( Rank( M ) - ExteriorPowerExponent( P ), M );
    
    result := List( GeneratingElements( M2 ),
                    e -> SingleValueOfExteriorPowerElement( WedgeExteriorPowerElements( a, e ) ) );
    
    return _Homalg_FreeModuleElementFromList( result, M2 );
end );


InstallMethod( KoszulComplex,
        "for sequences of ring elements",
        [ IsList, IsHomalgModule ],
  function( a, E )
    local n, M, C, d, phi, source, target, R, mat, a_elem, e, mat2;
    
    R := HomalgRing( E );
    
    n := Length( a );
    M := n * R;
    source := ExteriorPower( 0, M );
    
    C := HomalgCocomplex( source, 0 );
    
    a_elem := _Homalg_FreeModuleElementFromList( a, ExteriorPower( 1, M ) );
    
    for d in [ 1 .. n ] do
        Unbind( mat );
        for e in GeneratingElements( source ) do
            mat2 := MatrixOfMap( UnderlyingMorphism( WedgeExteriorPowerElements( a_elem, e ) ) );
            if IsBound( mat ) then
                mat := UnionOfRows( mat, mat2 );
            else
                mat := mat2;
            fi;
        od;
        
        target := ExteriorPower( d, M );
        phi := HomalgMap( mat, source, target );
        source := target;
        Add( C, phi );
    od;
    
    return TensorProduct( C, E );
end );

InstallMethod( GradeSequence,
        "for sequences of ring elements",
        [ IsList, IsHomalgModule ],
  function( a, E )
    local R, C, grade;
    
    R := HomalgRing( E );
    
    C := KoszulComplex( a, E );
    
    grade := 0;
    while IsZero( Cohomology( C, grade ) ) do
        grade := grade + 1;
        
        if grade > Length( a ) then
            return infinity;
        fi;
    od;
    return grade;
end );


InstallMethod( CayleyDeterminant,
        "for complexes of free modules",
        [ IsHomalgComplex ],

  function( C )
    local beta, d, R, morphisms, A, i, p, q, s, step, first_step, CertainX;
    
    R := HomalgRing( C );
    if IsHomalgLeftObjectOrMorphismOfLeftObjects( C ) then
        CertainX := CertainRows;
    else
        CertainX := CertainColumns;
    fi;
    
    step := function( beta, d, p, q, s )
        # This is the inductive step of the algorithm (i.e. Lemma 7.4).
        # β in Λ^p(R^(p+q))
        # returns γ such that ᴧ^q(B) = γ * β^T
        # (γ in Λ^q(R^(q+s)))
        # Also, Grade(γ) >= 2
        # beta is passed as a list
        local v, B, v_J_elems;
        
        B := Involution( MatrixOfMap( d ) );
        
        return List( Combinations( [ 1 .. q+s ], q ), function( J )
            local v_J, i, gamma_J;
            
            # Wedge together the columns of the matrix of d indicated by J
            v_J := GeneratingElements( ExteriorPower( 0, Source( d ) ) )[ 1 ];
            for i in [1 .. q] do
                v_J := WedgeExteriorPowerElements( v_J,
                               HomalgElement( HomalgMap( CertainX( B, [ J[ i ] ] ),
                                       "free", ExteriorPower( 1, Source( d ) ) ) ) );
            od;
            
            # Take v_J*
            v_J := ExteriorPowerElementDual( v_J );
            
            # Now v_J* and beta should be proportional
            # Find the factor
            v_J_elems := EntriesOfHomalgMatrix( MatrixOfMap( UnderlyingMorphism( v_J ) ) );
            for i in [ 1 .. Length( v_J_elems ) ] do
                if not IsZero( beta[ i ] ) then
                    gamma_J := v_J_elems[ i ] / beta[ i ];
                    break;
                fi;
            od;
            
            # Test this, if the assertion level is high enough
            Assert( 1, ForAll( [ 1 .. Length( v_J_elems ) ],
                    i -> beta[ i ] * gamma_J = v_J_elems[ i ]));
            
            return gamma_J;
        end );
    end;
    
    morphisms := MorphismsOfComplex( C );
    p := 0;
    q := 0;
    first_step := true;
    
    for d in morphisms{ Reversed( [ 1 .. Length( morphisms ) ] ) } do
        if ( HasIsFree( Source( d ) ) and not IsFree( Source( d ) ) ) or
           ( HasIsFree( Range( d ) ) and not IsFree( Range( d ) ) ) then
            TryNextMethod( );
        fi;
        p := q;
        q := Rank( Source( d ) ) - p;
        s := Rank( Range( d ) ) - q;
        
        if first_step then
            # Wedge together all the rows of the matrix of d
            A := MatrixOfMap( d );
            beta := GeneratingElements( ExteriorPower( 0, Range( d ) ) )[ 1 ];
            for i in [ 1 .. q ] do
                beta := WedgeExteriorPowerElements( beta,
                                HomalgElement( HomalgMap( CertainX( A, [ i ] ),
                                        "free", ExteriorPower( 1, Range( d ) ) ) ) );
            od;
            
            beta := EntriesOfHomalgMatrix( MatrixOfMap( UnderlyingMorphism( beta ) ) );
            first_step := false;
        else
            # If d is d_m, calculate beta_m
            beta := step( beta, d, p, q, s );
        fi;
        
    od;
    
    Assert( 0, Length( beta ) = 1 );
    
    return beta[ 1 ];
end );

InstallGlobalFunction( Gcd_UsingCayleyDeterminant,
  function ( arg )
    local M, C;
    
    if Length( arg ) = 1 then
        arg := arg[ 1 ];
    fi;
    
    M := FactorObject( LeftSubmodule( arg ) );
    
    C := FiniteFreeResolution( M );
    
    if C = fail then
        return fail;
    fi;
    
    return CayleyDeterminant( C );
end );
