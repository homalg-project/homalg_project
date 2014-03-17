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
               [ IsString, IsString, IsString, IsString ],
               
  function( attribute_name, print_name, type_of_view, compute_level )
    local node_object;
    
    if type_of_view = "all" then
        
        type_of_view := 1;
        
    elif type_of_view = "display" then
        
        type_of_view := 2;
        
    else
        
        type_of_view := 3;
        
    fi;
    
    if compute_level  = "all" then
        compute_level := 1;
    elif compute_level = "display" then
        compute_level := 2;
    elif compute_level = "full" then
        compute_level := 3;
    else
        compute_level := 4;
    fi;
    
    
    node_object := rec( print_name := print_name,
                        type_of_view := type_of_view,
                        sucessors := [ ],
                        predecessors := [ ],
                        compute_level := compute_level
                      );
    
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
InstallMethod( CreatePrintingGraph,
               [ IsOperation, IsString ],
               
  function( object_filter, general_object_description )
    local graph;
    
    graph := CreatePrintingGraph( object_filter );
    
    graph!.general_object_description := general_object_description;
    
    return graph;
    
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
    
    if Length( node_list ) > 4 or Length( node_list ) = 0 then
        
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
        
        node_list := [ node_list[ 1 ], node_list[ 1 ], "all", "none" ];
        
    elif Length( node_list ) = 2 and node_list[ 2 ] in [ "all", "display", "full" ] then
        
        node_list := [ node_list[ 1 ], node_list[ 1 ], node_list[ 2 ], "none" ];
        
    elif Length( node_list ) = 2 then
        
        Add( node_list, "all" );
        
        Add( node_list, "none" );
        
    elif Length( node_list ) = 3 and node_list[ 2 ] in [ "all", "display", "full", "none" ] then
        
        node_list := [ node_list[ 1 ], node_list[ 1 ], node_list[ 2 ], node_list[ 3 ] ];
        
    elif Length( node_list ) = 3 and node_list[ 3 ] = "none" then
        
        node_list := [ node_list[ 1 ], node_list[ 2 ], "all", "none" ];
        
    elif Length( node_list ) = 3 then
        
        Add( node_list, "none" );
        
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
               [ IsObject, IsAttributeDependencyGraphForPrintingNode and AlreadyChecked, IsAttributeDependencyGraphForPrintingNode, IsInt ],
               
  function( arg )
    
    return;
    
end );

##
InstallMethod( MarkPrintingNode,
               [ IsObject, IsAttributeDependencyGraphForPrintingNode, IsInt ],
               
  function( obj, node, type_of_view )
  
    MarkPrintingNode( obj, node, node, type_of_view );
    
end );

##
InstallMethod( MarkPrintingNode,
               [ IsObject, IsAttributeDependencyGraphForPrintingNode, IsAttributeDependencyGraphForPrintingNode, IsInt ],
               
  function( object, node_to_be_checked, previous_node, marking_level )
    local attr, i, node_level, compute_level;
    
    attr := ValueGlobal( Name( node_to_be_checked ) );
    
    node_level := node_to_be_checked!.type_of_view;
    
    if node_level > marking_level then
        
        SetFilterObj( node_to_be_checked, NotPrintedBecauseOfHighLevel );
        
        return;
        
    fi;
    
    if ( not Tester( attr )( object ) ) and marking_level < node_to_be_checked!.compute_level then
        
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
               [ IsAttributeDependencyGraphForPrinting, IsObject, IsInt ],
               
  function( graph, object, type_of_view )
    local i;
    
    for i in graph!.list_of_nodes do
        
        MarkPrintingNode( object, i, type_of_view );
        
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
    
    ResetFilterObj( node, NotPrintedBecauseOfHighLevel );
    
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

##
InstallGlobalFunction( DECIDE_TYPE_OF_PRINTING,
                       
  function( obj, node, type_of_view )
    local attr, value;
    
    attr := ValueGlobal( Name( node ) );
    
    if node!.compute_level <= type_of_view then
        
        attr( obj );
        
        ResetFilterObj( node, NotPrintBecauseNotComputedYet );
        
    fi;
    
    if Tester( attr )( obj ) = false then
        
        return [ "notcomputed", SuPeRfail ];
        
    fi;
    
    value := attr( obj );
    
    if value = true or value = false then
        
        return [ "property", value ];
        
    fi;
    
    return [ "attribute", value ];
    
end );

##
InstallGlobalFunction( BUILD_PRINTING_FOR_VIEW_AND_DISPLAY,
                       
  function( object, graph, level, separation_string )
    local print_string, current_node, current_type;
    
    print_string := "";
    
    for current_node in graph!.list_of_nodes do
        
        if current_node!.type_of_view > level then
            
            continue;
            
        fi;
        
        if NotPrintBecauseImplied( current_node ) or NotPrintBecauseFalse( current_node ) then
            
            continue;
            
        fi;
        
        current_type := DECIDE_TYPE_OF_PRINTING( object, current_node, level );
        
        if current_type[ 1 ] = "property" and current_type[ 2 ] = true then
            
            Append( print_string, current_node!.print_name );
            
            Append( print_string, separation_string );
            
        elif current_type = "attribute" then
            
            Append( print_string, current_node!.print_name );
            
            Append( print_string, ": " );
            
            Append( print_string, String( current_type[ 2 ] ) );
            
            Append( print_string, separation_string );
            
        fi;
        
    od;
    
    if print_string <> "" then
        
        print_string := print_string{[ 1 .. Length( print_string ) - Length( separation_string ) ]};
        
    fi;
    
    return print_string;
    
end );

##
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
    
    print_string := BUILD_PRINTING_FOR_VIEW_AND_DISPLAY( object, graph, 1, ", " );
    
    Print( print_string );
    
    Print( ">" );
    
end );

