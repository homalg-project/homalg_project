# SPDX-License-Identifier: GPL-2.0-or-later
# HomalgToCAS: A window to the outer world
#
# Reading the declaration part of the package.
#

## general stuff
ReadPackage( "HomalgToCAS", "gap/HomalgToCAS.gd" );

## pointers on external objects
ReadPackage( "HomalgToCAS", "gap/homalgExternalObject.gd" );

## statistics objects
ReadPackage( "HomalgToCAS", "gap/StatisticsObject.gd" );

## external rings
ReadPackage( "HomalgToCAS", "gap/HomalgExternalRing.gd" );

## external matrices
ReadPackage( "HomalgToCAS", "gap/HomalgExternalMatrix.gd" );

## homalgSendBlocking
ReadPackage( "HomalgToCAS", "gap/homalgSendBlocking.gd" );

## IO
ReadPackage( "HomalgToCAS", "gap/IO.gd" );
