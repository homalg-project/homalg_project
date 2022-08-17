# SPDX-License-Identifier: GPL-2.0-or-later
# GaussForHomalg: Gauss functionality for the homalg project
#
# This file tests if the package can be loaded without errors or warnings.
#
# do not load suggested dependencies automatically
gap> PushOptions( rec( OnlyNeeded := true ) );
gap> package_loading_info_level := InfoLevel( InfoPackageLoading );;
gap> SetInfoLevel( InfoPackageLoading, PACKAGE_ERROR );;
gap> LoadPackage( "homalg", false );
true
gap> LoadPackage( "Modules", false );
true
gap> LoadPackage( "GaussForHomalg", false );
true
gap> SetInfoLevel( InfoPackageLoading, PACKAGE_INFO );;
gap> LoadPackage( "homalg" );
true
gap> LoadPackage( "Modules" );
true
gap> LoadPackage( "GaussForHomalg" );
true
gap> SetInfoLevel( InfoPackageLoading, package_loading_info_level );;
