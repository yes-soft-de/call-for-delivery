import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class DeleteCompanyCriterialRequest {
  int id;
  DeleteCompanyCriterialRequest({
    required this.id,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
    };
  }

  factory DeleteCompanyCriterialRequest.fromMap(Map<String, dynamic> map) {
    return DeleteCompanyCriterialRequest(
      id: (map['id'] ?? 0) as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory DeleteCompanyCriterialRequest.fromJson(String source) =>
      DeleteCompanyCriterialRequest.fromMap(
          json.decode(source) as Map<String, dynamic>);
}
