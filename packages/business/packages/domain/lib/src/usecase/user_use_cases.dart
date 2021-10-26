import 'package:domain/domain.dart';
import 'common.dart';

abstract class GetUserByIdUseCase {
  Future<User> getUser(dynamic id);
}

abstract class GetUsersByPageUseCase {
  Future<Paginated<User>> getUsers({int? page});
}

abstract class FindUsersUseCase
    implements FindByNameUseCase<User>, FindByEmailUseCase<User> {}

abstract class GetAllUsers implements GetAll<User> {}

abstract class CreateUserUseCase {
  Future<User> create(User user);
}

//Não apagar daqui para baixo
abstract class FindUserById2 implements FindById2<User> { }

abstract class FindUserByNameUserParam2
    implements
        FindByName2<User, Paginated<User>> {
}

abstract class FindUserByNameStringParam2 implements
    FindByNameString2<Paginated<User>> {
}

abstract class FindUserByNamePageRequestParam2 implements
    BaseUseCaseAnyParam<PaginatedUseCaseRequest<String>,UseCaseResponse<Paginated<User>>> {
}

abstract class FindUserByEmailUserParam2 implements
    FindByEmail2<User,Paginated<User>> {
}

abstract class FindUserByEmailStringParam2 implements
    FindByEmailString2<Paginated<User>> {
}

abstract class FindUserByEmailPageRequestParam2 implements
    BaseUseCaseAnyParam<PaginatedUseCaseRequest<String>,UseCaseResponse<Paginated<User>>> {
}

abstract class CreateUserUseCase2 implements
    BaseUseCaseAnyParam<User, UseCaseResponse<User>> {}

abstract class GetAllUsers2 implements BaseUseCaseNoParam<UseCaseResponse<List<User>>>{}

//It doesn't make sense anymore

// abstract class FindUsersUseCase2
//     extends BaseUseCase<UseCaseRequest<User>, UseCaseResponse<User>> {
//   final FindUserByNameStringParam2 findByName;
//   final FindByEmail2<UseCaseRequest<User>, UseCaseResponse<User>> findByEmail;
//
//   FindUsersUseCase2(this.findByName, this.findByEmail);
// }
