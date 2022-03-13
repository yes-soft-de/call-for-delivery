class UpdateOrderStateRequest{
  String id;
  String state;

  UpdateOrderStateRequest(this.id, this.state);


  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = this.id;
    data['state'] = this.state;
    return data;
  }
}