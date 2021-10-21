import 'package:domain/domain.dart';
import 'package:domain/usecase.dart';

import 'package:injectable/injectable.dart';

@Injectable(as: GetUserByIdUseCase)
class GetUserByIdUseCaseImpl implements GetUserByIdUseCase {
  GetUserByIdUseCaseImpl(this._repository);

  final UserRepository _repository;

  @override
  Future<User> getUser(dynamic id) async {
    return _repository.getUser(id);
  }
}

@Injectable(as: GetUsersByPageUseCase)
class GetUsersByPageUseCaseImpl implements GetUsersByPageUseCase {
  GetUsersByPageUseCaseImpl(this._repository);

  final UserRepository _repository;

  @override
  Future<Paginated<User>> getUsers({int? page}) async {
    return await _repository.getUsers(page: page);
  }
}

@Injectable(as: FindUsersUseCase)
class FindUsersUseCaseImpl implements FindUsersUseCase {
  FindUsersUseCaseImpl(this._repository);

  final UserRepository _repository;

  @override
  Future<Paginated<User>> findByName(String name, {int page = 1}) async {
    return await _repository.findByName(name, page: page);
  }

  @override
  Future<Paginated<User>> findByEmail(String email, {int page = 1}) async {
    return await _repository.findByEmail(email, page: page);
  }
}

@Injectable(as: GetAllUsers)
class GetAllUsersImp implements GetAllUsers {
  GetAllUsersImp(this._repository);

  final UserRepository _repository;

  @override
  Future<List<User>> getAll() async {
    Set users = <User>{};

    final firstPage = await _repository.getUsers();

    users.addAll(firstPage.elements);

    final callsForPackage = 10;
    int totalPackages = (firstPage.pages -1) ~/ callsForPackage;
    //int totalPagesMock = 12;
    //int totalPackages = (totalPagesMock - 1) ~/ callsForPackage;

    List<PackageOfCalls> packages = [];

    var last = 0;
    for (int i = 0; i < totalPackages; i++) {
      var first = i * callsForPackage + 2;
      last = first + callsForPackage - 1;
      packages.add(PackageOfCalls<Paginated<User>>(
          first, last, (page) async => await _repository.getUsers(page: page)));
      //print(package.range);
    }
    if (last < firstPage.pages) {
      //last == 0, less then 'callsForPackage' pages
      var first = last == 0 ? last + 2 : last + 1;
      last = firstPage.pages;
      packages.add(PackageOfCalls<Paginated<User>>(
          first, last, (page) async => await _repository.getUsers(page: page)));
      //print(package.range);
    }

    for(var package in packages) {
      var resultCalls = await package.call();

      for(var page in resultCalls) {
        users.addAll((page as Paginated<User>).elements);
      }
    }

    return users.toList().cast();
  }
}

class PackageOfCalls<T> {
  final int first;
  final int last;
  late final List<int> range;
  final Future<T> Function(int order) future;
  late final List<Future<T>> calls;

  PackageOfCalls(this.first, this.last, this.future) {
    var length = last - first + 1;
    range = List.generate(length, (index) => index + first);
    calls = List.generate(length, (index) => future(range[index]));
  }

  Future<List<T>> call() async {
    return Future.wait(calls);
  }
}
