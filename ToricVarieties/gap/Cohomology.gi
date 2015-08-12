#(1) whitespaces adjusted
# -> done

#(2) added 'return' after error message
# -> done

#(3) checked functionality with new names of functions etc.
# -> not fully done yet because of the following problem:
# presentationMorphism( C3 ) (read initial.gi) causes problems - what to do with it?

#(4) found BUG:
# ClassGroup( ProjectiveSpace( 1 ) );
# (tried to use projective space to generated cpn)

#(5) changed functionality of 'GS_Checker'
# -> done

#(6) made the entrance conditions "smooth and complete etc" the same for all methods
# in particular I am not using 'HasCoxRing' but rather install the CoxRing if that has not been done before
# -> done

#(7) add BySmallerPresentation( ClassGroup( ) ) when I need it
# -> done

#(8) adjust variable names
# -> done

#(9) worked on docu, i.e.
# added math environments
# added conditions on the toric variety etc.
# -> done

#(10) "union of rows" and "PointContainedInCone" -> global function?
# -> no
# -> done

#(11) changed HasCoxRing again
# -> I now simply call this whenever I consider it needed
# -> done

#(12) bug - C3 has no presentationMorphism -> DegreeXPartOfFPModule does not work on it
# use 'PresentationMorphism( Source( EmbeddingInSuperObject( module ) ) );'
# -> done

#(13) specialised CPn methods to be added
# -> need CPn filter
# -> to be added soon
# -> should this be a filter? if so - how?

#(14): 'finite free resolution' instead of 'resolution' - why does that not work? When does it work?
# -> not done anything just yet




#############################################################################
##
##  Cohomology.gd     ToricVarieties       Martin Bies
##
##  Copyright 2011 Lehrstuhl B für Mathematik, RWTH Aachen
##
##  cohomology and multitruncations
##
#############################################################################

#################################
##
## Attributes
##
#################################


# compute the cone C = K^sat for smooth toric varieties, then C = K^sat = K, and it is simpler to compute it
InstallMethod( GSCone,
                " for toric varieties.",
                [ IsToricVariety ],
  function( variety )
    local deg, rayList, conesVList, buffer, i, j, conesHList;
    
    if not IsSmooth( variety ) then
        
      Error( "Variety must be smooth for this method to work." );
      return;
          
    fi;

    # use smaller present the class group
    ByASmallerPresentation( ClassGroup( variety ) );
        
    # obtain degrees of the generators of the Coxring
    deg := WeightsOfIndeterminates( CoxRing( variety ) );
    deg := List( [ 1..Length( deg ) ], x -> UnderlyingListOfRingElements( deg[ x ] ) );

    # figure out which rays contribute to the maximal cones in the fan
    rayList := RaysInMaximalCones( FanOfVariety( variety ) );

    # use raylist to produce list of cones to be intersected - each cone is V-presented first
    conesVList := [];
    for i in [ 1..Length( rayList ) ] do
      buffer := [];
      for j in [1..Length(rayList[i])] do
	if rayList[ i ][ j ] = 0 then
	  # the generator j in deg should be added to buffer
          Add( buffer, deg[ j ] );
        fi;
      od;
      Add( conesVList, buffer );
    od;

    # remove duplicates in coneVList
    conesVList := DuplicateFreeList( conesVList );

    # compute the H-presentation for the cones given by the V-presentation in the above list
    # to this end we use the NormalizInterface
    conesHList := [];
    for i in [ 1 .. Length( conesVList ) ] do
      Append( conesHList, NmzSupportHyperplanes( NmzCone( [ "integral_closure", conesVList[ i ] ] ) ) );
    od;

    # remove duplicates
    conesHList := DuplicateFreeList( conesHList );

    # and return the list of constraints
    return conesHList;

end );


#################################
##
## Methods to extract the thus-far computed DegreeXParts of a toric variety
##
#################################


# return the degree X Parts of a toric variety
InstallMethod( DegreeXParts,
               " for toric varieties",
               [ IsToricVariety ],
  function( variety )
    
    return variety!.DegreeXParts;
    
end );


#################################
##
## Methods for (multi-) truncation
##
#################################


