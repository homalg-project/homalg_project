# S1 with C2-iso and a point of S3-iso

M := [ [1,2], [1,3], [2,3] ];
G := Group( (1,2) );
S3 := Group( (1,2), (1,2,3) );
iso := rec( 1 := S3, 2 := G, 3 := G );
mu := [];
dim := 5;

