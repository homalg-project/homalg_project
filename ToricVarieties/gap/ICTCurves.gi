################################################################################################
##
##  ICTCurves.gi                       SheafCohomologyOnToricVarieties package
##
##  Copyright 2016                     Martin Bies,       ITP Heidelberg
##
#! @Chapter Irreducible, complete, torus-invariant curves and proper 1-cycles in a toric variety
##
################################################################################################



##############################################################################################
##
## Section GAP category of irreducible, complete, torus-invariant curves
##
##############################################################################################

# install ICT curves
DeclareRepresentation( "IsICTCurveRep",
                       IsICTCurve and IsAttributeStoringRep,
                       [ ] );

BindGlobal( "TheFamilyOfICTCurves",
            NewFamily( "TheFamilyOfICTCurves" ) );

BindGlobal( "TheTypeOfICTCurve",
            NewType( TheFamilyOfICTCurves,
                     IsICTCurveRep ) );



####################################################################################################################################
##
## Section A function that computes an integral vector u according to proposition 6.3.8 in "ToricVarities" by Cox, Schenk and Little
##
####################################################################################################################################

# local function used to compute a u according to prop. 6.3.8 in CSL
BindGlobal( "TORIC_VARIETIES_INTERNAL_COMPUTEU",
  function( rayGeneratorsOfMaxConej, rayGeneratorsOfTau, variety )
    local coneOfMaxConej, inequalitiesOfConeOfMaxConej, i, equation, intersectionCone, gens, u, tau, matrix, map, epi, epiMatrixList, 
         testray;

    # V( tau ) is the entire variety, which happens to be of dimension 1, so V( tau ) is a curve -> valid case
    if rayGeneratorsOfTau = [] and Dimension( variety ) = 1 then
 
      # in this case (since we assume the variety complete) N = N_\tau = Z. So if 1 in sigma_j, then u = 1 and otherwise u = -1.
      # just check if 1 is a ray generators of maxConej to decide which vector u we have to pick
      if not Position( rayGeneratorsOfMaxConej, [ 1 ] ) = fail then
        u := [ 1 ];
      else
        u := [ -1 ];
      fi;

      # return the result
      return u;

    # now the non-degenerate case
    else

      # we can now compute tau as a cone and check if it is of the correct dimension
      tau := NmzCone( [ "integral_closure", rayGeneratorsOfTau ] );

      # given that \tau is indeed a curve we can proceed to compute the map Z^|gens of tau| -> Z^[dim \Sigma]
      matrix := HomalgMatrix( rayGeneratorsOfTau, HOMALG_MATRICES.ZZ);
      map := HomalgMap( matrix, Length( rayGeneratorsOfTau ) * HOMALG_MATRICES.ZZ, Length( rayGeneratorsOfTau[ 1 ] ) * HOMALG_MATRICES.ZZ );

      # now compute the cokernel of this map
      epi := CokernelEpi( map );

      # and extract the matrix encoding this epi
      epiMatrixList := EntriesOfHomalgMatrix( MatrixOfMap( ByASmallerPresentation( epi ) ) );

      # find a ray of MaxConej which does belong to Tau (all others are mapped to zero by the projection)
      i := 1;
      testray := rayGeneratorsOfMaxConej[ i ];
      while not Position( rayGeneratorsOfTau, testray ) = fail do

        i := i + 1;
        testray := rayGeneratorsOfMaxConej[ i ]; 

      od;

      # then the inner product of this testray and epiMatrixList will tell us by its sign, if MaxConej maps to Cone( 1 ) or Cone( -1 )
      # in N_\tau
      # then prepare equation to define a cone by inequalities in Normaliz
      equation := ShallowCopy( epiMatrixList );
      if epiMatrixList * testray > 0 then
        Append( equation, [ -1 ] );
      else
        Append( equation, [ 1 ] );
      fi;

      # compute the inequalities that define maxConej (this is necessary to compute the intersection cone, because normaliz
      # does so far not except 'integral closure' and 'inhom_equations' as mutual input
      coneOfMaxConej := NmzCone( [ "integral_closure", rayGeneratorsOfMaxConej ] );
      inequalitiesOfConeOfMaxConej := NmzSupportHyperplanes( coneOfMaxConej );

      # now compute the intersection cone and its module generators
      intersectionCone := NmzCone( [ "inequalities", inequalitiesOfConeOfMaxConej, "inhom_equations", [ equation ] ] );
      gens := NmzModuleGenerators( intersectionCone );

      # take u to be the first module generator
      u := gens[ 1 ];
      #(the last entry is redundant output from normaliz and needs to be removed)
      Remove( u, Length( u ) );

      # finally return the result
      return u;

    fi;

end );



