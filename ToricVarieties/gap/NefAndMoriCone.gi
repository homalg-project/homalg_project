################################################################################################
##
##  NefMoriAndIntersection.gi          SheafCohomologyOnToricVarieties package
##
##  Copyright 2016                     Martin Bies,       ITP Heidelberg
##
#! @Chapter Nef and Mori Cone
##
################################################################################################



#########################################################
##
## Properties IsNet, IsAmpleViaNefCone of a toric divisor
##
#########################################################

InstallMethod( IsNef,
               "for toric Cartier divisors",
               [ IsToricDivisor ],
  function( divisor )
    local variety, nefCone, nefConeInequalities, class, i, constraint;

    # compute the ambient variety
    variety := AmbientToricVariety( divisor );

    # check if that variety is smooth and complete, for then we can compute the nef cone
    if not IsSmooth( variety ) then

      Error( "Only for smooth and complete varieties a method is implemented that can decide IsNef" );
      return;

    elif not IsComplete( variety ) then

      Error( "Only for smooth and complete varieties a method is implemented that can decide IsNef" );
      return;

    fi;

    # now compute the nef cone and its defining inequalities
    nefCone := NmzCone( [ "integral_closure", NefConeInClassGroup( variety ) ] );
    nefConeInequalities := NmzSupportHyperplanes( nefCone );

    # extract the class of the divisor
    class := UnderlyingListOfRingElements( ClassOfDivisor( divisor ) );

    # check if this class lies in the nef cone
    for i in [ 1 .. Length( nefConeInequalities ) ] do

      constraint := Sum( List( [ 1 .. Length( class ) ], x -> class[ x ] * nefConeInequalities[ i ][ x ] ) );

      if constraint < 0 then

        return false;

      fi;

    od;

    # all tests passed, so the divisor is indeed nef
    return true;
    
end );

InstallMethod( IsAmpleViaNefCone,
               "for toric Cartier divisors",
               [ IsToricDivisor ],
  function( divisor )
    local variety, nefCone, nefConeInequalities, class, i, constraint;

    # compute the ambient variety
    variety := AmbientToricVariety( divisor );

    # check if that variety is smooth and complete, for then we can compute the nef cone
    if not IsSmooth( variety ) then

      Error( "Only for smooth and projective varieties a method is implemented that can decide IsAmple" );
      return;

    elif not IsProjective( variety ) then

      Error( "Only for smooth and projective varieties a method is implemented that can decide IsAmple" );
      return;

    fi;

    # now compute the nef cone and its defining inequalities
    nefCone := NmzCone( [ "integral_closure", NefConeInClassGroup( variety ) ] );
    nefConeInequalities := NmzSupportHyperplanes( nefCone );

    # extract the class of the divisor
    class := UnderlyingListOfRingElements( ClassOfDivisor( divisor ) );

    # check if this class lies in the nef cone
    for i in [ 1 .. Length( nefConeInequalities ) ] do

      constraint := Sum( List( [ 1 .. Length( class ) ], x -> class[ x ] * nefConeInequalities[ i ][ x ] ) );

      if ( constraint < 0 ) or ( constraint = 0 ) then

        # this divisor is not ample, so return false
        return false;

      fi;

    od;

    # we passed all checks, so return true
    return true;

end );



###########################################################################
##
## Methods to compute various new attributes of toric varieties
##
###########################################################################

# this constructs the mapping matrix from the rare Cartier Data into Div_T( X_\Sigma ) -> for internal use only
BindGlobal( "TORIC_VARIETIES_INTERNAL_CONSTRUCTMATRIX",
  function( lengthOfM, numberOfM )
    local i, j, k, buffer, matrix, pos;
    
    # check for valid input
    if lengthOfM < 1 then
    
      Error( "lengthOfM must be greater than 0" );
    
    elif numberOfM < 1 then 
    
      Error( "numberofM must be greater than 0" );
      
    fi;

    # now generate the mapping matrix
    matrix := [];
    for i in [ 0 .. numberOfM - 2 ] do
    
      for j in [ i + 1 .. numberOfM - 1 ] do
      
        for k in [ 1 .. lengthOfM ] do
        
	  buffer := List( [ 1 .. numberOfM * lengthOfM ] , x -> 0 );
	  buffer[ i * lengthOfM + k ] := 1;
	  buffer[ j * lengthOfM  + k ] := -1;
	  Add( matrix, buffer );
      
	od;
      
      od;
    
    od;
    
    return matrix;
    
end );


