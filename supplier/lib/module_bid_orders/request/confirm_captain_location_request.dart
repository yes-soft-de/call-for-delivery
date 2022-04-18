class ConfirmCaptainLocationRequest {
  final int orderId;
  final bool isCaptainArrived;
  ConfirmCaptainLocationRequest({
    required this.orderId,
    required this.isCaptainArrived,
  });
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = this.orderId;
    data['isCaptainArrived'] = this.isCaptainArrived ? '1' : '0';
    return data;
  }
}
