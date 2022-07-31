class FilePdfResponse {
  String? fileUrl;
  String? file;
  String? baseUrl;

  FilePdfResponse({this.fileUrl, this.file, this.baseUrl});

  factory FilePdfResponse.fromJson(Map<String, dynamic> json) {
    return FilePdfResponse(
      fileUrl: json['fileURL'] as String?,
      file: json['file'] as String?,
      baseUrl: json['baseURL'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        'fileURL': fileUrl,
        'file': file,
        'baseURL': baseUrl,
      };
}
