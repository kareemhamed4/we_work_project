class UserGetOffersModel {
  int? id;
  String? message;
  String? offerdDate;
  String? userName;
  String? email;
  String? sender;
  String? sendrId;
  String? pictureUrl;

  UserGetOffersModel(
      {
        this.id,
        this.message,
        this.offerdDate,
        this.userName,
        this.email,
        this.sender,
        this.sendrId,
        this.pictureUrl});

  UserGetOffersModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    message = json['message'];
    offerdDate = json['offerdDate'];
    userName = json['userName'];
    email = json['email'];
    sender = json['sender'];
    sendrId = json['sendrId'];
    pictureUrl = json['pictureUrl'];
  }
}
