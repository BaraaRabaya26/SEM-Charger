class MeterModel {
  String? mID;
  String? sDATE;
  String? eDATE;

  MeterModel({this.mID, this.sDATE, this.eDATE});

  MeterModel.fromJson(Map<String, dynamic> json) {
    mID = json['M_ID'];
    sDATE = json['S_DATE'];
    eDATE = json['E_DATE'];
  }

// Map<String, dynamic> toJson() {
//   final Map<String, dynamic> data = new Map<String, dynamic>();
//   data['M_ID'] = this.mID;
//   data['S_DATE'] = this.sDATE;
//   data['E_DATE'] = this.eDATE;
//   return data;
// }
}