#############################################################################
##
##  HomogeneousMatrix.gi    GradedRingForHomalg package      Mohamed Barakat
##                                                    Markus Lange-Hegermann
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

##  <#GAPDoc Label="IsHomalgHomogeneousMatrixRep">
##  <ManSection>
##    <Filt Type="Representation" Arg="A" Name="IsHomalgHomogeneousMatrixRep"/>
##    <Returns>true or false</Returns>
##    <Description>
##      The representation of &homalg; matrices with entries in a &homalg; graded ring. <P/>
##      (It is a representation of the &GAP; category <C>IsHomalgMatrix</C>.)
##    <Listing Type="Code"><![CDATA[
DeclareRepresentation( "IsHomalgHomogeneousMatrixRep",
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

BindGlobal( "TheTypeHomalgHomogeneousMatrix",
        NewType( TheFamilyOfHomalgMatrices,
                IsHomalgHomogeneousMatrixRep ) );

####################################
#
# methods for operations:
#
####################################

##
InstallMethod( UnderlyingNonHomogeneousMatrix,
        "for homalg homogeneous matrices",
        [ IsHomalgHomogeneousMatrixRep and IsEmptyMatrix ],
        
  function( A )
    local B;
    
    if not HasEval( A ) then
      
      B := HomalgZeroMatrix( NrRows( A ), NrColumns( A ), UnderlyingNonGradedRing( HomalgRing( A ) ) );
      
      SetEval( A, B );
    
    fi;
    
    return Eval( A );
  
end );

##
InstallMethod( UnderlyingNonHomogeneousMatrix,
        "for homalg homogeneous matrices",
        [ IsHomalgHomogeneousMatrixRep ],
        
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
        "for homalg homogeneous matrices",
        [ IsHomalgHomogeneousMatrixRep ],
        
  function( A )
    
    return UnderlyingNonGradedRing( HomalgRing(A) );
    
end );

##
InstallMethod( BlindlyCopyMatrixPropertiesToHomogeneousMatrix,	## under construction
        "for homalg homogeneous matrices",
        [ IsHomalgMatrix, IsHomalgHomogeneousMatrixRep ],
        
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
        "for homalg homogeneous matrices",
        [ IsHomalgHomogeneousMatrixRep and IsMutableMatrix, IsInt, IsInt, IsHomalgGradedRingElementRep, IsHomalgGradedRingRep ],
        
  function( M, r, c, s, R )
    
    SetEntryOfHomalgMatrix( UnderlyingNonHomogeneousMatrix( M ), r, c, UnderlyingNonGradedRingElement( s ), UnderlyingNonGradedRing( R ) );
    
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
        "for homalg homogeneous matrices",
        [ IsHomalgHomogeneousMatrixRep and IsMutableMatrix, IsInt, IsInt, IsHomalgGradedRingElementRep, IsHomalgGradedRingRep ],
        
  function( M, r, c, s, R )
  
    AddToEntryOfHomalgMatrix( UnderlyingNonHomogeneousMatrix( M ), r, c, UnderlyingNonGradedRingElement( s ), UnderlyingNonGradedRing( R ) );
    
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
        "for homalg homogeneous matrices",
        [ IsHomalgHomogeneousMatrixRep, IsInt, IsInt, IsHomalgGradedRingRep ],
        
  function( M, r, c, R )
    
    return GetEntryOfHomalgMatrixAsString( UnderlyingNonHomogeneousMatrix( M ), r, c, UnderlyingNonGradedRing( R ) );
    
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
        "for homalg homogeneous matrices",
        [ IsHomalgHomogeneousMatrixRep, IsInt, IsInt, IsHomalgGradedRingRep ],
        
  function( M, r, c, R )
    
    return GradedRingElement( GetEntryOfHomalgMatrix( UnderlyingNonHomogeneousMatrix( M ), r, c, UnderlyingNonGradedRing( R ) ), R );
    
end );

InstallMethod( SaveHomalgMatrixToFile,
        "for homalg homogeneous matrices",
        [ IsString, IsHomalgHomogeneousMatrixRep, IsHomalgGradedRingRep ],
        
  function( filename, M, R )
  
    return SaveHomalgMatrixToFile( filename, UnderlyingNonHomogeneousMatrix( M ), UnderlyingNonGradedRing( R ) );
    
end );

##
InstallMethod( LoadHomalgMatrixFromFile,
        "for homalg homogeneous matrices",
        [ IsString, IsInt, IsInt, IsHomalgGradedRingRep ],
        
  function( filename, r, c, R )
  
    return HomogeneousMatrix( LoadHomalgMatrixFromFile( filename, r, c, UnderlyingNonGradedRing( R ) ), R );
    
end );

##
InstallMethod( MonomialMatrix,
        "for homalg graded rings",
        [ IsInt, IsHomalgGradedRingRep, IsList ],
        
  function( d, S, weights )
    local R, mon;
    
    R := UnderlyingNonGradedRing( S );
    
    mon := MonomialMatrix( d, R, weights );
    
    return HomogeneousMatrix( mon, S );
    
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
        "for homalg graded rings",
        [ IsList, IsList, IsHomalgGradedRingRep ],
        
  function( weightsS, weightsT, S )
    local R, rand;
    
    R := UnderlyingNonGradedRing( S );
    
    rand := RandomMatrixBetweenGradedFreeLeftModules( weightsS, weightsT, R );
    
    return HomogeneousMatrix( rand, S );
    
end );

##
InstallMethod( RandomMatrixBetweenGradedFreeRightModules,
        "for homalg graded rings",
        [ IsList, IsList, IsHomalgGradedRingRep ],
        
  function( weightsS, weightsT, S )
    local R, rand;
    
    R := UnderlyingNonGradedRing( S );
    
    rand := RandomMatrixBetweenGradedFreeRightModules( weightsS, weightsT, R );
    
    return HomogeneousMatrix( rand, S );
    
end );

####################################
#
# constructor functions and methods:
#
####################################

##  <#GAPDoc Label="HomogeneousMatrix">
##  <ManSection>
##    <Func Arg="numer, denom, R" Name="HomogeneousMatrix" Label="constructor for graded matrices using numerator and denominator"/>
##    <Func Arg="numer, R" Name="HomogeneousMatrix" Label="constructor for graded matrices using a given numerator and one as denominator"/>
##    <Returns>a graded matrix</Returns>
##    <Description>
##      Creates the homogeneous matrix <M><A>numer</A>/<A>denom</A></M> or in the second case <M><A>numer</A>/1</M> for the graded ring <A>R</A>. Both <A>numer</A> and <A>denom</A> may either be from the global ring or the computation ring.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
InstallMethod( HomogeneousMatrix,
        "constructor for matrices over graded rings",
        [ IsHomalgMatrix, IsHomalgGradedRingRep ],
        
  function( A, R )
    local G, type, matrix, ComputationRing, rr, AA;
    
    if IsHomalgHomogeneousMatrixRep( A ) then
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
      matrix, TheTypeHomalgHomogeneousMatrix,
      Eval, A
    );
    
    BlindlyCopyMatrixPropertiesToHomogeneousMatrix( A, matrix );
    
    return matrix;
    
end );

InstallMethod( HomogeneousMatrix,
        "constructor for matrices over graded rings",
        [ IsList, IsInt, IsInt, IsHomalgGradedRingRep ],
  function( A, r, c, R )
    
    return HomogeneousMatrix( HomalgMatrix( A, r, c, UnderlyingNonGradedRing( R ) ), R );
    
end );

##
InstallMethod( SetIsMutableMatrix,
        "for homalg homogeneous matrices",
        [ IsHomalgHomogeneousMatrixRep, IsBool ],
        
  function( A, b )
    
    if b = true then
      SetFilterObj( A, IsMutableMatrix );
    else
      ResetFilterObj( A, IsMutableMatrix );
    fi;
    
    SetIsMutableMatrix( UnderlyingNonHomogeneousMatrix( A ), b );
    
end );

####################################
#
# View, Print, and Display methods:
#
####################################

##
InstallMethod( Display,
        "for homalg homogeneous matrices",
        [ IsHomalgHomogeneousMatrixRep ],
        
  function( A )
    
    Display( UnderlyingNonHomogeneousMatrix( A ) );
    Print( "(homogeneous)\n" );
    
end );
