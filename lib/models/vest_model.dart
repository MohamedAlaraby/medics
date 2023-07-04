class VestModel {
  int? code;
  User? user;
  String? token;

  VestModel({this.code, this.user, this.token});

  VestModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    token = json['token'];
  }
}
class User {
  String? email;
  String? vestId;
  String? updatedAt;
  String? createdAt;
  int? id;

  User({this.email, this.vestId, this.updatedAt, this.createdAt, this.id});

  User.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    vestId = json['vest_id'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    id = json['id'];
  }
}
