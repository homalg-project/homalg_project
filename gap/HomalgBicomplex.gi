#############################################################################
##
##  HomalgBicomplex.gi          homalg package               Mohamed Barakat
##
##  Copyright 2007-2008 Lehrstuhl B für Mathematik, RWTH Aachen
##
##  Implementations for homalg bicomplexes.
##
#############################################################################

##  <#GAPDoc Label="Bicomplexes:intro">
##    Each bicomplex in &homalg; has an underlying complex of complexes. The bicomplex structure is simply
##    the addition of the known sign trick which induces the obvious equivalence between the category of bicomplexes
##    and the category of complexes with complexes as objects and chain maps as morphisms.
##    The majority of filtered complexes in algebra and geometry (unlike topology) arise as the total complex
##    of a bicomplex. Hence, most spectral sequences in algebra are spectral sequences of bicomplexes.
##    Indeed, bicomplexes in &homalg; are mainly used as an input for the spectral sequence machinery.
##  <#/GAPDoc>

####################################
#
# representations:
#
####################################

##  <#GAPDoc Label="IsBicomplexOfFinitelyPresentedObjectsRep">
##  <ManSection>
##    <Filt Type="Representation" Arg="BC" Name="IsBicomplexOfFinitelyPresentedObjectsRep"/>
##    <Returns><C>true</C> or <C>false</C></Returns>
##    <Description>
##      The &GAP; representation of bicomplexes (homological bicomplexes) of finitley generated &homalg; objects. <P/>
##      (It is a representation of the &GAP; category <Ref Filt="IsHomalgBicomplex"/>,
##       which is a subrepresentation of the &GAP; representation <C>IsFinitelyPresentedObjectRep</C>.)
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareRepresentation( "IsBicomplexOfFinitelyPresentedObjectsRep",
        IsHomalgBicomplex and IsFinitelyPresentedObjectRep,
        [  ] );

##  <#GAPDoc Label="IsBicocomplexOfFinitelyPresentedObjectsRep">
##  <ManSection>
##    <Filt Type="Representation" Arg="BC" Name="IsBicocomplexOfFinitelyPresentedObjectsRep"/>
##    <Returns><C>true</C> or <C>false</C></Returns>
##    <Description>
##      The &GAP; representation of bicocomplexes (cohomological bicomplexes) of finitley generated &homalg; objects. <P/>
##      (It is a representation of the &GAP; category <Ref Filt="IsHomalgBicomplex"/>,
##       which is a subrepresentation of the &GAP; representation <C>IsFinitelyPresentedObjectRep</C>.)
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareRepresentation( "IsBicocomplexOfFinitelyPresentedObjectsRep",
        IsHomalgBicomplex and IsFinitelyPresentedObjectRep,
        [  ] );

####################################
#
# families and types:
#
####################################

# a new family:
BindGlobal( "TheFamilyOfHomalgBicomplexes",
        NewFamily( "TheFamilyOfHomalgBicomplexes" ) );

# four new types:
BindGlobal( "TheTypeHomalgBicomplexOfLeftObjects",
        NewType( TheFamilyOfHomalgBicomplexes,
                IsBicomplexOfFinitelyPresentedObjectsRep and IsHomalgLeftObjectOrMorphismOfLeftObjects ) );

BindGlobal( "TheTypeHomalgBicomplexOfRightObjects",
        NewType( TheFamilyOfHomalgBicomplexes,
                IsBicomplexOfFinitelyPresentedObjectsRep and IsHomalgRightObjectOrMorphismOfRightObjects ) );

BindGlobal( "TheTypeHomalgBicocomplexOfLeftObjects",
        NewType( TheFamilyOfHomalgBicomplexes,
                IsBicocomplexOfFinitelyPresentedObjectsRep and IsHomalgLeftObjectOrMorphismOfLeftObjects ) );

BindGlobal( "TheTypeHomalgBicocomplexOfRightObjects",
        NewType( TheFamilyOfHomalgBicomplexes,
                IsBicocomplexOfFinitelyPresentedObjectsRep and IsHomalgRightObjectOrMorphismOfRightObjects ) );

####################################
#
# methods for attributes:
#
####################################

