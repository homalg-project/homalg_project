#############################################################################
##
##  Sheaves.gi                  Sheaves package              Mohamed Barakat
##
##  Copyright 2008-2009, Mohamed Barakat, Universität des Saarlandes
##
##  Implementation stuff for Sheaves.
##
#############################################################################

# a new representation for the GAP-category IsHomalgSheafOfRings

##  <#GAPDoc Label="IsSheafOfRingsRep">
##  <ManSection>
##    <Filt Type="Representation" Arg="M" Name="IsSheafOfRingsRep"/>
##    <Returns>true or false</Returns>
##    <Description>
##      The &GAP; representation of &homalg; sheaves of rings. <P/>
##      (It is a representation of the &GAP; category <Ref Filt="IsHomalgSheafOfRings"/>,
##       which is a subrepresentation of the &GAP; representation
##      <C>IsHomalgRingOrFinitelyPresentedModuleRep</C>.)
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareRepresentation( "IsSheafOfRingsRep",
        IsHomalgSheafOfRings and
        IsHomalgRingOrFinitelyPresentedModuleRep,
        [ "graded_ring" ] );

# a new representation for the GAP-category IsSetOfUnderlyingModules:
DeclareRepresentation( "IsSetOfUnderlyingModulesRep",
        IsSetOfUnderlyingModules,
        [ "ListOfPositionsOfKnownUnderlyingModules" ] );

# a new representation for the GAP-category IsHomalgSheaf

##  <#GAPDoc Label="IsCoherentSheafRep">
##  <ManSection>
##    <Filt Type="Representation" Arg="M" Name="IsCoherentSheafRep"/>
##    <Returns>true or false</Returns>
##    <Description>
##      The &GAP; representation of coherent &homalg; sheaves. <P/>
##      (It is a representation of the &GAP; category <Ref Filt="IsHomalgSheaf"/>,
##       which is a subrepresentation of the &GAP; representation
##      <C>IsFinitelyPresentedObjectRep</C>.)
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareRepresentation( "IsCoherentSheafRep",
        IsHomalgSheaf and
        IsFinitelyPresentedObjectRep,
        [ "UnderlyingModules",
          "PositionOfTheDefaultUnderlyingModule" ] );

####################################
#
# families and types:
#
####################################

# a new family:
BindGlobal( "TheFamilyOfSheavesOfRings",
        NewFamily( "TheFamilyOfSheavesOfRings" ) );

# a new type:
BindGlobal( "TheTypeSheafOfRings",
        NewType( TheFamilyOfSheavesOfRings,
                IsSheafOfRingsRep ) );

# a new family:
BindGlobal( "TheFamilyOfSetsOfUnderlyingModules",
        NewFamily( "TheFamilyOfSetsOfUnderlyingModules" ) );

# a new type:
BindGlobal( "TheTypeSetsOfSetsOfUnderlyingModules",
        NewType( TheFamilyOfSetsOfUnderlyingModules,
                IsSetOfUnderlyingModulesRep ) );

# a new family:
BindGlobal( "TheFamilyOfHomalgSheaves",
        NewFamily( "TheFamilyOfHomalgSheaves" ) );

# two new types:
BindGlobal( "TheTypeHomalgLeftCoherentSheaf",
        NewType( TheFamilyOfHomalgSheaves,
                IsCoherentSheafRep and IsHomalgLeftObjectOrMorphismOfLeftObjects ) );

BindGlobal( "TheTypeHomalgRightCoherentSheaf",
        NewType( TheFamilyOfHomalgSheaves,
                IsCoherentSheafRep and IsHomalgRightObjectOrMorphismOfRightObjects ) );

####################################
#
# global variables:
#
####################################

HOMALG_IO.Pictograms.MonomialMatrix := "mon";	## create the i-th monomial matrix

####################################
#
# methods for operations:
#
####################################

