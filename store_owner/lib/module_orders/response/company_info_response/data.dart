class Data {
  String? phone;
  String? phoneTwo;
  String? whatsapp;
  String? fax;
  String? bankName;
  String? stc;
  String? email;
  int? kilometers;
  num? maxKilometerBonus;
  num? minKilometerBonus;

  Data({
    this.phone,
    this.phoneTwo,
    this.whatsapp,
    this.fax,
    this.bankName,
    this.stc,
    this.email,
    this.kilometers,
    this.maxKilometerBonus,
    this.minKilometerBonus,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        phone: json['phone'] as String?,
        phoneTwo: json['phoneTwo'] as String?,
        whatsapp: json['whatsapp'] as String?,
        fax: json['fax'] as String?,
        bankName: json['bankName'] as String?,
        stc: json['stc'] as String?,
        email: json['email'] as String?,
        kilometers: json['kilometers'] as int?,
        maxKilometerBonus: json['maxKilometerBonus'] as num?,
        minKilometerBonus: json['minKilometerBonus'] as num?,
      );

  Map<String, dynamic> toJson() => {
        'phone': phone,
        'phoneTwo': phoneTwo,
        'whatsapp': whatsapp,
        'fax': fax,
        'bankName': bankName,
        'stc': stc,
        'email': email,
        'kilometers': kilometers,
        'maxKilometerBonus': maxKilometerBonus,
        'minKilometerBonus': minKilometerBonus,
      };
}