##############################################################################################
##
#! @Section Constructors for ICT curves
##
##############################################################################################

# constructor for ICT curve
InstallMethod( ICTCurve,
               " a toric variety and two non-negative and distinct integers",
               [ IsToricVariety, IsInt, IsInt, IsBool ],
  function( variety, i, j, check_dim )
    local max_cones, rays1, rays2, rays_tau, k, cone_tau, explicit_rays2, u, intersection_list, class, divisor, CartData, m1, m2, 
         vars, defining_variables, ICT_curve;

    # check if the input is valid
    if not IsSmooth( variety ) then

      Error( "This method is currently only supported for smooth and complete toric varieties" );
      return;

    elif not IsComplete( variety ) then

      Error( "This method is currently only supported for smooth and complete toric varieties" );
      return;

    fi;
    max_cones := Length( RaysInMaximalCones( FanOfVariety( variety ) ) );
    if i < 1 then

      Error( "The two integers must be positive" );
      return;

    elif j < 1 then

      Error( "The two integers must be positive" );
      return;

    elif i > max_cones then

      Error( "The two integers must not exceed the number of maximal cones" );
      return;

    elif j > max_cones then

      Error( "The two integers must not exceed the number of maximal cones" );
      return;

    elif i = j then

      Error( "The two integers must not be the same" );
      return;

    fi;

    # now identify the ray generators of the cone \tau = \sigma_i and \sigma_j (sigma_i/j the i-th/i-th max. cone)
    vars := IndeterminatesOfPolynomialRing( CoxRing( variety ) );
    defining_variables := [];
    rays1 := RaysInMaximalCones( FanOfVariety( variety ) )[ i ];
    rays2 := RaysInMaximalCones( FanOfVariety( variety ) )[ j ];
    rays_tau := [];
    for k in [ 1 .. Length( rays1 ) ] do

      if rays1[ k ] = 1 and rays2[ k ] = 1 then
        Add( rays_tau, RayGenerators( FanOfVariety( variety ) )[ k ] );
        Add( defining_variables, vars[ k ] );
      fi;

    od;

    # perform sanity checks if wished for
    if check_dim then

      # check that the dimension of the cone tau is Dimension( variety ) - 1
      if rays_tau = [] then

        # this is a curve iff the variety is of dimension 1, so if Dimension( variety ) <> 1 we raise an error
        if Dimension( variety ) <> 1 then

          Error( Concatenation( "V( tau ) corresponds to the entire variety which happens to be of dimension different",
                                " than 1. So V( tau ) is NOT a curve" ) );
          return;

        fi;

      elif not rays_tau = [] then

        # we can now compute tau as a cone and check if it is of the correct dimension
        cone_tau := NmzCone( [ "integral_closure", rays_tau ] );
        if not NmzRank( cone_tau ) = Dimension( variety ) - 1 then

          Error( "The dimension of tau is not dim( X_Sigma ) - 1. Thus V( tau ) is NOT a curve" );
          return;

        fi;

      fi;

    fi;

    # we compute an ICT curve C together with the following attributes:
    # (0) maximal cones that were intersected to form the cone \tau
    # (1) the ray-generators of the cone \tau
    # (2) the integral_vector u used to compute the intersection product with a (Cartier) divisor
    # (3) a list with the intersection numbers with a basis of the class group
    # (4) the list of variables whose simulaneous vanishing locus is the curve

    # @(2):
    explicit_rays2 := [];
    for k in [ 1 .. Length( rays2 ) ] do

      if rays2[ k ] = 1 then
        Add( explicit_rays2, RayGenerators( FanOfVariety( variety ) )[ k ] );
      fi;

    od;
    u := TORIC_VARIETIES_INTERNAL_COMPUTEU( explicit_rays2, rays_tau, variety );

    # @(3):
    intersection_list := [];
    for k in [ 1 .. Rank( ClassGroup( variety ) ) ] do
      class := ListWithIdenticalEntries( Rank( ClassGroup( variety ) ), 0 );
      class[ k ] := 1;
      divisor := DivisorOfGivenClass( variety, class );
      CartData := CartierData( divisor );
      m1 := CartData[ i ];
      m2 := CartData[ j ];
      Add( intersection_list, Sum( List( [ 1 .. Length( u ) ], x -> ( m1[ x ] - m2[ x ] ) * u [ x ] ) ) ); 
    od;

    # now objectify to form an ICT curve and return it
    ICT_curve := rec( );
    ObjectifyWithAttributes( ICT_curve, TheTypeOfICTCurve,
                             AmbientToricVariety, variety,
                             IntersectedMaximalCones, [ i,j ],
                             RayGenerators, rays_tau,
                             IntersectionU, u,
                             IntersectionList, intersection_list,
                             DefiningVariables, defining_variables
                            );
    return ICT_curve;

end );

