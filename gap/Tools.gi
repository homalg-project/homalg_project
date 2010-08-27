#############################################################################
##
##  Tools.gi                GradedRingForHomalg package      Mohamed Barakat
##                                                    Markus Lange-Hegermann
##
##  Copyright 2009-2010, Mohamed Barakat, University of Kaiserslautern
##                       Markus Lange-Hegermann, RWTH-Aachen University
##
##  Implementations for tools for graded matrices.
##
#############################################################################

################################
##
## operations for ring elements:
##
################################

###########################
##
## operations for matrices:
##
###########################

##
InstallMethod( NonTrivialDegreePerRow,
        "for homalg matrices",
        [ IsHomalgMatrix ],
        
  function( C )
    local R, RP, weights, e, deg0;
    
    if IsZero( C ) then
        return ListWithIdenticalEntries( NrRows( C ), -1 );
    fi;
    
    R := HomalgRing( C );
    
    RP := homalgTable( R );
    
    if Set( WeightsOfIndeterminates( R ) ) <> [ 1 ] then
        
        weights := WeightsOfIndeterminates( R );
        
        if IsList( weights[1] ) then
            if IsBound(RP!.NonTrivialMultiWeightedDegreePerRow) then
                return RP!.NonTrivialMultiWeightedDegreePerRow( C, weights );
            fi;
        elif IsBound(RP!.NonTrivialWeightedDegreePerRow) then
            return RP!.NonTrivialWeightedDegreePerRow( C, weights );
        fi;
        
    elif IsBound(RP!.NonTrivialDegreePerRow) then
        
        return RP!.NonTrivialDegreePerRow( C );
        
    fi;
    
    #=====# the fallback method #=====#
    
    e := DegreesOfEntries( C );
    
    deg0 := DegreeMultivariatePolynomial( Zero( R ) );
    
    return List( e, row -> First( row, a -> not a = deg0 ) );
    
end );

##
InstallMethod( NonTrivialDegreePerRow,
        "for homalg matrices",
        [ IsHomalgMatrix, IsList ],
        
  function( C, col_degrees )
    local R, RP, w, weights, e, deg0;
    
    if Length( col_degrees ) <> NrColumns( C ) then
        Error( "the number of entries in the list of column degrees does not match the number of columns of the matrix\n" );
    fi;
    
    if IsZero( C ) then
        return ListWithIdenticalEntries( NrRows( C ), -1 );
    fi;
    
    R := HomalgRing( C );
    
    RP := homalgTable( R );
    
    w := Set( col_degrees );
    
    if Set( WeightsOfIndeterminates( R ) ) <> [ 1 ] then
        
        weights := WeightsOfIndeterminates( R );
        
        if Length( w ) = 1 then
            if IsList( weights[1] ) then
                if IsBound(RP!.NonTrivialMultiWeightedDegreePerRow) then
                    return RP!.NonTrivialMultiWeightedDegreePerRow( C, weights ) + w[1];
                fi;
            elif IsBound(RP!.NonTrivialWeightedDegreePerRow) then
                return RP!.NonTrivialWeightedDegreePerRow( C, weights ) + w[1];
            fi;
        else
            if IsList( weights[1] ) then
                if IsBound(RP!.NonTrivialMultiWeightedDegreePerRowWithColPosition) then
                    e := RP!.NonTrivialMultiWeightedDegreePerRowWithColPosition( C, weights );
                    return List( [ 1 .. NrRows( C ) ], i -> e[1][i] + col_degrees[e[2][i]] );
                fi;
            elif IsBound(RP!.NonTrivialWeightedDegreePerRowWithColPosition) then
                e := RP!.NonTrivialWeightedDegreePerRowWithColPosition( C, weights );
                return List( [ 1 .. NrRows( C ) ], i -> e[1][i] + col_degrees[e[2][i]] );
            fi;
        fi;
        
    elif IsBound(RP!.NonTrivialDegreePerRow) then
        
        if Length( w ) = 1 then
            return RP!.NonTrivialDegreePerRow( C ) + w[1];
        else
            e := RP!.NonTrivialDegreePerRowWithColPosition( C );
            return List( [ 1 .. NrRows( C ) ], i -> e[1][i] + col_degrees[e[2][i]] );
        fi;
        
    fi;
    
    #=====# the fallback method #=====#
    
    e := DegreesOfEntries( C );
    
    deg0 := DegreeMultivariatePolynomial( Zero( R ) );
    
    return List( e, function( r ) local c; c := PositionProperty( r, a -> not a = deg0 ); return r[c] + col_degrees[c]; end );
    
end );

