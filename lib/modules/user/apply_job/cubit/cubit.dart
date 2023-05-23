import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:we_work/modules/user/apply_job/cubit/states.dart';
import 'package:we_work/network/end_points.dart';
import 'package:we_work/network/remote/dio_helper_advanced.dart';
import 'package:we_work/shared/constants/constants.dart';

class UserApplyJobCubit extends Cubit<UserApplyJobStates> {
  UserApplyJobCubit() : super(UserApplyJobInitialState());

  static UserApplyJobCubit get(context) => BlocProvider.of(context);

  String? filePath;
  String? fileName;
  FilePickerResult? result;
  Future<void> chooseCVFile() async {
    try {
      result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf'],
      );
      if (result != null && result!.files.isNotEmpty) {
        filePath = result!.files.last.path!;
        fileName = filePath!.split('/').last;
        emit(FilePickedSuccessState());
      }
    } catch (e) {
      emit(FilePickedErrorState());
    }
  }

  void deleteSelectedPdf(){
    filePath = null;
    fileName = null;
    result = null;
    emit(FileDeletedSuccessState());
  }

  Future<void> applyToJob({
    required int jobId,
    required String message,
}) async {
    emit(UserApplyJobLoadingState());
    if (filePath!.isEmpty) {
      emit(UserApplyJobErrorState("Please choose PDF file"));
      return;
    }
    try {
      final formData = FormData.fromMap({
        'file': await MultipartFile.fromFile(filePath!),
      });
      final response = await DioHelper.postData(
        url: "$USERAPPLYTOJOB$jobId",
        baseUrl: BASEURL,
        data: formData,
        token: userToken,
        contentType: 'multipart/form-data; boundary=${formData.boundary}',
      );
      if (response.statusCode == 200) {
        final responseData = response.data.toString();
        if (responseData == 'you Applyed for this job before') {
          emit(UserApplyJobErrorState('you Applyed for this job before'));
        } else {
          emit(UserApplyJobSuccessState(responseData));
        }
      } else {
        emit(UserApplyJobErrorState("Error while uploading your offer, try again!"));
      }
    } catch (e) {
      emit(UserApplyJobErrorState("Error while uploading your offer, try again!"));
    }
  }

/*  Future userApplyToJobNew({
    required int jobId,
    required String message,
  }) async {
    if (result != null) {
      emit(UserApplyJobLoadingState());
      if (!file!.existsSync()) {
        emit(UserApplyJobErrorState('File not found'));
        return;
      }
      FormData formData = FormData();
      formData.files.add(MapEntry(
        'file',
        MultipartFile.fromFileSync(file!.path),
      ));

      DioHelper.postData(
        url: "$USERAPPLYTOJOB$jobId",
        baseUrl: BASEURL,
        token: userToken,
        data: formData,
        contentType: "multipart/form-data",
        query: {
          "message": message,
        },
      ).then((value) {
        final responseData = value.data.toString();
        if (responseData == 'you Applyed for this job before') {
          emit(UserApplyJobErrorState('you Applyed for this job before'));
        } else {
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
  }*/
}