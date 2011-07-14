LoadPackage( "GradedModules" );

Qxyz := GradedRing( HomalgFieldOfRationalsInDefaultCAS( ) * "x,y,z" );

vmat := HomalgMatrix( "[ \
x,z,0,1, 0,  \
0,0,y,-z,0,  \
0,0,x,0, -z, \
0,0,0,x, -y  \
]", 4, 5, Qxyz );

V := LeftPresentation( vmat );

wmat := HomalgMatrix( "[ \
x,z,1,0, 0,  \
0,0,y,-z,0,  \
0,0,x,0, -z, \
0,0,0,x, -y  \
]", 4, 5, Qxyz );

W := LeftPresentation( wmat );

mmat := HomalgMatrix( "[ \
x,z,z,y, x,  \
0,0,-y,z,0,  \
0,0,x,0, -z, \
0,0,0,x, -y  \
]", 4, 5, Qxyz );

M := LeftPresentationWithDegrees( mmat );

nmat := HomalgMatrix( "[ \
x,z,z,0, x,  \
0,0,-y,z,0,  \
0,0,x,0, -z, \
0,0,0,x, -y  \
]", 4, 5, Qxyz );

N := LeftPresentationWithDegrees( nmat );

lmat := HomalgMatrix( "[ \
x,z,0,0, \
0,x,z,0, \
0,y,0,z, \
0,0,y,-x \
]", 4, 4, Qxyz );

L := LeftPresentationWithDegrees( lmat );
