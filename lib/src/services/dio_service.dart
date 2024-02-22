import 'dart:convert';

import 'package:dio/dio.dart';

import 'package:toolbox/src/constant/constant.dart';
import 'package:toolbox/src/services/error_handling_interceptor.dart';
import 'package:toolbox/src/services/token_interceptor.dart';

class DioService {
  factory DioService() => _instance;

  static final DioService _instance = DioService._internal();
  static late Dio _dio;

  DioService._internal() {
    init();
  }

  static Future<Dio> init() async {
    var options = BaseOptions(
      baseUrl: Constant.backendUrl,
      connectTimeout: const Duration(milliseconds: 5000),
      receiveTimeout: const Duration(milliseconds: 3000),
      receiveDataWhenStatusError: true,
      followRedirects: true,
      headers: {'Content-Type': 'application/json'},
    );
    _dio = Dio(options);
    _dio.interceptors.addAll([
      TokenInterceptor(dio: _dio),
      ErrorHandlingInterceptor(dio: _dio),
    ]);

    return _dio;
  }

  static bool isValidStatusCode(int statusCode) {
    if (statusCode >= 200 && statusCode < 300) {
      return true;
    } else {
      return false;
    }
  }

  static Future<Map<String, dynamic>> get(
    String url, {
    Map<String, dynamic>? queryParams,
    Function? successCallBack,
    Function? errorCallBack,
  }) async {
    try {
      Response response = await _dio.get(url, queryParameters: queryParams);
      Map<String, dynamic> dataMap = json.decode(json.encode(response.data));
      if (successCallBack != null) {
        successCallBack(dataMap);
      } else {
        return dataMap;
      }
    } catch (error) {
      if (errorCallBack != null) {
        errorCallBack(error.toString());
      } else {
        return <String, dynamic>{};
      }
    }
    return <String, dynamic>{};
  }

  static Future<Map<String, dynamic>> post(
    String url, {
    dynamic params,
    Function? successCallBack,
    Function? errorCallBack,
  }) async {
    try {
      Response response = await _dio.post(url, data: params);
      Map<String, dynamic> dataMap = json.decode(json.encode(response.data));
      if (successCallBack != null) {
        successCallBack(dataMap);
      } else {
        return dataMap;
      }
    } catch (error) {
      if (errorCallBack != null) {
        errorCallBack(error.toString());
      } else {
        return <String, dynamic>{};
      }
    }
    return <String, dynamic>{};
  }
}
