
import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';
import 'package:injectable/injectable.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:store_web/consts/urls.dart';
import 'package:store_web/module_upload/response/imgbb/imgbb_response.dart';
import 'package:store_web/utils/logger/logger.dart';

@injectable
class UploadRepository {
  Future<ImgBBResponse?> upload(String filePath) async {
    var client = Dio();
    MultipartFile? multi;
    if (kIsWeb) {
      var file = await XFile(filePath).readAsBytes();
      multi = MultipartFile.fromBytes(file,
          filename: DateTime.now().toIso8601String() + '-image');
    }
    FormData data = FormData.fromMap({
      'image': kIsWeb ? multi : await MultipartFile.fromFile(filePath),
    });

    Logger().info('UploadRepo', 'Uploading: ' + filePath);
    try {
      Response? response = await client.post(
        Urls.UPLOAD_API,
        data: data,
      );
      Logger().info('Got a Response', response.toString());
      return ImgBBResponse(url: response.data);
    } catch (e) {
      return null;
    }
  }

  Future<ImgBBResponse?> uploadPDF(String filePath) async {
    var client = Dio();
    MultipartFile? multi;
    if (kIsWeb) {
      var file = await XFile(filePath).readAsBytes();
      multi = MultipartFile.fromBytes(file,
          filename: DateTime.now().toIso8601String() + '-pdf');
    }
    FormData data = FormData.fromMap({
      'file': kIsWeb ? multi : await MultipartFile.fromFile(filePath),
    });

    Logger().info('UploadRepo', 'Uploading: ' + filePath);
    try {
      Response? response = await client.post(
        Urls.UPLOAD_PDF_API,
        data: data,
      );
      Logger().info('Got a Response', response.toString());
      return ImgBBResponse(url: response.data);
    } catch (e) {
      return null;
    }
  }
}
