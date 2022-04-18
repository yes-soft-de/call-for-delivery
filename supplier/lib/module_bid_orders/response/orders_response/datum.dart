import 'created_at.dart';

class Datum {
  int? id;
  String? title;
  String? description;
  CreatedAt? createdAt;
  Datum({
    this.id,
    this.createdAt,
    this.description,
    this.title
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json['id'] as int?,
        title: json['state'] as String?,
        description: json['payment'] as String?,
        createdAt: json['createdAt'] == null
            ? null
            : CreatedAt.fromJson(json['createdAt'] as Map<String, dynamic>),
      );
}
