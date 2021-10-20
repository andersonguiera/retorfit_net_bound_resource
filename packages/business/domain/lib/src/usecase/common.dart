import 'package:domain/domain.dart';

abstract class FindByNameUseCase<T>{
  Future<Paginated<T>> findByName(String name, {int page = 1});
}

abstract class FindByEmailUseCase<T>{
  Future<Paginated<T>> findByEmail(String email, {int page = 1});
}
