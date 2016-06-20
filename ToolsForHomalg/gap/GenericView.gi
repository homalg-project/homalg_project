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
    local conditions, condition_function, type_of_view, compute_level;
    
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
                            
                            return fail;
                            
                        fi;
                        
                        if cond( object ) <> true then
                            
                            return false;
                            
                        fi;
                        
                    fi;
                    
                    if IsFunction( i ) then
                        
                        if i( object ) <> true then
                            
                            return false;
                            
                        fi;
                        
                    fi;
                    
                od;
                
                return true;
                
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
        
        record!.TypeOfView := "ViewObj";
        
    fi;
    
    if not IsBound( record!.ComputeLevel ) then
        
        record!.ComputeLevel := "AllWithCompute";
        
    fi;
    
    type_of_view := record!.TypeOfView;
    
    if not IsInt( type_of_view ) then
        
        if type_of_view = "ViewObj" then
            
            record!.TypeOfView := 1;
            
        elif type_of_view = "Display" then
            
            record!.TypeOfView := 2;
            
        elif type_of_view = "ViewAll" then
            
            record!.TypeOfView := 3;
            
        else
            
            record!.TypeOfView := 4;
            
        fi;
        
    fi;
    
    compute_level := record!.ComputeLevel;
    
    if not IsInt( compute_level ) then
        
        if compute_level = "ViewObj" then
            
            record!.ComputeLevel := 1;
            
        elif compute_level = "Display" then
            
            record!.ComputeLevel := 2;
            
        elif compute_level = "ViewAll" then
            
            record!.ComputeLevel := 3;
            
        else
            
            record!.ComputeLevel := 4;
            
        fi;
        
    fi;
    
    if not IsBound( record!.Adjective ) then
        
        record!.Adjective := false;
        
    fi;
    
    if not IsBound( record!.NoSepString ) then
        
        record!.NoSepString := false;
        
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
    
    ObjectifyWithAttributes( node, node!.type );
    
    if IsBound( node!.Name ) then
        
        SetName( node, node!.Name );
        
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
                           list_of_conjunctions := [ ],
                           list_of_pre_object_nodes := [ ],
                           list_of_post_object_nodes := [ ]
                         );
    
    ObjectifyWithAttributes( printing_graph, TheTypeAttributeDependencyGraphForPrinting );
    
    return printing_graph;
    
end );

