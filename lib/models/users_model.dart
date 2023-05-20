class UsersModel {
  int? id;
  String? name;
  String? phone;
  String? email;
  Null emailVerifiedAt;
  String? createdAt;
  String? updatedAt;


  UsersModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    phone = json['phone'];
    email = json['email'];
    emailVerifiedAt = json['email_verified_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }




}
