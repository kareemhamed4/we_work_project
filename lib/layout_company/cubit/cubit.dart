import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:we_work/layout_company/cubit/states.dart';
import 'package:we_work/modules/company/drawer/drawer_company.dart';
import 'package:we_work/modules/company/home/cubit/cubit.dart';
import 'package:we_work/modules/company/notification/cubit/cubit.dart';
import 'package:we_work/modules/company/offers/offers_screen.dart';
import 'package:we_work/modules/company/profile/company_profile.dart';
import 'package:we_work/modules/company/notification/notification_Screen.dart';
import 'package:we_work/network/end_points.dart';
import 'package:we_work/network/remote/dio_helper_advanced.dart';

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
  void changeIndex(index, context) {
    if (index == 1) {
      CompanyGetUsersWhoAppliedCubit.get(context)
          .companyGetAllUsersWhoApplied();
    }
    if (index == 0) {
      CompanyHomeCubit.get(context).companyGetAllUsers();
    }
    currentIndex = index;
    emit(ChangeBottomNavBarCompanyState());
  }

  bool floatingButtonToggle = false;
  void changeToggle() {
    floatingButtonToggle = !floatingButtonToggle;
    emit(ChangeFloatingToggleCompanyState());
  }

  Future<void> launchInBrowser(Uri url) async {
    if (!await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    )) {
      throw Exception('Could not launch $url');
    }
  }

  Future<void> launchInWebViewOrVC(Uri url) async {
    if (!await launchUrl(
      url,
      mode: LaunchMode.inAppWebView,
      webViewConfiguration: const WebViewConfiguration(
          headers: <String, String>{'my_header_key': 'my_header_value'}),
    )) {
      throw Exception('Could not launch $url');
    }
  }
}
