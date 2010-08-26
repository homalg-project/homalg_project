#############################################################################
##
##  GradedRing.gi           GradedRingForHomalg package      Mohamed Barakat
##                                                    Markus Lange-Hegermann
##
##  Copyright 2010, Mohamed Barakat, University of Kaiserslautern
##           Markus Lange-Hegermann, RWTH-Aachen University
##
##  Implementations of procedures for graded rings.
##
#############################################################################

####################################
#
# representations:
#
####################################

##  <#GAPDoc Label="IsHomalgGradedRingRep">
##  <ManSection>
##    <Filt Type="Representation" Arg="R" Name="IsHomalgGradedRingRep"/>
##    <Returns>true or false</Returns>
##    <Description>
##      The representation of &homalg; graded rings. <P/>
##      (It is a subrepresentation of the &GAP; representation <Br/>
##      <C>IsHomalgRingOrFinitelyPresentedModuleRep</C>.)
##    <Listing Type="Code"><![CDATA[
DeclareRepresentation( "IsHomalgGradedRingRep",
        IsHomalgGradedRing and
        IsHomalgRingOrFinitelyPresentedModuleRep,
        [ "ring" ] );
##  ]]></Listing>
##    </Description>
##  </ManSection>
##  <#/GAPDoc>

####################################
#
# families and types:
#
####################################

# a new family:
BindGlobal( "TheFamilyOfHomalgGradedRings",
        NewFamily( "TheFamilyOfHomalgGradedRings" ) );
        
# a new type:
BindGlobal( "TheTypeHomalgGradedRing",
        NewType( TheFamilyOfHomalgGradedRings,
                IsHomalgGradedRingRep ) );

##  <#GAPDoc Label="IsHomalgGradedRingElementRep">
##  <ManSection>
##    <Filt Type="Representation" Arg="r" Name="IsHomalgGradedRingElementRep"/>
##    <Returns>true or false</Returns>
##    <Description>
##      The representation of elements of &homalg; graded rings. <P/>
##      (It is a representation of the &GAP; category <C>IsHomalgRingElement</C>.)
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareRepresentation( "IsHomalgGradedRingElementRep",
        IsHomalgRingElement,
        [ ] );

##  <#GAPDoc Label="IsHomalgGradedMatrixRep">
##  <ManSection>
##    <Filt Type="Representation" Arg="A" Name="IsHomalgGradedMatrixRep"/>
##    <Returns>true or false</Returns>
##    <Description>
##      The representation of &homalg; matrices with entries in a &homalg; graded ring. <P/>
##      (It is a representation of the &GAP; category <C>IsHomalgMatrix</C>.)
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareRepresentation( "IsHomalgGradedMatrixRep",
        IsHomalgMatrix,
        [ ] );

BindGlobal( "TheTypeHomalgGradedRingElement",
        NewType( TheFamilyOfHomalgRingElements,
                IsHomalgGradedRingElementRep ) );

BindGlobal( "TheTypeHomalgGradedMatrix",
        NewType( TheFamilyOfHomalgMatrices,
                IsHomalgGradedMatrixRep ) );

####################################
#
# methods for operations:
#
####################################

InstallMethod( UnderlyingNonGradedMatrix,
        "for homalg graded matrices",
        [ IsHomalgGradedMatrixRep ],
  function( M )
    return Eval( M );
  end
);

InstallMethod( UnderlyingNonGradedRingElement,
        "for homalg graded ring elements",
        [ IsHomalgGradedRingElementRep ],
  function( r )
    return EvalRingElement( r );
  end
);

##  <#GAPDoc Label="UnderlyingNonGradedRing:ring">
##  <ManSection>
##    <Oper Arg="R" Name="UnderlyingNonGradedRing" Label="for homalg graded rings"/>
##    <Returns>a &homalg; ring</Returns>
##    <Description>
##      Internally there is a ring, in which computations take place. This is either the global ring or a (not fully working) external ring in &Singular; with Mora's algorithm.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
InstallMethod( UnderlyingNonGradedRing,
        "for homalg graded rings",
        [ IsHomalgGradedRingRep ],
  function( R )
    return R!.ring;
  end
);

