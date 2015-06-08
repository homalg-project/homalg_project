LoadPackage( "GradedRingForHomalg" );

S := GradedRing( HomalgFieldOfRationalsInDefaultCAS( ) * "x,y,z,t" );

hmat := HomalgMatrix( "[ \
z,  0,    0,          0,           0,  0,          \
y,  0,    0,          0,           0,  0,          \
x,  0,    0,          0,           0,  0,          \
0,  y*z,  z*t,        0,           x*y,0,          \
0,  0,    x*y,        -y^2,        0,  x^2-t^2,    \
0,  0,    x^2*z,      -x*y*z,      0,  y*z*t,      \
0,  0,    x^2*y-x^2*t,-x*y^2+x*y*t,0,  y^2*t-y*t^2,\
t^3,x^2*z,0,          x*z*t,       x^3,-z*t^2      \
]", 8, 6, S );

LoadPackage( "GradedModules" );

H := LeftPresentationWithDegrees( hmat );

SetAsOriginalPresentation( H );

FilteredByPurity( H );

Display( H );

Assert( 0, DegreesOfGenerators( H ) = [ 0, 0, 0, 0, 0, 1, 2, 2, 0 ] );
