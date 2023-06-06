import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class UpdateCompanyCriterialStatusRequest {
  int id;
  bool status;
  UpdateCompanyCriterialStatusRequest({
    required this.id,
    required this.status,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'status': status,
    };
  }

  factory UpdateCompanyCriterialStatusRequest.fromMap(Map<String, dynamic> map) {
    return UpdateCompanyCriterialStatusRequest(
      id: (map['id'] ?? 0) as int,
      status: (map['status'] ?? false) as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory UpdateCompanyCriterialStatusRequest.fromJson(String source) => UpdateCompanyCriterialStatusRequest.fromMap(json.decode(source) as Map<String, dynamic>);
}
