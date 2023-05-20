import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:we_work/layout_company/cubit/states.dart';
import 'package:we_work/modules/company/drawer/drawer_company.dart';
import 'package:we_work/modules/company/notification/cubit/cubit.dart';
import 'package:we_work/modules/company/offers/offers_screen.dart';
import 'package:we_work/modules/company/profile/profile.dart';
import 'package:we_work/modules/company/notification/notification_Screen.dart';

class LayoutCompanyCubit extends Cubit<LayoutCompanyStates> {
  LayoutCompanyCubit() : super(LayoutCompanyInitialState());
  static LayoutCompanyCubit get(context) => BlocProvider.of(context);

  List<Widget> companyScreens = const [
    DrawerCompany(),
    CompanyNotificationScreen(),
    SizedBox(),
    CompanyOffersScreen(),
    CompanyProfile()
  ];

  int currentIndex = 0;
  void changeIndex(index,context) {
    if(index == 1){
      CompanyGetUsersWhoAppliedCubit.get(context).companyGetAllUsersWhoApplied();
    }
    currentIndex = index;
    emit(ChangeBottomNavBarCompanyState());
  }

  bool floatingButtonToggle = false;
  void changeToggle() {
    floatingButtonToggle = !floatingButtonToggle;
    emit(ChangeFloatingToggleCompanyState());
  }
}