##
InstallMethod( TotalComplex,
        "for homalg bicomplexes",
        [ IsBicomplexOfFinitelyPresentedObjectsRep ],
        
  function( B )
    local pq_lowest, n_lowest, n_highest, tot, n;
    
    pq_lowest := LowestBidegreeInBicomplex( B );
    
    n_lowest := pq_lowest[1] + pq_lowest[2];
    n_highest := HighestTotalObjectDegreeInBicomplex( B );
    
    tot := HomalgComplex( CertainObject( B, pq_lowest ), n_lowest );
    
    for n in [ n_lowest + 1 .. n_highest ] do
        Add( tot, MorphismOfTotalComplex( B, n ) );
    od;
    
    if HasIsBicomplex( B ) then
        SetIsComplex( tot, IsBicomplex( B ) );
    fi;
    
    return tot;
    
end );

##
InstallMethod( TotalComplex,
        "for homalg bicomplexes",
        [ IsBicomplexOfFinitelyPresentedObjectsRep and IsTransposedWRTTheAssociatedComplex ],
        
  function( B )
    
    return TotalComplex( TransposedBicomplex( B ) );
    
end );

##
InstallMethod( TotalComplex,
        "for homalg bicomplexes",
        [ IsBicocomplexOfFinitelyPresentedObjectsRep ],
        
  function( B )
    local pq_lowest, n_lowest, n_highest, tot, n;
    
    pq_lowest := LowestBidegreeInBicomplex( B );
    
    n_lowest := pq_lowest[1] + pq_lowest[2];
    n_highest := HighestTotalObjectDegreeInBicomplex( B );
    
    tot := HomalgCocomplex( CertainObject( B, pq_lowest ), n_lowest );
    
    for n in [ n_lowest .. n_highest - 1 ] do
        Add( tot, MorphismOfTotalComplex( B, n ) );
    od;
    
    if HasIsBicomplex( B ) then
        SetIsComplex( tot, IsBicomplex( B ) );
    fi;
    
    return tot;
    
end );

##
InstallMethod( TotalComplex,
        "for homalg bicomplexes",
        [ IsBicocomplexOfFinitelyPresentedObjectsRep and IsTransposedWRTTheAssociatedComplex ],
        
  function( B )
    
    return TotalComplex( TransposedBicomplex( B ) );
    
end );

##
InstallMethod( SpectralSequence,
        "for homalg bicomplexes",
        [ IsHomalgBicomplex ],
        
  function( B )
    
    return HomalgSpectralSequence( B );
    
end );

####################################
#
# methods for operations:
#
####################################

##  <#GAPDoc Label="UnderlyingComplex">
##  <ManSection>
##    <Func Arg="BC" Name="UnderlyingComplex"/>
##    <Returns>a &homalg; complex</Returns>
##    <Description>
##    The (co)complex of (co)complexes underlying the (co)homological bicomplex <A>BC</A>.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
InstallMethod( UnderlyingComplex,
        "for homalg bicomplexes",
        [ IsHomalgBicomplex ],
        
  function( B )
    
    return B!.complex;
    
end );

##
InstallMethod( homalgResetFilters,
        "for homalg bicomplexes",
        [ IsHomalgBicomplex ],
        
  function( B )
    local property;
    
    if not IsBound( HOMALG.PropertiesOfBicomplexes ) then
        HOMALG.PropertiesOfBicomplexes :=
          [ IsZero,
            IsBisequence,
            IsBicomplex ];
    fi;
    
    for property in HOMALG.PropertiesOfBicomplexes do
        ResetFilterObj( B, property );
    od;
    
    if HasTotalComplex( B ) then
        ResetFilterObj( B, TotalComplex );
        Unbind( B!.TotalComplex );
    fi;
    
    if HasSpectralSequence( B ) then
        ResetFilterObj( B, SpectralSequence );
        Unbind( B!.SpectralSequence );
    fi;
    
end );

##
InstallMethod( ObjectDegreesOfBicomplex,
        "for homalg bicomplexes",
        [ IsHomalgBicomplex ],
        
  function( B )
    local C, deg_p, o, deg_q;
    
    C := UnderlyingComplex( B );
    
    deg_p := ObjectDegreesOfComplex( C );
    
    o := LowestDegreeObject( C );
    
    deg_q := ObjectDegreesOfComplex( o );
    
    if IsComplexOfFinitelyPresentedObjectsRep( C ) and IsCocomplexOfFinitelyPresentedObjectsRep( o ) then
        deg_q := Reversed( -deg_q );
        ConvertToRangeRep( deg_q );
    elif IsCocomplexOfFinitelyPresentedObjectsRep( C ) and IsComplexOfFinitelyPresentedObjectsRep( o ) then
        deg_q := Reversed( -deg_q );
        ConvertToRangeRep( deg_q );
    fi;
    
    if HasIsTransposedWRTTheAssociatedComplex( B ) and
       IsTransposedWRTTheAssociatedComplex( B ) then
        return [ deg_q, deg_p ];
    else
        return [ deg_p, deg_q ];
    fi;
    
end );

