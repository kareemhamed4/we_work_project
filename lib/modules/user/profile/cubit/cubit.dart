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

  String? selectedExperience;
  List<String> experienceList = [
    "No Experience",
    "less than year",
    "1 year",
    "2-3 year",
    "more than 10 years"
  ];

  UserProfileModel? userProfileModel;
  void getUserInfo() {
    emit(UserGetProfileLoadingState());
    DioHelper.getData(
      url: USERGETPROFILE,
      baseUrl: BASEURL,
      token: userToken,
    ).then((value) {
      userProfileModel = UserProfileModel.fromJson(value.data);
      emit(UserGetProfileSuccessState(userProfileModel!));
    }).catchError((error) {
      if (error is DioError) {
        if (error.response?.statusCode == 400) {
          final responseData = error.response?.data;
          final errorMessage = responseData[""];
          emit(UserGetProfileErrorState(errorMessage));
        } else {
          emit(UserGetProfileErrorState(error.toString()));
        }
      } else {
        emit(UserGetProfileErrorState(error.toString()));
      }
    });
  }

  void updateUserInfo({
    required String name,
    required String bio,
    required String education,
    required String position,
    required String jobType,
    required String experience,
  }) {
    emit(UserUpdateProfileLoadingState());
    DioHelper.postData(
      url: USERUPDATEPROFILE,
      baseUrl: BASEURL,
      token: userToken,
      query: {
        "Bio": name,
        "Name": bio,
        "Education": education,
        "Position": position,
        "JobType": jobType,
        "Experine": experience,
      },
    ).then((value) {
      if (value.statusCode == 200) {
        getUserInfo();
        emit(UserUpdateProfileSuccessState(
            "Profile Info Updated Successfully!"));
      }
    }).catchError((error) {
      if (error is DioError) {
        if (error.response?.statusCode == 400) {
          final responseData = error.response?.data;
          final errorMessage = responseData["title"];
          emit(UserUpdateProfileErrorState(errorMessage));
        } else {
          emit(UserUpdateProfileErrorState(error.toString()));
        }
      } else {
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
        image: profileImage,
      );
    } else {
      emit(ProfileImagePickedErrorState());
    }
  }

  void userUploadImage({
    File? image,
  }) {
    emit(ProfileUploadImageLoadingState());
    FormData formData = FormData();
    formData.files.add(MapEntry(
      'file',
      MultipartFile.fromFileSync(image!.path),
    ));

    DioHelper.postData(
      url: USERUPLOADIMAGE,
      baseUrl: BASEURL,
      token: userToken,
      data: formData,
      contentType: "multipart/form-data",
    ).then((value) {
      final responseData = value.data;
      final imageUrl = responseData["image_Url"];
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