##  <#GAPDoc Label="UnderlyingNonGradedRing:element">
##  <ManSection>
##    <Oper Arg="r" Name="UnderlyingNonGradedRing" Label="for homalg graded ring elements"/>
##    <Returns>a &homalg; ring</Returns>
##    <Description>
##      Internally there is a ring, in which computations take place. This is either the global ring or a (not fully working) external ring in &Singular; with Mora's algorithm.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
InstallMethod( UnderlyingNonGradedRing,
        "for homalg graded ring elements",
        [ IsHomalgGradedRingElementRep ],
  function( r )
    return UnderlyingNonGradedRing( HomalgRing( r ) );
  end
);

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
  end
);

##  <#GAPDoc Label="Name:gradedmatrix">
##  <ManSection>
##    <Oper Arg="r" Name="Name" Label="for homalg graded ring elements"/>
##    <Returns>a string</Returns>
##    <Description>
##      The name of the graded ring element <A>r</A>.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
InstallMethod( Name,
        "for homalg graded ring elements",
        [ IsHomalgGradedRingElementRep ],
  function( o )
    return name( UnderlyingNonGradedRingElement( o ) );
  end
);

InstallMethod( String,
        "for homalg graded ring elements",
        [ IsHomalgGradedRingElementRep ],
  function( o )
    return Name( o );
  end
);

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
    
  end

);

##
InstallMethod( BlindlyCopyRingPropertiesToGradedRing, ## under construction
        "for homalg rings",
        [ IsHomalgRing, IsHomalgGradedRingRep ],
        
  function( R, S )
    local c;
    
    if HasZero( R ) then
      SetZero( S, GradedRingElement( Zero( R ), S ) );
    fi;    
    if HasOne( R ) then
      SetOne( S, GradedRingElement( One( R ), S ) );
    fi;
    if HasMinusOne( R ) then
      SetMinusOne( S, GradedRingElement( MinusOne( R ), S ) );
    fi;     
    
    for c in [ RationalParameters, 
               IndeterminateCoordinatesOfRingOfDerivations, 
               IndeterminateDerivationsOfRingOfDerivations,
               IndeterminateAntiCommutingVariablesOfExteriorRing,
               IndeterminateAntiCommutingVariablesOfExteriorRing,
               IndeterminatesOfExteriorRing,
               CoefficientsRing,
               BaseRing
              ] do
        if Tester( c )( R ) then
            Setter( c )( S, c( R ) );
        fi;
    od;
    
  end

);

##  <#GAPDoc Label="SetEntryOfHomalgMatrix:gradedmatrix">
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
    
  end

);

##  <#GAPDoc Label="AddToEntryOfHomalgMatrix:gradedmatrix">
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
    
  end

);

##  <#GAPDoc Label="GetEntryOfHomalgMatrixAsString:gradedmatrix">
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
    
  end

);

##  <#GAPDoc Label="GetEntryOfHomalgMatrix:gradedmatrix">
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
    
  end

);

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
InstallMethod( WeightsOfIndeterminates,
        "for homalg free polynomial rings",
        [ IsHomalgRing and IsFreePolynomialRing ],
  function( S )
    local n, old_weights, m, ow1, l, weights;
    
    n := Length( IndeterminatesOfPolynomialRing( S ) );
    
    if HasBaseRing( S ) and HasIsFreePolynomialRing( S ) and IsFreePolynomialRing( S ) then
        
        old_weights := WeightsOfIndeterminates( BaseRing( S ) );
        
        m := Length( old_weights );
        
        ow1 := old_weights[1];
        
        if IsInt( ow1 ) then
            
            l := 1;
            
            weights := List( old_weights, w -> [ w, 0 ] );
            
        elif IsList( ow1 ) then
            
            l := Length( ow1 );
            
            weights := List( old_weights, w -> Concatenation( w, [ 0 ] ) );
            
        else
            Error( "the base ring has invalid first weight\n" );
        fi;
        
        Append( weights, List( [ 1 .. n - m ], i -> Concatenation( List( [ 1 .. l ], j -> 0 ), [ 1 ] ) ) );
        
        S!.WeightsCompatibleWithBaseRing := true;
        
        return weights;
    else
        return ListWithIdenticalEntries( n, 1 );
    fi;
    
end );

