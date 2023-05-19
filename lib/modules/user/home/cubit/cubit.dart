import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:we_work/models/user/user_get_all_jobs_model.dart';
import 'package:we_work/models/user/user_get_job_details_model.dart';
import 'package:we_work/modules/user/home/cubit/states.dart';
import 'package:we_work/network/end_points.dart';
import 'package:we_work/network/remote/dio_helper_advanced.dart';
import 'package:we_work/shared/constants/constants.dart';

class UserHomeCubit extends Cubit<UserHomeStates> {
  UserHomeCubit() : super(UserHomeInitialState());

  static UserHomeCubit get(context) => BlocProvider.of(context);

  UserGetAllJobsModel? userGetAllJobsModel;
  void userGetAllJob() async {
    emit(UserGetAllJobsLoadingState());

    try {
      final response = await DioHelper.getData(
        url: USERGETALLJOBS,
        baseUrl: BASEURL,
        token: userToken,
      );

      userGetAllJobsModel = UserGetAllJobsModel.fromJson(response.data);
      emit(UserGetAllJobsSuccessState(userGetAllJobsModel!));
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

  UserGetAllJobsModel? userGetRemotlyJobsModel;
  void userGetRemotlyJob() async {
    emit(UserGetAllJobsLoadingState());
    try {
      final response = await DioHelper.getData(
        url: USERGETALLJOBS,
        baseUrl: BASEURL,
        token: userToken,
        query: {"jobType": "remote"},
      );

      userGetRemotlyJobsModel = UserGetAllJobsModel.fromJson(response.data);
      emit(UserGetAllJobsSuccessState(userGetRemotlyJobsModel!));
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
}
