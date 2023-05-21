class UserGetFreelanceDetailsModel {
  String? projectStatus;
  String? timeToComplete;
  String? projectDetails;
  String? title;
  String? requiredSkills;
  String? budget;
  String? published;
  String? projectOwner;

  UserGetFreelanceDetailsModel(
      {this.projectStatus,
        this.timeToComplete,
        this.projectDetails,
        this.title,
        this.requiredSkills,
        this.budget,
        this.published,
        this.projectOwner});

  UserGetFreelanceDetailsModel.fromJson(Map<String, dynamic> json) {
    projectStatus = json['projectStatus'];
    timeToComplete = json['timeToComplete'];
    projectDetails = json['projectDetails'];
    title = json['title'];
    requiredSkills = json['requiredSkills'];
    budget = json['budget'];
    published = json['published'];
    projectOwner = json['projectOwner'];
  }
}
