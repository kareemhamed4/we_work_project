import 'package:we_work/models/company/company_get_all_meetings_model.dart';
import 'package:we_work/models/company/company_get_user_applied_model.dart';

abstract class CompanyGetUsersWhoAppliedStates{}
class CompanyGetUsersWhoAppliedInitialState extends CompanyGetUsersWhoAppliedStates {}
class ChangeTabBarIndexState extends CompanyGetUsersWhoAppliedStates {}
class CompanyGetUsersWhoAppliedLoadingState extends CompanyGetUsersWhoAppliedStates {}
class CompanyGetUsersWhoAppliedSuccessState extends CompanyGetUsersWhoAppliedStates {
  final List<CompanyGetAllUsersApplied> companyGetAllUsersApplied;
  CompanyGetUsersWhoAppliedSuccessState(this.companyGetAllUsersApplied);
}
class CompanyGetUsersWhoAppliedErrorState extends CompanyGetUsersWhoAppliedStates {
  final String error;
  CompanyGetUsersWhoAppliedErrorState(this.error);
}

class CompanyGetMeetingsLoadingState extends CompanyGetUsersWhoAppliedStates {}
class CompanyGetMeetingsSuccessState extends CompanyGetUsersWhoAppliedStates {
  final List<CompanyMeetingsModel> companyMeetingsModel;
  CompanyGetMeetingsSuccessState(this.companyMeetingsModel);
}
class CompanyGetMeetingsErrorState extends CompanyGetUsersWhoAppliedStates {
  final String error;
  CompanyGetMeetingsErrorState(this.error);
}

class CompanyDeleteSentAcceptedOfferLoadingState extends CompanyGetUsersWhoAppliedStates {}
class CompanyDeleteSentAcceptedOfferSuccessState extends CompanyGetUsersWhoAppliedStates {
  final String msg;
  CompanyDeleteSentAcceptedOfferSuccessState(this.msg);
}
class CompanyDeleteSentAcceptedOfferErrorState extends CompanyGetUsersWhoAppliedStates {
  final String error;
  CompanyDeleteSentAcceptedOfferErrorState(this.error);
}

class CompanyGetUserAppliedLoadingState extends CompanyGetUsersWhoAppliedStates {}
class CompanyGetUserAppliedSuccessState extends CompanyGetUsersWhoAppliedStates {
  final CompanyGetAllUsersApplied companyGetAllUsersApplied;
  CompanyGetUserAppliedSuccessState(this.companyGetAllUsersApplied);
}
class CompanyGetUserAppliedErrorState extends CompanyGetUsersWhoAppliedStates {
  final String error;
  CompanyGetUserAppliedErrorState(this.error);
}

class CompanyDeclineUserAppliedLoadingState extends CompanyGetUsersWhoAppliedStates {}
class CompanyDeclineUserAppliedSuccessState extends CompanyGetUsersWhoAppliedStates {
  final String msg;
  CompanyDeclineUserAppliedSuccessState(this.msg);
}
class CompanyDeclineUserAppliedErrorState extends CompanyGetUsersWhoAppliedStates {
  final String error;
  CompanyDeclineUserAppliedErrorState(this.error);
}