##
InstallMethod( NonTrivialDegreePerColumn,
        "for homalg matrices",
        [ IsHomalgMatrix ],
        
  function( C )
    local R, RP, weights, e, deg0;
    
    if IsZero( C ) then
        return ListWithIdenticalEntries( NrColumns( C ), -1 );
    fi;
    
    R := HomalgRing( C );
    
    RP := homalgTable( R );
    
    if Set( WeightsOfIndeterminates( R ) ) <> [ 1 ] then
        
        weights := WeightsOfIndeterminates( R );
        
        if IsList( weights[1] ) then
            if IsBound(RP!.NonTrivialMultiWeightedDegreePerColumn) then
                return RP!.NonTrivialMultiWeightedDegreePerColumn( C, weights );
            fi;
        elif IsBound(RP!.NonTrivialWeightedDegreePerColumn) then
            return RP!.NonTrivialWeightedDegreePerColumn( C, weights );
        fi;
        
    elif IsBound(RP!.NonTrivialDegreePerColumn) then
        
        return RP!.NonTrivialDegreePerColumn( C );
        
    fi;
    
    #=====# the fallback method #=====#
    
    e := DegreesOfEntries( C );
    
    deg0 := DegreeMultivariatePolynomial( Zero( R ) );
    
    return List( TransposedMat( e ), column -> First( column, a -> not a = deg0 ) );
    
end );

