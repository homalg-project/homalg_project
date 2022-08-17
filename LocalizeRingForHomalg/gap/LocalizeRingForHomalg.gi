# SPDX-License-Identifier: GPL-2.0-or-later
# LocalizeRingForHomalg: A Package for Localization of Polynomial Rings
#
# Implementations
#

##  Implementation stuff for LocalizeRingForHomalg.

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
                local GlobalRing;
                
                GlobalRing := AssociatedGlobalRing( R );
                
                if HasName( R ) then
                    return Name( R );
                fi;
                
                if IsHomalgInternalRingRep( GlobalRing ) then
                  return Concatenation( RingName( GlobalRing ), "_< ", JoinStringsWithSeparator( EntriesOfHomalgMatrix( GeneratorsOfMaximalRightIdeal( R ) ), ", " ), " >" );
                else
                  return Concatenation( RingName( GlobalRing ), "_< ", JoinStringsWithSeparator( List( EntriesOfHomalgMatrix( GeneratorsOfMaximalRightIdeal( R ) ), Name ), ", " ), " >" );
                fi;

            end,
              
         )
);
