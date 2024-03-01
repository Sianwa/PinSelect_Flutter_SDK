// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_client.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps,no_leading_underscores_for_local_identifiers

class _APIClient implements APIClient {
  _APIClient(
    this._dio, {
    this.baseUrl,
  });

  final Dio _dio;

  String? baseUrl;

  @override
  Future<InitResponseModel> initializeService(requestPayloadModel) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{
      r'InstID': '54',
      r'Nonce': 'd180fa188a9548139d5ab69b3438db72',
      r'Timestamp': '1709280789113',
      r'SignatureMethod': 'SHA1',
      r'Signature': 'SiYdARRXG2AO15Z8wxwvd4gx1mU=',
      r'Authorization':
          'InterswitchAuth SUtJQTk3MUZCNTk5NkVBREJEMTY1MzQ0OTRDQjg3QjkwRDFEQjNFQUQxMDU=',
    };
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    _data.addAll(requestPayloadModel.toJson());
    final _result = await _dio
        .fetch<Map<String, dynamic>>(_setStreamType<InitResponseModel>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              'identity/api/v1/web/initialize',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = InitResponseModel.fromJson(_result.data!);
    return value;
  }

  @override
  Future<dynamic> getMLE() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch(_setStreamType<dynamic>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
        .compose(
          _dio.options,
          'identity/api/v1/keys/mle',
          queryParameters: queryParameters,
          data: _data,
        )
        .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = _result.data;
    return value;
  }

  RequestOptions _setStreamType<T>(RequestOptions requestOptions) {
    if (T != dynamic &&
        !(requestOptions.responseType == ResponseType.bytes ||
            requestOptions.responseType == ResponseType.stream)) {
      if (T == String) {
        requestOptions.responseType = ResponseType.plain;
      } else {
        requestOptions.responseType = ResponseType.json;
      }
    }
    return requestOptions;
  }
}