##
InstallMethod( CreatePrintingGraph,
               [ IsOperation, IsObject ],
               
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
InstallMethod( AddNodeToGraph,
               [ IsAttributeDependencyGraphForPrinting, IsRecord ],
               
  function( graph, node_record )
    local node_to_insert;
    
    node_to_insert := CreateNode( node_record );
    
    Add( graph!.list_of_nodes, node_to_insert );
    
    if node_to_insert!.Adjective = true then
        
        Add( graph!.list_of_pre_object_nodes, node_to_insert );
        
    else
        
        Add( graph!.list_of_post_object_nodes, node_to_insert );
        
    fi;
    
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
        
    elif not IsList( relation_record!.Source ) then
        
        relation_record!.Source := [ relation_record!.Source ];
        
    fi;
    
    if not IsBound( relation_record!.Range ) then
        
        relation_record!.Range := [ ];
        
        stop_early := true;
        
    elif not IsList( relation_record!.Range ) then
        
        relation_record!.Range := [ relation_record!.Range ];
        
    fi;
    
    node_list_without_relations := Concatenation( relation_record!.Source, relation_record!.Range );
    
    for i in node_list_without_relations do
        
        if IsString( i ) then
            
            continue;
            
        fi;
        
        AddNodeToGraph( graph, i );
        
    od;
    
    if stop_early = true then
        
        return;
        
    fi;
    
    for i in [ 1 .. Length( relation_record!.Source ) ] do
        
        relation_record!.Source[ i ] := GetNodeByName( graph, relation_record!.Source[ i ] );
        
    od;
    
    for i in [ 1 .. Length( relation_record!.Range ) ] do
        
        relation_record!.Range[ i ] := GetNodeByName( graph, relation_record!.Range[ i ] );
        
    od;
    
    if ForAny( Concatenation( relation_record!.Source, relation_record!.Range ), i -> i = fail ) then
        
        Error( "wrong input name given" );
        
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

##
InstallMethod( GetNodeByName,
               [ IsAttributeDependencyGraphForPrinting, IsString ],
               
  function( graph, node_name )
    local node;
    
    for node in graph!.list_of_nodes do
        
        if Name( node ) = node_name then
            
            return node;
            
        fi;
        
    od;
    
    return fail;
    
end );

##
InstallMethod( GetNodeByName,
               [ IsAttributeDependencyGraphForPrinting, IsAttributeDependencyGraphForPrintingNode ],
               
  function( graph, node )
    
    return node;
    
end );

#################################
##
## Testers
##
#################################

##
InstallMethod( MarkPrintingNode,
               [ IsObject, IsAttributeDependencyGraphForPrintingNode, IsInt ],
               
  function( obj, node, marking_level )
  
    MarkPrintingNode( obj, node, node, marking_level );
    
end );

##
InstallMethod( MarkPrintingNode,
               [ IsObject, IsAttributeDependencyGraphForPrintingNodeRep, IsInt ],
               
  function( object, node_to_be_checked, marking_level )
    local attr, i, node_level, compute_level;
    
    attr := ValueGlobal( node_to_be_checked!.Conditions );
    
    node_level := node_to_be_checked!.TypeOfView;
    
    if node_level > marking_level then
        
        SetFilterObj( node_to_be_checked, NodeOfHighLevel );
        
    fi;
    
    if ( not Tester( attr )( object ) ) and marking_level < node_to_be_checked!.ComputeLevel then
        
        SetFilterObj( node_to_be_checked, NotComputedNode );
        
    else
        
        attr := attr( object );
        
        if attr = false then
            
            SetFilterObj( node_to_be_checked, FalseNode );
            
        else
            
            for i in node_to_be_checked!.sucessors do
                
                MarkAsImplied( i, node_to_be_checked );
                
            od;
            
        fi;
        
    fi;
    
end );

##
InstallMethod( MarkPrintingNode,
               [ IsObject, IsAttributeDependencyGraphForPrintingWithFunctionNodeRep, IsAttributeDependencyGraphForPrintingNode, IsInt ],
               
  function( object, node_to_be_checked, previous_node, marking_level )
    local attr, i, node_level, compute_level;
    
    attr := node_to_be_checked!.Conditions;
    
    node_level := node_to_be_checked!.TypeOfView;
    
    if node_level > marking_level then
        
        SetFilterObj( node_to_be_checked, NodeOfHighLevel );
        
    fi;
    
    attr := attr( object );
    
    if attr = fail then
        
        SetFilterObj( node_to_be_checked, NotComputedNode );
        
    elif attr = false then
        
        SetFilterObj( node_to_be_checked, FalseNode );
        
    else
        
        for i in node_to_be_checked!.sucessors do
            
            MarkAsImplied( i, node_to_be_checked );
            
        od;
        
    fi;
    
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
        
        MarkAsImplied( conjunction_node!.sucessor, previous_node );
        
    fi;
    
end );

##
InstallMethod( MarkAsImplied,
               [ IsAttributeDependencyGraphForPrintingNode, IsAttributeDependencyGraphForPrintingNode ],
               
  function( node, previous_node )
    local i;
    
    SetFilterObj( node, ImpliedNode );
    
    for i in node!.sucessors do
        
        MarkAsImplied( i, node );
        
    od;
    
end );

InstallMethod( MarkGraphForPrinting,
               [ IsAttributeDependencyGraphForPrinting, IsObject, IsInt ],
               
  function( graph, object, marking_level )
    local i;
    
    for i in graph!.list_of_nodes do
        
        MarkPrintingNode( object, i, marking_level );
        
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
    
    ResetFilterObj( node, FalseNode );
    
    ResetFilterObj( node, NotComputedNode );
    
    ResetFilterObj( node, NodeOfHighLevel );
    
    ResetFilterObj( node, ImpliedNode );
    
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
                       
  function( obj, node, print_level )
    local attr, value, return_list;
    
    if IsAttributeDependencyGraphForPrintingWithFunctionNodeRep( node ) then
        
        attr := node!.Conditions;
        
    elif IsAttributeDependencyGraphForPrintingNodeRep( node ) then
        
        attr := ValueGlobal( node!.Conditions );
        
    fi;
    
    if NodeOfHighLevel( node ) then
        
        return [ "level_too_high", fail ];
        
    fi;
    
    if NotComputedNode( node ) then
        
        return [ "notcomputed", fail ];
        
    fi;
    
    if ImpliedNode( node ) and print_level <= 2 then
        
        return [ "implied_node", fail ];
        
    fi;
    
    value := attr( obj );
    
    if value = true or value = false then
        
        return_list := [ "property", value ];
        
    else
        
        return_list := [ "attribute", value ];
        
    fi;
    
    if IsFunction( node!.PrintString ) then
        
        Add( return_list, node!.PrintString( obj ) );
        
    else
        
        Add( return_list, node!.PrintString );
        
    fi;
    
    return return_list;
    
end );

##
InstallGlobalFunction( OBJECT_PRINT_STRING,
                       
  function( graph, object )
    
    if IsBound( graph!.general_object_description )  then
        
        if IsString( graph!.general_object_description ) then
            
            return graph!.general_object_description;
            
        elif IsFunction( graph!.general_object_description ) then
            
            return graph!.general_object_description( object );
            
        fi;
        
    elif HasName( object ) then
        
        return Name( object );
        
    elif Length( NamesFilter( graph!.object_filter ) ) > 0 then
        
        return NamesFilter( graph!.object_filter )[ 1 ];
        
    fi;
    
    return "object";
    
end );

##
InstallGlobalFunction( BUILD_PRINTING_FOR_VIEW_AND_DISPLAY,
                       
  function( object, graph, level, separation_string )
    local string_list, print_string, current_node, current_type, list_of_current_nodes, list_of_current_nodes_nr, lists_list, current_sep_string, current_printing_list,
          current_type_number;
    
    if IsString( separation_string ) then
        
        separation_string := [ separation_string, separation_string ];
        
    fi;
    
    string_list := [ "", "" ];
    
    lists_list := [ graph!.list_of_pre_object_nodes, graph!.list_of_post_object_nodes ];
    
    for list_of_current_nodes_nr in [ 1, 2 ] do
        
        current_sep_string := separation_string[ list_of_current_nodes_nr ];
        
        list_of_current_nodes := lists_list[ list_of_current_nodes_nr ];
        
        print_string := string_list[ list_of_current_nodes_nr ];
        
        current_printing_list := [ ];
        
        for current_node in list_of_current_nodes do
            
            if NodeOfHighLevel( current_node )
              or ImpliedNode( current_node )
              or FalseNode( current_node )
              or NotComputedNode( current_node ) then
                
                continue;
                
            fi;
            
            current_type := DECIDE_TYPE_OF_PRINTING( object, current_node, level );
            
            Add( current_type, current_node!.NoSepString );
            
            Add( current_printing_list, current_type );
            
        od;
        
        current_printing_list := Filtered( current_printing_list, i -> i[ 1 ] = "attribute" or ( i[ 1 ] = "property" and i[ 2 ] = true ) );
        
        Sort( current_printing_list, function( i, j ) if i[ 4 ] = true and j[ 4 ] = false then return false; fi; return true; end );
        
        for current_type_number in [ 1 .. Length( current_printing_list ) ] do
            
            current_type := current_printing_list[ current_type_number ];
            
            if current_type[ 1 ] = "property" and current_type[ 2 ] = true then
                
                Append( print_string, current_type[ 3 ] );
                
                if current_type[ 4 ] = false then
                    Append( print_string, current_sep_string );
                elif current_type[ 4 ] = true and not current_type_number = Length( current_printing_list ) then
                    Append( print_string, "-" );
                    Append( print_string, current_sep_string );
                fi;
                
            elif current_type[ 2 ] = "attribute" then
                
                Append( print_string, current_type[ 3 ] );
                
                Append( print_string, ": " );
                
                Append( print_string, String( current_type[ 2 ] ) );
                
                Append( print_string, current_sep_string );
                
            fi;
            
        od;
        
        if  print_string <> "" and current_printing_list[ Length( current_printing_list ) ][ 4 ] = false then
            
            string_list[ list_of_current_nodes_nr ] := print_string{[ 1 .. Length( print_string ) - Length( current_sep_string ) ]};
            Append( string_list[ list_of_current_nodes_nr ], " " );
            
        fi;

        
    od;
    
    return string_list;
    
end );

InstallMethod( StringMarkedGraphForStringMutable,
               [ IsObject, IsAttributeDependencyGraphForPrinting ],
               
  function( object, graph )
    local current_node, current_type, print_string, string_to_start_with, obj_description, string;
    
    print_string := BUILD_PRINTING_FOR_VIEW_AND_DISPLAY( object, graph, 1, ", " );
    
    string_to_start_with := print_string[ 1 ];
    
    obj_description := OBJECT_PRINT_STRING( graph, object );
    
    string_to_start_with := Concatenation( string_to_start_with, obj_description );
    
    NormalizeWhitespace( string_to_start_with );
    
    if LowercaseString( string_to_start_with )[ 1 ] in [ 'a', 'e', 'i', 'o', 'u' ] then
        
        string_to_start_with := Concatenation( "An ", string_to_start_with );
        
    else
        
        string_to_start_with := Concatenation( "A ", string_to_start_with );
        
    fi;
    
    string :=  "";
    
    Append( string, string_to_start_with );
    
    if print_string[ 2 ] <> "" then
        
        Append( string, " which has the following properties: " );
        
        Append( string, print_string[ 2 ] );
        
    fi;
    
    return string;
    
end );

##
InstallMethod( PrintMarkedGraphForViewObj,
               [ IsObject, IsAttributeDependencyGraphForPrinting ],
               
  function( object, graph )
    
    Print( "<", StringMarkedGraphForStringMutable( object, graph ), ">" );
    
end );

##
InstallMethod( PrintMarkedGraphForDisplay,
               [ IsObject, IsAttributeDependencyGraphForPrinting ],
               
    function( object, graph )
    local current_node, current_type, print_string, string_to_start_with, obj_description;
    
    print_string := BUILD_PRINTING_FOR_VIEW_AND_DISPLAY( object, graph, 2, [ ", ", ",\n" ] );
    
    string_to_start_with := print_string[ 1 ];
    
    obj_description := OBJECT_PRINT_STRING( graph, object );
    
    string_to_start_with := JoinStringsWithSeparator( [ string_to_start_with, obj_description ], " " );
    
    NormalizeWhitespace( string_to_start_with );
    
    if LowercaseString( string_to_start_with )[ 1 ] in [ 'a', 'e', 'i', 'o', 'u' ] then
        
        string_to_start_with := Concatenation( "An ", string_to_start_with );
        
    else
        
        string_to_start_with := Concatenation( "A ", string_to_start_with );
        
    fi;
    
    Print( string_to_start_with );
    
    if print_string[ 2 ] <> "" then
        
        Print( " which has the following properties:\n" );
        
        Print( print_string[ 2 ] );
        
    fi;
    
    Print( ".\n" );
    
end );

##
InstallMethod( PrintMarkedGraphFull,
               [ IsObject, IsAttributeDependencyGraphForPrinting ],
               
  function( object, graph )
    local print_string, current_node, current_type;
    
    Print( "Full description:\n" );
    
    Print( OBJECT_PRINT_STRING( graph, object ) );
    
    Print( "\n" );
    
    print_string := "";
    
    for current_node in graph!.list_of_nodes do
        
        current_type := DECIDE_TYPE_OF_PRINTING( object, current_node, 3 );
        
        if current_type[ 1 ] = "level_too_high" then
            
            continue;
            
        fi;
        
        Append( print_string, "- " );
        
        if IsFunction( current_node!.PrintString ) then
            
            Append( print_string, ReplacedString( current_node!.PrintString( object ), "\n", "\n  " ) );
            
        else
            
            Append( print_string, current_node!.PrintString );
            
            Append( print_string, ": " );
            
            if current_type[ 1 ] = "notcomputed" then
                
                Append( print_string, "not computed yet" );
                
            else
                
                current_type := ReplacedString( String( current_type[ 2 ] ), "\n", Concatenation( "\n", ListWithIdenticalEntries( Length( current_node!.PrintString ) + 5, ' ' ) ) );
                
                Append( print_string, current_type );
                
            fi;
            
        fi;
        
        Append( print_string, "\n" );
        
    od;
    
    Print( print_string );
    
end );

##
InstallMethod( PrintMarkedGraphFullWithEverythingComputed,
               [ IsObject, IsAttributeDependencyGraphForPrinting ],
               
  function( object, graph )
    local print_string, current_node, current_type, general_object_description;
    
    Print( "Full description:\n" );
    
    Print( OBJECT_PRINT_STRING( graph, object ) );
    
    Print( "\n" );
    
    print_string := "";
    
    for current_node in graph!.list_of_nodes do
        
        current_type := DECIDE_TYPE_OF_PRINTING( object, current_node, 4 );
        
        if current_type[ 1 ] = "level_too_high" then
            
            continue;
            
        fi;
        
        Append( print_string, "- " );
        
        if IsFunction( current_node!.PrintString ) then
            
            Append( print_string, ReplacedString( current_node!.PrintString( object ), "\n", "\n  " ) );
            
        else
            
            Append( print_string, current_node!.PrintString );
            
            Append( print_string, ": " );
            
            current_type := ReplacedString( String( current_type[ 2 ] ), "\n", Concatenation( "\n", ListWithIdenticalEntries( Length( current_node!.PrintString ) + 5, ' ' ) ) );
            
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
    
    InstallPrintFunctionsOutOfPrintingGraph( graph, 0 );
    
end );

InstallMethod( InstallPrintFunctionsOutOfPrintingGraph,
               [ IsAttributeDependencyGraphForPrinting, IsInt ],
               
  function( graph, rank )
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
    
    InstallMethod( StringMutable,
                   [ filter ],
                   rank,
                   
      function( obj )
        local string;
        
        MarkGraphForPrinting( graph, obj, 1 );
        
        string := StringMarkedGraphForStringMutable( obj, graph );
        
        ResetGraph( graph );
        
        return string;
        
    end );
    
    if install_view_obj = true then
        
        InstallMethod( ViewObj,
                       [ filter ],
                       rank,
                       
          function( obj )
              
              MarkGraphForPrinting( graph, obj, 1 );
              
              PrintMarkedGraphForViewObj( obj, graph );
              
              ResetGraph( graph );
              
        end );
        
    fi;
    
    if install_display = true then
        
        InstallMethod( Display,
                       [ filter ],
                       rank,
                       
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
