import 'package:we_work/models/user/user_get_profile_model.dart';

abstract class UserProfileStates{}
class UserProfileInitialState extends UserProfileStates {}
class UserGetProfileLoadingState extends UserProfileStates {}
class UserGetProfileSuccessState extends UserProfileStates {
  final UserProfileModel userProfileModel;
  UserGetProfileSuccessState(this.userProfileModel);
}
class UserGetProfileErrorState extends UserProfileStates {
  final String error;
  UserGetProfileErrorState(this.error);
}

class UserUpdateProfileLoadingState extends UserProfileStates {}
class UserUpdateProfileSuccessState extends UserProfileStates {
  final String msg;
  UserUpdateProfileSuccessState(this.msg);
}
class UserUpdateProfileErrorState extends UserProfileStates {
  final String error;
  UserUpdateProfileErrorState(this.error);
}

class ProfileImagePickedSuccessState extends UserProfileStates {}
class ProfileImagePickedErrorState extends UserProfileStates {}

class ProfileUploadImageLoadingState extends UserProfileStates {}
class ProfileImageUploadSuccessState extends UserProfileStates {
  final String imageUrl;

  ProfileImageUploadSuccessState(this.imageUrl);
}
class ProfileImageUploadErrorState extends UserProfileStates {
  final String error;
  ProfileImageUploadErrorState(this.error);
}