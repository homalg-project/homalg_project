#! @Chunk HilbertBasis2

LoadPackage( "4ti2Interface" );

#! We want to compute the Hilbert basis of the cone which faces
#! are represented by the inequalities below. This example is
#! taken from the toric and the ToricVarieties package manual.
#! In both packages it is very slow with the internal algorithms.

#! @Example
inequalities := [ [1,2,3,4], [0,1,0,7], [3,1,0,2], [0,0,1,0] ];
#! [ [ 1, 2, 3, 4 ], [ 0, 1, 0, 7 ], [ 3, 1, 0, 2 ], [ 0, 0, 1, 0 ] ]
basis := 4ti2Interface_hilbert_inequalities( inequalities );;
Length( basis );
#! 29
#! @EndExample
