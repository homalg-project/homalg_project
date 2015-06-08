LoadPackage( "RingsForHomalg" );

LoadPackage( "Modules" );

Qxyz := HomalgFieldOfRationalsInDefaultCAS( ) * "x,y,z";

matx := HomalgMatrix( "[ x ]", 1, 1, Qxyz );

Wx := LeftPresentation( matx );

matxy := HomalgMatrix( "[ x, y ]", 1, 2, Qxyz );

Wxy := LeftPresentation( matxy );

matxyz := HomalgMatrix( "[ x, y, z ]", 1, 3, Qxyz );

Wxyz := LeftPresentation( matxyz );

