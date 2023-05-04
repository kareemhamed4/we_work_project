import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:we_work/layout/cubit/states.dart';
import 'package:we_work/modules/user/offers/offers_screen.dart';
import 'package:we_work/modules/user/drawer/drawer.dart';
import 'package:we_work/modules/user/profile/myProfile.dart';
import 'package:we_work/modules/user/notification/notification_Screen.dart';
import 'package:we_work/modules/user/saved_jobs/saved_Job.dart';

class LayoutCubit extends Cubit<LayoutStates> {
  LayoutCubit() : super(LayoutInitialState());
  static LayoutCubit get(context) => BlocProvider.of(context);

  List<Widget> screens = [
    DrawerMyUser(),
    NotificationScreen(),
    SavedJob(),
    const OffersScreen(),
    MyProfile(),
  ];

  int currentIndex = 0;
  void changeIndex(index) {
    currentIndex = index;
    emit(ChangeBottomNavBarState());
  }
}
