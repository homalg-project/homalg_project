#include "polymake_cone.h"
#include <polymake/common/lattice_tools.h>


Obj REAL_CREATE_CONE_BY_RAYS( Polymake_Data* data, Obj rays ){
  
  data->main_polymake_session->set_application("polytope");

  polymake::Matrix<polymake::Rational> matr(0,0);
  POLYMAKE_RATIONAL_MATRIX_GAP_MATRIX( &matr, rays );

  perlobj* p = new perlobj("Cone");
  p->take("INPUT_RAYS") << matr;
  
  Obj elem = NewPolymakeExternalObject(T_POLYMAKE_EXTERNAL_CONE);
  POLYMAKEOBJ_SET_PERLOBJ(elem, p);
  
  return elem;
}


Obj REAL_CREATE_CONE_BY_RAYS_UNSAVE( Polymake_Data* data, Obj rays ){
  
    data->main_polymake_session->set_application("polytope");

  polymake::Matrix<polymake::Rational> matr(0,0);
  POLYMAKE_RATIONAL_MATRIX_GAP_MATRIX( &matr, rays );

  perlobj* p = new perlobj("Cone");
  p->take("RAYS") << matr;

  Obj elem = NewPolymakeExternalObject(T_POLYMAKE_EXTERNAL_CONE);
  POLYMAKEOBJ_SET_PERLOBJ(elem, p);

  return elem;
}


Obj REAL_CREATE_CONE_BY_INEQUALITIES( Polymake_Data* data, Obj rays ){
  
  data->main_polymake_session->set_application("polytope");

  polymake::Matrix<polymake::Rational> matr(0,0);
  POLYMAKE_RATIONAL_MATRIX_GAP_MATRIX( &matr, rays );

  perlobj* p = new perlobj("Cone");
  p->take("INEQUALITIES") << matr; 
  
  Obj elem = NewPolymakeExternalObject(T_POLYMAKE_EXTERNAL_CONE);
  POLYMAKEOBJ_SET_PERLOBJ(elem, p);
  return elem;
}


Obj REAL_CREATE_DUAL_CONE_OF_CONE(  Polymake_Data* data, Obj cone ){
  
#ifdef MORE_TESTS
  if(! IS_POLYMAKE_CONE(cone) ){
    ErrorMayQuit("argument is not a cone",0,0);
    return NULL;
  }
#endif
  
  perlobj* coneobj = PERLOBJ_POLYMAKEOBJ(cone);
  
  data->main_polymake_session->set_application_of(*coneobj);
  polymake::Matrix<polymake::Rational> matr, matr2;
  try
  {
    coneobj->give("FACETS") >> matr;
    coneobj->give("LINEAR_SPAN") >> matr2;
  }

  POLYMAKE_GAP_CATCH

  perlobj* p;
  p = new perlobj("Cone<Rational>");
  p->take("INPUT_RAYS") << matr / matr2 / -matr2;

  Obj elem = NewPolymakeExternalObject( T_POLYMAKE_EXTERNAL_CONE ); 
  POLYMAKEOBJ_SET_PERLOBJ( elem, p );

  return elem;
}


Obj REAL_GENERATING_RAYS_OF_CONE( Polymake_Data* data, Obj cone){

#ifdef MORE_TESTS
  if(! IS_POLYMAKE_CONE(cone) ){
    ErrorMayQuit(" argument is not a cone",0,0);
    return NULL;
  }
#endif
  perlobj* coneobj = PERLOBJ_POLYMAKEOBJ( cone );
  data->main_polymake_session->set_application_of(*coneobj);
  polymake::Matrix<polymake::Integer> matr, matr2;
  try{
     polymake::Matrix<polymake::Rational> matr_temp = coneobj->give("RAYS");
     matr=polymake::common::primitive( matr_temp );
     coneobj->give("LINEALITY_SPACE") >> matr_temp;
     matr2=polymake::common::primitive( matr_temp );
  }
  
  POLYMAKE_GAP_CATCH
  
  Obj RETLI1 = GAP_MATRIX_POLYMAKE_INTEGER_MATRIX( &matr );
  Obj RETLI2 = GAP_MATRIX_POLYMAKE_INTEGER_MATRIX( &matr2 );
  matr2 = -matr2;
  Obj RETLI3 = GAP_MATRIX_POLYMAKE_INTEGER_MATRIX( &matr2 );
  
  int len1 = LEN_PLIST( RETLI1 );
  int len2 = LEN_PLIST( RETLI2 );
  
  Obj RETLI = NEW_PLIST( T_PLIST, len1 + 2*len2 );
  SET_LEN_PLIST( RETLI, INTOBJ_INT( len1 + 2*len2 ) );
  
  for( int i = 1; i <= len1; i++ )
    SET_ELM_PLIST( RETLI, i, ELM_PLIST( RETLI1, i ) );
  
  for( int i = 1; i <= len2; i++ ){
    SET_ELM_PLIST( RETLI, len1 + i, ELM_PLIST( RETLI2, i ) );
    SET_ELM_PLIST( RETLI,  len1 + len2 + i, ELM_PLIST( RETLI3, i ) );
  }
  
  return RETLI;
}


