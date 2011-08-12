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
InstallMethod( homalgResetFilters,
        "for homalg static morphisms",
        [ IsHomalgStaticMorphism ],
        
  function( phi )
    local property;
    
    for property in LIMOR.intrinsic_properties do
        ResetFilterObj( phi, ValueGlobal( property ) );
    od;
    
end );

##
InstallMethod( HomalgCategory,
        "for homalg morphisms",
        [ IsHomalgMorphism ],
        
  function( phi )
    
    return HomalgCategory( Source( phi ) );
    
end );

##
InstallMethod( StructureObject,
        "for homalg morphism",
        [ IsHomalgMorphism ],
        
  function( phi )
    
    return StructureObject( Source( phi ) );
    
end );

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
    
    if IsHomalgChainMorphism( phi1 ) and IsHomalgChainMorphism( phi2 ) then
        return Range( phi1 ) = Source( phi2 );
    fi;
    
    return IsIdenticalObj( Range( phi1 ), Source( phi2 ) );
    
end );

##
InstallMethod( AreComposableMorphisms,
        "for homalg morphisms",
        [ IsHomalgMorphism and IsHomalgLeftObjectOrMorphismOfLeftObjects,
          IsHomalgMorphism and IsHomalgLeftObjectOrMorphismOfLeftObjects ],
        
  function( phi1, phi2 )
    
    if IsHomalgChainMorphism( phi1 ) and IsHomalgChainMorphism( phi2 ) then
        return Range( phi1 ) = Source( phi2 );
    fi;
    
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
InstallMethod( AssociatedMorphism,
        "for homalg morphisms",
        [ IsHomalgMorphism ],
        
  function( phi )
    local psi;
    
    if not HasMorphismAid( phi ) then
        return phi;
    fi;
    
    psi := PreCompose( phi, CokernelEpi( MorphismAid( phi ) ) );
    
    Assert( 4, not HasMorphismAid( psi ) or IsZero( MorphismAid( psi ) ) );
    
    if HasMorphismAid( psi ) then
        psi := RemoveMorphismAid( psi );
    fi;
    
    return psi;
    
end );

##
InstallMethod( GetMorphismAid,
        "for homalg morphisms",
        [ IsHomalgMorphism ],
        
  function( phi )
    local aid;
    
    if not HasMorphismAid( phi ) then
        Error( "the morphism does not have a morphism aid" );
    fi;
    
    aid := phi!.MorphismAid;
    
    # This is the "classical" aid:
    if IsHomalgMorphism( aid ) and IsIdenticalObj( Range( phi ), Range( aid ) ) then
        
        return aid;
        
    # PostDivide saves a (list of a) morphism which has the correct aid as the kernel.
    # we get the correct information here:
    elif IsList( aid ) and Length( aid ) = 1 and IsHomalgMorphism( aid[1] ) and IsIdenticalObj( Range( phi ), Source( aid[1] ) ) then
        
        aid := KernelSubobject( aid[1] )!.map_having_subobject_as_its_image;
        
        SetMorphismAid( phi, aid );
        
        return aid;
        
    else
        
        Error( "the morphism has an unknown object as morphism aid" );
        
    fi;
  
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
##  gap> ZZ := HomalgRingOfIntegers( );
##  Z
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

##
InstallMethod( UpdateObjectsByMorphism,
        "for homalg morphisms",
        [ IsHomalgMorphism and IsIsomorphism ],
        
  function( phi )
    
    if HasIsZero( Source( phi ) ) or HasIsZero( Range( phi ) ) then
        IsZero( phi );
    fi;
    
    MatchPropertiesAndAttributes( Source( phi ), Range( phi ), LIMOR.intrinsic_properties, LIMOR.intrinsic_attributes );
    
end );

####################################
#
# View, Print, and Display methods:
#
####################################

##
InstallMethod( ViewObj,
        "for homalg maps",
        [ IsHomalgMorphism ],
        
  function( o )
    local s, S;
    
    s := " ";
    
    S := Source( o );
    
    if IsBound( S!.adjective ) then
        s := Concatenation( s, S!.adjective, " " );
    fi;
    
    if IsHomalgLeftObjectOrMorphismOfLeftObjects( o ) then
        s := Concatenation( s, "left " );
    else
        s := Concatenation( s, "right " );
    fi;
    
    if IsHomalgEndomorphism( o ) then
        if IsBound( S!.string ) then
            s := Concatenation( s, S!.string );
        else
            s := Concatenation( s, "object" );
        fi;
    else
        if IsBound( S!.string_plural ) then
            s := Concatenation( s, S!.string_plural );
        elif IsBound( S!.string ) then
            s := Concatenation( s, S!.string, "s" );
        else
            s := Concatenation( s, "objects" );
        fi;
    fi;
    
    s := Concatenation( ViewString( o ), s, ">" );
    
    if ( HasIsOne( o ) and IsOne( o ) ) or ( HasIsZero( o ) and IsZero( o ) and not HasMorphismAid( o ) ) then
        Print( "<The ", s );
    elif s[1] in "aeiouAEIOU" then
        Print( "<An ", s );
    elif s[1] in "\"" and s[2] in "aeiouAEIOU" then
        Print( "<An ", s );
    else
        Print( "<A ", s );
    fi;
    
end );

##
InstallMethod( ViewString,
        "for homalg maps",
        [ IsHomalgMorphism ],
        
  function( o )
    local s;
    
    s := "";
    
    ## if this method applies and HasIsZero is set we already
    ## know that o is a non-zero morphism of homalg objects
    if HasIsZero( o ) and not IsZero( o ) then
        s := Concatenation( s, "non-zero " );
    fi;
    
    if HasIsMorphism( o ) then
        if IsMorphism( o ) then
            s := Concatenation( s, "homomorphism of" );
        elif HasMorphismAid( o ) then	## otherwise the notion of generalized morphism is meaningless
            if HasIsGeneralizedMorphism( o ) then
                if HasIsGeneralizedIsomorphism( o ) and IsGeneralizedIsomorphism( o ) then
                    s := Concatenation( s, "generalized isomorphism of" );
                elif HasIsGeneralizedMonomorphism( o ) and IsGeneralizedMonomorphism( o ) then
                    s := Concatenation( s, "generalized embedding of" );
                elif HasIsGeneralizedEpimorphism( o ) and IsGeneralizedEpimorphism( o ) then
                    s := Concatenation( s, "generalized epimorphism of" );
                elif IsGeneralizedMorphism( o ) then
                    s := Concatenation( s, "generalized homomorphism of" );
                else
                    s := Concatenation( s, "non-well defined (generalized) map of" );
                fi;
            else
                s := Concatenation( s, "\"generalized homomorphism\" of" );
            fi;
        else
            s := Concatenation( s, "non-well-defined map between" );
        fi;
    else
        if HasMorphismAid( o ) then	## otherwise the notion of generalized morphism is meaningless
            if HasIsGeneralizedMorphism( o ) then
                if HasIsGeneralizedIsomorphism( o ) and IsGeneralizedIsomorphism( o ) then
                    s := Concatenation( s, "generalized isomorphism of" );
                elif HasIsGeneralizedMonomorphism( o ) and IsGeneralizedMonomorphism( o ) then
                    s := Concatenation( s, "generalized embedding of" );
                elif HasIsGeneralizedEpimorphism( o ) and IsGeneralizedEpimorphism( o ) then
                    s := Concatenation( s, "generalized epimorphism of" );
                elif IsGeneralizedMorphism( o ) then
                    s := Concatenation( s, "generalized homomorphism of" );
                else
                    s := Concatenation( s, "non-well defined (generalized) map of" );
                fi;
            else
                s := Concatenation( s, "\"generalized homomorphism\" of" );
            fi;
        else
            s := Concatenation( s, "\"homomorphism\" of" );
        fi;
    fi;
    
    return s;
    
end );

##
InstallMethod( ViewString,
        "for homalg maps",
        [ IsHomalgMorphism and IsMonomorphism ], 896,
        
  function( o )
    local s;
    
    s := "";
    
    ## if this method applies and HasIsZero is set we already
    ## know that o is a non-zero morphism of homalg objects
    if HasIsZero( o ) and not IsZero( o ) then
        s := Concatenation( s, "non-zero " );
    fi;
    
    s := Concatenation( s, "monomorphism of" );
    
    return s;
    
end );

##
InstallMethod( ViewString,
        "for homalg maps",
        [ IsHomalgMorphism and IsEpimorphism ], 897,
        
  function( o )
    local s;
    
    s := "";
    
    ## if this method applies and HasIsZero is set we already
    ## know that o is a non-zero morphism of homalg objects
    if HasIsZero( o ) and not IsZero( o ) then
        s := Concatenation( s, "non-zero " );
    fi;
    
    s := Concatenation( s, "epimorphism of" );
    
    return s;
    
end );

##
InstallMethod( ViewString,
        "for homalg maps",
        [ IsHomalgMorphism and IsSplitMonomorphism ], 1998,
        
  function( o )
    local s;
    
    s := "";
    
    ## if this method applies and HasIsZero is set we already
    ## know that o is a non-zero morphism of homalg objects
    if HasIsZero( o ) and not IsZero( o ) then
        s := Concatenation( s, "non-zero " );
    fi;
    
    s := Concatenation( s, "split monomorphism of" );
    
    return s;
    
end );

##
InstallMethod( ViewString,
        "for homalg maps",
        [ IsHomalgMorphism and IsSplitEpimorphism ], 1999,
        
  function( o )
    local s;
    
    s := "";
    
    ## if this method applies and HasIsZero is set we already
    ## know that o is a non-zero morphism of homalg objects
    if HasIsZero( o ) and not IsZero( o ) then
        s := Concatenation( s, "non-zero " );
    fi;
    
    s := Concatenation( s, "split epimorphism of" );
    
    return s;
    
end );

##
InstallMethod( ViewString,
        "for homalg maps",
        [ IsHomalgMorphism and IsIsomorphism ], 2000,
        
  function( o )
    local s;
    
    s := "";
    
    ## if this method applies and HasIsZero is set we already
    ## know that o is a non-zero morphism of homalg objects
    if HasIsZero( o ) and not IsZero( o ) then
        s := Concatenation( s, "non-zero " );
    fi;
    
    s := Concatenation( s, "isomorphism of" );
    
    return s;
    
end );

##
InstallMethod( ViewString,
        "for homalg maps",
        [ IsHomalgMorphism and IsZero ], 2001,
        
  function( o )
    local s;
    
    s := "";
    
    if HasMorphismAid( o ) then
        s := Concatenation( s, "zero generalized " );
    else
        s := Concatenation( s, "zero " );
    fi;
    
    s := Concatenation( s, "morphism of" );
    
    return s;
    
end );

##
InstallMethod( ViewString,
        "for homalg maps",
        [ IsHomalgMorphism and IsIsomorphism and IsZero ], 2003,
        
  function( o )
    
    return "zero morphism of zero";
    
end );

##
InstallMethod( ViewString,
        "for homalg maps",
        [ IsHomalgEndomorphism ],
        
  function( o )
    local s;
    
    s := "";
    
    ## if this method applies and HasIsZero is set we already
    ## know that o is a non-zero morphism of homalg objects
    if HasIsZero( o ) and not IsZero( o ) then
        s := Concatenation( s, "non-zero " );
    fi;
    
    if HasIsMorphism( o ) then
        if IsMorphism( o ) then
            s := Concatenation( s, "endomorphism of" );
        else
            s := Concatenation( s, "non-well-defined self-map of" );
        fi;
    else
        s := Concatenation( s, "\"endomorphism\" of" );
    fi;
    
    return Concatenation( s, " a" );
    
end );

##
InstallMethod( ViewString,
        "for homalg maps",
        [ IsHomalgEndomorphism and IsIdempotent ],
        
  function( o )
    local s;
    
    s := "";
    
    ## if this method applies and HasIsZero is set we already
    ## know that o is a non-zero morphism of homalg objects
    if HasIsZero( o ) and not IsZero( o ) then
        if HasIsOne( o ) and not IsOne( o ) then
            s := Concatenation( s, "nontrivial " );
        else
            s := Concatenation( s, "non-zero " );
        fi;
    elif HasIsOne( o ) and not IsOne( o ) then
        s := Concatenation( s, "non-identity " );
    fi;
    
    if HasIsMorphism( o ) then
        if IsMorphism( o ) then
            s := Concatenation( s, "idempotent of" );
        else
            s := Concatenation( s, "non-well-defined self-map of" );
        fi;
    else
        s := Concatenation( s, "\"idempotent\" of" );
    fi;
    
    return Concatenation( s, " a" );
    
end );

##
InstallMethod( ViewString,
        "for homalg maps",
        [ IsHomalgEndomorphism and IsMonomorphism ],
        
  function( o )
    local s;
    
    s := "";
    
    ## if this method applies and HasIsZero is set we already
    ## know that o is a non-zero morphism of homalg objects
    if HasIsZero( o ) and not IsZero( o ) then
        s := Concatenation( s, "non-zero " );
    fi;
    
    return Concatenation( s, "monic endomorphism of a" );
    
end );

##
InstallMethod( ViewString,
        "for homalg maps",
        [ IsHomalgEndomorphism and IsEpimorphism ], 996,
        
  function( o )
    local s;
    
    s := "";
    
    ## if this method applies and HasIsZero is set we already
    ## know that o is a non-zero morphism of homalg objects
    if HasIsZero( o ) and not IsZero( o ) then
        s := Concatenation( s, "non-zero " );
    fi;
    
    return Concatenation( s, "epic endomorphism of a" );
    
end );

##
InstallMethod( ViewString,
        "for homalg maps",
        [ IsHomalgEndomorphism and IsSplitMonomorphism ], 997,
        
  function( o )
    local s;
    
    s := "";
    
    ## if this method applies and HasIsZero is set we already
    ## know that o is a non-zero morphism of homalg objects
    if HasIsZero( o ) and not IsZero( o ) then
        s := Concatenation( s, "non-zero " );
    fi;
    
    return Concatenation( s, "split monic endomorphism of a" );
    
end );

##
InstallMethod( ViewString,
        "for homalg maps",
        [ IsHomalgEndomorphism and IsSplitEpimorphism ], 2998,
        
  function( o )
    local s;
    
    s := "";
    
    ## if this method applies and HasIsZero is set we already
    ## know that o is a non-zero morphism of homalg objects
    if HasIsZero( o ) and not IsZero( o ) then
        s := Concatenation( s, "non-zero " );
    fi;
    
    s := Concatenation( s, "split epic endomorphism of a" );
    
    return s;
    
end );

##
InstallMethod( ViewString,
        "for homalg maps",
        [ IsHomalgEndomorphism and IsAutomorphism ], 2999,
        
  function( o )
    local s;
    
    s := "";
    
    ## if this method applies and HasIsZero is set we already
    ## know that o is a non-zero morphism of homalg objects
    if HasIsZero( o ) and not IsZero( o ) then
        s := Concatenation( s, "non-zero " );
    fi;
    
    s := Concatenation( s, "automorphism of a" );
    
    return s;
    
end );

##
InstallMethod( ViewString,
        "for homalg maps",
        [ IsHomalgEndomorphism and IsOne ], 5000,
        
  function( o )
    local s;
    
    s := "identity morphism of a";
    
    if HasIsZero( Source( o ) ) and not IsZero( Source( o ) ) then
        s := Concatenation( s, " non-zero" );
    fi;
    
    return s;
    
end );

##
InstallMethod( ViewString,
        "for homalg maps",
        [ IsHomalgEndomorphism and IsZero ], 5001,
        
  function( o )
    local s;
    
    s := "zero endomorphism of a";
    
    if HasIsZero( Source( o ) ) and not IsZero( Source( o ) ) then
        s := Concatenation( s, " non-zero" );
    fi;
    
    return s;
    
end );

##
InstallMethod( ViewString,
        "for homalg maps",
        [ IsHomalgEndomorphism and IsAutomorphism and IsZero ], 3003,
        
  function( o )
    
    return "zero endomorphism of a zero";
    
end );

