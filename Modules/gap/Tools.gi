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
InstallMethod( IntersectWithSubalgebra,
        "for ideals",
        [ IsFinitelyPresentedSubmoduleRep and ConstructedAsAnIdeal, IsList ],
        
  function( I, var )
    local left, ideal;
    
    left := IsHomalgLeftObjectOrMorphismOfLeftObjects( I );
    
    I := MatrixOfSubobjectGenerators( I );
    
    if not left then
        I := Involution( I );
    fi;
    
    I := IntersectWithSubalgebra( I, var );
    
    if not left then
        I := Involution( I );
    fi;
    
    if left then
        ideal := LeftSubmodule;
    else
        ideal := RightSubmodule;
    fi;
    
    return ideal( I );
    
end );

##
InstallMethod( MaximalIndependentSet,
        "for ideals",
        [ IsFinitelyPresentedSubmoduleRep and ConstructedAsAnIdeal ],
        
  function( I )
    local left;
    
    left := IsHomalgLeftObjectOrMorphismOfLeftObjects( I );
    
    I := MatrixOfSubobjectGenerators( I );
    
    if not left then
        I := Involution( I );
    fi;
    
    return MaximalIndependentSet( I );
    
end );

##
InstallMethod( EliminateOverBaseRing,
        "for a matrix and a list",
        [ IsHomalgMatrix, IsList, IsInt ],
        
  function( M, elim, d )
    local R, B, indets, L, N, n, monoms, monomStr, monomS, m,
          MonomsL, monomsL, monomSL, posL, coeffs, coeffsL;
    
    if not NrColumns( M ) = 1 then
        Error( "the number of columns must be 1\n" );
    fi;
    
    R := HomalgRing( M );
    
    if HasRelativeIndeterminatesOfPolynomialRing( R ) then
        B := BaseRing( R );
        indets := RelativeIndeterminatesOfPolynomialRing( R );
    elif HasIndeterminatesOfPolynomialRing( R ) then
        B := CoefficientsRing( R );
        indets := IndeterminatesOfPolynomialRing( R );
    elif IsFieldForHomalg( R ) then
        return HomalgZeroMatrix( 0, 1, R );
    else
        TryNextMethod( );
    fi;
    
    if not IsSubset( indets, elim ) then
        Error( "the second argument is not a subset of the list of indeterminates\n" );
    fi;
    
    L := Difference( indets, elim );
    
    if d > 0 then
        indets := HomalgMatrix( indets, R );
    fi;
    
    while d > 0 do
        M := UnionOfRowsOp( M, KroneckerMat( indets, M ) );
        d := d - 1;
    od;
    
    M := EntriesOfHomalgMatrix( M );
    
    M := List( M, Coefficients );
    
    N := List( M, a -> a!.monomials );
    
    n := Length( N );
    
    M := List( M, a -> B * a );
    
    monoms := Concatenation( N );
    
    ## check if a monomial could be reconstructed from its string
    m := Length( monoms );
    if m > 0 then
        Assert( 0, monoms[m] = String( monoms[m] ) / R );
    fi;
    
    monomStr := List( monoms, String );
    
    monomS := Set( monomStr );
    
    monoms := monoms{List( monomS, a -> Position( monomStr, a ) )};
    
    m := Length( monoms );
    
    MonomsL := Select( HomalgMatrix( monoms, m, 1, R ), L );
    
    monomsL := EntriesOfHomalgMatrix( MonomsL );
    
    monomSL := List( monomsL, String );
    
    posL := List( monomSL, a -> PositionSet( monomS, a ) );
    
    monoms := Concatenation( monomsL, monoms{Difference( [ 1 .. m ], posL )} );
    
    Assert( 0, m = Length( monoms ) );
    
    monomS := List( monoms, String );
    
    N := List( N, a -> List( a, b -> Position( monomS, String( b ) ) ) );
    
    coeffs := HomalgInitialMatrix( n, m, B );
    
    Perform( [ 1 .. n ],
            function( r )
              local l;
              l := N[r];
              Perform( [ 1 .. Length( l ) ],
                      function( c )
                        SetMatElm( coeffs, r, l[c], MatElm( M[r], c, 1 ) );
                      end );
            end );
    
    MakeImmutable( coeffs );
    
    coeffs := LeftSubmodule( coeffs );
    
    n := Length( monomsL );
    
    coeffsL := UnionOfColumnsOp(
                       HomalgIdentityMatrix( n, B ),
                       HomalgZeroMatrix( n, m - n, B )
                       );
    
    coeffsL := Subobject( coeffsL, SuperObject( coeffs ) );
    
    elim := Intersect( coeffs, coeffsL );
    
    OnBasisOfPresentation( elim );
    
    ByASmallerPresentation( elim );
    
    elim := MatrixOfSubobjectGenerators( elim );
    
    elim := CertainColumns( elim, [ 1 .. n ] );
    
    return ( R * elim ) * MonomsL;
    
end );

