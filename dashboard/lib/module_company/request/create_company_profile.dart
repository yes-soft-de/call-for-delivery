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

  CreateCompanyProfile(
      {this.phone,
      this.phone2,
      this.whatsapp,
      this.fax,
      this.bankName,
      this.stc,
      this.email,
      this.id ,
        this.minKilometerBonus,
        this.maxKilometerBonus,
        this.kilometers
      });

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
    map['id'] = id;
    map['phone'] = phone;
    map['phoneTwo'] = phone2;
    map['whatsapp'] = whatsapp;
    map['fax'] = fax;
    map['bankName'] = bankName;
    map['stc'] = stc;
    map['email'] = email;
    map['minKilometerBonus']=minKilometerBonus;
    map['maxKilometerBonus']=maxKilometerBonus;
    map['kilometers']=kilometers;
    return map;
  }
}
