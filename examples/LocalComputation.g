LoadPackage( "RingsForHomalg" );

homalgIOMode("all");

S := HomalgFieldOfRationalsInSingular() * "a,b,c,d,e,f";
R0 := LocalizeePolynomialRingAtZero( S );

R1:=RingForHomalgInMapleUsingInvolutiveLocalBasisfreeGINV("[a,b,c,d,e,f]");

R0!.ByASmallerPresentation:=true;
R1!.ByASmallerPresentation:=true;

A0:=HomalgMatrix("[\
a+b, c+d, e+f,\
-b, -c-d+b, c^2+c-e-f,\
f^3+f^2+f+1, 0, 0,\
b*d*f, -f*b*e+d*c*f+f*d^2, -f^2*c+f*e*d+f^2*d,\
b*d*e, e*d^2+d*e*c-b*e^2, -f*e*c+e^2*d+f*e*d,\
d^2*b, d^2*c-b*d*e+d^3, -d*c*f+e*d^2+f*d^2,\
c*b*d-f*b, f*b+d^2*c-d*f-c*f+d*c^2-e*b*c, d*e*c+d*c*f+c*f-f*e-f^2,\
0, -b^2*e+c*d*a-b*e*a+d^2*a, -b*c*f+d*f*a-c*f*a+d*e*a,\
b^2*d, -b^2*e+d^2*b+c*b*d, -b*c*f+b*d*f+b*d*e,\
0,f^3*c+f^3*d+f^2*c+f^2*d+c*f+d*f+c+d, f^3*e+f^4+f^2*e+f^3+f*e+f^2+e+f,\
b*d, f^3*b*e+f^2*b*e+f*b*e+c*d+d^2, f^4*c+f^3*c+f^2*c+d*f+d*e,\
0, f*b+f^2*b+f^4*b+f^3*b, f^3*b*e^2-d*f^4*c+e*f^4*b+f^2*b*e^2-f^3*c*d+f^3*b*e+f^4*c+f*b*e^2-d*f^2*c+f^2*b*e+f^3*c+b*e^2-d*c*f+f*b*e+f^2*c+c*f\
]",12,3,R0);

A1:=HomalgMatrix("[\
a-1+b, c+d, e+f,\
-b, -c-d+b, c^2+c-e-f,\
f^3+f^2+f+1, 0, 0,\
b*d*f, -f*b*e+d*c*f+f*d^2, -f^2*c+f*e*d+f^2*d,\
b*d*e, e*d^2+d*e*c-b*e^2, -f*e*c+e^2*d+f*e*d,\
d^2*b, d^2*c-b*d*e+d^3, -d*c*f+e*d^2+f*d^2,\
c*b*d-f*b, f*b+d^2*c-d*f-c*f+d*c^2-e*b*c, d*e*c+d*c*f+c*f-f*e-f^2,\
0, -b^2*e+c*d*a-c*d-b*e*a-b*e+d^2*a-d^2, -b*c*f+d*f*a-d*f-c*f*a-c*f+d*e*a-d*e,\
b^2*d, -b^2*e+d^2*b+c*b*d, -b*c*f+b*d*f+b*d*e,\
0, f^3*c+f^3*d+f^2*c+f^2*d+c*f+d*f+c+d, f^3*e+f^4+f^2*e+f^3+f*e+f^2+e+f,\
b*d, f^3*b*e+f^2*b*e+f*b*e+c*d+d^2, f^4*c+f^3*c+f^2*c+d*f+d*e,\
0,f*b+f^2*b+f^4*b+f^3*b,f^3*b*e^2-d*f^4*c+e*f^4*b+f^2*b*e^2-f^3*c*d+f^3*b*e+f^4*c+f*b*e^2-d*f^2*c+f^2*b*e+f^3*c+b*e^2-d*c*f+f*b*e+f^2*c+c*f\
]",12,3,R1);

M0:=LeftPresentation(A0);

OnLessGenerators(M0);

P0:=PurityFiltration(M0);

M1:=LeftPresentation(A1);

OnLessGenerators(M1);

P1:=PurityFiltration(M1);