# compute an H-presentation of the cone of intersection-product constraints 
BindGlobal( "TORIC_VARIETIES_INTERNAL_INTERSECTIONPRODUCTUCOLLECTIONCONEHCONSTRAINT",
  function( variety )
    local ulist, dimensionOfFan, numberOfMaximalCones, lengthOfVector, ures, i, j, k, position, newUList, buffer;

    # check if the input is valid
    if not IsSmooth( variety ) then

      Error( "The variety must be smooth" );
      return;

    elif not IsComplete( variety ) then

      Error( "The variety must be complete" );
      return;

    fi;

    # compute the length of the vectors needed to encode the cone of 'rare Cartier data differences'
    dimensionOfFan := Dimension( FanOfVariety( variety ) );
    numberOfMaximalCones := Length( RaysInMaximalCones( FanOfVariety( variety ) ) );
    lengthOfVector := dimensionOfFan * Binomial( numberOfMaximalCones, 2 );

    # compute the list of the original u-vectors
    GeneratorsOfProper1Cycles( variety );
    ulist := List( [ 1 .. Length( GeneratorsOfProper1Cycles( variety ) ) ], k ->
                                                                 [ IntersectedMaximalCones( GeneratorsOfProper1Cycles( variety )[ k ] )[ 1 ],
                                                                   IntersectedMaximalCones( GeneratorsOfProper1Cycles( variety )[ k ] )[ 2 ],
                                                                   IntersectionU( GeneratorsOfProper1Cycles( variety )[ k ] ) ] );

    # now turn them into the longer vectors
    newUList := [];
    for ures in ulist do
    
       i := ures[ 1 ];
       j := ures[ 2 ];
       position := ( - 1/2 * i^2 + i * ( numberOfMaximalCones - 1/2 ) - numberOfMaximalCones - 1 + j ) * dimensionOfFan;
       buffer := List( [ 1.. lengthOfVector ], x -> 0 ); 
       for k in [ 1 .. dimensionOfFan ] do
          buffer[ position + k ] := ures[ 3 ][ k ];
       od;
       Add( newUList, buffer );
    
    od;
      
    # return the new list of vectors
    return newUList;
    
end );


# compute the H-constraints on the rare Cartier data
# this is obtained by pullback of the H-constraints computed by IntersectionProductUCollectionConeHConstraint along the
# vector space homomorphism induced from TORIC_VARIETIES_INTERNAL_CONSTRUCTMATRIX
BindGlobal( "TORIC_VARIETIES_INTERNAL_INTERSECTIONPRODUCTUCOLLECTIONCONEHCONSTRAINTONRARECARTIERDATA",
  function( variety )
    local hConstraintsFromIntersectionProducts, lengthOfM, numberOfM, matrix, hConstraintsOnRareCartierData, i;

    # check if the input is valid
    if not IsSmooth( variety ) then

      Error( "The variety must be smooth" );
      return;

    elif not IsComplete( variety ) then

      Error( "The variety must be complete" );
      return;

    fi;

    # initialise the rough data
    hConstraintsFromIntersectionProducts := TORIC_VARIETIES_INTERNAL_INTERSECTIONPRODUCTUCOLLECTIONCONEHCONSTRAINT( variety );
    lengthOfM := Length( RayGenerators( FanOfVariety( variety ) )[ 1 ] );
    numberOfM := Length( RaysInMaximalCones( FanOfVariety( variety ) ) );
    matrix := TORIC_VARIETIES_INTERNAL_CONSTRUCTMATRIX( lengthOfM, numberOfM );

    # compute the nuew constraints
    hConstraintsOnRareCartierData := [];    
    for i in [ 1 .. Length( hConstraintsFromIntersectionProducts ) ] do

      Add( hConstraintsOnRareCartierData, hConstraintsFromIntersectionProducts[ i ] * matrix );

    od;

    # return the new list of vectors
    return hConstraintsOnRareCartierData;

end );


