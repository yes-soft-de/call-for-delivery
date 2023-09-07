// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';

class NaherEvanCaptainRequest {
  final int captainProfileId;
  final DateTime fromDate;
  final DateTime toDate;

  NaherEvanCaptainRequest({
    required this.captainProfileId,
    required this.fromDate,
    required this.toDate,
  });

  NaherEvanCaptainRequest copyWith({
    int? captainProfileId,
    DateTime? fromDate,
    DateTime? toDate,
  }) {
    return NaherEvanCaptainRequest(
      captainProfileId: captainProfileId ?? this.captainProfileId,
      fromDate: fromDate ?? this.fromDate,
      toDate: toDate ?? this.toDate,
    );
  }

  Future<Map<String, dynamic>> toMap() async {
    return <String, dynamic>{
      'captainProfileId': captainProfileId,
      'fromDate': fromDate.millisecondsSinceEpoch,
      'toDate': toDate.millisecondsSinceEpoch,
      'customizedTimezone': await FlutterNativeTimezone.getLocalTimezone(),
    };
  }

  String toJson() => json.encode(toMap());
}
