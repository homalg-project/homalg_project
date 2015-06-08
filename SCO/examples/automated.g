input := InputTextFile( "test.txt" );
LogTo( "log.txt" );

while ReadLine( input ) = "---\n" do
    Read( "examples.g" );
od;
