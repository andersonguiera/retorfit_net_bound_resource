import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';
import 'dto/user_dto.dart';
part 'user_repository_remote_service.g.dart';

@RestApi(baseUrl: 'https://jsonplaceholder.typicode.com/')
abstract class UserRepositoryRemoteServices {
  factory UserRepositoryRemoteServices(Dio dio, {String baseUrl}) =
  _UserRepositoryRemoteServices;

  @GET('/users/{id}')
  Future<UserDTO> getUser(@Path('id') dynamic id);

  @GET('/users')
  Future<List<UserDTO>> getUsers();

  @POST('/users')
  Future<UserDTO> createUser(@Body() UserDTO user);

  @PATCH('/users/{id}')
  Future<UserDTO> updateUser(@Path('id') dynamic id, @Body() UserDTO user);

  @DELETE('/users/{id}')
  Future<void> deleteUser(@Path('id') dynamic id);
}