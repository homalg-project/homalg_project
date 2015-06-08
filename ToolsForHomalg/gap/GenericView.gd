#############################################################################
##
##                                                     ToolsForHomalg package
##
##  Copyright 2014, Sebastian Gutsche, University of Kaiserslautern
##
#! @Chapter Dependency and printing graph.
##
#############################################################################

##################################
##
#! @Section Dependency graph for attributes
##
##################################

DeclareCategory( "IsAttributeDependencyGraphForPrinting",
                 IsObject );

DeclareCategory( "IsAttributeDependencyGraphForPrintingNode",
                 IsObject );

##################################
##
#! @Section Filters
##
##################################

DeclareFilter( "NotComputedNode" );

DeclareFilter( "FalseNode" );

DeclareFilter( "ImpliedNode" );

DeclareFilter( "NodeOfHighLevel" );

##################################
##
#! @Section Constructors
##
##################################

DeclareGlobalFunction( "TOOLS_FOR_HOMALG_CREATE_NODE_INPUT" );

DeclareOperation( "CreateNode",
                  [ IsRecord ] );

DeclareOperation( "CreateConjunctionNode",
                  [ IsList, IsAttributeDependencyGraphForPrintingNode ] );

## FIXME: This should be a filter. But there is no filter for filters? IsFilter is not a filter. WTF?
DeclareOperation( "CreatePrintingGraph",
                  [ IsOperation, IsObject ] );

DeclareOperation( "CreatePrintingGraph",
                  [ IsOperation ] );

##################################
##
#! @Section Setters
##
##################################

DeclareOperation( "AddNodeToGraph",
                  [ IsAttributeDependencyGraphForPrinting, IsRecord ] );

DeclareOperation( "AddRelationToGraph",
                  [ IsAttributeDependencyGraphForPrinting, IsRecord ] );

##################################
##
#! @Section Getters
##
##################################

DeclareOperation( "GetNodeByName",
                  [ IsAttributeDependencyGraphForPrinting, IsString ] );

DeclareOperation( "GetNodeByName",
                  [ IsAttributeDependencyGraphForPrinting, IsAttributeDependencyGraphForPrintingNode ] );

##################################
##
#! @Section Testers
##
##################################

DeclareOperation( "MarkPrintingNode",
                  [ IsObject, IsAttributeDependencyGraphForPrintingNode, IsInt ] );

DeclareOperation( "MarkPrintingNode",
                  [ IsObject, IsAttributeDependencyGraphForPrintingNode, IsAttributeDependencyGraphForPrintingNode, IsInt ] );

DeclareOperation( "MarkAsImplied",
                  [ IsAttributeDependencyGraphForPrintingNode ] );

DeclareOperation( "MarkAsImplied",
                  [ IsAttributeDependencyGraphForPrintingNode, IsAttributeDependencyGraphForPrintingNode ] );

DeclareOperation( "MarkGraphForPrinting",
                  [ IsAttributeDependencyGraphForPrinting, IsObject, IsInt ] );

##################################
##
#! @Section Reseters
##
##################################

DeclareGlobalFunction( "RESET_ALL_POSSIBLE_FILTERS_FOR_DEPENDENCY_GRAPH" );

DeclareOperation( "ResetGraph",
                  [ IsAttributeDependencyGraphForPrinting ] );

##################################
##
#! @Section Printers
##
##################################

DeclareGlobalFunction( "DECIDE_TYPE_OF_PRINTING" );

DeclareGlobalFunction( "BUILD_PRINTING_FOR_VIEW_AND_DISPLAY" );

DeclareGlobalFunction( "OBJECT_PRINT_STRING" );

DeclareOperation( "PrintMarkedGraphForViewObj",
                  [ IsObject, IsAttributeDependencyGraphForPrinting ] );

DeclareOperation( "PrintMarkedGraphForDisplay",
                  [ IsObject, IsAttributeDependencyGraphForPrinting ] );

DeclareOperation( "PrintMarkedGraphFull",
                  [ IsObject, IsAttributeDependencyGraphForPrinting ] );

DeclareOperation( "PrintMarkedGraphFullWithEverythingComputed",
                  [ IsObject, IsAttributeDependencyGraphForPrinting ] );

##################################
##
#! @Section Installers
##
##################################

DeclareOperation( "FullView",
                  [ IsObject ] );

DeclareOperation( "FullViewWithEverythingComputed",
                  [ IsObject ] );

DeclareOperation( "InstallPrintFunctionsOutOfPrintingGraph",
                  [ IsAttributeDependencyGraphForPrinting ] );

