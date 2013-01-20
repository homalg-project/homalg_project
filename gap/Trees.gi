#############################################################################
##
##  Trees.gi                                ToolsForHomalg package
##
##  Copyright 2007-2013, Mohamed Barakat, University of Kaiserslautern
##                       Sebastian Gutsche, RWTH-Aachen University
##                  Markus Lange-Hegermann, RWTH-Aachen University
##
##  Trees for use in ToDoLists.
##
#############################################################################

DeclareRepresentation( "IsTreeRep",
                       IsTree and IsAttributeStoringRep,
                       [ ] );

BindGlobal( "TheFamilyOfTrees",
        NewFamily( "TheFamilyOfTrees" ) );

BindGlobal( "TheTypeTree",
        NewType( TheFamilyOfTrees,
                IsTreeRep ) );

###################################
##
## Attributes
##
###################################

###################################
##
## Methods
##
###################################

##
InstallMethod( EQ,
               "for trees",
               [ IsTree, IsTree ],
               
  IsIdenticalObj
  
);

##
InstallMethod( Predecessor,
               "for trees",
               [ IsTree ],
               
  function( tree )
    
    return tree!.predecessor;
    
end );

##
InstallMethod( ListOfSuccessors,
               "for trees",
               [ IsTree ],
               
  function( tree )
    
    return tree!.successor;
    
end );

##
InstallMethod( Add,
               "adds subtree to tree",
               [ IsTree, IsTree ],
               
  function( tree, new_subtree )
    
    if Position( tree!.successor, new_subtree ) = fail and new_subtree!.predecessor = fail then
        
        Add( tree!.successor, new_subtree );
        
        ResetFilterObj( tree, IsSentinel );
        
        new_subtree!.predecessor := tree;
        
    fi;
    
end );

##
InstallMethod( Add,
               "adds list of trees to tree",
               [ IsTree, IsList ],
               
  function( tree, new_sublist )
    local i;
    
    for i in new_sublist do
        
        Add( tree, i );
        
    od;
    
end );

##
InstallMethod( ListOfSentinels,
               "for sentinels",
               [ IsTree and IsSentinel ],
               
  function( tree )
    
    return [ tree ];
    
end );

##
InstallMethod( ListOfSentinels,
               "returns list of leaves of tree",
               [ IsTree ],
               
  function( tree )
    
    return Concatenation( List( tree!.successor, ListOfSentinels ) );
    
end );

##
InstallMethod( RemoveHead,
               "for sentinels",
               [ IsTree and IsSentinel ],
               
  IdFunc
  
);

##
InstallMethod( RemoveHead,
               "for sentinels with content",
               [ IsTree and IsSentinel and HasContent ],
               
  function( tree )
    
    return Tree( );
    
end );

##
InstallMethod( RemoveHead,
               "removes head",
               [ IsTree ],
               
  function( tree )
    local succ, new_tree, new_succ, i;
    
    succ := tree!.successor;
    
    new_tree := succ[ 1 ];
    
    new_succ := new_tree!.successor;
    
    new_tree!.predecessor := fail;
    
    for i in [ 2 .. Length( tree!.successor ) ] do
        
        Add( new_succ, succ[ i ] );
        
        succ[ i ]!.predecessor := new_tree;
        
    od;
    
    return new_tree;
    
end );

##
InstallMethod( ContentListFromSentinelToHead,
               "for sentinels",
               [ IsTree and IsSentinel ],
               
  function( sentinel )
    local list;
    
    list := [ ];
    
    while sentinel <> fail do
        
        Add( list, Content( sentinel ) );
        
        sentinel := Predecessor( sentinel );
        
    od;
    
    return list;
    
end );

##
InstallMethod( PostOrder,
               "for sentinels",
               [ IsTree and IsSentinel ],
               
  function( tree )
    
    return [ Content( tree ) ];
    
end );

##
InstallMethod( PostOrder,
               "for sentinels",
               [ IsTree ],
               
  function( tree )
    local list;
    
    list := List( ListOfSuccessors( tree ), PostOrder );
    
    list := Concatenation( list );
    
    Add( list, Content( tree ) );
    
    return list;
    
end );

##
InstallMethod( in,
               "for trees",
               [ IsObject, IsTree ],
               
  function( obj, tree )
    
    if IsSentinel( tree ) then
        
        if HasContent( tree ) and Content( tree ) = obj then
            
            return true;
            
        fi;
        
        return false;
        
    fi;
    
    return ForAny( ListOfSuccessors( tree ), i -> obj in i );
    
end );

###################################
##
## Constructors
##
###################################

##
InstallMethod( Tree,
               "creates an empty tree",
               [ ],
               
  function( )
    local tree;
    
    tree := rec( successor := [ ],
                 predecessor := fail );
    
    ObjectifyWithAttributes( tree, TheTypeTree );
    
    SetFilterObj( tree, IsSentinel );
    
    return tree;
    
end );

##
InstallMethod( Tree,
               "creates tree with content",
               [ IsObject ],
               
  function( content )
    local tree;
    
    tree := rec( successor := [ ],
                 predecessor := fail );
    
    ObjectifyWithAttributes( tree, TheTypeTree );
    
    SetContent( tree, content );
    
    SetFilterObj( tree, IsSentinel );
    
    return tree;
    
end );

###################################
##
## Constructors
##
###################################

##
InstallMethod( ViewObj,
               "for trees",
               [ IsTree ],
               
  function( tree )
    
    Print( "<A" );
    
    if not HasContent( tree ) then
        
        Print( "n empty" );
        
    fi;
    
    if IsSentinel( tree ) then
        
        Print( " sentinel>" );
        
    else
        
        Print( " tree with currently " );
        
        Print( Length( tree!.successor ) );
        
        Print( " nodes>" );
        
    fi;
    
end );

##
InstallMethod( Display,
               "for trees with content",
               [ IsTree and HasContent ],
               
  function( tree )
    
    Display( Content( tree ) );
    
end );

##
InstallMethod( Display,
               "for trees",
               [ IsTree ],
               
  function( tree )
    
    Print( "A" );
    
    Print( "n empty" );
    
    if IsSentinel( tree ) then
        
        Print( " sentinel." );
        
    else
        
        Print( " tree with currently " );
        
        Print( Length( tree!.successor ) );
        
        Print( " nodes." );
        
    fi;
    
end );