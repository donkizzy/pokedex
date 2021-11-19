
import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';


class AppInterceptor extends Interceptor {
  AppInterceptor();

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {

       return super.onRequest(options, handler);
    }

    @override
    void onResponse(Response response, ResponseInterceptorHandler handler) {
      if (response.statusCode! >= 200 &&
          response.statusCode! < 400) {
        response.statusCode = 200;
      } else if (response.statusCode == 401) {
        debugPrint('status code 401 ==========================================');
      }
      return super.onResponse(response, handler);
    }
  }
