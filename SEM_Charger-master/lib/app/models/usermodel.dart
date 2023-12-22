class UserModel {
  String? uID;
  String? fNAME;
  String? lNAME;
  String? pHONENUM;
  String? cITY;
  String? mID;
  String? uSERNAME;
  String? pASSWORD;

  UserModel(
      {this.uID,
        this.fNAME,
        this.lNAME,
        this.pHONENUM,
        this.cITY,
        this.mID,
        this.uSERNAME,
        this.pASSWORD});

  UserModel.fromJson(Map<String, dynamic> json) {
    uID = json['U_ID'];
    fNAME = json['F_NAME'];
    lNAME = json['L_NAME'];
    pHONENUM = json['PHONE_NUM'];
    cITY = json['CITY'];
    mID = json['M_ID'];
    uSERNAME = json['USERNAME'];
    pASSWORD = json['PASSWORD'];
  }

// Map<String, dynamic> toJson() {
//   final Map<String, dynamic> data = new Map<String, dynamic>();
//   data['U_ID'] = this.uID;
//   data['F_NAME'] = this.fNAME;
//   data['L_NAME'] = this.lNAME;
//   data['PHONE_NUM'] = this.pHONENUM;
//   data['CITY'] = this.cITY;
//   data['M_ID'] = this.mID;
//   data['USERNAME'] = this.uSERNAME;
//   data['PASSWORD'] = this.pASSWORD;
//   return data;
// }
}