#############################################################################
##
##  LocalizeRingForHomalg.gi                   LocalizeRingForHomalg package  
##
##  Copyright 2013, Mohamed Barakat, University of Kaiserslautern
##                  Markus Lange-Hegermann, RWTH-Aachen University
##                  Vinay Wagh, Indian Institute of Technology Guwahati
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

##
InstallValue( CommonHomalgTableForLocalizedRingsAtPrimeIdeals,
        rec(
            RingName :=
              function( R )
                local globalR, baseR;
                
                globalR:= AssociatedGlobalRing( R );
                baseR:= BaseRing( globalR );
                
                if HasName( R ) then
                    return Name( R );
                fi;
                
                if IsHomalgInternalRingRep( globalR ) then
                  return Concatenation( "( ", RingName( baseR ), "_< ", JoinStringsWithSeparator( EntriesOfHomalgMatrix( GeneratorsOfPrimeIdeal( R ) ), ", " ), " > )", String( Indeterminates( R ) ) );
                else
                  return Concatenation( "( ", RingName( baseR ), "_< ", JoinStringsWithSeparator( List( EntriesOfHomalgMatrix( GeneratorsOfPrimeIdeal( R ) ), Name ), ", " ), " > )", String( Indeterminates( R ) ) );
                fi;
                
            end,
            
         )
);
