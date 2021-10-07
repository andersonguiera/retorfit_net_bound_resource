import 'package:data/src/datasource/remote/dto/address_dto.dart';
import 'package:data/src/datasource/remote/dto/company_dto.dart';
import 'package:data/src/datasource/remote/dto/user_dto.dart';
import 'package:domain/domain.dart';
import 'address_mapper.dart';
import 'company_mapper.dart';

extension UserMapper on User {
  UserDTO toDTO() => UserDTO(
      id,
      name,
      userName,
      email,
      phone,
      website,
      address == null
          ? null
          : AddressDTO(address!.street, address!.suite, address!.city,
              address!.zipCode, GeoDTO(address!.geo.lat, address!.geo.lng)),
      company == null
          ? null
          : CompanyDTO(company!.name, company!.catchPhrase, company!.bs));
}

extension UserDTOMapper on UserDTO {
  User toModel() => User(id, name, userName, email, phone, website,
      address?.toModel(), company?.toModel());
}
