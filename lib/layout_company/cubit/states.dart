abstract class LayoutCompanyStates {}
class LayoutCompanyInitialState extends LayoutCompanyStates {}
class ChangeBottomNavBarCompanyState extends LayoutCompanyStates {}
class ChangeFloatingToggleCompanyState extends LayoutCompanyStates {}

class CreateMeetingLoadingState extends LayoutCompanyStates {}
class CreateMeetingSuccessState extends LayoutCompanyStates {
  final String meetingUrl;
  CreateMeetingSuccessState(this.meetingUrl);
}
class CreateMeetingErrorState extends LayoutCompanyStates {
  final String error;
  CreateMeetingErrorState(this.error);
}