##
InstallMethod( CertainObject,
        "for homalg bicomplexes",
        [ IsHomalgBicomplex, IsList ],
        
  function( B, pq )
    local bidegree, C, obj_p;
    
    if not ForAll( pq, IsInt ) or not Length( pq ) = 2 then
        Error( "the second argument must be a list of two integers\n" );
    fi;
    
    bidegree := B!.bidegree_getter( pq );
    
    C := UnderlyingComplex( B );
    
    obj_p := CertainObject( C, bidegree[1] );
    
    if obj_p = fail then
        return fail;
    fi;
    
    return CertainObject( obj_p, bidegree[2] );
    
end );

##
InstallMethod( ObjectsOfBicomplex,
        "for homalg bicomplexes",
        [ IsHomalgBicomplex ],
        
  function( B )
    local bidegrees;
    
    bidegrees := ObjectDegreesOfBicomplex( B );
    
    return List( Reversed( bidegrees[2] ), q -> List( bidegrees[1], p -> CertainObject( B, [ p, q ] ) ) );
    
end );

##
InstallMethod( LowestBidegreeInBicomplex,
        "for homalg bicomplexes",
        [ IsHomalgBicomplex ],
        
  function( B )
    local bidegrees;
    
    bidegrees := ObjectDegreesOfBicomplex( B );
    
    return [ bidegrees[1][1], bidegrees[2][1] ];
    
end );

##
InstallMethod( HighestBidegreeInBicomplex,
        "for homalg bicomplexes",
        [ IsHomalgBicomplex ],
        
  function( B )
    local bidegrees;
    
    bidegrees := ObjectDegreesOfBicomplex( B );
    
    return [ bidegrees[1][Length( bidegrees[1] )], bidegrees[2][Length( bidegrees[2] )] ];
    
end );

##
InstallMethod( LowestTotalObjectDegreeInBicomplex,
        "for homalg bicomplexes",
        [ IsHomalgBicomplex ],
        
  function( B )
    local pq_lowest;
    
    pq_lowest := LowestBidegreeInBicomplex( B );
    
    return pq_lowest[1] + pq_lowest[2];
    
end );

##
InstallMethod( HighestTotalObjectDegreeInBicomplex,
        "for homalg bicomplexes",
        [ IsHomalgBicomplex ],
        
  function( B )
    local pq_highest;
    
    pq_highest := HighestBidegreeInBicomplex( B );
    
    return pq_highest[1] + pq_highest[2];
    
end );

##
InstallMethod( TotalObjectDegreesOfBicomplex,
        "for homalg bicomplexes",
        [ IsHomalgBicomplex ],
        
  function( B )
    
    return [ LowestTotalObjectDegreeInBicomplex( B ) .. HighestTotalObjectDegreeInBicomplex( B ) ];
    
end );

##
InstallMethod( LowestBidegreeObjectInBicomplex,
        "for homalg bicomplexes",
        [ IsHomalgBicomplex ],
        
  function( B )
    local pq;
    
    pq := LowestBidegreeInBicomplex( B );
    
    return CertainObject( B, pq );
    
end );

##
InstallMethod( HighestBidegreeObjectInBicomplex,
        "for homalg bicomplexes",
        [ IsHomalgBicomplex ],
        
  function( B )
    local pq;
    
    pq := HighestBidegreeInBicomplex( B );
    
    return CertainObject( B, pq );
    
end );

##
InstallMethod( CertainVerticalMorphism,
        "for homalg bicomplexes",
        [ IsHomalgBicomplex, IsList ],
        
  function( B, pq )
    local bidegree, C, obj_p, mor;
    
    if not ForAll( pq, IsInt ) or not Length( pq ) = 2 then
        Error( "the second argument must be a list of two integers\n" );
    fi;
    
    bidegree := B!.bidegree_getter( pq );
    
    C := UnderlyingComplex( B );
    
    obj_p := CertainObject( C, bidegree[1] );
    
    if obj_p = fail then
        return fail;
    fi;
    
    mor := CertainMorphism( obj_p, bidegree[2] );
    
    if mor = fail then
        return fail;
    fi;
    
    if IsEvenInt( pq[1] ) then
        return mor;
    else
        return -mor;
    fi;
    
end );

