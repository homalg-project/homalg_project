#############################################################################
##
##  HomalgSpectralSequence.gi   homalg package               Mohamed Barakat
##
##  Copyright 2007-2008 Lehrstuhl B für Mathematik, RWTH Aachen
##
##  Implementations for homalg spectral sequences.
##
#############################################################################

##  <#GAPDoc Label="SpectralSequences:intro">
##    Spectral sequences are regarded as the computational sledgehammer in homological algebra. Quoting the last lines
##    of Rotman's book <Cite Key="rot"/>: <P/>
##    <Quoted>The reader should now be convinced that virtually every purely homological result may be proved with
##      spectral sequences. Even though <Q>elementary</Q> proofs may exist for many of these results, spectral sequences
##      offer a systematic approach in place of sporadic success.</Quoted>
##  <#/GAPDoc>

####################################
#
# representations:
#
####################################

##  <#GAPDoc Label="IsSpectralSequenceOfFinitelyPresentedObjectsRep">
##  <ManSection>
##    <Filt Type="Representation" Arg="E" Name="IsSpectralSequenceOfFinitelyPresentedObjectsRep"/>
##    <Returns><C>true</C> or <C>false</C></Returns>
##    <Description>
##      The &GAP; representation of homological spectral sequences of finitley generated &homalg; objects. <P/>
##      (It is a representation of the &GAP; category <Ref Filt="IsHomalgSpectralSequence"/>,
##       which is a subrepresentation of the &GAP; representation <C>IsFinitelyPresentedObjectRep</C>.)
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareRepresentation( "IsSpectralSequenceOfFinitelyPresentedObjectsRep",
        IsHomalgSpectralSequence and IsFinitelyPresentedObjectRep,
        [  ] );

##  <#GAPDoc Label="IsSpectralCosequenceOfFinitelyPresentedObjectsRep">
##  <ManSection>
##    <Filt Type="Representation" Arg="E" Name="IsSpectralCosequenceOfFinitelyPresentedObjectsRep"/>
##    <Returns><C>true</C> or <C>false</C></Returns>
##    <Description>
##      The &GAP; representation of cohomological spectral sequences of finitley generated &homalg; objects. <P/>
##      (It is a representation of the &GAP; category <Ref Filt="IsHomalgSpectralSequence"/>,
##       which is a subrepresentation of the &GAP; representation <C>IsFinitelyPresentedObjectRep</C>.)
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareRepresentation( "IsSpectralCosequenceOfFinitelyPresentedObjectsRep",
        IsHomalgSpectralSequence and IsFinitelyPresentedObjectRep,
        [  ] );

####################################
#
# families and types:
#
####################################

# a new family:
BindGlobal( "TheFamilyOfHomalgSpectralSequencees",
        NewFamily( "TheFamilyOfHomalgSpectralSequencees" ) );

# four new types:
BindGlobal( "TheTypeHomalgSpectralSequenceAssociatedToABicomplexOfLeftObjects",
        NewType( TheFamilyOfHomalgSpectralSequencees,
                IsSpectralSequenceOfFinitelyPresentedObjectsRep and
                IsHomalgSpectralSequenceAssociatedToABicomplex and
                IsHomalgSpectralSequenceAssociatedToAnExactCouple and
                IsHomalgLeftObjectOrMorphismOfLeftObjects ) );

BindGlobal( "TheTypeHomalgSpectralSequenceAssociatedToABicomplexOfRightObjects",
        NewType( TheFamilyOfHomalgSpectralSequencees,
                IsSpectralSequenceOfFinitelyPresentedObjectsRep and
                IsHomalgSpectralSequenceAssociatedToABicomplex and
                IsHomalgSpectralSequenceAssociatedToAnExactCouple and
                IsHomalgRightObjectOrMorphismOfRightObjects ) );

BindGlobal( "TheTypeHomalgSpectralCosequenceAssociatedToABicomplexOfLeftObjects",
        NewType( TheFamilyOfHomalgSpectralSequencees,
                IsSpectralCosequenceOfFinitelyPresentedObjectsRep and
                IsHomalgSpectralSequenceAssociatedToABicomplex and
                IsHomalgSpectralSequenceAssociatedToAnExactCouple and
                IsHomalgLeftObjectOrMorphismOfLeftObjects ) );