Obj REAL_LINEALITY_SPACE_OF_CONE( Polymake_Data* data, Obj cone){

#ifdef MORE_TESTS
  if( ( ! IS_POLYMAKE_CONE(cone) ) ){
    ErrorMayQuit("parameter is not a cone",0,0);
    return NULL;
  }
#endif
  
  perlobj* coneobj = PERLOBJ_POLYMAKEOBJ( cone );
  data->main_polymake_session->set_application_of(*coneobj);
  polymake::Matrix<polymake::Integer> matr;
  try
  {
    polymake::Matrix<polymake::Rational> matr_temp = coneobj->give("LINEALITY_SPACE");
    matr=polymake::common::primitive( matr_temp );
  }

  POLYMAKE_GAP_CATCH
  
  Obj RETLI = GAP_MATRIX_POLYMAKE_INTEGER_MATRIX( &matr );
  
  return RETLI;
}


Obj REAL_HILBERT_BASIS_OF_CONE( Polymake_Data* data, Obj cone){

#ifdef MORE_TESTS
  if(! IS_POLYMAKE_CONE(cone) ){
    ErrorMayQuit(" parameter is not a cone.",0,0);
    return NULL;
  }
#endif
  
  perlobj* coneobj = PERLOBJ_POLYMAKEOBJ( cone );
  data->main_polymake_session->set_application_of(*coneobj);
  polymake::Array<polymake::Matrix<polymake::Integer>> arr;
  try
  {
     arr = coneobj->give("HILBERT_BASIS_GENERATORS");
  }

  POLYMAKE_GAP_CATCH

  const polymake::Matrix<polymake::Integer>& matr = arr[0];
  Obj RETLI = GAP_MATRIX_POLYMAKE_INTEGER_MATRIX( &matr );
  
  return RETLI;
  
}

Obj REAL_RAYS_IN_FACETS( Polymake_Data* data, Obj cone){

#ifdef MORE_TESTS
  if( ( ! IS_POLYMAKE_CONE(cone) ) and ( ! IS_POLYMAKE_POLYTOPE( cone ) ) ){
    ErrorMayQuit("parameter is not a cone.",0,0);
    return NULL;
  }
#endif
  
  perlobj* coneobj = PERLOBJ_POLYMAKEOBJ( cone );
  data->main_polymake_session->set_application_of(*coneobj);
  polymake::IncidenceMatrix<> matr;
  try
  {
    coneobj->give("RAYS_IN_FACETS") >> matr;
  }

  POLYMAKE_GAP_CATCH

  Obj RETLI = GAP_MATRIX_POLYMAKE_INTEGER_MATRIX( &matr );
  return RETLI;
  
}


Obj REAL_DEFINING_INEQUALITIES_OF_CONE( Polymake_Data* data, Obj cone){

#ifdef MORE_TESTS
  if(! IS_POLYMAKE_CONE(cone) ){
    ErrorMayQuit("parameter is not a polymake cone",0,0);
    return NULL;
  }
#endif
  
  perlobj* coneobj = PERLOBJ_POLYMAKEOBJ( cone );
  data->main_polymake_session->set_application_of(*coneobj);
  polymake::Matrix<polymake::Integer> matr, matr2;

  try{
    polymake::Matrix<polymake::Rational> matr_temp = coneobj->give("FACETS");
    matr=polymake::common::primitive(matr_temp);
    coneobj->give("LINEAR_SPAN") >> matr_temp;
    matr2=polymake::common::primitive(matr_temp);
  }
  
  POLYMAKE_GAP_CATCH

  Obj RETLI1 = GAP_MATRIX_POLYMAKE_INTEGER_MATRIX( &matr );
  Obj RETLI2 = GAP_MATRIX_POLYMAKE_INTEGER_MATRIX( &matr2 );
  matr2 = -matr2;
  Obj RETLI3 = GAP_MATRIX_POLYMAKE_INTEGER_MATRIX( &matr2 );
  
  int len1 = LEN_PLIST( RETLI1 );
  int len2 = LEN_PLIST( RETLI2 );
  
  Obj RETLI = NEW_PLIST( T_PLIST, len1 + 2*len2 );
  SET_LEN_PLIST( RETLI, INTOBJ_INT( len1 + 2*len2 ) );
  
  for( int i = 1; i <= len1; i++ )
    SET_ELM_PLIST( RETLI, i, ELM_PLIST( RETLI1, i ) );
  
  for( int i = 1; i <= len2; i++ ){
    SET_ELM_PLIST( RETLI, len1 + i, ELM_PLIST( RETLI2, i ) );
    SET_ELM_PLIST( RETLI,  len1 + len2 + i, ELM_PLIST( RETLI3, i ) );
  }
  return RETLI;
  
}

