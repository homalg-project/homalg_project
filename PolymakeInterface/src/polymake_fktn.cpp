#include "polymake_fktn.h"

Obj REAL_OBJECT_HAS_PROPERTY( Polymake_Data* data, Obj cone, const char* prop ){

#ifdef MORE_TESTS
  if(! IS_POLYMAKE_OBJECT(cone) ){
    ErrorMayQuit("argument",0,0);
    return NULL;
  }
#endif

  perlobj* coneobj = PERLOBJ_POLYMAKEOBJ( cone );
  data->main_polymake_session->set_application_of(*coneobj);
  
  bool i;
  try{
    coneobj->give(polymake::CStr(prop)) >> i;
  }
  POLYMAKE_GAP_CATCH
  
  if( i ){
    return True;
  }
  return False;

}

Obj REAL_OBJECT_HAS_INT_PROPERTY( Polymake_Data* data, Obj cone, const char* prop ){

#ifdef MORE_TESTS
  if(! IS_POLYMAKE_OBJECT(cone) ){
    ErrorMayQuit(" parameter is not a polymake object.",0,0);
    return NULL;
  }
#endif

  perlobj* coneobj = PERLOBJ_POLYMAKEOBJ( cone );
  data->main_polymake_session->set_application_of(*coneobj);
  
  int i;
  try{
    coneobj->give(polymake::CStr(prop)) >> i;
  }
  
  POLYMAKE_GAP_CATCH
  
  return INTOBJ_INT( i );
}


Obj REAL_POLYMAKE_DRAW( Polymake_Data* data, Obj cone ){

#ifdef MORE_TESTS
  if(! IS_POLYMAKE_OBJECT(cone) ){
    ErrorMayQuit(" parameter is not a polymake object.",0,0);
    return NULL;
  }
#endif

  perlobj* coneobj = PERLOBJ_POLYMAKEOBJ( cone );
  data->main_polymake_session->set_application_of(*coneobj);
  try{
    coneobj->call_method("VISUAL");
  }
  
  POLYMAKE_GAP_CATCH
  
  return True;

}


void REAL_SET_PROPERTY_TRUE( Polymake_Data* data, Obj conv, const char* prop){

#ifdef MORE_TESTS
  if(! IS_POLYMAKE_OBJECT(conv) ){
    ErrorMayQuit(" parameter is not a polymake object.",0,0);
    return;
  }
#endif

  perlobj* coneobj = PERLOBJ_POLYMAKEOBJ( conv );
  data->main_polymake_session->set_application_of(*coneobj);
  try{
    coneobj->take(polymake::CStr(prop)) << true;
  }
  
  POLYMAKE_GAP_CATCH
  
}

Obj REAL_POLYMAKE_SKETCH( Polymake_Data* data, Obj cone ){

#ifdef MORE_TESTS
  if(! IS_POLYMAKE_OBJECT(cone) ){
    ErrorMayQuit(" parameter is not a polymake object.",0,0);
    return NULL;
  }
#endif

  perlobj* coneobj = PERLOBJ_POLYMAKEOBJ( cone );
  data->main_polymake_session->set_application_of(*coneobj);
  try{
    polymake::call_function( "sketch", coneobj->call_method("VISUAL") );
  }
  
  POLYMAKE_GAP_CATCH
  
  return True;

}

