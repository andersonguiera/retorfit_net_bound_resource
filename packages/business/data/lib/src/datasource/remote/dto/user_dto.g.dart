// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserDTO _$UserDTOFromJson(Map<String, dynamic> json) => UserDTO(
      json['id'],
      json['name'] as String,
      json['username'] as String,
      json['email'] as String,
      json['phone'] as String,
      json['website'] as String,
      json['address'] == null
          ? null
          : AddressDTO.fromJson(json['address'] as Map<String, dynamic>),
      json['company'] == null
          ? null
          : CompanyDTO.fromJson(json['company'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$UserDTOToJson(UserDTO instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'username': instance.userName,
      'email': instance.email,
      'phone': instance.phone,
      'website': instance.website,
      'address': instance.address,
      'company': instance.company,
    };