##
InstallMethod( CertainVerticalMorphism,
        "for homalg bicomplexes",
        [ IsHomalgBicomplex and IsTransposedWRTTheAssociatedComplex, IsList ],
        
  function( B, pq )
    local bidegree, C, mor_p;
    
    if not ForAll( pq, IsInt ) or not Length( pq ) = 2 then
        Error( "the second argument must be a list of two integers\n" );
    fi;
    
    bidegree := B!.bidegree_getter( pq );
    
    C := UnderlyingComplex( B );
    
    mor_p := CertainMorphism( C, bidegree[1] );
    
    if mor_p = fail then
        return fail;
    fi;
    
    return CertainMorphism( mor_p, bidegree[2] );
    
end );

##
InstallMethod( CertainHorizontalMorphism,
        "for homalg bicomplexes",
        [ IsHomalgBicomplex, IsList ],
        
  function( B, pq )
    local bidegree, C, mor_p;
    
    if not ForAll( pq, IsInt ) or not Length( pq ) = 2 then
        Error( "the second argument must be a list of two integers\n" );
    fi;
    
    bidegree := B!.bidegree_getter( pq );
    
    C := UnderlyingComplex( B );
    
    mor_p := CertainMorphism( C, bidegree[1] );
    
    if mor_p = fail then
        return fail;
    fi;
    
    return CertainMorphism( mor_p, bidegree[2] );
    
end );

##
InstallMethod( CertainHorizontalMorphism,
        "for homalg bicomplexes",
        [ IsHomalgBicomplex and IsTransposedWRTTheAssociatedComplex, IsList ],
        
  function( B, pq )
    local bidegree, C, obj_p, mor;
    
    if not ForAll( pq, IsInt ) or not Length( pq ) = 2 then
        Error( "the second argument must be a list of two integers\n" );
    fi;
    
    bidegree := B!.bidegree_getter( pq );
    
    C := UnderlyingComplex( B );
    
    obj_p := CertainObject( C, bidegree[1] );
    
    if obj_p = fail then
        return fail;
    fi;
    
    mor := CertainMorphism( obj_p, bidegree[2] );
    
    if mor = fail then
        return fail;
    fi;
    
    if IsEvenInt( pq[2] ) then		## yes pq[2], not pq[1]
        return mor;
    else
        return -mor;
    fi;
    
end );

##
InstallMethod( BidegreesOfBicomplex,
        "for homalg bicomplexes",
        [ IsHomalgBicomplex, IsInt ],
        
  function( B, n )
    local bidegrees, lq, max, n_lowest, n_highest, tot_n, p, q;
    
    bidegrees := ObjectDegreesOfBicomplex( B );
    
    lq := Length( bidegrees[2] );
    max := Minimum( Length( bidegrees[1] ),  lq ) - 1;
    
    n_lowest := LowestTotalObjectDegreeInBicomplex( B );
    n_highest := HighestTotalObjectDegreeInBicomplex( B );
    
    tot_n := [ ];
    
    if n < n_lowest or n > n_highest then
        return tot_n;
    fi;
    
    if n - n_lowest < lq then
        for p in bidegrees[1][1] + [ 0 .. Minimum( n - n_lowest, max ) ] do
            Add( tot_n, [ p, n - p ] );
        od;
    else
        for q in bidegrees[2][lq] - [ 0 .. Minimum( n_highest - n, max ) ] do
            Add( tot_n, [ n - q, q ] );
        od;
    fi;
    
    return tot_n;
    
end );

##
InstallMethod( BidegreesOfObjectOfTotalComplex,
        "for homalg bicomplexes",
        [ IsHomalgBicomplex, IsInt ],
        
  function( B, n )
    
    return BidegreesOfBicomplex( B, n );
    
end );

##
InstallMethod( BidegreesOfObjectOfTotalComplex,
        "for homalg bicomplexes",
        [ IsHomalgBicomplex and IsTransposedWRTTheAssociatedComplex, IsInt ],
        
  function( B, n )
    
    return BidegreesOfBicomplex( TransposedBicomplex( B ), n );
    
end );

