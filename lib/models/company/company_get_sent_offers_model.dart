class CompanyGetSentOffersModel {
  String? message;
  int? offerId;
  String? offerdDate;
  String? reciver;
  String? bio;
  String? pictureUrl;
  String? reciverId;

  CompanyGetSentOffersModel(
      {this.message,
        this.offerdDate,
        this.offerId,
        this.reciver,
        this.bio,
        this.pictureUrl,
        this.reciverId});

  CompanyGetSentOffersModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    offerdDate = json['offerdDate'];
    reciver = json['reciver'];
    offerId = json['offerId'];
    bio = json['bio'];
    pictureUrl = json['pictureUrl'];
    reciverId = json['reciverId'];
  }
}
