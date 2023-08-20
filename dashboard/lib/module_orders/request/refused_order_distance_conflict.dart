import 'dart:convert';

import 'package:c4d/utils/extension/string_extensions.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class RefusedOrderDistanceConflictRequest {
  int? id;
  String? adminNote;

  RefusedOrderDistanceConflictRequest({
    required this.id,
    this.adminNote,
  });

  Map<String, dynamic> toMap() {
    if (adminNote.nullOrEmpty()) adminNote = ' ';

    return <String, dynamic>{
      'id': id,
      'adminNote': adminNote,
    };
  }

  String toJson() => json.encode(toMap());
}
