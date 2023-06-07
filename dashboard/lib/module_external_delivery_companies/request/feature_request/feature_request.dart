import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class FeatureRequest {
  int id;
  bool featureStatus;
  FeatureRequest({
    this.id = 2,
    required this.featureStatus,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'featureStatus': featureStatus,
    };
  }

  factory FeatureRequest.fromMap(Map<String, dynamic> map) {
    return FeatureRequest(
      id: (map['id'] ?? 0) as int,
      featureStatus: (map['featureStatus'] ?? false) as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory FeatureRequest.fromJson(String source) =>
      FeatureRequest.fromMap(json.decode(source) as Map<String, dynamic>);
}
