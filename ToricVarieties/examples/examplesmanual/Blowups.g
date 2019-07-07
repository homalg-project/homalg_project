#! @Chunk Blowups

LoadPackage( "ToricVarities" );

#! The following code exemplifies blowups of the 3-dimensional affine space.

#! @Example
rays := [ [1,0,0], [0,1,0], [0,0,1] ];
#! [ [1,0,0], [0,1,0], [0,0,1] ]
max_cones := [ [1,2,3] ];
#! [ [1,2,3] ]
fan := Fan( rays, max_cones );
#! <A fan in |R^3>
C3 := ToricVariety( rays, max_cones, [[0],[0],[0]], "x1,x2,x3" );
#! <A toric variety of dimension 3>
B1C3 := BlowupOfToricVariety( C3, "x1,x2,x3", "u0" );
#! <A toric variety of dimension 3>
[ IsComplete( B1C3 ), IsOrbifold( B1C3 ), IsSmooth( B1C3 ) ];
#! [ false, true, true ]
B2C3 := BlowupOfToricVariety( B1C3, "x1,u0", "u1" );
#! <A toric variety of dimension 3>
Rank( ClassGroup( B2C3 ) );
#! 3
B3C3 := BlowupOfToricVariety( B2C3, "x1,u1", "u2" );
#! <A toric variety of dimension 3>
CoxRing( B3C3 );
#! Q[x3,x2,x1,u0,u1,u2]
#! (weights: [ ( 0, 1, 0, 0 ), ( 0, 1, 0, 0 ), ( 0, 1, 1, 1 ), 
#! ( 0, -1, 1, 0 ), ( 0, 0, -1, 1 ), ( 0, 0, 0, -1 ) ])
#! @EndExample

#! Likewise, we can also perform blowups of the 3-dimensional projective space.

#! @Example
rays := [ [1,0,0], [0,1,0], [0,0,1], [-1,-1,-1] ];
#! [ [1,0,0], [0,1,0], [0,0,1], [-1,-1,-1] ]
max_cones := [ [1,2,3], [1,2,4], [1,3,4], [2,3,4] ];
#! [ [1,2,3], [1,2,4], [1,3,4], [2,3,4] ]
fan := Fan( rays, max_cones );
#! <A fan in |R^3>
P3 := ToricVariety( rays, max_cones, [[1],[1],[1],[1]], "x1,x2,x3,x4" );
#! <A toric variety of dimension 3>
B1P3 := BlowupOfToricVariety( P3, "x1,x2,x3", "u0" );
#! <A toric variety of dimension 3>
[ IsComplete( B1P3 ), IsOrbifold( B1P3 ), IsSmooth( B1P3 ) ];
#! [ true, true, true ]
B2P3 := BlowupOfToricVariety( B1P3, "x1,u0", "u1" );
#! <A toric variety of dimension 3>
Rank( ClassGroup( B2C3 ) );
#! 3
B3P3 := BlowupOfToricVariety( B2P3, "x1,u1", "u2" );
#! <A toric variety of dimension 3>
CoxRing( B3P3 );
#! Q[x4,x3,x2,x1,u0,u1,u2]
#! (weights: [ ( 1, 0, 0, 0 ), ( 1, 1, 0, 0 ), ( 1, 1, 0, 0 ), 
#! ( 1, 1, 1, 1 ), ( 0, -1, 1, 0 ), ( 0, 0, -1, 1 ), ( 0, 0, 0, -1 ) ])
#! @EndExample

#! Also, we can perform blowups of a generalized Hirzebruch 3-fold.

#! @Example
vars := "u,s,v,t,r";
#! "u,s,v,t,r"
rays := [ [0,0,-1],[1,0,0],[0,1,0],[-1,-1,-17],[0,0,1] ];
#! [ [0,0,-1],[1,0,0],[0,1,0],[-1,-1,-17],[0,0,1] ]
cones := [ [1,2,3], [1,2,4], [1,3,4], [2,3,5], [2,4,5], [3,4,5] ];
#! [ [1,2,3], [1,2,4], [1,3,4], [2,3,5], [2,4,5], [3,4,5] ]
weights := [ [1,-17], [0,1], [0,1], [0,1], [1,0] ];
#! [ [1,-17], [0,1], [0,1], [0,1], [1,0] ]
H3fold := ToricVariety( rays, cones, weights, vars );
#! <A toric variety of dimension 3>
B1H3fold := BlowupOfToricVariety( H3fold, "u,s", "u1" );
#! <A toric variety of dimension 3>
CoxRing( B1H3fold );
#! Q[t,u,r,v,u1,s]
#! (weights: [ ( 0, 1, 0 ), ( 1, -17, 1 ), ( 1, 0, 0 ), 
#! ( 0, 1, 0 ), ( 0, 0, -1 ), ( 0, 1, 1 ) ])
#! @EndExample

#! This example easily extends to an entire sequence of blowups.