BindGlobal( "TheTypeHomalgSpectralCosequenceAssociatedToABicomplexOfRightObjects",
        NewType( TheFamilyOfHomalgSpectralSequencees,
                IsSpectralCosequenceOfFinitelyPresentedObjectsRep and
                IsHomalgSpectralSequenceAssociatedToABicomplex and
                IsHomalgSpectralSequenceAssociatedToAnExactCouple and
                IsHomalgRightObjectOrMorphismOfRightObjects ) );

####################################
#
# methods for operations:
#
####################################

##
InstallMethod( homalgResetFilters,
        "for homalg spectral sequences",
        [ IsHomalgSpectralSequence ],
        
  function( E )
    local property;
    
    if not IsBound( HOMALG.PropertiesOfSpectralSequencees ) then
        HOMALG.PropertiesOfSpectralSequencees :=
          [ IsZero ];
    fi;
    
    for property in HOMALG.PropertiesOfSpectralSequencees do
        ResetFilterObj( E, property );
    od;
    
end );

##
InstallMethod( LevelsOfSpectralSequence,
        "for homalg spectral sequences",
        [ IsHomalgSpectralSequence ],
        
  function( E )
    
    return E!.levels;
    
end );

##
InstallMethod( CertainSheet,
        "for homalg spectral sequences",
        [ IsHomalgSpectralSequence, IsInt ],
        
  function( E, r )
    
    if IsBound(E!.(String( r ))) then
        return E!.(String( r ));
    fi;
    
    return fail;
    
end );

##
InstallMethod( LowestLevelInSpectralSequence,
        "for homalg spectral sequences",
        [ IsHomalgSpectralSequence ],
        
  function( E )
    
    return LevelsOfSpectralSequence( E )[1];
    
end );

##
InstallMethod( HighestLevelInSpectralSequence,
        "for homalg spectral sequences",
        [ IsHomalgSpectralSequence ],
        
  function( E )
    local levels;
    
    levels := LevelsOfSpectralSequence( E );
    
    return levels[Length( levels )];
    
end );

##
InstallMethod( SheetsOfSpectralSequence,
        "for homalg spectral sequences",
        [ IsHomalgSpectralSequence ],
        
  function( E )
    
    return List( LevelsOfSpectralSequence( E ), r -> CertainSheet( E, r ) );
    
end );

##
InstallMethod( LowestLevelSheetInSpectralSequence,
        "for homalg spectral sequences",
        [ IsHomalgSpectralSequence ],
        
  function( E )
    
    return CertainSheet( E, LowestLevelInSpectralSequence( E ) );
    
end );

##
InstallMethod( HighestLevelSheetInSpectralSequence,
        "for homalg spectral sequences",
        [ IsHomalgSpectralSequence ],
        
  function( E )
    
    return CertainSheet( E, HighestLevelInSpectralSequence( E ) );
    
end );

##
InstallMethod( ObjectDegreesOfSpectralSequence,
        "for homalg spectral sequences",
        [ IsHomalgSpectralSequence ],
        
  function( E )
    
    return E!.bidegrees;
    
end );

##
InstallMethod( CertainObject,
        "for homalg spectral sequences",
        [ IsHomalgSpectralSequence, IsList, IsInt ],
        
  function( E, pq, r )
    local Er;
    
    Er := CertainSheet( E, r );
    
    if Er = fail then
        return fail;
    fi;
    
    return CertainObject( Er, pq );
    
end );

##
InstallMethod( CertainObject,
        "for homalg spectral sequences",
        [ IsHomalgSpectralSequence, IsList ],
        
  function( E, pq )
    
    return CertainObject( E, pq, HighestLevelInSpectralSequence( E ) );
    
end );

