#############################################################################
##
##                                                     ToolsForHomalg package
##
##  Copyright 2014, Sebastian Gutsche, University of Kaiserslautern
##
##
#############################################################################

DeclareRepresentation( "IsAttributeDependencyGraphForPrintingRep",
                       IsAttributeDependencyGraphForPrinting and IsAttributeStoringRep,
                       [ ] );

BindGlobal( "TheFamilyOfAttributeDependencyGraphsForPrinting",
            NewFamily( "TheFamilyOfAttributeDependencyGraphsForPrinting" ) );

BindGlobal( "TheTypeAttributeDependencyGraphForPrinting",
            NewType( TheFamilyOfAttributeDependencyGraphsForPrinting,
                     IsAttributeDependencyGraphForPrintingRep ) );

DeclareRepresentation( "IsAttributeDependencyGraphForPrintingNodeRep",
                       IsAttributeDependencyGraphForPrintingNode and IsAttributeStoringRep,
                       [ ] );

BindGlobal( "TheFamilyOfAttributeDependencyGraphsForPrintingNodes",
            NewFamily( "TheFamilyOfAttributeDependencyGraphsForPrintingNodes" ) );

BindGlobal( "TheTypeAttributeDependencyGraphForPrintingNode",
            NewType( TheFamilyOfAttributeDependencyGraphsForPrintingNodes,
                     IsAttributeDependencyGraphForPrintingNodeRep ) );

DeclareRepresentation( "IsAttributeDependencyGraphForPrintingNodeConjunctionRep",
                       IsAttributeDependencyGraphForPrintingNode and IsAttributeStoringRep,
                       [ ] );

BindGlobal( "TheTypeAttributeDependencyGraphForPrintingNodeConjunction",
            NewType( TheFamilyOfAttributeDependencyGraphsForPrintingNodes,
                     IsAttributeDependencyGraphForPrintingNodeConjunctionRep ) );

##################################
##
## Constructors
##
##################################

##
InstallMethod( CreateNode,
               [ IsString, IsString, IsString ],
               
  function( attribute_name, print_name, type_of_view )
    local node_object;
    
    if type_of_view = "all" then
        
        type_of_view := 1;
        
    elif type_of_view = "display" then
        
        type_of_view := 2;
        
    else
        
        type_of_view := 3;
        
    fi;
    
    node_object := rec( print_name := print_name,
                        type_of_view := type_of_view,
                        sucessors := [ ],
                        predecessors := [ ] );
    
    ObjectifyWithAttributes( node_object, TheTypeAttributeDependencyGraphForPrintingNode,
                             Name, attribute_name );
    
    return node_object;
    
end );

##
InstallMethod( CreateConjunctionNode,
               [ ],
               
  function( )
    local conjunction_object;
    
    conjunction_object := rec( sucessor := [ ],
                               predecessors := [ ],
                               fullfillment_list := [ ]
                             );
    
    ObjectifyWithAttributes( conjunction_object, TheTypeAttributeDependencyGraphForPrintingNodeConjunction );
    
    return conjunction_object;
    
end );

##
InstallMethod( CreatePrintingGraph,
               [ IsOperation ],
               
  function( object_filter )
    local printing_graph;
    
    printing_graph := rec( list_of_nodes := [ ],
                           object_filter := object_filter,
                           list_of_conjunctions := [ ]
                         );
    
    ObjectifyWithAttributes( printing_graph, TheTypeAttributeDependencyGraphForPrinting );
    
    return printing_graph;
    
end );

##
InstallMethod( \=,
               [ IsAttributeDependencyGraphForPrintingNode, IsAttributeDependencyGraphForPrintingNode ],
               
  IsIdenticalObj
  
);

##################################
##
## Setters
##
##################################

##
InstallMethod( AddNodeToPrintingGraph,
               [ IsAttributeDependencyGraphForPrinting, IsList ],
               
  function( graph, node_list )
    local node_to_insert;
    
    if Length( node_list ) > 3 or Length( node_list ) = 0 then
        
        Error( "wrong length of print node list" );
        
        return;
        
    fi;
    
    if not IsString( node_list[ 1 ] ) then
        
        Error( "first entry must be attribute name" );
        
        return;
        
    fi;
    
    if not ForAll( node_list, IsString ) then
        
        Error( "entries must be strings" );
        
    fi;
    
    if NodeWithNameInGraph( graph, node_list[ 1 ] ) <> fail then
        
        return;
        
    fi;
    
    if Length( node_list ) = 1 then
        
        node_list := [ node_list[ 1 ], node_list[ 1 ], "all" ];
        
    elif Length( node_list ) = 2 and node_list[ 2 ] in [ "all", "display", "full" ] then
        
        node_list := [ node_list[ 1 ], node_list[ 1 ], node_list[ 2 ] ];
        
    elif Length( node_list ) = 2 then
        
        Add( node_list, "all" );
        
    fi;
    
    node_to_insert := CallFuncList( CreateNode, node_list );
    
    Add( graph!.list_of_nodes, node_to_insert );
    
end );