# constructor for ICT curve
InstallMethod( ICTCurve,
               " a toric variety and two non-negative and distinct integers",
               [ IsToricVariety, IsInt, IsInt ],
  function( variety, i, j )

  return ICTCurve( variety, i, j, true );

end );



################################################
##
## Section: String method for ICT curves
##
################################################

InstallMethod( String,
              [ IsICTCurve ],
  function( Curve )

     return Concatenation( "An irreducible, complete, torus-invariant curve in a toric variety given as V( ",
                           String( DefiningVariables( Curve ) ),
                           " )" );

end );



#################################################
##
## Section: Display method for ICT curves
##
#################################################

InstallMethod( Display,
              [ IsICTCurve ],
  function( curve )

  Print( "An irreducible, complete, torus-invariant curve in the toric variety with Cox ring: \n \n" );
  ViewObj( CoxRing( AmbientToricVariety( curve ) ) );
  Print( "\n \n" );
  Print( "and irrelevant ideal: \n \n" );
  Display( IrrelevantIdeal( AmbientToricVariety( curve ) ) );
  Print( "\n" );
  Print( "The structure sheaf of the curve is obtained from sheafifying the following module:" );
  FullInformation( StructureSheaf( curve ) );

end );



######################################
##
## Section: View method for ICT curves
##
######################################

##
InstallMethod( ViewObj,
               [ IsICTCurve ], 
               999, # FIXME FIXME FIXME!!!
function( curve )

      Print( Concatenation( "<", String( curve ), ">" ) );

end );



##############################################################################################
##
## Section: Attributes of ICT-Curves
##
##############################################################################################

InstallMethod( StructureSheaf,
               " for ICT-curve",
               [ IsICTCurve ],
  function( curve )
    local ideal;

    # now construct the structure sheaf
    ideal := GradedLeftSubmoduleForCAP( DefiningVariables( curve ), CoxRing( AmbientToricVariety( curve ) ) );
    return CAPPresentationCategoryObject( UnderlyingMorphism( EmbeddingInSuperObjectForCAP( ideal ) ) );

end );



##############################################################################################
##
## Section: A few opperations with ICTCurves
##
##############################################################################################