##
InstallMethod( WeightsOfIndeterminates,
        "for homalg exterior rings",
        [ IsHomalgRing and IsExteriorRing ],
        
  function( E )
    local n, old_weights, m, ow1, l, weights;
    
    n := Length( IndeterminatesOfExteriorRing( E ) );
    
    if HasBaseRing( E ) and HasIsExteriorRing( E ) and IsExteriorRing( E ) then
        
        old_weights := WeightsOfIndeterminates( BaseRing( E ) );
        
        m := Length( old_weights );
        
        ow1 := old_weights[1];
        
        if IsInt( ow1 ) then
            
            l := 1;
            
            weights := List( old_weights, w -> [ w, 0 ] );
            
        elif IsList( ow1 ) then
            
            l := Length( ow1 );
            
            weights := List( old_weights, w -> Concatenation( w, [ 0 ] ) );
            
        else
            Error( "the base ring has invalid first weight\n" );
        fi;
        
        Append( weights, List( [ 1 .. n - m ], i -> Concatenation( List( [ 1 .. l ], j -> 0 ), [ 1 ] ) ) );
        
        E!.WeightsCompatibleWithBaseRing := true;
        
        return weights;
    else
        return ListWithIdenticalEntries( n, 1 );
    fi;
    
end );

##
InstallMethod( ListOfDegreesOfMultiGradedRing,
        "for homalg rings",
        [ IsInt, IsHomalgGradedRingRep, IsHomogeneousList ], ## FIXME: is IsHomogeneousList too expensive?
        
  function( l, R, weights )
    local indets, n, B, j, w, wlist, i, k;
    
    if l < 1 then
        Error( "the first argument must be a positiv integer\n" );
    fi;
    
    indets := Indeterminates( R );
    
    if not Length( weights ) = Length( indets ) then
        Error( "there must be as many weights as indeterminates\n" );
    fi;
    
    if IsList( weights[1] ) and Length( weights[1] ) = l then
        return List( [ 1 .. l ], i -> List( weights, w -> w[i] ) );
    fi;
    
    ## the rest handles the (improbable?) case of successive extensions
    ## without multiple weights
    
    if l = 1 then
        return [ weights ];
    fi;
    
    n := Length( weights );
    
    if not HasBaseRing( R ) then
        Error( "no 1. base ring found\n" );
    fi;
    
    B := BaseRing( R );
    j := Length( Indeterminates( B ) );
    
    w := Concatenation(
                 ListWithIdenticalEntries( j, 0 ),
                 ListWithIdenticalEntries( n - j, 1 )
                 );
    
    wlist := [ ListN( w, weights, \* ) ];
    
    for i in [ 2 .. l - 1 ] do
        
        if not HasBaseRing( B ) then
            Error( "no ", i, ". base ring found\n" );
        fi;
        
        B := BaseRing( B );
        k := Length( Indeterminates( B ) );
        
        w := Concatenation(
                     ListWithIdenticalEntries( k, 0 ),
                     ListWithIdenticalEntries( j - k, 1 ),
                     ListWithIdenticalEntries( n - j, 0 )
                     );
        
        Add( wlist, ListN( w, weights, \* ) );
        
        j := k;
        
    od;
    
    w := Concatenation(
                 ListWithIdenticalEntries( j, 1 ),
                 ListWithIdenticalEntries( n - j, 0 )
                 );
    
    Add( wlist, ListN( w, weights, \* ) );
    
    return wlist;
    
end );

