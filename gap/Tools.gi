##
InstallOtherMethod( RankOfGauss,
        "for sets of relations",
	[ IsRecord ],
        
  function( M )
    
    return M.rank;
    
end );

