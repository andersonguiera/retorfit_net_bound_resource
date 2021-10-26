import 'package:domain/domain.dart';
import 'common.dart';

abstract class GetUserById implements GetById<User> {}

abstract class GetUsersByPage
    implements
        BaseUseCaseAnyParam<int,
            UseCaseResponse<Paginated<User>>> {}

abstract class FindUserByNameUserParam
    implements FindByName<User, Paginated<User>> {}

abstract class FindUserByNameStringParam
    implements FindByNameString<Paginated<User>> {}

abstract class FindUserByNamePageRequestParam
    implements
        BaseUseCaseAnyParam<PaginatedUseCaseRequest<String>,
            UseCaseResponse<Paginated<User>>> {}

abstract class FindUserByEmailUserParam
    implements FindByEmail<User, Paginated<User>> {}

abstract class FindUserByEmailStringParam
    implements FindByEmailString<Paginated<User>> {}

abstract class FindUserByEmailPageRequestParam
    implements
        BaseUseCaseAnyParam<PaginatedUseCaseRequest<String>,
            UseCaseResponse<Paginated<User>>> {}

abstract class CreateUserUseCase
    implements BaseUseCaseAnyParam<User, UseCaseResponse<User>> {}

abstract class GetAllUsers
    implements BaseUseCaseNoParam<UseCaseResponse<List<User>>> {}