##
InstallMethod( ObjectsOfSpectralSequence,
        "for homalg spectral sequences",
        [ IsHomalgSpectralSequence, IsInt ],
        
  function( E, r )
    local Er;
    
    Er := CertainSheet( E, r );
    
    if Er = fail then
        return fail;
    fi;
    
    return ObjectsOfBigradedObject( Er );
    
end );

##
InstallMethod( ObjectsOfSpectralSequence,
        "for homalg spectral sequences",
        [ IsHomalgSpectralSequence ],
        
  function( E )
    
    return ObjectsOfSpectralSequence( E, HighestLevelInSpectralSequence( E ) );
    
end );

##
InstallMethod( LowestBidegreeInSpectralSequence,
        "for homalg spectral sequences",
        [ IsHomalgSpectralSequence ],
        
  function( E )
    local bidegrees;
    
    bidegrees := ObjectDegreesOfSpectralSequence( E );
    
    return [ bidegrees[1][1], bidegrees[2][1] ];
    
end );

##
InstallMethod( HighestBidegreeInSpectralSequence,
        "for homalg spectral sequences",
        [ IsHomalgSpectralSequence ],
        
  function( E )
    local bidegrees;
    
    bidegrees := ObjectDegreesOfSpectralSequence( E );
    
    return [ bidegrees[1][Length( bidegrees[1] )], bidegrees[2][Length( bidegrees[2] )] ];
    
end );

##
InstallMethod( LowestTotalDegreeInSpectralSequence,
        "for homalg spectral sequences",
        [ IsHomalgSpectralSequence ],
        
  function( B )
    local pq_lowest;
    
    pq_lowest := LowestBidegreeInSpectralSequence( B );
    
    return pq_lowest[1] + pq_lowest[2];
    
end );

##
InstallMethod( HighestTotalDegreeInSpectralSequence,
        "for homalg spectral sequences",
        [ IsHomalgSpectralSequence ],
        
  function( B )
    local pq_highest;
    
    pq_highest := HighestBidegreeInSpectralSequence( B );
    
    return pq_highest[1] + pq_highest[2];
    
end );

##
InstallMethod( TotalDegreesOfSpectralSequence,
        "for homalg spectral sequences",
        [ IsHomalgSpectralSequence ],
        
  function( B )
    
    return [ LowestTotalDegreeInSpectralSequence( B ) .. HighestTotalDegreeInSpectralSequence( B ) ];
    
end );

##
InstallMethod( BidegreesOfSpectralSequence,
        "for homalg spectral sequences",
        [ IsHomalgSpectralSequence, IsInt ],
        
  function( E, n )
    local bidegrees, lq, max, n_lowest, n_highest, bidegrees_n, p, q;
    
    bidegrees := ObjectDegreesOfSpectralSequence( E );
    
    lq := Length( bidegrees[2] );
    max := Minimum( Length( bidegrees[1] ),  lq ) - 1;
    
    n_lowest := LowestTotalDegreeInSpectralSequence( E );
    n_highest := HighestTotalDegreeInSpectralSequence( E );
    
    bidegrees_n := [ ];
    
    if n < n_lowest or n > n_highest then
        return bidegrees_n;
    fi;
    
    if n - n_lowest < lq then
        for p in bidegrees[1][1] + [ 0 .. Minimum( n - n_lowest, max ) ] do
            Add( bidegrees_n, [ p, n - p ] );
        od;
    else
        for q in bidegrees[2][lq] - [ 0 .. Minimum( n_highest - n, max ) ] do
            Add( bidegrees_n, [ n - q, q ] );
        od;
    fi;
    
    return bidegrees_n;
    
end );

##
InstallMethod( LowestBidegreeObjectInSpectralSequence,
        "for homalg spectral sequences",
        [ IsHomalgSpectralSequence, IsInt ],
        
  function( E, r )
    local Er, pq;
    
    Er := CertainSheet( E, r );
    
    if Er = fail then
        return fail;
    fi;
    
    pq := LowestBidegreeInSpectralSequence( E );
    
    return CertainObject( Er, pq );
    
end );

