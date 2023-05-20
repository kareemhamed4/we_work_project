import 'package:we_work/models/company/company_get_user_applied_model.dart';

abstract class CompanyGetUsersWhoAppliedStates{}
class CompanyGetUsersWhoAppliedInitialState extends CompanyGetUsersWhoAppliedStates {}
class CompanyGetUsersWhoAppliedLoadingState extends CompanyGetUsersWhoAppliedStates {}
class CompanyGetUsersWhoAppliedSuccessState extends CompanyGetUsersWhoAppliedStates {
  final List<CompanyGetAllUsersApplied> companyGetAllUsersApplied;
  CompanyGetUsersWhoAppliedSuccessState(this.companyGetAllUsersApplied);
}
class CompanyGetUsersWhoAppliedErrorState extends CompanyGetUsersWhoAppliedStates {
  final String error;
  CompanyGetUsersWhoAppliedErrorState(this.error);
}