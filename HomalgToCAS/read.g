# SPDX-License-Identifier: GPL-2.0-or-later
# HomalgToCAS: A window to the outer world
#
# Reading the implementation part of the package.
#

## general stuff
ReadPackage( "HomalgToCAS", "gap/HomalgToCAS.gi" );

## pointers on external objects
ReadPackage( "HomalgToCAS", "gap/homalgExternalObject.gi" );

## statistics objects
ReadPackage( "HomalgToCAS", "gap/StatisticsObject.gi" );

## external rings
ReadPackage( "HomalgToCAS", "gap/HomalgExternalRing.gi" );

## IO
ReadPackage( "HomalgToCAS", "gap/IO.gi" );

## external matrices
ReadPackage( "HomalgToCAS", "gap/HomalgExternalMatrix.gi" );

## homalgSendBlocking
ReadPackage( "HomalgToCAS", "gap/homalgSendBlocking.gi" );

if IsBound( MakeThreadLocal ) then
    Perform(
            [
             "HOMALG_IO",
             ],
            MakeThreadLocal );
fi;
