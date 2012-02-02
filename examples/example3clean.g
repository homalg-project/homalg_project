LoadPackage( "ToricVarieties" );

## Lets have a look at the toric variety that is complete but not projective

rays := [ [1,0,0], [-1,0,0], [0,1,0], [0,-1,0], [0,0,1], [0,0,-1],
          [2,1,1], [1,2,1], [1,1,2], [1,1,1] ];
          
cones := [ [1,3,6], [1,4,6], [1,4,5], [2,3,6], [2,4,6], [2,3,5], [2,4,5],
           [1,5,9], [3,5,8], [1,3,7], [1,7,9], [5,8,9], [3,7,8],
           [7,9,10], [8,9,10], [7,8,10] ];
           
F := Fan( rays, cones );

T := ToricVariety( F );