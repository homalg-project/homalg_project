# SPDX-License-Identifier: GPL-2.0-or-later
# homalg: A homological algebra meta-package for computable Abelian categories
#
# This file tests if the package can be loaded without errors or warnings.
#
# do not load suggested dependencies automatically
gap> PushOptions( rec( OnlyNeeded := true ) );
gap> package_loading_info_level := InfoLevel( InfoPackageLoading );;
gap> SetInfoLevel( InfoPackageLoading, PACKAGE_ERROR );;
gap> LoadPackage( "MatricesForHomalg", false );
true
gap> LoadPackage( "Modules", false );
true
gap> LoadPackage( "homalg", false );
true
gap> SetInfoLevel( InfoPackageLoading, PACKAGE_INFO );;
gap> LoadPackage( "MatricesForHomalg" );
true
gap> LoadPackage( "Modules" );
true
gap> LoadPackage( "homalg" );
true
gap> SetInfoLevel( InfoPackageLoading, package_loading_info_level );;
