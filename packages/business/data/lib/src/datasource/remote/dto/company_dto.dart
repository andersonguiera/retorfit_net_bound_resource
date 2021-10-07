import 'package:json_annotation/json_annotation.dart';

part 'company_dto.g.dart';

@JsonSerializable()
class CompanyDTO {
  const CompanyDTO(this.name, this.catchPhrase, this.bs);

  final String name;
  final String catchPhrase;
  final String bs;

  factory CompanyDTO.fromJson(Map<String, dynamic> json) =>
      _$CompanyDTOFromJson(json);

  Map<String, dynamic> toJson() => _$CompanyDTOToJson(this);
}