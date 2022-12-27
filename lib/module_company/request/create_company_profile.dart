class CreateCompanyProfile {
  int? id;
  String? phone;
  String? phone2;
  String? whatsapp;
  String? fax;
  String? bankName;
  String? stc;
  String? email;
  String? minKilometerBonus;
  String? maxKilometerBonus;
  String? kilometers;
  String? storeProfitMargin;
  String? supplierProfitMargin;

  CreateCompanyProfile(
      {this.phone,
      this.phone2,
      this.whatsapp,
      this.fax,
      this.bankName,
      this.stc,
      this.email,
      this.id,
      this.minKilometerBonus,
      this.maxKilometerBonus,
      this.kilometers,
      this.storeProfitMargin,
      this.supplierProfitMargin});

  CreateCompanyProfile.fromJson(dynamic json) {
    id = json['id'];
    phone = json['phone'];
    phone2 = json['phoneTwo'];
    whatsapp = json['whatsapp'];
    fax = json['fax'];
    bankName = json['bankName'];
    stc = json['stc'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    if (id != null) {
      map['id'] = id;
    }
    if (phone != null) {
      map['phone'] = phone;
    }
    if (phone2 != null) {
      map['phoneTwo'] = phone2;
    }
    if (whatsapp != null) {
      map['whatsapp'] = whatsapp;
    }
    if (fax != null) {
      map['fax'] = fax;
    }
    if (bankName != null) {
      map['bankName'] = bankName;
    }
    if (stc != null) {
      map['stc'] = stc;
    }
    if (email != null) {
      map['email'] = email;
    }
    if (minKilometerBonus != null) {
      map['minKilometerBonus'] = minKilometerBonus;
    }
    if (maxKilometerBonus != null) {
      map['maxKilometerBonus'] = maxKilometerBonus;
    }
    if (kilometers != null) {
      map['kilometers'] = kilometers;
    }
    if (storeProfitMargin != null) {
      map['storeProfitMargin'] = storeProfitMargin;
    }
    if (supplierProfitMargin != null) {
      map['supplierProfitMargin'] = supplierProfitMargin;
    }
    return map;
  }
}
