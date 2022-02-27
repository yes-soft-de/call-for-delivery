class UpdatePassRequest{
  int id;
  String password;

  UpdatePassRequest(this.id, this.password);


  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = this.id;
    data['password'] = this.password;
    return data;
  }
}