# This method uses the NormalizInterface to compute the exponents of the degree 'degree' monoms in the Coxring of a smooth and compact toric variety 'variety'
InstallMethod( Exponents,
               "for a toric variety and a list describing a degree",
               [ IsToricVariety, IsList ],
  function( variety, degree )
    local divisor, A, rays, n, input, i, buffer, p, l, ListOfExponents, Deg1Elements, grading, C, exponent;

    if not IsSmooth( variety ) then
        
      Error( "Variety must be smooth for this method to work." );
      return;

    elif not IsComplete( variety ) then
        
      Error( "Variety must be complete for this method to work." );
      return;
    
    elif not Length( degree ) = Rank( ClassGroup( variety ) ) then

        Error( "Length of degree does not match the rank of the class group." );
        return;
      
    fi;    

    #install CoxRing of toric variety
    CoxRing( variety );
    
    # use smaller presentation of the class group of the toric variety
    ByASmallerPresentation( ClassGroup( variety ) );
    
    # construct divisor of given class
    divisor := DivisorOfGivenClass( variety, degree );
    A := UnderlyingListOfRingElements( UnderlyingGroupElement( divisor ) );

    # compute the ray generators
    rays := RayGenerators( FanOfVariety( variety ) );
    n := Length( rays );

    # now produce input, which we can pass to the NormalizInterface to encode this polytope
    input := [];
    for i in [1.. Length( rays ) ] do
      buffer := ShallowCopy( rays[ i ] );
      Add( buffer, A[ i ] );
      Add( input, buffer );
    od;

    # introduce polytope to Normaliz
    p := NmzCone( [ "inhom_inequalities", input ] );

    # and compute its vertices
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
    local cox_ring, ring, exponents, i,j, mons, mon;

    if not IsSmooth( variety ) then
        
      Error( "Variety must be smooth for this method to work." );
      return;

    elif not IsComplete( variety ) then
        
      Error( "Variety must be complete for this method to work." );
      return;
    
    elif not Length( degree ) = Rank( ClassGroup( variety ) ) then

        Error( "Length of degree does not match the rank of the class group." );
        return;
      
    fi;

    # check if this has been computed before...
    if not IsBound( variety!.DegreeXParts.( String( degree ) ) ) then

      # unfortunately this degree layer has not yet been computed, so we need to do it now          

      #install CoxRing of toric variety
      CoxRing( variety );
          
      # use smaller present the class group
      ByASmallerPresentation( ClassGroup( variety ) );

      # collect the necessary information
      cox_ring := CoxRing( variety );
      ring := ListOfVariablesOfCoxRing( variety );
      exponents := Exponents( variety, degree );
    
      # initialise the list of monoms
      mons := [ ];
    
      # turn the lattice points into monoms of the cox_ring
      for i in exponents do
        
	mon := List( [ 1 .. Length( ring ) ], j -> JoinStringsWithSeparator( [ ring[ j ], String( i [ j ] ) ], "^" ) );
        mon := JoinStringsWithSeparator( mon, "*" );  
        Add( mons, HomalgRingElement( mon, cox_ring ) );
        
      od;
  
      # add the result to DegreeXParts for future reference
      variety!.DegreeXParts.( String( degree ) ) := mons;

    else 
 
      # the result is known already
      mons := variety!.DegreeXParts.(String(degree));
    
    fi;

    # now return the result
    return mons;

end );


# Compute basis of the degree X part of the Coxring of a toric variety (smooth and compact will be assumed)
# probably not needed
InstallMethod( DegreeXPart,
               " for toric varieties, a list specifying a degree ",
               [ IsToricVariety, IsList ],
  function( variety, degree )

    if not IsSmooth( variety ) then
        
      Error( "Variety must be smooth for this method to work." );
      return;

    elif not IsComplete( variety ) then
        
      Error( "Variety must be complete for this method to work." );
      return;
    
    elif not Length( degree ) = Rank( ClassGroup( variety ) ) then

        Error( "Length of degree does not match the rank of the class group." );
        return;
      
    fi;

    # return the result
    return MonomsOfCoxRingOfDegreeByNormaliz( variety, degree );

end );


# a small helper function
BindGlobal( "TORIC_VARIETIES_INTERNAL_REPLACER",
  function( int, index, mon )

    if not int = index then
      return 0;
    else
      return mon;
    fi;
end );


# represent the degreeX part of a line bundle as "matrices" of length 'length' and the corresponding monoms at position 'index'
InstallMethod( DegreeXPartVectors,
               " for toric varieties, a list specifying a degree, a positie integer",
               [ IsToricVariety, IsList, IsPosInt, IsPosInt ],

  function( variety, degree, index, length )
    local gens;

    if not IsSmooth( variety ) then
        
      Error( "Variety must be smooth for this method to work." );
      return;

    elif not IsComplete( variety ) then
        
      Error( "Variety must be complete for this method to work." );
      return;
    
    elif not Length( degree ) = Rank( ClassGroup( variety ) ) then

        Error( "Length of degree does not match the rank of the class group." );
        return;
      
    fi;

    # compute Q-Basis of its global sections
    gens := MonomsOfCoxRingOfDegreeByNormaliz( variety, degree );

    # now represent these as matrices of length 'length' which contain zero but at position 'index' where we place the monoms
    # and return this list of matrices
    return List( [ 1.. Length( gens ) ], x -> HomalgMatrix( [ List( [ 1..length ], y -> TORIC_VARIETIES_INTERNAL_REPLACER( y, index, gens[ x ] ) ) ], CoxRing( variety ) ) );

end );

# represent the degreeX part of a line bundle as lists of length 'length' and the corresponding monoms at position 'index'
InstallMethod( DegreeXPartVectorsII,
               " for toric varieties",
               [ IsToricVariety, IsList, IsPosInt, IsPosInt ],
  function( variety, degree, index, length )
    local gens;

    if not IsSmooth( variety ) then
        
      Error( "Variety must be smooth for this method to work." );
      return;

    elif not IsComplete( variety ) then
        
      Error( "Variety must be complete for this method to work." );
      return;
    
    elif not Length( degree ) = Rank( ClassGroup( variety ) ) then

        Error( "Length of degree does not match the rank of the class group." );
        return;
    
    elif index > length then
    
        Error( "Index must be smaller than length." );
        return;
    
    fi;
    
    # compute Q-Basis of its global sections
    gens := MonomsOfCoxRingOfDegreeByNormaliz( variety, degree );

    # now represent these as lists of length 'length' which contain zero but at position 'index' where we place the monoms
    # that form a Q-basis of the corresponding degreeXpart
    return List( [ 1.. Length( gens ) ], x -> List( [ 1..length ], y -> TORIC_VARIETIES_INTERNAL_REPLACER( y, index, gens[ x ] ) ) );

end );


