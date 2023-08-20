class ChatModel {
  String? sender;
  var sentDate;
  String? msg;
  bool? isAdmin;

  ChatModel({this.sentDate, this.sender, this.msg, this.isAdmin});

  ChatModel.fromJson(Map<String, dynamic> jsonData) {
    sender = jsonData['sender'];
    isAdmin = jsonData['isAdmin'];
    try {
      msg = jsonData['msg']['message'];
    } catch (e) {
      msg = jsonData['msg'].toString();
    }
    if (jsonData['sentDate'] is String) {
      sentDate = DateTime.tryParse(jsonData['sentDate']);
    }
    if (jsonData['sentDate'] is int) {
      sentDate = DateTime.fromMillisecondsSinceEpoch((jsonData['sentDate'] ?? 1));
    }
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> jsonData = {
      'isAdmin': isAdmin,
      'sender': sender,
      'msg': msg,
      'sentDate': sentDate
    };

    return jsonData;
  }
}
