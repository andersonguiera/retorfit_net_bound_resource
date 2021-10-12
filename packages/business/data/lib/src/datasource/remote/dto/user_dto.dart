import 'package:json_annotation/json_annotation.dart';

part 'user_dto.g.dart';

@JsonSerializable()
class UserDTO {
  const UserDTO(this.id, this.name, this.email, this.gender,this.status,);

  final dynamic id;
  final String name;
  final String email;
  final String gender;
  final String status;

  factory UserDTO.fromJson(Map<String, dynamic> json) =>
      _$UserDTOFromJson(json);

  Map<String, dynamic> toJson() => _$UserDTOToJson(this);
}