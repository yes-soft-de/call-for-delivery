class Message {
  String? text;
  int? orderId;
  String? orderStatus;
  int? captainID;

  Message({this.text, this.orderId, this.captainID, this.orderStatus});

  factory Message.fromJson(Map<String, dynamic> json) => Message(
        text: json['text'] as String?,
        orderId: json['orderId'] as int?,
        orderStatus: json['orderState'] as String?,
        captainID: json['captainUserId'] as int?,
      );

  Map<String, dynamic> toJson() => {
        'text': text,
        'orderId': orderId,
      };
}
