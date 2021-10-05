import 'address.dart';
import 'company.dart';

class User {
  const User(this.id, this.name, this.userName, this.email, this.phone,
      this.website, this.address, this.company);

  final dynamic id;
  final String name;
  final String userName;
  final String email;
  final String phone;
  final String website;
  final Address? address;
  final Company? company;
}
