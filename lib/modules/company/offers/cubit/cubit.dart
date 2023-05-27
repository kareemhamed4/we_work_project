import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:we_work/models/company/company_get_freelance_offers.dart';
import 'package:we_work/models/company/company_get_sent_offers_model.dart';
import 'package:we_work/modules/company/offers/cubit/states.dart';
import 'package:we_work/network/end_points.dart';
import 'package:we_work/network/remote/dio_helper_advanced.dart';
import 'package:we_work/shared/constants/constants.dart';

class CompanyOffersCubit extends Cubit<CompanyOffersStates> {
  CompanyOffersCubit() : super(CompanyOffersInitialState());

  static CompanyOffersCubit get(context) => BlocProvider.of(context);

  List<CompanyGetSentOffersModel>? companyGetSentOffersModel;
  void companyGetAllSentOffers() async {
    emit(CompanyGetAllSentOffersLoadingState());
    try {
      final response = await DioHelper.getData(
        url: COMPANYGETSENTOFFERS,
        baseUrl: BASEURL,
        token: companyToken,
      );
      List<dynamic> responseList = response.data;
      companyGetSentOffersModel = responseList.map((json) {
        return CompanyGetSentOffersModel.fromJson(json);
      }).toList();
      emit(CompanyGetAllSentOffersSuccessState(companyGetSentOffersModel!));
    } catch (error) {
      if (error is DioError) {
        if (error.response?.statusCode == 400) {
          final responseData = error.response?.data;
          final errorMessage = responseData["errors"];
          emit(CompanyGetAllSentOffersErrorState(errorMessage));
        } else {
          emit(CompanyGetAllSentOffersErrorState(error.toString()));
        }
      } else {
        emit(CompanyGetAllSentOffersErrorState(error.toString()));
      }
    }
  }

  List<CompanyGetFreelanceOffersModel>? companyGetFreelanceOffersModel;
  void companyGetAllFreelanceOffers() async {
    emit(CompanyGetAllFreelanceOffersLoadingState());
    try {
      final response = await DioHelper.getData(
        url: COMPANYGETFREELANCEOFFERS,
        baseUrl: BASEURL,
        token: companyToken,
      );
      List<dynamic> responseList = response.data;
      companyGetFreelanceOffersModel = responseList.map((json) {
        return CompanyGetFreelanceOffersModel.fromJson(json);
      }).toList();
      emit(CompanyGetAllFreelanceOffersSuccessState(companyGetFreelanceOffersModel!));
    } catch (error) {
      if (error is DioError) {
        if (error.response?.statusCode == 400) {
          final responseData = error.response?.data;
          final errorMessage = responseData["errors"];
          emit(CompanyGetAllFreelanceOffersErrorState(errorMessage));
        } else {
          emit(CompanyGetAllFreelanceOffersErrorState(error.toString()));
        }
      } else {
        emit(CompanyGetAllFreelanceOffersErrorState(error.toString()));
      }
    }
  }

  Future<void> companyDeleteSentOffer({
    required int offerId,
  }) async{
    emit(CompanyDeleteSentOfferLoadingState());
    await DioHelper.deleteData(
      url: "$COMPANYDELETESENDOFFER$offerId",
      token: companyToken,
      baseUrl: BASEURL,
    ).then((value) {
      emit(CompanyDeleteSentOfferSuccessState(value.data.toString()));
      companyGetAllSentOffers();
    }).catchError((error) {
      if (error is DioError) {
        if (error.response?.statusCode == 404) {
          final errorMessage = error.response?.data.toString();
          emit(CompanyDeleteSentOfferErrorState(errorMessage!));
        } else {
          // Handle other DioError cases
          emit(CompanyDeleteSentOfferErrorState('An error occurred. Please try again.'));
        }
      } else {
        // Handle non-DioError cases
        emit(CompanyDeleteSentOfferErrorState('An error occurred. Please try again.'));
      }
    });
  }

  String? meetingUrl;
  Future<void> createZoomMeeting({
    required String topic,
    required String agenda,
    required String date,
    required double time,
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


  Future<void> companyAcceptFreelanceOffer({
    required String userId,
    required String message,
    required String meetingDate,
    required String meetingLink,
  }) async{
    emit(CompanyAcceptFreeLanceOfferLoadingState());
    await DioHelper.postData(
      url: "$COMPANYACCEPTFREELANCEOFFER$userId",
      token: companyToken,
      baseUrl: BASEURL,
      data: {
        "Message": message,
        "MeedtingDate": meetingDate,
        "MeetingLink": meetingLink,
      },
    ).then((value) {
      emit(CompanyAcceptFreeLanceOfferSuccessState(value.data.toString()));
    }).catchError((error) {
      if (error is DioError) {
        if (error.response?.statusCode == 400) {
          final errorResponse = error.response?.data;
          final errorMessage = errorResponse["errors"];
          emit(CompanyAcceptFreeLanceOfferErrorState(errorMessage!));
        } else {
          print(error.toString());
          emit(CompanyAcceptFreeLanceOfferErrorState('An error occurred. Please try again.'));
        }
      } else {
        print(error.toString());
        emit(CompanyAcceptFreeLanceOfferErrorState('An error occurred. Please try again.'));
      }
    });
  }

  double rate = 3.5;
  Future<void> companyRateUser({
    required String userId,
    required int rate,
  }) async{
    emit(CompanyRateUserLoadingState());
    await DioHelper.postData(
      url: "$COMPANYRATEUSER$userId/ratings",
      token: companyToken,
      baseUrl: BASEURL,
      data: {
        "Value": rate,
      },
    ).then((value) {
      emit(CompanyRateUserSuccessState("Rated Successfully!"));
    }).catchError((error) {
      if (error is DioError) {
        if (error.response?.statusCode == 400) {
          emit(CompanyRateUserErrorState('An error occurred. Please try again.'));
        } else {
          print(error.toString());
          emit(CompanyRateUserErrorState('An error occurred. Please try again.'));
        }
      } else {
        print(error.toString());
        emit(CompanyRateUserErrorState('An error occurred. Please try again.'));
      }
    });
  }
}
