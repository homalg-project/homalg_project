LoadPackage( "ToricVarieties" );

rays := [ [ 1, 0, 1 ], [ 1, 1, 0 ], [ 1, 0, -1 ],[ 1, -1, 0 ], [ 0, 0, 1 ], [ 0, 1, 0 ], [ 0, 0, -1 ],[ 0, -1, 0 ] ];

cones := [ [ 1, 2, 3, 4 ], [ 1, 2 , 5, 6], [ 2, 3, 6, 7 ], [ 3, 4, 7, 8 ], [ 4, 1, 8, 5 ] ];

F := Fan( rays, cones );

T := ToricVariety( F );

## This variety is not simplicial. We might want to check a thing about it

ClassGroup( T );

PicardGroup( F );

## We know see that this one is no orbifold.