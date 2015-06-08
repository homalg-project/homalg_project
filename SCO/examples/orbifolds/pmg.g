# pmg

# http://en.wikipedia.org/wiki/Wallpaper_group#Group_pmg

M := [ [1,2,4], [1,2,5], [1,4,5], [2,3,6], [2,3,9], [2,4,9], [2,5,6], [3,9,10], [4,5,8], [4,7,8], [4,7,9], [5,6,8], [6,8,10], [7,8,9], [8,9,10] ];
G := Group( (1,2) );
iso := rec( 1 := G, 7 := G, 3 := G, 6 := G, 10 := G );
mu:=[
[ [4], [1,4], [1,2,4], [1,4,5], x -> (1,2) ],
[ [4], [1,4], [1,4,5], [1,2,4], x -> (1,2) ],
[ [4], [4,7], [4,7,8], [4,7,9], x -> (1,2) ],
[ [4], [4,7], [4,7,9], [4,7,8], x -> (1,2) ],
];

dim := 4;

#matrix sizes:
# [ 16, 139, 546, 2321, 11276, 56251 ]
#factors:
# [ 8.6875, 3.92806, 4.25092, 4.85825 ]

# 1: 15 x 134 matrix with rank 14 and kernel dimension 1. Time: 0.000 sec.
# 2: 134 x 583 matrix with rank 117 and kernel dimension 17. Time: 0.004 sec.
# 3: 583 x 2934 matrix with rank 462 and kernel dimension 121. Time: 0.152 sec.
# 4: 2934 x 17126 matrix with rank 2468 and kernel dimension 466. Time: 3.145 sec.
# 5: 17126 x 104729 matrix with rank 14654 and kernel dimension 2472. Time: 114.119 sec.
# 6: 104729 x 658093 matrix with rank 90071 and kernel dimension 14658. Time: 4647.566 sec.
# Cohomology dimension at degree 0:  GF(2)^(1 x 1)
# Cohomology dimension at degree 1:  GF(2)^(1 x 3)
# Cohomology dimension at degree 2:  GF(2)^(1 x 4)
# Cohomology dimension at degree 3:  GF(2)^(1 x 4)
# Cohomology dimension at degree 4:  GF(2)^(1 x 4)
# Cohomology dimension at degree 5:  GF(2)^(1 x 4)

# Z
# 0
#   3
#   1
#   3
#   1

