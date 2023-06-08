class PendingOrderRequest {
  PendingOrderRequestType type;

  PendingOrderRequest({
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
