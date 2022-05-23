class CaptainFinanceRequest {
  int? planId;
  int? planType;
  bool? status;
  int? id;
  CaptainFinanceRequest.empty();

  CaptainFinanceRequest({
    this.planId,
    this.planType,
    this.id,
    this.status
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data['captainFinancialSystemType'] = planType;
    data['captainFinancialSystemId'] = planId;
    data['id'] = id;
    data['status'] = status == true ? 1 : 0;

    return data;
  }
}
