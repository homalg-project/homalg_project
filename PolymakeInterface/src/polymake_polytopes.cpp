#include "polymake_polytopes.h"
#include "polymake/common/lattice_tools.h"
#include "polymake_templates.h"

Obj REAL_CREATE_POLYTOPE_BY_POINTS( Polymake_Data* data, Obj polytope ){
  
#ifdef MORE_TESTS
  if( ! IS_PLIST( polytope ) ){
    ErrorMayQuit( "not a plain list", 0, 0);
    return NULL;
  }
#endif
  
  int len = LEN_PLIST( polytope );
  Obj akt = ELM_PLIST( polytope, 1 );
  Obj elem;
  
#ifdef MORE_TESTS
  if( !IS_PLIST( akt ) ){
    ErrorMayQuit( "not a plain list", 0, 0);
    return NULL;
  }
#endif

  int len_elem = LEN_PLIST( akt );
  data->main_polymake_session->set_application("polytope");

  polymake::Matrix<polymake::Rational> matr(len,len_elem+1);
  
  for(int i=1;i<=len;i++){
      akt = ELM_PLIST( polytope, i );
#ifdef MORE_TESTS
      if( !IS_PLIST( akt ) ){
        ErrorMayQuit( "not a plain list", 0, 0);
        return NULL;
      }
      if( LEN_PLIST( akt ) != len_elem ){
        ErrorMayQuit( "raygenerators are not of the same lenght", 0, 0);
        return NULL;
      }
#endif
      
      matr(i-1, 0) = 1;
      for(int j = 1; j <= len_elem; j++){
        elem = ELM_PLIST( akt, j);
        
#ifdef MORE_TESTS
        if( ! IS_INTOBJ( elem ) ){
          ErrorMayQuit( "some entries are not integers", 0, 0);
          return NULL;
        }
#endif
        matr(i-1, j) = INT_INTOBJ( elem );
      }
  }

  perlobj* p = new perlobj("LatticePolytope");
  p->take("POINTS") << matr;
  elem = NewPolymakeExternalObject( T_POLYMAKE_EXTERNAL_POLYTOPE );
  POLYMAKEOBJ_SET_PERLOBJ( elem, p );
  return elem;
}



Obj REAL_VERTICES_OF_POLYTOPE( Polymake_Data* data, Obj polytope){

#ifdef MORE_TESTS
  if(! IS_POLYMAKE_POLYTOPE(polytope) ){
    ErrorMayQuit(" parameter is not a polytope.",0,0);
    return NULL;
  }
#endif

  perlobj* polyobj = PERLOBJ_POLYMAKEOBJ( polytope );
  data->main_polymake_session->set_application_of(*polyobj);
  polymake::Matrix<polymake::Rational> matr;
  try{
    polyobj->give("VERTICES") >> matr;
  }
  
  POLYMAKE_GAP_CATCH
  
  UInt l = 10;
  Obj RETLI = NEW_PLIST( T_PLIST , l );
  SET_LEN_PLIST(RETLI, l );
  UInt k = 0;
  Obj LIZeil;
  UInt matr_cols = matr.cols() - 1;
  for(int i = 0;i<matr.rows();i++){
    if( matr(i,0) == 1 ){
      if( ++k > l){
        GROW_PLIST(RETLI,l*=2);
        SET_LEN_PLIST(RETLI, l );
      }
      LIZeil = NEW_PLIST( T_PLIST, matr.cols()-1);
      SET_LEN_PLIST( LIZeil , matr_cols );
      for(int j = 1;j<matr.cols();j++){
        SET_ELM_PLIST(LIZeil,j,INTOBJ_INT(static_cast<int>(matr(i,j))));
      }
      SET_ELM_PLIST(RETLI,k,LIZeil);
      CHANGED_BAG(RETLI);
    }
  }
  SHRINK_PLIST(RETLI,k);
  SET_LEN_PLIST(RETLI, k );
  return RETLI;
  
}



