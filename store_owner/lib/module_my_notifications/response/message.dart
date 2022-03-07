class Message {
  String? text;
  int? orderId;

  Message({this.text, this.orderId});

  factory Message.fromJson(Map<String, dynamic> json) => Message(
        text: json['text'] as String?,
        orderId: json['orderId'] as int?,
      );

  Map<String, dynamic> toJson() => {
        'text': text,
        'orderId': orderId,
      };
}
