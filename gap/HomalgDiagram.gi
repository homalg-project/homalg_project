#############################################################################
##
##  HomalgDiagram.gi                                          homalg package
##
##  Copyright 2007-2008, Mohamed Barakat, RWTH Aachen
##
##  Implementations for diagrams.
##
#############################################################################

####################################
#
# representations:
#
####################################

# a new representation for the GAP-category IsHomalgDiagram:
DeclareRepresentation( "IsHomalgDiagramRep",
        IsHomalgDiagram,
        [ "matrix", "range", "total", "display" ] );

####################################
#
# families and types:
#
####################################

# a new family:
BindGlobal( "TheFamilyOfHomalgDiagrams",
        NewFamily( "TheFamilyOfHomalgDiagrams" ) );

####################################
#
# global variables:
#
####################################

####################################
#
# methods for operations:
#
####################################

##
InstallMethod( MatrixOfDiagram,
        "for homalg diagrams",
        [ IsHomalgDiagramRep ],
        
  function( diag )
    
    return diag!.matrix;
    
end );

####################################
#
# View, Print, and Display methods:
#
####################################

##
InstallMethod( ViewObj,
        "for homalg diagrams",
        [ IsHomalgDiagramRep ],
        
  function( o )
    
    Print( "<A homalg diagram>" );
    
end );

##
InstallMethod( Display,
        "for homalg diagrams",
        [ IsHomalgDiagramRep ],
        
  function( o )
    
    Display( MatrixOfDiagram( o ) );
    
end );

