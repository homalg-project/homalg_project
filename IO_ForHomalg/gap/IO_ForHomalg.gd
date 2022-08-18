# SPDX-License-Identifier: GPL-2.0-or-later
# IO_ForHomalg: IO capabilities for the homalg project
#
# Declarations
#

##  Declaration stuff to use the GAP4 I/O package of Max Neunhoeffer.

# our info class:
DeclareInfoClass( "InfoIO_ForHomalg" );
SetInfoLevel( InfoIO_ForHomalg, 1 );

####################################
#
# global functions and operations:
#
####################################

DeclareGlobalFunction( "SendForkingToCAS" );

DeclareGlobalFunction( "SendToCAS" );

DeclareGlobalFunction( "CheckOutputOfCAS" );

DeclareGlobalFunction( "SendBlockingToCAS" );

DeclareGlobalFunction( "TryLaunchCAS_IO_ForHomalg" );

#! @ChapterInfo Tools, Functions
#! @Arguments function, args
#! @Returns list
#! @Description
#!   Returns real time seconds of the call function( args ) as first entry of list, result of call as second.
DeclareGlobalFunction( "TOOLS_FOR_HOMALG_GET_REAL_TIME_OF_FUNCTION_CALL" );
