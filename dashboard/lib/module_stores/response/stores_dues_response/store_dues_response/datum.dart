class Datum {
  int? id;
  int? storeOwnerProfileId;
  String? storeOwnerName;
  String? image;
  int? amount;
  int? toBePaid;
  List<String>? paymentFromCompanyToStore;
  String? flag;

  Datum({
    this.id,
    this.storeOwnerProfileId,
    this.storeOwnerName,
    this.image,
    this.amount,
    this.toBePaid,
    this.paymentFromCompanyToStore,
    this.flag,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json['id'] as int?,
        storeOwnerProfileId: json['storeOwnerProfileId'] as int?,
        storeOwnerName: json['storeOwnerName'] as String?,
        image: json['image']['image'] as String?,
        amount: json['amount'] as int?,
        toBePaid: json['toBePaid'] as int?,
        paymentFromCompanyToStore:
            json['paymentFromCompanyToStore'] as List<String>?,
        flag: json['flag'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'storeOwnerProfileId': storeOwnerProfileId,
        'storeOwnerName': storeOwnerName,
        'image': image,
        'amount': amount,
        'toBePaid': toBePaid,
        'paymentFromCompanyToStore': paymentFromCompanyToStore,
        'flag': flag,
      };
}