InstallMethod( ICTCurves,
               " for toric varieties",
               [ IsToricVariety ],
  function( variety )
    local max_cones, ray_generators, i, j, k, l, rays_in_max_cone_i, rays_in_max_cone_j, rays_tau, dim_tau, cone_tau, ICT_curves_list, 
         test_curve, exists;
    # check if the input is valid
    if not IsSmooth( variety ) then

      Error( "This method is currently only supported for smooth and complete toric varieties" );
      return;

    elif not IsComplete( variety ) then

      Error( "This method is currently only supported for smooth and complete toric varieties" );
      return;

    fi;

    # initialise the ICT_curves_list
    ICT_curves_list := [];

    # extract the maximal cones of the fan and the ray generators
    max_cones := RaysInMaximalCones( FanOfVariety( variety ) );
    ray_generators := RayGenerators( FanOfVariety( variety ) );

    # scan over all pairs of maximal cones and check if the cone tau formed from their intersection is
    # of dimension n - 1 (n = dim( variety ) )
    # -> then product the corresponding ICT-curve
    for i in [ 1 .. Length( max_cones ) - 1 ] do

      for j in [ i + 1 .. Length( max_cones ) ] do

        # now identify the ray generators of the cone \tau = \sigma_i \cap \sigma_j (sigma_i/j the i-th/i-th max. cone) and of \sigma_j
        rays_in_max_cone_i := RaysInMaximalCones( FanOfVariety( variety ) )[ i ];
        rays_in_max_cone_j := RaysInMaximalCones( FanOfVariety( variety ) )[ j ];
        rays_tau := [];
        for k in [ 1 .. Length( rays_in_max_cone_i ) ] do

          if rays_in_max_cone_i[ k ] = 1 and rays_in_max_cone_j[ k ] = 1 then
            Add( rays_tau, RayGenerators( FanOfVariety( variety ) )[ k ] );
          fi;

        od;

        # compute the dimension of the cone tau 
        if rays_tau = [] then
          dim_tau := 0;
        else
          cone_tau := NmzCone( [ "integral_closure", rays_tau ] );
          dim_tau := NmzRank( cone_tau );
        fi;

        # now check if the dimension of the cone \tau is dim( X_\Sigma ) - 1 and add the curve in this case
        if dim_tau = Dimension( variety ) - 1 then

          Add( ICT_curves_list, ICTCurve( variety, i, j, false ) );

        fi;

      od;

    od;

    # now return the result
    return ICT_curves_list;

end );

# compute the intersection product of the torus invarant complete curve with a toric divisor
InstallMethod( IntersectionProduct,
               " for an ICT-curve and a toric divisor",
               [ IsICTCurve, IsToricDivisor ],
  function( curve, divisor )
    local u, CartData, m1, m2;

    # extract the intersection u from the curve
    u := IntersectionU( curve );

    # and the Cartier data of the divisor
    CartData := CartierData( divisor );

    # now extract the two vectors from the Cartier data, which correspond to the maximal cones intersected to form the ICT-curve
    m1 := CartData[ IntersectedMaximalCones( curve )[ 1 ] ];
    m2 := CartData[ IntersectedMaximalCones( curve )[ 2 ] ];

    # and compute from them and u the intersection number as I := < m1-m2, u >
    return Sum( List( [ 1 .. Length( u ) ], x -> ( m1[ x ] - m2[ x ] ) * u [ x ] ) ); 

end );

# compute the intersection product of the torus invarant complete curve associated via the cone-orbit-correspondance to the intersection of
# the maximal cones i and j and a given toric Cartier divisor
InstallMethod( IntersectionProduct,
               " for an ICT-curve and a toric divisor",
               [ IsToricDivisor, IsICTCurve ],
  function( divisor, curve )

    return IntersectionProduct( curve, divisor );

end );



##############################################################################################
##
#! @Section GAP category for proper 1-cycles
##
##############################################################################################

# install ICT curves
DeclareRepresentation( "IsProper1CycleRep",
                       IsProper1Cycle and IsAttributeStoringRep,
                       [ ] );

BindGlobal( "TheFamilyOfProper1Cycles",
            NewFamily( "TheFamilyOfProper1Cycles" ) );

BindGlobal( "TheTypeOfProper1Cycle",
            NewType( TheFamilyOfProper1Cycles,
                     IsProper1CycleRep ) );



##############################################################################################
##
#! @Section Constructor For Proper 1-Cycles
##
##############################################################################################

