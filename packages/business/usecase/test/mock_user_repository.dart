import 'package:domain/domain.dart';

class MockUserRepository implements UserRepository {
  final elements = [
    const User(1, 'Maxim Gorky', 'gorky@yandex.ru', 'male', 'active'),
    const User(2, 'Lev Tolstoi', 'tolstoi@yandex.ru', 'male', 'active'),
    const User(
        3, 'Mikhail Lermontov', 'piechorin@yandex.ru', 'male', 'inactive'),
    const User(4, 'Ilia Tolstoi', 'ilia_the_son@yandex.ru', 'male', 'active'),
  ];

  @override
  Future<void> deleteUser(id) {
    // TODO: implement deleteUser
    throw UnimplementedError();
  }

  @override
  Future<User> getUser(id) async {
    return elements.firstWhere((element) => element.id == id,
        orElse: () => const User('', '', '', '', ''));
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

  @override
  Future<Paginated<User>> findByName(String name, {int page = 1}) async {
    final finded =
        elements.where((element) => element.name.contains(name)).toList();
    int total = finded.length;
    int max = 20;
    int size = total > max ? max : total;
    int end = page * max;
    int begin = end - max;
    end = end > total ? total : end;
    return Paginated(
        total: total,
        size: size,
        pages: total ~/ size,
        page: page,
        elements: finded.sublist(begin, end));
  }

  @override
  Future<Paginated<User>> findByEmail(String email, {int page = 1}) async {
    final finded =
    elements.where((element) => element.email.contains(email)).toList();
    int total = finded.length;
    int max = 20;
    int size = total > max ? max : total;
    int end = page * max;
    int begin = end - max;
    end = end > total ? total : end;
    return Paginated(
        total: total,
        size: size,
        pages: total ~/ size,
        page: page,
        elements: finded.sublist(begin, end));
  }

}
