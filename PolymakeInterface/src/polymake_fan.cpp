#include "polymake_fan.h"
#include "polymake_templates.h"

Obj REAL_FAN_BY_CONES( Polymake_Data* data, Obj cones ){
  
  if( ! IS_PLIST( cones ) ){
    ErrorMayQuit( "not a plain list", 0, 0);
    return NULL;
  }
  
  int numberofcones = LEN_PLIST( cones );
  Obj akt;
  Obj elem;
  Obj numb;
  int numberofrays = 0;
  data->main_polymake_session->set_application("fan");
  
  for(int i=1;i<=numberofcones;i++){
      akt = ELM_PLIST( cones, i );
#ifdef MORE_TESTS
      if( !IS_PLIST( akt ) ){
        ErrorMayQuit( "one cone is not a plain list", 0, 0);
        return NULL;
      }
#endif
      numberofrays += LEN_PLIST( akt );
  
  }
  
  int dimension = LEN_PLIST( ELM_PLIST( ELM_PLIST( cones, 1 ), 1 ) );
  polymake::Array<polymake::Set<int>> incMatr(numberofcones);
  polymake::Matrix<polymake::Rational> matr(numberofrays+1,dimension);
  int raycounter = 1;
  for(int i = 1; i <= numberofcones; i++){
        akt = ELM_PLIST( cones, i );
        for( int j = 1; j <= LEN_PLIST( akt ); j++){
            elem = ELM_PLIST( akt, j );
            for( int k = 1; k <= LEN_PLIST( elem ); k++){
                numb = ELM_PLIST( elem, k );
                
#ifdef MORE_TESTS
                if( ! IS_INTOBJ( numb ) ){
                  ErrorMayQuit( "some entries are not integers", 0, 0);
                  return NULL;
                }
#endif
                matr(raycounter, k-1) = INT_INTOBJ( numb );
            }
            incMatr[i-1] += raycounter;
            raycounter++;
        }
  }
  perlobj* q = new perlobj("PolyhedralFan<Rational>");
  q->take("INPUT_RAYS") << matr;
  q->take("INPUT_CONES") << incMatr;
  elem = NewPolymakeExternalObject( T_POLYMAKE_EXTERNAL_FAN );
  POLYMAKEOBJ_SET_PERLOBJ( elem, q);
  return elem;
}



Obj REAL_FAN_BY_RAYS_AND_CONES( Polymake_Data* data, Obj rays, Obj cones ){
  
  if( ! IS_PLIST( cones ) || ! IS_PLIST( rays ) ){
    ErrorMayQuit( "arguments are not plain lists", 0, 0);
    return NULL;
  }
  
  Obj akt;
  Obj elem;
  Obj numb;
  data->main_polymake_session->set_application("fan");
  polymake::Matrix<polymake::Rational> matr(0,0);
  
  POLYMAKE_RATIONAL_MATRIX_GAP_MATRIX( &matr, rays );
  
  int numberofcones = LEN_PLIST( cones );
  polymake::Array<polymake::Set<int>> incMatr(numberofcones);
  for(int i=0;i<numberofcones;i++){
      akt = ELM_PLIST( cones, i+1 );
#ifdef MORE_TESTS
      if( !IS_PLIST( akt ) ){
        ErrorMayQuit( "one cone is not a plain list", 0, 0);
        return NULL;
      }
#endif
      for(int j = 0; j < LEN_PLIST( akt ) ; j++){
        numb = ELM_PLIST( akt, j+1 );
#ifdef MORE_TESTS
        if( ! IS_INTOBJ( numb ) ){
          ErrorMayQuit( "some entries are not integers", 0, 0);
          return NULL;
        }
#endif
        incMatr[i] += static_cast<int>(INT_INTOBJ( numb ) - 1);
      }
  }

  perlobj* q = new perlobj("PolyhedralFan<Rational>");
  try{
    q->take("INPUT_RAYS") << matr;
    q->take("INPUT_CONES") << incMatr;
  }
  POLYMAKE_GAP_CATCH
  
  elem = NewPolymakeExternalObject( T_POLYMAKE_EXTERNAL_FAN );
  POLYMAKEOBJ_SET_PERLOBJ( elem, q);
  return elem;
}

Obj REAL_FAN_BY_RAYS_AND_CONES_UNSAVE( Polymake_Data* data, Obj rays, Obj cones ){
  
  if( ! IS_PLIST( cones ) || ! IS_PLIST( rays ) ){
    ErrorMayQuit( "arguments are not plain lists", 0, 0);
    return NULL;
  }
  
  Obj akt;
  Obj elem;
  Obj numb;
  data->main_polymake_session->set_application("fan");
  polymake::Matrix<polymake::Rational> matr(0,0);
  POLYMAKE_RATIONAL_MATRIX_GAP_MATRIX( &matr, rays );
  
  int numberofcones = LEN_PLIST( cones );
  polymake::IncidenceMatrix<> incMatr(numberofcones,matr.rows());
  for(int i=0;i<numberofcones;i++){
      akt = ELM_PLIST( cones, i+1 );
#ifdef MORE_TESTS
      if( !IS_PLIST( akt ) ){
        ErrorMayQuit( "one cone is not a plain list", 0, 0);
        return NULL;
      }
#endif
      for(int j = 0; j < LEN_PLIST( akt ) ; j++){
        numb = ELM_PLIST( akt, j+1 );
#ifdef MORE_TESTS
        if( ! IS_INTOBJ( numb ) ){
          ErrorMayQuit( "some entries are not integers", 0, 0);
          return NULL;
        }
#endif
        incMatr(i, INT_INTOBJ( numb ) - 1)=true;
      }
  }

  perlobj* q = new perlobj("PolyhedralFan<Rational>");
  try{
    q->take("RAYS") << matr;
    q->take("MAXIMAL_CONES") << incMatr;
  }
  POLYMAKE_GAP_CATCH
  
  elem = NewPolymakeExternalObject( T_POLYMAKE_EXTERNAL_FAN );
  POLYMAKEOBJ_SET_PERLOBJ( elem, q);
  return elem;
}