##
InstallMethod( LowestBidegreeObjectInSpectralSequence,
        "for homalg spectral sequences",
        [ IsHomalgSpectralSequence ],
        
  function( E )
    
    return LowestBidegreeObjectInSpectralSequence( E, HighestLevelInSpectralSequence( E ) );
    
end );

##
InstallMethod( HighestBidegreeObjectInSpectralSequence,
        "for homalg spectral sequences",
        [ IsHomalgSpectralSequence, IsInt ],
        
  function( E, r )
    local Er, pq;
    
    Er := CertainSheet( E, r );
    
    if Er = fail then
        return fail;
    fi;
    
    pq := HighestBidegreeInSpectralSequence( E );
    
    return CertainObject( Er, pq );
    
end );

##
InstallMethod( HighestBidegreeObjectInSpectralSequence,
        "for homalg spectral sequences",
        [ IsHomalgSpectralSequence ],
        
  function( E )
    
    return HighestBidegreeObjectInSpectralSequence( E, HighestLevelInSpectralSequence( E ) );
    
end );

##
InstallMethod( CertainMorphism,
        "for homalg spectral sequences",
        [ IsHomalgSpectralSequence, IsList, IsInt ],
        
  function( E, pq, r )
    local Er;
    
    Er := CertainSheet( E, r );
    
    if Er = fail then
        return fail;
    fi;
    
    return CertainMorphism( Er, pq );
    
end );

##
InstallMethod( CertainMorphism,
        "for homalg spectral sequences",
        [ IsHomalgSpectralSequence, IsList ],
        
  function( E, pq )
    
    return CertainMorphism( E, pq, HighestLevelInSpectralSequence( E ) );
    
end );

##
InstallMethod( UnderlyingBicomplex,
        "for homalg spectral sequences stemming from a bicomplex",
        [ IsHomalgSpectralSequenceAssociatedToABicomplex ],
        
  function( E )
    
    if IsBound(E!.bicomplex) then
        return E!.bicomplex;
    fi;
    
    Error( "it seems that the spectral sequence does not stem from a bicomplex\n" );
    
end );

##
InstallMethod( AssociatedFilteredComplex,
        "for homalg spectral sequences stemming from a bicomplex",
        [ IsHomalgSpectralSequenceAssociatedToABicomplex ],
        
  function( E )
    
    return TotalComplex( UnderlyingBicomplex( E ) );
    
end );

##
InstallMethod( AssociatedFirstSpectralSequence,
        "for homalg spectral sequences stemming from a bicomplex",
        [ IsHomalgSpectralSequenceAssociatedToABicomplex ],
        
  function( II_E )
    local BC, I_E;
    
    if not IsBound(II_E!.TransposedSpectralSequence) then
        BC := UnderlyingBicomplex( II_E );
        
        if not IsTransposedWRTTheAssociatedComplex( BC ) then
            return fail;	## this doesn't seem like the second spectral sequence
        fi;
        
        BC := TransposedBicomplex( BC );
        
        ## the first spectral sequence associated to BC,
        ## also called the first spectral sequence of the bicomplex BC;
        ## it becomes intrinsic at the second level (w.r.t. some original data)
        ## which is often its limit sheet
        I_E := HomalgSpectralSequence( BC );
        
        ## enforce computation till the second sheet, even if things stabilize earlier
        if HighestLevelInSpectralSequence( I_E ) < 2 then
            I_E := HomalgSpectralSequence( 2, BC );	## FIXME: find a way to avoid recomputing things
        fi;
        
        ## finally enrich the second spectral sequence with the first
        II_E!.TransposedSpectralSequence := I_E;
        
    fi;
    
    return II_E!.TransposedSpectralSequence;
    
end );

