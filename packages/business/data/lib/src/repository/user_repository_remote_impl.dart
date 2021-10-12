import 'package:data/src/exceptions/exceptions.dart';
import 'package:domain/domain.dart';
import 'package:dio/dio.dart';
import 'package:data/src/mapper/user_mapper.dart';
import 'package:data/src/datasource/remote/user_repository_remote_service.dart';

class UserRepositoryRemoteImpl implements UserRepository {
  UserRepositoryRemoteImpl(this._service);

  final UserRepositoryRemoteServices _service;

  @override
  Future<List<User>> getUsers({int? page}) async {
    try {
      var response = await _service.getUsers(page ?? 1);
      var usersDTO = response.data;
      return usersDTO.map((e) => e.toModel()).toList();
    } catch (error) {
      throw _handleError(error);
    }
  }

  @override
  Future<User> getUser(dynamic id) async {
    try {
      var response = await _service.getUser(id);
      return response.data.toModel();
    } catch (error) {
      throw _handleError(error);
    }
  }

  @override
  Future<User> saveUser(User user) async {
    if (user.id == null) {
      // criar um novo user
      try {
        var response = await _service.createUser(user.toDTO());
        return response.data.toModel();
      } catch (error) {
        throw _handleError(error);
      }
    } else {
      // atualiza um user existente
      try {
        var response = await _service.updateUser(user.id, user.toDTO());
        return response.data.toModel();
      } catch (error) {
        throw _handleError(error);
      }
    }
  }

  @override
  Future<void> deleteUser(dynamic id) async {
    try {
      await _service.deleteUser(id);
    } catch (error) {
      throw _handleError(error);
    }
  }

  DataException _handleDioError(DioError error) {
    if (error.response != null) {
      switch (error.response!.statusCode) {
        case 400:
          return BadRequestException(error.response!.data.toString());
        case 401:
          return UnauthorisedException(
              'Method:${error.requestOptions.method}, Path:${error.requestOptions.path}');
        case 403:
          return ForbiddenException(
              'Method:${error.requestOptions.method}, Path:${error.requestOptions.path}');
        case 404:
          return NotFoundException(error.requestOptions.path);
        default:
          return FetchDataException(error.response!.data.toString());
      }
    } else {
      return FetchDataException(error.message);
    }
  }

  DataException _handleError(Object error) {
    if(error is DioError) {
      return _handleDioError(error);
    } else {
      return FetchDataException('Erro inesperado: ${error.toString()}');
    }
  }
}
