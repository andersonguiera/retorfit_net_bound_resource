import 'package:domain/domain.dart';
import 'names.dart';

class MockUserRepository implements UserRepository {
  MockUserRepository._(this.elements) {}

  factory MockUserRepository.fromUsersList(int length) {
    final names = MockNames.names.sublist(0, length - 4);
    var elements = <User>[];
    var id = 5;

    elements.addAll([
      const User(1, 'Maxim Gorky', 'gorky@xpto.com.br', 'male', 'active'),
      const User(2, 'Lev Tolstoi', 'tolstoi@xpto.com.br', 'male', 'active'),
      const User(
          3, 'Mikhail Lermontov', 'piechorin@xpto.com.br', 'male', 'inactive'),
      const User(
          4, 'Ilia Tolstoi', 'ilia_the_son@xpto.com.br', 'male', 'active')
    ]);

    for (var name in names) {
      elements.add(User(id++, name, MockNames.getEmail(name),
          MockNames.getRandomGender(), MockNames.getRandomStatus()));
    }

    return MockUserRepository._(elements);
  }

  final List<User> elements;

  @override
  Future<void> deleteUser(id) {
    // TODO: implement deleteUser
    throw UnimplementedError();
  }

  @override
  Future<User> getUser(id) async {
    return elements.firstWhere((element) => element.id == id,
        orElse: () => User.empty);
  }

  @override
  Future<Paginated<User>> getUsers({int? page}) async {
    return _getPaginatedElements(page, elements);
  }

  @override
  Future<User> saveUser(User user) {
    // TODO: implement saveUser
    throw UnimplementedError();
  }

  @override
  Future<Paginated<User>> findByName(String name, {int page = 1}) async {
    final found =
        elements.where((element) => element.name.contains(name)).toList();
    return _getPaginatedElements(page, found);
  }

  @override
  Future<Paginated<User>> findByEmail(String email, {int page = 1}) async {
    final found =
        elements.where((element) => element.email.contains(email)).toList();

    return _getPaginatedElements(page, found);
  }

  Paginated<User> _getPaginatedElements(int? page, List<User> elements) {
    var threshold = 20;
    var total = elements.length;
    var offset = total < threshold ? total : threshold;
    var pages =
        total == 0 ? 1 : total ~/ threshold + (total % threshold > 0 ? 1 : 0);
    var start = ((page ?? 1) - 1) * offset;
    var end = start + offset <= total ? start + offset : total;
    var size = end - start;
    return Paginated(
        total: total,
        size: size,
        pages: pages,
        page: page ?? 1,
        elements: elements.sublist(start, end));
  }
}
