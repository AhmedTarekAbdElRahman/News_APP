import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/layout/news_app/cubit/states.dart';

import '../../../modules/news_app/business/business_screen.dart';
import '../../../modules/news_app/science/science_screen.dart';
import '../../../modules/news_app/sports/sports_screen.dart';
import '../../../shared/network/remote/dio_helper.dart';

class NewsCubit extends Cubit<NewStates>{
  NewsCubit() : super(NewsInitialState());
  static NewsCubit get(contex)=> BlocProvider.of(contex);
  int currentIndex =0;
  List <BottomNavigationBarItem> bottomItems=[
    const BottomNavigationBarItem(
      icon: Icon(
       Icons.business,
     ),
      label:'Business'
    ),
    const BottomNavigationBarItem(
        icon: Icon(
          Icons.sports,
        ),
        label:'Sports'
    ),
    const BottomNavigationBarItem(
        icon: Icon(
          Icons.science,
        ),
        label:'Science'
    ),
  ];
  List<Widget>screens=[
    BusinessScreen(),
    SportsScreen(),
    ScienceScreen(),
  ];
  void changeBottomNavBar(int index){
    currentIndex=index;
    if(index==1)
      getSports();
    if(index==2)
      getScience();
    emit(NewsBottomNavState());
  }

  List<dynamic>business=[];
  void getBusiness(){
    if(business.length==0){
      emit(NewsGetBusinessLoadingState());
      DioHelper.getData(
        url: 'v2/top-headlines',
        query: {
          'country':'eg',
          'category':'business',
          'apiKey':'e524bdb94d5d4f6c9a511932357502e4'
        },
      ).then((value) {
        print(value.data['articles'][0]['title']);
        business=value.data['articles'];
        print(business[0]['title']);
        emit(NewsGetBusinessSuccessState());
      }).catchError((error){
        print(error.toString());
        emit(NewsGetBusinessErrorState(error.toString()));
      });
    }
    else{
      emit(NewsGetBusinessSuccessState());
    }
  }

  List<dynamic>sports=[];
  void getSports(){
    if(sports.length==0){
      emit(NewsGetSportsLoadingState());
      DioHelper.getData(
        url: 'v2/top-headlines',
        query: {
          'country':'eg',
          'category':'sports',
          'apiKey':'e524bdb94d5d4f6c9a511932357502e4'
        },
      ).then((value) {
        //print(value.data['articles'][0]['title']);
        sports=value.data['articles'];
        print(sports[0]['title']);
        emit(NewsGetSportsSuccessState());
      }).catchError((error){
        print(error.toString());
        emit(NewsGetSportsErrorState(error.toString()));
      });
    }
    else{
      emit(NewsGetSportsSuccessState());
    }
  }

  List<dynamic>science=[];
  void getScience(){
    if(science.length==0){
      emit(NewsGetScienceLoadingState());
      DioHelper.getData(
        url: 'v2/top-headlines',
        query: {
          'country':'eg',
          'category':'science',
          'apiKey':'e524bdb94d5d4f6c9a511932357502e4'
        },
      ).then((value) {
        //print(value.data['articles'][0]['title']);
        science=value.data['articles'];
        print(science[0]['title']);
        emit(NewsGetScienceSuccessState());
      }).catchError((error){
        print(error.toString());
        emit(NewsGetScienceErrorState(error.toString()));
      });
    }
    else{
      emit(NewsGetScienceSuccessState());
    }


  }

  List<dynamic>search=[];
  void  getSearch(String value){
    emit(NewsGetSearchLoadingState());
    DioHelper.getData(
      url: 'v2/everything',
      query: {
        'q':'$value',
        'apiKey':'e524bdb94d5d4f6c9a511932357502e4'
      },
    ).then((value) {
      //print(value.data['articles'][0]['title']);
      search=value.data['articles'];
      print(search[0]['title']);
      emit(NewsGetSearchSuccessState());
    }).catchError((error){
      print(error.toString());
      emit(NewsGetSearchErrorState(error.toString()));
    });
  }
}

