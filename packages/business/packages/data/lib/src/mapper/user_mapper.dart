import 'package:data/src/datasource/remote/dto/user_dto.dart';
import 'package:domain/domain.dart';


extension UserMapper on User {
  UserDTO toDTO() => UserDTO(
      id,
      name,
      email,
      gender,
      status,
  );
}

extension UserDTOMapper on UserDTO {
  User toModel() => User(id, name, email, gender, status);
}