# this computes the Cartier Data group (differently than in Gutsche's approach!) and saves it as attribute of the toric variety
InstallMethod( CartierDataGroup,
               " for conv toric varieties",
               [ IsToricVariety ],
  function( variety )

    local rays, maximalCones, matrixScalarProducts, numberRayIsPartOfMaxCones, i, counter, j, row, k, matrixDifferences, pos;

    # extract the ray generators
    rays := RayGenerators( FanOfVariety( variety ) );

    # and the rays in the maximal cones
    maximalCones := RaysInMaximalCones( FanOfVariety( variety ) );

    # produce the matrix that computes the necessary scalar products
    # also count how many times rays[ i ] is part of maximal cones (-> needed to compute differences -> matrix below)
    matrixScalarProducts := [];
    numberRayIsPartOfMaxCones := List( [ 1 .. Length( rays ) ], x -> 0 );
    for i in [ 1 .. Length( rays ) ] do

      # counter counts the number of maximal cones that contain rays[ i ]
      # here we initialise that counter
      counter := 0;

      # loop over all maximal cones to check if rays[ i ] is part of them
      for j in [ 1 .. Length( maximalCones ) ] do

        # check membership
        if maximalCones[ j ][ i ] = 1 then

          # indeed rays[ i ] is part of the maximal cone j 
          # so increase the counter
          counter := counter + 1;

          # and compute the inner product of u_i and m_{\sigma_j}
          # to this end initialise row
          row := List( [ 1 .. Length( maximalCones ) * Length( rays[ 1 ] ) ], x -> 0 );

          # then add u_i at the correct position
          for k in [ 1 .. Length( rays[ i ] ) ] do

            row[ ( j -1 ) * Length( rays[ 1 ] ) + k ] := rays[ i ][ k ];

          od;

          # now add the row to the matrix
          Add( matrixScalarProducts, row );

        fi;

      od;

      # now save the number of max cones that contain rays[ i ]
      numberRayIsPartOfMaxCones[ i ] := counter;

    od;

    # compute the matrix for differences
    matrixDifferences := [];    

    # initialise the position at which we place the 1
    pos := 1;

    # now loop over all rays
    for i in [ 1 .. Length( rays ) ] do

      for j in [ 1 .. numberRayIsPartOfMaxCones[ i ] - 1 ] do

        # produce a difference
        row := List( [ 1 .. Length( matrixScalarProducts ) ], x -> 0 );

        # now add a +1 and -1 at the correct position
        row[ pos ] := 1;
        row[ pos + j ] := -1;

        # and add this row to matrixDfferences
        Add( matrixDifferences, row );

      od;

      # now increase the position of the 1
      pos := pos + numberRayIsPartOfMaxCones[ i ];

    od;

    #return the composition of these two matrices
    return matrixDifferences * matrixScalarProducts;

end );


# compute the Nef-cone within the CartierDataGroup and save it as attribute of the toric variety
InstallMethod( NefConeInCartierDataGroup,
               " for conv toric varieties",
               [ IsToricVariety ],
  function( variety )
    local hConstraints, cartierDataGroupConstraints, cone;

    # check if the input is valid
    if not IsSmooth( variety ) then

      Error( "The variety must be smooth" );
      return;

    elif not IsComplete( variety ) then

      Error( "The variety must be complete" );
      return;

    fi;

    # compute the hConstraints from intersection product condition of being nef
    hConstraints := TORIC_VARIETIES_INTERNAL_INTERSECTIONPRODUCTUCOLLECTIONCONEHCONSTRAINTONRARECARTIERDATA( variety );

    # extract the matrix whose kernel is the CartierDataGroup
    cartierDataGroupConstraints := CartierDataGroup( variety );

    # now add the h-constraints to a unified h-constraint
    #unifiedHConstraints := ShallowCopy( hConstraints );
    Append( hConstraints, cartierDataGroupConstraints );
    Append( hConstraints, -1 * cartierDataGroupConstraints );

    # use the unifiedHConstraints to construct a cone in convex and extract its ray generators
    cone := ConeByInequalities( hConstraints );
    return RayGenerators( cone );

end );

