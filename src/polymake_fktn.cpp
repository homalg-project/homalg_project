#include "polymake_fktn.h"


Obj REAL_IS_SIMPLICIAL_OBJECT( Polymake_Data* data, Obj cone ){

#ifdef MORE_TESTS
  if(! IS_POLYMAKE_OBJECT(cone) ){
    ErrorMayQuit(" parameter is not a polymake object.",0,0);
    return NULL;
  }
#endif

  perlobj* coneobj = PERLOBJ_POLYMAKEOBJ( cone );
  data->main_polymake_session->set_application_of(*coneobj);
  bool i;
  try{
    coneobj->give("SIMPLICIAL") >> i;
  }
  catch( std::exception err ){
    ErrorMayQuit(" error during polymake computation.",0,0);
    return NULL;
  }
  if(i) return True; return False;

}


Obj REAL_IS_LATTICE_OBJECT( Polymake_Data* data, Obj cone ){

#ifdef MORE_TESTS
  if(! IS_POLYMAKE_OBJECT(cone) ){
    ErrorMayQuit(" parameter is not a polymake object.",0,0);
    return NULL;
  }
#endif

  perlobj* coneobj = PERLOBJ_POLYMAKEOBJ( cone );
  data->main_polymake_session->set_application_of(*coneobj);
  
  bool i;
  try{
    coneobj->give("LATTICE") >> i;
  }
  catch( std::exception err ){
    ErrorMayQuit(" error during polymake computation.",0,0);
    return NULL;
  }
  if(i) return True; return False;

}


Obj REAL_IS_NORMAL_OBJECT( Polymake_Data* data, Obj cone ){

#ifdef MORE_TESTS
  if(! IS_POLYMAKE_OBJECT(cone) ){
    ErrorMayQuit(" parameter is not a polymake object.",0,0);
    return NULL;
  }
#endif

  perlobj* coneobj = PERLOBJ_POLYMAKEOBJ( cone );
  data->main_polymake_session->set_application_of(*coneobj);
  
  bool i;
  try{
    coneobj->give("NORMAL") >> i;
  }
  catch( std::exception err ){
    ErrorMayQuit(" error during polymake computation.",0,0);
    return NULL;
  }
  if(i) return True; return False;

}


Obj REAL_IS_SMOOTH_OBJECT( Polymake_Data* data, Obj cone ){

#ifdef MORE_TESTS
  if(! IS_POLYMAKE_OBJECT(cone) ){
    ErrorMayQuit(" parameter is not a polymake object.",0,0);
    return NULL;
  }
#endif

  perlobj* coneobj = PERLOBJ_POLYMAKEOBJ( cone );
  data->main_polymake_session->set_application_of(*coneobj);
  
  bool i;
  try{
    coneobj->give("SMOOTH") >> i;
  }
  catch( std::exception err ){
    ErrorMayQuit(" error during polymake computation.",0,0);
    return NULL;
  }
  if(i) return True; return False;

}


Obj REAL_IS_VERYAMPLE_OBJECT( Polymake_Data* data, Obj cone ){

#ifdef MORE_TESTS
  if(! IS_POLYMAKE_OBJECT(cone) ){
    ErrorMayQuit(" parameter is not a polymake object.",0,0);
    return NULL;
  }
#endif

  perlobj* coneobj = PERLOBJ_POLYMAKEOBJ( cone );
  data->main_polymake_session->set_application_of(*coneobj);
  
  bool i;
  try{
    coneobj->give("VERY_AMPLE") >> i;
  }
  catch( std::exception err ){
    ErrorMayQuit(" error during polymake computation.",0,0);
    return NULL;
  }
  if(i) return True; return False;

}


Obj REAL_OBJECT_HAS_PROPERTY( Polymake_Data* data, Obj cone, const char* prop ){

#ifdef MORE_TESTS
  if(! IS_POLYMAKE_OBJECT(cone) ){
    ErrorMayQuit(" parameter is not a polymake object.",0,0);
    return NULL;
  }
#endif

  perlobj* coneobj = PERLOBJ_POLYMAKEOBJ( cone );
  data->main_polymake_session->set_application_of(*coneobj);
  
  bool i;
  try{
    coneobj->give(prop) >> i;
  }
  catch( std::exception err ){
    ErrorMayQuit(" error during polymake computation.",0,0);
    return NULL;
  }
  if(i) return True; return False;

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
    coneobj->give(prop) >> i;
  }
  catch( std::exception err ){
    ErrorMayQuit(" error during polymake computation.",0,0);
    return NULL;
  }
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
    coneobj->VoidCallPolymakeMethod("VISUAL");
  }
  catch( std::exception err ){
    ErrorMayQuit(" error during polymake computation.",0,0);
    return NULL;
  }
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
    coneobj->take(prop) << true;
  }
  catch( std::exception err ){
    ErrorMayQuit(" error during polymake computation.",0,0);
  }
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
    VoidCallPolymakeFunction( "sketch", coneobj->CallPolymakeMethod("VISUAL") );
  }
  catch( const std::exception& ex ){
    ErrorMayQuit(ex.what(),0,0);
    return NULL;
  }
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
  pm::perl::Hash sketch_options;
  if( IS_STRING( filename ) ){
    sketch_options["File"] << CSTR_STRING( filename );
  }
  
  pm::perl::Hash visual_options;
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
        visual_options[ CSTR_STRING( description ) ] << CSTR_STRING( content );
      }else{
        if( IS_PLIST( content ) ){
          pm::Integer* cont = new pm::Integer[ LEN_PLIST( content ) ];
          for( int j = 1; j <= LEN_PLIST( content ); j++ ){
            Obj elem = ELM_PLIST( content, j );
            if( ! IS_INTOBJ( elem ) ){
                ErrorMayQuit("entry of option array is not an integer",0,0);
                return NULL;
            }
            cont[ j - 1 ] = INT_INTOBJ( elem );
          }
          visual_options[ CSTR_STRING( description ) ] << cont;
        }
      }
    }
  }
  try{
     VoidCallPolymakeFunction( "sketch", coneobj->CallPolymakeMethod("VISUAL", visual_options), sketch_options );
  }
  catch( const std::exception& ex ){
    ErrorMayQuit(ex.what(),0,0);
    return NULL;
  }
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
    coneobj->VoidCallPolymakeMethod("properties");
  }
  catch( std::exception& err ){
    cerr << err.what() << endl;
    ErrorMayQuit( "in polymake computation",0,0);
    return NULL;
  }
  return True;

}
