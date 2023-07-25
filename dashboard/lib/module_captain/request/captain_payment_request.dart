import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter_native_timezone/flutter_native_timezone.dart';

class CaptainPaymentRequest {
  int? captainProfileId;

  CaptainPaymentRequest({
    this.captainProfileId,
  });

  factory CaptainPaymentRequest.fromJson(Map<String, dynamic> json) {
    return CaptainPaymentRequest(
      captainProfileId: json['captainProfileId'] as int?,
    );
  }

  Future<Map<String, dynamic>> toJson() async {
    final Map<String, dynamic> data = <String, dynamic>{};

    if (!kIsWeb) {
      data['customizedTimezone'] =
          await FlutterNativeTimezone.getLocalTimezone();
    }
    if (captainProfileId != null) {
      data['captainProfileId'] = captainProfileId;
    }

    return data;
  }
}
