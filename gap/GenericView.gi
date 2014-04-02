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

DeclareRepresentation( "IsAttributeDependencyGraphForPrintingWithFunctionNodeRep",
                       IsAttributeDependencyGraphForPrintingNode and IsAttributeStoringRep,
                       [ ] );

BindGlobal( "TheTypeAttributeDependencyGraphForPrintingNodeWithFunction",
            NewType( TheFamilyOfAttributeDependencyGraphsForPrintingNodes,
                     IsAttributeDependencyGraphForPrintingWithFunctionNodeRep ) );

##################################
##
## Constructors
##
##################################

#
InstallGlobalFunction( TOOLS_FOR_HOMALG_CREATE_NODE_INPUT,
                       
  function( record )
    local conditions, condition_function;
    
    if not IsBound( record!.Conditions ) then
        
        Error( "wrong input, Conditions must be set." );
        
    fi;
    
    if IsString( record!.Conditions ) then
        
        record!.type := TheTypeAttributeDependencyGraphForPrintingNode;
        
    else
        
        record!.type := TheTypeAttributeDependencyGraphForPrintingNodeWithFunction;
        
        if IsList( record!.Conditions ) then
            
            conditions := ShallowCopy( record!.Conditions );
            
            condition_function := function( object )
                local i, cond;
                
                for i in conditions do
                    
                    if IsString( i ) then
                        
                        cond := ValueGlobal( i );
                        
                    fi;
                    
                    if IsOperation( cond ) then
                        
                        if Tester( cond )( object ) <> true then
                            
                            return [ "notcomputed", SuPeRfail ];
                            
                        fi;
                        
                        if cond( object ) <> true then
                            
                            return [ "false", false ];
                            
                        fi;
                        
                    fi;
                    
                    if IsFunction( i ) then
                        
                        if i( object ) <> true then
                            
                            return [ "false", false ];
                            
                        fi;
                        
                    fi;
                    
                od;
                
                return [ "true", true ];
                
            end;
            
            record!.Conditions := condition_function;
            
        fi;
        
    fi;
    
    if not IsBound( record!.PrintString ) then
        
        if IsString( record!.Conditions ) then
            
            record!.PrintString := record!.Conditions;
            
        else
            
            Error( "some print string must be given" );
            
        fi;
        
    fi;
    
    if not IsString( record!.PrintString ) or IsFunction( record!.PrintString ) then
        
        Error( "wrong print string input. Must be function or string." );
        
    fi;
    
    if not IsBound( record!.TypeOfView ) then
        
        record!.TypeOfView = "ViewObj";
        
    fi;
    
    if not IsBound( record!.ComputeLevel ) then
        
        record!.ComputeLevel = "AllWithCompute";
        
    fi;
    
    type_of_view := record!.TypeOfView;
    
    if type_of_view = "ViewObj" then
        
        record!.TypeOfView := 1;
        
    elif type_of_view = "Display" then
        
        record!.TypeOfView := 2;
        
    elif type_of_view = "ViewAll" then
        
        record!.TypeOfView := 3;
        
    else
        
        record!.TypeOfView := 4;
        
    fi;
    
    compute_level := record!.ComputeLevel;
    
    if compute_level = "ViewObj" then
        
        record!.ComputeLevel := 1;
        
    elif compute_level = "Display" then
        
        record!.ComputeLevel := 2;
        
    elif compute_level = "ViewAll" then
        
        record!.ComputeLevel := 3;
        
    else
        
        record!.ComputeLevel := 4;
        
    fi;
    
    if not IsBound( record!.Adjective ) then
        
        record!.Adjective := false;
        
    fi;
    
    return record;
    
end );

##
InstallMethod( CreateNode,
               [ IsRecord ],
               
  function( node )
    
    TOOLS_FOR_HOMALG_CREATE_NODE_INPUT( node );
    
    node!.sucessors := [ ];
    
    node!.predecessors := [ ];
    
    ObjectifyWithAttributes( node, node!.Type );
    
    if IsBound( node!.Name ) then
        
        SetName( node, node!.Name )
        
    elif IsString( node!.Conditions ) then
        
        SetName( node, node!.Conditions );
        
    fi;
    
    return node;
    
end );

##
InstallMethod( CreateConjunctionNode,
               [ IsList, IsAttributeDependencyGraphForPrintingNode ],
               
  function( predecessor_list, sucessor )
    local conjunction_object;
    
    conjunction_object := rec( sucessor := sucessor,
                               predecessors := predecessor_list,
                               fullfillment_list := ListWithIdenticalEntries( Length( predecessor_list ), 0 )
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
               [ IsAttributeDependencyGraphForPrinting, IsRecord ],
               
  function( graph, node_record )
    local node_to_insert;
    
    node_to_insert := CreateNode( node_record );
    
    Add( graph!.list_of_nodes, node_to_insert );
    
end );

##
InstallMethod( AddRelationToGraph,
               [ IsAttributeDependencyGraphForPrinting, IsRecord ],
               
  function( graph, relation_record )
    local node_list_without_relations, stop_early, i, conjunction_node, j;
    
    stop_early := false;
    
    if not IsBound( relation_record!.Source ) then
        
        relation_record!.Source := [ ];
        
        stop_early := true;
        
    fi;
    
    if not IsBound( relation_record!.Range ) then
        
        relation_record!.Range := [ ];
        
        stop_early := true;
        
    fi;
    
    
    node_list_without_relations := Concatenation( relation_record!.Source, relation_record!.Range );
    
    for i in node_list do
        
        AddNodeToPrintingGraph( graph, i );
        
    od;
    
    if stop_early = true then
        
        return;
        
    fi;
    
    for i in relation_record!.Range do
        
        conjunction_node := CreateConjunctionNode( relation_record!.Source, i );
        
        Add( graph!.list_of_conjunctions, conjunction_node );
        
        for j in relation_record!.Source do
            
            Add( j!.sucessors, conjunction_node );
            
        od;
        
        Add( i!.predecessors, conjunction_node );
        
    od;
    
end );

#################################
##
## Getters
##
#################################

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