# compute degree X part of a free graded S-module
InstallMethod( DegreeXPartOfFreeModule,
               " for toric varieties, a free graded S-module, a list specifying a degree ",
               [ IsToricVariety, IsGradedModuleOrGradedSubmoduleRep, IsList ],
  function( variety, module, degree )
    local degOfGensOfModule, degrees, i, gensCollection, gens;

    # check that the input is valid to work with
    if not IsSmooth( variety ) then
        
      Error( "Variety must be smooth for this method to work." );
      return;

    elif not IsComplete( variety ) then
        
      Error( "Variety must be complete for this method to work." );
      return;
    
    elif not Length( degree ) = Rank( ClassGroup( variety ) ) then

        Error( "Length of degree does not match the rank of the class group." );
        return;
      
    elif not IsFree( module ) then
          
      Error( "This module is not free. Try 'DegreeXPartOfFPModule'." );
      return;
            
    fi;

    # compute the degree layers of S that need to be computed
    degOfGensOfModule := DegreesOfGenerators( module );
    degrees := List( [ 1..Rank( module ) ], x -> degree - UnderlyingListOfRingElements( degOfGensOfModule[ x ] ) );

    # concatenate the lists of basis elements to have basis of the degreeX part of the free module M
    gensCollection := DegreeXPartVectors( variety, degrees[ 1 ], 1, Rank( module ) );
    
    # check if gens is not the zero vector space
    # for if that is the case, then the module M has no degreeX part, so we should return the empty list
    if not gensCollection = [ ] then

      for i in [ 2.. Length( degrees ) ] do

	# check if DegreeXPartVectors( variety, list[i], i, Rank( module ) ) is not the zero vector space
        # for if that is the case, then the module has no degreeX part, so we should return the empty list
        gens := DegreeXPartVectors( variety, degrees[ i ], i, Rank( module ) );
        if gens = [ ] then
	
	  return [ ];
        
        else
        
	  gensCollection := Concatenation( gensCollection, gens );
        
        fi;

      od;

    fi;

    # return the resulting list
    return gensCollection;

end );


# Compute degree X part of a graded free S-module as Q-vector space
InstallMethod( DegreeXPartOfFreeModuleAsVectorSpace,
               " for toric varieties, a free graded S-module, a list specifying a degree ",
               [ IsToricVariety, IsGradedModuleOrGradedSubmoduleRep, IsList ],
  function( variety, module, degree )
    local degOfGensOfModule, degrees, i, gens, dim, Q;

    # check that the input is valid to work with
    if not IsSmooth( variety ) then
        
      Error( "Variety must be smooth for this method to work." );
      return;

    elif not IsComplete( variety ) then
        
      Error( "Variety must be complete for this method to work." );
      return;
    
    elif not Length( degree ) = Rank( ClassGroup( variety ) ) then

        Error( "Length of degree does not match the rank of the class group." );
        return;
      
    elif not IsFree( module ) then
          
      Error( "This module is not free. Try 'DegreeXPartOfFPModule'." );
      return;
      
    fi;

    # compute the underlying coefficient ring
    Q := UnderlyingNonGradedRing( CoefficientsRing( HomalgRing( module ) ) );

    # compute the degree layers of S that need to be computed
    degOfGensOfModule := DegreesOfGenerators( module );
    degrees := List( [ 1..Rank( module ) ], x -> degree - UnderlyingListOfRingElements( degOfGensOfModule[ x ] ) );

    # concatenate the lists of basis elements to have basis of the degreeX part of the free module M
    gens := DegreeXPart( variety, degrees[ 1 ] );
             
    # check if gens is not the zero vector space
    # for if that is the case, then the module M has zero dimensional DegreeXPart, so we should return 0
    if gens = [] then
    
      return RowSpace( Q, 0 );
    
    else
    
      dim := Length( gens );
      
      for i in [ 2.. Length( degrees ) ] do

	# check if DegreeXPartVectors( variety, list[i], i, Rank( module ) ) is not the zero vector space
        # for if that is the case, then the module has zero dimensional DegreeXPart, so we should return 0
        gens := DegreeXPart( variety, degrees[ i ] );
        if gens = [] then
	
	  return RowSpace( Q, 0 );
        
        else
        
	  dim := dim + Length( gens );
        
        fi;

      od;

    # return the dimension of this Q-vector space
    return RowSpace( Q, dim );

    fi;

end );


