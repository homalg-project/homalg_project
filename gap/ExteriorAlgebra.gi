#############################################################################
##
##  ExteriorAlgebra.gi                                       Modules package
##
##  Copyright 2011, Florian Diebold, University of Kaiserslautern
##
##  Some stuff for calculating with exterior powers of free modules.
##
#############################################################################

## <#GAPDoc Label="ExteriorAlgebra:intro">
## What follows are several operations related to the exterior algebra
## of a free module:
## <List>
##   <Item>A constructor for the graded parts of the exterior algebra
##         (<Q>exterior powers</Q>)</Item>
##   <Item>Several Operations on elements of these exterior powers</Item>
##   <Item>A constructor for the <Q>Koszul complex</Q></Item>
##   <Item>An implementation of the <Q>Cayley determinant</Q> as defined in
##         <Cite Key="CQ11" />, which allows calculating greatest common
##         divisors from finite free resolutions.</Item>
## </List>
## <#/GAPDoc>

####################################
#
# methods for operations:
#
####################################

##  <#GAPDoc Label="ExteriorPower">
##  <ManSection>
##    <Oper Arg="k, M" Name="ExteriorPower"/>
##    <Returns>a &homalg; submodule</Returns>
##    <Description>
##      Construct the <A>k</A>-th exterior power of the free module <A>M</A>.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
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


