# SPDX-License-Identifier: GPL-2.0-or-later
# homalg: A homological algebra meta-package for computable Abelian categories
#
# Declarations
#

##  Declaration stuff for (spectral) filtrations.

DeclareOperation( "FiltrationOfTotalDefect",
        [ IsHomalgSpectralSequence, IsInt ] );

DeclareOperation( "FiltrationOfTotalDefect",
        [ IsHomalgSpectralSequence ] );

DeclareOperation( "FiltrationOfObjectInCollapsedSheetOfTransposedSpectralSequence",
        [ IsHomalgSpectralSequence, IsInt ] );

DeclareOperation( "FiltrationOfObjectInCollapsedSheetOfTransposedSpectralSequence",
        [ IsHomalgSpectralSequence ] );

DeclareOperation( "FiltrationBySpectralSequence",
        [ IsHomalgSpectralSequence, IsInt ] );

DeclareOperation( "FiltrationBySpectralSequence",
        [ IsHomalgSpectralSequence ] );

DeclareOperation( "PurityFiltrationViaBidualizingSpectralSequence",
        [ IsHomalgStaticObject ] );

DeclareOperation( "SetAttributesByPurityFiltration",
        [ IsHomalgFiltration ] );

DeclareOperation( "SetAttributesByPurityFiltrationViaBidualizingSpectralSequence",
        [ IsHomalgFiltration ] );

DeclareOperation( "OnPresentationAdaptedToFiltration",
        [ IsHomalgFiltration ] );

DeclareOperation( "FilteredByPurity",
        [ IsHomalgStaticObject ] );