# compute DegreeXPart of a free graded S-module as a matrix in whose rows we write the generators of the degree X part
InstallMethod( DegreeXPartOfFreeModuleAsMatrix,
               " for toric varieties, a free graded S-module, a list specifying a degree",
               [ IsToricVariety, IsGradedModuleOrGradedSubmoduleRep, IsList ],
  function( variety, module, degree )
    local gens, gensCollection, degOfGensOfModule, degrees, i;

    # check that the input is valid to work with
    if not IsSmooth( variety ) then
        
      Error( "Variety must be smooth for this method to work." );
      return;

    elif not IsComplete( variety ) then
        
      Error( "Variety must be complete for this method to work." );
      return;
    
    elif not Length( degree ) = Rank( ClassGroup( variety ) ) then

        Error( "Length of degree does not match the rank of the class group." );
        return;
            
    elif not IsFree( module ) then
          
      Error( "This module is not free. Try 'DegreeXPartOfFPModule'." );
      return;
            
    fi;
    
    # compute the degree layers of S that need to be computed
    degOfGensOfModule := DegreesOfGenerators( module );
    degrees := List( [ 1..Rank( module ) ], x -> degree - UnderlyingListOfRingElements( degOfGensOfModule[ x ] ) );

    # concatenate the lists of basis elements to have basis of the degreeX part of the free module M
    gensCollection := DegreeXPartVectorsII( variety, degrees[ 1 ], 1, Rank( module ) );
             
    # check if gens is not the zero vector space
    # for if that is the case, then the module M has no degreeX part, so we should return the empty list
    if gensCollection = [] then
    
      return [];
    
    else

      for i in [2.. Length( degrees ) ] do
      
	# check if DegreeXPartVectorsII( variety, list[i], i, Rank( module ) ) is not the zero vector space
        # for if that is the case, then the module has no degreeX part, so we should return the empty list
        gens := DegreeXPartVectorsII( variety, degrees[ i ], i, Rank( module ) );
        if gens = [] then
                    
	  return [];
        
        else
        
	  gensCollection := Concatenation( gensCollection, gens );
                 
        fi;

      od;

      # if the degree X layer is non-trivial, we should now have a neat list of its generators saved in gensCollection
      # we return the corresponding matrix
      return HomalgMatrix( gensCollection, HomalgRing( module ) );
      
    fi;

end );


# a method that unifies a list of rows-matrices into a single matrix
InstallMethod( UnionOfRows,
               "for list of row matrices",
               [ IsList ],
  function( ListOfRows )
    local resultMatrix, i;

    resultMatrix := ListOfRows[ 1 ];
    for i in [ 2..Length( ListOfRows ) ] do
    
      resultMatrix := UnionOfRows( resultMatrix, ListOfRows[ i ] );

    od;

    return resultMatrix;

end );


# compute the degree X part of a f.p. graded S-module
InstallMethod( DegreeXPartOfFPModule,
               " for toric varieties, a f.p. graded S-module, a list specifying a degree",
               [ IsToricVariety, IsGradedModuleOrGradedSubmoduleRep, IsList ],
  function( variety, module, degree )
    local h, M1, M2, gens1, gens2, rows, matrix, map, Q;

    # check that the input is valid to work with
    if not IsSmooth( variety ) then
        
      Error( "Variety must be smooth for this method to work." );
      return;

    elif not IsComplete( variety ) then
        
      Error( "Variety must be complete for this method to work." );
      return;
    
    elif not Length( degree ) = Rank( ClassGroup( variety ) ) then

        Error( "Length of degree does not match the rank of the class group." );
        return;
      
    fi;
    
    # reduce the work amount by choosing a smaller presentation
    ByASmallerPresentation( module );

    # check if this is a right-module, if so turn it into a left-module
    if not IsHomalgLeftObjectOrMorphismOfLeftObjects( module ) then
      module := ByASmallerPresentation( GradedHom( HomalgRing( module ) * 1, module ) );
    fi;

    # determine the underlying ring
    Q := UnderlyingNonGradedRing( CoefficientsRing( HomalgRing( module ) ) );

    # check for simple cases, to reduce the work amount
    if IsZero( module ) then

      return RowSpace( Q, 0 );

    elif IsFree( module ) then

      return DegreeXPartOfFreeModuleAsVectorSpace( variety, module, degree );

    else

      # the module is not zero nor free, so extract the presentation morphism h
      if HasAsCokernel( module ) then
         
        h := ByASmallerPresentation( AsCokernel( module ) );
        
      elif HasEmbeddingInSuperObject( module ) then
      
        h := ByASmallerPresentation( PresentationMorphism( Source( EmbeddingInSuperObject( module ) ) ) );

      else
        # so far my last resort -> is there a way to check for "hasPresentation?"
        h := ByASmallerPresentation( PresentationMorphism( module ) );

        #Error( "Cannot extract a presentation morphism for this module." );
        #return;
      
      fi;
      
      # source and range of h give the source and range free modules
      M1 := Source( h );
      M2 := Range( h );

      # compute Q-basis of the degree 'charges' layers of M1 and M2
      gens1 := DegreeXPartOfFreeModule( variety, M1, degree );
      gens2 := DegreeXPartOfFreeModuleAsMatrix( variety, M2, degree );
          
      # check for degenerate cases
      if gens1 = [] and gens2 = [] then

	# gens1 and gens2 is the zero vector space, so cokernel is isomorphic to the zero vector space too
        return RowSpace( Q, 0 );

      elif gens1 = [] and not gens2 = [] then

        # gens1 is the zero vector space, so cokernel is isomorphic to gens2
        return RowSpace( Q, NrRows( gens2 ) );

      elif gens2 = [] then

	# gens2 is the zero vector space, so the cokernel is the zero vector space as well
        return RowSpace( Q, 0 );

      else

	# no degenerate case, so do the full computation

	# compute the images of gens1 in the range of h expressed in terms of gens2 (that is what I use gens2 as matrix for)
        rows := List( [ 1..Length( gens1 ) ], x -> RightDivide( gens1[ x ] * MatrixOfMap( h ), gens2 ) );

        #-> rows=list of matrices s.t. each of these matrices is a row of the rep. matrix of the degreeXpart of the morphism h
        # we need to "compose" these matrices, to form the final matrix
        matrix := UnionOfRows( rows );

        # now turn matrix into a matrix over Q
        matrix := Q * matrix;

        # use matrix to define a map of finite dimensional Q-vector spaces
        map := HomalgMap( matrix, RowSpace( Q, NrRows( matrix ) ), RowSpace( Q, NrColumns( matrix ) ) );

        # the cokernel of map is (isomorphic to) the degree X part of module, so return this
        return ByASmallerPresentation( Cokernel( map ) );

      fi;

    fi;

end );


