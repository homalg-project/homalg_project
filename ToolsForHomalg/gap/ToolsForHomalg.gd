#############################################################################
##
##  ToolsForHomalg.gd                                 ToolsForHomalg package
##
##  Copyright 2007-2012, Mohamed Barakat, University of Kaiserslautern
##                       Sebastian Gutsche, RWTH-Aachen University
##                  Markus Lange-Hegermann, RWTH-Aachen University
##
##  Declarations for ToolsForHomalg.
##
#############################################################################


# our info classes:
DeclareInfoClass( "InfoToolsForHomalg" );
SetInfoLevel( InfoToolsForHomalg, 1 );

DeclareInfoClass( "InfoHomalgBasicOperations" );
SetInfoLevel( InfoHomalgBasicOperations, 1 );

# a central place for configurations:
#! @Description 
#! A central place for configurations.
#! ChapterInfo Basics, Variables
DeclareGlobalVariable( "HOMALG_TOOLS" );

####################################
#
# categories:
#
####################################

# three new categories:

#! @Chapter Basics
#! @Section Categories

#! @Description
#! This is the super super GAP-category which will
#! include the GAP-categories IsStructureObjectOrObject and IsHomalgObjectOrMorphism
DeclareCategory( "IsStructureObjectOrObjectOrMorphism",
                 IsAttributeStoringRep );

#! @Description
#! This is the super GAP-category which will include the GAP-categories
#! IsHomalgRing, IsHomalgModule, IsHomalgRingOrModule and IsHomalgComplex
DeclareCategory( "IsStructureObjectOrObject",
                 IsStructureObjectOrObjectOrMorphism );

#! @Description
#! This is the super GAP-category which will include the GAP-categories IsHomalgRing
#! we need this GAP-category to define things like Hom(M,R) as easy as Hom(M,N)
#! without distinguishing between structure objects (e.g. rings) and objects (e.g. modules)
DeclareCategory( "IsStructureObject",
                 IsStructureObjectOrObject );


#! @Description
#! This is the super GAP-category which will include the GAP-categories
#! IsHomalgRingMap, etc.
DeclareCategory( "IsStructureObjectMorphism",
                 IsAttributeStoringRep );

#! @Description
#! this is the super GAP-category which will include the GAP-categories
#! IsHomalgRing, IsHomalgModule:
DeclareCategory( "IsHomalgRingOrModule",
                 IsStructureObjectOrObject );

# a new GAP-category:

#! @Description 
#!  The category for weak pointer objects
#! @ChapterInfo Pointers, Weak_pointer_objects
DeclareCategory( "IsContainerForWeakPointers",
                 IsComponentObjectRep );

#! @Description
#!  The category for pointer objects
#! @ChapterInfo Pointers, Pointer_objects
DeclareCategory( "IsContainerForPointers",
                 IsComponentObjectRep );

####################################
#
# global functions and operations:
#
####################################

#! @Description
#!  The constructor for lists of weak pointers.
#! @Returns a list which can store weak pointers
#! @ChapterInfo Pointers, Weak pointer objects
DeclareGlobalFunction( "ContainerForWeakPointers" );

#! @Chapter Tools
#! @Section Functions

#! @Description
#!  A tool to compute the runtime of several methods.
#! @Returns an integer
DeclareGlobalFunction( "homalgTotalRuntimes",
                       "an integer" );

#! @Description
#!  A tool to install equivalence between filters.
#! @Returns 
#! @ChapterInfo Tools, Functions
DeclareGlobalFunction( "AddLeftRightLogicalImplicationsForHomalg" );

#! @Description
#!  Installs a logical implication for one type with all it's contrapositions.
#! @Returns 
#! @ChapterInfo Tools, Functions
DeclareGlobalFunction( "LogicalImplicationsForOneHomalgObject" );

#! @Description
#!  
#! @Returns 
#! @ChapterInfo Tools, Functions
DeclareGlobalFunction( "LogicalImplicationsForTwoHomalgBasicObjects" );