##
InstallMethod( PrintMarkedGraphForDisplay,
               [ IsObject, IsAttributeDependencyGraphForPrinting ],
               
  function( object, graph )
    local current_node, current_type, print_string;
    
    if IsBound( graph!.general_object_description ) then
        
        Print( graph!.general_object_description );
        
    elif Length( NamesFilter( graph!.object_filter ) ) > 0 then
        
        Print( NamesFilter( graph!.object_filter )[ 1 ] );
        
    else
        
        Print( "An object" );
        
    fi;
    
    Print( " which has the following properties:\n" );
    
    print_string := BUILD_PRINTING_FOR_VIEW_AND_DISPLAY( object, graph, 1, "\n" );
    
    Print( print_string );
    
    Print( ".\n" );
    
end );

##
InstallMethod( PrintMarkedGraphFull,
               [ IsObject, IsAttributeDependencyGraphForPrinting ],
               
  function( object, graph )
    local print_string, current_node, current_type;
    
    Print( "Full description:\n" );
    
    if IsBound( graph!.general_object_description ) then
        
        Print( graph!.general_object_description );
        
    elif Length( NamesFilter( graph!.object_filter ) ) > 0 then
        
        Print( NamesFilter( graph!.object_filter )[ 1 ] );
        
    else
        
        Print( "An object" );
        
    fi;
    
    Print( "\n" );
    
    print_string := "";
    
    for current_node in graph!.list_of_nodes do
        
        Append( print_string, "- " );
        
        Append( print_string, current_node!.print_name );
        
        Append( print_string, ": " );
        
        current_type := DECIDE_TYPE_OF_PRINTING( object, current_node, 3 );
        
        if NotPrintBecauseFalse( current_node ) then
            
            Append( print_string, "false" );
            
        ## The later might happen if node is implied
        elif NotPrintBecauseNotComputedYet( current_node ) or current_type[ 1 ] = "notcomputed" then
            
            Append( print_string, "not computed yet" );
            
        else
            
            current_type := ReplacedString( String( current_type[ 2 ] ), "\n", Concatenation( "\n", ListWithIdenticalEntries( Length( current_node!.print_name ) + 4, ' ' ) ) );
            
            Append( print_string, current_type );
            
        fi;
        
        Append( print_string, "\n" );
        
    od;
    
    Print( print_string );
    
end );