#################################
##
## Methods for B-transform
##
#################################



# compute H^0 from the B-transform
InstallMethod( H0FromBTransform, 
               " for toric varieties, a f.p. graded S-module, a non-negative integer",
               [ IsToricVariety, IsGradedModuleOrGradedSubmoduleRep, IsInt ],
  function( variety, module, index )
    local B, BPower, GH, zero;

    # check that the input is valid to work with
    if not IsSmooth( variety ) then
        
      Error( "Variety must be smooth for this method to work." );
      return;

    elif not IsComplete( variety ) then
        
      Error( "Variety must be complete for this method to work." );
      return;
          
    elif index < 0 then
    
      Error( "Index must be a non-negative integer." );
      return;
      
    fi;

    # generate the necessary information for the computation
    B := IrrelevantIdeal( variety );
    BPower := GradedLeftSubmodule( List( EntriesOfHomalgMatrix( MatrixOfSubobjectGenerators( B ) ), a -> a^(index) ) );	
    GH := ByASmallerPresentation( GradedHom( BPower, module ) );
    zero := List( [ 1..Rank( ClassGroup( variety ) ) ], x -> 0 );

    # compute the degree 0 part of the GradedHom under consideration
    return DegreeXPartOfFPModule( variety, GH, zero );

end );

# compute H^0 from the B-transform
InstallMethod( H0FromBTransformInInterval, 
               " for toric varieties, a f.p. graded S-module, a non-negative integer",
               [ IsToricVariety, IsGradedModuleOrGradedSubmoduleRep, IsInt, IsInt ],
  function( variety, module, min, max )
    local B, BPower, GH, zero, results, i;

    # check that the input is valid to work with
    if not IsSmooth( variety ) then
        
      Error( "Variety must be smooth for this method to work." );
      return;

    elif not IsComplete( variety ) then
        
      Error( "Variety must be complete for this method to work." );
      return;
    
    elif min < 0 then
      
      Error( "min must not be negative." );
      return; 
    
    elif not min <= max then
    
      Error( "max must not be smaller than min" );
      return;
    
    fi;

    # generate the necessary information for the computation
    B := IrrelevantIdeal( variety );
    zero := List( [ 1..Rank( ClassGroup( variety ) ) ], x -> 0 );

    # compute the elements of B-transfor for min <= index <= max
    results := [];    
    for i in [ min .. max ] do

      BPower := GradedLeftSubmodule( List( EntriesOfHomalgMatrix( MatrixOfSubobjectGenerators( B ) ), a -> a^( i ) ) );	
      GH := ByASmallerPresentation( GradedHom( BPower, module ) );
      Add( results, DegreeXPartOfFPModule( variety, GH, zero ) );

    od;
    
    # return the resulting list 'results'
    return results;

end );



#######################################
##
## Methods to apply theorem by G. Smith
##
#######################################


# extract the weights a_ij for a f.p. Z^n-graded S-module
InstallMethod( MultiGradedBetti, 
               " for f.p. graded S-modules.",
               [ IsGradedModuleOrGradedSubmoduleRep ],
  function( F )
    local resolution, morphismsOfResolution, i, j, a, buffer;

    # compute minimal free resolution/resolution
    #r := FiniteFreeResolution( F );
    resolution := Resolution( F );
    morphismsOfResolution := MorphismsOfComplex( resolution );

    # investigate these morphisms to compute the degrees a
    a := [];
    for i in [ 1.. Length( morphismsOfResolution ) ] do
      Add( a, DegreesOfGenerators( Range( morphismsOfResolution[ i ] ) ) );
    od;

    # if the last object in the resolution is non-zero, then its degrees of generators need to be added
    if not IsZero( morphismsOfResolution[ Length( morphismsOfResolution ) ] ) then
      Add( a, DegreesOfGenerators( Source( morphismsOfResolution[ i ] ) ) );
    fi;

    # represent the degrees a as lists of ring elements
    for i in [ 1.. Length( a ) ] do
      buffer := [];
      for j in [ 1.. Length( a[ i ] ) ] do
	Add( buffer, UnderlyingListOfRingElements( a[ i ][ j ] ) ); 
      od;
      a[ i ] := buffer;
    od;

    # return the weights
    return a;

end );