Obj REAL_INTERSECTION_OF_CONES( Polymake_Data* data, Obj cone1, Obj cone2){

#ifdef MORE_TESTS
  if(! IS_POLYMAKE_CONE(cone1) || ! IS_POLYMAKE_CONE(cone2) ){
    ErrorMayQuit(" parameter is not a cone.",0,0);
    return NULL;
  }
#endif

  perlobj* coneobj1 = PERLOBJ_POLYMAKEOBJ( cone1 );
  perlobj* coneobj2 = PERLOBJ_POLYMAKEOBJ( cone2 );

  data->main_polymake_session->set_application_of( *coneobj1 );

  perlobj intersec=polymake::call_function( "intersection", *coneobj1, *coneobj2 );

  perlobj* returnobj = new perlobj(intersec);

  Obj elem = NewPolymakeExternalObject(T_POLYMAKE_EXTERNAL_CONE);
  
  POLYMAKEOBJ_SET_PERLOBJ( elem, returnobj );
  
  return elem;
  
}

Obj REAL_EQUALITIES_OF_CONE( Polymake_Data* data, Obj cone){

#ifdef MORE_TESTS
  if(! IS_POLYMAKE_CONE(cone) ){
    ErrorMayQuit(" parameter is not an integer.",0,0);
    return NULL;
  }
#endif
  perlobj* coneobj = PERLOBJ_POLYMAKEOBJ( cone );
  data->main_polymake_session->set_application_of(*coneobj);
  polymake::Matrix<polymake::Rational> matr_rat = coneobj->give("LINEAR_SPAN");
  polymake::Matrix<polymake::Integer> matr = polymake::common::primitive( matr_rat );
  Obj RETLI = NEW_PLIST( T_PLIST , matr.rows() );
  UInt matr_rows = matr.rows();
  SET_LEN_PLIST( RETLI ,matr_rows);
  Obj LIZeil;

  UInt matr_cols = matr.cols();
  for(int i = 0;i<matr.rows();i++){
    LIZeil = NEW_PLIST( T_PLIST, matr.cols());
    SET_LEN_PLIST( LIZeil , matr_cols );
    for(int j = 0;j<matr.cols();j++){
      SET_ELM_PLIST(LIZeil,j+1,INTOBJ_INT( static_cast<int>(matr(i,j)) ));
    }
    SET_ELM_PLIST(RETLI,i+1,LIZeil);
    CHANGED_BAG(RETLI);
  }
  return RETLI;
}

Obj REAL_CREATE_CONE_BY_EQUALITIES_AND_INEQUALITIES( Polymake_Data* data, Obj eqs, Obj ineqs ){
  
  if( ! IS_PLIST( eqs ) || ! IS_PLIST( ineqs ) ){
    ErrorMayQuit( "not a plain list", 0, 0);
    return NULL;
  }
  
  int numberofrays = LEN_PLIST( eqs );
  Obj akt;
  Obj elem;
  Obj numb;
  data->main_polymake_session->set_application("polytope");
  int dimension = LEN_PLIST( ELM_PLIST( eqs, 1 ) );
  polymake::Matrix<polymake::Rational> matr(numberofrays,dimension);
  for(int i=0;i<numberofrays;i++){
      akt = ELM_PLIST( eqs, i+1 );
#ifdef MORE_TESTS
      if( !IS_PLIST( akt ) || LEN_PLIST( akt ) != dimension ){
        ErrorMayQuit( "one ray is not a plain list", 0, 0);
        return NULL;
      }
#endif
      for(int j = 0; j<dimension; j++){
        numb = ELM_PLIST( akt, j+1 );
#ifdef MORE_TESTS
        if( ! IS_INTOBJ( numb ) ){
          ErrorMayQuit( "some entries are not integers", 0, 0);
          return NULL;
        }
#endif
        matr(i,j) = INT_INTOBJ( numb );
      }
  }
  int numberofcones = LEN_PLIST( ineqs );
  polymake::Matrix<polymake::Rational> matr2(numberofcones,dimension);
  for(int i=0;i<numberofcones;i++){
      akt = ELM_PLIST( ineqs, i+1 );
#ifdef MORE_TESTS
      if( !IS_PLIST( akt ) || LEN_PLIST( akt ) != dimension ){
        ErrorMayQuit( "one ray is not a plain list", 0, 0);
        return NULL;
      }
#endif
      for(int j = 0; j<dimension; j++){
        numb = ELM_PLIST( akt, j+1 );
#ifdef MORE_TESTS
        if( ! IS_INTOBJ( numb ) ){
          ErrorMayQuit( "some entries are not integers", 0, 0);
          return NULL;
        }
#endif
        matr2(i,j) = INT_INTOBJ( numb );
      }
  }

  perlobj* q = new perlobj("Cone<Rational>");
  q->take("EQUATIONS") << matr;
  q->take("INEQUALITIES") << matr2;
  elem = NewPolymakeExternalObject( T_POLYMAKE_EXTERNAL_CONE );
  POLYMAKEOBJ_SET_PERLOBJ( elem, q);
  return elem;
}
