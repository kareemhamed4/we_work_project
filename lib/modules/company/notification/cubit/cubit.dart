import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:we_work/models/company/company_get_all_meetings_model.dart';
import 'package:we_work/models/company/company_get_user_applied_model.dart';
import 'package:we_work/modules/company/notification/cubit/states.dart';
import 'package:we_work/network/end_points.dart';
import 'package:we_work/network/remote/dio_helper_advanced.dart';
import 'package:we_work/shared/constants/constants.dart';

class CompanyGetUsersWhoAppliedCubit extends Cubit<CompanyGetUsersWhoAppliedStates> {
  CompanyGetUsersWhoAppliedCubit() : super(CompanyGetUsersWhoAppliedInitialState());

  static CompanyGetUsersWhoAppliedCubit get(context) => BlocProvider.of(context);

  int currentIndexForTabBar = 0;
  void changeTabBarIndex(int index) {
    currentIndexForTabBar = index;
    emit(ChangeTabBarIndexState());
  }

  List<CompanyGetAllUsersApplied>? companyGetAllUsersApplied;
  Future<void> companyGetAllUsersWhoApplied() async{
    emit(CompanyGetUsersWhoAppliedLoadingState());
    DioHelper.getData(
      url: COMPANYGETALLUSERSWHOAPPLIED,
      baseUrl: BASEURL,
      token: companyToken,
    ).then((value){
      List<dynamic> responseList = value.data;
      companyGetAllUsersApplied = responseList.map((json) {
        return CompanyGetAllUsersApplied.fromJson(json);
      }).toList();
      emit(CompanyGetUsersWhoAppliedSuccessState(companyGetAllUsersApplied!));
    }).catchError((error){
      if (error is DioError) {
        if (error.response?.statusCode == 401) {
          emit(CompanyGetUsersWhoAppliedErrorState("Unauthorized"));
        }else{
          emit(CompanyGetUsersWhoAppliedErrorState(error.toString()));
        }
    }
      else{
        emit(CompanyGetUsersWhoAppliedErrorState(error.toString()));
      }
    });
  }

  List<CompanyMeetingsModel>? companyMeetingsModel;
  Future<void> companyGetAllMeetings() async{
    emit(CompanyGetMeetingsLoadingState());
    DioHelper.getData(
      url: COMPANYGETALLMEETINGS,
      baseUrl: BASEURL,
      token: companyToken,
    ).then((value){
      List<dynamic> responseList = value.data;
      companyMeetingsModel = responseList.map((json) {
        return CompanyMeetingsModel.fromJson(json);
      }).toList();
      emit(CompanyGetMeetingsSuccessState(companyMeetingsModel!));
    }).catchError((error){
      if (error is DioError) {
        if (error.response?.statusCode == 401) {
          emit(CompanyGetMeetingsErrorState("Unauthorized"));
        }else{
          emit(CompanyGetMeetingsErrorState(error.toString()));
        }
      }
      else{
        emit(CompanyGetMeetingsErrorState(error.toString()));
      }
    });
  }

  Future<void> companyDeleteAcceptedOffer({
    required int meetingId,
  }) async{
    emit(CompanyDeleteSentAcceptedOfferLoadingState());
    await DioHelper.deleteData(
      url: "$COMPANYDELETEACCEPTEDOFFER$meetingId",
      token: companyToken,
      baseUrl: BASEURL,
    ).then((value) {
      emit(CompanyDeleteSentAcceptedOfferSuccessState(value.data.toString()));
      companyGetAllMeetings();
    }).catchError((error) {
      if (error is DioError) {
        if (error.response?.statusCode == 404) {
          final errorMessage = error.response?.data.toString();
          emit(CompanyDeleteSentAcceptedOfferErrorState(errorMessage!));
        } else {
          // Handle other DioError cases
          emit(CompanyDeleteSentAcceptedOfferErrorState('An error occurred. Please try again.'));
        }
      } else {
        // Handle non-DioError cases
        emit(CompanyDeleteSentAcceptedOfferErrorState('An error occurred. Please try again.'));
      }
    });
  }

  CompanyGetAllUsersApplied? companyGetUserApplied;
  Future<void> companyGetUserWhoApplied({
    required int id,
  }) async {
    emit(CompanyGetUserAppliedLoadingState());
    try {
      final response = await DioHelper.getData(
        url: "$COMPANYGETUSERWHOAPPLIED$id",
        baseUrl: BASEURL,
        token: companyToken,
      );
      companyGetUserApplied = CompanyGetAllUsersApplied.fromJson(response.data);
      emit(CompanyGetUserAppliedSuccessState(companyGetUserApplied!));
    } catch (error) {
      if (error is DioError) {
        if (error.response?.statusCode == 404) {
          final responseData = error.response?.data;
          final errorMessage = responseData["title"];
          emit(CompanyGetUserAppliedErrorState(errorMessage));
        } else {
          emit(CompanyGetUserAppliedErrorState(error.toString()));
        }
      } else {
        emit(CompanyGetUserAppliedErrorState(error.toString()));
      }
    }
  }

  Future<void> companyDeclineUserApplied({
    required int applicantId,
  }) async{
    emit(CompanyDeclineUserAppliedLoadingState());
    await DioHelper.deleteData(
      url: "$COMPANYDECLINEUSERAPPLIED$applicantId",
      token: companyToken,
      baseUrl: BASEURL,
    ).then((value) {
      emit(CompanyDeclineUserAppliedSuccessState("Applicant Declined Successfully!"));
      companyGetAllUsersWhoApplied();
    }).catchError((error) {
      if (error is DioError) {
        if (error.response?.statusCode == 404) {
          final errorResponse = error.response?.data;
          final errorMessage = errorResponse["title"];
          emit(CompanyDeclineUserAppliedErrorState(errorMessage));
        } else {
          // Handle other DioError cases
          emit(CompanyDeclineUserAppliedErrorState('An error occurred. Please try again.'));
        }
      } else {
        // Handle non-DioError cases
        emit(CompanyDeclineUserAppliedErrorState('An error occurred. Please try again.'));
      }
    });
  }
}
