LoadPackage( "GradedRingForHomalg" );

Qxy := HomalgFieldOfRationalsInDefaultCAS( ) * "x,y";
S := GradedRing( Qxy );

wmat := HomalgMatrix( "[ \
x, -y\
]", 1, 2, Qxy );

LoadPackage( "GradedModules" );

wmor := GradedMap( wmat, "free", [1,1], "left", S );
W := Cokernel( wmor );

W2 := UnderlyingObject(SubmoduleGeneratedByHomogeneousPart(2,S^0));
W3 := UnderlyingObject(SubmoduleGeneratedByHomogeneousPart(3,S^0));

W_neg := UnderlyingObject(SubmoduleGeneratedByHomogeneousPart(-2,S^4));
