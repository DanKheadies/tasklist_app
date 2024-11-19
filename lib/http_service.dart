import 'dart:convert';

import 'package:dio/dio.dart';

enum Method {
  post,
  get,
  delete,
  patch,
}

class HttpService {
  Dio? _dio;

  Future<HttpService> init(BaseOptions options) async {
    _dio = Dio(options);
    return this;
  }

  request({
    required String endpoint,
    required Method method,
    Map<String, dynamic>? params,
    Map<String, dynamic>? queryParams,
  }) async {
    Response response;

    try {
      if (method == Method.get) {
        response = await _dio!.get(
          endpoint,
          queryParameters: queryParams,
          data: jsonEncode(params),
        );
      } else if (method == Method.post) {
        response = await _dio!.post(
          endpoint,
          data: jsonEncode(params),
        );
      } else if (method == Method.delete) {
        response = await _dio!.delete(endpoint);
      } else {
        response = await _dio!.patch(
          endpoint,
          data: jsonEncode(params),
        );
      }
      return response;
    } on DioException catch (err) {
      // print(err.error); // null
      // print(err.message); // main "meat" w/ code
      // print(err.response);  // blank
      // print(err.type);
      if (err.type == DioExceptionType.badResponse) {
        return Response(
          requestOptions: RequestOptions(),
          data: {
            'message': 'Bad Response',
            'status': '403',
          },
        );
      } else {
        print('other..');
        return err;
      }
    }
  }
}
