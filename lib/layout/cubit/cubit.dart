import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:we_work/layout/cubit/states.dart';
import 'package:we_work/modules/user/home/home.dart';
import 'package:we_work/modules/user/offers/offers_screen.dart';
import 'package:we_work/modules/user/profile/user_profile.dart';
import 'package:we_work/modules/user/notification/notification_Screen.dart';
import 'package:we_work/modules/user/saved_jobs/saved_job.dart';

class LayoutCubit extends Cubit<LayoutStates> {
  LayoutCubit() : super(LayoutInitialState());
  static LayoutCubit get(context) => BlocProvider.of(context);

  List<Widget> screens = [
    const UserHomeScreen(),
    NotificationScreen(),
    SavedJob(),
    OffersScreen(),
    const MyProfile(),
  ];

  int currentIndex = 0;
  void changeIndex(index) {
    currentIndex = index;
    emit(ChangeBottomNavBarState());
  }

  void launchZoomMeeting({
    required String? meetingUrl,
  }) async {
    if (meetingUrl == null) {
      throw 'Meeting URL is null or not assigned.';
    }
    final String url = meetingUrl;
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      await launch(url);
    }
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
