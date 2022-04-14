class SendNotificationRequest{
  int? otherUserId;
  String? appType;
  String title;
  String messageBody;

  SendNotificationRequest({
    this.otherUserId,
    this.appType,
   required this.title,
    required  this.messageBody});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['otherUserId'] = this.otherUserId;
    data['appType'] = this.appType;
    data['title'] = this.title;
    data['messageBody'] = this.messageBody;
    return data;
  }
}