# compute the Nef-cone within Div_T ( X_\Sigma ) and save it as attribute of the given toric variety
InstallMethod( NefConeInTorusInvariantWeilDivisorGroup,
               " for conv toric varieties",
               [ IsToricVariety ],
  function( variety )
    local matrix, rayGenerators, lengthOfRays, maxCones, row, ray, i, j, k, gensOfCone, gensOfPushforwardCone, PushforwardCone, 
         rayGeneratorsOfPushforwardCone;

    # check for valid input
    if not IsSmooth( variety ) then

      Error( "The variety must be smooth" );
      return;

    elif not IsComplete( variety ) then

      Error( "The variety must be complete" );
      return;

    fi;

    # extract the ray generators and the maximal cones
    rayGenerators := RayGenerators( FanOfVariety( variety ) );
    lengthOfRays := Length( rayGenerators[ 1 ] );
    maxCones := RaysInMaximalCones( FanOfVariety( variety ) );

    # now compute the matrix that embeds Z^{length of rays * number of maximal cones} into Div_T ( variety )
    matrix := [];
    for i in [ 1 .. Length( rayGenerators ) ] do

      # find a maximal cone that contains rayGenerators[ i ]
      j := 1;
      while maxCones[ j ][ i ] = 0 do
        j := j + 1;      
      od;

      # then compute the inner product of ( (-1) * rayGenerators[ i ] ) with the element of the Cartier data corresponding to 
      # this maximal cone
      row := List( [ 1 .. Length( maxCones ) * lengthOfRays ], x -> 0 );

      for k in [ 1.. lengthOfRays ] do
        row[ ( j - 1 ) * lengthOfRays + k ] := - rayGenerators[ i ][ k ]; 
      od;

      # and add the row to this matrix
      Add( matrix, row );

    od;

    # now compute the ray generators of the cone in Z^{length of rays * number of maximal cones}
    gensOfCone := NefConeInCartierDataGroup( variety );

    # compute the images of these ray generators via 'matrix'
    gensOfPushforwardCone := DuplicateFreeList( List( [ 1 .. Length( gensOfCone ) ], x -> matrix * gensOfCone[ x ] ) );

    # return the pushforward gens
    return gensOfPushforwardCone;

end );


# compute the Nef-cone within the Class group and save it as attribute of the given toric variety
InstallMethod( NefConeInClassGroup,
               " for conv toric varieties",
               [ IsToricVariety ],
  function( variety )
    local gensOfCone, map, matrix, i, gensOfPushforwardCone, PushforwardCone;

    # check for valid input
    if not IsSmooth( variety ) then

      Error( "The variety must be smooth" );
      return;

    elif not IsComplete( variety ) then

      Error( "The variety must be complete" );
      return;

    fi;

    # obtain the ray generators within the torus invariant Weil divisor group
    gensOfCone := NefConeInTorusInvariantWeilDivisorGroup( variety );

    map := MapFromWeilDivisorsToClassGroup( variety );
    matrix := EntriesOfHomalgMatrixAsListList( MatrixOfMap( map ) );

    # homalg thinks about "left multiplication" of vectors
    # I prefer to think about right multiplication
    # so I need to transpose matrix
    matrix := TransposedMat( matrix );

    # compute the images
    gensOfPushforwardCone := DuplicateFreeList( List( [ 1 .. Length( gensOfCone ) ], x -> matrix * gensOfCone[ x ] ) );

    # return the pushforward gens
    return NmzExtremeRays( NmzCone( [ "integral_closure", gensOfPushforwardCone ] ) );
    #return gensOfPushforwardCone;

end );

# convenience method
InstallMethod( NefCone,
               " for conv toric varieties",
               [ IsToricVariety ],
  function( variety )

    # check for valid input
    if not IsSmooth( variety ) then

      Error( "The variety must be smooth" );
      return;

    elif not IsComplete( variety ) then

      Error( "The variety must be complete" );
      return;

    fi;

    # and return the result
    return NefConeInClassGroup( variety );

end );