##
InstallMethod( PrintMarkedGraphFullWithEverythingComputed,
               [ IsObject, IsAttributeDependencyGraphForPrinting ],
               
  function( object, graph )
    local print_string, current_node, current_type;
    
    Print( "Full description:\n" );
    
    if IsBound( graph!.general_object_description ) then
        
        Print( graph!.general_object_description );
        
    elif Length( NamesFilter( graph!.object_filter ) ) > 0 then
        
        Print( NamesFilter( graph!.object_filter )[ 1 ] );
        
    else
        
        Print( "An object" );
        
    fi;
    
    Print( "\n" );
    
    print_string := "";
    
    for current_node in graph!.list_of_nodes do
        
        Append( print_string, "- " );
        
        Append( print_string, current_node!.print_name );
        
        Append( print_string, ": " );
        
        current_type := DECIDE_TYPE_OF_PRINTING( object, current_node, 4 );
        
        if NotPrintBecauseFalse( current_node ) then
            
            Append( print_string, "false" );
            
        ## The later might happen if node is implied
        elif NotPrintBecauseNotComputedYet( current_node ) or current_type[ 1 ] = "notcomputed" then
            
            Append( print_string, "not computed yet" );
            
        else
            
            current_type := ReplacedString( String( current_type[ 2 ] ), "\n", Concatenation( "\n", ListWithIdenticalEntries( Length( current_node!.print_name ) + 4, ' ' ) ) );
            
            Append( print_string, current_type );
            
        fi;
        
        Append( print_string, "\n" );
        
    od;
    
    Print( print_string );
    
end );

##
InstallMethod( PrintMarkedGraphFullWithEverythingComputed,
               [ IsObject, IsAttributeDependencyGraphForPrinting ],
               
  function( object, graph )
    local print_string, current_node, current_type;
    
    Print( "Full description:\n" );
    
    if IsBound( graph!.general_object_description ) then
        
        Print( graph!.general_object_description );
        
    elif Length( NamesFilter( graph!.object_filter ) ) > 0 then
        
        Print( NamesFilter( graph!.object_filter )[ 1 ] );
        
    else
        
        Print( "An object" );
        
    fi;
    
    Print( "\n" );
    
    print_string := "";
    
    for current_node in graph!.list_of_nodes do
        
        Append( print_string, "- " );
        
        Append( print_string, current_node!.print_name );
        
        Append( print_string, ": " );
        
        current_type := DECIDE_TYPE_OF_PRINTING( object, current_node );
        
        if NotPrintBecauseFalse( current_node ) then
            
            Append( print_string, "false" );
            
        else
            
            current_type := ReplacedString( String( current_type[ 2 ] ), "\n", Concatenation( "\n", ListWithIdenticalEntries( Length( current_node!.print_name ) + 4, ' ' ) ) );
            
            Append( print_string, current_type );
            
        fi;
        
        Append( print_string, "\n" );
        
    od;
    
    Print( print_string );
    
end );

#################################
##
## Installer
##
#################################

InstallMethod( InstallPrintFunctionsOutOfPrintingGraph,
               [ IsAttributeDependencyGraphForPrinting ],
               
  function( graph )
    local filter, install_view_obj, install_display, install_full_view, install_full_view_with_everything_computed;
    
    filter := graph!.object_filter;
    
    ##get special instructions
    install_view_obj := ValueOption( "InstallViewObj" );
    if install_view_obj <> false then
        install_view_obj := true;
    fi;
    
    install_display := ValueOption( "InstallDisplay" );
    if install_display <> false then
        install_display := true;
    fi;
    
    install_full_view := ValueOption( "InstallFullView" );
    if install_full_view <> false then
        install_full_view := true;
    fi;
    
    install_full_view_with_everything_computed := ValueOption( "InstallFullViewWithEverythingComputed" );
    if install_full_view_with_everything_computed <> false then
        install_full_view_with_everything_computed := true;
    fi;
    
    if install_view_obj = true then
        
        InstallMethod( ViewObj,
                       [ filter ],
                       
          function( obj )
              
              MarkGraphForPrinting( graph, obj, 1 );
              
              PrintMarkedGraphForViewObj( obj, graph );
              
              ResetGraph( graph );
              
        end );
        
    fi;
    
    if install_display = true then
        
        InstallMethod( Display,
                       [ filter ],
                       
          function( obj )
            
            MarkGraphForPrinting( graph, obj, 2 );
            
            PrintMarkedGraphForDisplay( obj, graph );
            
            ResetGraph( graph );
            
        end );
        
    fi;
    
    if install_full_view = true then
        
        InstallMethod( FullView,
                       [ filter ],
                       
          function( obj )
            
            MarkGraphForPrinting( graph, obj, 3 );
            
            PrintMarkedGraphFull( obj, graph );
            
            ResetGraph( graph );
            
        end );
        
    fi;
    
    if install_full_view_with_everything_computed = true then
        
        InstallMethod( FullViewWithEverythingComputed,
                       [ filter ],
                       
          function( obj )
            
            MarkGraphForPrinting( graph, obj, 4 );
            
            PrintMarkedGraphFull( obj, graph );
            
            ResetGraph( graph );
            
        end );
        
    fi;
    
end );
