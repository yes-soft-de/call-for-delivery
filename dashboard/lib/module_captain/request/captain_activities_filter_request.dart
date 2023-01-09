import 'package:c4d/generated/l10n.dart';

class CaptainActivityFilterRequest {
  String? state;
  DateTime? toDate;
  DateTime? fromDate;
  CaptainActivityFilterRequest({
    this.fromDate,
    this.state,
    this.toDate,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.state != null) {
      data['state'] = this.state;
    }
    if (toDate != null) {
      data['toDate'] = DateTime(
              this.toDate!.year, this.toDate!.month, this.toDate!.day + 1, 0)
          .toIso8601String();
    }
    if (fromDate != null) {
      data['fromDate'] = DateTime(
              this.fromDate!.year, this.fromDate!.month, this.fromDate!.day, 0)
          .toUtc()
          .toIso8601String();
    }
    return data;
  }
}
