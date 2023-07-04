class XRayModel {
  Pred? pred;
  Map<String,dynamic>? data;
  XRayModel.fromJson(Map<String, dynamic> json) {
    pred = json['pred'] != null ? Pred.fromJson(json['pred']) : null;

  }
}

class Pred {
  double? Atelectasis;
  double? Effusion;
  double? Infiltration;
  double? Nodule;
  double? Mass;
  double? Pneumothorax;
  double? Consolidation;
  double? Pleural_Thickening;
  double? Cardiomegaly;
  double? Edema;

  Pred.fromJson(Map<String, dynamic> json) {
    Atelectasis = json['Atelectasis'];
    Effusion = json['Effusion'];
    Infiltration = json['Infiltration'];
    Nodule = json['Nodule'];
    Mass = json['Mass'];
    Pneumothorax = json['Pneumothorax'];
    Consolidation = json['Consolidation'];
    Pleural_Thickening = json['Pleural_Thickening'];
    Cardiomegaly = json['Cardiomegaly'];
    Edema = json['Edema'];
  }


}
