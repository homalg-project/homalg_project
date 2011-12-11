#############################################################################
##
##  CombinatoricalObject.gd               ConvexForHomalg package       Sebastian Gutsche
##
##  Copyright 2011-2012 Lehrstuhl B für Mathematik, RWTH Aachen
##
##  The Main Object to be viewed, is almost everything that has a number ;).
##
#############################################################################


DeclareCategory( "IsCombinatoricalObject" );


################################
##
## Basics
##
################################


DeclareAttribute( "WeakPointerToExternalObject",
        IsCombinatoricalObject );