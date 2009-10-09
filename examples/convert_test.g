Print( "S := " );

Display( S );

Print( "\n## via listlist:\n" );
tmat := ShallowCopy( imat );
SetExtractHomalgMatrixToFile( tmat, false );
smat := tmat * S;
Print( "\n" );
Display( smat );
if IsHomalgInternalRingRep( S ) then
    kmat := smat * R;
    Print( "\n" );
    Display( kmat );
    b := b and ( Eval( tmat ) = Eval( kmat ) );
else
    SetExtractHomalgMatrixToFile( smat, false );
    kmat := smat * R;
    Print( "\n" );
    Display( kmat );
    b := b and ( Eval( tmat ) = Eval( kmat ) );
fi;

Print( "\n## via list:\n" );

tmat := ShallowCopy( imat );
SetExtractHomalgMatrixToFile( tmat, false );
smat := ConvertHomalgMatrix( tmat, nr, nc, S );
Print( "\n" );
Display( smat );
if IsHomalgInternalRingRep( S ) then
    kmat := smat * R;
    Print( "\n" );
    Display( kmat );
    b := b and ( Eval( tmat ) = Eval( kmat ) );
else
    SetExtractHomalgMatrixToFile( smat, false );
    kmat := ConvertHomalgMatrix( smat, nr, nc, R );
    Print( "\n" );
    Display( kmat );
    b := b and ( Eval( tmat ) = Eval( kmat ) );
fi;

Print( "\n## via sparse (2 arguments call of ConvertHomalgMatrix):\n" );
tmat := ShallowCopy( imat );
SetExtractHomalgMatrixAsSparse( tmat, true );
smat := tmat * S;
Print( "\n" );
Display( smat );
if IsHomalgInternalRingRep( S ) then
    kmat := smat * R;
    Print( "\n" );
    Display( kmat );
    b := b and ( Eval( tmat ) = Eval( kmat ) );
else
    SetExtractHomalgMatrixAsSparse( smat, true );
    kmat := smat * R;
    Print( "\n" );
    Display( kmat );
    b := b and ( Eval( tmat ) = Eval( kmat ) );
fi;

Print( "\n## via sparse (4 arguments call of ConvertHomalgMatrix):\n" );
tmat := ShallowCopy( imat );
SetExtractHomalgMatrixAsSparse( tmat, true );
smat := ConvertHomalgMatrix( tmat, nr, nc, S );
Print( "\n" );
Display( smat );
if IsHomalgInternalRingRep( S ) then
    kmat := smat * R;
    Print( "\n" );
    Display( kmat );
    b := b and ( Eval( tmat ) = Eval( kmat ) );
else
    SetExtractHomalgMatrixAsSparse( smat, true );
    kmat := ConvertHomalgMatrix( smat, nr, nc, R );
    Print( "\n" );
    Display( kmat );
    b := b and ( Eval( tmat ) = Eval( kmat ) );
fi;

Print( "\n## via file:\n" );
tmat := ShallowCopy( imat );
SetExtractHomalgMatrixToFile( tmat, true );
smat := ConvertHomalgMatrix( tmat, S );
Print( "\n" );
Display( smat );
if IsHomalgInternalRingRep( S ) then
    kmat := smat * R;
    Print( "\n" );
    Display( kmat );
    b := b and ( Eval( tmat ) = Eval( kmat ) );
else
    kmat := smat * R;
    Print( "\n" );
    Display( kmat );
    b := b and ( Eval( tmat ) = Eval( kmat ) );
fi;