##
InstallMethod( StructureSheafOfAmbientSpace,
        "for sheaves",
        [ IsHomalgSheaf and IsHomalgLeftObjectOrMorphismOfLeftObjects ],
        
  function( E )
    
    return LeftActingDomain( E );
    
end );

##
InstallMethod( StructureSheafOfAmbientSpace,
        "for sheaves",
        [ IsHomalgSheaf and IsHomalgRightObjectOrMorphismOfRightObjects ],
        
  function( E )
    
    return RightActingDomain( E );
    
end );

##
InstallMethod( DimensionOfAmbientSpace,
        "for sheaves of rings",
        [ IsHomalgSheaf ],
        
  function( E )
    
    return Dimension( StructureSheafOfAmbientSpace( E ) );
    
end );

##
InstallMethod( HomalgRing,
        "for sheaves of rings",
        [ IsHomalgSheafOfRings ],
        
  function( O )
    
    if IsBound(O!.graded_ring) then
        return O!.graded_ring;
    fi;
    
    return fail;
    
end );

##
InstallMethod( HomalgRing,
        "for sheaves",
        [ IsHomalgSheaf ],
        
  function( E )
    
    return HomalgRing( StructureSheafOfAmbientSpace( E ) );
    
end );

##
InstallMethod( PositionOfTheDefaultUnderlyingModule,
        "for homalg modules",
        [ IsHomalgSheaf ],
        
  function( E )
    
    if IsBound(E!.PositionOfTheDefaultUnderlyingModule) then
        return E!.PositionOfTheDefaultUnderlyingModule;
    fi;
    
    return fail;
    
end );

##
InstallMethod( SetPositionOfTheDefaultUnderlyingModule,
        "for homalg modules",
        [ IsHomalgSheaf, IsPosInt ],
        
  function( E, pos )
    
    E!.PositionOfTheDefaultUnderlyingModule := pos;
    
end );

##
InstallMethod( SetOfUnderlyingModules,
        "for homalg modules",
        [ IsHomalgSheaf ],
        
  function( E )
    
    if IsBound(E!.SetOfUnderlyingModules) then
        return E!.SetOfUnderlyingModules;
    fi;
    
    return fail;
    
end );

##
InstallMethod( UnderlyingModule,
        "for homalg modules",
        [ IsHomalgSheaf ],
        
  function( E )
    
    if IsBound(SetOfUnderlyingModules(E)!.(PositionOfTheDefaultUnderlyingModule( E ))) then;
        return SetOfUnderlyingModules(E)!.(PositionOfTheDefaultUnderlyingModule( E ));
    fi;
    
    return fail;
    
end );

##
InstallMethod( UnderlyingModule,
        "for homalg modules",
        [ IsHomalgSheaf, IsPosInt ],
        
  function( E, pos )
    
    if IsBound(SetOfUnderlyingModules(E)!.(pos)) then;
        return SetOfUnderlyingModules(E)!.(pos);
    fi;
    
    return fail;
    
end );

####################################
#
# constructor functions and methods:
#
####################################

##
InstallMethod( StructureSheafOfProj,
        "for sheaves",
        [ IsHomalgRing and IsFreePolynomialRing ],
        
  function( S )
    local O;
    
    O := rec( graded_ring := S );
    
    ObjectifyWithAttributes(
            O, TheTypeSheafOfRings,
            Dimension, Length( Indeterminates( S ) ) - 1
            );
    
    return O;
    
end );

##
InstallMethod( CreateSetOfUnderlyingModulesOfSheaf,
        "constructor",
        [ IsHomalgModule ],
        
  function( M )
    local set;
    
    set := rec(
               ListOfPositionsOfKnownUnderlyingModules := [ 1 ],
               1 := M
               );
    
    Objectify( TheTypeSetsOfSetsOfUnderlyingModules, set );
    
    return set;
    
end );