#! @Description
#!  
#! @Returns 
#! @ChapterInfo Tools, Functions
DeclareGlobalFunction( "InstallLogicalImplicationsForHomalgBasicObjects" );

#! @Description
#!  
#! @Returns 
#! @ChapterInfo Tools, Functions
DeclareGlobalFunction( "LeftRightAttributesForHomalg" );

#! @Description
#!  
#! @Returns 
#! @ChapterInfo Tools, Functions
DeclareGlobalFunction( "InstallLeftRightAttributesForHomalg" );

#! @Description
#!  A method to match the properties and attributes of two objects.
#! @Returns 
#! @ChapterInfo Tools, Functions
DeclareGlobalFunction( "MatchPropertiesAndAttributes" );

#! @Description
#!  Installs methods to pull new known properties and attributes from one object to another
#! @Returns 
#! @ChapterInfo Tools, Functions
DeclareGlobalFunction( "InstallImmediateMethodToPullPropertyOrAttribute" );

#! @Description
#!  Installs methods to pull new known properties and attributes under certain conditions from one object to another.
#! @Returns 
#! @ChapterInfo Tools, Functions
DeclareGlobalFunction( "InstallImmediateMethodToConditionallyPullPropertyOrAttribute" );

#! @Description
#!  Installs an immediate method which can pull a property from one object to another with different names.
#! @Returns 
#! @ChapterInfo Tools, Functions
DeclareGlobalFunction( "InstallImmediateMethodToPullPropertyOrAttributeWithDifferentName" );

#! @Description
#!  Installs an immediate method to pull several properties or attributes from one object to another.
#! @Returns 
#! @ChapterInfo Tools, Functions
DeclareGlobalFunction( "InstallImmediateMethodToPullPropertiesOrAttributes" );

#! @Description
#!  Installs an immediate method to pull a property if it is true.
#! @Returns 
#! @ChapterInfo Tools, Functions
DeclareGlobalFunction( "InstallImmediateMethodToPullTrueProperty" );

#! @Description
#!  Installs an immediate method which conditionally pulls a property if it is true.
#! @Returns 
#! @ChapterInfo Tools, Functions
DeclareGlobalFunction( "InstallImmediateMethodToConditionallyPullTrueProperty" );

#! @Description
#!  Installs an immediate method which pulls a property with a different name if it is true.
#! @Returns 
#! @ChapterInfo Tools, Functions
DeclareGlobalFunction( "InstallImmediateMethodToPullTruePropertyWithDifferentName" );

#! @Description
#!  Installs an immediate method which pulls several properties if they are true
#! @Returns 
#! @ChapterInfo Tools, Functions
DeclareGlobalFunction( "InstallImmediateMethodToPullTrueProperties" );

#! @Description
#!  Installs an immediate method to pull a property if it is false.
#! @Returns 
#! @ChapterInfo Tools, Functions
DeclareGlobalFunction( "InstallImmediateMethodToPullFalseProperty" );

#! @Description
#!  Installs an immediate method which conditionally pulls a property if it is false.
#! @Returns 
#! @ChapterInfo Tools, Functions
DeclareGlobalFunction( "InstallImmediateMethodToConditionallyPullFalseProperty" );

#! @Description
#!  Installs an immediate method which pulls a property with a different name if it is false.
#! @Returns 
#! @ChapterInfo Tools, Functions
DeclareGlobalFunction( "InstallImmediateMethodToPullFalsePropertyWithDifferentName" );

#! @Description
#!  Installs an immediate method which pulls several properties if they are false.
#! @Returns 
#! @ChapterInfo Tools, Functions
DeclareGlobalFunction( "InstallImmediateMethodToPullFalseProperties" );

#! @Description
#!  Installs an immediate method to push a property from one object to another.
#! @Returns 
#! @ChapterInfo Tools, Functions
DeclareGlobalFunction( "InstallImmediateMethodToPushPropertyOrAttribute" );

