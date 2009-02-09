#############################################################################
##
##  LocalRingGroebner.gi    LocalizeRingForHomalg package    Mohamed Barakat
##                                                    Markus Lange-Hegermann
##
##  Copyright 2009, Mohamed Barakat, Universität des Saarlandes
##           Markus Lange-Hegermann, RWTH-Aachen University
##
##  Implementations for Groebner basis related computations of local rings.
##
#############################################################################

####################################
#
# constructor functions and methods:
#
####################################

##
InstallMethod( CreateHomalgTableForLocalizedRings,
        "for polynomial homalg rings with Groebner basis computations",
        [ IsHomalgExternalRingRep and IsFreePolynomialRing ],
        
  function( globalR )
    local globalRP, RP, RP_General, RP_Basic, RP_BestBasis, RP_specific, component;
    
    globalRP := homalgTable( globalR );
    
    RP := rec (
                  Zero := globalRP!.Zero,
                  
                  One := globalRP!.One,
                  
                  MinusOne := globalRP!.MinusOne,

                  IsZero := function(a)
                    return IsZero(NumeratorOfLocalElement(a));
                  end,

                  IsOne := function(a)
                    return IsZero(NumeratorOfLocalElement(a)-DenominatorOfLocalElement(a));
                  end,

                  Minus := function(a,b)
                    return HomalgLocalRingElement(
                      NumeratorOfLocalElement(a)*DenominatorOfLocalElement(b)-NumeratorOfLocalElement(b)*DenominatorOfLocalElement(a),
                      DenominatorOfLocalElement(a)*DenominatorOfLocalElement(b),
                      HomalgRing(a));
                  end,

                  DivideByUnit :=function( a, u )
                    return HomalgLocalRingElement(
                      NumeratorOfLocalElement(a),
                      DenominatorOfLocalElement(a)*u,
                      HomalgRing(a));
                  end,

                  #IsUnit CAS-dependent

                  Sum := function(a,b)
                    return HomalgLocalRingElement(
                      NumeratorOfLocalElement(a)*DenominatorOfLocalElement(b)+NumeratorOfLocalElement(b)*DenominatorOfLocalElement(a),
                      DenominatorOfLocalElement(a)*DenominatorOfLocalElement(b),
                      HomalgRing(a));
                  end,

                  Product := function(a,b)
                    return HomalgLocalRingElement(
                      NumeratorOfLocalElement(a)*NumeratorOfLocalElement(b),
                      DenominatorOfLocalElement(a)*DenominatorOfLocalElement(b),
                      HomalgRing(a));
                  end
                  
                  
                  
               );
    
    Objectify( TheTypeHomalgTable, RP );
    
    return RP;
    
    ## rest
    
    RP := ShallowCopy( CommonHomalgTableForLocalizedRingsTools );
    
    RP_General := ShallowCopy( CommonHomalgTableForLocalizedRings );
    
    RP_Basic := ShallowCopy( CommonHomalgTableForLocalizedRingsBasic );
    
    RP_specific := rec( );
    
    for component in NamesOfComponents( RP_General ) do
        RP.(component) := RP_General.(component);
    od;
    
    for component in NamesOfComponents( RP_Basic ) do
        RP.(component) := RP_Basic.(component);
    od;
    
    for component in NamesOfComponents( RP_specific ) do
        RP.(component) := RP_specific.(component);
    od;
    
end );

