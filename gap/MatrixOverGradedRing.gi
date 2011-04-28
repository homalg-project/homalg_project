#############################################################################
##
##  MatrixOverGradedRing.gi                      GradedRingForHomalg package
##
##  Copyright 2009-2010, Mohamed Barakat, University of Kaiserslautern
##                       Markus Lange-Hegermann, RWTH-Aachen University
##
##  Implementations for homogeneous matrices.
##
#############################################################################

####################################
#
# representations:
#
####################################

##  <#GAPDoc Label="IsHomalgMatrixOverGradedRingRep">
##  <ManSection>
##    <Filt Type="Representation" Arg="A" Name="IsHomalgMatrixOverGradedRingRep"/>
##    <Returns>true or false</Returns>
##    <Description>
##      The representation of &homalg; matrices with entries in a &homalg; graded ring. <P/>
##      (It is a representation of the &GAP; category <C>IsMatrixOverGradedRing</C>.)
##    <Listing Type="Code"><![CDATA[
DeclareRepresentation( "IsHomalgMatrixOverGradedRingRep",
        IsMatrixOverGradedRing,
        [ ] );
##  ]]></Listing>
##    </Description>
##  </ManSection>
##  <#/GAPDoc>

####################################
#
# families and types:
#
####################################

BindGlobal( "TheTypeHomalgMatrixOverGradedRing",
        NewType( TheFamilyOfHomalgMatrices,
                IsHomalgMatrixOverGradedRingRep ) );

####################################
#
# methods for operations:
#
####################################

##
InstallMethod( UnderlyingMatrixOverNonGradedRing,
        "for homalg homogeneous matrices",
        [ IsHomalgMatrixOverGradedRingRep and IsEmptyMatrix ],
        
  function( A )
    local B;
    
    if not HasEval( A ) then
      
      B := HomalgZeroMatrix( NrRows( A ), NrColumns( A ), UnderlyingNonGradedRing( HomalgRing( A ) ) );
      
      SetEval( A, B );
    
    fi;
    
    return Eval( A );
  
end );

##
InstallMethod( UnderlyingMatrixOverNonGradedRing,
        "for homalg homogeneous matrices",
        [ IsHomalgMatrixOverGradedRingRep ],
        
  Eval );

##  <#GAPDoc Label="UnderlyingNonGradedRing:matrix">
##  <ManSection>
##    <Oper Arg="mat" Name="UnderlyingNonGradedRing" Label="for homalg homogeneous matrices"/>
##    <Returns>a &homalg; ring</Returns>
##    <Description>
##      The nongraded ring underlying <C>HomalgRing</C>(<A>mat</A>).
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
InstallMethod( UnderlyingNonGradedRing,
        "for homalg homogeneous matrices",
        [ IsHomalgMatrixOverGradedRingRep ],
        
  function( A )
    
    return UnderlyingNonGradedRing( HomalgRing(A) );
    
end );

