class Datum {
  String? month;
  int? storeOwnerProfileId;
  String? storeOwnerName;
  String? image;
  int? amount;
  int? toBePaid;

  Datum({
    this.month,
    this.storeOwnerProfileId,
    this.storeOwnerName,
    this.image,
    this.amount,
    this.toBePaid,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        month: json['month'] as String?,
        storeOwnerProfileId: json['storeOwnerProfileId'] as int?,
        storeOwnerName: json['storeOwnerName'] as String?,
        image: json['image']['image'] as String?,
        amount: json['amount'] as int?,
        toBePaid: json['toBePaid'] as int?,
      );

  Map<String, dynamic> toJson() => {
        'month': month,
        'storeOwnerProfileId': storeOwnerProfileId,
        'storeOwnerName': storeOwnerName,
        'image': image,
        'amount': amount,
        'toBePaid': toBePaid,
      };
}
