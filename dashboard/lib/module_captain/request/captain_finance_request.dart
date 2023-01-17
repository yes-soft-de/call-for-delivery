class CaptainFinanceRequest {
  int? planId;
  int? planType;
  bool? status;
  int? id;
  int? captain;
  CaptainFinanceRequest.empty();

  CaptainFinanceRequest(
      {this.planId, this.planType, this.id, this.status, this.captain});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (planType != null) {
      data['captainFinancialSystemType'] = planType;
    }
    if (planId != null) {
      data['captainFinancialSystemId'] = planId;
    }
    if (id != null) {
      data['id'] = id;
    }
    if (status != null) {
      data['status'] = status == true ? 1 : 0;
    }
    if (captain != null) {
      data['captain'] = captain;
    }

    return data;
  }
}
