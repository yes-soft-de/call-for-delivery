class ActiveCategoryRequest {
  int id;
  bool status;

  ActiveCategoryRequest({
    required this.id,
    required this.status,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'status': status,
      };
}