# method to compute the smallest ample divisor of a given toric variety
InstallMethod( ClassOfSmallestAmpleDivisor,
               " for toric varieties",
               [ IsToricVariety ],
  function( variety )
    local extremeRays, length, extremeRays2, polytope, latticePoints, i, j, buffer, inequalities, classOfSmallestAmpleDivisor, 
         lengthOfClassOfSmallestAmpleDivisor, checker, computeInequality, refLength;

    # check if it is smooth and complete
    if not IsSmooth( variety ) then

      Error( "The variety needs to be smooth" );
      return;

    elif not IsProjective( variety) then

      Error( "The variety needs to be projective" );
      return;

    fi;

    # compute the nefCone
    extremeRays := NefConeInClassGroup( variety );

    # the naive guess would be to sum all rays
    # then one would consider the class Sum( extremeRays )
    # for simplicity we compute the Taxi-driver-distance of this vector, i.e. the sum of its components, and then mutliply this integers
    # with the ray generators
    # next use the so-stretched ray generators to define a polytope within the cone
    # this polytope contains the samllest interior lattice point...

    # compute taxi-driver-distance
    length := Sum( Sum( extremeRays ) );

    # now modify the ray generators
    extremeRays2 := List( [ 1 .. Length( extremeRays ) ], x -> length * extremeRays[ x ] );

    # construct polytope
    polytope := NmzCone( [ "polytope", extremeRays2 ] );

    # compute the lattice points
    latticePoints := NmzDeg1Elements( polytope );

    # note that normaliz produces redundant output which forces us to delete the last of the entries in each 'sublists'
    for i in [ 1 .. Length( latticePoints ) ] do

      buffer := latticePoints[ i ];
      Remove( buffer, Length( buffer ) );
      latticePoints[ i ] := buffer;

    od;

    # select the interior points!!!
    inequalities := NmzSupportHyperplanes( NmzCone( [ "integral_closure", extremeRays ] ) );

    # now search for the point which has the smallest distance from the origin, but use the Euclidean metric this time
    classOfSmallestAmpleDivisor := Sum( extremeRays );
    lengthOfClassOfSmallestAmpleDivisor := Sum( List( [ 1 .. Length( latticePoints[ 1 ] ) ], 
       x -> classOfSmallestAmpleDivisor[ x ] * classOfSmallestAmpleDivisor[ x ] ) );

    for i in [ 1 .. Length( latticePoints ) ] do

      # check if internal point
      checker := true;

      for j in [ 1 .. Length( inequalities ) ] do

        # compute the inequality 
        computeInequality := Sum( List ( [ 1 .. Length( inequalities[ j ] ) ], x -> inequalities[ j ][ x ] * latticePoints[ x ] ) );

        # check if <= 0, for this means that it is not an internal point
        if not computeInequality > 0 then

          # this is not an internal point
          checker := false;

        fi;

      od;

      # if this is an internal point, check if it is a better choice than the one before
      if checker then

        # compute reference length
        refLength := Sum( List( [ 1 .. Length( latticePoints[ i ] ) ], x -> latticePoints[ i ][ x ] * latticePoints[ i ][ x ] ) );

        # compare with lengthOfClassOfSmallestAmpleDivisor
        if refLength < lengthOfClassOfSmallestAmpleDivisor then

          # we found a better class
          classOfSmallestAmpleDivisor := latticePoints[ i ];
          lengthOfClassOfSmallestAmpleDivisor := refLength;

        fi;

      fi;

    od;

    # now return this class
    return classOfSmallestAmpleDivisor;
    
end );


# method to compute the group of proper 1-cycles and then save them as attribute to the given toric variety
InstallMethod( GroupOfProper1Cycles,
               "for toric varieties",
               [ IsToricVariety ],
  function( variety ) 
    local rayGenerators, matrix, map;

    # this computation works whenever the fan is simplicial and has convex support of full dimension
    # as I don't know a check for the latter I will test simplicial and complete instead
    if not IsSimplicial( FanOfVariety( variety ) ) then

      Error( "The variety must be simplicial" );
      return;

    elif not IsComplete( variety ) then

      Error( Concatenation( "The variety is not complete. Still the method works if the fan has convex support of",
                            " full dimension. Do you want to continue?" ) );

    fi;

    # compute the mapping into the group of 1-parameter curves
    rayGenerators := RayGenerators( FanOfVariety( variety ) );
    matrix := List( [ 1.. Length( rayGenerators ) ], x -> rayGenerators[ x ] );
    map := HomalgMap( matrix, Length( rayGenerators ) * HOMALG_MATRICES.ZZ, Length( rayGenerators[ 1 ] ) * HOMALG_MATRICES.ZZ );
    
    # return the kernel embedding
    return KernelSubobject( map );

end );

# method to compute the mori cone of a given toric variety and then save it as attribute of this toric variety
InstallMethod( MoriCone,
               "for toric varieties",
               [ IsToricVariety ],
  function( variety ) 
    local nefConeGenerators, intersectionForm, matrix, hConstraints, i, moriCone;

    # check for valid input
    if not IsSmooth( variety ) then

      Error( "The variety must be simplicial" );
      return;

    elif not IsComplete( variety ) then

      Error( "The variety is not complete" );
      return;

    fi;

    # compute the nef cone and its generators
    nefConeGenerators := NefConeInClassGroup( variety );

    # compute the intersection product
    intersectionForm := IntersectionForm( variety );
    matrix := TransposedMat( intersectionForm );

    # compute matrix * nefConeGenerators to obtain an H-constraints for the Mori-cone
    hConstraints := List( [ 1 .. Length( nefConeGenerators ) ], x -> matrix * nefConeGenerators[ x ] );

    # now define the mori cone
    moriCone := NmzCone( [ "inequalities", hConstraints ] );

    # and return the result
    #return moriCone;
    return NmzExtremeRays( moriCone );

end );