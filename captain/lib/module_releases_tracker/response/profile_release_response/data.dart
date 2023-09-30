class Data {
  bool? newVersionExist;
  bool? isCritical;
  String? releaseVersion;
  int? platformOs;

  Data({
    this.newVersionExist,
    this.isCritical,
    this.releaseVersion,
    this.platformOs,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        newVersionExist: json['newVersionExist'] as bool?,
        isCritical: json['isCritical'] as bool?,
        releaseVersion: json['releaseVersion'] as String?,
        platformOs: json['platformOS'] as int?,
      );

  Map<String, dynamic> toJson() => {
        'newVersionExist': newVersionExist,
        'isCritical': isCritical,
        'releaseVersion': releaseVersion,
        'platformOS': platformOs,
      };
}
