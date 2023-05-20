abstract class CompanyAddFreelanceJobStates{}
class CompanyAddFreelanceJobInitialState extends CompanyAddFreelanceJobStates {}
class CompanyAddFreelanceJobLoadingState extends CompanyAddFreelanceJobStates {}
class CompanyAddFreelanceJobSuccessState extends CompanyAddFreelanceJobStates {
  final String msg;
  CompanyAddFreelanceJobSuccessState(this.msg);
}
class CompanyAddFreelanceJobErrorState extends CompanyAddFreelanceJobStates {
  final String error;
  CompanyAddFreelanceJobErrorState(this.error);
}