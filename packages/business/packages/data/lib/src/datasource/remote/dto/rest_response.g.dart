// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rest_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Links _$LinksFromJson(Map<String, dynamic> json) => Links(
      json['current'] as String?,
      previous: json['previous'] as String?,
      next: json['next'] as String?,
    );

Map<String, dynamic> _$LinksToJson(Links instance) => <String, dynamic>{
      'previous': instance.previous,
      'current': instance.current,
      'next': instance.next,
    };

Pagination _$PaginationFromJson(Map<String, dynamic> json) => Pagination(
      json['total'] as int,
      json['pages'] as int,
      json['page'] as int,
      json['limit'] as int,
      Links.fromJson(json['links'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PaginationToJson(Pagination instance) =>
    <String, dynamic>{
      'total': instance.total,
      'pages': instance.pages,
      'page': instance.page,
      'limit': instance.size,
      'links': instance.links,
    };

MetaData _$MetaDataFromJson(Map<String, dynamic> json) => MetaData(
      Pagination.fromJson(json['pagination'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$MetaDataToJson(MetaData instance) => <String, dynamic>{
      'pagination': instance.pagination,
    };

RestResponse<T> _$RestResponseFromJson<T>(Map<String, dynamic> json) =>
    RestResponse<T>(
      json['meta'] == null
          ? null
          : MetaData.fromJson(json['meta'] as Map<String, dynamic>),
      _Converter<T>().fromJson(json['data']),
    );

Map<String, dynamic> _$RestResponseToJson<T>(RestResponse<T> instance) =>
    <String, dynamic>{
      'meta': instance.meta,
      'data': _Converter<T>().toJson(instance.data),
    };