##  <#GAPDoc Label="Wedge">
##  <ManSection>
##    <Oper Arg="x, y" Name="Wedge" Label="for elements of exterior powers of free modules"/>
##    <Returns>an element of an exterior power</Returns>
##    <Description>
##      Calculate <M><A>x</A> \wedge <A>y</A></M>.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
InstallMethod( Wedge,
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

##  <#GAPDoc Label="SingleValueOfExteriorPowerElement">
##  <ManSection>
##    <Oper Arg="x" Name="SingleValueOfExteriorPowerElement" />
##    <Returns>a ring element</Returns>
##    <Description>
##      For <A>x</A> in a highest exterior power, returns its single
##      coordinate in the canonical basis; i.e. <M>[<A>x</A>]</M> as
##      defined in <Cite Key="CQ11" />.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
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

##  <#GAPDoc Label="ExteriorPowerElementDual">
##  <ManSection>
##    <Oper Arg="x" Name="ExteriorPowerElementDual" />
##    <Returns>an element of an exterior power</Returns>
##    <Description>
##      For <A>x</A> in a q-th exterior power of a free module of rank n,
##      return <M><A>x</A>*</M> in the (n-q)-th exterior power, as defined
##      in <Cite Key="CQ11" />.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
InstallMethod( ExteriorPowerElementDual,
        "for elements of exterior powers of free modules",
        [ IsExteriorPowerElement ],
        
  function( a )
    local result, P, M, M2;
    
    P := Range( UnderlyingMorphism( a ) );
    M := ExteriorPowerBaseModule( P );
    M2 := ExteriorPower( Rank( M ) - ExteriorPowerExponent( P ), M );
    
    result := List( GeneratingElements( M2 ),
                    e -> SingleValueOfExteriorPowerElement( Wedge( a, e ) ) );
    
    return _Homalg_FreeModuleElementFromList( result, M2 );
end );


##  <#GAPDoc Label="KoszulCocomplex">
##  <ManSection>
##    <Oper Arg="a, E" Name="KoszulCocomplex" />
##    <Returns>a &homalg; cocomplex</Returns>
##    <Description>
##      Calculate the <A>E</A>-valued Koszul complex of <A>a</A>.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
InstallMethod( KoszulCocomplex,
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
            mat2 := MatrixOfMap( UnderlyingMorphism( Wedge( a_elem, e ) ) );
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

InstallMethod( GradeList,
        "for a list of ring elements and a module",
        [ IsList, IsHomalgModule ],
  function( a, E )
    local R, C, grade;
    
    R := HomalgRing( E );
    
    C := KoszulCocomplex( a, E );
    
    grade := 0;
    while IsZero( Cohomology( C, grade ) ) do
        grade := grade + 1;
        
        if grade > Length( a ) then
            return infinity;
        fi;
    od;
    return grade;
end );

InstallMethod( GradeList,
        "for a list of ring elements and a ring",
        [ IsList, IsHomalgRing ],
  function( a, R )
    return GradeList( a, 1 * R );
end );

InstallMethod( GradeIdeal,
        "for ideals",
        [ IsFinitelyPresentedSubmoduleRep and ConstructedAsAnIdeal ],
  function( I )
    local R, generators;
    
    R := HomalgRing( I );
    generators := EntriesOfHomalgMatrix( MatrixOfSubobjectGenerators( I ) );
    
    return GradeList( generators, 1 * R );
end );

InstallMethod( GradeIdealOnModule,
        "for an ideal and a module",
        [ IsFinitelyPresentedSubmoduleRep and ConstructedAsAnIdeal, IsHomalgModule ],
  function( I, E )
    local R, generators;
    
    generators := EntriesOfHomalgMatrix( MatrixOfSubobjectGenerators( I ) );
    
    return GradeList( generators, E );
end );

InstallMethod( GradeIdealOnModule,
        "for an ideal and a ring",
        [ IsFinitelyPresentedSubmoduleRep and ConstructedAsAnIdeal, IsHomalgRing ],
  function( I, R )
    return GradeIdealOnModule( I, 1 * R );
end );

##  <#GAPDoc Label="Grade_UsingKoszulCocomplex">
##  <ManSection>
##    <Func Arg="a[, E]" Name="Grade_UsingKoszulCocomplex" />
##    <Returns>a positive integer or infinity</Returns>
##    <Description>
##      Calculate the Grade of <A>a</A> (on <A>E</A>, if given), as defined in
##      <Cite Key="CQ11" />. <A>a</A> can be either a list of module elements
##      or an ideal.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
InstallGlobalFunction( Grade_UsingKoszulCocomplex,
  function( arg )
    local E;
    
    if IsList( arg[ 1 ] ) then
        if Length( arg ) = 1 then
            E := 1 * HomalgRing( arg[ 1 ][ 1 ] );
        else
            E := arg[ 2 ];
        fi;
        return GradeList( arg[ 1 ], E );
    else
        if Length( arg ) = 1 then
            return GradeIdeal( arg[ 1 ] );
        else
            return GradeIdealOnModule( arg[ 1 ], arg[ 2 ] );
        fi;
    fi;
end );

#InstallMethod( Grade,
#        "for an ideal and a module",
#        [ IsFinitelyPresentedSubmoduleRep and ConstructedAsAnIdeal, IsHomalgModule ],
#        Grade_UsingKoszulCocomplex );

#InstallMethod( Grade,
#        "for an ideal",
#        [ IsFinitelyPresentedSubmoduleRep and ConstructedAsAnIdeal ],
#        Grade_UsingKoszulCocomplex );

InstallGlobalFunction( WedgeMatrixBaseImages,
  function( A, J, M )
    local v, CertainX, i;
    
    if IsHomalgLeftObjectOrMorphismOfLeftObjects( M ) then
        CertainX := CertainRows;
    else
        CertainX := CertainColumns;
    fi;
    
    v := GeneratingElements( ExteriorPower( 0, M ) )[ 1 ];
    for i in [1 .. Length( J )] do
        v := Wedge( v,
                    HomalgElement( HomalgMap( CertainX( A, [ J[ i ] ] ),
                            "free", ExteriorPower( 1, M ) ) ) );
    od;
    
    return v;
end );

InstallGlobalFunction( CayleyDeterminant_Step,
  function( beta, d, p, q, s )
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
        v_J := WedgeMatrixBaseImages( B, J, Source( d ) );
        
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
        Assert( 3, ForAll( [ 1 .. Length( v_J_elems ) ],
                i -> beta[ i ] * gamma_J = v_J_elems[ i ]));
        
        return gamma_J;
    end );
end );


##  <#GAPDoc Label="CayleyDeterminant">
##  <ManSection>
##    <Oper Arg="C" Name="CayleyDeterminant" />
##    <Returns>a ring element</Returns>
##    <Description>
##      Calculate the Cayley determinant of the complex <A>C</A>, as
##      defined in <Cite Key="CQ11" />.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
InstallMethod( CayleyDeterminant,
        "for complexes of free modules",
        [ IsHomalgComplex ],

  function( C )
    local beta, d, R, morphisms, A, i, p, q, s, first_step;
    
    R := HomalgRing( C );
    
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
            # Wedge together all the rows resp. cols of the matrix of d
            A := MatrixOfMap( d );
            beta := WedgeMatrixBaseImages( A, [ 1 .. q ], Range( d ) );
            
            beta := EntriesOfHomalgMatrix( MatrixOfMap( UnderlyingMorphism( beta ) ) );
            first_step := false;
        else
            # If d is d_m, calculate beta_m
            beta := CayleyDeterminant_Step( beta, d, p, q, s );
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

##
InstallMethod( GcdOp,
        "for homalg ring elements",
        [ IsHomalgRingElement, IsHomalgRingElement ],
        
  Gcd_UsingCayleyDeterminant );

##
InstallGlobalFunction( Lcm_UsingCayleyDeterminant,
  function ( arg )
    local  nargs;
    
    nargs := Length( arg );
    
    if nargs = 0  then
        Error( "<arg> must be nonempty" );
    elif Length( arg ) = 1 and IsList( arg[1] )  then
        if IsEmpty( arg[1] )  then
            Error( "<arg>[1] must be nonempty" );
        fi;
        arg := arg[1];
    fi;
    return LcmOp( arg, arg[1] );
end );
