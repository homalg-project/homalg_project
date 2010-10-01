#############################################################################
##
##  HomalgMorphism.gi           homalg package               Mohamed Barakat
##
##  Copyright 2007-2010, Mohamed Barakat, University of Kaiserslautern
##
##  Implementation for morphisms of (Abelian) categories.
##
#############################################################################

####################################
#
# representations:
#
####################################

##  <#GAPDoc Label="IsMorphismOfFinitelyGeneratedObjectsRep">
##  <ManSection>
##    <Filt Type="Representation" Arg="phi" Name="IsMorphismOfFinitelyGeneratedObjectsRep"/>
##    <Returns><C>true</C> or <C>false</C></Returns>
##    <Description>
##      The &GAP; representation of morphisms of finitley generated &homalg; objects. <P/>
##      (It is a representation of the &GAP; category <Ref Filt="IsHomalgMorphism"/>.)
##    <Listing Type="Code"><![CDATA[
DeclareRepresentation( "IsMorphismOfFinitelyGeneratedObjectsRep",
        IsHomalgMorphism,
        [ ] );
##  ]]></Listing>
##    </Description>
##  </ManSection>
##  <#/GAPDoc>

##  <#GAPDoc Label="IsStaticMorphismOfFinitelyGeneratedObjectsRep">
##  <ManSection>
##    <Filt Type="Representation" Arg="phi" Name="IsStaticMorphismOfFinitelyGeneratedObjectsRep"/>
##    <Returns><C>true</C> or <C>false</C></Returns>
##    <Description>
##      The &GAP; representation of static morphisms of finitley generated &homalg; static objects. <P/>
##      (It is a representation of the &GAP; category <Ref Filt="IsHomalgStaticMorphism"/>,
##       which is a subrepresentation of the &GAP; representation
##       <Ref Filt="IsMorphismOfFinitelyGeneratedObjectsRep"/>.)
##    <Listing Type="Code"><![CDATA[
DeclareRepresentation( "IsStaticMorphismOfFinitelyGeneratedObjectsRep",
        IsHomalgStaticMorphism and
        IsMorphismOfFinitelyGeneratedObjectsRep,
        [ ] );
##  ]]></Listing>
##    </Description>
##  </ManSection>
##  <#/GAPDoc>

####################################
#
# methods for operations:
#
####################################

##
InstallMethod( AreComparableMorphisms,
        "for homalg morphisms",
        [ IsHomalgMorphism, IsHomalgMorphism ],
        
  function( phi1, phi2 )
    
    return IsIdenticalObj( Source( phi1 ), Source( phi2 ) ) and
           IsIdenticalObj( Range( phi1 ), Range( phi2 ) );
    
end );

##
InstallMethod( AreComposableMorphisms,
        "for homalg morphisms",
        [ IsHomalgMorphism and IsHomalgRightObjectOrMorphismOfRightObjects,
          IsHomalgMorphism and IsHomalgRightObjectOrMorphismOfRightObjects ],
        
  function( phi2, phi1 )
    
    return IsIdenticalObj( Range( phi1 ), Source( phi2 ) );
    
end );

##
InstallMethod( AreComposableMorphisms,
        "for homalg morphisms",
        [ IsHomalgMorphism and IsHomalgLeftObjectOrMorphismOfLeftObjects,
          IsHomalgMorphism and IsHomalgLeftObjectOrMorphismOfLeftObjects ],
        
  function( phi1, phi2 )
    
    return IsIdenticalObj( Range( phi1 ), Source( phi2 ) );
    
end );

## a synonym of `-<elm>':
InstallMethod( AdditiveInverseMutable,
        "of homalg morphisms",
        [ IsHomalgMorphism and IsZero ],
        
  function( phi )
    
    return phi;
    
end );

##
## composition is a bifunctor to profit from the caching mechanisms for functors (cf. ToolFunctors.gi)
##

##
InstallMethod( POW,
        "for homalg morphisms",
        [ IsHomalgMorphism, IsInt ],
        
  function( phi, pow )
    local id, inv;
    
    if pow = -1 then
        
        id := TheIdentityMorphism( Range( phi ) );
        
        inv := id / phi;	## mimic lift
        
        if HasIsIsomorphism( phi ) then
            SetIsIsomorphism( inv, IsIsomorphism( phi ) );
        fi;
        
        ## CAUTION: inv might very well be non-well-defined
        return inv;
        
    fi;
    
    TryNextMethod( );
    
end );

