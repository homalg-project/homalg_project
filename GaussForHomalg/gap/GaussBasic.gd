# SPDX-License-Identifier: GPL-2.0-or-later
# GaussForHomalg: Gauss functionality for the homalg project
#
# Declarations
#

DeclareOperation( "MyEval",
        [ IsHomalgMatrix ] );

DeclareOperation( "SetMyEval",
        [ IsHomalgMatrix, IsSparseMatrix ] );

DeclareOperation( "SetMyEval",
        [ IsHomalgMatrix, IsList ] );

####################################
#
# global variables:
#
####################################

DeclareGlobalVariable( "CommonHomalgTableForGaussBasic" );

