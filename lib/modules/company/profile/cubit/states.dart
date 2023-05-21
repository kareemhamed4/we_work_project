import 'package:we_work/models/company/company_get_profile_model.dart';

abstract class CompanyProfileStates{}
class CompanyProfileInitialState extends CompanyProfileStates {}
class CompanyGetProfileLoadingState extends CompanyProfileStates {}
class CompanyGetProfileSuccessState extends CompanyProfileStates {
  final CompanyProfileModel userProfileModel;
  CompanyGetProfileSuccessState(this.userProfileModel);
}
class CompanyGetProfileErrorState extends CompanyProfileStates {
  final String error;
  CompanyGetProfileErrorState(this.error);
}

class CompanyUpdateProfileLoadingState extends CompanyProfileStates {}
class CompanyUpdateProfileSuccessState extends CompanyProfileStates {
  final String msg;
  CompanyUpdateProfileSuccessState(this.msg);
}
class CompanyUpdateProfileErrorState extends CompanyProfileStates {
  final String error;
  CompanyUpdateProfileErrorState(this.error);
}

class ProfileImagePickedSuccessState extends CompanyProfileStates {}
class ProfileImagePickedErrorState extends CompanyProfileStates {}

class ProfileUploadImageLoadingState extends CompanyProfileStates {}
class ProfileImageUploadSuccessState extends CompanyProfileStates {
  final String imageUrl;

  ProfileImageUploadSuccessState(this.imageUrl);
}
class ProfileImageUploadErrorState extends CompanyProfileStates {
  final String error;
  ProfileImageUploadErrorState(this.error);
}