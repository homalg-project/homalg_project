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
##      <C>IsHomalgRingOrFinitelyPresentedObjectRep</C>.)
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareRepresentation( "IsSheafOfRingsRep",
        IsHomalgSheafOfRings and
        IsHomalgRingOrFinitelyPresentedObjectRep,
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
##      The &GAP; representation of coherent sheaves. <P/>
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

##  <#GAPDoc Label="IsCoherentSubsheafRep">
##  <ManSection>
##    <Filt Type="Representation" Arg="M" Name="IsCoherentSubsheafRep"/>
##    <Returns>true or false</Returns>
##    <Description>
##      The &GAP; representation of coherent sheaves. <P/>
##      (It is a representation of the &GAP; category <Ref Filt="IsHomalgSheaf"/>,
##       which is a subrepresentation of the &GAP; representation
##      <C>IsFinitelyPresentedSubobjectRep</C>.)
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareRepresentation( "IsCoherentSubsheafRep",
        IsHomalgSheaf and
        IsFinitelyPresentedSubobjectRep,
        [ "map_having_subobject_as_its_image" ] );

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
HOMALG_IO.Pictograms.Eliminate := "eli";	## eliminate variables

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
             PositionOfTheDefaultUnderlyingModule := 1,
             string := "sheaf", string_plural := "sheaves"
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
    local O, S, weights, is_subobject, M, R, left_sheaf, properties, nz;
    
    O := StructureSheafOfAmbientSpace( E );
    
    S := HomalgRing( O );
    
    is_subobject := IsFinitelyPresentedSubobjectRep( E );
    
    if is_subobject then
        M := UnderlyingObject( E );
        if HasIsFree( M ) and IsFree( M ) then
            SetIsFree( E, true );
            ViewObj( E );
            return;
        elif HasIsZero( M ) and IsZero( M ) then
            SetIsZero( E, true );
            ViewObj( E );
            return;
        fi;
    else
        M := E;
    fi;
    
    left_sheaf := IsHomalgLeftObjectOrMorphismOfLeftObjects( M );
    
    properties := "";
    
    if HasIsStablyFree( M ) and IsStablyFree( M ) then
        Append( properties, " stably free" );
        if HasIsFree( M ) and not IsFree( M ) then	## the "not"s are obsolete but kept for better readability
            Append( properties, " non-free" );
            nz := true;
        fi;
    elif HasIsDirectSumOfLineBundles( M ) and IsDirectSumOfLineBundles( M ) then
        if HasRankOfSheaf( M ) and RankOfSheaf( M ) = 1 then
            Append( properties, " invertible" );
        else
            Append( properties, " direct sum of line bundles" );
        fi;
        if HasIsFree( M ) and not IsFree( M ) then	## the "not"s are obsolete but kept for better readability
            Append( properties, " non-free" );
            nz := true;
        fi;
    elif HasIsLocallyFree( M ) and IsLocallyFree( M ) then
        Append( properties, " locally free" );
        if HasIsFree( M ) and not IsFree( M ) then
            Append( properties, " non-free" );
            nz := true;
        fi;
    elif HasIsReflexive( M ) and IsReflexive( M ) then
        Append( properties, " reflexive" );
        if HasIsLocallyFree( M ) and not IsLocallyFree( M ) then
            Append( properties, " non-locally free" );
            nz := true;
        elif HasIsStablyFree( M ) and not IsStablyFree( M ) then
            Append( properties, " non-stably free" );
            nz := true;
        elif HasIsFree( M ) and not IsFree( M ) then
            Append( properties, " non-free" );
            nz := true;
        fi;
    elif HasIsTorsionFree( M ) and IsTorsionFree( M ) then
        if HasCodegreeOfPurity( M ) then
            if CodegreeOfPurity( M ) = [ 1 ] then
                Append( properties, Concatenation( " codegree-", String( 1 ), "-pure" ) );
            else
                Append( properties, Concatenation( " codegree-", String( CodegreeOfPurity( M ) ), "-pure" ) );
            fi;
            if not ( HasRankOfSheaf( M ) and RankOfSheaf( M ) > 0 ) then
                Print( " torsion-free" );
            fi;
            nz := true;
        else
            Append( properties, " torsion-free" );
            if HasIsReflexive( M ) and not IsReflexive( M ) then
                Append( properties, " non-reflexive" );
                nz := true;
            elif HasIsLocallyFree( M ) and not IsLocallyFree( M ) then
                Append( properties, " non-projective" );
                nz := true;
            elif HasIsFree( M ) and not IsFree( M ) then
                Append( properties, " non-free" );
                nz := true;
            fi;
        fi;
    fi;
    
    if HasIsTorsion( M ) and IsTorsion( M ) then
        if HasCodim( M ) then
            if HasIsPure( M ) then
                if IsPure( M ) then
                    ## only display the purity information if the ambient space has dimension > 1:
                    if not Dimension( O ) <= 1 then
                        if HasCodegreeOfPurity( M ) then
                            if CodegreeOfPurity( M ) = [ 0 ] then
                                Append( properties, " reflexively " );
                            elif CodegreeOfPurity( M ) = [ 1 ] then
                                Append( properties, Concatenation( " codegree-", String( 1 ), "-" ) );
                            else
                                Append( properties, Concatenation( " codegree-", String( CodegreeOfPurity( M ) ), "-" ) );
                            fi;
                        else
                            Append( properties, " " );
                        fi;
                        Append( properties, "pure" );
                    fi;
                else
                    Append( properties, " non-pure" );
                fi;
            fi;
            Append( properties, " codim " );
            Append( properties, String( Codim( M ) ) );
        else
            if HasIsPure( M ) then
                if IsPure( M ) then
                    ## only display the purity information if the global dimension of the ring is > 1:
                    if not ( left_sheaf and HasLeftGlobalDimension( R ) and LeftGlobalDimension( R ) <= 1 ) and
                       not ( not left_sheaf and HasRightGlobalDimension( R ) and RightGlobalDimension( R ) <= 1 ) then
                        if HasCodegreeOfPurity( M ) then
                            if CodegreeOfPurity( M ) = [ 0 ] then
                                Append( properties, " reflexively " );
                            elif CodegreeOfPurity( M ) = [ 1 ] then
                                Append( properties, Concatenation( " codegree-", String( 1 ), "-" ) );
                            else
                                Append( properties, Concatenation( " codegree-", String( CodegreeOfPurity( M ) ), "-" ) );
                            fi;
                        else
                            Append( properties, " " );
                        fi;
                        Append( properties, "pure" );
                    fi;
                else
                    Append( properties, " non-pure" );
                fi;
            elif HasIsZero( M ) and not IsZero( M ) then
                properties := Concatenation( " non-zero", properties );
            fi;
            Append( properties, " torsion" );
        fi;
    else
        if HasIsPure( M ) and not IsPure( M ) then
            Append( properties, " non-pure" );
        fi;
        if HasRankOfSheaf( M ) then
            Append( properties, " rank " );
            Append( properties, String( RankOfSheaf( M ) ) );
        elif HasIsZero( M ) and not IsZero( M ) and
          not ( HasIsPure( M ) and not IsPure( M ) ) and
          not ( IsBound( nz ) and nz = true ) then
            properties := Concatenation( " non-zero", properties );
        fi;
    fi;
    
    if left_sheaf then
        
        if is_subobject then
            if IsIdenticalObj( SuperObject( E ), 1 * S ) then
                Print( "<A", properties, " coherent sheaf of (left) ideals" );
            else
                Print( "<A", properties, " coherent subsheaf of (left) modules" );
            fi;
        else
            Print( "<A", properties, " coherent sheaf of (left) modules" );
        fi;
        
    else
        
        if is_subobject then
            if IsIdenticalObj( SuperObject( E ), S * 1 ) then
                Print( "<A", properties, " coherent sheaf of (right) ideals" );
            else
                Print( "<A", properties, " coherent subsheaf of (right) modules" );
            fi;
        else
            Print( "<A", properties, " coherent sheaf of (right) modules" );
        fi;
        
    fi;
    
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
InstallMethod( ViewObj,
        "for free sheaves",
        [ IsCoherentSheafRep and IsFree ], 1001, ## since we don't use the filter IsHomalgLeftObjectOrMorphismOfLeftObjects it is good to set the ranks high
        
  function( M )
    local r, rk;
    
    if IsBound( M!.distinguished ) then
        Print( "<The" );
    else
        Print( "<A" );
    fi;
    
    Print( " free sheaf of " );
    
    if IsHomalgLeftObjectOrMorphismOfLeftObjects( M ) then
        Print( "left" );
    else
        Print( "right" );
    fi;
    
    Print( " modules" );
    
    r := NrGenerators( M );
    
    if HasRankOfSheaf( M ) then
        rk := RankOfSheaf( M );
        Print( " of rank ", rk );
    fi;
    
    Print( ">" );
    
end );

##
InstallMethod( ViewObj,
        "for zero sheaves",
        [ IsCoherentSheafRep and IsZero ], 1001, ## since we don't use the filter IsHomalgLeftObjectOrMorphismOfLeftObjects we need to set the ranks high
        
  function( M )
    
    if IsBound( M!.distinguished ) then
        Print( "<The" );
    else
        Print( "<A" );
    fi;
    
    Print( " zero sheaf of " );
    
    if IsHomalgLeftObjectOrMorphismOfLeftObjects( M ) then
        Print( "left" );
    else
        Print( "right" );
    fi;
    
    Print( " modules>" );
    
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

