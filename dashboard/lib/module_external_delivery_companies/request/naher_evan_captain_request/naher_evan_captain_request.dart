// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';

class NaherEvanCaptainRequest {
  final int captainProfileId;
  DateTime? fromDate;
  DateTime? toDate;

  NaherEvanCaptainRequest({
    required this.captainProfileId,
    this.fromDate,
    this.toDate,
  });

  Future<Map<String, dynamic>> toMap() async {
    return <String, dynamic>{
      'captainProfileId': captainProfileId,
      if (fromDate != null) 'fromDate': fromDate,
      if (toDate != null) 'toDate': toDate,
      'customizedTimezone': await FlutterNativeTimezone.getLocalTimezone(),
    };
  }

  String toJson() => json.encode(toMap());
}
