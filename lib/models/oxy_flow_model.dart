class OxyFlowModel {
  String? oxyFlow;


  OxyFlowModel.fromJson(Map<String, dynamic> json) {
    oxyFlow = json['oxy_flow'];
  }
}