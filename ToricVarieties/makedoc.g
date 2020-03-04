if fail = LoadPackage("AutoDoc", ">= 2016.01.21") then
    Error("AutoDoc 2016.01.21 or newer is required");
fi;

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