# check if a point satisfies hyperplane constraints for a cone, thereby determining if the point lies in the cone
InstallMethod( PointContainedInCone,
               " for a cone given by H-constraints, a list specifying a point ",
               [ IsList, IsList ],
  function( cone, point )
    local i, constraint;

    # check if the point satisfies the hyperplane constraints or not
    for i in [ 1..Length( cone ) ] do

      # compute constraint
      constraint := Sum( List( [ 1..Length( cone[ i ] ) ], x -> cone[ i ][ x ] * point[ x ] ) );

      # if non-negative, the point satisfies this constraint
      if constraint < 0 then
	return false;
      fi;
      
    od;

    # return the result
    return true;

end );


# this methods checks if the conditions in the theorem by Greg Smith are satisfied
BindGlobal( "TORIC_VARIETIES_INTERNAL_GS_PARAMETER_CHECK",
  function( variety, e, module, Index )
    local B, BPower, aB, aB01, aM, d, Deltaa, i, j, C, deg, div, result;

    # check if Index is meaningful
    if Index < 0 then
    
      Error( "Index must be non-negative." );
      return;
      
    elif Index > Dimension( variety ) then
    
      Error( "Index must not be greater than the dimension of the variety." );
      return;

    fi;

    # we first compute the e-th Frobenius power of the irrelevant ideal
    B := IrrelevantIdeal( variety );
    BPower := GradedLeftSubmodule( List( EntriesOfHomalgMatrix( MatrixOfSubobjectGenerators( B ) ), x -> x^(e) ) );

    # compute the respective degree that is needed to compare
    aB := MultiGradedBetti( BPower );
    aB01 := aB[ 1 ][ 1 ];

    # compute the respective degrees of the module
    aM := MultiGradedBetti( module );

    # determine range in which we need to check
    d := Minimum( Dimension( variety ) - Index, Length( aM ) -1 );

    # now compute a list of vectors that need to lie in the GS cone
    Deltaa := [];
    for i in [ 0..d ] do
      for j in [ 1..Length( aM[ i+1 ] ) ] do
	Add( Deltaa, aB01 - aM[ i+1 ][ j ] );
      od;
    od;

    # compute the GScone via its hyperplane criterion
    C := GSCone( variety );

    # now check if the points in Deltaa satisfy these constraints
    # if at least one does not, then return false
    for i in [ 1..Length( Deltaa ) ] do
      if not PointContainedInCone( C, Deltaa[ i ] ) then
	return false;
      fi;
    od;

    # return the result
    return true;

end );

# compute H0 by applying the theorem from Greg Smith
InstallMethod( H0ByGS, 
               " for a toric variety, a f.p. graded S-module ",
               [ IsToricVariety, IsGradedModuleOrGradedSubmoduleRep ],
  function( variety, module )
    local e, B, BPower, zero, GH, deg, div;

    # check that the input is valid to work with
    if not IsSmooth( variety ) then
        
      Error( "Variety must be smooth for this method to work." );
      return;

    elif not IsComplete( variety ) then
        
      Error( "Variety must be complete for this method to work." );
      return;
    
    elif not IsProjective( variety ) then

        Error( "Variety must be projective." );
        return;
      
    fi;

    # compute irrelevant ideal of variety
    CoxRing( variety );
    B := IrrelevantIdeal( variety );

    # smaller presentation of the class group
    ByASmallerPresentation( ClassGroup( variety ) );

    # extract divisor of degree given by the degree of the gens of B
    deg := UnderlyingListOfRingElements( DegreesOfGenerators( B )[ 1 ] );
    div := DivisorOfGivenClass( variety, deg );

    # check for ampleness of corresponding bundle
    if IsAmple( div ) then
    
      # we might be able to find a good bound... so let us try
    
      # determine the integer e that we need to perform the computation of the cohomology
      e := 0;
      while not TORIC_VARIETIES_INTERNAL_GS_PARAMETER_CHECK( variety, e, module, 0 ) do
	e := e + 1;
      od;

      # inform the user that we have found a suitable e
      Print( Concatenation( "Found integer: ", String( e ) , "\n" ) );
            
      # now compute the appropriate Frobenius power of the irrelevant ideal
      BPower := GradedLeftSubmodule( List( EntriesOfHomalgMatrix( MatrixOfSubobjectGenerators( B ) ), x -> x^( e ) ) );	

      # compute the GradedHom
      GH := ByASmallerPresentation( GradedHom( BPower, module ) );

      # truncate the degree 0 part
      zero := List( [ 1..Rank( ClassGroup( variety ) ) ], x -> 0 );
      return [ e, DegreeXPartOfFPModule( variety, GH, zero ) ];

    else
    
      # unfortunately the bundle is not ample
      Print( "The bundle 'degree of irrelevant ideal' is not ample." );
      return;
      
    fi;
   
end );


