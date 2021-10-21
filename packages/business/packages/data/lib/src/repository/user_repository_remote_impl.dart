import 'package:data/src/datasource/remote/dto/rest_response.dart';
import 'package:data/src/datasource/remote/dto/user_dto.dart';
import 'package:data/src/exception/exceptions.dart';
import 'package:domain/domain.dart';
import 'package:dio/dio.dart';
import 'package:data/src/mapper/user_mapper.dart';
import 'package:data/src/datasource/remote/user_repository_remote_service.dart';
import 'package:injectable/injectable.dart';
import 'package:domain/exceptions.dart' show DomainException;

@Injectable(as: UserRepository)
class UserRepositoryRemoteImpl implements UserRepository {
  UserRepositoryRemoteImpl(this._service);

  final UserRepositoryRemoteServices _service;

  @override
  Future<Paginated<User>> getUsers({int? page}) async {
    try {
      var response = await _service.getUsers(page ?? 1);
      return _generatePaginateReturn(response);
    } catch (error) {
      throw _handleError(error, StackTrace.current);
    }
  }

  @override
  Future<User> getUser(dynamic id) async {
    try {
      var response = await _service.getUser(id);
      return response.data.toModel();
    } catch (error) {
      throw _handleError(error, StackTrace.current);
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
        throw _handleError(error, StackTrace.current);
      }
    } else {
      // atualiza um user existente
      try {
        var response = await _service.updateUser(user.id, user.toDTO());
        return response.data.toModel();
      } catch (error) {
        throw _handleError(error, StackTrace.current);
      }
    }
  }

  @override
  Future<void> deleteUser(dynamic id) async {
    try {
      await _service.deleteUser(id);
    } catch (error) {
      throw _handleError(error, StackTrace.current);
    }
  }

  @override
  Future<Paginated<User>> findByName(String name, {int page = 1}) async {
    try {
      var response = await _service.findByName(name, page);
      return _generatePaginateReturn(response);
    } catch (error) {
      throw _handleError(error, StackTrace.current);
    }
  }

  @override
  Future<Paginated<User>> findByEmail(String email, {int page = 1}) async {
    try {
      var response = await _service.findByEmail(email, page);
      return _generatePaginateReturn(response);
    } catch (error) {
      throw _handleError(error,StackTrace.current);
    }
  }

  Paginated<User> _generatePaginateReturn(
      RestResponse<List<UserDTO>> response) {
    var usersDTO = response.data;
    var pagination = response.meta!.pagination;
    return Paginated<User>(
        total: pagination.total,
        size: pagination.size,
        pages: pagination.pages,
        page: pagination.page,
        elements: usersDTO.map((e) => e.toModel()).toList());
  }

  DomainException _handleDioError(DioError error, StackTrace stackTrace) {
    if (error.response != null) {
      switch (error.response!.statusCode) {
        case 400:
          return BadRequestException(error.response!.data.toString(), stackTrace);
        case 401:
          return UnauthorisedException(
              'Method:${error.requestOptions.method}, Path:${error.requestOptions.path}', stackTrace);
        case 403:
          return ForbiddenException(
              'Method:${error.requestOptions.method}, Path:${error.requestOptions.path}', stackTrace);
        case 404:
          return NotFoundException(error.requestOptions.path, stackTrace);
        default:
          return FetchDataException(error.response!.data.toString(), stackTrace);
      }
    } else {
      return FetchDataException(error.message, stackTrace);
    }
  }

  DomainException _handleError(Object error, StackTrace stackTrace) {
    if (error is DioError) {
      return _handleDioError(error, stackTrace);
    } else {
      return FetchDataException(error.toString(), stackTrace);
    }
  }
}
