#The PSL2Z Orbifold, \infinity is one vertex with \Z-iso, therefore a S^1 on 1

C2 := Group( [[-1,0],[0,-1]] );
J := Group( [[0,-1],[1,0]] ); #at i
U := Group( [[1,-1],[1,0]] ); #at \rho

mu := [];

M := [ [1,2], [1,3], [2,4], [3,4] ];

iso := rec( 1 := J, 2 := C2, 3 := C2, 4 := U );

dim := 4;