#! @Description
#!  Installs an immediate method to conditionally push a property from one object to another.
#! @Returns 
#! @ChapterInfo Tools, Functions
DeclareGlobalFunction( "InstallImmediateMethodToConditionallyPushPropertyOrAttribute" );

#! @Description
#!  Installs an immediate method which can push a property from one object to another with different names.
#! @Returns 
#! @ChapterInfo Tools, Functions
DeclareGlobalFunction( "InstallImmediateMethodToPushPropertyOrAttributeWithDifferentName" );

#! @Description
#!  Installs an immediate method to push several properties or attributes from one object to another.
#! @Returns 
#! @ChapterInfo Tools, Functions
DeclareGlobalFunction( "InstallImmediateMethodToPushPropertiesOrAttributes" );

#! @Description
#!  Installs an immediate method to push a property if it is true.
#! @Returns 
#! @ChapterInfo Tools, Functions
DeclareGlobalFunction( "InstallImmediateMethodToPushTrueProperty" );

#! @Description
#!  Installs an immediate method which pushes a property with a different name if it is true.
#! @Returns 
#! @ChapterInfo Tools, Functions
DeclareGlobalFunction( "InstallImmediateMethodToPushTruePropertyWithDifferentName" );

#! @Description
#!  Installs an immediate method which pushes several properties if they are true
#! @Returns 
#! @ChapterInfo Tools, Functions
DeclareGlobalFunction( "InstallImmediateMethodToPushTrueProperties" );

#! @Description
#!  Installs an immediate method to push a property if it is false.
#! @Returns 
#! @ChapterInfo Tools, Functions
DeclareGlobalFunction( "InstallImmediateMethodToPushFalseProperty" );

#! @Description
#!  Installs an immediate method which pushes a property with a different name if it is false.
#! @Returns 
#! @ChapterInfo Tools, Functions
DeclareGlobalFunction( "InstallImmediateMethodToPushFalsePropertyWithDifferentName" );

#! @Description
#!  Installs an immediate method which push several properties if they are false.
#! @Returns 
#! @ChapterInfo Tools, Functions
DeclareGlobalFunction( "InstallImmediateMethodToPushFalseProperties" );

#! @Description
#!  Installs an attribute with a coustom getter function.
#! @Returns 
#! @ChapterInfo Tools, Functions
DeclareGlobalFunction( "DeclareAttributeWithCustomGetter" );

#! @Description
#!  Appends an entry to a homalg table.
#! @Returns 
#! @ChapterInfo Tools, Functions
DeclareGlobalFunction( "AppendToAhomalgTable" );

#! @Description
#!  Creates a list of integers out of the names of components.
#! @Returns a list of integers
#! @ChapterInfo Tools, Functions
DeclareGlobalFunction( "homalgNamesOfComponentsToIntLists" );

#! @Description
#!  Increases an existing counter in an object.
#! @Returns 
#! @ChapterInfo Tools, Functions
DeclareGlobalFunction( "IncreaseExistingCounterInObject" );

#! @Description
#!  Increases an existiing counter on an object with timing.
#! @Returns 
#! @ChapterInfo Tools, Functions
DeclareGlobalFunction( "IncreaseExistingCounterInObjectWithTiming" );

#! @Description
#!  Increases a counter in an object and creates one if it not exists
#! @Returns 
#! @ChapterInfo Tools, Functions
DeclareGlobalFunction( "IncreaseCounterInObject" );

#! @Description
#!  Converts the current memory state to a string
#! @Returns 
#! @ChapterInfo Tools, Functions
DeclareGlobalFunction( "MemoryToString" );

#! @Description
#!  Returns the <A>p</A>-exponent of the integer <A>n</A>, where <A>p</A> is a rational prime.
#! @Arguments n, p
#! @Returns A nonnegative integer
#! @ChapterInfo Tools, Functions
DeclareGlobalFunction( "PrimePowerExponent" );

