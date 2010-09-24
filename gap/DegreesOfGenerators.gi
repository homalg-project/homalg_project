#############################################################################
##
##  SetOfDegreesOfGenerators.gi         Graded Modules package
##
##  Copyright 2007-2010, Mohamed Barakat, University of Kaiserslautern
##                       Markus Lange-Hegermann, RWTH Aachen
##
##  implementation stuff for degrees of sets of generators.
##
#############################################################################

####################################
#
# representations:
#
####################################

# a new representation for the GAP-category IsSetsOfGenerators:
DeclareRepresentation( "IsSetOfDegreesOfGeneratorsRep",
        IsSetOfDegreesOfGenerators,
        [ "ListOfPositionsOfKnownDegrees" ] );

####################################
#
# families and types:
#
####################################

# a new family:
BindGlobal( "TheFamilyOfHomalgSetOfDegreesOfGenerators",
        NewFamily( "TheFamilyOfHomalgSetOfDegreesOfGenerators" ) );

# a new type:
BindGlobal( "TheTypeHomalgSetOfDegreesOfGenerators",
        NewType( TheFamilyOfHomalgSetOfDegreesOfGenerators,
                IsSetOfDegreesOfGeneratorsRep ) );

####################################
#
# methods for operations:
#
####################################

##
InstallMethod( AddDegreesOfGenerators,
        "for a set of degrees of generators",
        [ IsSetOfDegreesOfGeneratorsRep, IsInt, IsList ],
  function( gens, pos, degrees )
  
    gens!.(pos) := degrees;
    Add( gens!.ListOfPositionsOfKnownDegreesOfGenerators, pos );
    
end );

##
InstallMethod( GetDegreesOfGenerators,
        "for a set of degrees of generators",
        [ IsSetOfDegreesOfGeneratorsRep, IsPosInt ],
  function( gens, pos )
    
    if IsBound( gens!.(pos) ) then
      return gens!.(pos);
    else
      return fail;
    fi;
    
end );

##
InstallMethod( ListOfPositionsOfKnownDegreesOfGenerators,
        "for a set of degrees of generators",
        [ IsSetOfDegreesOfGeneratorsRep ],
  function( gens )
    
    return gens!.ListOfPositionsOfKnownDegreesOfGenerators;
    
end );


####################################
#
# constructor functions and methods:
#
####################################

##
InstallMethod( CreateSetOfDegreesOfGenerators,
  "for list of degrees",
  [ IsList ],
  function( degrees )
    
    return CreateSetOfDegreesOfGenerators( degrees, 1 );
    
end );

##
InstallMethod( CreateSetOfDegreesOfGenerators,
  "for list of degrees and a position",
  [ IsList, IsInt ],
  function( degrees, pos )
    local generators;
    
    generators := rec( 
      ListOfPositionsOfKnownDegreesOfGenerators := [ pos ]
      );
    
    generators!.(pos) := degrees;
    
    ## Objectify:
    Objectify( TheTypeHomalgSetOfDegreesOfGenerators, generators );
    
    return generators;
    
end );

##
InstallMethod( DegreesOfGenerators,
        "for homalg graded modules",
        [ IsGradedModuleRep, IsPosInt ],
        
  function( M, pos )
  local degrees, l_deg, l_rel, T;
    
    degrees := GetDegreesOfGenerators( SetOfDegreesOfGenerators( M ), pos );
    
    if degrees = fail then
      l_deg := ListOfPositionsOfKnownDegreesOfGenerators( SetOfDegreesOfGenerators( M ) );
      l_rel := ListOfPositionsOfKnownSetsOfRelations( M );
      if not pos in l_rel then
        return fail;
      fi;
      #use a heuristic here to find a smaller/better/faster-to-compute transition matrix?
      if IsHomalgLeftObjectOrMorphismOfLeftObjects( M ) then
        T := TransitionMatrix( M, l_deg[1], pos );
        degrees := NonTrivialDegreePerColumn( T, DegreesOfGenerators( M, l_deg[1] ) );
      else
        T := TransitionMatrix( M, pos, l_deg[1] );
        degrees := NonTrivialDegreePerRow( T, DegreesOfGenerators( M, l_deg[1] ) );
      fi;
      AddDegreesOfGenerators( SetOfDegreesOfGenerators( M ), pos, degrees );
    fi;
    
    return degrees;
    
end );

##
InstallMethod( DegreesOfGenerators,
        "for homalg graded modules",
        [ IsGradedModuleRep ],
        
  function( M )
    
    return DegreesOfGenerators( M, PositionOfTheDefaultPresentation( UnderlyingModule( M ) ) );
    
end );

##
InstallMethod( DegreesOfGenerators,
        "for homalg graded modules",
        [ IsGradedModuleRep and IsZero ],
        
  function( M )
    
    if NrGenerators( M ) > 0 then
        TryNextMethod( );
    fi;
    
    return [ ];
    
end );
  
####################################
#
# View, Print, and Display methods:
#
####################################

InstallMethod( ViewObj,
        "for set of degrees of generators",
        [ IsSetOfDegreesOfGeneratorsRep ],
        
  function( o )
    local l;
    
    l := Length( o!.ListOfPositionsOfKnownDegreesOfGenerators );
    
    Print( "<A set containing " );
    
    if l = 1 then
        Print( "a single list " );
    else
        Print( l, " lists " );
    fi;
    
    Print( "of degrees of generators of a graded homalg module>" );
    
end );

##
InstallMethod( Display,
        "for set of degrees of generators",
        [ IsSetOfDegreesOfGeneratorsRep ], ## since we don't use the filter IsHomalgLeftObjectOrMorphismOfLeftObjects we need to set the ranks high
        
  function( o )
    
    ViewObj( o );
    
end );