##
InstallMethod( BlindlyCopyMatrixPropertiesToMatrixOverGradedRing,	## under construction
        "for homalg homogeneous matrices",
        [ IsHomalgMatrix, IsHomalgMatrixOverGradedRingRep ],
        
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

##  <#GAPDoc Label="SetEntryOfHomalgMatrix">
##  <ManSection>
##    <Oper Arg="mat, i, j, r, R" Name="SetEntryOfHomalgMatrix" Label="for homalg homogenous matrices"/>
##    <Description>
##      Changes the entry (<A>i,j</A>) of the homogenous matrix <A>mat</A> to the value <A>r</A>. Here <A>R</A> is the (graded) &homalg; ring involved in these computations.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
InstallMethod( SetEntryOfHomalgMatrix,
        "for homalg homogeneous matrices",
        [ IsHomalgMatrixOverGradedRingRep and IsMutableMatrix, IsInt, IsInt, IsHomalgGradedRingElementRep, IsHomalgGradedRingRep ],
        
  function( M, r, c, s, R )
    
    SetEntryOfHomalgMatrix( UnderlyingMatrixOverNonGradedRing( M ), r, c, UnderlyingNonGradedRingElement( s ), UnderlyingNonGradedRing( R ) );
    
end );

##  <#GAPDoc Label="AddToEntryOfHomalgMatrix">
##  <ManSection>
##    <Oper Arg="mat, i, j, r, R" Name="AddToEntryOfHomalgMatrix" Label="for homalg homogenous matrices"/>
##    <Description>
##      Changes the entry (<A>i,j</A>) of the homogenous matrix <A>mat</A> by adding the value <A>r</A> to it. Here <A>R</A> is the (graded) &homalg; ring involved in these computations.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
InstallMethod( AddToEntryOfHomalgMatrix,
        "for homalg homogeneous matrices",
        [ IsHomalgMatrixOverGradedRingRep and IsMutableMatrix, IsInt, IsInt, IsHomalgGradedRingElementRep, IsHomalgGradedRingRep ],
        
  function( M, r, c, s, R )
  
    AddToEntryOfHomalgMatrix( UnderlyingMatrixOverNonGradedRing( M ), r, c, UnderlyingNonGradedRingElement( s ), UnderlyingNonGradedRing( R ) );
    
end );

##  <#GAPDoc Label="GetEntryOfHomalgMatrixAsString">
##  <ManSection>
##    <Oper Arg="mat, i, j, R" Name="GetEntryOfHomalgMatrixAsString" Label="for homalg homogenous matrices"/>
##    <Returns>a string</Returns>
##    <Description>
##      Returns the entry (<A>i,j</A>) of the homogenous matrix <A>mat</A> as a string. Here <A>R</A> is the (graded) &homalg; ring involved in these computations.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
InstallMethod( GetEntryOfHomalgMatrixAsString,
        "for homalg homogeneous matrices",
        [ IsHomalgMatrixOverGradedRingRep, IsInt, IsInt, IsHomalgGradedRingRep ],
        
  function( M, r, c, R )
    
    return GetEntryOfHomalgMatrixAsString( UnderlyingMatrixOverNonGradedRing( M ), r, c, UnderlyingNonGradedRing( R ) );
    
end );

##  <#GAPDoc Label="GetEntryOfHomalgMatrix">
##  <ManSection>
##    <Oper Arg="mat, i, j, R" Name="GetEntryOfHomalgMatrix" Label="for homalg homogenous matrices"/>
##    <Returns>a graded ring element</Returns>
##    <Description>
##      Returns the entry (<A>i,j</A>) of the homogenous matrix <A>mat</A>. Here <A>R</A> is the (graded) &homalg; ring involved in these computations.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
InstallMethod( GetEntryOfHomalgMatrix,
        "for homalg homogeneous matrices",
        [ IsHomalgMatrixOverGradedRingRep, IsInt, IsInt, IsHomalgGradedRingRep ],
        
  function( M, r, c, R )
    
    return GradedRingElement( GetEntryOfHomalgMatrix( UnderlyingMatrixOverNonGradedRing( M ), r, c, UnderlyingNonGradedRing( R ) ), R );
    
end );

##
InstallMethod( SaveHomalgMatrixToFile,
        "for homalg homogeneous matrices",
        [ IsString, IsHomalgMatrixOverGradedRingRep, IsHomalgGradedRingRep ],
        
  function( filename, M, R )
  
    return SaveHomalgMatrixToFile( filename, UnderlyingMatrixOverNonGradedRing( M ), UnderlyingNonGradedRing( R ) );
    
end );

##
InstallMethod( LoadHomalgMatrixFromFile,
        "for homalg homogeneous matrices",
        [ IsString, IsInt, IsInt, IsHomalgGradedRingRep ],
        
  function( filename, r, c, R )
  
    return MatrixOverGradedRing( LoadHomalgMatrixFromFile( filename, r, c, UnderlyingNonGradedRing( R ) ), R );
    
end );

##  <#GAPDoc Label="MonomialMatrix">
##  <ManSection>
##    <Oper Arg="d, R" Name="MonomialMatrix"/>
##    <Returns>a &homalg; matrix</Returns>
##    <Description>
##      The column matrix of <A>d</A>-th monomials of the &homalg; graded ring <A>R</A>.
##      <Example><![CDATA[
##  gap> R := HomalgFieldOfRationalsInDefaultCAS( ) * "x,y,z";;
##  gap> S := GradedRing( R );;
##  gap> m := MonomialMatrix( 2, S );
##  <A ? x 1 matrix over a graded ring>
##  gap> NrRows( m );
##  6
##  gap> m;
##  <A 6 x 1 matrix over a graded ring>
##   gap> Display( m );
##   z^2,
##   y*z,
##   y^2,
##   x*z,
##   x*y,
##   x^2 
##  ]]></Example>
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
InstallMethod( MonomialMatrix,
        "for homalg rings",
        [ IsInt, IsHomalgGradedRing ],
        
  function( d, S )
    
    return MatrixOverGradedRing(
                   MonomialMatrixWeighted(
                           d, UnderlyingNonGradedRing( S ), WeightsOfIndeterminates( S ) ),
                   S );
    
end );

##
InstallMethod( MonomialMatrix,
        "for homalg rings",
        [ IsList, IsHomalgGradedRing ],
        
  function( d, S )
    
    return MatrixOverGradedRing(
                   MonomialMatrixWeighted(
                           d, UnderlyingNonGradedRing( S ), WeightsOfIndeterminates( S ) ),
                   S );
    
end );

##  <#GAPDoc Label="RandomMatrixBetweenGradedFreeLeftModules">
##  <ManSection>
##    <Oper Arg="degreesS,degreesT,R" Name="RandomMatrixBetweenGradedFreeLeftModules"/>
##    <Returns>a &homalg; matrix</Returns>
##    <Description>
##      A random <M>r \times c </M>-matrix between the graded free <E>left</E> modules
##      <M><A>R</A>^{(-<A>degreesS</A>)} \to <A>R</A>^{(-<A>degreesT</A>)}</M>,
##      where <M>r = </M><C>Length</C><M>(</M><A>degreesS</A><M>)</M> and
##      <M>c = </M><C>Length</C><M>(</M><A>degreesT</A><M>)</M>.
##      <Example><![CDATA[
##  gap> R := HomalgFieldOfRationalsInDefaultCAS( ) * "a,b,c";;
##  gap> S := GradedRing( R );;
##  gap> rand := RandomMatrixBetweenGradedFreeLeftModules( [ 2, 3, 4 ], [ 1, 2 ], S );
##  <A 3 x 2 matrix over a graded ring>
##   gap> Display( rand );
##   a-2*b+2*c,                                                2,                 
##   a^2-a*b+b^2-2*b*c+5*c^2,                                  3*c,               
##   2*a^3-3*a^2*b+2*a*b^2+3*a^2*c+a*b*c-2*b^2*c-3*b*c^2-2*c^3,a^2-4*a*b-3*a*c-c^2
##  ]]></Example>
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
InstallMethod( RandomMatrixBetweenGradedFreeLeftModules,
        "for homalg graded rings",
        [ IsList, IsList, IsHomalgGradedRingRep ],
        
  function( degreesS, degreesT, S )
    
    return MatrixOverGradedRing(
                   RandomMatrixBetweenGradedFreeLeftModulesWeighted(
                           degreesS, degreesT,
                           UnderlyingNonGradedRing( S ), WeightsOfIndeterminates( S ) ),
                   S );
    
end );

##  <#GAPDoc Label="RandomMatrixBetweenGradedFreeRightModules">
##  <ManSection>
##    <Oper Arg="degreesT,degreesS,R" Name="RandomMatrixBetweenGradedFreeRightModules"/>
##    <Returns>a &homalg; matrix</Returns>
##    <Description>
##      A random <M>r \times c </M>-matrix between the graded free <E>right</E> modules
##      <M><A>R</A>^{(-<A>degreesS</A>)} \to <A>R</A>^{(-<A>degreesT</A>)}</M>,
##      where <M>r = </M><C>Length</C><M>(</M><A>degreesT</A><M>)</M> and
##      <M>c = </M><C>Length</C><M>(</M><A>degreesS</A><M>)</M>.
##      <Example><![CDATA[
##  gap> R := HomalgFieldOfRationalsInDefaultCAS( ) * "a,b,c";;
##  gap> S := GradedRing( R );;
##  gap> rand := RandomMatrixBetweenGradedFreeRightModules( [ 1, 2 ], [ 2, 3, 4 ], S );
##  <A 2 x 3 matrix over a graded ring>
##   gap> Display( rand );
##   a-2*b-c,a*b+b^2-b*c,2*a^3-a*b^2-4*b^3+4*a^2*c-3*a*b*c-b^2*c+a*c^2+5*b*c^2-2*c^3,
##   -5,     -2*a+c,     -2*a^2-a*b-2*b^2-3*a*c                                      
##  ]]></Example>
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
InstallMethod( RandomMatrixBetweenGradedFreeRightModules,
        "for homalg graded rings",
        [ IsList, IsList, IsHomalgGradedRingRep ],
        
  function( degreesS, degreesT, S )
    
    return MatrixOverGradedRing(
                   RandomMatrixBetweenGradedFreeRightModulesWeighted(
                           degreesS, degreesT,
                           UnderlyingNonGradedRing( S ), WeightsOfIndeterminates( S ) ),
                   S );
    
end );

##
InstallMethod( DegreesOfEntries,
        "for homalg matrices",
        [ IsHomalgMatrix, IsHomalgGradedRing ],
        
  function( C, S )
    
    if IsZero( C ) then
        
        return ListWithIdenticalEntries( NrRows( C ),
                       ListWithIdenticalEntries( NrColumns( C ),
                               DegreeOfRingElement( Zero( S ) ) ) );
    fi;
    
    return DegreesOfEntriesFunction( S )( C );
    
end );

##
InstallMethod( NonTrivialDegreePerRow,
        "for a homalg matrix and a graded ring",
        [ IsHomalgMatrix, IsHomalgGradedRing ],
        
  function( C, S )
    
    if IsOne( C ) then
        return ListWithIdenticalEntries( NrRows( C ), DegreeOfRingElement( One( S ) ) );
    elif IsZero( C ) then
        return ListWithIdenticalEntries( NrRows( C ), DegreeOfRingElement( One( S ) ) );	## One( S ) is not a mistake
    fi;
    
    return NonTrivialDegreePerRowFunction( S )( C );
    
end );

##
InstallMethod( NonTrivialDegreePerRow,
        "for a homalg matrix and a graded ring",
        [ IsHomalgMatrix, IsHomalgGradedRing, IsList ],
        
  function( C, S, col_degrees )
    
    if Length( col_degrees ) <> NrColumns( C ) then
        Error( "the number of entries in the list of column degrees does not match the number of columns of the matrix\n" );
    fi;
    
    if IsOne( C ) then
        return col_degrees;
    elif IsEmptyMatrix( C ) then
        return ListWithIdenticalEntries( NrRows( C ), DegreeOfRingElement( One( S ) ) );	## One( S ) is not a mistake
    elif IsZero( C ) then
        return ListWithIdenticalEntries( NrRows( C ), col_degrees[1] );	## this is not a mistake
    fi;
    
    return NonTrivialDegreePerRowWithColDegreesFunction( S )( col_degrees )( C );
    
end );

##
InstallMethod( NonTrivialDegreePerColumn,
        "for a homalg matrix and a graded ring",
        [ IsHomalgMatrix, IsHomalgGradedRing ],
        
  function( C, S )
    
    if IsOne( C ) then
        return ListWithIdenticalEntries( NrColumns( C ), DegreeOfRingElement( One( S ) ) );
    elif IsZero( C ) then
        return ListWithIdenticalEntries( NrColumns( C ), DegreeOfRingElement( One( S ) ) );	## One( S ) is not a mistake
    fi;
    
    return NonTrivialDegreePerColumnFunction( S )( C );
    
end );

##
InstallMethod( NonTrivialDegreePerColumn,
        "for a homalg matrix and a graded ring",
        [ IsHomalgMatrix, IsHomalgGradedRing, IsList ],
        
  function( C, S, row_degrees )
    
    if Length( row_degrees ) <> NrRows( C ) then
        Error( "the number of entries in the list of row degrees does not match the number of rows of the matrix\n" );
    fi;
    
    if IsOne( C ) then
        return row_degrees;
    elif IsEmptyMatrix( C ) then
        return ListWithIdenticalEntries( NrColumns( C ), DegreeOfRingElement( One( S ) ) );	## One( S ) is not a mistake
    elif IsZero( C ) then
        return ListWithIdenticalEntries( NrColumns( C ), row_degrees[1] );	## this is not a mistake
    fi;
    
    return NonTrivialDegreePerColumnWithRowDegreesFunction( S )( row_degrees )( C );
    
end );

####################################
#
# constructor functions and methods:
#
####################################

##  <#GAPDoc Label="MatrixOverGradedRing">
##  <ManSection>
##    <Func Arg="numer, denom, R" Name="MatrixOverGradedRing" Label="constructor for homogenous matrices using numerator and denominator"/>
##    <Func Arg="numer, R" Name="MatrixOverGradedRing" Label="constructor for homogenous matrices using a given numerator and one as denominator"/>
##    <Returns>a homogeneous matrix</Returns>
##    <Description>
##      Creates the homogeneous matrix <M><A>numer</A>/<A>denom</A></M> or in the second case <M><A>numer</A>/1</M> for the graded ring <A>R</A>. Both <A>numer</A> and <A>denom</A> may either be from the global ring or the computation ring.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
InstallMethod( MatrixOverGradedRing,
        "constructor for matrices over graded rings",
        [ IsHomalgMatrix, IsHomalgGradedRingRep ],
        
  function( A, R )
    local G, type, matrix, ComputationRing, rr, AA;
    
    if IsHomalgMatrixOverGradedRingRep( A ) then
      return A;
    fi;
    
    G := HomalgRing( A );
    
    ComputationRing := UnderlyingNonGradedRing( R );
    
    if not IsIdenticalObj( ComputationRing , HomalgRing( A ) ) then
      Error( "Underlying rings do not match" );
    fi;
    
    matrix := rec(
      ring := R,
     );
    
    ObjectifyWithAttributes(
      matrix, TheTypeHomalgMatrixOverGradedRing,
      Eval, A
    );
    
    BlindlyCopyMatrixPropertiesToMatrixOverGradedRing( A, matrix );
    
    return matrix;
    
end );

InstallMethod( MatrixOverGradedRing,
        "constructor for matrices over graded rings",
        [ IsList, IsInt, IsInt, IsHomalgGradedRingRep ],
  function( A, r, c, R )
    
    return MatrixOverGradedRing( HomalgMatrix( A, r, c, UnderlyingNonGradedRing( R ) ), R );
    
end );

##
InstallMethod( \*,
        "for homalg matrices",
        [ IsHomalgGradedRingRep, IsHomalgMatrix ],
        
  function( R, m )
    
    return MatrixOverGradedRing( UnderlyingNonGradedRing( R ) * m, R );
    
end );

##
InstallMethod( \*,
        "for matrices over graded rings",
        [ IsHomalgRing, IsHomalgMatrixOverGradedRingRep ],
        
  function( R, m )
    
    return R * UnderlyingMatrixOverNonGradedRing( m );
    
end );

##
InstallMethod( SetIsMutableMatrix,
        "for homalg homogeneous matrices",
        [ IsHomalgMatrixOverGradedRingRep, IsBool ],
        
  function( A, b )
    
    if b = true then
      SetFilterObj( A, IsMutableMatrix );
    else
      ResetFilterObj( A, IsMutableMatrix );
    fi;
    
    SetIsMutableMatrix( UnderlyingMatrixOverNonGradedRing( A ), b );
    
end );

####################################
#
# View, Print, and Display methods:
#
####################################

##
InstallMethod( Display,
        "for homalg homogeneous matrices",
        [ IsHomalgMatrixOverGradedRingRep ],
        
  function( A )
    
    Display( UnderlyingMatrixOverNonGradedRing( A ) );
    Print( "(homogeneous)\n" );
    
end );
