#############################################################################
##
##  HomalgFunctor.gi            homalg package               Mohamed Barakat
##
##  Copyright 2007-2008 Lehrstuhl B für Mathematik, RWTH Aachen
##
##  Implementation stuff for functors.
##
#############################################################################

####################################
#
# representations:
#
####################################

# a new representation for the category IsHomalgGenerators:
DeclareRepresentation( "IsHomalgFunctorRep",
        IsHomalgFunctor,
        [ ] );

####################################
#
# families and types:
#
####################################

# a new family:
BindGlobal( "HomalgFunctorFamily",
        NewFamily( "TheFamilyOfHomalgGenerators" ) );

# two new types:
BindGlobal( "TheTypeHomalgGeneratorsOfLeftModule",
        NewType(  TheFamilyOfHomalgGenerators,
                IsHomalgGeneratorsOfFinitelyGeneratedModuleRep and IsHomalgGeneratorsOfLeftModule ) );

BindGlobal( "TheTypeHomalgGeneratorsOfRightModule",
        NewType(  TheFamilyOfHomalgGenerators,
                IsHomalgGeneratorsOfFinitelyGeneratedModuleRep and IsHomalgGeneratorsOfRightModule ) );

####################################
#
# methods for operations:
#
####################################

##
InstallMethod( MatrixOfGenerators,
        "for sets of generators of homalg modules",
        [ IsHomalgGeneratorsOfFinitelyGeneratedModuleRep ],
        
  function( gen )
    
    return gen!.generators;
    
end );

####################################
#
# constructor functions and methods:
#
####################################

####################################
#
# View, Print, and Display methods:
#
####################################

InstallMethod( ViewObj,
        "for homalg generators",
        [ IsHomalgGeneratorsOfFinitelyGeneratedModuleRep ],
        
  function( o )
    local m;
    
    m := NrGenerators( o );
    
    if m = 0 then
        Print( "<An empty set of generators of a homalg " );
    elif m = 1 then
        Print( "<A set consisting of a single generator of a homalg " );
    else
        Print( "<A set of ", m, " generators of a homalg " );
    fi;
    
    if IsHomalgGeneratorsOfLeftModule( o ) then
        Print( "left " );
    else
        Print( "right " );
    fi;
    
    Print( "module>" );
    
end );

InstallMethod( Display,
        "for homalg generators",
        [ IsHomalgGeneratorsOfFinitelyGeneratedModuleRep ],
        
  function( o )
    
    Display( MatrixOfGenerators( o ) );
    
end );