##
InstallMethod( NonTrivialDegreePerColumn,
        "for homalg matrices",
        [ IsHomalgMatrix, IsList ],
        
  function( C, row_degrees )
    local R, RP, w, weights, e, deg0;
    
    if Length( row_degrees ) <> NrRows( C ) then
        Error( "the number of entries in the list of row degrees does not match the number of rows of the matrix\n" );
    fi;
    
    if IsZero( C ) then
        return ListWithIdenticalEntries( NrColumns( C ), -1 );
    fi;
    
    R := HomalgRing( C );
    
    RP := homalgTable( R );
    
    w := Set( row_degrees );
    
    if Set( WeightsOfIndeterminates( R ) ) <> [ 1 ] then
        
        weights := WeightsOfIndeterminates( R );
        
        if Length( w ) = 1 then
            if IsList( weights[1] ) then
                if IsBound(RP!.NonTrivialMultiWeightedDegreePerColumn) then
                    return RP!.NonTrivialMultiWeightedDegreePerColumn( C, weights ) + w[1];
                fi;
            elif IsBound(RP!.NonTrivialWeightedDegreePerColumn) then
                return RP!.NonTrivialWeightedDegreePerColumn( C, weights ) + w[1];
            fi;
        else
            if IsList( weights[1] ) then
                if IsBound(RP!.NonTrivialMultiWeightedDegreePerColumnWithRowPosition) then
                    e := RP!.NonTrivialMultiWeightedDegreePerColumnWithRowPosition( C, weights );
                    return List( [ 1 .. NrColumns( C ) ], j -> e[1][j] + row_degrees[e[2][j]] );
                fi;
            elif IsBound(RP!.NonTrivialWeightedDegreePerColumnWithRowPosition) then
                e := RP!.NonTrivialWeightedDegreePerColumnWithRowPosition( C, weights );
                return List( [ 1 .. NrColumns( C ) ], j -> e[1][j] + row_degrees[e[2][j]] );
            fi;
        fi;
        
    elif IsBound(RP!.NonTrivialDegreePerColumn) then
        
        if Length( w ) = 1 then
            return RP!.NonTrivialDegreePerColumn( C ) + w[1];
        else
            e := RP!.NonTrivialDegreePerColumnWithRowPosition( C );
            return List( [ 1 .. NrColumns( C ) ], j -> e[1][j] + row_degrees[e[2][j]] );
        fi;
        
    fi;
    
    #=====# the fallback method #=====#
    
    e := DegreesOfEntries( C );
    
    deg0 := DegreeMultivariatePolynomial( Zero( R ) );
    
    return List( TransposedMat( e ), function( c ) local r; r := PositionProperty( c, a -> not a = deg0 ); return c[r] + row_degrees[r]; end );
    
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
##  <A homalg graded (unknown number of rows) by 1 matrix>
##  gap> NrRows( m );
##  6
##  gap> m;
##  <A homalg graded 6 by 1 matrix>
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
        [ IsInt, IsHomalgRing, IsList ],
        
  function( d, R, weights )
    local RP, vars, mon;
    
    RP := homalgTable( R );
    
    if d < 0 then       ## we only accept weights 1 or 0
        return HomalgZeroMatrix( 0, 1, R );
    fi;
    
    vars := Indeterminates( R );
    
    if not Length( weights ) = Length( Indeterminates( R ) ) then
        Error( "there must be as many weights as indeterminates\n" );
    fi;
    
    if not Set( weights ) = [ 1 ] then
        
        ## the variables of weight 1
        vars := vars{Filtered( [ 1 .. Length( weights ) ], p -> weights[p] = 1 )};
        
    fi;
    
    if IsBound(RP!.MonomialMatrix) then
        mon := RP!.MonomialMatrix( d, vars, R );        ## the external object
        mon := HomalgMatrix( mon, R );
        SetNrColumns( mon, 1 );
        if d = 0 then
            IsOne( mon );
        fi;
        return mon;
    fi;
    
    if IsHomalgExternalRingRep( R ) then
        Error( "could not find a procedure called MonomialMatrix in the homalgTable of the external ring\n" );
    fi;
    
    #=====# begin of the core procedure #=====#
    
    TryNextMethod( );
    
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
##  gap> S := GradedRing( R );;
##  gap> rand := RandomMatrixBetweenGradedFreeLeftModules( [ 2, 3, 4 ], [ 1, 2 ], S );
##  <A homalg graded 3 by 2 matrix>
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
        [ IsList, IsList, IsHomalgRing ],
        
  function( weightsS, weightsT, R )
    local RP, r, c, rand, i, j, mon;
    
    RP := homalgTable( R );
    
    r := Length( weightsS );
    c := Length( weightsT );
    
    if weightsT = [ ] then
        return HomalgZeroMatrix( 0, c, R );
    elif weightsS = [ ] then
        return HomalgZeroMatrix( r, 0, R );
    fi;
    
    if IsBound(RP!.RandomMatrix) then
        rand := RP!.RandomMatrix( R, weightsT, weightsS );      ## the external object
        rand := HomalgMatrix( rand, r, c, R );
        return rand;
    fi;
    
    #=====# begin of the core procedure #=====#
    
    rand := [ 1 .. r * c ];
    
    for i in [ 1 .. r ] do
        for j in [ 1 .. c ] do
            mon := MonomialMatrix( weightsS[i] - weightsT[j], R );
            mon := ( R * HomalgMatrix( RandomMat( 1, NrRows( mon ) ), HOMALG_MATRICES.ZZ ) ) * mon;
            mon := GetEntryOfHomalgMatrix( mon, 1, 1 );
            rand[ ( i - 1 ) * c + j ] := mon;
        od;
    od;
    
    return HomalgMatrix( rand, r, c, R );
    
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
##  gap> S := GradedRing( R );;
##  gap> rand := RandomMatrixBetweenGradedFreeRightModules( [ 1, 2 ], [ 2, 3, 4 ], S );
##  <A homalg graded 2 by 3 matrix>
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
        [ IsList, IsList, IsHomalgRing ],
        
  function( weightsT, weightsS, R )
    local RP, r, c, rand, i, j, mon;
    
    RP := homalgTable( R );
    
    r := Length( weightsT );
    c := Length( weightsS );
    
    if weightsT = [ ] then
        return HomalgZeroMatrix( 0, c, R );
    elif weightsS = [ ] then
        return HomalgZeroMatrix( r, 0, R );
    fi;
    
    if IsBound(RP!.RandomMatrix) then
        rand := RP!.RandomMatrix( R, weightsT, weightsS );      ## the external object
        rand := HomalgMatrix( rand, r, c, R );
        return rand;
    fi;
    
    #=====# begin of the core procedure #=====#
    
    rand := [ 1 .. r * c ];
    
    for i in [ 1 .. r ] do
        for j in [ 1 .. c ] do
            mon := MonomialMatrix( weightsS[j] - weightsT[i], R );
            mon := ( R * HomalgMatrix( RandomMat( 1, NrRows( mon ) ), HOMALG_MATRICES.ZZ ) ) * mon;
            mon := GetEntryOfHomalgMatrix( mon, 1, 1 );
            rand[ ( i - 1 ) * c + j ] := mon;
        od;
    od;
    
    return HomalgMatrix( rand, r, c, R );
    
end );