##  <#GAPDoc Label="MonomialMatrix">
##  <ManSection>
##    <Oper Arg="d, R" Name="MonomialMatrix"/>
##    <Returns>a &homalg; matrix</Returns>
##    <Description>
##      The column matrix of <A>d</A>-th monomials of the &homalg; graded ring <A>R</A>.
##      <Example><![CDATA[
##  gap> S := HomalgFieldOfRationalsInDefaultCAS( ) * "x,y,z";;
##  gap> m := MonomialMatrix( 2, S );
##  <A homalg external (unknown number of rows) by 1 matrix>
##  gap> NrRows( m );
##  6
##  gap> m;
##  <A homalg external 6 by 1 matrix>
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
        [ IsInt, IsHomalgGradedRingRep, IsList ],
        
  function( d, S, weights )
    local R, RP, vars, mon;
    
    R := UnderlyingNonGradedRing( S );
    RP := homalgTable( R );
    
    if d < 0 then ## we only accept weights 1 or 0
        return GradedMatrix( HomalgZeroMatrix( 0, 1, R ), S );
    fi;
    
    vars := Indeterminates( S );
    
    if not Length( weights ) = Length( vars ) then
        Error( "there must be as many weights as indeterminates\n" );
    fi;
    
    if not Set( weights ) = [ 1 ] then
        
        ## the variables of weight 1
        vars := vars{Filtered( [ 1 .. Length( weights ) ], p -> weights[p] = 1 )};
        
    fi;
    
    if IsBound(RP!.MonomialMatrix) then
        mon := RP!.MonomialMatrix( d, vars, R );  ## the external object
        mon := HomalgMatrix( mon, R );
        SetNrColumns( mon, 1 );
        if d = 0 then
            IsOne( mon );
        fi;
        return GradedMatrix( mon, S );
    fi;
    
    if not IsHomalgInternalRingRep( R ) then
        Error( "could not find a procedure called MonomialMatrix in the homalgTable of the external ring\n" );
    fi;
    
    #=====# begin of the core procedure #=====#
    
    TryNextMethod( );
    
end );

##
InstallMethod( MonomialMatrix,
        "for homalg rings",
        [ IsInt, IsHomalgGradedRingRep ],
        
  function( d, S )
    
    return MonomialMatrix( d, S, WeightsOfIndeterminates( S ) );
    
end );

##
InstallMethod( MonomialMatrix,
        "for homalg rings",
        [ IsList, IsHomalgGradedRingRep, IsList ],
        
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
        [ IsList, IsHomalgGradedRingRep ],
        
  function( d, S )
    
    return MonomialMatrix( d, S, WeightsOfIndeterminates( S ) );
    
end );

##  <#GAPDoc Label="RandomMatrixBetweenGradedFreeLeftModules">
##  <ManSection>
##    <Oper Arg="weightsS,weightsT,R" Name="RandomMatrixBetweenGradedFreeLeftModules"/>
##    <Returns>a &homalg; matrix</Returns>
##    <Description>
##      A random <M>r \times c </M>-matrix between the graded free <E>left</E> modules
##      <M><A>R</A>^{(-<A>weightsS</A>)} \to <A>R</A>^{(-<A>weightsT</A>)}</M>,
##      where <M>r = </M><C>Length</C><M>(</M><A>weightsS</A><M>)</M> and
##      <M>c = </M><C>Length</C><M>(</M><A>weightsT</A><M>)</M>.
##      <Example><![CDATA[
##  gap> R := HomalgFieldOfRationalsInDefaultCAS( ) * "a,b,c";;
##  gap> rand := RandomMatrixBetweenGradedFreeLeftModules( [ 2, 3, 4 ], [ 1, 2 ], R );
##  <A homalg external 3 by 2 matrix>
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
        "for homalg rings",
        [ IsList, IsList, IsHomalgGradedRingRep ],
        
  function( weightsS, weightsT, S )
    local R, RP, r, c, rand, i, j, mon;
    
    R := UnderlyingNonGradedRing( R );
    RP := homalgTable( R );
    
    r := Length( weightsS );
    c := Length( weightsT );
    
    if weightsT = [ ] then
        return GradedMatrix( HomalgZeroMatrix( 0, c, R ), S );
    elif weightsS = [ ] then
        return GradedMatrix( HomalgZeroMatrix( r, 0, R ), S );
    fi;
    
    if IsBound(RP!.RandomMatrix) then
        rand := RP!.RandomMatrix( R, weightsT, weightsS );  ## the external object
        rand := HomalgMatrix( rand, r, c, R );
        return GradedMatrix( rand, S );
    fi;
    
    #=====# begin of the core procedure #=====#
    
    rand := [ 1 .. r * c ];
    
    for i in [ 1 .. r ] do
        for j in [ 1 .. c ] do
            mon := UnderlyingNonGradedMatrix( MonomialMatrix( weightsS[i] - weightsT[j], S ) );
            mon := ( R * HomalgMatrix( RandomMat( 1, NrRows( mon ) ), HOMALG_MATRICES.ZZ ) ) * mon;
            mon := GetEntryOfHomalgMatrix( mon, 1, 1 );
            rand[ ( i - 1 ) * c + j ] := mon;
        od;
    od;
    
    return GradedMatrix( HomalgMatrix( rand, r, c, R ), S );
    
