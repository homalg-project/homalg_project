#############################################################################
##
##  Gradedmatrix.gi         GradedRingForHomalg package      Mohamed Barakat
##                                                    Markus Lange-Hegermann
##
##  Copyright 2009-2010, Mohamed Barakat, University of Kaiserslautern
##                       Markus Lange-Hegermann, RWTH-Aachen University
##
##  Implementations for graded matrices.
##
#############################################################################

####################################
#
# representations:
#
####################################

##  <#GAPDoc Label="IsHomalgGradedMatrixRep">
##  <ManSection>
##    <Filt Type="Representation" Arg="A" Name="IsHomalgGradedMatrixRep"/>
##    <Returns>true or false</Returns>
##    <Description>
##      The representation of &homalg; matrices with entries in a &homalg; graded ring. <P/>
##      (It is a representation of the &GAP; category <C>IsHomalgMatrix</C>.)
##    <Listing Type="Code"><![CDATA[
DeclareRepresentation( "IsHomalgGradedMatrixRep",
        IsHomalgMatrix,
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

BindGlobal( "TheTypeHomalgGradedMatrix",
        NewType( TheFamilyOfHomalgMatrices,
                IsHomalgGradedMatrixRep ) );

####################################
#
# methods for operations:
#
####################################

##
InstallMethod( UnderlyingNonGradedMatrix,
        "for homalg graded matrices",
        [ IsHomalgGradedMatrixRep ],
        
  Eval );

##  <#GAPDoc Label="UnderlyingNonGradedRing:matrix">
##  <ManSection>
##    <Oper Arg="mat" Name="UnderlyingNonGradedRing" Label="for homalg graded matrices"/>
##    <Returns>a &homalg; ring</Returns>
##    <Description>
##      Internally there is a ring, in which computations take place. This is either the global ring or a (not fully working) pre ring in &Singular; with Mora's algorithm.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
InstallMethod( UnderlyingNonGradedRing,
        "for homalg graded matrices",
        [ IsHomalgGradedMatrixRep ],
        
  function( A )
    
    return UnderlyingNonGradedRing( HomalgRing(A) );
    
end );

##
InstallMethod( BlindlyCopyMatrixPropertiesToGradedMatrix,	## under construction
        "for homalg matrices",
        [ IsHomalgMatrix, IsHomalgGradedMatrixRep ],
        
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
##    <Oper Arg="mat, i, j, r, R" Name="SetEntryOfHomalgMatrix" Label="for homalg graded matrices"/>
##    <Description>
##      Changes the entry (<A>i,j</A>) of the graded matrix <A>mat</A> to the value <A>r</A>. Here <A>R</A> is the (graded) &homalg; ring involved in these computations.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
InstallMethod( SetEntryOfHomalgMatrix,
        "for homalg graded matrices",
        [ IsHomalgGradedMatrixRep and IsMutableMatrix, IsInt, IsInt, IsHomalgGradedRingElementRep, IsHomalgGradedRingRep ],
        
  function( M, r, c, s, R )
    
    SetEntryOfHomalgMatrix( UnderlyingNonGradedMatrix( M ), r, c, UnderlyingNonGradedRingElement( s ), UnderlyingNonGradedRing( R ) );
    
end );

##  <#GAPDoc Label="AddToEntryOfHomalgMatrix">
##  <ManSection>
##    <Oper Arg="mat, i, j, r, R" Name="AddToEntryOfHomalgMatrix" Label="for homalg graded matrices"/>
##    <Description>
##      Changes the entry (<A>i,j</A>) of the graded matrix <A>mat</A> by adding the value <A>r</A> to it. Here <A>R</A> is the (graded) &homalg; ring involved in these computations.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
InstallMethod( AddToEntryOfHomalgMatrix,
        "for homalg graded matrices",
        [ IsHomalgGradedMatrixRep and IsMutableMatrix, IsInt, IsInt, IsHomalgGradedRingElementRep, IsHomalgGradedRingRep ],
        
  function( M, r, c, s, R )
  
    AddToEntryOfHomalgMatrix( UnderlyingNonGradedMatrix( M ), r, c, UnderlyingNonGradedRingElement( s ), UnderlyingNonGradedRing( R ) );
    
end );

##  <#GAPDoc Label="GetEntryOfHomalgMatrixAsString">
##  <ManSection>
##    <Oper Arg="mat, i, j, R" Name="GetEntryOfHomalgMatrixAsString" Label="for homalg graded matrices"/>
##    <Returns>a string</Returns>
##    <Description>
##      Returns the entry (<A>i,j</A>) of the graded matrix <A>mat</A> as a string. Here <A>R</A> is the (graded) &homalg; ring involved in these computations.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
InstallMethod( GetEntryOfHomalgMatrixAsString,
        "for homalg graded matrices",
        [ IsHomalgGradedMatrixRep, IsInt, IsInt, IsHomalgGradedRingRep ],
        
  function( M, r, c, R )
    
    return GetEntryOfHomalgMatrixAsString( UnderlyingNonGradedMatrix( M ), r, c, UnderlyingNonGradedRing( R ) );
    
end );

##  <#GAPDoc Label="GetEntryOfHomalgMatrix">
##  <ManSection>
##    <Oper Arg="mat, i, j, R" Name="GetEntryOfHomalgMatrix" Label="for homalg graded matrices"/>
##    <Returns>a graded ring element</Returns>
##    <Description>
##      Returns the entry (<A>i,j</A>) of the graded matrix <A>mat</A>. Here <A>R</A> is the (graded) &homalg; ring involved in these computations.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
InstallMethod( GetEntryOfHomalgMatrix,
        "for homalg graded matrices",
        [ IsHomalgGradedMatrixRep, IsInt, IsInt, IsHomalgGradedRingRep ],
        
  function( M, r, c, R )
    
    return GradedRingElement( GetEntryOfHomalgMatrix( UnderlyingNonGradedMatrix( M ), r, c, UnderlyingNonGradedRing( R ) ), R );
    
end );

InstallMethod( SaveHomalgMatrixToFile,
        "for graded rings",
        [ IsString, IsHomalgGradedMatrixRep, IsHomalgGradedRingRep ],
        
  function( filename, M, R )
  
    return SaveHomalgMatrixToFile( filename, UnderlyingNonGradedMatrix( M ), UnderlyingNonGradedRing( R ) );
    
end );

##
InstallMethod( LoadHomalgMatrixFromFile,
        "for graded rings",
        [ IsString, IsInt, IsInt, IsHomalgGradedRingRep ],
        
  function( filename, r, c, R )
  
    return GradedRingElement( LoadHomalgMatrixFromFile( filename, r, c, UnderlyingNonGradedRing( R ) ), R );
    
end );

##
InstallMethod( MonomialMatrix,
        "for homalg rings",
        [ IsInt, IsHomalgGradedRingRep, IsList ],
        
  function( d, S, weights )
    local R, mon;
    
    R := UnderlyingNonGradedRing( S );
    
    mon := MonomialMatrix( d, R, weights );
    
    return GradedMatrix( mon, S );
    
end );

##
InstallMethod( MonomialMatrix,
        "for homalg rings",
        [ IsInt, IsHomalgRing ],
        
  function( d, S )
    
    return MonomialMatrix( d, S, WeightsOfIndeterminates( S ) );
    
end );

##
InstallMethod( MonomialMatrix,
        "for homalg rings",
        [ IsList, IsHomalgRing, IsList ],
        
  function( d, S, weights )
    local l, mon, w;
    
    if not Length( weights ) = Length( Indeterminates( S ) ) then
        Error( "there must be as many weights as indeterminates\n" );
    fi;
    
    l := Length( d );
    
    w := ListOfDegreesOfMultiGradedRing( l, S, weights );
    
    mon := List( [ 1 .. l ] , i -> MonomialMatrix( d[i], S, w[i] ) );
    
    return Iterated( mon, KroneckerMat );
    
end );

##
InstallMethod( MonomialMatrix,
        "for homalg rings",
        [ IsList, IsHomalgRing ],
        
  function( d, S )
    
    return MonomialMatrix( d, S, WeightsOfIndeterminates( S ) );
    
end );

##
InstallMethod( RandomMatrixBetweenGradedFreeLeftModules,
        "for homalg rings",
        [ IsList, IsList, IsHomalgGradedRingRep ],
        
  function( weightsS, weightsT, S )
    local R, rand;
    
    R := UnderlyingNonGradedRing( S );
    
    rand := RandomMatrixBetweenGradedFreeLeftModules( weightsS, weightsT, R );
    
    return GradedMatrix( rand, S );
    
end );

##
InstallMethod( RandomMatrixBetweenGradedFreeRightModules,
        "for homalg rings",
        [ IsList, IsList, IsHomalgGradedRingRep ],
        
  function( weightsS, weightsT, S )
    local R, rand;
    
    R := UnderlyingNonGradedRing( S );
    
    rand := RandomMatrixBetweenGradedFreeRightModules( weightsS, weightsT, R );
    
    return GradedMatrix( rand, S );
    
end );

##
InstallMethod( DegreeMultivariatePolynomial,
        "for homalg rings",
        [ IsHomalgGradedRingElementRep ],
        
  function( r )
    
    return DegreeMultivariatePolynomial( UnderlyingNonGradedRingElement( r ) );
    
end );

####################################
#
# constructor functions and methods:
#
####################################

##  <#GAPDoc Label="HomalgGradedMatrix">
##  <ManSection>
##    <Func Arg="numer, denom, R" Name="HomalgGradedMatrix" Label="constructor for graded matrices using numerator and denominator"/>
##    <Func Arg="numer, R" Name="HomalgGradedMatrix" Label="constructor for graded matrices using a given numerator and one as denominator"/>
##    <Returns>a graded matrix</Returns>
##    <Description>
##      Creates the graded matrix <M><A>numer</A>/<A>denom</A></M> or in the second case <M><A>numer</A>/1</M> for the graded ring <A>R</A>. Both <A>numer</A> and <A>denom</A> may either be from the global ring or the computation ring.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
InstallMethod( GradedMatrix,
        "constructor for matrices over graded rings",
        [ IsHomalgMatrix, IsHomalgGradedRingRep ],
        
  function( A, R )
    local G, type, matrix, ComputationRing, rr, AA;
    
    if IsHomalgGradedMatrixRep( A ) then
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
      matrix, TheTypeHomalgGradedMatrix,
      Eval, A
    );
    
    BlindlyCopyMatrixPropertiesToGradedMatrix( A, matrix );
    
    return matrix;
    
end );

##
InstallMethod( SetIsMutableMatrix,
        "for homalg graded matrices",
        [ IsHomalgGradedMatrixRep, IsBool ],
        
  function( A, b )
    
    if b = true then
      SetFilterObj( A, IsMutableMatrix );
    else
      ResetFilterObj( A, IsMutableMatrix );
    fi;
    
    SetIsMutableMatrix( UnderlyingNonGradedMatrix( A ), b );
    
end );

####################################
#
# View, Print, and Display methods:
#
####################################

##
InstallMethod( Display,
        "for homalg graded matrices",
        [ IsHomalgGradedMatrixRep ],
        
  function( A )
    
    Display( UnderlyingNonGradedMatrix( A ) );
    Print( "(graded)\n" );
    
end );