##
InstallMethod( LevelOfStability,
        "for homalg spectral sequences",
        [ IsHomalgSpectralSequenceAssociatedToABicomplex, IsList, IsInt ],
        
  function( E, pq, a )
    local bidegrees, p, q, i, j, lq, r, Er;
    
    if CertainObject( E, pq ) = fail then
        return fail;
    fi;
    
    bidegrees := ObjectDegreesOfSpectralSequence( E );
    
    p := bidegrees[1];
    q := bidegrees[2];
    
    i := Position( p, pq[1] );
    j := Position( q, pq[2] );
    
    lq := Length( q );
    
    for r in LevelsOfSpectralSequence( E ) do
        Er := CertainSheet( E, r );
        if IsBound( Er!.stability_table ) and Er!.stability_table[lq-j+1][i] in [ '.', 's' ] then
            return Maximum( r, a );
        fi;
    od;
    
    return fail;
    
end );

##
InstallMethod( LevelOfStability,
        "for homalg spectral sequences",
        [ IsHomalgSpectralSequenceAssociatedToABicomplex, IsList ],
        
  function( E, pq )
    
    return LevelOfStability( E, pq, LevelsOfSpectralSequence( E )[1] );
    
end );

##
InstallMethod( StaircaseOfStability,
        "for homalg spectral sequences",
        [ IsHomalgSpectralSequenceAssociatedToABicomplex, IsList, IsInt ],
        
  function( E, pq, a )
    local l, bidegrees, p, q, r, Er, st, c;
    
    l := LevelOfStability( E, pq, a ) - a;
    
    ## the trivial cases:
    if l = 0 then
        return [ 0 ];
    elif l = 1 then
        return [ 1 ];
    elif l = fail then
        return fail;
    fi;
    
    bidegrees := ObjectDegreesOfSpectralSequence( E );
    
    p := pq[1];
    q := pq[2];
    
    st := [ ];
    c := 1;
    
    for r in Filtered( LevelsOfSpectralSequence( E ), i -> i >= a + 1 and i <= a + l ) do
        Er := CertainSheet( E, r );
        if IsBound( Er!.embeddings ) then
            if IsIsomorphism( Er!.embeddings.(String( [ p, q ] )) ) then
                c := c + 1;
            else
                Add( st, c );
                c := 1;
            fi;
        else
            return fail;
        fi;
    od;
    
    if st = [ ] then
        return fail;
    else
        return st;
    fi;
    
end );

##
InstallMethod( StaircaseOfStability,
        "for homalg spectral sequences",
        [ IsHomalgSpectralSequenceAssociatedToABicomplex, IsList ],
        
  function( E, pq )
    
    return StaircaseOfStability( E, pq, LevelsOfSpectralSequence( E )[1] );
    
end );

##
InstallMethod( DecideZero,
        "for homalg spectral sequences",
        [ IsHomalgSpectralSequence ],
        
  function( E )
    
    return DecideZero( HighestLevelSheetInSpectralSequence( E ) );
    
end );

##  <#GAPDoc Label="ByASmallerPresentation:spectralsequence">
##  <ManSection>
##    <Meth Arg="E" Name="ByASmallerPresentation" Label="for spectral sequences"/>
##    <Returns>a &homalg; spectral sequence</Returns>
##    <Description>
##    See <Ref Meth="ByASmallerPresentation" Label="for bigraded objects"/> on bigraded object.
##      <Listing Type="Code"><![CDATA[
InstallMethod( ByASmallerPresentation,
        "for homalg spectral sequences",
        [ IsHomalgSpectralSequence ],
        
  function( E )
    
    ByASmallerPresentation( HighestLevelSheetInSpectralSequence( E ) );
    
    if IsBound( E!.TransposedSpectralSequence ) then
        ByASmallerPresentation( E!.TransposedSpectralSequence );
    fi;
    
    return E;
    
end );
##  ]]></Listing>
##      This method performs side effects on its argument <A>E</A> and returns it.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>

####################################
#
# constructor functions and methods:
#
####################################

