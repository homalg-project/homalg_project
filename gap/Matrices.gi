############################################################################
##
##  Matrices.gi                SCO package                   Simon Goertzen
##
##  Copyright 2007-2008 Lehrstuhl B für Mathematik, RWTH Aachen
##
##  Implementation stuff for matrix creation.
##
#############################################################################

##  <#GAPDoc Label="BoundaryOperator">
##  <ManSection>
##  <Func Arg="i, L, mu" Name="BoundaryOperator"/>
##  <Returns>List B</Returns>
##  <Description>
##  This returns the <A>i</A>th boundary of <A>L</A>, which has to be an
##  element of a simplicial set. <A>mu</A> is the function <M>\mu</M> that
##  has to be taken into account when computing orbifold boundaries. This
##  function is used for matrix creation, there should not be much reason
##  for calling it independently.
##  </Description>
##  </ManSection>
##  <#/GAPDoc>
##
InstallGlobalFunction( BoundaryOperator, "Arguments: i, L, mu. Calculate i-th boundary of L with the help of mu",
  function( i, L, mu)
    local n, tau, rho, j, boundary;
    boundary := ShallowCopy( L );
    n := ( Length( L ) - 1 ) / 2;
    if i < 0 or i > n then
        Error( "BoundaryOperator index i is out of bounds ([0..", n, "])! i = ", i );
    fi;
    tau := Intersection( Filtered( L, x->IsList( x ) ) );
    if i = 0 then
        boundary := L{[3..Length( L )]};
        rho := Intersection( Filtered( boundary, x->IsList( x ) ) );
    elif i = n then
        boundary := L{[1..Length( L ) - 2]};
        rho := Intersection( Filtered( boundary, x->IsList( x ) ) );
    fi;
    if i = 0 or i = n then
        for j in [2,4..Length( boundary ) - 1] do
            boundary[j] := mu( [ tau, rho, boundary[j-1], boundary[j+1] ] )( boundary[j] );
        od;
        return boundary;
    fi;
    boundary := boundary{Difference( [1..Length( boundary )],[2*i+1,2*i+2] )};
    rho := Intersection( Filtered( boundary, x->IsList( x ) ) );
    for j in [2,4..Length( boundary ) - 1] do
        if j = 2*i then
            boundary[j] := mu( [ tau, rho, L[j-1], L[j+3] ] )( L[j] * L[j+2] );
        else
            boundary[j] := mu( [ tau, rho, boundary[j-1], boundary[j+1] ] )( boundary[j] );
        fi;
    od;
    return boundary;
  end
);

##  <#GAPDoc Label="CreateCohomologyMatrix">
##  <ManSection>
##  <Meth Arg="S, d, R" Name="CreateCohomologyMatrix"/>
##  <Returns>List <A>M</A></Returns>
##  <Description>
##  This returns the list <A>M</A> of homalg matrices over the homalg ring
##  <A>R</A> up to dimension <A>d</A>, corresponding to the cohomology matrices
##  induced by the simplicial set <A>S</A>.
##  <Example><![CDATA[
##  gap> S;
##  <The simplicial set of the orbifold triangulation "Teardrop",
##  computed up to dimension 0 with Length vector [ 4 ]>
##  gap> M := CreateCohomologyMatrix( S, 4, HomalgRingOfIntegers() );;
##  gap> S;
##  <The simplicial set of the orbifold triangulation "Teardrop",
##  computed up to dimension 5 with Length vector [ 4, 12, 22, 33, 51, 73 ]>
##  ]]></Example>
##  </Description>
##  </ManSection>
##  <#/GAPDoc>
##
InstallMethod( CreateCohomologyMatrix, "for internal and external rings",
        [ IsSimplicialSet, IsInt, IsHomalgRing ],
  function( ss, d, R )
    local S, x, matrices, one, minusone, k, p, i, ind, pos, res;
    
    S := x -> SimplicialSet( ss, x );
    matrices := [];
    
    one := One( R );
    minusone := MinusOne( R );
    
    for k in [ 1 .. d + 1 ] do
        if Length( S(k) ) = 0 then
            matrices[k] := HomalgInitialMatrix( Length( S(k-1) ), 1, R );
        else
            matrices[k] := HomalgInitialMatrix( Length( S(k-1) ), Length( S(k) ), R );
            for p in [ 1 .. Length( S(k) ) ] do #column iterator
                for i in [ 0 .. k ] do #row iterator
                    ind := PositionSet( S(k-1), BoundaryOperator( i, S(k)[p], ss!.orbifold_triangulation!.mu ) );
                    if not ind = fail then
                        if IsEvenInt( i ) then
                            AddToEntryOfHomalgMatrix( matrices[k], ind, p, one );
                        else
                            AddToEntryOfHomalgMatrix( matrices[k], ind, p, minusone );
                        fi;
                    fi;
                od;
            od;
        fi;
	ResetFilterObj( matrices[k], IsInitialMatrix );
	ResetFilterObj( matrices[k], IsMutableMatrix );
    od;

    return matrices;
        
  end
);
  
##  <#GAPDoc Label="CreateHomologyMatrix">
##  <ManSection>
##  <Meth Arg="S, d, R" Name="CreateHomologyMatrix"/>
##  <Returns>List <A>M</A></Returns>
##  <Description>
##  This returns the list <A>M</A> of homalg matrices over the homalg ring
##  <A>R</A> up to dimension <A>d</A>, corresponding to the homology matrices
##  induced by the simplicial set <A>S</A>.
##  <Example><![CDATA[
##  gap> S;
##  <The simplicial set of the orbifold triangulation "Teardrop",
##  computed up to dimension 0 with Length vector [ 4 ]>
##  gap> M := CreateCohomologyMatrix( S, 4, HomalgRingOfIntegers() );;
##  gap> S;
##  <The simplicial set of the orbifold triangulation "Teardrop",
##  computed up to dimension 5 with Length vector [ 4, 12, 22, 33, 51, 73 ]>
##  ]]></Example>
##  </Description>
##  </ManSection>
##  <#/GAPDoc>
##
InstallMethod( CreateHomologyMatrix, "for internal and external rings",
        [ IsSimplicialSet, IsInt, IsHomalgRing ],
  function( s, d, R )
    return List( CreateCohomologyMatrix( s, d, R ), Involution );
  end
);

## create the matrices interally, then push them via file transfer
#InstallMethod( CreateCohomologyMatrix, "for an external ring",
#        [ IsSimplicialSet, IsInt, IsHomalgExternalRingRep ],
#  function( s, d, R )
#    local internal_ring;
#    internal_ring := HomalgRingOfIntegers();
#    return List( CreateCohomologyMatrix( s, d, internal_ring ),
#      function(m)
#        SetExtractHomalgMatrixToFile( m, true );
#        return HomalgMatrix( m, R );
#      end );
#  end
#);

