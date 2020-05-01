#! @Chunk HilbertBasis

LoadPackage( "4ti2Interface" );

#! We want to compute the Hilbert basis of the cone obtained
#! by intersecting the positive orthant with the hyperplane
#! given by the equation below.

#! @Example
gens := [ 23, 25, 37, 49 ];
#! [ 23, 25, 37, 49 ]
equation := [ Concatenation( gens, -gens ) ];
#! [ [ 23, 25, 37, 49, -23, -25, -37, -49 ] ]
basis := 4ti2Interface_hilbert_equalities_in_positive_orthant( equation );;
Length( basis );
#! 436
#! @EndExample