##
InstallMethod( EliminateOverBaseRing,
        "for a matrix and a list",
        [ IsHomalgMatrix, IsList ],
        
  function( M, elim )
    
    return EliminateOverBaseRing( M, elim, 0 );
    
end );

##
InstallMethod( SimplifiedInequalities,
        [ IsList ],
        
  function( ineqs )
    local R, A;
    
    if ineqs = [ ] then
        return ineqs;
    fi;
    
    R := HomalgRing( ineqs[1] );
    
    ## normalize
    ineqs := List( ineqs, DecideZero );
    
    if ForAny( ineqs, IsZero ) then
        Error( "the input list of inequalities contains a zero element\n" );
    fi;
    
    ineqs := Set( ineqs );
    
    if HasAmbientRing( R ) then
        A := AmbientRing( R );
        ineqs := List( ineqs, i -> i / A );
    fi;
    
    ## radical decomposition
    ineqs := List( ineqs, i -> RadicalDecomposition( LeftSubmodule( [ i ] ) ) );
    ineqs := Concatenation( ineqs );
    ineqs := List( ineqs, i -> MatElm( MatrixOfSubobjectGenerators( i ), 1, 1 ) );
    ineqs := Set( ineqs );
    
    if HasAmbientRing( R ) then
        ineqs := List( ineqs, i -> i / R );
    fi;
    
    ## get rid of constants
    ineqs := Filtered( ineqs, i -> not IsUnit( i ) );
    
    return ineqs;
    
end );

##
InstallMethod( SimplifiedInequalities,
        [ IsHomalgMatrix ],
        
  function( ineqs )
    
    ineqs := EntriesOfHomalgMatrix( ineqs );
    
    return SimplifiedInequalities( ineqs );
    
end );

##
InstallMethod( DefiningIdeal,
        "for homalg rings",
        [ IsHomalgRing and IsHomalgResidueClassRingRep ],
        
  function( R )
    local m, ideal;
    
    m := MatrixOfRelations( R );
    
    if NrColumns( m ) = 1 then
        ideal := LeftSubmodule;
    elif NrRows( m ) = 1 then
        ideal := RightSubmodule;
    else
        Error( "the matrix of relations m of the residue class ring R has a weird shape\n" );
    fi;
    
    return ideal( m );
    
end );

##
InstallMethod( DefiningIdealFromNameOfResidueClassRing,
        "for a homalg ring and a string",
        [ IsHomalgRing, IsString ],
        
  function( R, string )
    local pos1, pos2, vars, gens;
    
    pos1 := Position( string, '[' );
    
    if not pos1 = fail then
        pos2 := Position( string, ']' );
        vars := string{[ pos1 + 1 .. pos2 - 1 ]};
        R := R * vars;
    fi;
    
    pos1 := Position( string, '(' );
    
    gens := "0";
    
    if not pos1 = fail then
        pos2 := Position( string, ')' );
        gens := string{[ pos1 + 1 .. pos2 - 1 ]};
        
    fi;
    
    return LeftSubmodule( gens, R );
    
end );