#! @Description
#!  Apply ViewObj to the list <A>L</A>.
#! @Arguments L
#! @Returns nothing
#! @ChapterInfo Tools, Functions
DeclareOperation( "ViewList",
        [ IsList ] );

# basic operations:

#! @Description
#!  
#! @Returns 
#! @ChapterInfo Tools, Functions
DeclareOperation( "homalgLaTeX",
                  [ IsObject ] );

#! @Description
#!  Runs the examples for homalg if the package is loadable.
#! @Returns <C>true</C> or <C>false</C>
#! @ChapterInfo Tools, Examplefunctions
DeclareOperation( "ExamplesForHomalg",
                  [ ] );

#! @Description
#!  Runs the named example for homalg
#! @Returns <C>true</C> or <C>false</C>
#! @ChapterInfo Tools, Examplefunctions
DeclareOperation( "ExamplesForHomalg",
                  [ IsInt ] );

#! @Description
#!  Updates the weak pointers in a container and deletes the empty ones
#! @Returns 
#! @ChapterInfo Pointers, Weak pointer objects
DeclareOperation( "UpdateContainerOfWeakPointers",
                  [ IsContainerForWeakPointers ] );

#! @Description
#!  Adds a weak pointer of an objects to a weak pointer list.
#! @Returns 
#! @ChapterInfo Pointers, Weak pointer objects
DeclareGlobalFunction( "_AddElmWPObj_ForHomalg" );

#! @Description
#!  Adds a weak pointer which depends on two objects to a list of weak pointers
#! @Returns 
#! @ChapterInfo Pointers, Weak pointer objects
DeclareGlobalFunction( "_AddTwoElmWPObj_ForHomalg" );

#! @Description
#!  Creates a weak pointer depending on two objects and adds it to the container.
#! @Returns 
#! @ChapterInfo Pointers, Weak pointer objects
DeclareOperation( "_ElmWPObj_ForHomalg",
                  [ IsContainerForWeakPointers, IsObject, IsObject ] );


DeclareOperation( "Display",
        [ IsContainerForWeakPointers, IsString ] );

# PointerObject Operations

#! @Description
#!  Creates a container for pointers.
#! @Returns a container for pointers
#! @ChapterInfo Pointers, Pointer objects
DeclareGlobalFunction( "ContainerForPointers" );

#! @Description
#!  Updates the container of pointers, removes old.
#! @Returns 
#! @ChapterInfo Pointers, Pointer objects
DeclareOperation( "UpdateContainerOfPointers",
                  [ IsContainerForPointers ] );

#! @Description
#!  Adds a pointer to an object to a container for pointers.
#! @Returns 
#! @ChapterInfo Pointers, Pointer objects
DeclareGlobalFunction( "_AddElmPObj_ForHomalg" );

#! @Description
#!  Adds a pointer to two objects to a container for pointers
#! @Returns 
#! @ChapterInfo Pointers, Pointer objects
DeclareGlobalFunction( "_AddTwoElmPObj_ForHomalg" );

#! @Description
#!  Returns an object which a pointer refers to.
#! @Returns an object
#! @ChapterInfo Pointers, Pointer objects
DeclareOperation( "_ElmPObj_ForHomalg",
                  [ IsContainerForPointers, IsObject, IsObject ] );

DeclareOperation( "PositionOfTheDefaultPresentation",
        [ IsObject ] );

DeclareOperation( "Display",
        [ IsContainerForPointers, IsString ] );

DeclareGlobalFunction( "ExecForHomalg" );

DeclareOperation( "ShaSum",
        [ IsString ] );

DeclareGlobalFunction( "GetTimeOfDay" );

DeclareGlobalFunction( "ReplacedStringForHomalg" );

DeclareGlobalFunction( "ReplacedFileForHomalg" );

DeclareGlobalFunction( "EvalReplacedFileForHomalg" );

DeclareGlobalFunction( "WriteReplacedFileForHomalg" );
