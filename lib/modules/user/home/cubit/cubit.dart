import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:we_work/models/user/user_get_all_jobs_model.dart';
import 'package:we_work/models/user/user_get_freelance_details_model.dart';
import 'package:we_work/models/user/user_get_freelance_jobs_model.dart';
import 'package:we_work/models/user/user_get_job_details_model.dart';
import 'package:we_work/modules/user/home/cubit/states.dart';
import 'package:we_work/network/end_points.dart';
import 'package:we_work/network/remote/dio_helper_advanced.dart';
import 'package:we_work/shared/constants/constants.dart';

class UserHomeCubit extends Cubit<UserHomeStates> {
  UserHomeCubit() : super(UserHomeInitialState());

  static UserHomeCubit get(context) => BlocProvider.of(context);

  UserGetAllJobsModel? userGetAllJobsModel;
  UserGetAllJobsModel? userGetFilterJobsModel;
  UserGetAllJobsModel? userGetSearchedJobsModel;
  Future<void> getAllJobs({
    int? salaryMin,
    int? salaryMax,
    String? country,
    String? position,
    String? experience,
    String? jobType,
    String? city,
    String? disabled,
    String? category,
    String? search,
  }) async {
    if (search != null) {
      emit(UserGetSearchedJobsLoadingState());
    } else if (category != null) {
      emit(UserGetCategorizedJobsLoadingState());
    }else {
      emit(UserGetAllJobsLoadingState());
    }

    try {
      final response = await DioHelper.getData(
        url: USERGETALLJOBS,
        baseUrl: BASEURL,
        token: userToken,
        query: search != null ? {
          "SalaryMin": salaryMin ?? "",
          "SalaryMax": salaryMax ?? "",
          "country": country ?? "",
          "Position": position ?? "",
          "experince": experience ?? "",
          "jobType": jobType ?? "",
          "city": city ?? "",
          "disabled": disabled ?? "",
          "Category": category ?? "",
          "search": search,
        } : {
          "SalaryMin": salaryMin ?? "",
          "SalaryMax": salaryMax ?? "",
          "country": country ?? "",
          "Position": position ?? "",
          "experince": experience ?? "",
          "jobType": jobType ?? "",
          "city": city ?? "",
          "disabled": disabled ?? "",
          "Category": category ?? "",
        },
      );
      if (search != null) {
        userGetSearchedJobsModel = UserGetAllJobsModel.fromJson(response.data);
        emit(UserGetSearchedJobsSuccessState(userGetSearchedJobsModel!));
      } else if(salaryMin != null && salaryMax != null && country != null && position != null && experience != null && jobType != null && city != null && disabled != null){
        userGetFilterJobsModel = UserGetAllJobsModel.fromJson(response.data);
        emit(UserGetAllJobsSuccessState(userGetFilterJobsModel!));
      } else if (category != null){
        userGetAllJobsModel = UserGetAllJobsModel.fromJson(response.data);
        emit(UserGetCategorizedJobsSuccessState(userGetAllJobsModel!));
      }else {
        userGetAllJobsModel = UserGetAllJobsModel.fromJson(response.data);
        emit(UserGetAllJobsSuccessState(userGetAllJobsModel!));
      }
    } catch (error) {
      if (error is DioError) {
        if (error.response?.statusCode == 400) {
          final responseData = error.response?.data;
          final errorMessage = responseData["errors"]["ConfirmPassword"][0];
          emit(UserGetAllJobsErrorState(errorMessage));
        } else {
          emit(UserGetAllJobsErrorState(error.toString()));
        }
      } else {
        emit(UserGetAllJobsErrorState(error.toString()));
      }
    }
  }

  List<UserGetFreelanceJobsModel>? userGetFreelanceJobsModel;
  void userGetAllFreelanceJobs() async {
    emit(UserGetAllFreelanceJobsLoadingState());
    try {
      final response = await DioHelper.getData(
        url: USERGETALLFREELANCEJOBS,
        baseUrl: BASEURL,
        token: userToken,
      );
      List<dynamic> responseList = response.data;
      userGetFreelanceJobsModel = responseList.map((json) {
        return UserGetFreelanceJobsModel.fromJson(json);
      }).toList();
      emit(UserGetAllFreelanceJobsSuccessState(userGetFreelanceJobsModel!));
    } catch (error) {
      if (error is DioError) {
        if (error.response?.statusCode == 400) {
          final responseData = error.response?.data;
          final errorMessage = responseData[""];
          emit(UserGetAllFreelanceJobsErrorState(errorMessage));
        } else {
          emit(UserGetAllFreelanceJobsErrorState(error.toString()));
        }
      } else {
        emit(UserGetAllFreelanceJobsErrorState(error.toString()));
      }
    }
  }

