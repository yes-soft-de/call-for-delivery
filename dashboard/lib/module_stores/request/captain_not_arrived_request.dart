class FilterOrderCaptainNotArrivedRequest {
  String? toDate;
  String? fromDate;
  FilterOrderCaptainNotArrivedRequest({this.fromDate, this.toDate});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (toDate != null) {
      data['toDate'] = this.toDate;
    }
    if (fromDate != null) {
      data['fromDate'] = this.fromDate;
    }

    return data;
  }
}
