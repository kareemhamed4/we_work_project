class UserGetOffersModel {
  String? message;
  String? offerdDate;
  String? userName;
  String? email;
  String? sender;
  String? sendrId;
  String? pictureUrl;

  UserGetOffersModel(
      {this.message,
        this.offerdDate,
        this.userName,
        this.email,
        this.sender,
        this.sendrId,
        this.pictureUrl});

  UserGetOffersModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    offerdDate = json['offerdDate'];
    userName = json['userName'];
    email = json['email'];
    sender = json['sender'];
    sendrId = json['sendrId'];
    pictureUrl = json['pictureUrl'];
  }
}