## FOR INTERNAL USE ONLY!!!!
InstallMethod( AddConjunctionToGraph,
               [ IsAttributeDependencyGraphForPrinting, IsList, IsList ],
               
  function( graph, predec, succ )
    local conjunction_node, i, j;
    
    conjunction_node := CreateConjunctionNode( );
    
    Add( graph!.list_of_conjunctions, conjunction_node );
    
    for i in predec do
        
        for j in graph!.list_of_nodes do
            
            if IsString( i ) then
                
                i := [ i ];
                
            fi;
            
            if i[ 1 ] = Name( j ) then
                
                Add( conjunction_node!.predecessors, j );
                
                Add( conjunction_node!.fullfillment_list, 0 );
                
                Add( j!.sucessors, conjunction_node );
                
            fi;
            
        od;
        
    od;
    
    if not IsString( succ ) then
        
        succ := succ[ 1 ];
        
    fi;
    
    for i in graph!.list_of_nodes do
        
        if Name( i ) = succ then
            
            Add( conjunction_node!.sucessor, i );
            
            Add( i!.predecessors, conjunction_node );
            
            break;
            
        fi;
        
    od;
    
end );

##
InstallMethod( AddRelationToGraph,
               [ IsAttributeDependencyGraphForPrinting, IsList ],
               
  function( graph, relation_list )
    local i, first_part, relation_names;
    
    if not Length( relation_list ) = 2 then
        
        Error( "length of input list must be two" );
        
        return;
        
    fi;
    
    ##Process input data
    for i in relation_list[ 1 ] do
        
        AddNodeToPrintingGraph( graph, i );
        
    od;
    
    for i in relation_list[ 2 ] do
        
        AddNodeToPrintingGraph( graph, i );
        
    od;
    
    ##Add relations now.
    if Length( relation_list[ 1 ] ) > 1 then
        
        for i in relation_list[ 2 ] do
            
            AddConjunctionToGraph( graph, relation_list[ 1 ], i );
            
        od;
        
    else
        
        i := 1;
        
        while i <= Length( graph!.list_of_nodes ) do
            
            if Name( graph!.list_of_nodes[ i ] ) = relation_list[ 1 ][ 1 ][ 1 ] then
                
                first_part := graph!.list_of_nodes[ i ];
                
                break;
                
            fi;
            
            i := i + 1;
            
        od;
        
        if not IsBound( first_part ) then
            
            Error( "PANIC: missing node in graph" );
            
        fi;
        
        relation_names := List( relation_list[ 2 ], function( i ) if IsString( i ) then return i; else return i[ 1 ]; fi; end );
        
        for i in graph!.list_of_nodes do
            
            if Name( i ) in relation_names then
                
                Add( i!.predecessors, first_part );
                
                Add( first_part!.sucessors, i );
                
            fi;
            
        od;
        
    fi;
    
end );

#################################
##
## Getters
##
#################################

InstallMethod( NodeWithNameInGraph,
               [ IsAttributeDependencyGraphForPrinting, IsString ],
               
  function( graph, name )
    local i;
    
    for i in graph!.list_of_nodes do
        
        ## This can be done WAY MORE EFFICIENT by memorising the names.
        if Name( i ) = name then
            
            return i;
            
        fi;
        
    od;
    
    return fail;
    
end );

#################################
##
## Testers
##
#################################

##
InstallMethod( MarkPrintingNode,
               [ IsObject, IsAttributeDependencyGraphForPrintingNode and AlreadyChecked, IsAttributeDependencyGraphForPrintingNode ],
               
  function( arg )
    
    return;
    
end );

##
InstallMethod( MarkPrintingNode,
               [ IsObject, IsAttributeDependencyGraphForPrintingNode ],
               
  function( obj, node )
  
    MarkPrintingNode( obj, node, node );
    
end );

##
InstallMethod( MarkPrintingNode,
               [ IsObject, IsAttributeDependencyGraphForPrintingNode, IsAttributeDependencyGraphForPrintingNode ],
               
  function( object, node_to_be_checked, previous_node )
    local attr, i;
    
    attr := ValueGlobal( Name( node_to_be_checked ) );
    
    if not Tester( attr )( object ) then
        
        SetFilterObj( node_to_be_checked, NotPrintBecauseNotComputedYet );
        
        return;
        
    fi;
    
    attr := attr( object );
    
    if attr = false then
        
        SetFilterObj( node_to_be_checked, NotPrintBecauseFalse );
        
        return;
        
    fi;
    
    for i in node_to_be_checked!.sucessors do
        
        MarkAsImplied( i, node_to_be_checked );
        
    od;
    
end );