##
InstallMethod( HomalgSheaf,
        "constructor",
        [ IsHomalgModule ],
        
  function( M )
    local S, O, E;
    
    S := HomalgRing( M );
    
    O := StructureSheafOfProj( S );
    
    E := rec(
             SetOfUnderlyingModules := CreateSetOfUnderlyingModulesOfSheaf( M ),
             PositionOfTheDefaultUnderlyingModule := 1
             );
    
    if IsHomalgLeftObjectOrMorphismOfLeftObjects( M ) then
        
        ObjectifyWithAttributes(
                E, TheTypeHomalgLeftCoherentSheaf,
                LeftActingDomain, O );
        
    else
        
        ObjectifyWithAttributes(
                E, TheTypeHomalgRightCoherentSheaf,
                RightActingDomain, O );
        
    fi;
    
    return E;
    
end );

##
InstallMethod( LeftSheaf,
        "constructor",
        [ IsHomalgMatrix, IsList ],
        
  function( mat, weights )
    local M;
    
    M := LeftPresentationWithDegrees( mat, weights );
    
    return HomalgSheaf( M );
    
end );

##
InstallMethod( LeftSheaf,
        "constructor",
        [ IsHomalgMatrix, IsInt ],
        
  function( mat, weight )
    
    return LeftSheaf( mat, ListWithIdenticalEntries( NrColumns( mat ), weight ) );
    
end );

##
InstallMethod( LeftSheaf,
        "constructor",
        [ IsHomalgMatrix ],
        
  function( mat )
    
    return LeftSheaf( mat, ListWithIdenticalEntries( NrColumns( mat ), 0 ) );
    
end );

##
InstallMethod( RightSheaf,
        "constructor",
        [ IsHomalgMatrix, IsList ],
        
  function( mat, weights )
    local M;
    
    M := RightPresentationWithDegrees( mat, weights );
    
    return HomalgSheaf( M );
    
end );

##
InstallMethod( RightSheaf,
        "constructor",
        [ IsHomalgMatrix, IsInt ],
        
  function( mat, weight )
    
    return RightSheaf( mat, ListWithIdenticalEntries( NrRows( mat ), weight ) );
    
end );

##
InstallMethod( RightSheaf,
        "constructor",
        [ IsHomalgMatrix ],
        
  function( mat )
    
    return RightSheaf( mat, ListWithIdenticalEntries( NrRows( mat ), 0 ) );
    
end );

##
InstallMethod( DirectSumOfLeftLineBundles,
        "constructor",
        [ IsHomalgRing, IsList ],
        
  function( R, weights )
    
    return LeftPresentationWithDegrees( HomalgZeroMatrix( 0, Length( weights ), R ), weights );
    
end );

##
InstallMethod( DirectSumOfLeftLineBundles,
        "constructor",
        [ IsInt, IsHomalgRing, IsInt ],
        
  function( rank, R, weight )
    
    return DirectSumOfLeftLineBundles( R, ListWithIdenticalEntries( rank, weight ) );
    
end );

##
InstallMethod( DirectSumOfLeftLineBundles,
        "constructor",
        [ IsInt, IsHomalgRing ],
        
  function( rank, R )
    
    return DirectSumOfLeftLineBundles( rank, R, 0 );
    
end );

##
InstallMethod( DirectSumOfRightLineBundles,
        "constructor",
        [ IsHomalgRing, IsList ],
        
  function( R, weights )
    
    return RightPresentationWithDegrees( HomalgZeroMatrix( Length( weights ), 0, R ), weights );
    
end );

##
InstallMethod( DirectSumOfRightLineBundles,
        "constructor",
        [ IsInt, IsHomalgRing, IsInt ],
        
  function( rank, R, weight )
    
    return DirectSumOfRightLineBundles( R, ListWithIdenticalEntries( rank, weight ) );
    
end );

##
InstallMethod( DirectSumOfRightLineBundles,
        "constructor",
        [ IsInt, IsHomalgRing ],
        
  function( rank, R )
    
    return DirectSumOfRightLineBundles( rank, R, 0 );
    
end );

