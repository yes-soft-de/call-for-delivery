import 'package:store_web/di/di_config.dart';
import 'package:store_web/module_upload/service/image_upload/image_upload_service.dart';

class PdfModel {
  String? pdfFilePath;
  String? pdfOnServerPath;
  String? pdfPreview;
  String? pdfBaseUrl;
  PdfModel(
      {this.pdfFilePath,
      this.pdfOnServerPath,
      this.pdfPreview,
      this.pdfBaseUrl});
  Future<void> uploadPdf() async {
    if (pdfFilePath != null) {
      pdfOnServerPath =
          await getIt<ImageUploadService>().uploadPdf(pdfFilePath);
      return;
    } else {
      
      return;
    }
  }

  // please before call this you need to be sure that your are upload any path available
  String? getPdfRequest() {
    return pdfOnServerPath;
  }
}
