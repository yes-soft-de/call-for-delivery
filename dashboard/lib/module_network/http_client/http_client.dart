import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:firebase_performance_dio/firebase_performance_dio.dart';
import 'package:injectable/injectable.dart';
import 'package:c4d/di/di_config.dart';
import 'package:c4d/module_localization/service/localization_service/localization_service.dart';
import 'package:c4d/utils/logger/logger.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

@injectable
class ApiClient {
  final String tag = 'ApiClient';

  final performanceInterceptor = DioFirebasePerformanceInterceptor();

  ApiClient();

  Future<Map<String, dynamic>?> get(
    String url, {
    Map<String, String>? queryParams,
    Map<String, String>? headers,
  }) async {
    try {
      Logger.info(tag, 'Requesting GET to: ' + url);
      Logger.info(tag, 'Headers: ' + headers.toString());
      Logger.info(tag, 'Query: ' + queryParams.toString());
      Dio client = Dio(BaseOptions(
        sendTimeout: 60000,
        receiveTimeout: 60000,
        connectTimeout: 60000,
      ));
      if (!kIsWeb) {
        client.interceptors.add(performanceInterceptor);
      }
      if (headers != null) {
        if (headers['Authorization'] != null) {
          Logger.info(tag, 'Adding Auth Header');
          client.options.headers['Authorization'] = headers['Authorization'];
        }
        Logger.info(tag, 'LANG');
        client.options.headers['Accept-Language'] =
            getIt<LocalizationService>().getLanguage();
        // client.options.headers['Access-Control-Allow-Origin'] =
        //     '*';
      }
      //  client.options.headers['Access-Control-Allow-Origin'] = '*';
      var response = await client.get(
        url,
        queryParameters: queryParams,
      );
      return _processResponse(response);
    } catch (e) {
      if (e is DioError) {
        DioError err = e;
        if (err.response != null) {
          if (err.response!.statusCode! < 501) {
            Logger.error(
                tag, err.message + ', GET: ' + url, StackTrace.current);
            return {
              'status_code': '${err.response?.statusCode?.toString() ?? '0'}'
            };
          }
        }
      } else {
        Logger.error(tag, e.toString() + ', GET: ' + url, StackTrace.current);
      }
      return null;
    }
  }

  Future<Map<String, dynamic>?> post(
    String url,
    Map<String, dynamic> payLoad, {
    Map<String, String>? queryParams,
    Map<String, String>? headers,
  }) async {
    Dio client = Dio(BaseOptions(
      sendTimeout: 60000,
      receiveTimeout: 60000,
      connectTimeout: 60000,
    ));
    try {
      Logger.info(tag, 'Requesting Post to: ' + url);
      Logger.info(tag, 'POST: ' + jsonEncode(payLoad));
      Logger.info(tag, 'Headers: ' + jsonEncode(headers));
      if (headers != null) {
        if (headers['Authorization'] != null) {
          Logger.info(tag, 'Adding Auth Header');
          client.options.headers['Authorization'] = headers['Authorization'];
        }
      }
      // client.options.headers['Access-Control-Allow-Origin'] = '*';
      if (!kIsWeb) {
        client.interceptors.add(performanceInterceptor);
      }
      var response = await client.post(
        url,
        queryParameters: queryParams,
        data: json.encode(payLoad),
      );
      return _processResponse(response);
    } catch (e) {
      if (e is DioError) {
        DioError err = e;
        if (err.response != null) {
          if (err.response!.statusCode! < 501) {
            Logger.error(
                tag, err.message + ', POST: ' + url, StackTrace.current);
            return {
              'status_code': '${err.response?.statusCode?.toString() ?? '0'}'
            };
          }
        }
      } else {
        Logger.error(tag, e.toString() + ', POST: ' + url, StackTrace.current);
        return null;
      }
    }
    return null;
  }

  Future<Map<String, dynamic>?> put(
    String url,
    Map<String, dynamic> payLoad, {
    Map<String, String>? queryParams,
    Map<String, String>? headers,
  }) async {
    try {
      Logger.info(tag, 'Requesting PUT to: ' + url);
      Logger.info(tag, 'PUT: ' + jsonEncode(payLoad));
      Logger.info(tag, 'Headers: ' + jsonEncode(headers));
      Dio client = Dio(BaseOptions(
        sendTimeout: 60000,
        receiveTimeout: 60000,
        connectTimeout: 60000,
      ));

      if (headers != null) {
        if (headers['Authorization'] != null) {
          Logger.info(tag, 'Adding Auth Header');
          client.options.headers['Authorization'] = headers['Authorization'];
        }
      }
      //  client.options.headers['Access-Control-Allow-Origin'] = '*';
      if (!kIsWeb) {
        client.interceptors.add(performanceInterceptor);
      }
      var response = await client.put(
        url,
        queryParameters: queryParams,
        data: json.encode(payLoad),
        options: Options(headers: headers),
      );
      return _processResponse(response);
    } catch (e) {
      if (e is DioError) {
        DioError err = e;
        if (err.response != null) {
          if (err.response!.statusCode! < 501) {
            Logger.error(
                tag, err.message + ', PUT: ' + url, StackTrace.current);
            return {
              'status_code': '${err.response?.statusCode?.toString() ?? '0'}'
            };
          }
        }
      } else {
        Logger.error(tag, e.toString() + ', PUT: ' + url, StackTrace.current);
      }
      return null;
    }
  }

  Future<Map<String, dynamic>?> delete(
    String url, {
    Map<String, String>? queryParams,
    Map<String, String>? headers,
    Map<String, dynamic>? payLoad,
  }) async {
    try {
      Logger.info(tag, 'Requesting DELETE to: ' + url);
      Logger.info(tag, 'Headers: ' + headers.toString());
      Logger.info(tag, 'Query: ' + queryParams.toString());
      if (payLoad != null) {
        Logger.info(tag, 'PUT: ' + jsonEncode(payLoad));
      }
      Dio client = Dio(BaseOptions(
        sendTimeout: 60000,
        receiveTimeout: 60000,
        connectTimeout: 60000,
      ));
      if (!kIsWeb) {
        client.interceptors.add(performanceInterceptor);
      }
      if (headers != null) {
        if (headers['Authorization'] != null) {
          Logger.info(tag, 'Adding Auth Header');
          client.options.headers['Authorization'] = headers['Authorization'];
        }
      }
      //   client.options.headers['Access-Control-Allow-Origin'] = '*';
      var response = await client.delete(
        url,
        data: payLoad != null ? json.encode(payLoad) : {},
        queryParameters: queryParams,
      );
      return _processResponse(response);
    } catch (e) {
      if (e is DioError) {
        DioError err = e;
        if (err.response!.statusCode != 404) {
          Logger.error(
              tag, err.message + ', DELETE: ' + url, StackTrace.current);
        }
      } else {
        Logger.error(
            tag, e.toString() + ', DELETE: ' + url, StackTrace.current);
      }
      return null;
    }
  }

  Map<String, dynamic>? _processResponse(Response response) {
    if (response.statusCode! < 500) {
      Logger.info(tag, response.data.toString());
      return response.data;
    } else {
      Logger.error(
          tag,
          response.statusCode.toString() + '\n\n' + response.data.toString(),
          StackTrace.current);
      return null;
    }
  }
}
