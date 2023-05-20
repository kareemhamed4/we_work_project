import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:we_work/models/user/user_get_profile_model.dart';
import 'package:we_work/modules/user/profile/cubit/states.dart';
import 'package:we_work/network/end_points.dart';
import 'package:we_work/network/remote/dio_helper_advanced.dart';
import 'package:we_work/shared/constants/constants.dart';

class UserProfileCubit extends Cubit<UserProfileStates> {
  UserProfileCubit() : super(UserProfileInitialState());

  static UserProfileCubit get(context) => BlocProvider.of(context);

  UserProfileModel? userProfileModel;
  void getUserInfo() {
    emit(UserGetProfileLoadingState());
    DioHelper.getData(
      url: USERGETPROFILE,
      baseUrl: BASEURL,
      token: userToken,
    ).then((value){
      userProfileModel = UserProfileModel.fromJson(value.data);
      emit(UserGetProfileSuccessState(userProfileModel!));
    }).catchError((error){
      if (error is DioError) {
        if (error.response?.statusCode == 400) {
          final responseData = error.response?.data;
          final errorMessage = responseData[""];
          emit(UserGetProfileErrorState(errorMessage));
        }else{
          emit(UserGetProfileErrorState(error.toString()));
        }
    }else{
        emit(UserGetProfileErrorState(error.toString()));
      }
    });
  }

  void updateUserInfo({
    required String bio,
}) {
    emit(UserUpdateProfileLoadingState());
    DioHelper.postData(
      url: USERUPDATEPROFILE,
      baseUrl: BASEURL,
      token: userToken,
      query: {
        "Bio": bio
      },
    ).then((value){
      getUserInfo();
      final message = value.data.toString();
      emit(UserUpdateProfileSuccessState(message));
    }).catchError((error){
      if (error is DioError) {
        if (error.response?.statusCode == 400) {
          final responseData = error.response?.data;
          final errorMessage = responseData["title"];
          emit(UserUpdateProfileErrorState(errorMessage));
        }else{
          emit(UserUpdateProfileErrorState(error.toString()));
        }
      }else{
        emit(UserUpdateProfileErrorState(error.toString()));
      }
    });
  }

  var picker = ImagePicker();
  File? profileImage;
  Future getProfileImage() async {
    final pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      profileImage = File(pickedFile.path);
      emit(ProfileImagePickedSuccessState());
      userUploadImage(
        cvFile: profileImage,
      );
    } else {
      emit(ProfileImagePickedErrorState());
    }
  }

  void userUploadImage({
    File? cvFile,
  }) {
    emit(ProfileUploadImageLoadingState());
    FormData formData = FormData();
    formData.files.add(MapEntry(
      'file',
      MultipartFile.fromFileSync(cvFile!.path),
    ));

    DioHelper.postData(
      url: USERUPLOADIMAGE,
      baseUrl: BASEURL,
      token: userToken,
      data: formData,
      contentType: "multipart/form-data",
    ).then((value) {
      final responseData = value.data;
      final imageUrl = responseData["image_url"];
      emit(ProfileImageUploadSuccessState(imageUrl));
    }).catchError((error) {
      if (error is DioError) {
        if (error.response?.statusCode == 400) {
          final responseData = error.response?.data;
          emit(ProfileImageUploadErrorState(responseData));
        } else {
          print(error.toString());
          emit(ProfileImageUploadErrorState(error.toString()));
        }
      } else {
        print(error.toString());
        emit(ProfileImageUploadErrorState(error.toString()));
      }
    });
  }
}
