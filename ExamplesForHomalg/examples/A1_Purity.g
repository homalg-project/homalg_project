ReadPackage( "ExamplesForHomalg", "examples/Viktor.g" );

filt := PurityFiltration( V );

II_E := SpectralSequence( filt );

m := IsomorphismOfFiltration( filt );

