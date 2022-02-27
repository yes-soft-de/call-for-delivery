class FilterUserRequest{
  String? userID;
  String? type;

  FilterUserRequest( {this.userID, this.type});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userId'] = this.userID;
    data['role'] = this.type;
    return data;
  }

}