##  <#GAPDoc Label="HomalgSpectralSequence">
##  <ManSection>
##    <Oper Arg="r, B, a" Name="HomalgSpectralSequence" Label="constructor for spectral sequences given a bicomplex"/>
##    <Oper Arg="r, B" Name="HomalgSpectralSequence" Label="constructor for spectral sequences without a special sheet given a bicomplex"/>
##    <Oper Arg="B, a" Name="HomalgSpectralSequence" Label="constructor for spectral sequences without bound given a bicomplex"/>
##    <Oper Arg="B" Name="HomalgSpectralSequence" Label="constructor for spectral sequences without bound and without a special sheet given a bicomplex"/>
##    <Returns>a &homalg; spectral sequence</Returns>
##    <Description>
##    The first syntax is the main constructor. It creates the homological (resp. cohomological) spectral sequence
##    associated to the homological (resp. cohomological) bicomplex <A>B</A> starting at level <M>0</M> and ending
##    at level <A>r</A><M>\geq 0</M> (regardless if the spectral sequence stabilizes earlier). The generalized embeddings
##    into the objects of 0-th sheet are always computed for each higher sheet <M>Er</M> and stored as
##    a record under the component <M>Er</M>!.absolute_embeddings. If <A>a</A> is greater than <M>0</M> the generalized
##    embeddings into the objects of the <A>a</A>-th sheet also get computed for each higher sheet <M>Er</M> and stored
##    as a record under the component <M>Er</M>!.relative_embeddings. The level <A>a</A> at which the spectral sequence
##    becomes intrinsic is a natural candidate for <A>a</A>. The <A>a</A>-th sheet is called the <E>special</E> sheet.
##    <P/>
##    If <A>r</A><M>=-1</M> it computes all the sheets of the spectral sequence until the sequence stabilizes,
##    i.e. until all higher arrows become zero.
##    <P/>
##    If <A>a</A><M>=-1</M> no special sheet is specified.
##    <P/>
##    In the second syntax <A>a</A> is set to <M>-1</M>.
##    <P/>
##    In the third syntax <A>r</A> is set to <M>-1</M>.
##    <P/>
##    In the fourth syntax both <A>r</A> and <A>a</A> are set to <M>-1</M>.
##    <P/>
##    The following example demonstrates the computation of a <M>Tor-Ext</M> spectral sequence:
##      <Example><![CDATA[
##  gap> ZZ := HomalgRingOfIntegers( );;
##  gap> M := HomalgMatrix( "[ 2, 3, 4,   5, 6, 7 ]", 2, 3, ZZ );;
##  gap> M := LeftPresentation( M );
##  <A non-torsion left module presented by 2 relations for 3 generators>
##  gap> dM := Resolution( M );
##  <A non-zero right acyclic complex containing a single morphism of left modules\
##   at degrees [ 0 .. 1 ]>
##  gap> CC := Hom( dM, dM );
##  <A non-zero acyclic cocomplex containing a single morphism of right complexes \
##  at degrees [ 0 .. 1 ]>
##  gap> B := HomalgBicomplex( CC );
##  <A non-zero bicocomplex containing right modules at bidegrees [ 0 .. 1 ]x
##  [ -1 .. 0 ]>
##  ]]></Example>
##    Now we construct the spectral sequence associated to the bicomplex <M>B</M>, also called the <E>first</E>
##    spectral sequence:
##      <Example><![CDATA[
##  gap> I_E := HomalgSpectralSequence( 2, B );
##  <A stable cohomological spectral sequence with sheets at levels 
##  [ 0 .. 2 ] each consisting of right modules at bidegrees [ 0 .. 1 ]x
##  [ -1 .. 0 ]>
##  gap> Display( I_E );
##  a cohomological spectral sequence at bidegrees
##  [ [ 0 .. 1 ], [ -1 .. 0 ] ]
##  ---------
##  Level 0:
##  
##   * *
##   * *
##  ---------
##  Level 1:
##  
##   * *
##   . .
##  ---------
##  Level 2:
##  
##   s s
##   . .
##  ]]></Example>
##    Legend:
##    <List>
##      <Item>A star <A>*</A> stands for a nonzero module.</Item>
##      <Item>A dot <A>.</A> stands for a zero module.</Item>
##      <Item>The letter <A>s</A> stands for a nonzero module that became stable.</Item>
##    </List>
##    <P/>
##    The <E>second</E> spectral sequence of the bicomplex is, by definition, the spectral sequence associated to
##    the transposed bicomplex:
##      <Example><![CDATA[
##  gap> tB := TransposedBicomplex( B );
##  <A non-zero bicocomplex containing right modules at bidegrees [ -1 .. 0 ]x
##  [ 0 .. 1 ]>
##  gap> II_E := HomalgSpectralSequence( tB, 2 );
##  <A stable cohomological spectral sequence with sheets at levels 
##  [ 0 .. 2 ] each consisting of right modules at bidegrees [ -1 .. 0 ]x
##  [ 0 .. 1 ]>
##  gap> Display( II_E );
##  a cohomological spectral sequence at bidegrees
##  [ [ -1 .. 0 ], [ 0 .. 1 ] ]
##  ---------
##  Level 0:
##  
##   * *
##   * *
##  ---------
##  Level 1:
##  
##   * *
##   * *
##  ---------
##  Level 2:
##  
##   s s
##   . s
##  ]]></Example>
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
InstallMethod( HomalgSpectralSequence,
        "for homalg bicomplexes",
        [ IsInt, IsHomalgBicomplex, IsInt ],
        
  function( r, B, a )				## a could, for example, be the level where E_r becomes intrinsic
    local bidegrees, E, Ei, type, rr, i;
    
    bidegrees := ObjectDegreesOfBicomplex( B );
    
    E := rec( bidegrees := bidegrees,
              levels := [ 0 ],
              bicomplex := B );
    
    Ei := HomalgBigradedObject( B );
    
    E.0 := Ei;
    
    if IsHomalgLeftObjectOrMorphismOfLeftObjects( E.0 ) then
        if IsBicomplexOfFinitelyPresentedObjectsRep( B ) then
            type := TheTypeHomalgSpectralSequenceAssociatedToABicomplexOfLeftObjects;
        else
            type := TheTypeHomalgSpectralCosequenceAssociatedToABicomplexOfLeftObjects;
        fi;
    else
        if IsBicomplexOfFinitelyPresentedObjectsRep( B ) then
            type := TheTypeHomalgSpectralSequenceAssociatedToABicomplexOfRightObjects;
        else
            type := TheTypeHomalgSpectralCosequenceAssociatedToABicomplexOfRightObjects;
        fi;
    fi;
    
    rr := r;
    i := 0;
    
    while rr <> 0 do
        if r <  0 and
           ( ( IsZero( Ei ) and i > 0 ) or
             ( ( HasIsStableSheet( Ei ) or IsBound( Ei!.stable ) ) and IsStableSheet( Ei ) ) ) then
            break;
        fi;
        AsDifferentialObject( Ei );
        if i = a then
            ## generalized embeddings into this sheet are computed
            Ei!.SpecialSheet := true;
        fi;
        Ei := DefectOfExactness( Ei );
        i := i + 1;
        Add( E.levels, i );
        E.(String(i)) := Ei;
        rr := rr - 1;
    od;
    
    ConvertToRangeRep( E.levels );
    
    ## Objectify
    Objectify( type, E );
    
    return E;
    
end );


