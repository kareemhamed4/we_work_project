abstract class CompanyAddJobStates{}
class CompanyAddJobInitialState extends CompanyAddJobStates {}
class CompanyAddJobLoadingState extends CompanyAddJobStates {}
class CompanyAddJobSuccessState extends CompanyAddJobStates {
  final String msg;
  CompanyAddJobSuccessState(this.msg);
}
class CompanyAddJobErrorState extends CompanyAddJobStates {
  final String error;
  CompanyAddJobErrorState(this.error);
}