class FilterOrderRequest {
  String? state;
  String? toDate;
  String? fromDate;
  FilterOrderRequest({this.fromDate, this.state, this.toDate});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['state'] = this.state;
    if (toDate != null) {
      data['dateTow'] = this.toDate;
    }
    if (fromDate != null) {
      data['dateOne'] = this.fromDate;
    }

    return data;
  }
}
