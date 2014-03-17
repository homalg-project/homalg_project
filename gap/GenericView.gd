#############################################################################
##
##                                                     ToolsForHomalg package
##
##  Copyright 2014, Sebastian Gutsche, University of Kaiserslautern
##
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

DeclareFilter( "NotPrintBecauseImplied" );

DeclareFilter( "NotPrintBecauseFalse" );

DeclareFilter( "NotPrintBecauseNotComputedYet" );

DeclareFilter( "NotPrintedBecauseOfHighLevel" );

DeclareFilter( "AlreadyChecked" );

InstallTrueMethod( AlreadyChecked, NotPrintBecauseFalse );

InstallTrueMethod( AlreadyChecked, NotPrintBecauseImplied );

InstallTrueMethod( AlreadyChecked, NotPrintBecauseNotComputedYet );

InstallTrueMethod( AlreadyChecked, NotPrintedBecauseOfHighLevel );

##################################
##
#! @Section Constructors
##
##################################

DeclareOperation( "CreateNode",
                  [ IsString, IsString, IsString, IsString ] );

DeclareOperation( "CreateConjunctionNode",
                  [ ] );

## FIXME: This should be a filter. But there is no filter for filters? IsFilter is not a filter. WTF?
DeclareOperation( "CreatePrintingGraph",
                  [ IsOperation, IsString ] );

DeclareOperation( "CreatePrintingGraph",
                  [ IsOperation ] );

##################################
##
#! @Section Setters
##
##################################

DeclareOperation( "AddNodeToPrintingGraph",
                  [ IsAttributeDependencyGraphForPrinting, IsList ] );

DeclareOperation( "AddConjunctionToGraph",
                  [ IsAttributeDependencyGraphForPrinting, IsList, IsList ] );

DeclareOperation( "AddRelationToGraph",
                  [ IsAttributeDependencyGraphForPrinting, IsList ] );

##################################
##
#! @Section Getters
##
##################################

DeclareOperation( "NodeWithNameInGraph",
                  [ IsAttributeDependencyGraphForPrinting, IsString ] );

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

