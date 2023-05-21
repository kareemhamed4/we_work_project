class UserGetFreelanceJobsModel {
  int? id;
  String? projectDetails;
  String? title;
  String? budget;
  String? projectOwner;
  String? pictureUrl;

  UserGetFreelanceJobsModel(
      {this.id,
        this.projectDetails,
        this.title,
        this.budget,
        this.projectOwner,
        this.pictureUrl});

  UserGetFreelanceJobsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    projectDetails = json['projectDetails'];
    title = json['title'];
    budget = json['budget'];
    projectOwner = json['projectOwner'];
    pictureUrl = json['pictureUrl'];
  }
}
