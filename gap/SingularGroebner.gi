#############################################################################
##
##  SingularGroebner          RingsForHomalg package          Simon Goertzen
##
##  Copyright 2007-2008 Lehrstuhl B für Mathematik, RWTH Aachen
##
##  Implementations for Grobner Basis calculations in Singular            
##
#############################################################################

####################################
#
# constructor functions and methods:
#
####################################

InstallMethod( CreateHomalgTable,
        "for homalg rings with Groebner Basis calculations provided by Singular",
        [ IsHomalgExternalRingObjectInSingularRep ],
        
  function( arg )
    local RP, RP_default, RP_specific, component;
    
    RP := ShallowCopy( CommonHomalgTableForSingularTools );
    
    RP_default := ShallowCopy( CommonHomalgTableForSingularDefault );
    
    RP_specific := rec(
                       RingName :=
		       R -> "Weyl(t,D)",
		       
		       Involution :=
                       function( M )
                         local R, I;
                         R := HomalgRing( M );
                         I := HomalgVoidMatrix( NrColumns( M ), NrRows( M ), R );
                         homalgSendBlocking( [ "map F = ", R, ", t, -D; matrix ", I, " = transpose( involution( ", M, ", F ) )" ], "need_command", HOMALG_IO.Pictograms.Involution ); #FIXME
                         ResetFilterObj( I, IsVoidMatrix );
                         return I;
                       end,
                                              
                       );
    
    for component in NamesOfComponents( RP_default ) do
        RP.(component) := RP_default.(component);
    od;
    
    for component in NamesOfComponents( RP_specific ) do
        RP.(component) := RP_specific.(component);
    od;
    
    Objectify( TheTypeHomalgTable, RP );
    
    return RP;
    
end );
