import 'package:we_work/models/company/company_get_all_users_model.dart';

abstract class CompanyHomeStates{}
class CompanyHomeInitialState extends CompanyHomeStates {}
class ChangeZoomDrawerState extends CompanyHomeStates {}

class CompanyGetAllUsersLoadingState extends CompanyHomeStates {}
class CompanyGetAllUsersSuccessState extends CompanyHomeStates {
  final CompanyGetAllUsersModel companyGetAllUsersModel;
  CompanyGetAllUsersSuccessState(this.companyGetAllUsersModel);
}
class CompanyGetAllUsersErrorState extends CompanyHomeStates {
  final String error;
  CompanyGetAllUsersErrorState(this.error);
}

class CompanySendOfferToUserLoadingState extends CompanyHomeStates {}
class CompanySendOfferToUserSuccessState extends CompanyHomeStates {
  final String msg;
  CompanySendOfferToUserSuccessState(this.msg);
}
class CompanySendOfferToUserErrorState extends CompanyHomeStates {
  final String error;
  CompanySendOfferToUserErrorState(this.error);
}

class CompanyGetUserDetailsLoadingState extends CompanyHomeStates {}
class CompanyGetUserDetailsSuccessState extends CompanyHomeStates {
  final CompanyGetAllUsersModel companyGetAllUsersModel;
  CompanyGetUserDetailsSuccessState(this.companyGetAllUsersModel);
}
class CompanyGetUserDetailsErrorState extends CompanyHomeStates {
  final String error;
  CompanyGetUserDetailsErrorState(this.error);
}