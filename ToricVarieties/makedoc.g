LoadPackage( "AutoDoc", "2016.02.16" );

AutoDoc(rec(
    scaffold := true,
    autodoc := rec(
        files := [ "doc/Doc.autodoc" ],
        scan_dirs := [ "gap", "examples/examplesmanual" ]
    ),
    maketest := rec(
        folder := ".",
        commands := [
            "LoadPackage( \"IO_ForHomalg\" );",
            "LoadPackage( \"GaussForHomalg\" );",
            "LoadPackage( \"ToricVarieties\" );",
            "HOMALG_IO.show_banners := false;",
            "HOMALG_IO.suppress_PID := true;",
            "HOMALG_IO.use_common_stream := true;",
        ]
    )
));

QUIT;
