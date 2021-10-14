// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_repository_remote_service.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

class _UserRepositoryRemoteServices implements UserRepositoryRemoteServices {
  _UserRepositoryRemoteServices(this._dio, {this.baseUrl}) {
    baseUrl ??= 'https://gorest.co.in/public/v1';
  }

  final Dio _dio;

  String? baseUrl;

  @override
  Future<RestResponse<UserDTO>> getUser(id) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<RestResponse<UserDTO>>(
            Options(method: 'GET', headers: <String, dynamic>{}, extra: _extra)
                .compose(_dio.options, '/users/$id',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = RestResponse<UserDTO>.fromJson(_result.data!);
    return value;
  }

  @override
  Future<RestResponse<List<UserDTO>>> getUsers(page) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<RestResponse<List<UserDTO>>>(
            Options(method: 'GET', headers: <String, dynamic>{}, extra: _extra)
                .compose(_dio.options, '/users?page=$page',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = RestResponse<List<UserDTO>>.fromJson(_result.data!);
    return value;
  }

  @override
  Future<RestResponse<UserDTO>> createUser(user) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(user.toJson());
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<RestResponse<UserDTO>>(Options(
                method: 'POST',
                headers: <String, dynamic>{
                  r'Content-Type': 'application/json',
                  r'Authorization':
                      'Bearer 14a842a38e579f2320b377dab8f8e17ec59a19993c28c9c15b505021efc4f74b'
                },
                extra: _extra,
                contentType: 'application/json')
            .compose(_dio.options, '/users',
                queryParameters: queryParameters, data: _data)
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = RestResponse<UserDTO>.fromJson(_result.data!);
    return value;
  }

  @override
  Future<RestResponse<UserDTO>> updateUser(id, user) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(user.toJson());
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<RestResponse<UserDTO>>(Options(
                method: 'PATCH',
                headers: <String, dynamic>{
                  r'Content-Type': 'application/json',
                  r'Authorization':
                      'Bearer 14a842a38e579f2320b377dab8f8e17ec59a19993c28c9c15b505021efc4f74b'
                },
                extra: _extra,
                contentType: 'application/json')
            .compose(_dio.options, '/users/$id',
                queryParameters: queryParameters, data: _data)
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = RestResponse<UserDTO>.fromJson(_result.data!);
    return value;
  }

  @override
  Future<void> deleteUser(id) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    await _dio.fetch<void>(_setStreamType<void>(Options(
            method: 'DELETE',
            headers: <String, dynamic>{
              r'Content-Type': 'application/json',
              r'Authorization':
                  'Bearer 14a842a38e579f2320b377dab8f8e17ec59a19993c28c9c15b505021efc4f74b'
            },
            extra: _extra,
            contentType: 'application/json')
        .compose(_dio.options, '/users/$id',
            queryParameters: queryParameters, data: _data)
        .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    return null;
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
