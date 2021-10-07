// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'address_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GeoDTO _$GeoDTOFromJson(Map<String, dynamic> json) => GeoDTO(
      json['lat'] as String,
      json['lng'] as String,
    );

Map<String, dynamic> _$GeoDTOToJson(GeoDTO instance) => <String, dynamic>{
      'lat': instance.lat,
      'lng': instance.lng,
    };

AddressDTO _$AddressDTOFromJson(Map<String, dynamic> json) => AddressDTO(
      json['street'] as String,
      json['suite'] as String,
      json['city'] as String,
      json['zipcode'] as String,
      GeoDTO.fromJson(json['geo'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$AddressDTOToJson(AddressDTO instance) =>
    <String, dynamic>{
      'street': instance.street,
      'suite': instance.suite,
      'city': instance.city,
      'zipcode': instance.zipCode,
      'geo': instance.geo,
    };
