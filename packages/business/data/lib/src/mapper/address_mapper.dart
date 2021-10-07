import 'package:data/src/datasource/remote/dto/address_dto.dart';
import 'package:domain/domain.dart';

extension GeoMapper on Geo {
  GeoDTO toDTO() => GeoDTO(lat, lng);
}

extension GeoDTOMapper on GeoDTO {
  Geo toModel() => Geo(lat, lng);
}

extension AddressMapper on Address {
  AddressDTO toDTO() => AddressDTO(street, suite, city, zipCode, geo.toDTO());
}

extension AddressDTOMapper on AddressDTO {
  Address toModel() => Address(street, suite, city, zipCode, geo.toModel());
}
