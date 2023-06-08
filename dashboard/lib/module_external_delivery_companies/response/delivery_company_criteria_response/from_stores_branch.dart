class FromStoresBranch {
  int? branchId;
  String? branchName;

  FromStoresBranch({
    this.branchId,
    this.branchName,
  });

  factory FromStoresBranch.fromJson(Map<String, dynamic> json) {
    return FromStoresBranch(
      branchId: json['id'],
      branchName: json['name'],
    );
  }
}
