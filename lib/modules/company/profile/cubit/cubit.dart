import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:we_work/models/company/company_get_profile_model.dart';
import 'package:we_work/modules/company/profile/cubit/states.dart';
import 'package:we_work/network/end_points.dart';
import 'package:we_work/network/remote/dio_helper_advanced.dart';
import 'package:we_work/shared/constants/constants.dart';

class CompanyProfileCubit extends Cubit<CompanyProfileStates> {
  CompanyProfileCubit() : super(CompanyProfileInitialState());

  static CompanyProfileCubit get(context) => BlocProvider.of(context);

  CompanyProfileModel? companyProfileModel;
  void getCompanyInfo() {
    emit(CompanyGetProfileLoadingState());
    DioHelper.getData(
      url: COMPANYGETPROFILE,
      baseUrl: BASEURL,
      token: companyToken,
    ).then((value){
      companyProfileModel = CompanyProfileModel.fromJson(value.data);
      emit(CompanyGetProfileSuccessState(companyProfileModel!));
    }).catchError((error){
      if (error is DioError) {
        if (error.response?.statusCode == 400) {
          final responseData = error.response?.data;
          final errorMessage = responseData[""];
          emit(CompanyGetProfileErrorState(errorMessage));
        }else{
          emit(CompanyGetProfileErrorState(error.toString()));
        }
    }else{
        emit(CompanyGetProfileErrorState(error.toString()));
      }
    });
  }

  void updateCompanyInfo({
    required String name,
    required String bio,
    required String education,
    required String position,
    required String jobType,
  }) {
    emit(CompanyUpdateProfileLoadingState());
    DioHelper.postData(
      url: USERUPDATEPROFILE,
      baseUrl: BASEURL,
      token: companyToken,
      query: {
        "Bio": name,
        "Name": bio,
        "Education": education,
        "Position": position,
        "JobType": jobType,
      },
    ).then((value) {
      if (value.statusCode == 200) {
        getCompanyInfo();
        emit(CompanyUpdateProfileSuccessState(
            "Profile Info Updated Successfully!"));
      }
    }).catchError((error) {
      if (error is DioError) {
        if (error.response?.statusCode == 400) {
          final responseData = error.response?.data;
          final errorMessage = responseData["title"];
          emit(CompanyUpdateProfileErrorState(errorMessage));
        } else {
          emit(CompanyUpdateProfileErrorState(error.toString()));
        }
      } else {
        emit(CompanyUpdateProfileErrorState(error.toString()));
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
      token: companyToken,
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
