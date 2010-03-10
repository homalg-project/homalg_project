LoadPackage( "RingsForHomalg" );;

R := HomalgFieldOfRationalsInDefaultCAS( ) *  "a,b,c,d,e";;
A := HomalgMatrix( "[\
2*a+c+d+e-2,2*a+c+d+e-2,2*a+c+d+e-2,0,\
2*c*d+d^2+2*c*e+2*d*e-3*e^2-2*c-d-6*e+1,\
2*c*d+d^2+2*c*e+2*d*e-3*e^2-2*c-d-6*e+1,\
2*c*d+d^2+2*c*e+2*d*e-3*e^2-2*c-d-6*e+1,0,\
-4*a+2*b-c-d-e+2,-4*a+2*b-c-d-e+2,\
-c+d+e+2,4*a*d-2*b*d+2*d^2+2*d*e,\
c^2-d-1,c^2-d-1,c^2-d-1,0,\
4*d*e^2-d^2+2*c*e+4*d*e-3*e^2-2*c+3*d-6*e+5,\
4*d*e^2-d^2+2*c*e+4*d*e-3*e^2-2*c+3*d-6*e+5,\
4*d*e^2-d^2+2*c*e+4*d*e-3*e^2-2*c+3*d-6*e+5,0,\
0,b^2+a+c+d+e,0,b^2*e+a*e+c*e+d*e+e^2,\
0,b^2*d+a*d+c*d+d^2+d*e,0,0,\
0,a*b^2+a^2+a*c+a*d+a*e,0,0,\
4*b^3*d-4*d^3-12*d^2*e-32*c*e^2+12*e^3+21*d^2\
-42*c*e+40*d*e+27*e^2+8*c-9*d+16*e-17,\
-4*a*b*d-4*b*c*d-4*b*d^2-4*d^3-4*b*d*e-12*d^2*e-32*c*e^2+\
12*e^3+21*d^2-42*c*e+40*d*e+27*e^2+8*c-9*d+16*e-17,\
-12*d^2*e-32*c*e^2+12*e^3+21*d^2-42*c*e+44*d*e+\
27*e^2+8*c-9*d+16*e-17,-4*b^3+4*d^2+4*e\
]", 9 , 4 , R );;
M := LeftPresentation( A );

LoadPackage( "LocalizeRingForHomalg" );;
R0 := LocalizeAtZero( R );;
M0 := R0 * M;; ByASmallerPresentation( M0 );
filt0 := PurityFiltration( M0 );
Display( filt0 );
FilteredModule := Source( IsomorphismOfFiltration( filt0 ) );;
Display( FilteredModule );

EntriesOfHomalgMatrix( MatrixOfRelations( FilteredModule ) );;
ListToListList( last , 7 , 4 );