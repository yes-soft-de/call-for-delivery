class ChatModel {
  String? sender;
  int? sentDate;
  String? msg;
  String? id;
  /// 1 for text , 2 for images
  int? messageType;

  ChatModel({this.sentDate, this.sender, this.msg,this.id,this.messageType});

  ChatModel.fromJson(Map<String, dynamic> jsonData) {
    sender = jsonData['sender'];
    try {
      msg = jsonData['msg']['message'];
    } catch (e) {
      msg = jsonData['msg'].toString();
    }
    if (jsonData['sentDate'] is String) {
      sentDate = DateTime.tryParse(jsonData['sentDate'])?.millisecondsSinceEpoch;
    }
    if (jsonData['sentDate'] is int) {
      sentDate =  DateTime.fromMillisecondsSinceEpoch(jsonData['sentDate'] ?? 1).millisecondsSinceEpoch;
    }
    messageType = jsonData['messageType'];
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> jsonData = {
      'sender': sender,
      'msg': msg,
      'sentDate': DateTime.fromMillisecondsSinceEpoch(sentDate!).toIso8601String(),
      'id': id,
      'messageType':messageType
    };

    return jsonData;
  }
}
