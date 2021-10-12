import 'package:data/src/datasource/remote/api_config.dart';
import 'package:data/src/datasource/remote/dto/rest_response.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart' hide Headers;
import 'dto/user_dto.dart';
part 'user_repository_remote_service.g.dart';

@RestApi(baseUrl: 'https://gorest.co.in/public/v1')
abstract class UserRepositoryRemoteServices {
  factory UserRepositoryRemoteServices(Dio dio, {String baseUrl}) =
  _UserRepositoryRemoteServices;

  @GET('/users/{id}')
  Future<RestResponse<UserDTO>> getUser(@Path('id') dynamic id);

  @GET('/users?page={page}')
  Future<RestResponse<List<UserDTO>>> getUsers(@Path('page') int page);

  @POST('/users')
  @Headers(<String,dynamic>{
    'Content-Type':'application/json',
    'Authorization': ApiConfig.authorization
  })
  Future<RestResponse<UserDTO>> createUser(@Body() UserDTO user);

  @PATCH('/users/{id}')
  @Headers(<String,dynamic>{
    'Content-Type':'application/json',
    'Authorization':ApiConfig.authorization
  })
  Future<RestResponse<UserDTO>> updateUser(@Path('id') dynamic id, @Body() UserDTO user);

  @DELETE('/users/{id}')
  @Headers(<String,dynamic>{
    'Content-Type':'application/json',
    'Authorization':ApiConfig.authorization
  })
  Future<void> deleteUser(@Path('id') dynamic id);
}