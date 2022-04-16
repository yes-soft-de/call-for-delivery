class CaptainFinanceRequest {
  int? planId;
  int? planType;

  CaptainFinanceRequest.empty();

  CaptainFinanceRequest({
    this.planId,
    this.planType,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data['captainFinancialSystemType'] = planId;
    data['captainFinancialSystemId'] = planType;
    return data;
  }
}
