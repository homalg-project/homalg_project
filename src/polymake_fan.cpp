#include "polymake_fan.h"

Obj REAL_FAN_BY_CONES_SAVE( Polymake_Data* data, Obj cones ){
  
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
  pm::Array< pm::Set<pm::Integer> > incMatr(numberofcones,pm::Set<pm::Integer>());
  pm::Rational ratarray[ (numberofrays+1)*dimension ];
  int raycounter = 1;
  for(int i = 0; i < dimension; i++ )
    ratarray[i] = 0;
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
                
                ratarray[ raycounter*dimension+(k-1) ] = INT_INTOBJ( numb );
              
            }
            (incMatr[i-1]).collect(raycounter);
            raycounter++;
        }
  }
  
  pm::Matrix<pm::Rational>* matr = new pm::Matrix<pm::Rational>((numberofrays+1),dimension,ratarray);
  perlobj q;
  CallPolymakeFunction("check_fan",*matr,incMatr) >> q;
  data->polymake_objects->insert( object_pair(data->new_polymake_object_number, &q ) );
  elem = INTOBJ_INT( data->new_polymake_object_number );
  data->new_polymake_object_number++;
  return elem;
}



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
  pm::Array< pm::Set<pm::Integer> > incMatr(numberofcones,pm::Set<pm::Integer>());
  pm::Rational ratarray[ (numberofrays+1)*dimension ];
  int raycounter = 1;
  for(int i = 0; i < dimension; i++ )
    ratarray[i] = 0;
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
                
                ratarray[ raycounter*dimension+(k-1) ] = INT_INTOBJ( numb );
              
            }
            (incMatr[i-1]).collect(raycounter);
            raycounter++;
        }
  }
  pm::Matrix<pm::Rational>* matr = new pm::Matrix<pm::Rational>((numberofrays+1),dimension,ratarray);
  perlobj* q = new perlobj("PolyhedralFan<Rational>");
  q->take("INPUT_RAYS") << *matr;
  q->take("INPUT_CONES") << incMatr;
  data->polymake_objects->insert( object_pair(data->new_polymake_object_number, q ) );
  elem = INTOBJ_INT( data->new_polymake_object_number );
  data->new_polymake_object_number++;
  return elem;
}