  UserGetJobDetailsModel? userGetJobDetailsModel;
  Future<void> userGetJobDetails({
    required int id,
  }) async {
    emit(UserGetJobDetailsLoadingState());
    try {
      final response = await DioHelper.getData(
        url: "$USERGETJOBDETAILS$id",
        baseUrl: BASEURL,
        token: userToken,
      );
      userGetJobDetailsModel = UserGetJobDetailsModel.fromJson(response.data);
      emit(UserGetJobDetailsSuccessState(userGetJobDetailsModel!));
    } catch (error) {
      if (error is DioError) {
        if (error.response?.statusCode == 400) {
          final responseData = error.response?.data;
          final errorMessage = responseData["errors"]["ConfirmPassword"][0];
          emit(UserGetJobDetailsErrorState(errorMessage));
        } else {
          emit(UserGetJobDetailsErrorState(error.toString()));
        }
      } else {
        emit(UserGetJobDetailsErrorState(error.toString()));
      }
    }
  }

  UserGetFreelanceDetailsModel? userGetFreelanceDetailsModel;
  Future<void> userGetFreelanceJobDetails({
    required int id,
  }) async {
    emit(UserGetFreelanceJobDetailsLoadingState());
    try {
      final response = await DioHelper.getData(
        url: "$USERGETFREELANCEJOBDETAILS$id",
        baseUrl: BASEURL,
        token: userToken,
      );
      userGetFreelanceDetailsModel = UserGetFreelanceDetailsModel.fromJson(response.data);
      emit(UserGetFreelanceJobDetailsSuccessState(userGetFreelanceDetailsModel!));
    } catch (error) {
      if (error is DioError) {
        if (error.response?.statusCode == 400) {
          final responseData = error.response?.data;
          final errorMessage = responseData["errors"]["ConfirmPassword"][0];
          emit(UserGetFreelanceJobDetailsErrorState(errorMessage));
        } else {
          emit(UserGetFreelanceJobDetailsErrorState(error.toString()));
        }
      } else {
        emit(UserGetFreelanceJobDetailsErrorState(error.toString()));
      }
    }
  }

  void userSendOfferToFreelanceJob({
    required String offerDetails,
    required String offerValue,
    required String timeToRecieve,
    required int jobId,
  }) async {
    emit(UserSendOfferToFreelanceJobLoadingState());
    try {
      final response = await DioHelper.postData(
          url: "$USERSENDOFFERTOFREELANCEJOB$jobId",
          baseUrl: BASEURL,
          token: userToken,
          data: {
            "OfferDetails": offerDetails,
            "OfferValue": offerValue,
            "TimeToRecive": timeToRecieve,
          });
      emit(UserSendOfferToFreelanceJobSuccessState(response.data.toString()));
    } catch (error) {
      if (error is DioError) {
        if (error.response?.statusCode == 400) {
          final responseData = error.response?.data.toString();
          emit(UserSendOfferToFreelanceJobErrorState(responseData!));
        } else {
          emit(UserSendOfferToFreelanceJobErrorState(error.toString()));
        }
      } else {
        emit(UserSendOfferToFreelanceJobErrorState(error.toString()));
      }
    }
  }

/*  UserGetAllJobsModel? userGetSearchedJobsModel;
  void userGetSearchedJobs({
    String? search,
    int? salaryMin,
    int? salaryMax,
    String? country,
    String? position,
    String? experience,
    String? jobType,
    String? city,
    String? disabled,
  }) async {
    emit(UserGetSearchedJobsLoadingState());
    try {
      final response = await DioHelper.getData(
        url: USERGETALLJOBS,
        baseUrl: BASEURL,
        token: userToken,
        query: {
          "search": search,
          "SalaryMin": salaryMin ?? "",
          "SalaryMax": salaryMax ?? "",
          "country": country ?? "",
          "Position": position ?? "",
          "experince": experience ?? "",
          "jobType": jobType ?? "",
          "city": city ?? "",
          "disabled": disabled ?? "",
        },
      );
      userGetSearchedJobsModel = UserGetAllJobsModel.fromJson(response.data);
      emit(UserGetSearchedJobsSuccessState(userGetSearchedJobsModel!));
    } catch (error) {
      if (error is DioError) {
        if (error.response?.statusCode == 400) {
          final responseData = error.response?.data;
          final errorMessage = responseData["errors"]["Search"][0];
          emit(UserGetSearchedJobsErrorState(errorMessage));
        } else {
          emit(UserGetSearchedJobsErrorState(error.toString()));
        }
      } else {
        emit(UserGetSearchedJobsErrorState(error.toString()));
      }
    }
  }*/
}
