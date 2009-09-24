#############################################################################
##
##  LocalizeRingForHomalg.gd  LocalizeRingForHomalg package  Mohamed Barakat
##                                                    Markus Lange-Hegermann
##
##  Copyright 2009, Mohamed Barakat, Universität des Saarlandes
##           Markus Lange-Hegermann, RWTH-Aachen University
##
##  Implementation stuff for LocalizeRingForHomalg.
##
#############################################################################

####################################
#
# global variables:
#
####################################

# a central place for configuration variables:

##
InstallValue( HOMALG_LOCALIZE_RING,
        rec(
           )
);

##
InstallValue( CommonHomalgTableForLocalizedRings,
        rec(
            RingName :=
              function( R )
                local r, var, local_var;
                
                if HasName( R ) then
                    return Name( R );
                fi;
                
                return Concatenation( RingName( AssociatedGlobalRing( R ) ), "_<", JoinStringsWithSeparator( List( EntriesOfHomalgMatrix( GeneratorsOfMaximalRightIdeal( R ) ), Name ) ), ">" );
                

            end,
              
         )
);

####################################
#
# constructor functions and methods:
#
####################################

