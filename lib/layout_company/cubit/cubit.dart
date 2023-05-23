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

  String? meetingUrl;
  Future<void> createZoomMeeting({
    required String topic,
    required String agenda,
    required String date,
    required String time,
    required int duration,
  }) async {
    emit(CreateMeetingLoadingState());
    DioHelper.postData(
      url: CREATEZOOMMEETING,
      baseUrl: BASEURL,
      data: {
        "id": "string",
        "topic": topic,
        "agenda": agenda,
        "date": date,
        "time": time,
        "duration": duration,
        "timeZone": "string",
      },
    ).then((value){
      if(value.statusCode == 200){
        meetingUrl = value.data.last;
        emit(CreateMeetingSuccessState(meetingUrl!));
      }
    }).catchError((error){
      emit(CreateMeetingErrorState(error.toString()));
    });
  }

  void launchZoomMeeting() async {
    if (meetingUrl == null) {
      throw 'Meeting URL is null or not assigned.';
    }

    final String url = meetingUrl!;

    if (await canLaunch(url)) {
      await launch(url);
    } else {
      await launch(url);
    }
  }
}