##
InstallMethod( MorphismOfTotalComplex,
        "for homalg bicomplexes",
        [ IsHomalgBicomplex, IsList, IsList ],
        
  function( B, bidegrees_source, bidegrees_target )
    local horizontal, vertical, stack, pq_source, pq_target, diff, augment, source;
    
    if IsBicomplexOfFinitelyPresentedObjectsRep( B ) then
        horizontal := [ -1, 0 ];
        vertical := [ 0, -1 ];
    else
        horizontal := [ 1, 0 ];
        vertical := [ 0, 1 ];
    fi;
    
    if bidegrees_source = [ ] or bidegrees_target = [ ] then
        return fail;
    fi;
    
    stack := [ ];
    
    for pq_source in bidegrees_source do
        augment := [ ];
        for pq_target in bidegrees_target do
            source := CertainObject( B, pq_source );
            diff := pq_target - pq_source;
            if diff = horizontal then
                Add( augment, CertainHorizontalMorphism( B, pq_source ) );
            elif diff = vertical then
                Add( augment, CertainVerticalMorphism( B, pq_source ) );
            else
                Add( augment, TheZeroMorphism( source, CertainObject( B, pq_target ) ) );
            fi;
        od;
        Add( stack, Iterated( augment, ProductMorphism ) );
    od;
    
    stack := Iterated( stack, CoproductMorphism );
    
    return stack;
    
end );

##
InstallMethod( MorphismOfTotalComplex,
        "for homalg bicomplexes",
        [ IsHomalgBicomplex, IsInt ],
        
  function( B, n )
    local bidegrees_source, bidegrees_target;
    
    bidegrees_source := Reversed( BidegreesOfObjectOfTotalComplex( B, n ) );		## this has the effect, that [ n, 0 ] comes last
    
    if IsBicomplexOfFinitelyPresentedObjectsRep( B ) then
        bidegrees_target := Reversed( BidegreesOfObjectOfTotalComplex( B, n - 1 ) );	## this has the effect, that [ n - 1, 0 ] comes last
    else
        bidegrees_target := Reversed( BidegreesOfObjectOfTotalComplex( B, n + 1 ) );	## this has the effect, that [ n + 1, 0 ] comes last
    fi;
    
    return MorphismOfTotalComplex( B, bidegrees_source, bidegrees_target );
    
end );
    
##
InstallMethod( DecideZero,
        "for homalg bicomplexes",
        [ IsHomalgBicomplex ],
        
  function( B )
    
    DecideZero( UnderlyingComplex( B ) );
    
    IsZero( B );
    
    return B;
    
end );

##  <#GAPDoc Label="ByASmallerPresentation:bicomplex">
##  <ManSection>
##    <Meth Arg="B" Name="ByASmallerPresentation" Label="for bicomplexes"/>
##    <Returns>a &homalg; bicomplex</Returns>
##    <Description>
##    See <Ref Meth="ByASmallerPresentation" Label="for complexes"/> on complexes.
##      <Listing Type="Code"><![CDATA[
InstallMethod( ByASmallerPresentation,
        "for homalg bicomplexes",
        [ IsHomalgBicomplex ],
        
  function( B )
    
    ByASmallerPresentation( UnderlyingComplex( B ) );
    
    IsZero( B );
    
    return B;
    
end );
##  ]]></Listing>
##      This method performs side effects on its argument <A>B</A> and returns it.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>

####################################
#
# constructor functions and methods:
#
####################################

