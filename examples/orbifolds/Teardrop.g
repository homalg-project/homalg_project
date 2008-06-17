#The Teardrop orbifold

M := [ [1,2,3], [1,2,4], [1,3,4], [2,3,5], [2,4,5], [3,4,5] ];
G := Group( (1,2) );
Isotropy := rec( 1 := G );
mult := [
[ [3], [1,3], [1,2,3], [1,3,4], x -> (1,2) ],
[ [3], [1,3], [1,3,4], [1,2,3], x -> (1,2) ]
];

dim := 5;

#C:[ 0 ], [ 1 ], [ 0 ], [ 1 ], [ 2 ]
#H:[ 0 ], [ 1 ], [ 0 ], [ 2 ], [ 1 ]

#  1: 6 x 27 matrix with rank 5 and kernel dimension 1.
#  2: 27 x 88 matrix with rank 22 and kernel dimension 5.
#  3: 88 x 378 matrix with rank 65 and kernel dimension 23.
#  4: 378 x 1875 matrix with rank 312 and kernel dimension 66.
#  5: 1875 x 9375 matrix with rank 1562 and kernel dimension 313.
#  6: 9375 x 46875 matrix with rank 7812 and kernel dimension 1563.
#  7: 46875 x 234375 matrix with rank 39062 and kernel dimension 7813.
#  8: 234375 x 1171875 matrix with rank 195312 and kernel dimension 39063.
#  Cohomology dimension at degree 0:  GF(2)^(1 x 1)
#  Cohomology dimension at degree 1:  GF(2)^(1 x 0)
#  Cohomology dimension at degree 2:  GF(2)^(1 x 1)
#  Cohomology dimension at degree 3:  GF(2)^(1 x 1)
#  Cohomology dimension at degree 4:  GF(2)^(1 x 1)
#  Cohomology dimension at degree 5:  GF(2)^(1 x 1)
#  Cohomology dimension at degree 6:  GF(2)^(1 x 1)
#  Cohomology dimension at degree 7:  GF(2)^(1 x 1)
