import 'package:domain/domain.dart';

class MockUserRepository implements UserRepository {
  final elements = [
    const User(1, 'Maxim Gorky', 'gorky@yandex.ru', 'male', 'active'),
    const User(2, 'Lev Tolstoy', 'tolstoi@yandex.ru', 'male', 'active'),
    const User(
        3, 'Mikhail Lermontov', 'piechorin@yandex.ru', 'male', 'inactive'),
  ];

  @override
  Future<void> deleteUser(id) {
    // TODO: implement deleteUser
    throw UnimplementedError();
  }

  @override
  Future<User> getUser(id) async {
    return elements.firstWhere((element) => element.id == id, orElse: ()=> const User('','', '', '', ''));
  }

  @override
  Future<Paginated<User>> getUsers({int? page}) async {
    int total = 1085;
    int size = elements.length;
    return Paginated(
        total: total,
        size: size,
        pages: total ~/ size,
        page: page ?? 1,
        elements: elements);
  }

  @override
  Future<User> saveUser(User user) {
    // TODO: implement saveUser
    throw UnimplementedError();
  }
}
