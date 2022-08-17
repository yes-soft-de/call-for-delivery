class FilterOrderRequest {
  String? state;
  String? toDate;
  String? fromDate;
  FilterOrderRequest({this.fromDate, this.state, this.toDate});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.state != null) {
      data['state'] = this.state;
    }
    if (toDate != null) {
      data['toDate'] = this.toDate;
    }
    if (fromDate != null) {
      data['fromDate'] = this.fromDate;
    }

    return data;
  }
}