##
InstallMethod( HomalgSpectralSequence,
        "for homalg bicomplexes",
        [ IsInt, IsHomalgBicomplex ],
        
  function( r, B )
    
    return HomalgSpectralSequence( r, B, -1 );
    
end );

##
InstallMethod( HomalgSpectralSequence,
        "for homalg bicomplexes",
        [ IsHomalgBicomplex, IsInt ],
        
  function( B, a )
    local E;
    
    E := HomalgSpectralSequence( -1, B, a );
    
    SetSpectralSequence( B, E );
    
    return E;
    
end );

##
InstallMethod( HomalgSpectralSequence,
        "for homalg bicomplexes",
        [ IsHomalgBicomplex ],
        
  function( B )
    local E;
    
    E := HomalgSpectralSequence( -1, B, -1 );
    
    SetSpectralSequence( B, E );
    
    return E;
    
end );

####################################
#
# View, Print, and Display methods:
#
####################################

##
InstallMethod( ViewObj,
        "for homalg spectral sequences",
        [ IsHomalgSpectralSequence ],
        
  function( o )
    local Er, levels, degrees, l, opq;
    
    Print( "<A" );
    
    if HasIsZero( o ) then ## if this method applies and HasIsZero is set we already know that o is a non-zero homalg spectral sequence
        Print( " non-zero" );
    fi;
    
    Er := HighestLevelSheetInSpectralSequence( o );
    
    if HasIsStableSheet( Er ) then
        if IsStableSheet( Er ) then
            Print( " stable" );
        else
            Print( " yet unstable" );
        fi;
    fi;
    
    if IsSpectralCosequenceOfFinitelyPresentedObjectsRep( o ) then
        Print( " co" );
    else
        Print( " " );
    fi;
    
    Print( "homological spectral sequence with " );
    
    levels := o!.levels;
    
    if Length( levels ) = 1 then
        Print( "a single sheet at level ", levels[1], " consisting of " );
    else
        Print( "sheets at levels ", levels, " each consisting of " );
    fi;
    
    degrees := ObjectDegreesOfSpectralSequence( o );
    
    l := Length( degrees[1] ) * Length( degrees[2] );
    
    opq := CertainObject( o, [ degrees[1][1], degrees[2][1] ] );
    
    if l = 1 then
        
        Print( "a single " );
        
        if IsHomalgLeftObjectOrMorphismOfLeftObjects( o ) then
            Print( "left" );
        else
            Print( "right" );
        fi;
        
        if IsHomalgStaticObject( opq ) then
            if IsBound( opq!.string ) then
                Print( " ", opq!.string );
            else
                Print( " object" );
            fi;
        else
            if IsComplexOfFinitelyPresentedObjectsRep( opq ) then
                Print( " complex" );
            else
                Print( " cocomplex" );
            fi;
        fi;
        
        Print( " per sheet at bidegree ", [ degrees[1][1], degrees[2][1] ], ">" );
        
    else
        
        if IsHomalgLeftObjectOrMorphismOfLeftObjects( o ) then
            Print( "left" );
        else
            Print( "right" );
        fi;
        
        if IsHomalgStaticObject( opq ) then
            if IsBound( opq!.string_plural ) then
                Print( " ", opq!.string_plural );
            else
                Print( " objects" );
            fi;
        else
            if IsComplexOfFinitelyPresentedObjectsRep( opq ) then
                Print( " complexes" );
            else
                Print( " cocomplexes" );
            fi;
        fi;
        
        Print( " at bidegrees ", degrees[1], "x", degrees[2], ">" );
        
    fi;
    
end );

