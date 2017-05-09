#############################################################################
##
##  ResidueClassRingForHomalg.gi  MatricesForHomalg package  Mohamed Barakat
##
##  Copyright 2007-2009 Mohamed Barakat, Universität des Saarlandes
##
##  Implementation stuff for homalg residue class rings.
##
#############################################################################

####################################
#
# global variables:
#
####################################

# a central place for configuration variables:

##
InstallValue( HOMALG_RESIDUE_CLASS_RING,
        rec(
           )
);

##
InstallValue( CommonHomalgTableForResidueClassRings,
        rec(
            RingName :=
              function( R )
                local ring_rel, entries, name;
                
                ring_rel := MatrixOfRelations( R );
                
                if IsBound( ring_rel!.BasisOfRowModule ) then
                    ring_rel := ring_rel!.BasisOfRowModule;
                elif IsBound( ring_rel!.BasisOfColumnModule ) then
                    ring_rel := ring_rel!.BasisOfColumnModule;
                fi;
                
                if not IsBound( ring_rel!.StringOfEntriesForRingName ) then
                    
                    entries := EntriesOfHomalgMatrix( ring_rel );
                    
                    if entries = [ ] then
                        entries := "0";
                    elif IsHomalgInternalRingRep( AmbientRing( R ) ) then
                        entries := JoinStringsWithSeparator( List( entries, String ), ", " );
                    else
                        entries := JoinStringsWithSeparator( List( entries, Name ), ", " );
                    fi;
                    
                    name := RingName( AmbientRing( R ) );
                    
                    ring_rel!.StringOfEntries := String( Concatenation( "[ ", entries, " ]" ) );
                    ring_rel!.StringOfEntriesForRingName := String( Concatenation( name, "/( ", entries, " )" ) );
                    
                fi;
                
                return ring_rel!.StringOfEntriesForRingName;
                
            end,
              
         )
);

