import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../modules/business/business_screen.dart';
import '../../../modules/science/science_screen.dart';
import '../../../modules/settings/settings_screen.dart';
import '../../../modules/sports/sports_screen.dart';
import '../../network/remote/dio_helper.dart';
import 'state.dart';

class NewsCubit extends Cubit<NewsStates> {
  NewsCubit() : super(NewsInitialState());

  static NewsCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  List<BottomNavigationBarItem> bottomItems = [
    const BottomNavigationBarItem(
        icon: Icon(
          Icons.business,
        ),
        label: "Business"),
    const BottomNavigationBarItem(
        icon: Icon(
          Icons.sports,
        ),
        label: "Sports"),
    const BottomNavigationBarItem(
        icon: Icon(
          Icons.science,
        ),
        label: "Science"),
  ];

  List<Widget> screens = [
    const BusinessScreen(),
    const SportScreen(),
    const ScienceScreen(),
  ];

  void changeBottomNavBar(int index) {
    currentIndex = index;
    emit(NewsBottomNavState());
  }

  List<dynamic> business = [];

  void getBusiness() {
    emit(NewsGetBusinessLoadingState());
    DioHelper.getData(
      url: 'v2/top-headlines',
      query: {
        'country': 'us',
        'category': 'business',
        'apiKey': '368c1426fd53417ea19cb75827145b25'
      },
    ).then((value) {
      business = value?.data['articles'];
      print(business[0]['title']);
      emit(NewsGetBusinessSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(NewsGetBusinessErrorState(error.toString()));
    });
  }

  List<dynamic> sports = [];

  void getSports() {
    emit(NewsGetSportsLoadingState());
    // if (sports.length == 0) {
    DioHelper.getData(
      url: 'v2/top-headlines',
      query: {
        'country': 'us',
        'category': 'sports',
        'apiKey': '368c1426fd53417ea19cb75827145b25'
      },
    ).then((value) {
      sports = value?.data['articles'];
      print(sports[0]['title']);
      emit(NewsGetSportsSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(NewsGetSportsErrorState(error.toString()));
    });
    // } else {
    //   emit(NewsGetSportsSuccessState());
    // }
  }

  List<dynamic> science = [];

  void getScience() {
    emit(NewsGetScienceLoadingState());
    // if (science.length == 0) {
    DioHelper.getData(
      url: 'v2/top-headlines',
      query: {
        'country': 'us',
        'category': 'science',
        'apiKey': '368c1426fd53417ea19cb75827145b25'
      },
    ).then((value) {
      science = value?.data['articles'];
      print(science[0]['title']);
      emit(NewsGetScienceSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(NewsGetScienceErrorState(error.toString()));
    });
    // } else {
    //   emit(NewsGetScienceSuccessState());
    // }
  }
}
