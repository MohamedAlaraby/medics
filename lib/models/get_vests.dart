class GetVestsModel {
  int? code;
  List<String>? data;

  GetVestsModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    data = json['data'].cast<String>();
  }

}
