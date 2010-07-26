#############################################################################
##
##  Filtrations.gi              homalg package               Mohamed Barakat
##
##  Copyright 2007-2010, Mohamed Barakat, RWTH-Aachen
##
##  Declaration stuff for (spectral) filtrations.
##
#############################################################################

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

DeclareOperation( "FilteredByPurity",
        [ IsHomalgStaticObject ] );

