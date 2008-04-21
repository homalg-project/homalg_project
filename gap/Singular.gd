#############################################################################
##
##  Singular.gd               RingsForHomalg package         Mohamed Barakat
##                                                    Markus Lange-Hegermann
##
##  Copyright 2007-2008 Lehrstuhl B für Mathematik, RWTH Aachen
##
##  Declaration stuff for the external computer algebra system Singular.
##
#############################################################################

#############################################################################
# forbidden expressions inside of Singular
# dummy_variable     to emulate Q
# list l             can be used, but is allready declared in all rings
# matrix S           can be used, but is allready declared in all rings
# matrix U           can be used, but is allready declared in all rings
# matrix V           can be used, but is allready declared in all rings
# string s           can be used, but is allready declared in all rings
# int i              can be used, but is allready declared in all rings
# int j              can be used, but is allready declared in all rings
#############################################################################

####################################
#
# global variables:
#
####################################

DeclareGlobalVariable( "HOMALG_IO_Singular" );

####################################
#
# global functions and operations:
#
####################################

# constructor methods:

DeclareGlobalFunction( "RingForHomalgInSingular" );

DeclareGlobalFunction( "HomalgFieldOfRationalsInSingular" );

# basic operations:

