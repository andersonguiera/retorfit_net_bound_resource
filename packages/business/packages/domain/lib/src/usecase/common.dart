import 'package:domain/domain.dart';

abstract class FindByNameUseCase<T> {
  Future<Paginated<T>> findByName(String name, {int page = 1});
}

abstract class FindByEmailUseCase<T> {
  Future<Paginated<T>> findByEmail(String email, {int page = 1});
}

abstract class GetAll<T> {
  Future<List<T>> getAll();
}

//Não apagar daqui para baixo
class UseCaseResponse<T> {
  UseCaseResponse(this.payload);

  final T payload;
}

class UseCaseRequest<T> {
  UseCaseRequest(this.param);

  final T param;
}

class PaginatedUseCaseRequest<T> extends UseCaseRequest<T> {
  final int page;

  PaginatedUseCaseRequest(this.page, T param) : super(param);
}

abstract class BaseUseCase<R, T> {
}


abstract class BaseUseCaseNoParam<T extends UseCaseResponse> implements BaseUseCase<void, T> {
  Future<T> perform();
}

abstract class BaseUseCaseAnyParam<R, T extends UseCaseResponse> implements BaseUseCase<R, T> {
  Future<T> perform(R request);
}

abstract class BaseUseCaseRequestParam<R extends UseCaseRequest, T extends UseCaseResponse> implements BaseUseCase<R, T> {
}

abstract class BaseUseCaseRequestResponseTyped<R, T> implements BaseUseCaseAnyParam<UseCaseRequest<R>, UseCaseResponse<T>> {

}

abstract class FindByName2<R, T>
    implements BaseUseCaseRequestResponseTyped<R,T> {}

abstract class FindByNameString2<T>
    implements BaseUseCaseAnyParam<String, UseCaseResponse<T>> {}

abstract class FindByEmail2<R, T>
    implements BaseUseCaseRequestResponseTyped<R, T> {}

abstract class FindByEmailString2<T>
    implements BaseUseCaseAnyParam<String, UseCaseResponse<T>> {}

abstract class FindById2<T>
    implements BaseUseCaseAnyParam<dynamic, UseCaseResponse<T>> {}
