#############################################################################
##
##                                                      4ti2Interface package
##
##  Copyright 2013,           Sebastian Gutsche, University of Kaiserslautern
##
#############################################################################

## init
ReadPackage( "4ti2Interface", "gap/4ti2Interface.gd" );

if IsPackageMarkedForLoading( "JuliaInterface", ">= 0.2" ) then
    ReadPackage( "4ti2Interface", "gap/Julia.gd" );
fi;
