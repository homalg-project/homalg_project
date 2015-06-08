LoadPackage( "RingsForHomalg" );

R := HomalgFieldOfRationalsInDefaultCAS( ) * "z0..7";

M := HomalgMatrix( "[ \
z0 + z1 + z2 + z3 + z4 + z5 + z6 + z7, \
z0*z1 + z1*z2 + z2*z3 + z3*z4 + z4*z5 + z5*z6 + z6*z7 + z7*z0, \
z0*z1*z2 + z1*z2*z3 + z2*z3*z4 + z3*z4*z5 + z4*z5*z6 + z5*z6*z7 \
 + z6*z7*z0 + z7*z0*z1, \
z0*z1*z2*z3 + z1*z2*z3*z4 + z2*z3*z4*z5 + z3*z4*z5*z6 + z4*z5*z6*z7 \
 + z5*z6*z7*z0 + z6*z7*z0*z1 + z7*z0*z1*z2, \
z0*z1*z2*z3*z4 + z1*z2*z3*z4*z5 + z2*z3*z4*z5*z6 + z3*z4*z5*z6*z7 \
 + z4*z5*z6*z7*z0 + z5*z6*z7*z0*z1 + z6*z7*z0*z1*z2 + z7*z0*z1*z2*z3, \
z0*z1*z2*z3*z4*z5 + z1*z2*z3*z4*z5*z6 + z2*z3*z4*z5*z6*z7 + z3*z4*z5*z6*z7*z0 \
 + z4*z5*z6*z7*z0*z1 + z5*z6*z7*z0*z1*z2 + z6*z7*z0*z1*z2*z3 + z7*z0*z1*z2*z3*z4, \
z0*z1*z2*z3*z4*z5*z6 + z1*z2*z3*z4*z5*z6*z7 + z2*z3*z4*z5*z6*z7*z0 \
 + z3*z4*z5*z6*z7*z0*z1 + z4*z5*z6*z7*z0*z1*z2 + z5*z6*z7*z0*z1*z2*z3 \
 + z6*z7*z0*z1*z2*z3*z4 + z7*z0*z1*z2*z3*z4*z5, \
z0*z1*z2*z3*z4*z5*z6*z7 - 1 \
]", 8, 1, R );

LoadPackage( "Modules" );

M := LeftPresentation( M );
