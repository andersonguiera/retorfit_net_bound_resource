import 'package:data/src/datasource/remote/dto/company_dto.dart';
import 'package:domain/domain.dart';

extension CompanyMapper on Company {
  CompanyDTO toDTO() => CompanyDTO(name, catchPhrase, bs);
}

extension CompanyDTOMapper on CompanyDTO {
  Company toModel() => Company(name, catchPhrase, bs);
}