Obj REAL_LATTICE_POINTS_OF_POLYTOPE( Polymake_Data* data, Obj polytope){

#ifdef MORE_TESTS
  if(! IS_POLYMAKE_POLYTOPE(polytope) ){
    ErrorMayQuit("argumnt is not a polytope.",0,0);
    return NULL;
  }
#endif

  perlobj* polyobj = PERLOBJ_POLYMAKEOBJ( polytope );
  data->main_polymake_session->set_application_of(*polyobj);
  polymake::Array<polymake::Matrix<polymake::Integer>> arr;
  try{
      arr = polyobj->give("LATTICE_POINTS_GENERATORS");
  }

  POLYMAKE_GAP_CATCH

  const polymake::Matrix<polymake::Integer>& matr = arr[ 1 ];
  Obj RETLI = NEW_PLIST( T_PLIST , matr.rows());
  UInt matr_rows = matr.rows();
  SET_LEN_PLIST( RETLI , matr_rows );
  Obj LIZeil;
  UInt matr_cols = matr.cols() - 1;
  for(int i = 0;i<matr.rows();i++){
    LIZeil = NEW_PLIST( T_PLIST, matr.cols()-1);
    SET_LEN_PLIST( LIZeil , matr_cols );
    for(int j = 1;j<matr.cols();j++){
      SET_ELM_PLIST(LIZeil,j,INTOBJ_INT(static_cast<int>(matr(i,j))));
    }
    SET_ELM_PLIST(RETLI,i+1,LIZeil);
    CHANGED_BAG(RETLI);
  }
  return RETLI;
  
}



Obj REAL_CREATE_POLYTOPE_BY_INEQUALITIES( Polymake_Data* data, Obj polytope){
  
  data->main_polymake_session->set_application("polytope");
  
  polymake::Matrix<polymake::Rational> matr(0,0);
  POLYMAKE_RATIONAL_MATRIX_GAP_MATRIX( &matr, polytope );
  
  perlobj* p = new perlobj("LatticePolytope");
  try{
    p->take("INEQUALITIES") << matr;
  }
  POLYMAKE_GAP_CATCH
  
  Obj elem = NewPolymakeExternalObject( T_POLYMAKE_EXTERNAL_POLYTOPE );
  POLYMAKEOBJ_SET_PERLOBJ( elem, p );
  return elem;
}



Obj REAL_FACET_INEQUALITIES_OF_POLYTOPE( Polymake_Data* data, Obj polytope){

#ifdef MORE_TESTS
  if(! IS_POLYMAKE_POLYTOPE(polytope) ){
    ErrorMayQuit("argument is not a polytope",0,0);
    return NULL;
  }
#endif

  perlobj* polyobj = PERLOBJ_POLYMAKEOBJ( polytope );
  data->main_polymake_session->set_application_of(*polyobj);
  polymake::Matrix<polymake::Integer> matr;
  try{
    polymake::Matrix<polymake::Rational> matr_rat = polyobj->give("FACETS");
    matr = polymake::common::primitive( matr_rat );
  }
  POLYMAKE_GAP_CATCH
  
  return GAP_MATRIX_POLYMAKE_INTEGER_MATRIX( &matr );
  
}


Obj REAL_EQUALITIES_OF_POLYTOPE( Polymake_Data* data, Obj polytope){

#ifdef MORE_TESTS
  if(! IS_POLYMAKE_POLYTOPE(polytope) ){
    ErrorMayQuit("argument is not a polytope",0,0);
    return NULL;
  }
#endif

  perlobj* polyobj = PERLOBJ_POLYMAKEOBJ( polytope );
  data->main_polymake_session->set_application_of(*polyobj);
  polymake::Matrix<polymake::Integer> matr;
  try{
    polymake::Matrix<polymake::Rational> matr_rat = polyobj->give("AFFINE_HULL");
    matr = polymake::common::primitive( matr_rat );
  }
  POLYMAKE_GAP_CATCH
  
  return GAP_MATRIX_POLYMAKE_INTEGER_MATRIX( &matr );
  
}


Obj REAL_INTERIOR_LATTICE_POINTS( Polymake_Data* data, Obj polytope){

#ifdef MORE_TESTS
  if(! IS_POLYMAKE_POLYTOPE(polytope) ){
    ErrorMayQuit(" parameter is not a polytope.",0,0);
    return NULL;
  }
#endif

  perlobj* polyobj = PERLOBJ_POLYMAKEOBJ( polytope );
  data->main_polymake_session->set_application_of(*polyobj);
  polymake::Matrix<polymake::Integer> matr;
  try{
    polyobj->give("INTERIOR_LATTICE_POINTS") >> matr;
  }

  POLYMAKE_GAP_CATCH

  Obj RETLI = NEW_PLIST( T_PLIST , matr.rows());
  UInt matr_rows = matr.rows();
  SET_LEN_PLIST( RETLI , matr_rows );
  Obj LIZeil;
  UInt matr_cols = matr.cols() - 1;
  for(int i = 0;i<matr.rows();i++){
    LIZeil = NEW_PLIST( T_PLIST, matr.cols()-1);
    SET_LEN_PLIST( LIZeil , matr_cols );
    for(int j = 1;j<matr.cols();j++){
      SET_ELM_PLIST(LIZeil,j,INTOBJ_INT(static_cast<int>(matr(i,j))));
    }
    SET_ELM_PLIST(RETLI,i+1,LIZeil);
    CHANGED_BAG(RETLI);
  }
  return RETLI;
}



