import '../created_at.dart';

class Datum {
  int? id;
  String? title;
  String? description;
  CreatedAt? createdAt;
  bool? openToPriceOffer;
  Datum({
    this.id,
    this.createdAt,
    this.description,
    this.title,
    this.openToPriceOffer
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json['id'] as int?,
        title: json['title'] as String?,
        description: json['description'] as String?,
        openToPriceOffer: json['openToPriceOffer'] as bool?,
        createdAt: json['createdAt'] == null
            ? null
            : CreatedAt.fromJson(json['createdAt'] as Map<String, dynamic>),
      );
}
