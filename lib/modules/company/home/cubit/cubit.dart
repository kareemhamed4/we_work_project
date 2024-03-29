import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:we_work/models/company/company_get_all_users_model.dart';
import 'package:we_work/models/company/company_get_jobs_model.dart';
import 'package:we_work/modules/company/home/cubit/states.dart';
import 'package:we_work/network/end_points.dart';
import 'package:we_work/network/remote/dio_helper_advanced.dart';
import 'package:we_work/shared/constants/constants.dart';

class CompanyHomeCubit extends Cubit<CompanyHomeStates> {
  CompanyHomeCubit() : super(CompanyHomeInitialState());

  static CompanyHomeCubit get(context) => BlocProvider.of(context);

  CompanyGetAllUsersModel? companyGetAllUsersModel;
  CompanyGetAllUsersModel? companyGetFilteredUsersModel;
  void companyGetAllUsers({
    String? country,
    String? city,
    String? jobType,
    String? position,
    String? experience,
}) async {
    emit(CompanyGetAllUsersLoadingState());
    try {
      final response = await DioHelper.getData(
        url: COMPANYGETALLUSERS,
        baseUrl: BASEURL,
        token: companyToken,
        query: {
          "country": country ?? "",
          "city": city ?? "",
          "jobType": jobType ?? "",
          "position": position ?? "",
          "experince": experience ?? "",
        },
      );
      if (country != null &&
          position != null &&
          experience != null &&
          jobType != null &&
          city != null){
        companyGetFilteredUsersModel = CompanyGetAllUsersModel.fromJson(response.data);
      }else{
        companyGetAllUsersModel = CompanyGetAllUsersModel.fromJson(response.data);
      }
      emit(CompanyGetAllUsersSuccessState(companyGetAllUsersModel!));
    } catch (error) {
      if (error is DioError) {
        if (error.response?.statusCode == 400) {
          final responseData = error.response?.data;
          final errorMessage = responseData["errors"];
          emit(CompanyGetAllUsersErrorState(errorMessage));
        } else {
          emit(CompanyGetAllUsersErrorState(error.toString()));
        }
      } else {
        emit(CompanyGetAllUsersErrorState(error.toString()));
      }
    }
  }

  void companySendOfferToUser({
    required String message,
    required String uId,
}) async {
    emit(CompanySendOfferToUserLoadingState());
    try {
      await DioHelper.postData(
        url: "$COMPANYSENDOFFERTOUSER$uId",
        baseUrl: BASEURL,
        token: companyToken,
        data: {
          "Message":message
        }
      );
      emit(CompanySendOfferToUserSuccessState("Offer Created Successfully!"));
    } catch (error) {
      if (error is DioError) {
        if (error.response?.statusCode == 400) {
          final responseData = error.response?.data.toString();
          emit(CompanySendOfferToUserErrorState(responseData!));
        } else {
          emit(CompanySendOfferToUserErrorState(error.toString()));
        }
      } else {
        emit(CompanySendOfferToUserErrorState(error.toString()));
      }
    }
  }

  Future<void> companyGetUserDetails({
    required int id,
}) async {
    emit(CompanyGetUserDetailsLoadingState());
    try {
      final response = await DioHelper.getData(
        url: "$COMPANYGETALLUSERS$id",
        baseUrl: BASEURL,
        token: companyToken,
      );
      companyGetAllUsersModel = CompanyGetAllUsersModel.fromJson(response.data);
      emit(CompanyGetUserDetailsSuccessState(companyGetAllUsersModel!));
    } catch (error) {
      if (error is DioError) {
        if (error.response?.statusCode == 400) {
          final responseData = error.response?.data;
          final errorMessage = responseData["errors"];
          emit(CompanyGetUserDetailsErrorState(errorMessage));
        } else {
          emit(CompanyGetUserDetailsErrorState(error.toString()));
        }
      } else {
        emit(CompanyGetUserDetailsErrorState(error.toString()));
      }
    }
  }

  List<CompanyGetJobsModel>? companyGetJobsModel;
  void companyGetHerJobs() async {
    emit(CompanyGetHerJobsLoadingState());
    try {
      final response = await DioHelper.getData(
        url: COMPANYGETALLHERJOBS,
        baseUrl: BASEURL,
        token: companyToken,
      );
      List<dynamic> responseList = response.data;
      companyGetJobsModel = responseList.map((json) {
        return CompanyGetJobsModel.fromJson(json);
      }).toList();
      emit(CompanyGetHerJobsSuccessState(companyGetJobsModel!));
    } catch (error) {
      if (error is DioError) {
        if (error.response?.statusCode == 400) {
          final responseData = error.response?.data;
          final errorMessage = responseData["errors"];
          emit(CompanyGetHerJobsErrorState(errorMessage));
        } else {
          emit(CompanyGetHerJobsErrorState(error.toString()));
        }
      } else {
        emit(CompanyGetHerJobsErrorState(error.toString()));
      }
    }
  }

  CompanyGetAllUsersModel? companyGetSearchedUsersModel;
  void companyGetSearchedUsers({
    required String search,
    String? country,
    String? city,
    String? jobType,
    String? position,
    String? experience,
  }) async {
    emit(CompanyGetSearchedUsersLoadingState());
    try {
      final response = await DioHelper.getData(
        url: COMPANYGETALLUSERS,
        baseUrl: BASEURL,
        token: companyToken,
        query: {
          "search": search,
          "country": country ?? "",
          "city": city ?? "",
          "jobType": jobType ?? "",
          "position": position ?? "",
          "experince": experience ?? "",
        },
      );
      companyGetSearchedUsersModel = CompanyGetAllUsersModel.fromJson(response.data);
      emit(CompanyGetSearchedUsersSuccessState(companyGetSearchedUsersModel!));
    } catch (error) {
      if (error is DioError) {
        if (error.response?.statusCode == 400) {
          final responseData = error.response?.data;
          final errorMessage = responseData["errors"]["Search"][0];
          emit(CompanyGetSearchedUsersErrorState(errorMessage));
        } else {
          emit(CompanyGetSearchedUsersErrorState(error.toString()));
        }
      } else {
        emit(CompanyGetSearchedUsersErrorState(error.toString()));
      }
    }
  }

  Future<void> companyDeleteHeyJob({
    required int jobId,
  }) async{
    emit(CompanyDeleteHerJobLoadingState());
    await DioHelper.deleteData(
      url: "$COMPANYDELETEHERJOB$jobId",
      token: companyToken,
      baseUrl: BASEURL,
    ).then((value) {
      emit(CompanyDeleteHerJobSuccessState(value.data.toString()));
      companyGetHerJobs();
    }).catchError((error) {
      if (error is DioError) {
        if (error.response?.statusCode == 404) {
          final errorResponse = error.response?.data;
          final errorMessage = errorResponse["title"];
          emit(CompanyDeleteHerJobErrorState(errorMessage));
        } else {
          // Handle other DioError cases
          emit(CompanyDeleteHerJobErrorState('An error occurred. Please try again.'));
        }
      } else {
        // Handle non-DioError cases
        emit(CompanyDeleteHerJobErrorState('An error occurred. Please try again.'));
      }
    });
  }
}
