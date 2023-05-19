import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:we_work/modules/user/upload_cv/cubit/states.dart';
import 'package:we_work/network/end_points.dart';
import 'package:we_work/network/remote/dio_helper_advanced.dart';
import 'package:we_work/shared/constants/constants.dart';

class UserApplyJobCubit extends Cubit<UserApplyJobStates> {
  UserApplyJobCubit() : super(UserApplyJobInitialState());

  static UserApplyJobCubit get(context) => BlocProvider.of(context);

  void userApplyJob({
    File? cvFile,
    required int jobId,
    required String message,
  }) {
    emit(UserApplyJobLoadingState());

    FormData formData = FormData();
    formData.files.add(MapEntry(
      'file',
      MultipartFile.fromFileSync(cvFile!.path),
    ));

    DioHelper.postData(
      url: "$USERAPPLYTOJOB$jobId",
      baseUrl: BASEURL,
      token: userToken,
      data: formData,
      query: {"message": message},
      contentType: "multipart/form-data",
    ).then((value) {
      final responseData = value.data.toString();
      if (responseData == 'you Applyed for this job before') {
        emit(UserApplyJobErrorState('you Applyed for this job before'));
      }else{
        emit(UserApplyJobSuccessState(responseData));
      }
    }).catchError((error) {
      if (error is DioError) {
        if (error.response?.statusCode == 400) {
          final responseData = error.response?.data;
          emit(UserApplyJobErrorState(responseData));
        } else {
          print(error.toString());
          emit(UserApplyJobErrorState(error.toString()));
        }
      } else {
        print(error.toString());
        emit(UserApplyJobErrorState(error.toString()));
      }
    });
  }

}
