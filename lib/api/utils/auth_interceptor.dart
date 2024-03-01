import 'package:dio/dio.dart';


class AuthInterceptor extends Interceptor {
  AuthInterceptor(this._authHeaders);

  final Map<String, String> _authHeaders;

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.headers["InstID"] = _authHeaders["InstID"];
    options.headers["Nonce"] = _authHeaders["Nonce"];
    options.headers["Timestamp"] = _authHeaders["Timestamp"];
    options.headers["SignatureMethod"] = _authHeaders["SignatureMethod"];
    options.headers["Signature"] = _authHeaders["Signature"];
    options.headers["Authorization"] = _authHeaders["Authorization"];
    return handler.next(options);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    if (err.response != null) {
      final errorMsg = err.response!.data.toString();
      if (errorMsg.contains("cannot be trusted")) {
      } else if (err.response!.statusCode == 403) {}
    }
    return super.onError(err, handler);
  }
}
