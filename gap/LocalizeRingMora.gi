#############################################################################
##
##  LocalizeRingMora.gi                        LocalizeRingForHomalg package
##
##  Copyright 2009-2011, Mohamed Barakat, University of Kaiserslautern
##                       Markus Lange-Hegermann, RWTH-Aachen University
##
##  Implementations for Mora basis related computations of local rings.
##
#############################################################################

####################################
#
# methods for operations:
#
####################################

##
InstallMethod( AffineDegree,
        "for matrices over homalg local rings",
        [ IsHomalgLocalMatrixRep ],
        
  function( mat )
    
    return AffineDegree( Numerator( mat ) );
    
end );

##
InstallMethod( ConstantTermOfHilbertPolynomial,
        "for matrices over homalg local rings",
        [ IsHomalgLocalMatrixRep ],
        
  function( mat )
    
    return ConstantTermOfHilbertPolynomial( Numerator( mat ) );
    
end );

##  <#GAPDoc Label="LocalizePolynomialRingAtZeroWithMora">
##  <ManSection>
##    <Oper Arg="R" Name="LocalizePolynomialRingAtZeroWithMora" Label= "constructor for homalg localized rings using Mora's algorithm"/>
##    <Returns>a local ring</Returns>
##    <Description>
##      This method localizes the ring <A>R</A> at zero and this localized ring is returned. The ring table uses Mora's algorithm as implemented &Singular; for low level computations.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
InstallMethod( LocalizePolynomialRingAtZeroWithMora,
        "for homalg rings",
        [ IsHomalgRing and IsFreePolynomialRing ],
  function( R )
    local var, Rloc, S, v, RP, c, n_gens, gens;
    
    ## the following call will invoke RingsForHomalg
    RP := CreateHomalgTableForLocalizedRingsWithMora( R );
    Rloc := _LocalizePolynomialRingAtZeroWithMora( R );
    Rloc!.asserts.BasisOfRowsCoeff := function( arg ) return true; end;
    Rloc!.asserts.BasisOfColumnsCoeff := function( arg ) return true; end;
    Rloc!.asserts.DecideZeroRowsEffectively := function( arg ) return true; end;
    Rloc!.asserts.DecideZeroColumnsEffectively := function( arg ) return true; end;
    var := IndeterminatesOfPolynomialRing( R );
    
    S := CreateHomalgRing( Rloc, [ TheTypeHomalgLocalRing, TheTypeHomalgLocalMatrix ], HomalgLocalRingElement, RP );
    ## for the view methods:
    ## <A local (Mora) ring>
    ## <A matrix over a local (Mora) ring>
    S!.description := " local (Mora)";
    S!.AssociatedGlobalRing := R;
    S!.AssociatedComputationRing := Rloc;
    SetIsLocalRing( S, true );
    
    n_gens := Length( var );
    gens := Rloc * HomalgMatrix( var, n_gens, 1, R );
    SetGeneratorsOfMaximalLeftIdeal( S, gens );
    gens := Rloc * HomalgMatrix( var, 1, n_gens, R );
    SetGeneratorsOfMaximalRightIdeal( S, gens );
    
    SetRingProperties( S );
    
    return S;
    
end );

##
InstallMethod( CreateHomalgTableForLocalizedRingsWithMora,
        "for Singular rings",
        [ IsHomalgRing and IsCommutative and IsFreePolynomialRing ],
        
  function( globalR )
    local globalRP, RP;
    
    if LoadPackage( "RingsForHomalg" ) <> true then
        Error( "the package RingsForHomalg failed to load\n" );
    fi;
    
    if not ValueGlobal( "IsHomalgExternalRingInSingularRep" )( globalR ) then
        TryNextMethod( );
    fi;
    
    globalRP := homalgTable( globalR );
    
    RP := rec(
              Zero := globalRP!.Zero,
              
              One := globalRP!.One,
              
              MinusOne := globalRP!.MinusOne,
              );
    
    ## RP_General
    AppendToAhomalgTable( RP, CommonHomalgTableForLocalizedRings );
    
    ## RP_Basic
    AppendToAhomalgTable( RP, CommonHomalgTableForLocalizedRingsBasic );
    
    ## RP_Tools
    AppendToAhomalgTable( RP, CommonHomalgTableForLocalizedRingsTools );
    
    ## RP_Mora
    AppendToAhomalgTable( RP, CommonHomalgTableForSingularToolsMoraPreRing );
    
    ## Objectify
    Objectify( TheTypeHomalgTable, RP );
    
    return RP;
    
end );
