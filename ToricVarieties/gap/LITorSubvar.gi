#############################################################################
##
##  LITorSubvar.gi     ToricVarieties       Sebastian Gutsche
##
##  Copyright 2011- 2016, Sebastian Gutsche, TU Kaiserslautern
##                        Martin Bies,       ITP Heidelberg
##
##  Logical implications for toric subvarieties.
##
#############################################################################

#############################
##
## True methods
##
#############################

##
InstallTrueMethod( IsWholeVariety, IsOpen and IsClosedSubvariety );

##
InstallTrueMethod( IsOpen, IsWholeVariety );

##
InstallTrueMethod( IsClosedSubvariety, IsWholeVariety );
