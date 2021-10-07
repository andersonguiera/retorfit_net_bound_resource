import 'package:domain/domain.dart';
import 'package:test/test.dart';
import 'package:data/data.dart';
import 'package:dio/dio.dart';
import 'package:data/src/mapper/user_mapper.dart';
import 'package:data/remote.dart';

void main() {
  test('Test a list of User', () async {
    final UserRepository repository =
        UserRepositoryRemoteImpl(UserRepositoryRemoteServices(Dio()));
    final users = await repository.getUsers();

    expect(users.length, 10);
  });

  test('Test one User', () async {
    final UserRepository repository =
        UserRepositoryRemoteImpl(UserRepositoryRemoteServices(Dio()));
    final users = await repository.getUser(1);

    expect(users.name, 'Leanne Graham');
    expect(users.userName, 'Bret');
    expect(users.email, 'Sincere@april.biz');
    expect(users.phone, '1-770-736-8031 x56442');
    expect(users.website, 'hildegard.org');

    expect(users.address!.street, 'Kulas Light');
    expect(users.address!.suite, 'Apt. 556');
    expect(users.address!.city, 'Gwenborough');
    expect(users.address!.zipCode, '92998-3874');
    expect(users.address!.geo.lat, '-37.3159');
    expect(users.address!.geo.lng, '81.1496');

    expect(users.company!.name, 'Romaguera-Crona');
    expect(
        users.company!.catchPhrase, 'Multi-layered client-server neural-net');
    expect(users.company!.bs, 'harness real-time e-markets');
  });

  test('Test one User to DTO', () async {
    const user = User(
        1,
        'Leanne Graham',
        'Bret',
        'Sincere@april.biz',
        '1-770-736-8031 x56442',
        'hildegard.org',
        Address('Kulas Light', 'Apt. 556', 'Gwenborough', '92998-3874',
            Geo('-37.3159', '81.1496')),
        Company('Romaguera-Crona', 'Multi-layered client-server neural-net',
            'harness real-time e-markets'));
    final userDTO = user.toDTO();

    expect(user.name, userDTO.name);
    expect(user.userName, userDTO.userName);
    expect(user.email, userDTO.email);
    expect(user.phone, userDTO.phone);
    expect(user.website, userDTO.website);

    expect(user.address!.street, userDTO.address!.street);
    expect(user.address!.suite, userDTO.address!.suite);
    expect(user.address!.city, userDTO.address!.city);
    expect(user.address!.zipCode, userDTO.address!.zipCode);
    expect(user.address!.geo.lat, userDTO.address!.geo.lat);
    expect(user.address!.geo.lng, userDTO.address!.geo.lng);

    expect(user.company!.name, 'Romaguera-Crona');
    expect(user.company!.catchPhrase, 'Multi-layered client-server neural-net');
    expect(user.company!.bs, 'harness real-time e-markets');
  });

  test('Test one DTO to User', () async {
    const userDTO = UserDTO(
        1,
        'Leanne Graham',
        'Bret',
        'Sincere@april.biz',
        '1-770-736-8031 x56442',
        'hildegard.org',
        AddressDTO('Kulas Light', 'Apt. 556', 'Gwenborough', '92998-3874',
            GeoDTO('-37.3159', '81.1496')),
        CompanyDTO('Romaguera-Crona', 'Multi-layered client-server neural-net',
            'harness real-time e-markets'));
    final user = userDTO.toModel();

    expect(user.name, userDTO.name);
    expect(user.userName, userDTO.userName);
    expect(user.email, userDTO.email);
    expect(user.phone, userDTO.phone);
    expect(user.website, userDTO.website);

    expect(user.address!.street, userDTO.address!.street);
    expect(user.address!.suite, userDTO.address!.suite);
    expect(user.address!.city, userDTO.address!.city);
    expect(user.address!.zipCode, userDTO.address!.zipCode);
    expect(user.address!.geo.lat, userDTO.address!.geo.lat);
    expect(user.address!.geo.lng, userDTO.address!.geo.lng);

    expect(user.company!.name, 'Romaguera-Crona');
    expect(user.company!.catchPhrase, 'Multi-layered client-server neural-net');
    expect(user.company!.bs, 'harness real-time e-markets');
  });

  test('Test post an User', () async {
    final UserRepository repository =
    UserRepositoryRemoteImpl(UserRepositoryRemoteServices(Dio()));

    const user = User(
        null,
        'Aleksei Maksimovich Peshkov',
        'Gorki',
        'gorki@yandex.ru',
        '+7 495 690-05-35',
        'www.gorki-pisat.ru',
        Address('Malaya Nikitskaya Ulitsa', '6/2', 'Moscow', '121069',
            Geo('55.75807', '37.59633')),
        Company('Russian Writers', 'We do it best', 'What?'));

    var newUser = await repository.saveUser(user);

    expect(user.name, newUser.name);
    expect(user.userName, newUser.userName);
    expect(user.email, newUser.email);
    expect(user.phone, newUser.phone);
    expect(user.website, newUser.website);

    expect(user.address!.street, newUser.address!.street);
    expect(user.address!.suite, newUser.address!.suite);
    expect(user.address!.city, newUser.address!.city);
    expect(user.address!.zipCode, newUser.address!.zipCode);
    expect(user.address!.geo.lat, newUser.address!.geo.lat);
    expect(user.address!.geo.lng, newUser.address!.geo.lng);

    expect(user.company!.name, newUser.company!.name);
    expect(user.company!.catchPhrase, newUser.company!.catchPhrase);
    expect(user.company!.bs, newUser.company!.bs);
  });

  test('Test post an User without Address and Company', () async {
    final UserRepository repository =
    UserRepositoryRemoteImpl(UserRepositoryRemoteServices(Dio()));

    const user = User(
        null,
        'Aleksei Maksimovich Peshkov',
        'Gorki',
        'gorki@yandex.ru',
        '+7 495 690-05-35',
        'www.gorki-pisat.ru',
        null,
        null);

    var newUser = await repository.saveUser(user);

    expect(user.name, newUser.name);
    expect(user.userName, newUser.userName);
    expect(user.email, newUser.email);
    expect(user.phone, newUser.phone);
    expect(user.website, newUser.website);

    expect(user.address, null);

    expect(user.company, null);
  });

  test('Update one User', () async {
    final UserRepository repository =
    UserRepositoryRemoteImpl(UserRepositoryRemoteServices(Dio()));
    final users = await repository.getUser(1);

    var updatedTransientUser = users.copyWith(name: 'Alan Touring');
    var updatedUser = await repository.saveUser(updatedTransientUser);

    expect(updatedUser.name, 'Alan Touring');
    expect(users.id, updatedUser.id);
    expect(users.userName, updatedUser.userName);
    expect(users.email, updatedUser.email);
    expect(users.phone, updatedUser.phone);
    expect(users.website, updatedUser.website);

    expect(users.address!.street, updatedUser.address!.street);
    expect(users.address!.suite, updatedUser.address!.suite);
    expect(users.address!.city, updatedUser.address!.city);
    expect(users.address!.zipCode, updatedUser.address!.zipCode);
    expect(users.address!.geo.lat, updatedUser.address!.geo.lat);
    expect(users.address!.geo.lng, updatedUser.address!.geo.lng);

    expect(users.company!.name, updatedUser.company!.name);
    expect(
        users.company!.catchPhrase, updatedUser.company!.catchPhrase);
    expect(users.company!.bs, updatedUser.company!.bs);
  });

  test('Delete one User', () async {
    final UserRepository repository =
    UserRepositoryRemoteImpl(UserRepositoryRemoteServices(Dio()));
    final user = await repository.getUser(1);
    expect(() async => await repository.deleteUser(1), returnsNormally);
  });
}
