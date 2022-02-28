import 'package.dart';

class Datum {
  int? id;
  String? name;
  String? description;
  List<Package>? packages;

  Datum({this.id, this.name, this.description, this.packages});

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json['id'] as int?,
        name: json['name'] as String?,
        description: json['description'] as String?,
        packages: (json['packages'] as List<dynamic>?)
            ?.map((e) => Package.fromJson(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'description': description,
        'packages': packages?.map((e) => e.toJson()).toList(),
      };
}
