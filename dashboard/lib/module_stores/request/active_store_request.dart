class ActiveStoreRequest {
  int id;
  String status;

  ActiveStoreRequest({required this.id,required this.status,});

  Map<String, dynamic> toJson() => {
    'id': id,
    'status': status,
  };
}
