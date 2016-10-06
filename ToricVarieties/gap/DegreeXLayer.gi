##########################################################
##
#! @Section Truncations of the Cox ring to a single degree
##
##########################################################

# return the degree X layers of a toric variety
InstallMethod( DegreeXLayers,
               " for toric varieties",
               [ IsToricVariety ],
  function( variety )

    return variety!.DegreeXLayers;

end );

# This method uses the NormalizInterface to compute the exponents of the degree 'degree' monoms in the Coxring of a smooth and compact toric variety 'variety'
InstallMethod( Exponents,
               "for a toric variety and a list describing a degree",
               [ IsToricVariety, IsList ],
  function( variety, degree )
    local divisor, A, rays, n, input, i, buffer, p, l, ListOfExponents, Deg1Elements, grading, C, exponent;

    if not IsSmooth( variety ) then

      Error( "Variety must be smooth for this method to work" );
      return;

    elif not IsComplete( variety ) then

      Error( "Variety must be complete for this method to work" );
      return;

    elif not Length( degree ) = Rank( ClassGroup( variety ) ) then

        Error( "Length of degree does not match the rank of the class group" );
        return;

    fi;

    # construct divisor of given class
    divisor := DivisorOfGivenClass( variety, degree );
    A := UnderlyingListOfRingElements( UnderlyingGroupElement( divisor ) );

    # compute the ray generators
    rays := RayGenerators( FanOfVariety( variety ) );
    n := Length( rays );

    # now produce input, which we can pass to the NormalizInterface to encode this polytope
    input := [];
    for i in [ 1.. Length( rays ) ] do
      buffer := ShallowCopy( rays[ i ] );
      Add( buffer, A[ i ] );
      Add( input, buffer );
    od;

    # introduce polytope to Normaliz
    p := NmzCone( [ "inhom_inequalities", input ] );

    # and compute its vertices 
    # this line can cause Normaliz to print "warning: matrix has rank 0. Please check input data."
    # I guess this is the case whenever l = [], but I do not yet know how to turn it off easily
    # fixme
    l := NmzVerticesOfPolyhedron( p ); 

    # now distinguish cases
    if l = [] then

      # => the polytope is empty, so
      return [];

    else 

      # => the polytope is not empty so distinguish again
      if Length( l ) = 1 then

        # there is only one vertex in the polytope, i.e. this vertex is the single lattice point in the polytope
        # thus we have (after removing the last entry <-> redundant output)
        Deg1Elements := l;
        Remove( Deg1Elements[1], Length( Deg1Elements[1] ) );

      else

        # there are at least 2 vertices and thus at least 2 lattice points to this polytope
        # hence we need to compute them properly by Normaliz
        # this is why we need to introduce a grading
        grading := List( [ 1..Length( rays[ 1 ] ) ], n -> 0 );
        Add( grading, 1 );

        # which we use to construct the corresponding cone in Normaliz...
        C := NmzCone( [ "inequalities", input, "grading", [ grading ] ] );

        # ...and then compute its lattice points
        Deg1Elements := NmzDeg1Elements( C );

        # finally drop from all elements in myList the last element <-> redundant output from Normaliz
        for i in [ 1..Length( Deg1Elements ) ] do
          Remove( Deg1Elements[ i ], Length( Deg1Elements[ i ] ) );
        od;

      fi;

      # now turn myList into the exponents that we are looking for
      ListOfExponents := [];
      for i in Deg1Elements do
        exponent := List( [ 1..n ], j -> A[ j ] + Sum( List( [ 1..Length( i ) ], m -> rays[ j ][ m ] * i[ m ] ) ) );
        Add( ListOfExponents, exponent );
      od;

      # and return the list of exponents
      return ListOfExponents;

    fi;

end );


# this method computes the Laurent monomials of the lattice points and thereby identifies the monoms of given degree in the Coxring
InstallMethod( MonomsOfCoxRingOfDegreeByNormaliz,
               "for a smooth and compact toric variety and a list describing a degree in its class group",
               [ IsToricVariety, IsList ],
  function( variety, degree )
    local cox_ring, variables, exponents, i,j, mons, mon;

    if not IsSmooth( variety ) then

      Error( "Variety must be smooth for this method to work" );
      return;

    elif not IsComplete( variety ) then

      Error( "Variety must be complete for this method to work" );
      return;

    elif not Length( degree ) = Rank( ClassGroup( variety ) ) then

        Error( "Length of degree does not match the rank of the class group" );
        return;

    fi;

    # check if this has been computed before...
    if not IsBound( variety!.DegreeXLayers.( String( degree ) ) ) then

      # unfortunately this degree layer has not yet been computed, so we need to do it now          

      # collect the necessary information
      cox_ring := CoxRing( variety );
      variables := ListOfVariablesOfCoxRing( variety );
      exponents := Exponents( variety, degree );

      # initialise the list of monoms
      mons := [ ];

      # turn the lattice points into monoms of the cox_ring
      for i in exponents do

        mon := List( [ 1 .. Length( variables ) ], j -> JoinStringsWithSeparator( [ variables[ j ], String( i [ j ] ) ], "^" ) );
        mon := JoinStringsWithSeparator( mon, "*" );
        Add( mons, HomalgRingElement( mon, cox_ring ) );

      od;

      # add the result to DegreeXLayers for future reference
      variety!.DegreeXLayers.( String( degree ) ) := mons;

    else 

      # the result is known already
      mons := variety!.DegreeXLayers.( String( degree ) );

    fi;

    # now return the result
    return mons;

end );


# Compute basis of the degree X layer of the Coxring of a toric variety (smooth and compact will be assumed)
# probably not needed
InstallMethod( DegreeXLayer,
               " for toric varieties, a list specifying a degree ",
               [ IsToricVariety, IsList ],
  function( variety, degree )

    # return the result
    return MonomsOfCoxRingOfDegreeByNormaliz( variety, degree );

end );


# represent the degree X layer of a line bundle as lists of length 'length' and the corresponding monoms at position 'index'
InstallMethod( DegreeXLayerVectorsAsColumnMatrices,
               " for toric varieties",
               [ IsToricVariety, IsList, IsPosInt, IsPosInt ],
  function( variety, degree, index, length )
    local gens, res, i;

    if not IsSmooth( variety ) then

      Error( "Variety must be smooth for this method to work" );
      return;

    elif not IsComplete( variety ) then

      Error( "Variety must be complete for this method to work" );
      return;

    elif not Length( degree ) = Rank( ClassGroup( variety ) ) then

        Error( "Length of degree does not match the rank of the class group" );
        return;

    elif index > length then

        Error( "Index must be smaller than length" );
        return;

    fi;

    # compute Q-Basis of its global sections
    gens := MonomsOfCoxRingOfDegreeByNormaliz( variety, degree );

    # now represent these as matrices of length 'length' which contain nothing but at position 'index'
    # there we place the monoms that form a Q-basis of the corresponding degree X layer
    res := List( [ 1 .. Length( gens ) ] );
    for i in [ 1 .. Length( gens ) ] do
      res[ i ] := HomalgInitialMatrix( length, 1, CoxRing( variety ) );
      SetMatElm( res[ i ], index, 1, gens[ i ] );
    od;

    return res;

end );