Obj REAL_POLYMAKE_SKETCH_WITH_OPTIONS( Polymake_Data* data, Obj cone, Obj filename, Obj options ){
  #ifdef MORE_TESTS
  if(! IS_POLYMAKE_OBJECT(cone) ){
    ErrorMayQuit(" parameter is not a polymake object.",0,0);
    return NULL;
  }
  #endif
  perlobj* coneobj = PERLOBJ_POLYMAKEOBJ( cone );
  data->main_polymake_session->set_application_of(*coneobj);
  polymake::perl::OptionSet sketch_options;
  if( IS_STRING( filename ) ){
    sketch_options["File"] << CSTR_STRING( filename );
  }
  
  polymake::perl::OptionSet visual_options;
  if( IS_PLIST( options ) ){
    for( int i = 1; i <= LEN_PLIST( options ); i++ ){
      Obj current_option = ELM_PLIST( options, i );
      Obj description = ELM_PLIST( current_option, 1 );
      if( ! IS_STRING( description ) ){
          ErrorMayQuit("first entry in option entry is not a string",0,0);
          return NULL;
      }
      Obj content = ELM_PLIST( current_option, 2 );
      if( IS_STRING( content ) ){
        visual_options[ polymake::CStr(CSTR_STRING( description )) ] << CSTR_STRING( content );
      }else{
        if( IS_PLIST( content ) ){
          polymake::Integer* cont = new polymake::Integer[ LEN_PLIST( content ) ];
          for( int j = 1; j <= LEN_PLIST( content ); j++ ){
            Obj elem = ELM_PLIST( content, j );
            if( ! IS_INTOBJ( elem ) ){
                ErrorMayQuit("entry of option array is not an integer",0,0);
                return NULL;
            }
            cont[ j - 1 ] = INT_INTOBJ( elem );
          }
          visual_options[ polymake::CStr(CSTR_STRING( description )) ] << cont;
        }
      }
    }
  }
  try{
    polymake::call_function( "sketch", coneobj->call_method("VISUAL", visual_options), sketch_options );
  }
  
  POLYMAKE_GAP_CATCH
  
  return True;

}

Obj REAL_POLYMAKE_PROPERTIES( Polymake_Data* data, Obj cone ){

#ifdef MORE_TESTS
  if(! IS_POLYMAKE_OBJECT(cone) ){
    ErrorMayQuit(" parameter is not a polymake object.",0,0);
    return NULL;
  }
#endif

  perlobj* coneobj = PERLOBJ_POLYMAKEOBJ( cone );
  data->main_polymake_session->set_application_of(*coneobj);
  try{
    coneobj->call_method("properties");
  }
  
  POLYMAKE_GAP_CATCH
  
  return True;

}

template<typename T>
void POLYMAKE_RATIONAL_MATRIX_GAP_MATRIX( T* polymake_matrix, Obj gap_matrix ){
  
  int rows = LEN_PLIST( gap_matrix );
  Obj current = ELM_PLIST( gap_matrix, 1 );
  Obj elem;
  
#ifdef MORE_TESTS
  if( !IS_PLIST( current ) ){
    ErrorMayQuit( "first ray is not a plain list", 0, 0);
    return;
  }
#endif
  
  int columns = LEN_PLIST( current );
  
  polymake_matrix->resize( rows, columns );
  
  for(int i=0;i<rows;i++){
      current = ELM_PLIST( gap_matrix, i+1 );
#ifdef MORE_TESTS
      if( !IS_PLIST( current ) ){
        ErrorMayQuit( "one row is not a plain list", 0, 0);
        return;
      }
      if( LEN_PLIST( current ) != columns  ){
        ErrorMayQuit( "rows are not of the same length", 0, 0);
        return;
      }
#endif
      for(int j = 0; j < columns; j++){
        elem = ELM_PLIST( current, j+1);
#ifdef MORE_TESTS
        if( ! IS_INTOBJ( elem ) ){
          ErrorMayQuit( "entry is not an integer", 0, 0);
          return;
        }
#endif
        (*polymake_matrix)(i,j) = INT_INTOBJ( elem );
      }
  }
}

template<typename T>
Obj GAP_MATRIX_POLYMAKE_INTEGER_MATRIX( T* polymake_matrix ){
  
  Obj RETLI = NEW_PLIST( T_PLIST , polymake_matrix->rows() );
  UInt matr_rows = polymake_matrix->rows();
  SET_LEN_PLIST( RETLI , matr_rows );
  
  Obj LIZeil;
  
  UInt matr_cols = polymake_matrix->cols();
  for(int i = 0;i<polymake_matrix->rows();i++){
    LIZeil = NEW_PLIST( T_PLIST, polymake_matrix->cols() );
    SET_LEN_PLIST( LIZeil ,matr_cols);
    for(int j = 0;j<polymake_matrix->cols();j++){
      SET_ELM_PLIST(LIZeil,j+1,INTOBJ_INT(static_cast<int>((*polymake_matrix)(i,j))));
    }
    SET_ELM_PLIST(RETLI,i+1,LIZeil);
  }
  return RETLI;
}
