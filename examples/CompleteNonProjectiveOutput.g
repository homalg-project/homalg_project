gap> LoadPackage( "ToricVarieties" );
true
gap> rays := [ [1,0,0], [-1,0,0], [0,1,0], [0,-1,0], [0,0,1], [0,0,-1],
>           [2,1,1], [1,2,1], [1,1,2], [1,1,1] ];
[ [ 1, 0, 0 ], [ -1, 0, 0 ], [ 0, 1, 0 ], [ 0, -1, 0 ], [ 0, 0, 1 ],
[ 0, 0, -1 ], [ 2, 1, 1 ], [ 1, 2, 1 ], [ 1, 1, 2 ], [ 1, 1, 1 ] ]
gap> 
gap> cones := [ [1,3,6], [1,4,6], [1,4,5], [2,3,6], [2,4,6], [2,3,5], [2,4,5],
>            [1,5,9], [3,5,8], [1,3,7], [1,7,9], [5,8,9], [3,7,8],
>            [7,9,10], [8,9,10], [7,8,10] ];
[ [ 1, 3, 6 ], [ 1, 4, 6 ], [ 1, 4, 5 ], [ 2, 3, 6 ], [ 2, 4, 6 ], [ 2, 3, 5 ],
[ 2, 4, 5 ], [ 1, 5, 9 ], [ 3, 5, 8 ], [ 1, 3, 7 ], 
  [ 1, 7, 9 ], [ 5, 8, 9 ], [ 3, 7, 8 ], [ 7, 9, 10 ], [ 8, 9, 10 ], [ 7, 8, 10 ] ]
gap> 
gap> F := Fan( rays, cones );
<A fan>
gap> 
gap> T := ToricVariety( F );
<A toric variety>
gap> 
gap> IsComplete( T );
true
gap> 
gap> IsAffine( T );
false
gap> 
gap> SetIsProjective( T, false );
gap> 
gap> Dimension( T );
3
gap> 
gap> HasTorusfactor( T );
false
gap> 
gap> IsSmooth( T );
true
gap> 
gap> ClassGroup( T );
<A non-torsion left module presented by 3 relations for 10 generators>
gap> 
gap> PicardGroup( T );
<A non-torsion left submodule given by 10 generators>
gap> 
gap> CoxRing( T, "x" );
Q[x_1,x_2,x_3,x_4,x_5,x_6,x_7,x_8,x_9,x_10]
(weights: [ [ 0, 0, 0, 0, 0, 1, -1, -1, -2, -1 ], 
 [ 0, 0, 0, 1, 0, 0, -1, -2, -1, -1 ], 
 [ 0, 0, 0, 0, 1, 0, 2, 1, 1, 1 ],
 [ 0, 0, 0, 1, 0, 0, 0, 0, 0, 0 ], 
 [ 0, 0, 0, 0, 1, 0, 0, 0, 0, 0 ],
 [ 0, 0, 0, 0, 0, 1, 0, 0, 0, 0 ],
 [ 0, 0, 0, 0, 0, 0, 1, 0, 0, 0 ],
 [ 0, 0, 0, 0, 0, 0, 0, 1, 0, 0 ], 
 [ 0, 0, 0, 0, 0, 0, 0, 0, 1, 0 ],
 [ 0, 0, 0, 0, 0, 0, 0, 0, 0, 1 ] ])
gap> 
gap> Display( ClassGroup ( T ) );
[ [   1,   0,   0,   0,   0,  -1,   1,   1,   2,   1 ],
  [   0,   1,   0,  -1,   0,   0,   1,   2,   1,   1 ],
  [   0,   0,  -1,   0,   1,   0,   2,   1,   1,   1 ] ]

Cokernel of the map

Z^(1x3) --> Z^(1x10),

currently represented by the above matrix
gap> 
gap> Display( ByASmallerPresentation( ClassGroup( T ) ) );
Z^(1 x 7)
gap> 
gap> CoxRing( T );
Q[x_1,x_2,x_3,x_4,x_5,x_6,x_7,x_8,x_9,x_10]
(weights: [ [ 0, 0, 1, -1, -1, -2, -1 ],
 [ 1, 0, 0, -1, -2, -1, -1 ],
 [ 0, 1, 0, 2, 1, 1, 1 ],
 [ 1, 0, 0, 0, 0, 0, 0 ],
 [ 0, 1, 0, 0, 0, 0, 0 ],
 [ 0, 0, 1, 0, 0, 0, 0 ],
 [ 0, 0, 0, 1, 0, 0, 0 ], 
 [ 0, 0, 0, 0, 1, 0, 0 ], 
 [ 0, 0, 0, 0, 0, 1, 0 ], 
 [ 0, 0, 0, 0, 0, 0, 1 ] ])
