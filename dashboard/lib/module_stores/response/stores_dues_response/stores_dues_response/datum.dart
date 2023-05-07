class Datum {
  int? id;
  int? storeOwnerProfileId;
  String? storeOwnerName;
  String? image;
  int? amountSum;
  int? toBePaid;

  Datum({
    this.id,
    this.storeOwnerProfileId,
    this.storeOwnerName,
    this.image,
    this.amountSum,
    this.toBePaid,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json['id'] as int?,
        storeOwnerProfileId: json['storeOwnerProfileId'] as int?,
        storeOwnerName: json['storeOwnerName'] as String?,
        image: json['image']['image'] as String?,
        amountSum: json['amountSum'] as int?,
        toBePaid: json['toBePaid'] as int?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'storeOwnerProfileId': storeOwnerProfileId,
        'storeOwnerName': storeOwnerName,
        'image': image,
        'amountSum': amountSum,
        'toBePaid': toBePaid,
      };
}