InstallMethod( GeneratorsOfProper1Cycles,
               " for toric varieties",
               [ IsToricVariety ],
  function( variety )
    local max_cones, ray_generators, i, j, k, l, rays_in_max_cone_i, rays_in_max_cone_j, rays_tau, dim_tau, cone_tau, ICT_curves_list, 
         test_curve, exists;
    # check if the input is valid
    if not IsSmooth( variety ) then

      Error( "This method is currently only supported for smooth and complete toric varieties" );
      return;

    elif not IsComplete( variety ) then

      Error( "This method is currently only supported for smooth and complete toric varieties" );
      return;

    fi;

    # initialise the ICT_curves_list
    ICT_curves_list := [];

    # extract the maximal cones of the fan and the ray generators
    max_cones := RaysInMaximalCones( FanOfVariety( variety ) );
    ray_generators := RayGenerators( FanOfVariety( variety ) );

    # scan over all pairs of maximal cones and check if the cone tau formed from their intersection is
    # of dimension n - 1 (n = dim( variety ) )
    # -> then product the corresponding ICT-curve
    for i in [ 1 .. Length( max_cones ) - 1 ] do

      for j in [ i + 1 .. Length( max_cones ) ] do

        # now identify the ray generators of the cone \tau = \sigma_i \cap \sigma_j (sigma_i/j the i-th/i-th max. cone) and of \sigma_j
        rays_in_max_cone_i := RaysInMaximalCones( FanOfVariety( variety ) )[ i ];
        rays_in_max_cone_j := RaysInMaximalCones( FanOfVariety( variety ) )[ j ];
        rays_tau := [];
        for k in [ 1 .. Length( rays_in_max_cone_i ) ] do

          if rays_in_max_cone_i[ k ] = 1 and rays_in_max_cone_j[ k ] = 1 then
            Add( rays_tau, RayGenerators( FanOfVariety( variety ) )[ k ] );
          fi;

        od;

        # compute the dimension of the cone tau 
        if rays_tau = [] then
          dim_tau := 0;
        else
          cone_tau := NmzCone( [ "integral_closure", rays_tau ] );
          dim_tau := NmzRank( cone_tau );
        fi;

        # now check if the dimension of the cone \tau is dim( X_\Sigma ) - 1 and add the curve in this case
        if dim_tau = Dimension( variety ) - 1 then

          # now check through the previously computed curves to see if we have found a curve which is numerically equiavlent
          # if so, do not add this curve, for they represent the same proper 1 cycle in this case!

          # initialise the curve
          test_curve := ICTCurve( variety, i, j, false );

          # and start the scan
          exists := false;
          k := 1;
          while ( not exists and k < Length( ICT_curves_list ) + 1 ) do

            # if the intersection numbers with the standard basis of Cl( variety ) agree, then the two ICT-curves are numerically equivalent
            if IntersectionList( ICT_curves_list[ k ] ) = IntersectionList( test_curve ) then
              exists := true;
            fi;

            # otherwise increase the count
            k := k+1;

          od;

          # now check the result
          if not exists then
            Add( ICT_curves_list, test_curve );
          fi;

        fi;

      od;

    od;

    # now return the result
    return ICT_curves_list;

end );

InstallMethod( Proper1Cycle,
               " for a toric variety and a list of integers",
               [ IsToricVariety, IsList ],
  function( variety, list )
    local cycle, k;

    # check for valid input
    if not IsSmooth( variety ) then

      Error( "Currently this method is only supported for smooth and complete toric varieties" );
      return;

    elif not IsComplete( variety ) then

      Error( "Currently this method is only supported for smooth and complete toric varieties" );
      return;

    elif Length( list ) <> Length( GeneratorsOfProper1Cycles( variety ) ) then

      Error( "The given list cannot be interpreted as an element in the free Abelian group of ICT-curves with our choice of generators" );
      return;

    fi;

    for k in [ 1 .. Length( list ) ] do
      if not IsInt( list[ k ] ) then
        Error( "The entries in the given list must all be integers" );
        return;
      fi;
    od;

    # input is valid, so construct the proper 1-cycle
    cycle := rec( );
    ObjectifyWithAttributes( cycle, TheTypeOfProper1Cycle,
                             AmbientToricVariety, variety,
                             UnderlyingGroupElement, list
                            );
    return cycle;

end );

