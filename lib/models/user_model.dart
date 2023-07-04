class UserModel {
  User? user;
  String? token;

  UserModel({this.user, this.token});

  UserModel.fromJson(Map<String, dynamic> json) {
    user = json['user'] != null ?  User.fromJson(json['user']) : null;
    token = json['token'];
  }


}

class User {
  int? id;
  String? name;
  String? age;
  String? phone;
  String? gender;
  String? email;
  String? emailVerifiedAt;
  String? type;
  String? vestId;
  String? createdAt;
  String? updatedAt;

  User.fromJson(Map<String, dynamic> json) {
    id =  json['id'];
    name = json['name'];
    age =  json['age'];
    phone = json['phone'];
    gender = json['gender'];
    email = json['email'];
    emailVerifiedAt = json['email_verified_at'];
    type = json['type'];
    vestId = json['vest_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
}

