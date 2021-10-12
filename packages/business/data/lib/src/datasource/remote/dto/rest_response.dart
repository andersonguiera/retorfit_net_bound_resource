import 'package:data/remote.dart';
import 'package:json_annotation/json_annotation.dart';

part 'rest_response.g.dart';

@JsonSerializable()
class Links {

  const Links(this.current, {this.previous, this.next});

  final String? previous;
  final String current;
  final String? next;

  factory Links.fromJson(Map<String, dynamic> json) =>
      _$LinksFromJson(json);

  Map<String, dynamic> toJson() => _$LinksToJson(this);
}

@JsonSerializable()
class Pagination {

  const Pagination(this.total, this.pages, this.page, this.limit, this.links);

  final int total;
  final int pages;
  final int page;
  final int limit;
  final Links links;

  factory Pagination.fromJson(Map<String, dynamic> json) =>
      _$PaginationFromJson(json);

  Map<String, dynamic> toJson() => _$PaginationToJson(this);
}

@JsonSerializable()
class MetaData {

  const MetaData(this.pagination);

  final Pagination pagination;

  factory MetaData.fromJson(Map<String, dynamic> json) =>
      _$MetaDataFromJson(json);

  Map<String, dynamic> toJson() => _$MetaDataToJson(this);
}

@JsonSerializable()
class RestResponse<T> {
  const RestResponse(this.meta, this.data);

  final MetaData? meta;
  @_Converter()
  final T data;

  factory RestResponse.fromJson(Map<String, dynamic> json) =>
      _$RestResponseFromJson<T>(json);

  Map<String, dynamic> toJson() => _$RestResponseToJson(this);
}

class _Converter<T> implements JsonConverter<T, Object?> {
  const _Converter();

  @override
  T fromJson(Object? json) {
    if(json is Map<String, dynamic> && json.containsKey('name') && json.containsKey('gender') ) {
      return UserDTO.fromJson(json) as T;
    } else {
      return (json as Iterable).map((e) => UserDTO.fromJson(e)).toList() as T;
    }
  }

  @override
  Object? toJson(T object) => object;
}