import 'package:domain/domain.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';
import 'user_dto.dart';

part 'user_repository_remote_impl.g.dart';

@RestApi(baseUrl: 'https://jsonplaceholder.typicode.com/')
abstract class UserRepositoryRemoteServices {
  factory UserRepositoryRemoteServices(Dio dio, {String baseUrl}) =
  _UserRepositoryRemoteServices;

  @GET('/users/{id}')
  Future<UserDTO> getUser(@Path('id') dynamic id);

  @GET('/users')
  Future<List<UserDTO>> getUsers();
}

class UserRepositoryRemoteImpl implements UserRepository {
  UserRepositoryRemoteImpl(this._service);

  UserRepositoryRemoteServices _service;

  @override
  Future<List<User>> getUsers() async {
    var usersDTO = await _service.getUsers();
    return usersDTO.map((e) => e.toModel()).toList();
  }

  @override
  Future<User> getUser(@Path('id') dynamic id) async {
    var userDTO = await _service.getUser(id);
    return userDTO.toModel();
  }
}

