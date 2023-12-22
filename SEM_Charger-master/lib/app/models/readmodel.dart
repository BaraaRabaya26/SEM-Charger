class ReadModel { //convert json to dart class for easier access
  String? rID;
  String? pOWER;
  String? vOLTAGE;
  String? aMPERE;
  String? fEE;
 // String? bALANCE;
  String? dATE;
  String? mID;

  ReadModel(
      {this.rID,
        this.pOWER,
        this.vOLTAGE,
        this.aMPERE,
        this.fEE,
    //    this.bALANCE,
        this.dATE,
        this.mID});

  ReadModel.fromJson(Map<String, dynamic> json) {
    rID = json['R_ID'];
    pOWER = json['POWER'];
    vOLTAGE = json['VOLTAGE'];
    aMPERE = json['AMPERE'];
    fEE = json['FEE'];
  //  bALANCE = json['BALANCE'];
    dATE = json['DATE'];
    mID = json['M_ID'];
  }

// Map<String, dynamic> toJson() {
//   final Map<String, dynamic> data = new Map<String, dynamic>();
//   data['R_ID'] = this.rID;
//   data['POWER'] = this.pOWER;
//   data['VOLTAGE'] = this.vOLTAGE;
//   data['AMPERE'] = this.aMPERE;
//   data['FEE'] = this.fEE;
//   data['BALANCE'] = this.bALANCE;
//   data['DATE'] = this.dATE;
//   data['M_ID'] = this.mID;
//   return data;
// }
}
