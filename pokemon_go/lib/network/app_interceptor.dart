
import 'package:dio/dio.dart';


class AppInterceptor extends Interceptor {
  AppInterceptor();

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    //var token = SessionManager().authToken;

    // if (token.isNotEmpty) {
    //   options.headers.addAll({"Authorization": "Bearer " + token});
    //   return super.onRequest(options, handler);
    }

    @override
    void onResponse(Response response, ResponseInterceptorHandler handler) {
      if (response.statusCode! >= 200 &&
          response.statusCode! < 400) {
        response.statusCode = 200;
      } else if (response.statusCode == 401) {
        print('status code 401 ==========================================');
      }
      return super.onResponse(response, handler);
    }
  }