#! @Example
vars := "u,s,v,t,r,x,y,w";
#! "u,s,v,t,r,x,y,w"
rays := [ [0,0,-1,-2,-3], [1,0,0,-2,-3], [0,1,0,-2,-3], [-1,-1,-17,-2,-3], 
          [0,0,1,-2,-3], [0, 0, 0, 1, 0], 
[0, 0, 0, 0, 1], [0, 0, 0, -2, -3] ];
#! [ [0,0,-1,-2,-3], [1,0,0,-2,-3], [0,1,0,-2,-3], [-1,-1,-17,-2,-3], 
#! [0,0,1,-2,-3], [0, 0, 0, 1, 0], [0, 0, 0, 0, 1], [0, 0, 0, -2, -3] ]
cones := [ [1,2,3,6,7], [1,2,3,6,8], [1,2,3,7,8], [1,2,4,6,7], [1,2,4,6,8],
           [1,2,4,7,8], [1,3,4,6,7], [1,3,4,6,8], [1,3,4,7,8], [2,3,5,6,7],
           [2,3,5,6,8], [2,3,5,7,8], [2,4,5,6,7], [2,4,5,6,8], [2,4,5,7,8],
           [3,4,5,6,7], [3,4,5,6,8], [3,4,5,7,8] ];
#! [ [ 1, 2, 3, 6, 7 ], [ 1, 2, 3, 6, 8 ], [ 1, 2, 3, 7, 8 ],
#!   [ 1, 2, 4, 6, 7 ], [ 1, 2, 4, 6, 8 ], [ 1, 2, 4, 7, 8 ],
#!   [ 1, 3, 4, 6, 7 ], [ 1, 3, 4, 6, 8 ], [ 1, 3, 4, 7, 8 ],
#!   [ 2, 3, 5, 6, 7 ], [ 2, 3, 5, 6, 8 ], [ 2, 3, 5, 7, 8 ],
#!   [ 2, 4, 5, 6, 7 ], [ 2, 4, 5, 6, 8 ], [ 2, 4, 5, 7, 8 ],
#!   [ 3, 4, 5, 6, 7 ], [ 3, 4, 5, 6, 8 ], [ 3, 4, 5, 7, 8 ] ]
w := [ [1,-17,0], [0,1,0], [0,1,0], [0,1,0], [1,0,0], [0,0,2], [0,0,3], 
       [-2,14,1] ];
#! [ [1,-17,0], [0,1,0], [0,1,0], [0,1,0], [1,0,0], [0,0,2], [0,0,3], [-2,14,1] ]
base := ToricVariety( rays, cones, w, vars );
#! <A toric variety of dimension 5>
b1 := BlowupOfToricVariety( base, "x,y,u", "u1" );
#! <A toric variety of dimension 5>
b2 := BlowupOfToricVariety( b1, "x,y,u1", "u2" );
#! <A toric variety of dimension 5>
b3 := BlowupOfToricVariety( b2, "y,u1", "u3" );
#! <A toric variety of dimension 5>
b4 := BlowupOfToricVariety( b3, "y,u2", "u4" );
#! <A toric variety of dimension 5>
b5 := BlowupOfToricVariety( b4, "u2,u3", "u5" );
#! <A toric variety of dimension 5>
b6 := BlowupOfToricVariety( b5, "u1,u3", "u6" );
#! <A toric variety of dimension 5>
b7 := BlowupOfToricVariety( b6, "u2,u4", "u7" );
#! <A toric variety of dimension 5>
b8 := BlowupOfToricVariety( b7, "u3,u4", "u8" );
#! <A toric variety of dimension 5>
b9 := BlowupOfToricVariety( b8, "u4,u5", "u9" );
#! <A toric variety of dimension 5>
b10 := BlowupOfToricVariety( b9, "u5,u8", "u10" );
#! <A toric variety of dimension 5>
b11 := BlowupOfToricVariety( b10, "u4,u8", "u11" );
#! <A toric variety of dimension 5>
b12 := BlowupOfToricVariety( b11, "u4,u9", "u12" );
#! <A toric variety of dimension 5>
b13 := BlowupOfToricVariety( b12, "u8,u9", "u13" );
#! <A toric variety of dimension 5>
b14 := BlowupOfToricVariety( b13, "u9,u11", "u14" );
#! <A toric variety of dimension 5>
b15 := BlowupOfToricVariety( b14, "u4,v", "d" );
#! <A toric variety of dimension 5>
final_space := BlowupOfToricVariety( b15, "u3,u5", "u15" );
#! <A toric variety of dimension 5>
#! @EndExample

#! This sequence of blowups can also be performed with a single command.

#! @Example
final_space2 := SequenceOfBlowupsOfToricVariety( base, 
                    [ ["x,y,u","u1"], 
                    ["x,y,u1","u2"],
                    ["y,u1","u3"],
                    ["y,u2","u4"],
                    ["u2,u3","u5"],
                    ["u1,u3","u6"],
                    ["u2,u4","u7"],
                    ["u3,u4","u8"],
                    ["u4,u5","u9"],
                    ["u5,u8","u10"],
                    ["u4,u8","u11"],
                    ["u4,u9","u12"],
                    ["u8,u9","u13"],
                    ["u9,u11","u14"],
                    ["u4,v","d"],
                    ["u3,u5","u15"] ] );
#! <A toric variety of dimension 5>
[ IsComplete( final_space2 ), IsOrbifold( final_space2 ), 
  IsSmooth( final_space2 ) ];
#! [ true, true, false ]
#! @EndExample
