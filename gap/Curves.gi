#############################################################################
##
##  Curves.gi                   Sheaves package              Mohamed Barakat
##
##  Copyright 2008-2009, Mohamed Barakat, Universität des Saarlandes
##
##  Implementations of procedures for curves.
##
#############################################################################

####################################
#
# methods for operations:
#
####################################

####################################
#
# constructor functions and methods:
#
####################################

##  <#GAPDoc Label="ProjectivePlaneCurve">
##  <ManSection>
##    <Oper Arg="base_locus, degmat" Name="ProjectivePlaneCurve"/>
##    <Returns>a &homalg; left or right ideal</Returns>
##    <Description>
##      The plane curve defined through the base locus <A>base_locus</A>.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
InstallMethod( ProjectivePlaneCurve,
        "constructor for projective plane curves specified by a degree defining matrix and base locus",
        [ IsFinitelyPresentedSubmoduleRep, IsHomalgMatrix ],
        
  function( base_locus, degmat )
    local left, base_locus_gens, base_locus_degs, degmat_degs, l,
          d, R, O, curve;
    
    ## decide if left or right ideal
    left := IsHomalgLeftObjectOrMorphismOfLeftObjects( base_locus );
    
    ## check that the degree defining matrix has a valid shape
    if not ( left and NrRows( degmat ) = 1 ) and not ( not left and NrColumns( degmat ) = 1 ) then
        Error( "the degree defining matrix has a wrong shape\n" );
    fi;
    
    base_locus_gens := MatrixOfGenerators( base_locus );
    
    base_locus_degs := Flat( DegreesOfEntries( base_locus_gens ) );
    
    degmat_degs := Flat( DegreesOfEntries( degmat ) );
    
    l := Length( degmat_degs );
    
    ## the position of the first degree greater or equal to 0
    d := First( [ 1 .. l ], i -> degmat_degs[i] >= 0 );
    
    if d = fail then
        Error( "the degree defining matrix must contain at least one nonzero element\n" );
    fi;
    
    ## the degree of the curve
    d := degmat_degs[d] + base_locus_degs[d];
    
    if not ForAll( [ 1 .. l ], i -> degmat_degs[i] < 0 or degmat_degs[i] + base_locus_degs[i] = d ) then
        Error( "the degrees of entries of the specified degree defining matrix do not _constantly_ complement the degrees of entries of the matrix of generators of the ideal describing the singular locus\n" );
    fi;
    
    R := HomalgRing( degmat );
    
    if left then
        O := ( 1 * R )^0;
    else
        O := ( R * 1 )^0;
    fi;
    
    ## the plane curve of degree d with s ordinary singularities and genus g
    if left then
        curve := degmat * base_locus_gens;
    else
        curve := base_locus_gens * degmat;
    fi;
    
    curve := Subobject( curve, O );
    
    curve := Scheme( curve );
    
    SetDimension( curve, 1 );
    
    return curve;
    
end );

##  <#GAPDoc Label="RandomProjectivePlaneCurve">
##  <ManSection>
##    <Oper Arg="d, points, mults" Name="RandomProjectivePlaneCurve" Label="for singular curves"/>
##    <Oper Arg="d, R1" Name="RandomProjectivePlaneCurve" Label="for smooth curves"/>
##    <Returns>a &homalg; left or right ideal</Returns>
##    <Description>
##      The random plane curve of degree <A>d</A> through the locus given by the points defined by the homogeneous
##      prime ideals in list <A>points</A> with multiplicities <A>mults</A>.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
InstallMethod( RandomProjectivePlaneCurve,
        "constructor for projective plane curves specified by degree and singularities",
        [ IsInt, IsList, IsList ],
        
  function( d, points, mults )
    local s, left, base_locus, base_locus_gens, base_locus_degs, sing_pos, sing_locus,
          R, O, degmat, curve, g, adjoint_system, omega, V, D;
    
    if not ForAll( points, IsFinitelyPresentedSubmoduleRep ) then
        TryNextMethod( );
    fi;
    
    ## the number of singular points
    s := Length( points );
    
    if s = 0 then
        Error( "the list of points is empty\n" );
    fi;
    
    ## we assume that the second argument "points" is a list
    ## of points given by graded prime ideals
    
    ## decide if left or right ideal
    left := IsHomalgLeftObjectOrMorphismOfLeftObjects( points[1] );
    
    base_locus := IntersectWithMultiplicity( points, mults );
    
    R := HomalgRing( base_locus );
    
    if left then
        O := n -> ( 1 * R )^n;
    else
        O := n -> ( R * 1 )^n;
    fi;
    
    degmat := RandomMatrix( O( -d ), base_locus );
    
    curve := ProjectivePlaneCurve( base_locus, degmat );
    
    ## the expected genus of the curve
    g := Binomial( d - 1, 2 ) - Iterated( List( [ 1 .. s ], i -> Binomial( mults[i], 2 ) ), SUM );
    
    ## the singular locus
    sing_pos := Filtered( [ 1 .. s ], i -> mults[i] > 1 );
    
    if sing_pos = [ ] then
        sing_locus := FullSubmodule( O( 0 ) );
    else
        sing_locus := IntersectWithMultiplicity( points{ sing_pos }, mults{ sing_pos } );
    fi;
    
    SetPrimaryDecomposition( sing_locus, ListN( points{ sing_pos }, mults{ sing_pos }, function ( p, r ) return [ p, r ]; end ) );
    
    sing_locus := Scheme( sing_locus );
    
    IsEmpty( sing_locus );
    
    ## the adjoint system
    if sing_pos = [ ] then
        adjoint_system := FullSubmodule( O( 0 ) ) * O( d - 2 - 1 );
    else
        adjoint_system := IntersectWithMultiplicity( points{ sing_pos }, mults{ sing_pos } - 1 ) * O( d - 2 - 1 );
    fi;
    
    SetPrimaryDecomposition( adjoint_system, ListN( points{ sing_pos }, mults{ sing_pos } - 1, function ( p, r ) return [ p, r ]; end ) );
    
    ## the canonical sheaf of the curve as a sheaf on the ambient projective space P^{g-1}
    omega := HomalgSheaf( adjoint_system );
    
    ## the global sections of omega
    V := GlobalSections( omega );
    
    ## the linear system associated to omega, i.e. P( V )
    D := AsLinearSystem( V );
    
    ## check if D is a linear system of dimension g-1
    if Dimension( D ) <> g - 1 then
        Error( "the dimension of the linear system is not one less than the genus of the curve\n" );
    fi;
    
    ## save the known attributes
    SetGenus( curve, g );
    SetDegreeAsSubscheme( curve, d );
    SetSingularLocus( curve, sing_locus );
    SetCanonicalSheafOnAmbientSpace( curve, omega );
    
    return curve;
    
end );

##
InstallMethod( RandomProjectivePlaneCurve,
        "constructor for projective plane curves specified by degree",
        [ IsInt, IsHomalgModule ],
        
  function( d, R1 )	## R1 is a free module of rank 1
    
    return RandomProjectivePlaneCurve( d, [ FullSubmodule( R1^0 ) ], [ 0 ] );
    
end );
