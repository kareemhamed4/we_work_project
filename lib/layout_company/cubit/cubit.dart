import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:we_work/layout_company/cubit/states.dart';
import 'package:we_work/modules/company/home/home.dart';
import 'package:we_work/modules/company/offers/offers_screen.dart';
import 'package:we_work/modules/company/profile/company_profile.dart';
import 'package:we_work/modules/company/notification/notification_screen.dart';

class LayoutCompanyCubit extends Cubit<LayoutCompanyStates> {
  LayoutCompanyCubit() : super(LayoutCompanyInitialState());
  static LayoutCompanyCubit get(context) => BlocProvider.of(context);

  List<Widget> companyScreens = [
    const CompanyHome(),
    const CompanyNotificationScreen(),
    const SizedBox(),
    CompanyOffersScreen(),
    const CompanyProfile()
  ];

  int currentIndex = 0;
  void changeIndex(index, context) {
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
