
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

abstract class FindByName<R, T>
    implements BaseUseCaseRequestResponseTyped<R,T> {}

abstract class FindByNameString<T>
    implements BaseUseCaseAnyParam<String, UseCaseResponse<T>> {}

abstract class FindByEmail<R, T>
    implements BaseUseCaseRequestResponseTyped<R, T> {}

abstract class FindByEmailString<T>
    implements BaseUseCaseAnyParam<String, UseCaseResponse<T>> {}

abstract class GetById<T>
    implements BaseUseCaseAnyParam<dynamic, UseCaseResponse<T>> {}
