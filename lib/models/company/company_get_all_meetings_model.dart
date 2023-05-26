class CompanyMeetingsModel {
  int? id;
  String? user;
  String? userID;
  String? message;
  String? meetingLink;
  String? sendingTime;
  String? pictureUrl;
  String? meedtingDate;

  CompanyMeetingsModel(
      {this.id,
        this.user,
        this.userID,
        this.message,
        this.meetingLink,
        this.sendingTime,
        this.pictureUrl,
        this.meedtingDate});

  CompanyMeetingsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    user = json['user'];
    userID = json['userID'];
    message = json['message'];
    meetingLink = json['meetingLink'];
    sendingTime = json['sendingTime'];
    pictureUrl = json['pictureUrl'];
    meedtingDate = json['meedtingDate'];
  }
}
