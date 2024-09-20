# SPDX-License-Identifier: GPL-2.0-or-later
# ToolsForHomalg: Special methods and knowledge propagation tools
#
# Declarations
#

#! @Chapter Basics

#! @Section Global variables

# our info classes:
DeclareInfoClass( "InfoToolsForHomalg" );
SetInfoLevel( InfoToolsForHomalg, 1 );

DeclareInfoClass( "InfoHomalgBasicOperations" );
SetInfoLevel( InfoHomalgBasicOperations, 1 );

# a central place for configurations:
#! @Description 
#! A central place for configurations.
DeclareGlobalVariable( "HOMALG_TOOLS" );

####################################
#
# categories:
#
####################################

# three new categories:

#! @Section GAP Categories

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
# attributes:
#
####################################

#! @Section Attributes

#! @Description
#! A filter inheriting from `IsRing` which uniquely identifies the ring <A>ring</A>.
#! For example, the ring `Integers` is identified by `IsIntegers`.
#! If no filter uniquely identifying the ring exists,
#! the most special filter available should be chosen.
#! @Arguments ring
DeclareAttribute( "RingFilter",
                  IsRing );

#! @Description
#! A filter inheriting from `IsRingElement` which uniquely identifies elements of the ring <A>ring</A>.
#! For example, the elements of the ring `Integers` are identified by `IsInt`.
#! If no filter uniquely identifying the elements of the ring exists,
#! the most special filter available should be chosen.
#! @Arguments ring
DeclareAttribute( "RingElementFilter",
                  IsRing );

SetRingFilter( Integers, IsIntegers );
SetRingElementFilter( Integers, IsInt );

SetRingFilter( Rationals, IsRationals );
SetRingElementFilter( Rationals, IsRat );

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
DeclareGlobalFunction( "homalgTotalRuntimes" );

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
#! @ChapterInfo Tools, Example functions
DeclareOperation( "ExamplesForHomalg",
                  [ ] );

#! @Description
#!  Runs the named example for homalg
#! @Returns <C>true</C> or <C>false</C>
#! @ChapterInfo Tools, Example functions
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

#! @Description
#!  Return the position of the object identical to <A>o</A> in the list <A>L</A>
#! @Arguments L, o
#! @Returns a positive integer or fail
DeclareOperation( "IdenticalPosition",
        [ IsList, IsObject ] );

DeclareOperation( "AppendNew",
        [ IsList, IsList ] );

#! @Description
#!  Return the list of positions of maximal objects in <A>L</A>
#!  w.r.t. the partial order defined by the binary function <A>f</A>.
#! @Arguments L, f
#! @Returns a list
DeclareOperation( "PositionsOfMaximalObjects",
        [ IsList, IsFunction ] );

#! @Description
#!  Return the sublist of maximal objects in <A>L</A>
#!  w.r.t. the partial order defined by the binary function <A>f</A>.
#! @Arguments L, f
#! @Returns a list
DeclareOperation( "MaximalObjects",
        [ IsList, IsFunction ] );

DeclareGlobalFunction( "ExecForHomalg" );

DeclareOperation( "ShaSum",
        [ IsString ] );

DeclareGlobalFunction( "GetTimeOfDay" );

DeclareGlobalFunction( "CallFuncListWithTime" );
DeclareGlobalFunction( "CallFuncListWithUserTime" );

#! @Description
#!  returns  a new list that contains for each element <A>elm</A> of the list <A>list</A> a list of length two,
#!  the first element of this is <A>elm</A> itself and the second element is the number of times <A>elm</A>
#!  appears in list until the next different element. The default comparing function is <C>\=</C>, which can be
#!  changed by passing an optional value to <A>ComparingFunction</A>.
#! @Arguments list
#! @Returns a list
DeclareGlobalFunction( "CollectEntries" );

DeclareGlobalFunction( "DotToSVG" );

DeclareGlobalFunction( "WriteFileForHomalg" );

DeclareGlobalFunction( "ReadFileForHomalg" );

DeclareGlobalFunction( "ReplacedStringForHomalg" );

DeclareGlobalFunction( "ReplacedFileForHomalg" );

DeclareGlobalFunction( "EvalReplacedFileForHomalg" );

DeclareGlobalFunction( "WriteReplacedFileForHomalg" );

DeclareGlobalFunction( "WriteFileInPackageForHomalg" );

DeclareGlobalFunction( "IsExistingFileInPackageForHomalg" );

DeclareGlobalFunction( "ReadFileFromPackageForHomalg" );

##
DeclareOperation( "IsShowable",
        [ IsString, IsObject ] );

#! @Description
#!  Installs a method for `IsShowable` such that
#!  `IsShowable( mime_type, object )` returns `true` for any
#!  `mime_type` in the list <A>mime_types</A> and `object` in the filter <A>filter</A>.
#! @Arguments mime_types, filter
DeclareGlobalFunction( "MakeShowable" );

#! @Description
#!  Installs a method for `IsShowable` such that
#!  `IsShowable( "text/latex", object )` and `IsShowable( "application/x-latex", object )` return `true`
#!  for an `object` in the filter <A>filter</A>.
#! @Arguments filter
DeclareGlobalFunction( "MakeShowableWithLaTeX" );

DeclareGlobalFunction( "FillWithCharacterAfterDecimalNumber" );

#! @Description
#!   Searches for the keys of <A>record</A> in <A>string</A> and replaces them by their values.
#!   The values can be strings or lists of strings. In the second case, the search term must be followed by `...`
#!   and the replacement string is formed by joining the entries of the list with the separator `", "`.
#! @Arguments string, record
DeclareGlobalFunction( "ReplacedStringViaRecord" );

#! @Description
#!   (Re-)Starts a timer with the given name.
#! @Arguments name
DeclareGlobalFunction( "StartTimer" );

#! @Description
#!   Stops a timer with the given name.
#! @Arguments name
DeclareGlobalFunction( "StopTimer" );

#! @Description
#!   Resets a timer with the given name.
#! @Arguments name
DeclareGlobalFunction( "ResetTimer" );

#! @Description
#!   Displays the current value of the timer with the given name.
#! @Arguments name
DeclareGlobalFunction( "DisplayTimer" );

#! @Description
#!   The input is a filter <A>filt</A>.
#!   The output is the list of all filters implied by <A>filt</A>, including <A>filt</A> itself.
#! @Arguments filt
DeclareGlobalFunction( "ListImpliedFilters" );

#! @Description
#!   If only a string <A>name</A> is given, displays an incrementing number every time a breakpoint with this name is visited.
#!   If additionally an integer <A>break_at</A> is given, enters a break-loop if the breakpoint has been visited the specified number of times.
#!   If a function <A>break_function</A> is given, it is executed before entering the break-loop.
#! @Arguments name[, break_at[, break_function]]
DeclareGlobalFunction( "Breakpoint" );

#! @Description
#!   Like <C>ReadPackage</C> but reads the file only once in the runnig GAP session.
#! @Arguments name
DeclareGlobalFunction( "ReadPackageOnce" );
