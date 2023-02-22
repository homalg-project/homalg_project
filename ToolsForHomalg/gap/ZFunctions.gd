# SPDX-License-Identifier: GPL-2.0-or-later
# ToolsForHomalg: Special methods and knowledge propagation tools
#
# Declarations
#
#! @Chapter Z-functions

#! @Section Gap categories for Z functions

#! A $\mathbb{Z}$-function is an enumerated collection of objects in which repetitions are allowed
#! and order does matter. The reason behind calling it a $\mathbb{Z}$-function rather than
#! simply a sequence, is to avoid possible conflicts with other packages that use the terms
#! **Sequence** and **IsSequence**.

#! @Description
#!  Gap-categories of $\mathbb{Z}$-functions
DeclareCategory( "IsZFunction", IsObject );

#! @Description
#!  Gap-categories of inductive $\mathbb{Z}$-functions
DeclareCategory( "IsZFunctionWithInductiveSides", IsZFunction );

#! @Section Creating Z-functions

#! @Description
#! The global function has no arguments and the output is an empty $\mathbb{Z}$-function. That means, it can not be evaluated yet.
#! @Arguments func
#! @Returns an integer
DeclareGlobalFunction( "VoidZFunction" );

#! @Description
#! The argument is a function <A>func</A> that can be applied on integers.
#! The output is a $\mathbb{Z}$-function <C>z_func</C>. We call <A>func</A>
#! the <C>UnderlyingFunction</C> of <C>z_func</C>.
#! @Arguments func
#! @Returns a $\mathbb{Z}$-function
DeclareAttribute( "AsZFunction", IsFunction );

#! @Description
#! The argument is a <A>z_func</A>. The output is its <C>UnderlyingFunction</C> function. I.e., the function that will be applied on index <C>i</C>
#! whenever we call <A>z_func</A>[<C>i</C>].
#! @Arguments z_func
#! @Returns a $\mathbb{Z}$-function
DeclareAttribute( "UnderlyingFunction", IsZFunction );

#! @Description
#! The argument is a $\mathbb{Z}$-function <A>z_func</A> and an integer <A>i</A>. The output is
#! <A>z_func</A>[<A>i</A>].
#! @Arguments z_func, i
#! @Returns a Gap object
KeyDependentOperation( "ZFunctionValue", IsZFunction, IsInt, ReturnTrue );

#! @Description
#! The method delegates to <C>ZFunctionValue</C>.
#! @Arguments z_func, i
#! @Returns a Gap object
DeclareOperation( "\[\]", [ IsZFunction, IsInt ] );


#! @Description
#! The arguments are an integer <A>n</A>, a Gap object <A>val_n</A>, a function <A>lower_func</A>, a function <A>upper_func</A> and a function <A>compare_func</A>.
#! The output is the $\mathbb{Z}$-function <C>z_func</C> defined as follows:
#! <C>z_func</C>[<C>i</C>]
#! is equal to <A>lower_func</A>(<C>z_func</C>[<C>i+1</C>]) if <C>i</C><C>&lt;</C><A>n</A>;
#! and is equal to <A>val_n</A> if <C>i</C>=<A>n</A>;
#! and is equal to <A>upper_func</A>(<C>z_func</C>[<C>i-1</C>]) otherwise.
#! At each call, the method compares the computed value to the previous or next value via the function
#! <A>compare_func</A>; and 
#! in the affermative case, the method sets a upper or lower stable values.
#! @Arguments n, val_n, lower_func, upper_func, compare_func
#! @Returns a $\mathbb{Z}$-function with inductive sides
DeclareOperation( "ZFunctionWithInductiveSides",
      [ IsInt, IsObject, IsFunction, IsFunction, IsFunction ] );
#! @InsertChunk AsZFunctionWithInductiveSides

#! @BeginGroup 9228
#! @Description
#! They are the attributes that define a $\mathbb{Z}$-function with inductive sides.
#! @Arguments z_func
#! @Returns a function
DeclareAttribute( "UpperFunction", IsZFunctionWithInductiveSides );
#! @Arguments z_func
#! @Returns a function
DeclareAttribute( "LowerFunction", IsZFunctionWithInductiveSides );
#! @Arguments z_func
#! @Returns an integer
DeclareAttribute( "StartingIndex", IsZFunctionWithInductiveSides );
#! @Arguments z_func
#! @Returns a Gap object
DeclareAttribute( "StartingValue", IsZFunctionWithInductiveSides );
#! @EndGroup
#! @Group 9228
#! @Arguments z_func
#! @Returns a function
DeclareAttribute( "CompareFunction", IsZFunctionWithInductiveSides );

#! @Description
#! The argument is a $\mathbb{Z}$-function <A>z_func</A>. We say that <A>z_func</A> has a stable upper value <C>val</C>,
#! if there is an index <C>n</C> such that <A>z_func</A>[<C>i</C>] is equal to <C>val</C> for all indices <C>i</C>'s greater or equal to <C>n</C>.
#! In that case, the output is the value <C>val</C>.
#! @Arguments z_func
#! @Returns a Gap object
DeclareAttribute( "StableUpperValue", IsZFunction );

#! @Description
#! The argument is a $\mathbb{Z}$-function <A>z_func</A> with a stable upper value <C>val</C>. The output is some index where <A>z_func</A> starts to take
#! values equal to <C>val</C>.
#! @Arguments z_func
#! @Returns an integer
DeclareAttribute( "IndexOfStableUpperValue", IsZFunction );

#! @Description
#! The arguments are a $\mathbb{Z}$-function <A>z_func</A>,
#! an integer <A>n</A> and an object <A>val</A>.
#! The operation sets <A>val</A> as a stable upper value for
#! <A>z_func</A> at the index <A>n</A>.
#! @Arguments z_func, n, val
#! @Returns nothing
DeclareOperation( "SetStableUpperValue",
              [ IsZFunction, IsInt, IsObject ] );

