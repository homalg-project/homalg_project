#############################################################################
##
##  ToricDivisorsLI.gi     ToricVarieties       Sebastian Gutsche
##
##  Copyright 2011 Lehrstuhl B für Mathematik, RWTH Aachen
##
##  Logical implications for toric divisors
##
#############################################################################

#############################
##
## True methods
##
#############################

##
## <=
##

##
InstallTrueMethod( IsCartier, IsPrincipal );

##
InstallTrueMethod( IsBasepointFree, IsAmple );

##
InstallTrueMethod( IsNumericallyEffective, IsBasepointFree );