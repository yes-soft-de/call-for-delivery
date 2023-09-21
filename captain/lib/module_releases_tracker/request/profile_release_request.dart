import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class ProfileReleaseRequest {
  String version;

  ProfileReleaseRequest({
    required this.version,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'version': version,
    };
  }

  factory ProfileReleaseRequest.fromMap(Map<String, dynamic> map) {
    return ProfileReleaseRequest(
      version: (map['version'] ?? '') as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory ProfileReleaseRequest.fromJson(String source) =>
      ProfileReleaseRequest.fromMap(
          json.decode(source) as Map<String, dynamic>);
}
