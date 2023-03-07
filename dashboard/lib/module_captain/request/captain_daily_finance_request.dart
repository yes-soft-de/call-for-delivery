class CaptainDailyFinanceRequest {
  DateTime? fromDate;
  DateTime? toDate;
  int? captainProfileId;
  int? isPaid;

  CaptainDailyFinanceRequest(
      {this.fromDate, this.toDate, this.captainProfileId, this.isPaid});

  factory CaptainDailyFinanceRequest.fromJson(Map<String, dynamic> json) {
    return CaptainDailyFinanceRequest(
      fromDate: json['fromDate'] == null
          ? null
          : DateTime.parse(json['fromDate'] as String),
      toDate: json['toDate'] == null
          ? null
          : DateTime.parse(json['toDate'] as String),
      captainProfileId: json['captainProfileId'] as int?,
      isPaid: json['isPaid'] as int?,
    );
  }

  Map<String, dynamic> toJson() => {
        'fromDate': fromDate?.toIso8601String(),
        'toDate': toDate?.toIso8601String(),
        'captainProfileId': captainProfileId,
        'isPaid': isPaid,
      };
}