##  <#GAPDoc Label="ByASmallerPresentation:morphism">
##  <ManSection>
##    <Meth Arg="phi" Name="ByASmallerPresentation" Label="for morphisms"/>
##    <Returns>a &homalg; map</Returns>
##    <Description>
##    It invokes <C>ByASmallerPresentation</C> for &homalg; (static) objects.
##      <Listing Type="Code"><![CDATA[
InstallMethod( ByASmallerPresentation,
        "for homalg morphisms",
        [ IsStaticMorphismOfFinitelyGeneratedObjectsRep ],
        
  function( phi )
    
    ByASmallerPresentation( Source( phi ) );
    ByASmallerPresentation( Range( phi ) );
    
    return DecideZero( phi );
    
end );
##  ]]></Listing>
##      This method performs side effects on its argument <A>phi</A> and returns it.
##      <Example><![CDATA[
##  gap> ZZ := HomalgRingOfIntegers( );;
##  gap> M := HomalgMatrix( "[ 2, 3, 4,   5, 6, 7 ]", 2, 3, ZZ );
##  <A 2 x 3 matrix over an internal ring>
##  gap> M := LeftPresentation( M );
##  <A non-torsion left module presented by 2 relations for 3 generators>
##  gap> N := HomalgMatrix( "[ 2, 3, 4, 5,   6, 7, 8, 9 ]", 2, 4, ZZ );
##  <A 2 x 4 matrix over an internal ring>
##  gap> N := LeftPresentation( N );
##  <A non-torsion left module presented by 2 relations for 4 generators>
##  gap> mat := HomalgMatrix( "[ \
##  > 1, 0, -2, -4, \
##  > 0, 1,  4,  7, \
##  > 1, 0, -2, -4  \
##  > ]", 3, 4, ZZ );;
##  <A 3 x 4 matrix over an internal ring>
##  gap> phi := HomalgMap( mat, M, N );
##  <A "homomorphism" of left modules>
##  gap> IsMorphism( phi );
##  true
##  gap> phi;
##  <A homomorphism of left modules>
##  gap> Display( phi );
##  [ [   1,   0,  -2,  -4 ],
##    [   0,   1,   4,   7 ],
##    [   1,   0,  -2,  -4 ] ]
##  
##  the map is currently represented by the above 3 x 4 matrix
##  gap> ByASmallerPresentation( phi );
##  <A non-zero homomorphism of left modules>
##  gap> Display( phi );
##  [ [   0,   0,   0 ],
##    [   1,  -1,  -2 ] ]
##  
##  the map is currently represented by the above 2 x 3 matrix
##  gap> M;
##  <A rank 1 left module presented by 1 relation for 2 generators>
##  gap> Display( M );
##  Z/< 3 > + Z^(1 x 1)
##  gap> N;
##  <A rank 2 left module presented by 1 relation for 3 generators>
##  gap> Display( N );
##  Z/< 4 > + Z^(1 x 2)
##  ]]></Example>
##    </Description>
##  </ManSection>
##  <#/GAPDoc>

## this should be the lowest rank method
InstallMethod( PreInverse,
        "for homalg morphisms",
        [ IsHomalgMorphism ],
        
  function( phi )
    
    return fail;
    
end );

## this should be the lowest rank method
InstallMethod( PostInverse,
        "for homalg morphisms",
        [ IsHomalgMorphism ],
        
  function( phi )
    
    return fail;
    
end );

#=======================================================================
# Complete an image-square
#
#  A_ is a free or beta1 is injective ( cf. [HS, Lemma III.3.1]
#                                       and [BR08, Subsection 3.1.2] )
#
#     A_ --(alpha1)--> A
#     |                |
#  (psi=?)    Sq1    (phi)
#     |                |
#     v                v
#     B_ --(beta1)---> B
#
#_______________________________________________________________________

##
InstallMethod( CompleteImageSquare,		### defines: CompleteImageSquare (CompleteImSq)
        "for homalg morphisms",
        [ IsHomalgMorphism,
          IsHomalgMorphism,
          IsHomalgMorphism ],
        
  function( alpha1, phi, beta1 )
    
    return PreCompose( alpha1, phi ) / beta1;	## lift or projective lift
    
end );

#=======================================================================
# Complete a kernel-square
#
#  alpha2 is surjective ( cf. [HS, Lemma III.3.1] )
#
#     A --(alpha2)->> _A
#     |                |
#   (phi)   Sq2   (theta=?)
#     |                |
#     v                v
#     B --(beta2)---> _B
#
#_______________________________________________________________________

##
InstallMethod( CompleteKernelSquare,		### defines: CompleteKernelSquare
        "for homalg morphisms",
        [ IsHomalgMorphism,
          IsHomalgMorphism,
          IsHomalgMorphism ],
        
  function( alpha2, phi, beta2 )
    
    return PreDivide( alpha2, PreCompose( phi, beta2 ) );	## colift
    
end );

##
InstallMethod( DiagonalMorphismOp,
        "for two homalg morphisms",
        [ IsHomalgMorphism, IsHomalgMorphism ],
        
  function( phi1, phi2 )
    local zero_M1_N2, zero_M2_N1, phi1_0, phi2_0;
    
    zero_M1_N2 := TheZeroMorphism( Source( phi1 ), Range( phi2 ) );
    zero_M2_N1 := TheZeroMorphism( Source( phi2 ), Range( phi1 ) );
    
    phi1_0 := ProductMorphism( phi1, zero_M1_N2 );
    phi2_0 := ProductMorphism( zero_M2_N1, phi2 );
    
    return CoproductMorphism( phi1_0, phi2_0 );
    
end );

##
InstallMethod( DiagonalMorphismOp,
	"for a list of homalg morphims a single one",
	[ IsList, IsHomalgMorphism ],

  function( L, phi )

    return Iterated( L, DiagonalMorphismOp );

end );

##
InstallGlobalFunction( DiagonalMorphism,
  function ( arg )
    local  d;
    if Length( arg ) = 0  then
        Error( "<arg> must be nonempty" );
    elif Length( arg ) = 1 and IsList( arg[1] )  then
        if IsEmpty( arg[1] )  then
            Error( "<arg>[1] must be nonempty" );
        fi;
        arg := arg[1];
    fi;
    return DiagonalMorphismOp( arg, arg[1] );
end );

## this should be the lowest rank method
InstallMethod( UpdateObjectsByMorphism,
        "for homalg morphisms",
        [ IsHomalgMorphism ],
        
  function( phi )
    
    ## fallback: do nothing :)
    
end );

