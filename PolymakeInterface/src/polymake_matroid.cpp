#include "polymake_matroid.h"
#include "polymake_templates.h"



Obj REAL_CREATE_MATROID_BY_MATRIX( Polymake_Data* data, Obj matrix ){
  
  data->main_polymake_session->set_application( "matroid" );
  
  polymake::Matrix<polymake::Rational> matr(0,0);
  POLYMAKE_RATIONAL_MATRIX_GAP_MATRIX( &matr, matrix );
  
  perlobj* matroid = new perlobj( "Matroid" );
  
  matroid->take("VECTORS") << matr;
  
  Obj gapmatroid = NewPolymakeExternalObject( T_POLYMAKE_EXTERNAL_MATROID );
  POLYMAKEOBJ_SET_PERLOBJ( gapmatroid, matroid );
  
  return gapmatroid;
  
}

Obj REAL_CREATE_MATROID_ABSTRACT( Polymake_Data* data, Obj size, Obj elements ){
  
  data->main_polymake_session->set_application( "matroid" );
  
  if( ! IS_INTOBJ( size ) ){
    ErrorMayQuit( "first argument is not an integer", 0, 0);
    return NULL;
  }
  
  int matroid_size = INT_INTOBJ( size );
  
  if( ! IS_PLIST( elements ) ){
    ErrorMayQuit( "second argument is not a plain list", 0, 0);
    return NULL;
  }
  
  int nr_of_basis = INT_INTOBJ( LEN_PLIST( elements ) );
  polymake::Array<polymake::Set<int>> incMatr(nr_of_basis);
  
  for( int current_basis=1;current_basis<=nr_of_basis;current_basis++){
      
      Obj current_basis_list = ELM_PLIST( elements, current_basis );
      
      if( ! IS_PLIST( current_basis_list ) ){
        ErrorMayQuit( "second argument is not a plain list", 0, 0);
        return NULL;
      }
      
      int current_length = INT_INTOBJ( LEN_PLIST( current_basis_list ) );
      
      for( int i=1;i<=current_length;i++){
          incMatr[current_basis] += INT_INTOBJ( ELM_PLIST( current_basis_list, i ) ) - 1;
      }
      
  }
  
  perlobj* matroid = new perlobj( "Matroid" );
  
  matroid->take( "N_ELEMENTS" ) << matroid_size;
  matroid->take( "BASES" ) << incMatr;
  
  Obj gapmatroid = NewPolymakeExternalObject( T_POLYMAKE_EXTERNAL_MATROID );
  POLYMAKEOBJ_SET_PERLOBJ( gapmatroid, matroid );
  
  return gapmatroid;
  
}

Obj REAL_IS_ISOMORPHIC_MATROID( Polymake_Data* data, Obj matroid1, Obj matroid2 ){
  
  if( ! IS_POLYMAKE_MATROID( matroid1 ) ){
    ErrorMayQuit( "first argument is not a matroid", 0, 0);
    return NULL;
  }
  
  if( ! IS_POLYMAKE_MATROID( matroid2 ) ){
    ErrorMayQuit( "second argument is not a matroid", 0, 0);
    return NULL;
  }
  
  perlobj* matr1 = PERLOBJ_POLYMAKEOBJ( matroid1 );
  perlobj* matr2 = PERLOBJ_POLYMAKEOBJ( matroid2 );
  
  bool is_isomorpic;
  try{
    is_isomorpic = matr1->call_method( "is_isomorphic_to", *matr2 );
  }
  
  POLYMAKE_GAP_CATCH
  
  if( is_isomorpic ){
      return True;
  }
  return False;
  
}