##
InstallMethod( ViewObj,
        "for homalg spectral sequences",
        [ IsHomalgSpectralSequence and IsZero ],
        
  function( o )
    
    Print( "<A zero " );
    
    if IsHomalgLeftObjectOrMorphismOfLeftObjects( o ) then
        Print( "left" );
    else
        Print( "right" );
    fi;
    
    if IsSpectralCosequenceOfFinitelyPresentedObjectsRep( o ) then
        Print( " co" );
    else
        Print( " " );
    fi;
    
    Print( "homological spectral sequence>" );
    
end );

##
InstallMethod( Display,
        "for homalg spectral sequences",
        [ IsHomalgSpectralSequence ],
        
  function( o )
    local I_E, Ers, Er;
    
    if IsBound( o!.TransposedSpectralSequence ) then
        Print( "The associated transposed spectral sequence:\n\n" );
        Display( o!.TransposedSpectralSequence );
        Print( "\nNow the spectral sequence of the bicomplex:\n\n" );
    fi;
    
    Ers := SheetsOfSpectralSequence( o );
    
    Print( "a " );
    
    if IsSpectralCosequenceOfFinitelyPresentedObjectsRep( o ) then
        Print( "co" );
    fi;
    
    Print( "homological spectral sequence at bidegrees\n", ObjectDegreesOfSpectralSequence( o ), "\n---------\n" );
    
    Display( Ers[1] );
    
    for Er in Ers{[ 2 .. Length( Ers ) ]} do
        Print( "---------\n" );
        Display( Er );
    od;
    
end );

