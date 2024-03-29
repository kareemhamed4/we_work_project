import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:we_work/models/user/user_get_applied_jobs_model.dart';
import 'package:we_work/modules/user/saved_jobs/cubit/states.dart';
import 'package:we_work/network/end_points.dart';
import 'package:we_work/network/remote/dio_helper_advanced.dart';
import 'package:we_work/shared/constants/constants.dart';

class UserGetAppliedJobsCubit extends Cubit<UserGetAppliedJobsStates> {
  UserGetAppliedJobsCubit() : super(UserGetAppliedJobsInitialState());

  static UserGetAppliedJobsCubit get(context) => BlocProvider.of(context);

  List<UserGetAppliedJobsModel>? getAppliedJobsModel;
  Future<void> userGetAppliedJobs() async{
    emit(UserGetAppliedJobsLoadingState());
    DioHelper.getData(
      url: USERGETAPPLIEDJOBS,
      baseUrl: BASEURL,
      token: userToken,
    ).then((value){
      List<dynamic> responseList = value.data;
      getAppliedJobsModel = responseList.map((json) {
        return UserGetAppliedJobsModel.fromJson(json);
      }).toList();
      emit(UserGetAppliedJobsSuccessState(getAppliedJobsModel!));
    }).catchError((error){
      if (error is DioError) {
        if (error.response?.statusCode == 400) {
          final responseData = error.response?.data;
          final errorMessage = responseData[""][0];
          emit(UserGetAppliedJobsErrorState(errorMessage));
        }else{
          emit(UserGetAppliedJobsErrorState(error.toString()));
        }
    }
      else{
        emit(UserGetAppliedJobsErrorState(error.toString()));
      }
    });
  }

  Future<void> deleteApplicant({
    required String applicantId,
  }) async{
    emit(UserDeleteApplicantLoadingState());
    await DioHelper.deleteData(
      url: "$USERDDELETEAPPLICANT$applicantId",
      token: userToken,
      baseUrl: BASEURL,
    ).then((value) {
      emit(UserDeleteApplicantSuccessState(value.data.toString()));
      userGetAppliedJobs();
    }).catchError((error) {
      if (error is DioError) {
        if (error.response?.statusCode == 404) {
          final responseData = error.response?.data;
          final errorMessage = responseData['title'];
          emit(UserDeleteApplicantErrorState(errorMessage));
        } else {
          // Handle other DioError cases
          emit(UserDeleteApplicantErrorState('An error occurred. Please try again.'));
        }
      } else {
        // Handle non-DioError cases
        emit(UserDeleteApplicantErrorState('An error occurred. Please try again.'));
      }
    });
  }
}
