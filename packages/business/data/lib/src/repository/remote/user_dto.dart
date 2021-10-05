import 'package:json_annotation/json_annotation.dart';
import 'package:domain/domain.dart';

part 'user_dto.g.dart';

@JsonSerializable()
class UserDTO {
  const UserDTO(this.id, this.name, this.userName, this.email, this.phone,
      this.website);

  final dynamic id;
  final String name;
  @JsonKey(name: 'username')
  final String userName;
  final String email;
  final String phone;
  final String website;

  factory UserDTO.fromJson(Map<String, dynamic> json) =>
      _$UserDTOFromJson(json);

  Map<String, dynamic> toJson() => _$UserDTOToJson(this);

  User toModel() =>
      User(
          id,
          name,
          userName,
          email,
          phone,
          website,
          null,
          null);
}