##
InstallMethod( POW,
        "constructor",
        [ IsHomalgSheafOfRings, IsInt ],
        
  function( R, twist )
    
    return DirectSumOfLeftLineBundles( 1, R, -twist );
    
end );

##
InstallMethod( POW,
        "constructor",
        [ IsHomalgSheafOfRings, IsList ],
        
  function( R, twist )
    
    return DirectSumOfLeftLineBundles( R, -twist );
    
end );

####################################
#
# View, Print, and Display methods:
#
####################################

##
InstallMethod( ViewObj,
        "for sheaves of rings",
        [ IsSheafOfRingsRep ],
        
  function( O )
    local S, weights;
    
    S := HomalgRing( O );
    
    if S <> fail then
        
        if IsFreePolynomialRing( S ) then
            
            Print( "<The structure sheaf of some ", Dimension( O ), "-dimensional " );
            
            weights := WeightsOfIndeterminates( S );
            
            if Set( weights ) <> [ 1 ] then
                
                weights := String( weights );
                
                RemoveCharacters( weights, "\[\] " );
                
                Print( "(", weights, ")-weighted " );
                
            fi;
            
            Print( "projective space>" );
            
        else
            
            Print( "<A sheaf of rings>" );
            
        fi;
        
    else
        
        Print( "<A sheaf of rings>" );
        
    fi;
    
end );

##
InstallMethod( ViewObj,
        "for sets of relations",
        [ IsSetOfUnderlyingModulesRep ],
        
  function( o )
    local l;
    
    l := Length( o!.ListOfPositionsOfKnownUnderlyingModules );
    
    if l = 1 then
        Print( "<A set containing a single graded module underlying a sheaf>" );
    else
        Print( "<A set of ", l, " graded modules underlying a sheaf>" );
    fi;
    
end );

##
InstallMethod( ViewObj,
        "for coherent sheaves",
        [ IsCoherentSheafRep ],
        
  function( E )
    local O, S, weights;
    
    O := StructureSheafOfAmbientSpace( E );
    
    S := HomalgRing( O );
    
    Print( "<A coherent sheaf of modules" );
    
    if S <> fail then
        
        if IsFreePolynomialRing( S ) then
            
            Print( " on some ", Dimension( O ), "-dimensional " );
            
            weights := WeightsOfIndeterminates( S );
            
            if Set( weights ) <> [ 1 ] then
                
                weights := String( weights );
                
                RemoveCharacters( weights, "\[\] " );
                
                Print( "(", weights, ")-weighted " );
                
            fi;
            
            Print( "projective space" );
            
        fi;
        
    fi;
    
    Print( ">" );
    
end );

##
InstallMethod( homalgProjString,
        "for sheaves of rings",
        [ IsHomalgRing and IsFreePolynomialRing ],
        
  function( S )
    local proj, weights;
    
    proj := "O_P";
    
    Append( proj, String( Length( Indeterminates( S ) ) - 1 ) );
    
    weights := WeightsOfIndeterminates( S );
    
    if Set( weights ) <> [ 1 ] then
        
        weights := String( weights );
        
        RemoveCharacters( weights, "\[\] " );
        
        Append( proj, Concatenation( "(", weights, ")" ) );
        
    fi;
    
    return proj;
    
end );

##
InstallMethod( Display,
        "for sheaves of rings",
        [ IsSheafOfRingsRep ],
        
  function( O )
    local S, weights;
    
    S := HomalgRing( O );
    
    if S <> fail then
        
        if IsFreePolynomialRing( S ) then
            
            Print( homalgProjString( S ) );
            
        else
            
            Print( "no display method found" );
            
        fi;
        
    else
        
        Print( "no display method found" );
        
    fi;
    
    Print( "\n" );
    
end );

##
InstallMethod( Display,
        "for sheaves of rings",
        [ IsCoherentSheafRep ],
        
  function( E )
    
    Display( UnderlyingModule( E ) );
    
end );