##  <#GAPDoc Label="HomalgBicomplex">
##  <ManSection>
##    <Func Arg="C" Name="HomalgBicomplex" Label="constructor for bicomplexes given a complex of complexes"/>
##    <Returns>a &homalg; bicomplex</Returns>
##    <Description>
##    This constructor creates a bicomplex (homological bicomplex) given a &homalg; complex of (co)complexes <A>C</A>
##    (&see; <Ref Func="HomalgComplex" Label="constructor for complexes given a chain map"/>),
##    resp. creates a bicocomplex (cohomological bicomplex) given a &homalg; cocomplex of (co)complexes <A>C</A>
##    (&see; <Ref Func="HomalgCocomplex" Label="constructor for cocomplexes given a chain map"/>).
##    Using the usual sign-trick a complex of complexes gives rise to a bicomplex and vice versa.
##      <Example><![CDATA[
##  gap> ZZ := HomalgRingOfIntegers( );;
##  gap> M := HomalgMatrix( "[ 2, 3, 4,   5, 6, 7 ]", 2, 3, ZZ );
##  <A homalg internal 2 by 3 matrix>
##  gap> M := LeftPresentation( M );
##  <A non-torsion left module presented by 2 relations for 3 generators>
##  gap> d := Resolution( M );
##  <A non-zero right acyclic complex containing a single morphism of left modules\
##   at degrees [ 0 .. 1 ]>
##  gap> dd := Hom( d );
##  <A non-zero acyclic cocomplex containing a single morphism of right modules at\
##   degrees [ 0 .. 1 ]>
##  gap> C := Resolution( dd );
##  <An acyclic cocomplex containing a single morphism of right complexes at degre\
##  es [ 0 .. 1 ]>
##  gap> CC := Hom( C );
##  <A non-zero acyclic complex containing a single morphism of left cocomplexes a\
##  t degrees [ 0 .. 1 ]>
##  gap> BC := HomalgBicomplex( CC );
##  <A non-zero bicomplex containing left modules at bidegrees [ 0 .. 1 ]x
##  [ -1 .. 0 ]>
##  gap> Display( BC );
##   * *
##   * *
##  gap> UU := UnderlyingComplex( BC );
##  <A non-zero acyclic complex containing a single morphism of left cocomplexes a\
##  t degrees [ 0 .. 1 ]>
##  gap> IsIdenticalObj( UU, CC );
##  true
##  gap> tBC := TransposedBicomplex( BC );
##  <A non-zero bicomplex containing left modules at bidegrees [ -1 .. 0 ]x
##  [ 0 .. 1 ]>
##  gap> Display( tBC );
##   * *
##   * *
##  ]]></Example>
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
InstallGlobalFunction( HomalgBicomplex,
  function( arg )
    local nargs, C, transposed, complex, of_complex, left, type, bidegree_getter, B;
    
    nargs := Length( arg );
    
    if nargs = 0 then
        Error( "empty input\n" );
    fi;
    
    C := arg[1];
    
    if not IsHomalgComplex( C ) or not IsHomalgComplex( LowestDegreeObject( C ) ) then
        Error( "the first argument is not a complex of complexes\n" );
    fi;
    
    if nargs > 1 and IsString( arg[nargs] ) and Length( arg[nargs] ) > 0 and LowercaseString( arg[nargs]{[1]} )= "t" then
        transposed := true;
    else
        transposed := false;
    fi;
    
    complex := IsComplexOfFinitelyPresentedObjectsRep( C );
    of_complex := IsComplexOfFinitelyPresentedObjectsRep( LowestDegreeObject( C ) );
    
    left := IsHomalgLeftObjectOrMorphismOfLeftObjects( C );
    
    if complex then
        if left then
            type := TheTypeHomalgBicomplexOfLeftObjects;
        else
            type := TheTypeHomalgBicomplexOfRightObjects;
        fi;
    else
        if left then
            type := TheTypeHomalgBicocomplexOfLeftObjects;
        else
            type := TheTypeHomalgBicocomplexOfRightObjects;
        fi;
    fi;
    
    if ( complex and of_complex ) or ( not complex and not of_complex ) then
        if transposed then
            bidegree_getter := function( pq ) return [ pq[2], pq[1] ]; end;
        else
            bidegree_getter := function( pq ) return [ pq[1], pq[2] ]; end;
        fi;
    else
        if transposed then
            bidegree_getter := function( pq ) return [ pq[2], -pq[1] ]; end;
        else
            bidegree_getter := function( pq ) return [ pq[1], -pq[2] ]; end;
        fi;
    fi;
    
    B := rec( complex := C,
              bidegree_getter := bidegree_getter );
    
    ## Objectify
    ObjectifyWithAttributes(
            B, type,
            IsTransposedWRTTheAssociatedComplex, transposed );
    
    if HasIsComplex( C ) then
        SetIsBicomplex( B, IsComplex( C ) );
    elif HasIsSequence( C ) then
        SetIsBisequence( B, IsSequence( C ) );
    fi;
    
    return B;
    
end );