#! @Description
#! The argument is a $\mathbb{Z}$-function <A>z_func</A>. We say that <A>z_func</A> has a stable lower value <C>val</C>,
#! if there is an index <C>n</C> such that <A>z_func</A>[<C>i</C>] is equal to <C>val</C> for all indices <C>i</C>'s less or equal to <C>n</C>.
#! In that case, the output is the value <C>val</C>.
#! @Arguments z_func
#! @Returns a Gap object
DeclareAttribute( "StableLowerValue", IsZFunction );

#! @Description
#! The argument is a $\mathbb{Z}$-function <A>z_func</A> with a stable lower value <C>val</C>. The output is some index where <A>z_func</A> starts to take
#! values equal to <C>val</C>.
#! @Arguments z_func
#! @Returns an integer
DeclareAttribute( "IndexOfStableLowerValue", IsZFunction );

#! @Description
#! The arguments are a $\mathbb{Z}$-function <A>z_func</A>,
#! an integer <A>n</A> and an object <A>val</A>.
#! The operation sets <A>val</A> as a stable lower value for
#! <A>z_func</A> at the index <A>n</A>.
#! @Arguments z_func, n, val
#! @Returns nothing
DeclareOperation( "SetStableLowerValue",
              [ IsZFunction, IsInt, IsObject ] );

#! @Description
#! The argument is a $\mathbb{Z}$-function <A>z_func</A>. The output is another
#! $\mathbb{Z}$-function <C>ref_z_func</C> such that <C>ref_z_func</C>[<C>i</C>] is equal
#! to <A>z_func</A>[<C>-i</C>] for all <C>i</C>'s in $\mathbb{Z}$.
#! @Arguments z_func
#! @Returns a $\mathbb{Z}$-function 
DeclareAttribute( "Reflection", IsZFunction );

#! @Description
#! The argument is a $\mathbb{Z}$-function <A>z_func</A> and an integer <A>n</A>. The output is
#! another $\mathbb{Z}$-function <C>m</C> such that <C>m</C>[<C>i</C>] is equal to <A>z_func</A>[<C>n+i</C>].
#! @Arguments z_func, n
#! @Returns a $\mathbb{Z}$-function
KeyDependentOperation( "ApplyShift", IsZFunction, IsInt, ReturnTrue );


#! @Description
#! The arguments are a $\mathbb{Z}$-function <A>z_func</A> and a function <A>F</A> that can
#! be applied on one argument.
#! The output is another $\mathbb{Z}$-function <C>m</C> such that
#! <C>m</C>[<C>i</C>] is equal to <A>F</A>(<A>z_func</A>[<C>i</C>]).
#! @Arguments z_func, F
#! @Returns a $\mathbb{Z}$-function
DeclareOperation( "ApplyMap", [ IsZFunction, IsFunction ] );

#! @Description
#! The arguments are a list of $\mathbb{Z}$-functions
#! <A>L</A> and a function <A>F</A> with
#! <C>Length</C>(<A>L</A>) arguments.
#! The output is another $\mathbb{Z}$-function <C>m</C> such that
#! <C>m</C>[<C>i</C>] is equal to <A>F</A>(<A>L</A>[1][<C>i</C>],...,
#! <A>L</A>[<C>Length</C>(<A>L</A>)][<C>i</C>]). We call the list <A>L</A> the <C>BaseZFunctions</C>
#! of <C>m</C> and <A>F</A> the <C>AppliedMap</C>.
#! @Arguments L, F
#! @Returns a $\mathbb{Z}$-function
DeclareOperation( "ApplyMap", [ IsDenseList, IsFunction ] );

#! @Description
#! The argument is a $\mathbb{Z}$-function <A>z_func</A> that has been defined by applying a map <C>F</C>
#! on a list <C>L</C> of $\mathbb{Z}$-functions. The output is the list <C>L</C>.
#! @Arguments z_func
#! @Returns a list of $\mathbb{Z}$-functions
DeclareAttribute( "BaseZFunctions", IsZFunction );

#! @Description
#! The argument is a $\mathbb{Z}$-function <A>z_func</A> that has been defined by applying a map <C>F</C>
#! on a list <C>L</C> of $\mathbb{Z}$-functions. The output is the function <C>F</C>.
#! @Arguments z_func
#! @Returns a $\mathbb{Z}$-function
DeclareAttribute( "AppliedMap", IsZFunction );

#! @Description
#! The argument is a dense list <A>L</A> of $\mathbb{Z}$-functions.
#! The output is another $\mathbb{Z}$-function <C>m</C> such that
#! <C>m</C>[<C>i</C>] is equal to [<A>L</A>[1][<C>i</C>],...,
#! <A>L</A>[<C>Length</C>(<A>L</A>)][<C>i</C>]] for all indices <C>i</C>'s in $\mathbb{Z}$.
#! @Arguments L
#! @Returns a $\mathbb{Z}$-function
DeclareOperation( "CombineZFunctions", [ IsDenseList ] );

#! @Description
#! The argument is a $\mathbb{Z}$-function <A>z_func</A>, an integer <A>n</A> and a dense list <A>L</A>.
#! The output is a new $\mathbb{Z}$-function whose values between <A>n</A> and <A>n</A>+<C>Length</C>(<A>L</A>)-1
#! are the entries of <A>L</A>.
#! @Arguments z_func, n, L
#! @Returns a $\mathbb{Z}$-function
DeclareOperation( "Replace", [ IsZFunction, IsInt, IsDenseList ] );

