class ActivePackageRequest {
  int id;
  String status;

  ActivePackageRequest({
    required this.id,
    required this.status,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'status': status,
      };
}