##
InstallMethod( TransposedBicomplex,
        "for homalg bicomplexes",
        [ IsHomalgBicomplex ],
        
  function( B )
    local tB, C;
    
    if IsBound(B!.TransposedBicomplex) then
        return B!.TransposedBicomplex;
    fi;
    
    C := UnderlyingComplex( B );
    
    tB := HomalgBicomplex( C, "TransposedBicomplex" );
    
    B!.TransposedBicomplex := tB;
    tB!.TransposedBicomplex := B;	## thanks GAP
    
    return tB;
    
end );

##
InstallMethod( TransposedBicomplex,
        "for homalg bicomplexes",
        [ IsHomalgBicomplex and IsTransposedWRTTheAssociatedComplex ],
        
  function( tB )
    
    return tB!.TransposedBicomplex;
    
end );

####################################
#
# View, Print, and Display methods:
#
####################################

##
InstallMethod( ViewObj,
        "for homalg bicomplexes",
        [ IsHomalgBicomplex ],
        
  function( o )
    local cpx, degrees, l, opq;
    
    cpx := IsBicomplexOfFinitelyPresentedObjectsRep( o );
    
    Print( "<A" );
    
    if HasIsZero( o ) then ## if this method applies and HasIsZero is set we already know that o is a non-zero homalg bi(co)complex
        Print( " non-zero" );
    fi;
    
    if HasIsBicomplex( o ) then
        if IsBicomplex( o ) then
            if cpx then
                Print( " bicomplex" );
            else
                Print( " bicocomplex" );
            fi;
        else
            if cpx then
                Print( " non-bicomplex" );
            else
                Print( " non-bicocomplex" );
            fi;
        fi;
    elif HasIsSequence( o ) then
        if IsSequence( o ) then
            if cpx then
                Print( " bisequence" );
            else
                Print( " bicosequence" );
            fi;
        else
            if cpx then
                Print( " bisequence of non-well-definded morphisms" );
            else
                Print( " bicosequence of non-well-definded morphisms" );
            fi;
        fi;
    else
        if cpx then
            Print( " \"bicomplex\"" );
        else
            Print( " \"bicocomplex\"" );
        fi;
    fi;
    
    Print( " containing " );
    
    degrees := ObjectDegreesOfBicomplex( o );
    
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
        
        Print( " at bidegree ", [ degrees[1][1], degrees[2][1] ], ">" );
        
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
        "for homalg bicomplexes",
        [ IsBicomplexOfFinitelyPresentedObjectsRep and IsZero ],
        
  function( o )
    local degrees;
    
    degrees := ObjectDegreesOfBicomplex( o );
    
    Print( "<A zero " );
    
    if IsHomalgLeftObjectOrMorphismOfLeftObjects( o ) then
        Print( "left" );
    else
        Print( "right" );
    fi;
    
    Print( " bicomplex with bidegrees ", degrees[1], "x", degrees[2], ">" );
    
end );

##
InstallMethod( ViewObj,
        "for homalg bicomplexes",
        [ IsBicocomplexOfFinitelyPresentedObjectsRep and IsZero ],
        
  function( o )
    local degrees;
    
    degrees := ObjectDegreesOfBicomplex( o );
    
    Print( "<A zero " );
    
    if IsHomalgLeftObjectOrMorphismOfLeftObjects( o ) then
        Print( "left" );
    else
        Print( "right" );
    fi;
    
    Print( " bicocomplex with bidegrees ", degrees[1], "x", degrees[2], ">" );
    
end );

##
InstallMethod( Display,
        "for homalg bicomplexes",
        [ IsHomalgBicomplex ],
        
  function( o )
    local bidegrees, q, p, Bpq;
    
    bidegrees := ObjectDegreesOfBicomplex( o );
    for q in Reversed( bidegrees[2] ) do
        for p in bidegrees[1] do
            Bpq := CertainObject( o, [ p, q ] );
            if HasIsZero( Bpq ) and IsZero( Bpq ) then
                Print( " ." );
            else
                Print( " *" );
            fi;
        od;
        Print( "\n" );
    od;
    
end );

##
InstallMethod( Display,
        "for homalg bicomplexes",
        [ IsBicomplexOfFinitelyPresentedObjectsRep and IsZero ],
        
  function( o )
    
    Print( "0\n" );
    
end );

##
InstallMethod( Display,
        "for homalg bicomplexes",
        [ IsBicocomplexOfFinitelyPresentedObjectsRep and IsZero ],
        
  function( o )
    
    Print( "0\n" );
    
end );

