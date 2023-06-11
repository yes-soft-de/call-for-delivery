class PendingOrderRequest {
  PendingOrderRequestType type;
  int externalCompanyId;

  PendingOrderRequest({
    this.externalCompanyId = 0,
    required this.type,
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
