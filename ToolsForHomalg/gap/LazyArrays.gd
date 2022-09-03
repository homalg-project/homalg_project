# SPDX-License-Identifier: GPL-2.0-or-later
# ToolsForHomalg: Special methods and knowledge propagation tools
#
# Declarations
#

#! @Chapter Lazy Lists

#! @Section GAP categories

#! @Description
#!  The &GAP; category of lazy arrays.
#! @Arguments L
DeclareCategory( "IsLazyArray",
        IsComponentObjectRep and IsList );

#! @Section Constructors

#! @Description
#!  Construct a lazy array out of the nonnegative integer <A>n</A>
#!  and the function <A>func</A> defined in the range [ 0 .. <A>n</A> ],
#!  and possibly empty (sparse) list <A>values</A> of a posteriori possibly known values.
#! @Group LazyArray
#! @Arguments n, func, values
DeclareGlobalFunction( "LazyArray" );

#! @Group LazyArray
#! @Arguments values
DeclareGlobalFunction( "LazyArrayFromList" );

#! @Section Operations

DeclareOperation( "ListOfValues", [ IsLazyArray ] );
