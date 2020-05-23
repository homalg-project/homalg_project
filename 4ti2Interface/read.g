#############################################################################
##
##                                                      4ti2Interface package
##
##  Copyright 2013,           Sebastian Gutsche, University of Kaiserslautern
##
#############################################################################

## read
ReadPackage( "4ti2Interface", "gap/4ti2Interface.gi" );

if IsPackageMarkedForLoading( "JuliaInterface", ">= 0.2" ) then
    ReadPackage( "4ti2Interface", "gap/Julia.gi" );
fi;
