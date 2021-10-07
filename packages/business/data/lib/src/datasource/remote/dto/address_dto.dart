import 'package:json_annotation/json_annotation.dart';

part 'address_dto.g.dart';

@JsonSerializable()
class GeoDTO {

  const GeoDTO(this.lat, this.lng);

  final String lat;
  final String lng;

  factory GeoDTO.fromJson(Map<String,dynamic> json) => _$GeoDTOFromJson(json);

  Map<String, dynamic> toJson()=> _$GeoDTOToJson(this);
}

@JsonSerializable()
class AddressDTO {
  const AddressDTO(this.street, this.suite, this.city, this.zipCode, this.geo);

  final String street;
  final String suite;
  final String city;
  @JsonKey(name: 'zipcode')
  final String zipCode;
  final GeoDTO geo;

  factory AddressDTO.fromJson(Map<String, dynamic> json) =>
      _$AddressDTOFromJson(json);

  Map<String, dynamic> toJson() => _$AddressDTOToJson(this);

}
