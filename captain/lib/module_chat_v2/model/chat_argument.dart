class ChatArgument {
  String roomID;
  String? userType;
  bool support;
  int? userID;
  bool guest;
  String? name;

  ChatArgument({
    required this.roomID,

    /// the type of user you talking to
    required this.userType,
    this.support = false,
    this.userID,
    this.guest = false,
    required this.name,
  });
}
