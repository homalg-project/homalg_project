# S1 with C2-Isotropy and a point of S3-Isotropy

M := [ [1,2], [1,3], [2,3] ];
G := Group( (1,2) );
S3 := Group( (1,2), (1,2,3) );
Isotropy := rec( 1 := S3, 2 := G, 3 := G );
mult := [];
dim := 5;