Obj REAL_CREATE_POLYTOPE_BY_HOMOGENEOUS_POINTS( Polymake_Data* data, Obj points ){
  
  data->main_polymake_session->set_application("polytope");

  polymake::Matrix<polymake::Rational> matr(0,0);
  POLYMAKE_RATIONAL_MATRIX_GAP_MATRIX( &matr, points );
  
  perlobj* p = new perlobj("Polytope<Rational>");
  p->take("POINTS") << matr;
  Obj elem = NewPolymakeExternalObject(T_POLYMAKE_EXTERNAL_POLYTOPE);

  POLYMAKEOBJ_SET_PERLOBJ(elem, p);

  return elem;
}



Obj REAL_HOMOGENEOUS_POINTS_OF_POLYTOPE( Polymake_Data* data, Obj polytope){

#ifdef MORE_TESTS
  if( ( ! IS_POLYMAKE_POLYTOPE(polytope) ) ){
    ErrorMayQuit("argument is not a polytope",0,0);
    return NULL;
  }
#endif
  
  perlobj* coneobj = PERLOBJ_POLYMAKEOBJ( polytope );
  data->main_polymake_session->set_application_of(*coneobj);
  polymake::Matrix<polymake::Integer> matr;
  try{
      polymake::Matrix<polymake::Rational> matr_temp = coneobj->give("VERTICES");
      matr=polymake::common::primitive( matr_temp );
  }
  POLYMAKE_GAP_CATCH
  
  return GAP_MATRIX_POLYMAKE_INTEGER_MATRIX( &matr );
  
}


// FIXME: This method will produce wrong results.
Obj REAL_TAIL_CONE_OF_POLYTOPE( Polymake_Data* data, Obj polytope){

#ifdef MORE_TESTS
  if(! IS_POLYMAKE_POLYTOPE(polytope) ){
    ErrorMayQuit(" parameter is not a polytope.",0,0);
    return NULL;
  }
#endif

  perlobj* polyobj = PERLOBJ_POLYMAKEOBJ( polytope );
  data->main_polymake_session->set_application_of(*polyobj);
  polymake::Matrix<polymake::Rational> matr;
  try{
    polyobj->give("VERTICES") >> matr;
  }

  POLYMAKE_GAP_CATCH

  UInt l = 10;
  Obj RETLI = NEW_PLIST( T_PLIST , l );
  SET_LEN_PLIST(RETLI, l );
  Obj LIZeil;
  UInt k = 0;
  UInt matr_cols = matr.cols() - 1;
  for(int i = 0;i<matr.rows();i++){
    if( matr(i,0)==0 ){
      if(++k>l){
        GROW_PLIST(RETLI,l*=2);
        SET_LEN_PLIST(RETLI, l );
      }
      LIZeil = NEW_PLIST( T_PLIST, matr.cols()-1);
      SET_LEN_PLIST( LIZeil , matr_cols );
      for(int j = 1;j<matr.cols();j++){
        SET_ELM_PLIST(LIZeil,j, INTOBJ_INT( static_cast<int>(matr(i,j)) ) );
      }
      SET_ELM_PLIST(RETLI,k,LIZeil);
      CHANGED_BAG(RETLI);
    }
  }
  SHRINK_PLIST(RETLI,k);
  SET_LEN_PLIST(RETLI, k );
  return RETLI;
  
}


