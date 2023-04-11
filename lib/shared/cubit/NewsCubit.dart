import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/modules/ScienceScreen.dart';

import 'package:news_app/modules/SportsScreen.dart';
import 'package:news_app/shared/cubit/news_states.dart';
import 'package:flutter/material.dart';
import 'package:news_app/modules/BusinessScreen.dart';
import 'package:news_app/shared/local/ChacheHelper.dart';

import '../network/DioHelper.dart';

class NewsCubit extends Cubit<NewsStates>{
  NewsCubit() : super(NewsInitial());

  static NewsCubit get(context) => BlocProvider.of(context);

  static bool iconDark = false;

  List<BottomNavigationBarItem> navigationItems = const [
    BottomNavigationBarItem(icon: Icon(Icons.business_center),label: 'Business'),
    BottomNavigationBarItem(icon: Icon(Icons.sports_baseball_outlined),label: 'Sports'),
    BottomNavigationBarItem(icon: Icon(Icons.science),label: 'Science'),
  ];
  int currentIndex = 0;
  List<Widget> screens = const [
    BusinessScreen(),
    SportsScreen(),
    ScienceScreen(),
  ];
  List<dynamic> businessList = [];
  List<dynamic> sportsList = [];
  List<dynamic> scienceList = [];
  List<dynamic> searchList = [];
  TextEditingController searchController = TextEditingController();

  void getSearch(String value){
    print(value);
    emit(SearchGetDataLoadingState());
    searchList = [];
    if(searchList.isEmpty){
      DioHelper.getData(
          url: '/v2/everything/',
          query: {
            'q' : value,
            'apiKey' : 'e3ad341320d14c3396066b0f068c470e',
          }
      ).then((value){
        searchList = value?.data['articles'];
        // print(value?.data['articles']);
        emit(SearchGetDataSuccessState());
      }).catchError((error){
        print(error);
        emit(SearchGetDataErrorState(error.toString()));
      });
    }
    else {
      emit(SearchGetDataSuccessState());
    }
  }
  void changeThemeMode(isDark){
    if(isDark != null) {
      iconDark = CacheHelper.getCacheBool(key: 'isDark')!;
      emit(ChangeThemeMode());
    } else {
      iconDark = !iconDark;
      CacheHelper.setCacheBool(key: 'isDark', value: iconDark).then((value){
        emit(ChangeThemeMode());
      });
    }
  }
  void changeBottomIndex(int index){
    currentIndex = index;
    if(currentIndex == 1) sportsGetData();
    else if(currentIndex == 2) scienceGetData();
    emit(BottomNavbarChange());
  }
  void businessGetData(){
    emit(BusinessGetDataLoadingState());
    businessList = [];
    if(businessList.isEmpty){
      DioHelper.getData(
          url: '/v2/top-headlines/',
          query: {
            'country' : 'us',
            'category' : 'business',
            'apiKey' : 'e3ad341320d14c3396066b0f068c470e',
            'pageSize' : 50,
          }
      ).then((value){
        businessList = value?.data['articles'];
        // print(value?.data['articles']);
        emit(BusinessGetDataSuccessState());
      }).catchError((error){
        print(error);
        emit(BusinessGetDataErrorState(error.toString()));
      });
    }
    else{
      emit(BusinessGetDataSuccessState());
    }
  }
  void sportsGetData(){
    emit(SportsGetDataLoadingState());
    sportsList = [];
    if(sportsList.isEmpty){
      DioHelper.getData(
          url: '/v2/top-headlines/',
          query: {
            'country' : 'us',
            'category' : 'sports',
            'apiKey' : 'e3ad341320d14c3396066b0f068c470e',
            'pageSize' : 50,
          }
      ).then((value){
        sportsList = value?.data['articles'];
        // print(value?.data['articles']);
        emit(SportsGetDataSuccessState());
      }).catchError((error){
        print(error);
        emit(SportsGetDataErrorState(error.toString()));
      });
    }
    else{
      emit(SportsGetDataSuccessState());
    }
  }
  void scienceGetData(){
    emit(ScienceGetDataLoadingState());
    scienceList = [];
    if(scienceList.isEmpty){
      DioHelper.getData(
          url: '/v2/top-headlines/',
          query: {
            'country' : 'us',
            'category' : 'science',
            'apiKey' : 'e3ad341320d14c3396066b0f068c470e',
            'pageSize' : 50,
          }
      ).then((value){
        scienceList = value?.data['articles'];
        // print(value?.data['articles']);
        emit(ScienceGetDataSuccessState());
      }).catchError((error){
        print(error);
        emit(ScienceGetDataErrorState(error.toString()));
      });
    }
    else {
      emit(ScienceGetDataSuccessState());
    }
  }
}

