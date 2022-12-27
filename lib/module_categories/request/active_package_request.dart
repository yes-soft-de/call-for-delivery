class ActivePackageRequest {
  int id;
  dynamic status;

  ActivePackageRequest({
    required this.id,
    required this.status,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'status': status,
      };
}
