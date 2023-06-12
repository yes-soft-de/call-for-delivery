class PendingOrderRequest {
  PendingOrderRequestType type;
  int externalCompanyId;
  String? storeOwnerProfileId;
  String? storeBranchId;
  DateTime? toDate;
  DateTime? fromDate;

  PendingOrderRequest({
    this.externalCompanyId = 0,
    required this.type,
    this.storeOwnerProfileId,
    this.storeBranchId,
    this.fromDate,
    this.toDate,
  });
}

enum PendingOrderRequestType {
  all,
  onlyExternal;

  String get value {
    if (this == PendingOrderRequestType.onlyExternal) return '1';
    return '0';
  }
}
