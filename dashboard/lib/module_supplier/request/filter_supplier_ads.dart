class FilterSupplierAds {
  String? toDate;
  String? fromDate;
  int supplierProfileId;
  int? supplierCategoryId;
  String? status;
  String? administrationStatus;

  FilterSupplierAds(
      {this.toDate,
      this.fromDate,
      required this.supplierProfileId,
      this.supplierCategoryId,
      this.status,
      this.administrationStatus});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['supplierCategoryId'] = this.supplierCategoryId;
    data['supplierProfileId'] = this.supplierProfileId;
    if (toDate != null) {
      data['toDate'] = this.toDate;
    }
    if (fromDate != null) {
      data['fromDate'] = this.fromDate;
    }

    return data;
  }
}