end );

##  <#GAPDoc Label="RandomMatrixBetweenGradedFreeRightModules">
##  <ManSection>
##    <Oper Arg="weightsT,weightsS,R" Name="RandomMatrixBetweenGradedFreeRightModules"/>
##    <Returns>a &homalg; matrix</Returns>
##    <Description>
##      A random <M>r \times c </M>-matrix between the graded free <E>right</E> modules
##      <M><A>R</A>^{(-<A>weightsS</A>)} \to <A>R</A>^{(-<A>weightsT</A>)}</M>,
##      where <M>r = </M><C>Length</C><M>(</M><A>weightsT</A><M>)</M> and
##      <M>c = </M><C>Length</C><M>(</M><A>weightsS</A><M>)</M>.
##      <Example><![CDATA[
##  gap> R := HomalgFieldOfRationalsInDefaultCAS( ) * "a,b,c";;
##  gap> rand := RandomMatrixBetweenGradedFreeRightModules( [ 1, 2 ], [ 2, 3, 4 ], R );
##  <A homalg external 2 by 3 matrix>
##   gap> Display( rand );
##   a-2*b-c,a*b+b^2-b*c,2*a^3-a*b^2-4*b^3+4*a^2*c-3*a*b*c-b^2*c+a*c^2+5*b*c^2-2*c^3,
##   -5,     -2*a+c,     -2*a^2-a*b-2*b^2-3*a*c                                      
##  ]]></Example>
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
InstallMethod( RandomMatrixBetweenGradedFreeRightModules,
        "for homalg rings",
        [ IsList, IsList, IsHomalgGradedRingRep ],
        
  function( weightsT, weightsS, S )
    local R, RP, r, c, rand, i, j, mon;
    
    R := UnderlyingNonGradedRing( S );
    RP := homalgTable( R );
    
    r := Length( weightsT );
    c := Length( weightsS );
    
    if weightsT = [ ] then
        return GradedMatrix( HomalgZeroMatrix( 0, c, R ), S );
    elif weightsS = [ ] then
        return GradedMatrix( HomalgZeroMatrix( r, 0, R ), S );
    fi;
    
    if IsBound(RP!.RandomMatrix) then
        rand := RP!.RandomMatrix( R, weightsT, weightsS );  ## the external object
        rand := HomalgMatrix( rand, r, c, R );
        return GradedMatrix( rand, S );
    fi;
    
    #=====# begin of the core procedure #=====#
    
    rand := [ 1 .. r * c ];
    
    for i in [ 1 .. r ] do
        for j in [ 1 .. c ] do
            mon := UnderlyingNonGradedMatrix( MonomialMatrix( weightsS[j] - weightsT[i], S ) );
            mon := ( R * HomalgMatrix( RandomMat( 1, NrRows( mon ) ), HOMALG_MATRICES.ZZ ) ) * mon;
            mon := GetEntryOfHomalgMatrix( mon, 1, 1 );
            rand[ ( i - 1 ) * c + j ] := mon;
        od;
    od;
    
    return GradedMatrix( HomalgMatrix( rand, r, c, R ) );
    
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

InstallMethod( GradedRing,
        "For graded homalg rings",
        [ IsHomalgGradedRingRep ],
  function( R )
    return R;
end );

InstallMethod( GradedRing,
        "For homalg rings",
        [ IsHomalgRing ],
  function( R )
  local RP, component, S;
    
    ## create ring RP with R as underlying global ring
    RP := CreateHomalgTableForGradedRings( R );
    
    S := CreateHomalgRing( R, [ TheTypeHomalgGradedRing, TheTypeHomalgGradedMatrix ], GradedRingElement, RP );
    SetConstructorForHomalgMatrices( S, 
      function( arg )
      local R, mat, l;
        R := arg[Length( arg )];
        l := Concatenation( arg{ [ 1 .. Length( arg ) - 1 ] }, [ UnderlyingNonGradedRing( arg[ Length( arg ) ] ) ] );
        mat := CallFuncList( HomalgMatrix, l );
        return GradedMatrix( mat, R );
      end
    );
    
    BlindlyCopyRingPropertiesToGradedRing( R, S );
    
    S!.description := "graded";
    
    SetWeightsOfIndeterminates( S, WeightsOfIndeterminates( R ) );
    
#     MatchPropertiesAndAttributes( R, S, LIRNG.intrinsic_properties, LIRNG.intrinsic_attributes );

    return S;

    end );

##  <#GAPDoc Label="HomalgGradedRingElement">
##  <ManSection>
##    <Func Arg="numer, denom, R" Name="HomalgGradedRingElement" Label="constructor for graded ring elements using numerator and denominator"/>
##    <Func Arg="numer, R" Name="HomalgGradedRingElement" Label="constructor for graded ring elements using a given numerator and one as denominator"/>
##    <Returns>a graded ring element</Returns>
##    <Description>
##      Creates the graded ring element <M><A>numer</A>/<A>denom</A></M> or in the second case <M><A>numer</A>/1</M> for the graded ring <A>R</A>. Both <A>numer</A> and <A>denom</A> may either be a string describing a valid global ring element or from the global ring or computation ring.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
InstallGlobalFunction( GradedRingElement,
  function( arg )
    local nargs, el, S, ar, properties, R, c, r;
    
    nargs := Length( arg );
    
    if nargs = 0 then
        Error( "empty input\n" );
    fi;
    
    el := arg[1];
    
    if IsHomalgGradedRingElementRep( el ) then
      
      return el;
    
    elif nargs = 2 then
        
        ## extract the properties of the global ring element
        if IsHomalgGradedRing( arg[2] ) then
          S := arg[2];
          ar := [ el, S ];
          properties := KnownTruePropertiesOfObject( el );	## FIXME: a huge potential for problems
          Add( ar, List( properties, ValueGlobal ) );  ## at least an empty list is inserted; avoids infinite loops
          return CallFuncList( GradedRingElement, ar );
        else
          Error( "Expected a ring element and a ring" );
        fi;
        
    fi;
    
    properties := [ ];
    
    for ar in arg{[ 2 .. nargs ]} do
        if not IsBound( S ) and IsHomalgGradedRing( ar ) then
            S := ar;
        elif IsList( ar ) and ForAll( ar, IsFilter ) then
            Append( properties, ar );
        else
            Error( "this argument (now assigned to ar) should be in { IsHomalgRing, IsList( IsFilter )}\n" );
        fi;
    od;
    
    R := UnderlyingNonGradedRing( S );
    
    if not IsHomalgRingElement( el ) or not IsIdenticalObj( R, HomalgRing( el ) ) then
      el := HomalgRingElement( el, R );
    fi;
    
    if IsBound( S ) then
        r := rec( 
          ring := S
        );
        ## Objectify:
        ObjectifyWithAttributes( 
          r, TheTypeHomalgGradedRingElement,
          EvalRingElement, el
        );
    fi;
    
    if properties <> [ ] then
        for ar in properties do
            Setter( ar )( r, true );
        od;
    fi;
    
    return r;
    
end );

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
InstallMethod( ViewObj,
        "for homalg graded rings",
        [ IsHomalgGradedRingRep ],
        
  function( o )
    
    Print( "Graded " );
    Display( UnderlyingNonGradedRing( o ) );
    
end );

##
InstallMethod( ViewObj,
        "for homalg graded ring elements",
        [ IsHomalgGradedRingElementRep ],
        
  function( o )
    
    Print( "Graded " );
    Display( UnderlyingNonGradedRingElement( o ) );
    
end );

##
InstallMethod( ViewObj,
        "for homalg graded matrices",
        [ IsHomalgGradedMatrixRep ],
        
  function( o )
    
    Print( "Graded " );
    Display( UnderlyingNonGradedMatrix( o ) );
    
end );

##
InstallMethod( Display,
        "for graded homalg rings",
        [ IsHomalgGradedRingRep ],
        
  function( o )
    
    Display( UnderlyingNonGradedRing( o ) );
    Print( "(graded)\n" );
    
end );

##
InstallMethod( Display,
        "for homalg graded ring elements",
        [ IsHomalgGradedRingElementRep ],
        
  function( r )
    
    Display( UnderlyingNonGradedRingElement( r ) );
    
end );

##
InstallMethod( Display,
        "for homalg graded matrices",
        [ IsHomalgGradedMatrixRep ],
        
  function( A )
  
    Display( UnderlyingNonGradedMatrix( A ) );
    Print( "(graded)\n" );
    
end );
