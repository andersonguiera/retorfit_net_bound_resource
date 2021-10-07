import 'package:data/src/datasource/remote/dto/address_dto.dart';
import 'package:data/src/datasource/remote/dto/company_dto.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_dto.g.dart';

@JsonSerializable()
class UserDTO {
  const UserDTO(this.id, this.name, this.userName, this.email, this.phone,
      this.website, this.address, this.company);

  final dynamic id;
  final String name;
  @JsonKey(name: 'username')
  final String userName;
  final String email;
  final String phone;
  final String website;
  final AddressDTO? address;
  final CompanyDTO? company;

  factory UserDTO.fromJson(Map<String, dynamic> json) =>
      _$UserDTOFromJson(json);

  Map<String, dynamic> toJson() => _$UserDTOToJson(this);
}