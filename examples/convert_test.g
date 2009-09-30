## via listlist
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

## via list
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

## via sparse (2 arguments call of ConvertHomalgMatrix)
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

## via sparse (4 arguments call of ConvertHomalgMatrix)
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

## via file
tmat := ShallowCopy( imat );
smat := tmat * S;
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
