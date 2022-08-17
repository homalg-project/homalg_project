# SPDX-License-Identifier: GPL-2.0-or-later
# 4ti2Interface: A link to 4ti2
#
# Reading the declaration part of the package.
#

## init
ReadPackage( "4ti2Interface", "gap/4ti2Interface.gd" );

if IsPackageMarkedForLoading( "JuliaInterface", ">= 0.2" ) then
    ReadPackage( "4ti2Interface", "gap/Julia.gd" );
fi;