Obj REAL_RAYS_IN_MAXCONES_OF_FAN( Polymake_Data* data, Obj fan ){

#ifdef MORE_TESTS
  if(! IS_POLYMAKE_FAN(fan) ){
    ErrorMayQuit(" parameter is not a fan.",0,0);
    return NULL;
  }
#endif
  
  perlobj* coneobj = PERLOBJ_POLYMAKEOBJ( fan );
  data->main_polymake_session->set_application_of(*coneobj);
  polymake::IncidenceMatrix<> matr;
  try
  {
    coneobj->give("MAXIMAL_CONES") >> matr;
  }
  POLYMAKE_GAP_CATCH
  
  Obj RETLI = GAP_MATRIX_POLYMAKE_INTEGER_MATRIX( &matr );
  return RETLI;
  
}



Obj REAL_NORMALFAN_OF_POLYTOPE( Polymake_Data* data, Obj polytope ){

#ifdef MORE_TESTS
  if(! IS_POLYMAKE_POLYTOPE(polytope) ){
    ErrorMayQuit(" parameter is not a polytope.",0,0);
    return NULL;
  }
#endif
  
  perlobj* coneobj = PERLOBJ_POLYMAKEOBJ( polytope );
  data->main_polymake_session->set_application("fan");
  perlobj p;
  try{
    p = polymake::call_function("normal_fan",*coneobj);
  }
  POLYMAKE_GAP_CATCH
  
  perlobj* q = new perlobj(p);
  Obj elem = NewPolymakeExternalObject( T_POLYMAKE_EXTERNAL_FAN );
  POLYMAKEOBJ_SET_PERLOBJ( elem, q );
  return elem;
}


Obj REAL_STELLAR_SUBDIVISION( Polymake_Data* data, Obj ray, Obj fan ){

#ifdef MORE_TESTS
  if( (! IS_POLYMAKE_CONE(ray)) || (! IS_POLYMAKE_FAN(fan)) ){
    ErrorMayQuit(" parameter is not a fan or a cone.",0,0);
    return NULL;
  }
#endif
  perlobj* rayobject = PERLOBJ_POLYMAKEOBJ( ray );
  perlobj* fanobject = PERLOBJ_POLYMAKEOBJ( fan );
  data->main_polymake_session->set_application("fan");
  perlobj p;
  try{
    p = polymake::call_function("stellar_subdivision",*rayobject,*fanobject);
  }
  POLYMAKE_GAP_CATCH
  
  perlobj* q = new perlobj(p);
  Obj elem = NewPolymakeExternalObject( T_POLYMAKE_EXTERNAL_FAN );
  POLYMAKEOBJ_SET_PERLOBJ( elem, q );
  return elem;
}


Obj REAL_RAYS_OF_FAN( Polymake_Data* data, Obj fan){

#ifdef MORE_TESTS
  if(  ( ! IS_POLYMAKE_FAN(fan) ) ){
    ErrorMayQuit("argument is not a cone or fan",0,0);
    return NULL;
  }
#endif
  
  perlobj* coneobj = PERLOBJ_POLYMAKEOBJ( fan );
  data->main_polymake_session->set_application_of(*coneobj);
  polymake::Matrix<polymake::Integer> matr;
  try{
      polymake::Matrix<polymake::Rational> matr_temp = coneobj->give("RAYS");
      matr = polymake::common::primitive( matr_temp );
  }
  POLYMAKE_GAP_CATCH
  
  return GAP_MATRIX_POLYMAKE_INTEGER_MATRIX( &matr );
}


Obj REAL_F_VECTOR( Polymake_Data* data, Obj fan){

#ifdef MORE_TESTS
  if(  ( ! IS_POLYMAKE_FAN(fan) ) ){
    ErrorMayQuit(" parameter is not a cone or fan.",0,0);
    return NULL;
  }
#endif
  
  perlobj* fanobj = PERLOBJ_POLYMAKEOBJ( fan );
  data->main_polymake_session->set_application_of(*fanobj);
  polymake::Vector<polymake::Integer> matr;
  try{
    fanobj->give("F_VECTOR") >> matr;
  }

  POLYMAKE_GAP_CATCH

  UInt matr_rows = matr.size();
  Obj RETLI = NEW_PLIST( T_PLIST , matr.size() );
  SET_LEN_PLIST( RETLI , matr_rows );
  for(int i = 0;i<matr.size(); i++){
      SET_ELM_PLIST(RETLI,i+1,INTOBJ_INT( static_cast<int>(matr[i]) ));
      CHANGED_BAG(RETLI);
  }
  return RETLI;
}
