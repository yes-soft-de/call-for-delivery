import 'dart:io';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:intl/intl.dart';

class FilterOrderRequest {
  int? storeOwnerProfileId;
  String? state;
  DateTime? toDate;
  DateTime? fromDate;
  num? maxKilo;
  num? maxKiloFromDistance;
  int? chosenDistanceIndicator;
  FilterOrderRequest({
    this.fromDate,
    this.maxKilo,
    this.maxKiloFromDistance,
    this.state,
    this.toDate,
    this.storeOwnerProfileId,
    this.chosenDistanceIndicator,
  });

  Future<Map<String, dynamic>> toJson() async {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['state'] = this.state;
    data['storeOwnerProfileId'] = this.storeOwnerProfileId;
    if (this.chosenDistanceIndicator != null) {
      data['chosenDistanceIndicator'] = this.chosenDistanceIndicator ?? 0;
    }
    if (this.maxKiloFromDistance != null) {
      data['storeBranchToClientDistance'] = this.maxKiloFromDistance;
    }
    if (this.maxKilo != null) {
      data['kilometer'] = this.maxKilo;
    }
    if (toDate != null) {
      data['toDate'] = DateFormat('yyyy-MM-dd', 'en').format(toDate!);
    }
    if (fromDate != null) {
      data['fromDate'] = DateFormat('yyyy-MM-dd', 'en').format(fromDate!);
    }
    if (Platform.isAndroid || Platform.isIOS) {
      data['customizedTimezone'] =
          await FlutterNativeTimezone.getLocalTimezone();
    }
    return data;
  }
}
