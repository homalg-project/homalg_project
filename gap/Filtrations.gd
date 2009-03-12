#############################################################################
##
##  Filtrations.gi              homalg package               Mohamed Barakat
##
##  Copyright 2007-2009 Lehrstuhl B für Mathematik, RWTH Aachen
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

