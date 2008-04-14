LoadPackage( "SCO" );
HOMALG_IO.color_display := true;
SetInfoLevel( InfoLIMAT, 2 );
SetInfoLevel( InfoCOLEM, 2 );
SetInfoLevel( InfoHomalgOperations, 3 );

if not IsBound(orbifold) then orbifold:="C2.g"; fi;
Read(Concatenation("../examples/",orbifold));