# compute H1 by applying the theorem from Greg Smith
InstallMethod( HiByGS, 
               " for a toric variety, a f.p. graded S-module ",
               [ IsToricVariety, IsGradedModuleOrGradedSubmoduleRep, IsInt ],
  function( variety, module, index )
    local e, B, BPower, zero, GE, deg, div;

    # check that the input is valid to work with
    if not IsSmooth( variety ) then
        
      Error( "Variety must be smooth for this method to work." );
      return;

    elif not IsComplete( variety ) then
        
      Error( "Variety must be complete for this method to work." );
      return;
    
    elif not IsProjective( variety ) then

        Error( "Variety must be projective." );
        return;
      
    elif index < 0 then
    
      Error( "Index must be non-negative." );
      return;
      
    elif index > Dimension( variety ) then
    
      Error( "Index must not be greater than the dimension of the variety." );
      return;
      
    fi;

    # compute irrelevant ideal of variety
    CoxRing( variety );
    B := IrrelevantIdeal( variety );

    # smaller presentation of the class group
    ByASmallerPresentation( ClassGroup( variety ) );

    # extract divisor of degree given by the degree of the gens of B
    deg := UnderlyingListOfRingElements( DegreesOfGenerators( B )[ 1 ] );
    div := DivisorOfGivenClass( variety, deg );

    # check for ampleness of corresponding bundle
    if IsAmple( div ) then
    
      # we might be able to find a good bound... so let us try
    
      # determine the integer e that we need to perform the computation of the cohomology
      e := 0;
      while not TORIC_VARIETIES_INTERNAL_GS_PARAMETER_CHECK( variety, e, module, index ) do
	e := e + 1;
      od;

      # inform the user that we have found a suitable e
      Print( Concatenation( "Found integer: ", String( e ) , "\n" ) );
      
      # now compute the appropriate Frobenius power of the irrelevant ideal
      BPower := GradedLeftSubmodule( List( EntriesOfHomalgMatrix( MatrixOfSubobjectGenerators( B ) ), x -> x^( e ) ) );	

      # compute the GradedHom
      GE := ByASmallerPresentation( GradedExt( index, BPower, module ) );

      # truncate the degree 0 part
      zero := List( [ 1..Rank( ClassGroup( variety ) ) ], x -> 0 );
      return [ e, DegreeXPartOfFPModule( variety, GE, zero ) ];

    else
    
      # unfortunately the bundle is not ample
      Print( "The bundle 'degree of irrelevant ideal' is not ample." );
      return;
      
    fi;
   
end );


# compute all cohomology classes by applying the theorem from Greg Smith
InstallMethod( AllCohomsByGS, 
               " for a toric variety, a f.p. graded S-module ",
               [ IsToricVariety, IsGradedModuleOrGradedSubmoduleRep ],
  function( variety, module )
    local e, B, BPower, zero, GE, i, cohoms, cohom, deg, div;

    # check that the input is valid to work with
    if not IsSmooth( variety ) then
        
      Error( "Variety must be smooth for this method to work." );
      return;

    elif not IsComplete( variety ) then
        
      Error( "Variety must be complete for this method to work." );
      return;
    
    elif not IsProjective( variety ) then

        Error( "Variety must be projective." );
        return;
      
    fi;
    
    # compute irrelevant ideal of variety
    CoxRing( variety );
    B := IrrelevantIdeal( variety );

    # smaller presentation of the class group
    ByASmallerPresentation( ClassGroup( variety ) );

    # extract divisor of degree given by the degree of the gens of B
    deg := UnderlyingListOfRingElements( DegreesOfGenerators( B )[ 1 ] );
    div := DivisorOfGivenClass( variety, deg );

    # check for ampleness of corresponding bundle
    if IsAmple( div ) then
    
      # determine the integer e that we need to perform the computation H0 -> this then also allows to compute all other cohomologies
      e := 0;
      while not TORIC_VARIETIES_INTERNAL_GS_PARAMETER_CHECK( variety, e, module, 0 ) do
	e := e + 1;
      od;

      # inform the user that we found a suitable integer
      Print( Concatenation( "Found integer: ", String( e ) , "\n" ) );

      # now compute the appropriate Frobenius power of the irrelevant ideal
      BPower := GradedLeftSubmodule( List( EntriesOfHomalgMatrix( MatrixOfSubobjectGenerators( B ) ), x -> x^(e) ) );	

      # compute the cohomology classes
      zero := List( [ 1..Rank( ClassGroup( variety ) ) ], x -> 0 );
      cohoms := [];
      for i in [ 0..Dimension( variety ) ] do

	# compute the module that we need to truncate    
	GE := ByASmallerPresentation( GradedExt( i, BPower, module ) );

	# truncate the degree 0 part
	cohom := DegreeXPartOfFPModule( variety, GE, zero );
	Add( cohoms, [ i, cohom ] );

	# inform the user that we computed another cohomology class
	Print( Concatenation( "Computation finished for i=", String( i ) , "\n" ) );
	Display( cohom );
	Print( "...\n" );
	
      od;

      # return the result
      return [e, cohoms];

    else
    
      # unfortunately the bundle is not ample
      Print( "The bundle 'degree of irrelevant ideal' is not ample." );
      return;
          
    fi;

end );


#######################################
##
## Methods specialised to CPN
##
#######################################