InstallMethod( Proper1Cycle,
               " for a toric variety and a list of integers",
               [ IsToricVariety, IsHomalgModuleElement ],
  function( variety, element )

    return Proper1Cycle( variety, UnderlyingListOfRingElements( element ) );

end );



################################################
##
## Section: String method for ICT curves
##
################################################

InstallMethod( String,
              [ IsProper1Cycle ],
  function( cycle )

     return "A proper 1-cycle in a toric variety";

end );



#################################################
##
## Section: Display method for ICT curves
##
#################################################

InstallMethod( Display,
              [ IsProper1Cycle ],
  function( cycle )

  Print( "A proper 1-cycle in the toric variety with Cox ring: \n \n" );
  ViewObj( CoxRing( AmbientToricVariety( cycle ) ) );
  Print( "\n \n" );
  Print( "and irrelevant ideal: \n \n" );
  Display( IrrelevantIdeal( AmbientToricVariety( cycle ) ) );
  Print( "\n" );
  Print( "The underlying group element is: \n" );
  Print( UnderlyingGroupElement( cycle ) );

end );



######################################
##
## Section: View method for ICT curves
##
######################################

##
InstallMethod( ViewObj,
               [ IsProper1Cycle ], 
               999, # FIXME FIXME FIXME!!!
function( cycle )

      Print( Concatenation( "<", String( cycle ), ">" ) );

end );





##############################################################################################
##
#! @Section Operations with proper 1-cycles
##
##############################################################################################

# compute the intersection product of a proper 1-cycle with a toric divisor
InstallMethod( IntersectionProduct,
               " for a proper 1-cycle and a toric divisor",
               [ IsProper1Cycle, IsToricDivisor ],
  function( cycle, divisor )

    return Sum( List( [ 1 .. Length( UnderlyingGroupElement( cycle ) ) ],
               k -> UnderlyingGroupElement( cycle )[ k ] *
                                  IntersectionProduct( GeneratorsOfProper1Cycles( AmbientToricVariety( cycle ) )[ k ], divisor ) ) );

end );

InstallMethod( IntersectionProduct,
               " for a proper 1-cycle and a toric divisor",
               [ IsToricDivisor, IsProper1Cycle ],
  function( divisor, cycle )

    return IntersectionProduct( cycle, divisor );

end );

# method to compute the intersection form of a toric variety and save it as attribute of the given toric variety
InstallMethod( IntersectionForm,
               "for toric varieties",
               [ IsToricVariety ],
  function( variety )
    local matrix_entries, cycles, i, degree, divisor, row;

    if not IsSmooth( variety ) then

      Error( "This method is currently only supported for smooth and complete toric varieties" );
      return;

    elif not IsComplete( variety ) then

      Error( "This method is currently only supported for smooth and complete toric varieties" );
      return;

    fi;

    # pick standard basis of the class group as e_i = ( 0, ..., 0, 1, 0, ..., 0 ) with 1 at position i
    # and compute the intersection products of the divisor D_i with all ICT-curves
    # we store the result in a matrix over the integers

    # initialise variables
    matrix_entries := [];
    cycles := GeneratorsOfProper1Cycles( variety );

    # compute the intersection numbers
    for i in [ 1 .. Rank( ClassGroup( variety ) ) ] do

      # construct divisor D_i = D( e_i )
      degree := ListWithIdenticalEntries( Rank( ClassGroup( variety ) ), 0 );
      degree[ i ] := 1;
      divisor := DivisorOfGivenClass( variety, degree );

      # and compute the intersection products
      row := List( [ 1 .. Length( cycles ) ], x -> IntersectionProduct( divisor, cycles[ x ] ) );

      # add to the matrix_entries
      Add( matrix_entries, row );

    od;

    # return the result
    return matrix_entries;

end );
