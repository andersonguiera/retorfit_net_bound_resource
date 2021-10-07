import 'package:domain/domain.dart';
import 'package:retrofit/retrofit.dart';
import 'package:data/src/mapper/user_mapper.dart';
import 'package:data/src/datasource/remote/user_repository_remote_service.dart';

class UserRepositoryRemoteImpl implements UserRepository {
  UserRepositoryRemoteImpl(this._service);

  final UserRepositoryRemoteServices _service;

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

  @override
  Future<User> saveUser(User user) async {
    if(user.id == null) { // criar um novo user
      var userDTO = await _service.createUser(user.toDTO());
      return userDTO.toModel();
    } else { // atualiza um user existente
      var userDTO = await _service.updateUser(user.id, user.toDTO());
      return userDTO.toModel();
    }
  }

  @override
  Future<void> deleteUser(dynamic id) async {
    await _service.deleteUser(id);
  }
}

