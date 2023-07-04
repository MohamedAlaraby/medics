class SensorsReadingsModel {
  int? code;
  Data? data;

  SensorsReadingsModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }


}

class Data {
  int? id;
  String? vestId;
  String? temp;
  String? pressH;
  String? pressL;
  String? ecg;
  String? spo;
  String? heartRate;
  String? status;
  String? prob;
  String? createdAt;
  String? updatedAt;


  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    vestId = json['vest_id'];
    temp = json['temp'];
    pressH = json['press_h'];
    pressL = json['press_l'];
    ecg = json['ecg'];
    spo = json['spo'];
    heartRate = json['heart_rate'];
    status = json['status'];
    prob = json['prob'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }


}