Obj REAL_MINKOWSKI_SUM( Polymake_Data* data, Obj polytope1, Obj polytope2 ){
    
#ifdef MORE_TESTS
  if( (!IS_POLYMAKE_POLYTOPE(polytope1)) || (!IS_POLYMAKE_POLYTOPE(polytope2))  ){
    ErrorMayQuit("one parameter is not a polytope.",0,0);
    return NULL;
  }
#endif
  perlobj* poly1 = PERLOBJ_POLYMAKEOBJ( polytope1 );
  perlobj* poly2 = PERLOBJ_POLYMAKEOBJ( polytope2 );
  data->main_polymake_session->set_application_of(*poly1);
  
  perlobj sum;
  try{
    sum = polymake::call_function("minkowski_sum",*poly1,*poly2);
  }
  
  POLYMAKE_GAP_CATCH
  
  perlobj* sumpointer = new perlobj(sum);
  Obj elem = NewPolymakeExternalObject(T_POLYMAKE_EXTERNAL_POLYTOPE);
  POLYMAKEOBJ_SET_PERLOBJ(elem, sumpointer);
  return elem;
}



Obj REAL_MINKOWSKI_SUM_WITH_COEFFICIENTS( Polymake_Data* data, Obj fact1, Obj polytope1, Obj fact2, Obj polytope2 ){
    
#ifdef MORE_TESTS
  if( (!IS_POLYMAKE_POLYTOPE(polytope1)) || (!IS_POLYMAKE_POLYTOPE(polytope2))  ){
    ErrorMayQuit("one parameter is not a polytope.",0,0);
    return NULL;
  }
#endif

#ifdef MORE_TESTS
  if( (!IS_INTOBJ(fact1)) || (!IS_INTOBJ(fact2))  ){
    ErrorMayQuit("one parameter is not an integer.",0,0);
    return NULL;
  }
#endif

  perlobj* poly1 = PERLOBJ_POLYMAKEOBJ( polytope1 );
  perlobj* poly2 = PERLOBJ_POLYMAKEOBJ( polytope2 );
  data->main_polymake_session->set_application_of(*poly1);
  
  perlobj sum;
  try{
    sum = polymake::call_function("minkowski_sum",INT_INTOBJ(fact1),*poly1,INT_INTOBJ(fact2),*poly2);
  }
  
  POLYMAKE_GAP_CATCH
  
  perlobj* sumpointer = new perlobj(sum);
  Obj elem = NewPolymakeExternalObject(T_POLYMAKE_EXTERNAL_POLYTOPE);
  POLYMAKEOBJ_SET_PERLOBJ(elem, sumpointer);
  return elem;
}


Obj REAL_LATTICE_POINTS_GENERATORS( Polymake_Data* data, Obj polytope ){
#ifdef MORE_TESTS
  if(! IS_POLYMAKE_POLYTOPE(polytope) ){
    ErrorMayQuit("argument is not a polytope",0,0);
    return NULL;
  }
#endif

  perlobj* polyobj = PERLOBJ_POLYMAKEOBJ( polytope );
  data->main_polymake_session->set_application_of(*polyobj);
  polymake::Array<polymake::Matrix<polymake::Integer>> array;
  try{
      array = polyobj->give("LATTICE_POINTS_GENERATORS");
  }
  
  POLYMAKE_GAP_CATCH
  
  Obj RET_ARRAY = NEW_PLIST( T_PLIST, 3 );
  SET_LEN_PLIST( RET_ARRAY, (UInt)3 );
  
  for( int index_of_array=0;index_of_array<3;index_of_array++ ){
    SET_ELM_PLIST( RET_ARRAY, index_of_array + 1, GAP_MATRIX_POLYMAKE_INTEGER_MATRIX( &(array[index_of_array]) ) );
    CHANGED_BAG( RET_ARRAY );
  }
  return RET_ARRAY;
  
}


Obj REAL_INTERSECTION_OF_POLYTOPES( Polymake_Data* data, Obj cone1, Obj cone2){

#ifdef MORE_TESTS
  if(! IS_POLYMAKE_POLYTOPE(cone1) || ! IS_POLYMAKE_POLYTOPE(cone2) ){
    ErrorMayQuit("argument is not a polytope",0,0);
    return NULL;
  }
#endif

  perlobj* coneobj1 = PERLOBJ_POLYMAKEOBJ( cone1 );
  perlobj* coneobj2 = PERLOBJ_POLYMAKEOBJ( cone2 );

  data->main_polymake_session->set_application_of( *coneobj1 );

  perlobj intersec = polymake::call_function( "intersection", *coneobj1, *coneobj2 );

  perlobj* returnobj = new perlobj(intersec);

  Obj elem = NewPolymakeExternalObject(T_POLYMAKE_EXTERNAL_POLYTOPE);
  
  POLYMAKEOBJ_SET_PERLOBJ( elem, returnobj );
  
  return elem;
  
}