##
InstallMethod( MarkAsImplied,
               [ IsAttributeDependencyGraphForPrintingNode and AlreadyChecked, IsAttributeDependencyGraphForPrintingNode ],
               
  function( node, previous_node )
    
    return;
    
end );

##
InstallMethod( MarkAsImplied,
               [ IsAttributeDependencyGraphForPrintingNodeConjunctionRep, IsAttributeDependencyGraphForPrintingNode ],
               
  function( conjunction_node, previous_node )
    local position;
    
    position := Position( conjunction_node!.predecessors, previous_node );
    
    if position = fail then
        
        return;
        
    fi;
    
    conjunction_node!.fullfillment_list[ position ] := 1;
    
    if ForAll( conjunction_node!.fullfillment_list, i -> i = 1 ) then
        
        MarkAsImplied( conjunction_node!.sucessor[ 1 ], previous_node );
        
    fi;
    
end );

##
InstallMethod( MarkAsImplied,
               [ IsAttributeDependencyGraphForPrintingNode, IsAttributeDependencyGraphForPrintingNode ],
               
  function( node, previous_node )
    local i;
    
    SetFilterObj( node, NotPrintBecauseImplied );
    
    for i in node!.sucessors do
        
        MarkAsImplied( i, node );
        
    od;
    
end );

InstallMethod( MarkGraphForPrinting,
               [ IsAttributeDependencyGraphForPrinting, IsObject ],
               
  function( graph, object )
    local i;
    
    for i in graph!.list_of_nodes do
        
        MarkPrintingNode( object, i );
        
    od;
    
end );

#################################
##
## Reseters
##
#################################

##
InstallGlobalFunction( RESET_ALL_POSSIBLE_FILTERS_FOR_DEPENDENCY_GRAPH,
                       
  function( node )
    
    ResetFilterObj( node, NotPrintBecauseImplied );
    
    ResetFilterObj( node, NotPrintBecauseFalse );
    
    ResetFilterObj( node, NotPrintBecauseNotComputedYet );
    
    ResetFilterObj( node, AlreadyChecked );
    
end );

##
InstallMethod( ResetGraph,
               [ IsAttributeDependencyGraphForPrinting ],
               
  function( graph )
    local node;
    
    for node in graph!.list_of_nodes do
        
        RESET_ALL_POSSIBLE_FILTERS_FOR_DEPENDENCY_GRAPH( node );
        
    od;
    
    for node in graph!.list_of_conjunctions do
        
        RESET_ALL_POSSIBLE_FILTERS_FOR_DEPENDENCY_GRAPH( node );
        
        node!.fullfillment_list := List( node!.fullfillment_list, i -> 0 );
        
    od;
    
end );

#################################
##
## Printers
##
#################################

InstallGlobalFunction( DECIDE_TYPE_OF_PRINTING,
                       
  function( obj, node )
    local attr, value;
    
    attr := ValueGlobal( Name( node ) );
    
    if Tester( attr )( obj ) = false then
        
        return [ "notcomputed", SuPeRfail ];
        
    fi;
    
    value := attr( obj );
    
    if value = true or value = false then
        
        return [ "property", value ];
        
    fi;
    
    return [ "attribute", value ];
    
end );

InstallMethod( PrintMarkedGraphForViewObj,
               [ IsObject, IsAttributeDependencyGraphForPrinting ],
               
  function( object, graph )
    local current_node, current_type, print_string;
    
    Print( "<" );
    
    if IsBound( graph!.general_object_description ) then
        
        Print( graph!.general_object_description );
        
    elif Length( NamesFilter( graph!.object_filter ) ) > 0 then
        
        Print( NamesFilter( graph!.object_filter )[ 1 ] );
        
    else
        
        Print( "An object" );
        
    fi;
    
    Print( " which has the following properties: " );
    
    print_string := "";
    
    for current_node in graph!.list_of_nodes do
        
        if current_node!.type_of_view > 1 then
            
            continue;
            
        fi;
        
        if NotPrintBecauseImplied( current_node ) or NotPrintBecauseFalse( current_node ) or NotPrintBecauseNotComputedYet( current_node ) then
            
            continue;
            
        fi;
        
        current_type := DECIDE_TYPE_OF_PRINTING( object, current_node );
        
        if current_type[ 1 ] = "property" and current_type[ 2 ] = true then
            
            Append( print_string, current_node!.print_name );
            
            Append( print_string, ", " );
            
        elif current_type = "attribute" then
            
            Append( print_string, current_node!.print_name );
            
            Append( print_string, ": " );
            
            Append( print_string, String( current_type[ 2 ] ) );
            
            Append( print_string, ", " );
            
        fi;
        
    od;
    
    if Length( print_string ) > 0 then
        
        print_string := print_string{[ 1 .. Length( print_string ) - 2 ]};
        
    fi;
    
    Print( print_string );
    
    Print( ">" );
    
end );