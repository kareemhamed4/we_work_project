import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:we_work/layout_company/cubit/states.dart';
import 'package:we_work/modules/company/drawer/drawer_company.dart';
import 'package:we_work/modules/company/offers/offers_screen.dart';
import 'package:we_work/modules/company/profile/profile.dart';
import 'package:we_work/screen/company_screen/company_notification_Screen.dart';

class LayoutCompanyCubit extends Cubit<LayoutCompanyStates> {
  LayoutCompanyCubit() : super(LayoutCompanyInitialState());
  static LayoutCompanyCubit get(context) => BlocProvider.of(context);

  List<Widget> companyScreens = [
    const DrawerCompany(),
    CompanNotificationScreen(),
    const SizedBox(),
    const CompanyOffersScreen(),
    const CompanyProfile()
  ];

  int currentIndex = 0;
  void changeIndex(index) {
    currentIndex = index;
    emit(ChangeBottomNavBarCompanyState());
  }
}