# check if a toric variety is CPN
InstallMethod( IsCPN, 
               " for a toric variety ",
               [ IsToricVariety ],
  function( variety )
  local rank, B, gensOfB, degrees;
  
  # obtain rank of the class group
  rank := Rank( ByASmallerPresentation( ClassGroup( variety ) ) );
  
  # initialise CoxRing and extract the weights of its indeterminantes
  CoxRing( variety );
  degrees := WeightsOfIndeterminates( CoxRing( variety ) );

  
  # extract irrelevant ideal and its generators
  B := IrrelevantIdeal( variety );
  gensOfB := EntriesOfHomalgMatrix( MatrixOfMap( EmbeddingInSuperObject( B ) ) );
  
  # now check if this variety is CPN 
  if not rank = 1 then
  
    return false;
  
  elif not degrees = List( [ 1..Length( degrees ) ] , x -> 1 ) then
  
    return false;
     
  elif not gensOfB = IndeterminatesOfPolynomialRing( CoxRing( variety ) ) then
  
    return false;
  
  fi;

  # all tests passed, so this is (probably?) a CPN 
  # hence return 'true'
  return true;
  
end );

# compute H0 of that particular bundle via linear regularity
InstallMethod( H0OnCPNViaLinReg,
               " for a toric variety and graded left module",
               [ IsToricVariety, IsGradedModuleOrGradedSubmoduleRep ],
  function( variety, module )
    local deltaMd , m, mPower, H0Func;

    #compute the maximal ideal
    m := IrrelevantIdeal( variety );

    #determine deltaMd according to lemma 4.2 - this is the critical line
    deltaMd := Maximum( 0, LinearRegularity( module ) + 1 );

    #compute the linRegIndex'th Frobenius power of m
    mPower := GradedLeftSubmodule( List( EntriesOfHomalgMatrix( MatrixOfSubobjectGenerators( m ) ), a -> a^(deltaMd) ) );	
	
    #compute H0
    H0Func := HilbertFunction( ByASmallerPresentation( GradedHom( mPower, module ) ) );

    # return only H^0 of the bundle asked by the user, however we know H^0 also for the positive twists of that bundle
    return H0Func( 0 );
 
end );


# compute H0 of bundle and all its positive twists via linear regularity
InstallMethod( H0OnCPNForAllTwistsViaLinReg,
               " for a toric variety and graded left module",
               [ IsToricVariety, IsGradedModuleOrGradedSubmoduleRep ],
  function( variety, module )
    local deltaMd , m, mPower, H0Func;

    #compute the maximal ideal
    m := IrrelevantIdeal( variety );

    #determine deltaMd according to lemma 4.2 - this is the critical line
    deltaMd := Maximum( 0, LinearRegularity( module ) + 1 );

    #compute the linRegIndex'th Frobenius power of m
    mPower := GradedLeftSubmodule( List( EntriesOfHomalgMatrix( MatrixOfSubobjectGenerators( m ) ), a -> a^(deltaMd) ) );	
	
    #compute H0
    H0Func := HilbertFunction( ByASmallerPresentation( GradedHom( mPower, module ) ) );

    # return only H^0 of the bundle asked by the user, however we know H^0 also for the positive twists of that bundle
    return H0Func;
 
end );


# compute H0 of bundle and all its positive twists via linear regularity
InstallMethod( H0OnCPNInRangeViaLinReg,
               " for a toric variety and graded left module",
               [ IsToricVariety, IsGradedModuleOrGradedSubmoduleRep, IsList ],
  function( variety, module, range )
    local deltaMd , m, mPower, H0Func;

    #compute the maximal ideal
    m := IrrelevantIdeal( variety );

    #determine deltaMd according to lemma 4.2 - this is the critical line
    deltaMd := Maximum( 0, LinearRegularity( module ) + 1 );

    #compute the linRegIndex'th Frobenius power of m
    mPower := GradedLeftSubmodule( List( EntriesOfHomalgMatrix( MatrixOfSubobjectGenerators( m ) ), a -> a^(deltaMd) ) );	
	
    #compute H0
    H0Func := HilbertFunction( ByASmallerPresentation( GradedHom( mPower, module ) ) );

    # return only H^0 of the bundle asked by the user, however we know H^0 also for the positive twists of that bundle
    return List( range, x -> [ x, H0Func( x ) ] );
 
end );


####################################################
##
## Methods for the computation of H^0 on smooth and compact toric varieties
## which hand the input over to the fastest knwon method implemented thus far
##
####################################################

# compute H0 of bundle and all its positive twists via linear regularity
InstallMethod( H0,
               " for a toric variety and graded left module",
               [ IsToricVariety, IsGradedModuleOrGradedSubmoduleRep ],
  function( variety, module )
    local deltaMd , m, mPower, H0Func;

    # check what input we have and then hand the input to the most favorable method  
    if not IsSmooth( variety ) then
    
      Error( "The variety must be smooth." );
      return;
       
    elif not IsComplete( variety ) then
    
      Error( "The variety must be complete." );
      return;
      
    elif not IsProjective( variety ) then
    
      Print( "Let us try to use the methods of the B-transform to gain an idea about H^0. \n" );
      Print( "We pick a range from 0 to 5 now... \n" );
      return H0FromBTransformInInterval( variety, module, 0, 5 );   

    elif IsCPN( variety ) then

      Print( "This variety is a CPN. Therefore we apply linear regularity to compute H^0. \n" );
      return H0OnCPNViaLinReg( variety, module );
      
    else
    
      Print( "This variety is smooth, complete and projective. Therefore we apply the theorem of Greg Smith to compute H^0. \n" );
      return H0ByGS( variety, module );
    
    fi;
  
end );
