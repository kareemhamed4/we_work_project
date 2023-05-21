class CompanyGetFreelanceOffersModel {
  String? userId;
  String? title;
  String? dateTime;
  String? email;
  int? offerValue;
  String? timeToComplete;
  String? pictureUrl;
  String? displayName;
  int? jobid;

  CompanyGetFreelanceOffersModel(
      {this.userId,
        this.title,
        this.dateTime,
        this.email,
        this.offerValue,
        this.timeToComplete,
        this.pictureUrl,
        this.displayName,
        this.jobid});

  CompanyGetFreelanceOffersModel.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    title = json['title'];
    dateTime = json['dateTime'];
    email = json['email'];
    offerValue = json['offerValue'];
    timeToComplete = json['timeToComplete'];
    pictureUrl = json['pictureUrl'];
    displayName = json['displayName'];
    jobid = json['jobid'];
  }
}
